//! Upgrade the types of scalars observed to be accessed as atomics to [`Atomic`] types.
//!
//! In SPIR-V, atomic operations can be applied to any scalar value, but in Naga
//! IR atomic operations can only be applied to values of type [`Atomic`]. Naga
//! IR's restriction matches Metal Shading Language and WGSL, so we don't want
//! to relax that. Instead, when the SPIR-V front end observes a value being
//! accessed using atomic instructions, it promotes the value's type from
//! [`Scalar`] to [`Atomic`]. This module implements `Module::upgrade_atomics`,
//! the function that makes that change.
//!
//! Atomics can only appear in global variables in the [`Storage`] and
//! [`Workgroup`] address spaces. These variables can either have `Atomic` types
//! themselves, or be [`Array`]s of such, or be [`Struct`]s containing such.
//! So we only need to change the types of globals and struct fields.
//!
//! Naga IR [`Load`] expressions and [`Store`] statements can operate directly
//! on [`Atomic`] values, retrieving and depositing ordinary [`Scalar`] values,
//! so changing the types doesn't have much effect on the code that operates on
//! those values.
//!
//! Future work:
//!
//! - The GLSL front end could use this transformation as well.
//!
//! [`Atomic`]: TypeInner::Atomic
//! [`Scalar`]: TypeInner::Scalar
//! [`Storage`]: crate::AddressSpace::Storage
//! [`WorkGroup`]: crate::AddressSpace::WorkGroup
//! [`Array`]: TypeInner::Array
//! [`Struct`]: TypeInner::Struct
//! [`Load`]: crate::Expression::Load
//! [`Store`]: crate::Statement::Store

use alloc::{format, sync::Arc};
use core::sync::atomic::AtomicUsize;

use crate::{GlobalVariable, Handle, Module, Type, TypeInner};

#[cfg(feature = "cuda-in")]
mod storage;
#[cfg(feature = "cuda-in")]
pub(crate) use storage::StorageViews;

#[derive(Clone, Debug, thiserror::Error)]
pub enum Error {
    #[error("encountered an unsupported expression")]
    Unsupported,
    #[error("unexpected end of struct field access indices")]
    UnexpectedEndOfIndices,
    #[error("encountered unsupported global initializer in an atomic variable")]
    GlobalInitUnsupported,
    #[error("expected to find a global variable")]
    GlobalVariableMissing,
    #[error("atomic compare exchange requires a scalar base type")]
    CompareExchangeNonScalarBaseType,
    #[error("atomic storage view nesting limit exceeded")]
    StorageViewNestingLimit,
}

#[derive(Clone, Default)]
struct Padding(Arc<AtomicUsize>);

impl core::fmt::Display for Padding {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        for _ in 0..self.0.load(core::sync::atomic::Ordering::Relaxed) {
            f.write_str("  ")?;
        }
        Ok(())
    }
}

impl Drop for Padding {
    fn drop(&mut self) {
        let _ = self.0.fetch_sub(1, core::sync::atomic::Ordering::Relaxed);
    }
}

impl Padding {
    fn trace(&self, msg: impl core::fmt::Display, t: impl core::fmt::Debug) {
        format!("{msg} {t:#?}")
            .split('\n')
            .for_each(|ln| log::trace!("{self}{ln}"));
    }

    fn debug(&self, msg: impl core::fmt::Display, t: impl core::fmt::Debug) {
        format!("{msg} {t:#?}")
            .split('\n')
            .for_each(|ln| log::debug!("{self}{ln}"));
    }

    fn inc_padding(&self) -> Padding {
        let _ = self.0.fetch_add(1, core::sync::atomic::Ordering::Relaxed);
        self.clone()
    }
}

#[derive(Debug, Default)]
pub struct Upgrades {
    /// Global variables that we've accessed using atomic operations.
    ///
    /// This includes globals with composite types (arrays, structs) where we've
    /// only accessed some components (elements, fields) atomically.
    globals: crate::arena::HandleSet<GlobalVariable>,

    /// Struct fields that we've accessed using atomic operations.
    ///
    /// Each key refers to some [`Struct`] type, and each value is a set of
    /// the indices of the fields in that struct that have been accessed
    /// atomically.
    ///
    /// This includes fields with composite types (arrays, structs)
    /// of which we've only accessed some components (elements, fields)
    /// atomically.
    ///
    /// [`Struct`]: crate::TypeInner::Struct
    fields: crate::FastHashMap<Handle<Type>, bit_set::BitSet>,

    #[cfg(feature = "cuda-in")]
    vector_components: crate::FastHashMap<Handle<Type>, bit_set::BitSet>,
}

impl Upgrades {
    pub fn insert_global(&mut self, global: Handle<GlobalVariable>) {
        self.globals.insert(global);
    }

    pub fn insert_field(&mut self, struct_type: Handle<Type>, field: usize) {
        self.fields.entry(struct_type).or_default().insert(field);
    }

