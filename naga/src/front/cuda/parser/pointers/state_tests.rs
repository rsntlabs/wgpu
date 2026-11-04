use super::*;

const TEST_SPAN: Span = Span::new(7, 19);
const SOURCE: &str = r#"__global__ void retained(int *out) {
    int first[3]{2, 3, 5}, second[3]{7, 11, 13};
    float unrelated = 1.0f;
    int *pointer = first;
    int *const fixed = second;
    const int *view = first;
    int *copy = pointer;
    pointer = second;
    ++pointer;
    pointer -= 1;
    pointer += 2;
    view = pointer;
    out[0] = *pointer + *copy + *fixed + *view + int(unrelated);
}"#;

fn parsed_state(source: &'static str) -> (Parser<'static>, FunctionParameterState, Function) {
    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
    assert!(matches!(
        parser.function_definition().unwrap(),
        FunctionKind::Kernel
    ));
    let mut context = parser.kernels[0].context.take().unwrap();
    let state = context.take_parameter_state();
    let function = context.ir;
    parser
        .validate_pointer_state(&state, &function, TEST_SPAN)
        .unwrap();
    (parser, state, function)
}

fn assert_rejected(change: impl FnOnce(&mut FunctionParameterState, &mut Function)) {
    let (mut parser, mut state, mut function) = parsed_state(SOURCE);
    change(&mut state, &mut function);
    let error = parser
        .validate_pointer_state(&state, &function, TEST_SPAN)
        .unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(SOURCE.get(range).is_some());
    assert_eq!(error.message, "invalid CUDA source pointer state");
}

fn object_local(state: &FunctionParameterState, writable: bool) -> Handle<LocalVariable> {
    state
        .pointers
        .cells
        .iter()
        .find_map(|(&local, cell)| {
            (cell.kind == PointerCellKind::Object { writable }).then_some(local)
        })
        .unwrap()
}

fn object_binding(
    state: &FunctionParameterState,
    function: &Function,
    writable: bool,
) -> Handle<BoundReference> {
    state
        .pointers
        .expressions
        .iter()
        .find_map(|(_, expression)| {
            let PointerExpressionKind::Object(binding) = expression.kind else {
                return None;
            };
            let target = &state.bound_references[binding].targets[0];
            let Expression::LocalVariable(local) =
                function.expressions[state.bound_addresses[target.address].root]
            else {
                return None;
            };
            (state.pointers.cells[&local].kind == PointerCellKind::Object { writable })
                .then_some(binding)
        })
        .unwrap()
}

fn snapshot(state: &FunctionParameterState) -> (Handle<PointerExpression>, Handle<LocalVariable>) {
    state
        .pointers
        .expressions
        .iter()
        .find_map(|(handle, expression)| match expression.kind {
            PointerExpressionKind::Snapshot(local) => Some((handle, local)),
            _ => None,
        })
        .unwrap()
}

fn operation_marker(
    state: &FunctionParameterState,
    predicate: impl Fn(&PointerOperation) -> bool,
) -> Handle<Expression> {
    *state
        .pointers
        .operations
        .iter()
        .find(|&(_, operation)| predicate(operation))
        .unwrap()
        .0
}

#[test]
fn parsed_pointer_state_preserves_objects_snapshots_and_added_const_qualification() {
    let (_, state, _) = parsed_state(SOURCE);
    assert!(state
        .pointers
        .cells
        .values()
        .any(|cell| cell.kind == PointerCellKind::Object { writable: false }));
    assert!(state.pointers.operations.values().any(|operation| {
        let PointerOperation::Assign { ref value, .. } = *operation else {
            return false;
        };
        let PointerExpressionKind::Snapshot(local) =
            state.pointers.expressions[value.expression].kind
        else {
            return false;
        };
        value.qualifiers.is_const && !state.pointers.cells[&local].qualifiers.is_const
    }));
}

#[test]
fn pointer_state_allows_unemitted_operations_after_return() {
    parsed_state(
        "__global__ void retained() {
            int values[3]{2, 3, 5};
            int *pointer = values;
            return;
            pointer = values + 1;
            ++pointer;
        }",
    );
}

#[test]
fn pointer_cell_metadata_rejects_a_different_local_root() {
    assert_rejected(|state, _| {
        let local = object_local(state, true);
        let other = object_local(state, false);
        let expression = state.pointers.cells[&other].expression;
        state.pointers.cells.get_mut(&local).unwrap().expression = expression;
    });
}

