use alloc::vec;

use super::origins::PointerOrigin;
use super::*;

const TEST_SPAN: Span = Span::new(7, 19);

fn parser() -> Parser<'static> {
    Parser::new(Lexer::new("").unwrap(), &Options::default())
}

fn insert_type(parser: &mut Parser<'_>, inner: TypeInner) -> Handle<Type> {
    parser
        .module
        .types
        .insert(Type { name: None, inner }, TEST_SPAN)
}

fn fixed_array(
    parser: &mut Parser<'_>,
    base: Handle<Type>,
    length: u32,
    stride: u32,
) -> Handle<Type> {
    insert_type(
        parser,
        TypeInner::Array {
            base,
            size: ArraySize::Constant(core::num::NonZeroU32::new(length).unwrap()),
            stride,
        },
    )
}

fn local_root(parser: &mut Parser<'_>, ty: Handle<Type>) -> Handle<Expression> {
    let variable = parser.function.ir.local_variables.append(
        LocalVariable {
            name: None,
            ty,
            init: None,
        },
        TEST_SPAN,
    );
    parser
        .function
        .ir
        .expressions
        .append(Expression::LocalVariable(variable), TEST_SPAN)
}

fn global_root(
    parser: &mut Parser<'_>,
    ty: Handle<Type>,
    space: AddressSpace,
) -> Handle<Expression> {
    let variable = parser.module.global_variables.append(
        GlobalVariable {
            name: None,
            space,
            binding: None,
            ty,
            init: None,
            memory_decorations: Default::default(),
        },
        TEST_SPAN,
    );
    parser
        .function
        .ir
        .expressions
        .append(Expression::GlobalVariable(variable), TEST_SPAN)
}

fn captured_index(parser: &mut Parser<'_>) -> AddressProjection {
    let ty = insert_type(parser, TypeInner::Scalar(Scalar::U32));
    AddressProjection::Index(local_root(parser, ty))
}

fn record_type(
    parser: &mut Parser<'_>,
    scalar: Handle<Type>,
    samples: Handle<Type>,
) -> Handle<Type> {
    insert_type(
        parser,
        TypeInner::Struct {
            members: vec![
                StructMember {
                    name: Some(String::from("value")),
                    ty: scalar,
                    binding: None,
                    offset: 0,
                },
                StructMember {
                    name: Some(String::from("samples")),
                    ty: samples,
                    binding: None,
                    offset: 4,
                },
            ],
            span: 16,
        },
    )
}

fn assert_origin(
    parser: &mut Parser<'_>,
    address: BoundAddress,
    is_array: bool,
    expected: PointerOrigin,
) {
    let expression_count = parser.function.ir.expressions.len();
    let statement_count = parser.function.ir.body.len();
    let actual = parser
        .analyze_pointer_origin(address, is_array, TEST_SPAN)
        .unwrap();
    match (actual, expected) {
        (
            PointerOrigin::Array {
                address,
                initial_index,
            },
            PointerOrigin::Array {
                address: expected_address,
                initial_index: expected_index,
            },
        ) => {
            assert_eq!(address, expected_address);
            assert_eq!(initial_index, expected_index);
        }
        (PointerOrigin::Object(address), PointerOrigin::Object(expected)) => {
            assert_eq!(address, expected);
        }
        _ => panic!("unexpected pointer origin category"),
    }
    assert_eq!(parser.function.ir.expressions.len(), expression_count);
    assert_eq!(parser.function.ir.body.len(), statement_count);
}

fn assert_origin_error(
    parser: &mut Parser<'_>,
    address: BoundAddress,
    is_array: bool,
    message: &str,
) {
    let expression_count = parser.function.ir.expressions.len();
    let statement_count = parser.function.ir.body.len();
    let Err(error) = parser.analyze_pointer_origin(address, is_array, TEST_SPAN) else {
        panic!("malformed address unexpectedly had a pointer origin");
    };
    assert_eq!(error.span, TEST_SPAN);
    assert!(error.message.contains(message), "{error}");
    assert_eq!(parser.function.ir.expressions.len(), expression_count);
    assert_eq!(parser.function.ir.body.len(), statement_count);
}

#[test]
fn array_decay_preserves_local_workgroup_and_dynamic_storage_roots() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let fixed = fixed_array(&mut parser, scalar, 4, 4);
    let dynamic = insert_type(
        &mut parser,
        TypeInner::Array {
            base: scalar,
            size: ArraySize::Dynamic,
            stride: 4,
        },
    );
    let roots = [
        local_root(&mut parser, fixed),
        global_root(&mut parser, fixed, AddressSpace::WorkGroup),
        global_root(
            &mut parser,
            dynamic,
            AddressSpace::Storage {
                access: StorageAccess::LOAD | StorageAccess::STORE,
            },
        ),
    ];
    for root in roots {
        let address = BoundAddress {
            root,
            projections: vec![],
        };
        assert_origin(
            &mut parser,
            address.clone(),
            true,
            PointerOrigin::Array {
                address,
                initial_index: None,
            },
        );
    }
}

