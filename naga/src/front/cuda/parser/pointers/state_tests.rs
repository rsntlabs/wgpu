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
    let mut context = parser.kernel_context.take().unwrap();
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
        value.is_const && !state.pointers.cells[&local].is_const
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
