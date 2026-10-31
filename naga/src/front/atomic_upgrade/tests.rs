use alloc::{string::String, vec};

use super::*;
use crate::{AddressSpace, ArraySize, Scalar, Span, StorageAccess, StructMember, VectorSize};

fn insert_type(module: &mut Module, inner: TypeInner) -> Handle<Type> {
    module
        .types
        .insert(Type { name: None, inner }, Span::UNDEFINED)
}

fn member(name: &str, ty: Handle<Type>, offset: u32) -> StructMember {
    StructMember {
        name: Some(String::from(name)),
        ty,
        binding: None,
        offset,
    }
}

fn global(module: &mut Module, ty: Handle<Type>, space: AddressSpace) -> Handle<GlobalVariable> {
    module.global_variables.append(
        GlobalVariable {
            name: None,
            space,
            binding: None,
            ty,
            init: None,
            memory_decorations: Default::default(),
        },
        Span::UNDEFINED,
    )
}

fn array(module: &mut Module, base: Handle<Type>, stride: u32) -> Handle<Type> {
    insert_type(
        module,
        TypeInner::Array {
            base,
            size: ArraySize::Constant(core::num::NonZeroU32::new(2).unwrap()),
            stride,
        },
    )
}

#[test]
fn storage_views_preserve_vector_components_record_padding_and_unselected_roots() {
    let mut module = Module::default();
    let scalar = insert_type(&mut module, TypeInner::Scalar(Scalar::I32));
    let pair = insert_type(
        &mut module,
        TypeInner::Vector {
            size: VectorSize::Bi,
            scalar: Scalar::I32,
        },
    );
    let quad = insert_type(
        &mut module,
        TypeInner::Vector {
            size: VectorSize::Quad,
            scalar: Scalar::I32,
        },
    );
    let record = insert_type(
        &mut module,
        TypeInner::Struct {
            members: vec![
                member("marker", scalar, 0),
                member("pair", pair, 8),
                member("quad", quad, 16),
                member("tail", scalar, 32),
            ],
            span: 48,
        },
    );
    let records = array(&mut module, record, 48);
    let writable = global(
        &mut module,
        records,
        AddressSpace::Storage {
            access: StorageAccess::LOAD | StorageAccess::STORE,
        },
    );
    let readonly = global(
        &mut module,
        records,
        AddressSpace::Storage {
            access: StorageAccess::LOAD,
        },
    );
    let original = module.types[record].clone();
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(writable);
    upgrades.insert_field(record, 1);
    upgrades.insert_field(record, 2);
    upgrades.insert_vector_component(pair, 1);
    upgrades.insert_vector_component(quad, 2);
    let views = module
        .upgrade_atomics_with_storage_views(&upgrades)
        .unwrap();

    assert_eq!(module.types[record], original);
    assert_eq!(module.global_variables[readonly].ty, records);
    let storage_records = module.global_variables[writable].ty;
    assert_eq!(views.source_type(storage_records), Some(records));
    let TypeInner::Array {
        base: storage_record,
        stride,
        ..
    } = module.types[storage_records].inner
    else {
        panic!("storage array")
    };
    assert_eq!(stride, 48);
    assert_eq!(views.source_type(storage_record), Some(record));
    let TypeInner::Struct { ref members, span } = module.types[storage_record].inner else {
        panic!("storage record")
    };
    assert_eq!(span, 48);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<vec::Vec<_>>(),
        [0, 4, 8, 16, 32, 36]
    );
    assert_eq!(
        (0..4)
            .map(|index| views.field_index(storage_record, index).unwrap())
            .collect::<vec::Vec<_>>(),
        [0, 2, 3, 4]
    );
    for (source_vector, storage_field, atomic_component, width) in
        [(pair, 2, 1, 2), (quad, 3, 2, 4)]
    {
        let storage_vector = members[storage_field].ty;
        assert_eq!(views.source_type(storage_vector), Some(source_vector));
        let TypeInner::Struct {
            members: ref components,
            span,
        } = module.types[storage_vector].inner
        else {
            panic!("component record")
        };
        assert_eq!(span, width * 4);
        assert_eq!(components.len(), width as usize);
        for (index, component) in components.iter().enumerate() {
            assert_eq!(
                views.field_index(storage_vector, index as u32),
                Some(index as u32)
            );
            assert_eq!(component.offset, index as u32 * 4);
            let expected = if index == atomic_component {
                TypeInner::Atomic(Scalar::I32)
            } else {
                TypeInner::Scalar(Scalar::I32)
            };
            assert_eq!(module.types[component.ty].inner, expected);
        }
    }
}