#[test]
fn pointer_cell_metadata_rejects_a_non_u32_local() {
    assert_rejected(|state, function| {
        let local = object_local(state, true);
        let float_type = function
            .local_variables
            .iter()
            .find(|&(_, variable)| variable.name.as_deref() == Some("unrelated"))
            .unwrap()
            .1
            .ty;
        function.local_variables[local].ty = float_type;
    });
}

#[test]
fn pointer_snapshot_rejects_a_missing_cell() {
    assert_rejected(|state, _| {
        let (_, local) = snapshot(state);
        state.pointers.cells.remove(&local).unwrap();
    });
}

#[test]
fn pointer_snapshot_rejects_an_object_cell() {
    assert_rejected(|state, _| {
        let (expression, _) = snapshot(state);
        let object = object_local(state, true);
        state.pointers.expressions[expression].kind = PointerExpressionKind::Snapshot(object);
    });
}

#[test]
fn pointer_capture_rejects_an_object_destination() {
    assert_rejected(|state, _| {
        let marker = operation_marker(state, |operation| {
            matches!(*operation, PointerOperation::Capture { .. })
        });
        let object = object_local(state, true);
        let PointerOperation::Capture {
            ref mut destination,
            ..
        } = *state.pointers.operations.get_mut(&marker).unwrap()
        else {
            unreachable!();
        };
        *destination = object;
    });
}

#[test]
fn pointer_assignment_rejects_a_const_object_destination() {
    assert_rejected(|state, function| {
        let marker = operation_marker(state, |operation| {
            matches!(*operation, PointerOperation::Assign { .. })
        });
        let fixed = object_binding(state, function, false);
        let PointerOperation::Assign {
            ref mut destination,
            ..
        } = *state.pointers.operations.get_mut(&marker).unwrap()
        else {
            unreachable!();
        };
        *destination = fixed;
    });
}

#[test]
fn pointer_update_rejects_a_const_object_destination() {
    assert_rejected(|state, function| {
        let marker = operation_marker(state, |operation| {
            matches!(*operation, PointerOperation::Update { .. })
        });
        let fixed = object_binding(state, function, false);
        let PointerOperation::Update {
            ref mut destination,
            ..
        } = *state.pointers.operations.get_mut(&marker).unwrap()
        else {
            unreachable!();
        };
        *destination = fixed;
    });
}

#[test]
fn pointer_update_rejects_a_float_amount() {
    assert_rejected(|state, function| {
        let marker = operation_marker(state, |operation| {
            matches!(*operation, PointerOperation::Update { .. })
        });
        let float = function
            .expressions
            .iter()
            .find(|&(_, expression)| matches!(*expression, Expression::Literal(Literal::F32(_))))
            .unwrap()
            .0;
        let PointerOperation::Update { ref mut amount, .. } =
            *state.pointers.operations.get_mut(&marker).unwrap()
        else {
            unreachable!();
        };
        *amount = float;
    });
}

#[test]
fn pointer_update_rejects_a_missing_later_amount_expression() {
    assert_rejected(|state, function| {
        let marker = *state
            .pointers
            .operations
            .iter()
            .filter(|&(_, operation)| matches!(*operation, PointerOperation::Update { .. }))
            .max_by_key(|&(marker, _)| marker.index())
            .unwrap()
            .0;
        let mut detached = function.expressions.clone();
        let missing = detached.append(Expression::Literal(Literal::U32(1)), TEST_SPAN);
        let PointerOperation::Update { ref mut amount, .. } =
            *state.pointers.operations.get_mut(&marker).unwrap()
        else {
            unreachable!();
        };
        *amount = missing;
    });
}

#[test]
fn pointer_operation_rejects_a_non_binary_marker() {
    assert_rejected(|state, function| {
        let marker = operation_marker(state, |_| true);
        function.expressions[marker] = Expression::Literal(Literal::U32(0));
    });
}

#[test]
fn pointer_operation_rejects_a_live_marker_outside_its_block() {
    assert_rejected(|state, function| {
        let (index, emit) = function
            .body
            .iter()
            .enumerate()
            .find_map(|(index, statement)| {
                let Statement::Block(ref body) = *statement else {
                    return None;
                };
                let &[Statement::Emit(ref range)] = &body[..] else {
                    return None;
                };
                range
                    .clone()
                    .any(|marker| state.pointers.operations.contains_key(&marker))
                    .then(|| (index, body[0].clone()))
            })
            .unwrap();
        function.body[index] = emit;
    });
}