    #[cfg(feature = "cuda-in")]
    pub(crate) fn insert_vector_component(&mut self, vector_type: Handle<Type>, component: usize) {
        self.vector_components
            .entry(vector_type)
            .or_default()
            .insert(component);
    }

    pub fn is_empty(&self) -> bool {
        self.globals.is_empty()
    }
}

struct UpgradeState<'a> {
    padding: Padding,
    module: &'a mut Module,

    /// A map from old types to their upgraded versions.
    ///
    /// This ensures we never try to rebuild a type more than once.
    upgraded_types: crate::FastHashMap<Handle<Type>, Handle<Type>>,

    #[cfg(feature = "cuda-in")]
    storage_views: Option<StorageViews>,
}

impl UpgradeState<'_> {
    const fn has_storage_views(&self) -> bool {
        #[cfg(feature = "cuda-in")]
        {
            self.storage_views.is_some()
        }
        #[cfg(not(feature = "cuda-in"))]
        {
            false
        }
    }

    fn inc_padding(&self) -> Padding {
        self.padding.inc_padding()
    }

    /// Get a type equivalent to `ty`, but with [`Scalar`] leaves upgraded to [`Atomic`] scalars.
    ///
    /// If such a type already exists in `self.module.types`, return its handle.
    /// Otherwise, construct a new one and return that handle.
    ///
    /// If `ty` is a [`Pointer`], [`Array`], [`BindingArray`], recurse into the
    /// type and upgrade its leaf types.
    ///
    /// If `ty` is a [`Struct`], recurse into it and upgrade only those fields
    /// whose indices appear in `field_indices`.
    ///
    /// The existing type is not affected.
    ///
    /// [`Scalar`]: crate::TypeInner::Scalar
    /// [`Atomic`]: crate::TypeInner::Atomic
    /// [`Pointer`]: crate::TypeInner::Pointer
    /// [`Array`]: crate::TypeInner::Array
    /// [`Struct`]: crate::TypeInner::Struct
    /// [`BindingArray`]: crate::TypeInner::BindingArray
    fn upgrade_type(
        &mut self,
        ty: Handle<Type>,
        upgrades: &Upgrades,
        depth: u32,
    ) -> Result<Handle<Type>, Error> {
        if self.has_storage_views() && depth > 64 {
            return Err(Error::StorageViewNestingLimit);
        }
        #[cfg(feature = "cuda-in")]
        if self.has_storage_views() {
            self.module
                .types
                .check_contains_handle(ty)
                .map_err(|_| Error::Unsupported)?;
        }
        let padding = self.inc_padding();
        if !self.has_storage_views() {
            padding.trace("visiting type: ", ty);
        }

        // If we've already upgraded this type, return the handle we produced at
        // the time.
        if let Some(&new) = self.upgraded_types.get(&ty) {
            return Ok(new);
        }

        #[cfg(feature = "cuda-in")]
        let mut field_indices = None;
        let inner = match self.module.types[ty].inner {
            TypeInner::Scalar(scalar) => {
                #[cfg(feature = "cuda-in")]
                if self.has_storage_views()
                    && !matches!(scalar, crate::Scalar::I32 | crate::Scalar::U32)
                {
                    return Err(Error::Unsupported);
                }
                log::trace!("{padding}hit the scalar leaf, replacing with an atomic");
                TypeInner::Atomic(scalar)
            }
            TypeInner::Pointer { base, space } => TypeInner::Pointer {
                base: self.upgrade_type(base, upgrades, depth + 1)?,
                space,
            },
            TypeInner::Array { base, size, stride } => TypeInner::Array {
                base: self.upgrade_type(base, upgrades, depth + 1)?,
                size,
                stride,
            },
            TypeInner::Struct { ref members, span } => {
                // If no field or subfield of this struct was ever accessed
                // atomically, no change is needed. We should never have arrived here.
                let Some(fields) = upgrades.fields.get(&ty) else {
                    if self.has_storage_views() {
                        return Err(Error::Unsupported);
                    }
                    unreachable!("global or field incorrectly flagged as atomically accessed");
                };

                let mut new_members = members.clone();
                for field in fields {
                    if self.has_storage_views() && field >= new_members.len() {
                        return Err(Error::Unsupported);
                    }
                    new_members[field].ty =
                        self.upgrade_type(new_members[field].ty, upgrades, depth + 1)?;
                }

                #[cfg(feature = "cuda-in")]
                if self.has_storage_views() {
                    let type_span = self.module.types.get_span(ty);
                    let (members, indices) =
                        storage::padded_members(self.module, new_members, span, type_span)?;
                    new_members = members;
                    field_indices = Some(indices);
                }

                TypeInner::Struct {
                    members: new_members,
                    span,
                }
            }
            #[cfg(feature = "cuda-in")]
            TypeInner::Vector { size, scalar } if self.has_storage_views() => {
                if !matches!(size, crate::VectorSize::Bi | crate::VectorSize::Quad)
                    || !matches!(scalar, crate::Scalar::I32 | crate::Scalar::U32)
                {
                    return Err(Error::Unsupported);
                }
                let components = upgrades
                    .vector_components
                    .get(&ty)
                    .ok_or(Error::Unsupported)?;
                if components.is_empty() || components.iter().any(|index| index >= size as usize) {
                    return Err(Error::Unsupported);
                }
                let span = self.module.types.get_span(ty);
                let scalar_type = self.module.types.insert(
                    Type {
                        name: None,
                        inner: TypeInner::Scalar(scalar),
                    },
                    span,
                );
                let atomic_type = self.upgrade_type(scalar_type, upgrades, depth + 1)?;
                let (members, indices) =
                    storage::vector_members(size, scalar_type, atomic_type, components);
                field_indices = Some(indices);
                TypeInner::Struct {
                    members,
                    span: size as u32 * scalar.width as u32,
                }
            }
            TypeInner::BindingArray { base, size } => TypeInner::BindingArray {
                base: self.upgrade_type(base, upgrades, depth + 1)?,
                size,
            },
            _ => return Ok(ty),
        };

        // At this point, we have a `TypeInner` that is the upgraded version of
        // `ty`. Find a suitable `Type` for this, creating a new one if
        // necessary, and return its handle.
        let r#type = &self.module.types[ty];
        let span = self.module.types.get_span(ty);
        let new_type = Type {
            name: r#type.name.clone(),
            inner,
        };
        if !self.has_storage_views() {
            padding.debug("ty: ", ty);
            padding.debug("from: ", r#type);
            padding.debug("to:   ", &new_type);
        }
        let new_handle = self.module.types.insert(new_type, span);
        self.upgraded_types.insert(ty, new_handle);
        #[cfg(feature = "cuda-in")]
        if let Some(ref mut views) = self.storage_views {
            views.source_types.insert(new_handle, ty);
            if let Some(indices) = field_indices {
                views.field_indices.insert(new_handle, indices);
            }
        }
        Ok(new_handle)
    }

    fn upgrade_all(&mut self, upgrades: &Upgrades) -> Result<(), Error> {
        for handle in upgrades.globals.iter() {
            let padding = self.inc_padding();

            let global = if self.has_storage_views() {
                self.module
                    .global_variables
                    .try_get(handle)
                    .map_err(|_| Error::GlobalVariableMissing)?
            } else {
                &self.module.global_variables[handle]
            };
            if !self.has_storage_views() {
                padding.trace("visiting global variable: ", handle);
                padding.trace("var: ", global);
            }

            #[cfg(feature = "cuda-in")]
            if self.has_storage_views() {
                let supported = match global.space {
                    crate::AddressSpace::WorkGroup => true,
                    crate::AddressSpace::Storage { access } => {
                        access.contains(crate::StorageAccess::LOAD | crate::StorageAccess::STORE)
                    }
                    _ => false,
                };
                if !supported {
                    return Err(Error::Unsupported);
                }
            }

            if global.init.is_some() {
                return Err(Error::GlobalInitUnsupported);
            }

            let var_ty = global.ty;
            let new_ty = self.upgrade_type(var_ty, upgrades, 0)?;
            if new_ty != var_ty {
                if !self.has_storage_views() {
                    padding.debug("upgrading global variable: ", handle);
                    padding.debug("from ty: ", var_ty);
                    padding.debug("to ty:   ", new_ty);
                }
                self.module.global_variables[handle].ty = new_ty;
            }
        }

        Ok(())
    }
}