#[test]
fn storage_padding_uses_compact_arrays_for_large_gaps() {
    let mut module = Module::default();
    let scalar = insert_type(&mut module, TypeInner::Scalar(Scalar::I32));
    let record = insert_type(
        &mut module,
        TypeInner::Struct {
            members: vec![member("counter", scalar, 0), member("other", scalar, 4096)],
            span: 8192,
        },
    );
    let variable = global(&mut module, record, AddressSpace::WorkGroup);
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(variable);
    upgrades.insert_field(record, 0);
    let views = module
        .upgrade_atomics_with_storage_views(&upgrades)
        .unwrap();
    let storage = module.global_variables[variable].ty;
    let TypeInner::Struct { ref members, span } = module.types[storage].inner else {
        panic!("storage record")
    };
    assert_eq!(span, 8192);
    assert_eq!(members.len(), 4);
    assert_eq!(views.field_index(storage, 1), Some(2));
    for index in [1, 3] {
        let TypeInner::Array {
            size: ArraySize::Constant(count),
            stride: 4,
            ..
        } = module.types[members[index].ty].inner
        else {
            panic!("compact padding")
        };
        assert_eq!(count.get(), 1023);
    }
}

#[test]
fn storage_view_depth_checks_only_follow_upgraded_fields() {
    let mut module = Module::default();
    let scalar = insert_type(&mut module, TypeInner::Scalar(Scalar::I32));
    let mut nested = scalar;
    for _ in 0..70 {
        nested = insert_type(
            &mut module,
            TypeInner::Array {
                base: nested,
                size: ArraySize::Constant(core::num::NonZeroU32::new(1).unwrap()),
                stride: 4,
            },
        );
    }
    let record = insert_type(
        &mut module,
        TypeInner::Struct {
            members: vec![member("counter", scalar, 0), member("unchanged", nested, 4)],
            span: 8,
        },
    );
    let variable = global(&mut module, record, AddressSpace::WorkGroup);
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(variable);
    upgrades.insert_field(record, 0);
    let views = module
        .upgrade_atomics_with_storage_views(&upgrades)
        .unwrap();
    let storage = module.global_variables[variable].ty;
    let TypeInner::Struct { ref members, .. } = module.types[storage].inner else {
        panic!("storage record")
    };
    let index = views.field_index(storage, 1).unwrap();
    assert_eq!(members[index as usize].ty, nested);

    module.global_variables[variable].ty = record;
    upgrades.insert_field(record, 1);
    assert!(matches!(
        module.upgrade_atomics_with_storage_views(&upgrades),
        Err(Error::StorageViewNestingLimit)
    ));
}

#[test]
fn storage_views_reject_invalid_fields_components_and_memory_spaces() {
    let mut module = Module::default();
    let pair = insert_type(
        &mut module,
        TypeInner::Vector {
            size: VectorSize::Bi,
            scalar: Scalar::I32,
        },
    );
    let variable = global(&mut module, pair, AddressSpace::WorkGroup);
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(variable);
    upgrades.insert_vector_component(pair, 2);
    assert!(matches!(
        module.upgrade_atomics_with_storage_views(&upgrades),
        Err(Error::Unsupported)
    ));

    for space in [
        AddressSpace::Private,
        AddressSpace::Storage {
            access: StorageAccess::LOAD,
        },
    ] {
        let mut module = Module::default();
        let scalar = insert_type(&mut module, TypeInner::Scalar(Scalar::I32));
        let variable = global(&mut module, scalar, space);
        let mut upgrades = Upgrades::default();
        upgrades.insert_global(variable);
        assert!(matches!(
            module.upgrade_atomics_with_storage_views(&upgrades),
            Err(Error::Unsupported)
        ));
    }
    let scalar = insert_type(&mut module, TypeInner::Scalar(Scalar::I32));
    let record = insert_type(
        &mut module,
        TypeInner::Struct {
            members: vec![member("counter", scalar, 0)],
            span: 4,
        },
    );
    module.global_variables[variable].ty = record;
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(variable);
    upgrades.insert_field(record, 1);
    assert!(matches!(
        module.upgrade_atomics_with_storage_views(&upgrades),
        Err(Error::Unsupported)
    ));
}

#[cfg(feature = "spv-in")]
#[test]
fn default_atomic_upgrade_keeps_vector_types_unchanged() {
    let mut module = Module::default();
    let pair = insert_type(
        &mut module,
        TypeInner::Vector {
            size: VectorSize::Bi,
            scalar: Scalar::I32,
        },
    );
    let variable = global(&mut module, pair, AddressSpace::WorkGroup);
    let mut upgrades = Upgrades::default();
    upgrades.insert_global(variable);
    upgrades.insert_vector_component(pair, 1);
    module.upgrade_atomics(&upgrades).unwrap();
    assert_eq!(module.global_variables[variable].ty, pair);
    module
        .upgrade_atomics_with_storage_views(&upgrades)
        .unwrap();
    assert_ne!(module.global_variables[variable].ty, pair);
}