#[test]
fn pointer_operation_rejects_a_live_marker_without_an_operation() {
    assert_rejected(|state, _| {
        let marker = operation_marker(state, |operation| {
            matches!(*operation, PointerOperation::Assign { .. })
        });
        state.pointers.operations.remove(&marker).unwrap();
    });
}

#[test]
fn pointer_cell_rejects_overlap_with_a_validation_address() {
    assert_rejected(|state, _| {
        let local = object_local(state, true);
        let access = state.pointers.accesses.iter().next().unwrap().0;
        let previous = state
            .pointers
            .access_addresses
            .insert(access, local)
            .unwrap();
        state
            .pointers
            .validation_addresses
            .remove(&previous)
            .unwrap();
        state.pointers.validation_addresses.insert(local, access);
    });
}

const ARRAY_VIEW_SOURCE: &str = r#"__global__ void retained(int *out) {
    using Known = int[3]; using Values = int[];
    Known first{2, 3, 5}; const Known frozen{7, 11, 13};
    Known *known = &first; const Known *readonly = &frozen;
    Values *view = known; const Values *readview = readonly;
    int *elements = *view;
    out[0] = elements[1] + (*readview)[1];
}"#;

fn array_view_handles(
    state: &FunctionParameterState,
    readonly: bool,
) -> (Handle<PointerExpression>, Handle<PointerExpression>) {
    state
        .pointers
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            let PointerExpressionKind::ArrayView { base } = expression.kind else {
                return None;
            };
            let PointerExpressionKind::Snapshot(local) = state.pointers.expressions[base].kind
            else {
                return None;
            };
            (state.pointers.cells[&local].qualifiers.is_const == readonly).then_some((handle, base))
        })
        .unwrap()
}