impl Module {
    /// Upgrade `global_var_handles` to have [`Atomic`] leaf types.
    ///
    /// [`Atomic`]: TypeInner::Atomic
    #[cfg(feature = "spv-in")]
    pub(crate) fn upgrade_atomics(&mut self, upgrades: &Upgrades) -> Result<(), Error> {
        let mut state = UpgradeState {
            padding: Default::default(),
            module: self,
            upgraded_types: crate::FastHashMap::with_capacity_and_hasher(
                upgrades.fields.len(),
                Default::default(),
            ),
            #[cfg(feature = "cuda-in")]
            storage_views: None,
        };

        state.upgrade_all(upgrades)?;

        Ok(())
    }

    #[cfg(feature = "cuda-in")]
    /// The caller accounts for reachable source types and the generated storage views.
    pub(crate) fn upgrade_atomics_with_storage_views(
        &mut self,
        upgrades: &Upgrades,
    ) -> Result<StorageViews, Error> {
        let mut state = UpgradeState {
            padding: Default::default(),
            module: self,
            upgraded_types: crate::FastHashMap::default(),
            storage_views: Some(StorageViews::default()),
        };
        state.upgrade_all(upgrades)?;
        Ok(state.storage_views.unwrap())
    }
}

#[cfg(all(test, feature = "cuda-in"))]
mod tests;
