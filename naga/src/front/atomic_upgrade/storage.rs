use alloc::{string::String, vec::Vec};

use super::Error;
use crate::{Handle, Module, Span, StructMember, Type, TypeInner, VectorSize};

#[derive(Debug, Default)]
pub(crate) struct StorageViews {
    pub(super) source_types: crate::FastHashMap<Handle<Type>, Handle<Type>>,
    pub(super) field_indices: crate::FastHashMap<Handle<Type>, Vec<u32>>,
}

impl StorageViews {
    pub(crate) fn source_type(&self, storage_type: Handle<Type>) -> Option<Handle<Type>> {
        self.source_types.get(&storage_type).copied()
    }

    pub(crate) fn field_index(&self, storage_type: Handle<Type>, source_field: u32) -> Option<u32> {
        self.field_indices
            .get(&storage_type)?
            .get(source_field as usize)
            .copied()
    }
}

fn push_padding(
    module: &mut Module,
    members: &mut Vec<StructMember>,
    offset: u32,
    size: u32,
    span: Span,
) -> Result<(), Error> {
    if size == 0 {
        return Ok(());
    }
    if !size.is_multiple_of(4) || !offset.is_multiple_of(4) {
        return Err(Error::Unsupported);
    }
    let scalar = module.types.insert(
        Type {
            name: None,
            inner: TypeInner::Scalar(crate::Scalar::U32),
        },
        span,
    );
    let ty = if size == 4 {
        scalar
    } else {
        module.types.insert(
            Type {
                name: None,
                inner: TypeInner::Array {
                    base: scalar,
                    size: crate::ArraySize::Constant(core::num::NonZeroU32::new(size / 4).unwrap()),
                    stride: 4,
                },
            },
            span,
        )
    };
    members.push(StructMember {
        name: None,
        ty,
        binding: None,
        offset,
    });
    Ok(())
}

pub(super) fn padded_members(
    module: &mut Module,
    members: Vec<StructMember>,
    span: u32,
    type_span: Span,
) -> Result<(Vec<StructMember>, Vec<u32>), Error> {
    if !span.is_multiple_of(4) || span > crate::valid::MAX_TYPE_SIZE {
        return Err(Error::Unsupported);
    }
    let capacity = members
        .len()
        .checked_mul(2)
        .and_then(|count| count.checked_add(1))
        .ok_or(Error::Unsupported)?;
    let mut padded = Vec::with_capacity(capacity);
    let mut indices = Vec::with_capacity(members.len());
    let mut offset = 0;
    for member in members {
        module
            .types
            .check_contains_handle(member.ty)
            .map_err(|_| Error::Unsupported)?;
        let gap = member
            .offset
            .checked_sub(offset)
            .ok_or(Error::Unsupported)?;
        push_padding(module, &mut padded, offset, gap, type_span)?;
        let size = module.types[member.ty]
            .inner
            .try_size(module.to_ctx())
            .ok_or(Error::Unsupported)?;
        offset = member.offset.checked_add(size).ok_or(Error::Unsupported)?;
        indices.push(u32::try_from(padded.len()).map_err(|_| Error::Unsupported)?);
        padded.push(member);
    }
    let gap = span.checked_sub(offset).ok_or(Error::Unsupported)?;
    push_padding(module, &mut padded, offset, gap, type_span)?;
    Ok((padded, indices))
}

pub(super) fn vector_members(
    size: VectorSize,
    scalar_type: Handle<Type>,
    atomic_type: Handle<Type>,
    components: &bit_set::BitSet,
) -> (Vec<StructMember>, Vec<u32>) {
    let mut members = Vec::with_capacity(size as usize);
    let mut indices = Vec::with_capacity(size as usize);
    for (index, name) in ["x", "y", "z", "w"]
        .into_iter()
        .take(size as usize)
        .enumerate()
    {
        indices.push(index as u32);
        members.push(StructMember {
            name: Some(String::from(name)),
            ty: if components.contains(index) {
                atomic_type
            } else {
                scalar_type
            },
            binding: None,
            offset: index as u32 * 4,
        });
    }
    (members, indices)
}