fn reject_array_view_state(
    change: impl FnOnce(&mut Parser<'static>, &mut FunctionParameterState, &mut Function),
) -> ParseError {
    let (mut parser, mut state, mut function) = parsed_state(ARRAY_VIEW_SOURCE);
    change(&mut parser, &mut state, &mut function);
    let error = parser
        .validate_pointer_state(&state, &function, TEST_SPAN)
        .unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(ARRAY_VIEW_SOURCE.get(range).is_some());
    error
}

#[test]
fn array_view_metadata_rejects_invalid_children_shapes_and_depths() {
    for case in [
        "missing child",
        "forward child",
        "cycle",
        "scalar target",
        "different element",
        "different stride",
        "complete target",
        "stored depth",
        "depth limit",
    ] {
        let error = reject_array_view_state(|parser, state, _| {
            let (view, child) = array_view_handles(state, false);
            let pointee = state.pointers.expressions[view].pointee;
            let TypeInner::Array {
                base: element,
                stride,
                ..
            } = parser.module.types[pointee].inner
            else {
                panic!("expected the logical unknown-bound array");
            };
            match case {
                "missing child" => {
                    let mut detached = state.pointers.expressions.clone();
                    let missing =
                        detached.append(state.pointers.expressions[child].clone(), TEST_SPAN);
                    state.pointers.expressions[view].kind =
                        PointerExpressionKind::ArrayView { base: missing };
                }
                "forward child" => {
                    let later = state
                        .pointers
                        .expressions
                        .append(state.pointers.expressions[child].clone(), TEST_SPAN);
                    state.pointers.expressions[view].kind =
                        PointerExpressionKind::ArrayView { base: later };
                }
                "cycle" => {
                    state.pointers.expressions[view].kind =
                        PointerExpressionKind::ArrayView { base: view }
                }
                "scalar target" => state.pointers.expressions[view].pointee = element,
                "different element" | "different stride" => {
                    let base = if case == "different element" {
                        parser.scalar_handle(Scalar::U32, TEST_SPAN)
                    } else {
                        element
                    };
                    let stride = if case == "different stride" {
                        stride + 4
                    } else {
                        stride
                    };
                    let forged = parser.module.types.insert(
                        Type {
                            name: None,
                            inner: TypeInner::Array {
                                base,
                                size: ArraySize::Dynamic,
                                stride,
                            },
                        },
                        TEST_SPAN,
                    );
                    state.pointers.expressions[view].pointee = forged;
                }
                "complete target" => {
                    state.pointers.expressions[view].pointee =
                        state.pointers.expressions[child].pointee
                }
                "stored depth" => state.pointers.expressions[view].depth += 1,
                "depth limit" => {
                    let local = object_local(state, true);
                    let offset = state.pointers.cells[&local].expression;
                    let known = state.pointers.expressions[child].pointee;
                    let mut base = child;
                    for _ in 0..63 {
                        let depth = state.pointers.expressions[base].depth + 1;
                        base = state.pointers.expressions.append(
                            PointerExpression {
                                kind: PointerExpressionKind::Offset {
                                    base,
                                    offset,
                                    subtract: false,
                                },
                                pointee: known,
                                depth,
                            },
                            TEST_SPAN,
                        );
                    }
                    assert_eq!(state.pointers.expressions[base].depth, 64);
                    state.pointers.expressions.append(
                        PointerExpression {
                            kind: PointerExpressionKind::ArrayView { base },
                            pointee,
                            depth: 65,
                        },
                        TEST_SPAN,
                    );
                }
                _ => unreachable!(),
            }
        });
        assert_eq!(
            error.message,
            if case == "depth limit" {
                "CUDA pointer expression nesting limit exceeded"
            } else {
                "invalid CUDA source pointer state"
            },
            "{case}"
        );
    }
}

#[test]
fn array_view_values_preserve_const_qualification_through_snapshots() {
    let error = reject_array_view_state(|_, state, _| {
        let (view, _) = array_view_handles(state, true);
        let value = state
            .pointers
            .operations
            .values_mut()
            .find_map(|operation| {
                let PointerOperation::Initialize { ref mut value, .. } = *operation else {
                    return None;
                };
                (value.expression == view).then_some(value)
            })
            .unwrap();
        assert!(value.qualifiers.is_const);
        value.qualifiers = Qualifiers::NONE;
    });
    assert_eq!(error.message, "invalid CUDA source pointer state");
}

#[test]
fn array_view_validation_slots_require_bijective_sized_congruent_proxies() {
    for case in [
        "missing forward map",
        "missing reverse map",
        "different count",
        "different element",
        "different stride",
        "scalar proxy",
    ] {
        let error = reject_array_view_state(|parser, state, function| {
            let (local, access) = state
                .pointers
                .validation_addresses
                .iter()
                .find_map(|(&local, &access)| {
                    matches!(
                        *state.pointers.accesses[access]
                            .ty
                            .inner_with(&parser.module.types),
                        TypeInner::Array {
                            size: ArraySize::Dynamic,
                            ..
                        }
                    )
                    .then_some((local, access))
                })
                .unwrap();
            let TypeInner::Array {
                base: element,
                size,
                stride,
            } = parser.module.types[function.local_variables[local].ty].inner
            else {
                panic!("expected a sized array validation slot");
            };
            assert_eq!(
                size,
                ArraySize::Constant(core::num::NonZeroU32::new(1).unwrap())
            );
            match case {
                "missing forward map" => {
                    state.pointers.validation_addresses.remove(&local).unwrap();
                }
                "missing reverse map" => {
                    state.pointers.access_addresses.remove(&access).unwrap();
                }
                "scalar proxy" => function.local_variables[local].ty = element,
                "different count" | "different element" | "different stride" => {
                    let base = if case == "different element" {
                        parser.scalar_handle(Scalar::U32, TEST_SPAN)
                    } else {
                        element
                    };
                    let count = if case == "different count" { 2 } else { 1 };
                    let stride = if case == "different stride" {
                        stride + 4
                    } else {
                        stride
                    };
                    function.local_variables[local].ty = parser.module.types.insert(
                        Type {
                            name: None,
                            inner: TypeInner::Array {
                                base,
                                size: ArraySize::Constant(
                                    core::num::NonZeroU32::new(count).unwrap(),
                                ),
                                stride,
                            },
                        },
                        TEST_SPAN,
                    );
                }
                _ => unreachable!(),
            }
        });
        assert_eq!(error.message, "invalid CUDA source pointer state", "{case}");
    }
}

#[test]
fn array_view_source_descriptors_require_canonical_address_spaces() {
    let (mut parser, state, function) = parsed_state(ARRAY_VIEW_SOURCE);
    let (view, _) = array_view_handles(&state, false);
    let original = state
        .pointers
        .operations
        .values()
        .find_map(|operation| {
            let PointerOperation::Initialize { ref value, .. } = *operation else {
                return None;
            };
            (value.expression == view).then_some(value.clone())
        })
        .unwrap();
    let pointee = state.pointers.expressions[view].pointee;
    let TypeInner::Array { base: element, .. } = parser.module.types[pointee].inner else {
        panic!("expected the logical unknown-bound array");
    };
    for (base, space) in [
        (pointee, AddressSpace::Function),
        (
            pointee,
            AddressSpace::Storage {
                access: StorageAccess::LOAD,
            },
        ),
        (
            element,
            AddressSpace::Storage {
                access: StorageAccess::LOAD | StorageAccess::STORE,
            },
        ),
    ] {
        let mut forged = original.clone();
        forged.ty = TypeResolution::Value(TypeInner::Pointer { base, space });
        let types = parser.module.types.len();
        let error = parser
            .validate_source_pointer_value(&state.pointers, &function, &forged)
            .unwrap_err();
        assert_eq!(error.message, "invalid CUDA source pointer state");
        assert_eq!(error.span, forged.span);
        assert_eq!(parser.module.types.len(), types);
    }
}

#[test]
fn array_view_parameters_require_their_logical_source_owner() {
    let source =
        "using Values = int[]; __device__ int retained(Values *view) { return (*view)[0]; }";
    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
    parser.alias_declaration(true).unwrap();
    assert!(matches!(
        parser.function_definition().unwrap(),
        FunctionKind::Device
    ));
    let handle = parser.module.functions.iter().next().unwrap().0;
    let function = core::mem::take(&mut parser.module.functions[handle]);
    let state = parser.parameter_states.remove(&handle).unwrap();
    let parameters = parser.function_declarations[&handle].parameters.clone();
    parser
        .validate_pointer_state_with_parameters(&state, &function, &parameters, TEST_SPAN)
        .unwrap();
    let mut with_erased = parameters.clone();
    with_erased.insert(
        0,
        SourceParameter::NullPointer {
            mode: ParameterMode::Value,
        },
    );
    parser
        .validate_pointer_state_with_parameters(&state, &function, &with_erased, TEST_SPAN)
        .unwrap();
    for case in [
        "missing owner",
        "value mode",
        "physical proxy owner",
        "different pointee",
        "wrong physical shape",
    ] {
        let mut forged_parameters = parameters.clone();
        let mut forged_function = function.clone();
        match case {
            "missing owner" => forged_parameters.clear(),
            "value mode" => {
                let SourceParameter::Shader { ty, .. } = parameters[0] else {
                    panic!("expected one source pointer parameter");
                };
                forged_parameters[0] = SourceParameter::Shader {
                    ty,
                    mode: ParameterMode::Value,
                };
            }
            "physical proxy owner" => {
                forged_parameters[0] = SourceParameter::Shader {
                    ty: function.arguments[0].ty,
                    mode: ParameterMode::Pointer {
                        qualifiers: Qualifiers::NONE,
                    },
                }
            }
            "different pointee" => {
                let scalar = parser.scalar_handle(Scalar::U32, TEST_SPAN);
                let pointer = parser.pointer_type(scalar, TEST_SPAN).unwrap();
                let ty = parser.type_handle(&pointer, TEST_SPAN);
                forged_parameters[0] = SourceParameter::Shader {
                    ty,
                    mode: ParameterMode::Pointer {
                        qualifiers: Qualifiers::NONE,
                    },
                };
            }
            "wrong physical shape" => {
                let TypeInner::Pointer { base: proxy, .. } =
                    parser.module.types[function.arguments[0].ty].inner
                else {
                    panic!("expected a physical pointer argument");
                };
                let TypeInner::Array { base, .. } = parser.module.types[proxy].inner else {
                    panic!("expected an array validation proxy");
                };
                let array = parser
                    .array_type(
                        base,
                        ArraySize::Constant(core::num::NonZeroU32::new(2).unwrap()),
                        TEST_SPAN,
                        TEST_SPAN,
                    )
                    .unwrap();
                let pointer = parser.pointer_type(array, TEST_SPAN).unwrap();
                forged_function.arguments[0].ty = parser.type_handle(&pointer, TEST_SPAN);
            }
            _ => unreachable!(),
        }
        let error = parser
            .validate_pointer_state_with_parameters(
                &state,
                &forged_function,
                &forged_parameters,
                TEST_SPAN,
            )
            .unwrap_err();
        assert_eq!(error.message, "invalid CUDA source pointer state", "{case}");
    }
}