#[test]
fn row_decay_keeps_the_entire_captured_ancestor_path() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let row = fixed_array(&mut parser, scalar, 3, 4);
    let matrix = fixed_array(&mut parser, row, 2, 12);
    let root = local_root(&mut parser, matrix);
    let address = BoundAddress {
        root,
        projections: vec![captured_index(&mut parser)],
    };
    assert_origin(
        &mut parser,
        address.clone(),
        true,
        PointerOrigin::Array {
            address,
            initial_index: None,
        },
    );
}

#[test]
fn indexed_scalar_removes_only_the_final_array_projection() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let row = fixed_array(&mut parser, scalar, 3, 4);
    let matrix = fixed_array(&mut parser, row, 2, 12);
    let root = local_root(&mut parser, matrix);
    let ancestor = captured_index(&mut parser);
    let indices = [AddressProjection::Field(2), captured_index(&mut parser)];
    for initial_index in indices {
        assert_origin(
            &mut parser,
            BoundAddress {
                root,
                projections: vec![ancestor.clone(), initial_index.clone()],
            },
            false,
            PointerOrigin::Array {
                address: BoundAddress {
                    root,
                    projections: vec![ancestor.clone()],
                },
                initial_index: Some(initial_index),
            },
        );
    }
}

#[test]
fn scalar_root_keeps_its_individual_object_origin() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let address = BoundAddress {
        root: local_root(&mut parser, scalar),
        projections: vec![],
    };
    assert_origin(
        &mut parser,
        address.clone(),
        false,
        PointerOrigin::Object(address),
    );
}

#[test]
fn structure_array_field_decay_keeps_the_field_path() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let samples = fixed_array(&mut parser, scalar, 3, 4);
    let record = record_type(&mut parser, scalar, samples);
    let address = BoundAddress {
        root: local_root(&mut parser, record),
        projections: vec![AddressProjection::Field(1)],
    };
    assert_origin(
        &mut parser,
        address.clone(),
        true,
        PointerOrigin::Array {
            address,
            initial_index: None,
        },
    );
}

#[test]
fn field_of_an_array_element_remains_an_individual_object() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let samples = fixed_array(&mut parser, scalar, 3, 4);
    let record = record_type(&mut parser, scalar, samples);
    let records = fixed_array(&mut parser, record, 2, 16);
    let address = BoundAddress {
        root: local_root(&mut parser, records),
        projections: vec![captured_index(&mut parser), AddressProjection::Field(0)],
    };
    assert_origin(
        &mut parser,
        address.clone(),
        false,
        PointerOrigin::Object(address),
    );
}

#[test]
fn nested_structure_array_element_keeps_ancestors_and_splits_the_last_index() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let samples = fixed_array(&mut parser, scalar, 3, 4);
    let record = record_type(&mut parser, scalar, samples);
    let records = fixed_array(&mut parser, record, 2, 16);
    let root = local_root(&mut parser, records);
    let ancestor = captured_index(&mut parser);
    let initial_index = captured_index(&mut parser);
    assert_origin(
        &mut parser,
        BoundAddress {
            root,
            projections: vec![
                ancestor.clone(),
                AddressProjection::Field(1),
                initial_index.clone(),
            ],
        },
        false,
        PointerOrigin::Array {
            address: BoundAddress {
                root,
                projections: vec![ancestor, AddressProjection::Field(1)],
            },
            initial_index: Some(initial_index),
        },
    );
}

#[test]
fn vector_component_keeps_its_individual_object_origin() {
    let mut parser = parser();
    let vector = insert_type(
        &mut parser,
        TypeInner::Vector {
            size: VectorSize::Bi,
            scalar: Scalar::F32,
        },
    );
    let address = BoundAddress {
        root: local_root(&mut parser, vector),
        projections: vec![AddressProjection::Field(1)],
    };
    assert_origin(
        &mut parser,
        address.clone(),
        false,
        PointerOrigin::Object(address),
    );
}

#[test]
fn malformed_roots_are_checked_for_both_address_and_decay_origins() {
    let mut parser = parser();
    let root = parser
        .function
        .ir
        .expressions
        .append(Expression::Literal(Literal::U32(0)), TEST_SPAN);
    for is_array in [false, true] {
        assert_origin_error(
            &mut parser,
            BoundAddress {
                root,
                projections: vec![],
            },
            is_array,
            "unknown CUDA pointer origin",
        );
    }
}

#[test]
fn malformed_typed_projections_preserve_source_spans_without_emitting_ir() {
    let mut parser = parser();
    let scalar = insert_type(&mut parser, TypeInner::Scalar(Scalar::I32));
    let samples = fixed_array(&mut parser, scalar, 3, 4);
    let record = record_type(&mut parser, scalar, samples);
    let root = local_root(&mut parser, record);
    let index = captured_index(&mut parser);
    for is_array in [false, true] {
        assert_origin_error(
            &mut parser,
            BoundAddress {
                root,
                projections: vec![AddressProjection::Field(2)],
            },
            is_array,
            "invalid CUDA address field",
        );
        assert_origin_error(
            &mut parser,
            BoundAddress {
                root,
                projections: vec![index.clone()],
            },
            is_array,
            "invalid CUDA structure address index",
        );
        assert_origin_error(
            &mut parser,
            BoundAddress {
                root,
                projections: vec![AddressProjection::Field(0), AddressProjection::Field(0)],
            },
            is_array,
            "invalid CUDA address projection",
        );
    }
}
