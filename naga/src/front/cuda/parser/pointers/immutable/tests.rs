use alloc::vec;

use super::*;

const TEST_SPAN: Span = Span::new(7, 19);
const SOURCE: &str = "__global__ void retained(int *out) { out[0] = out[1]; }";

fn parsed_state() -> (Parser<'static>, Function, FunctionParameterState) {
    let mut parser = Parser::new(Lexer::new(SOURCE).unwrap(), &Options::default());
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
    assert!(
        !ImmutablePointers::analyze(&mut parser, &function, &state, TEST_SPAN)
            .unwrap()
            .is_empty()
    );
    (parser, function, state)
}

fn operation_index(
    function: &Function,
    state: &FunctionParameterState,
    predicate: impl Fn(&PointerOperation) -> bool,
) -> usize {
    function
        .body
        .iter()
        .position(|statement| {
            let Statement::Block(ref body) = *statement else {
                return false;
            };
            deferred_call_marker(body)
                .and_then(|marker| state.pointers.operations.get(&marker))
                .is_some_and(&predicate)
        })
        .unwrap()
}

fn initialize(operation: &PointerOperation) -> bool {
    matches!(*operation, PointerOperation::Initialize { .. })
}

fn capture(operation: &PointerOperation) -> bool {
    matches!(*operation, PointerOperation::Capture { .. })
}

fn assert_fallback(parser: &mut Parser<'_>, function: &Function, state: &FunctionParameterState) {
    let plan = ImmutablePointers::analyze(parser, function, state, TEST_SPAN).unwrap();
    assert!(plan.is_empty());
    for &local in state.pointers.cells.keys() {
        assert!(plan.initializer(local).is_none());
    }
}

#[test]
fn immutable_pointer_proof_resolves_objects_and_snapshots_to_resource_arrays() {
    let (mut parser, function, state) = parsed_state();
    let plan = ImmutablePointers::analyze(&mut parser, &function, &state, TEST_SPAN).unwrap();
    let initializer = state
        .pointers
        .operations
        .values()
        .find_map(|operation| match *operation {
            PointerOperation::Initialize { ref value, .. } => Some(value.expression),
            _ => None,
        })
        .unwrap();
    assert!(matches!(
        state.pointers.expressions[initializer].kind,
        PointerExpressionKind::Array(_)
    ));
    for &local in state.pointers.cells.keys() {
        assert_eq!(plan.initializer(local), Some(initializer));
    }
}

#[test]
fn immutable_pointer_proof_falls_back_for_duplicate_root_initialization() {
    let (mut parser, mut function, state) = parsed_state();
    let index = operation_index(&function, &state, initialize);
    let duplicate = function.body[index].clone();
    function.body.push(duplicate, TEST_SPAN);
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_missing_root_initialization() {
    let (mut parser, mut function, state) = parsed_state();
    let index = operation_index(&function, &state, initialize);
    function.body.cull(index..index + 1);
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_duplicate_capture() {
    let (mut parser, mut function, state) = parsed_state();
    let index = operation_index(&function, &state, capture);
    let duplicate = function.body[index].clone();
    function.body.push(duplicate, TEST_SPAN);
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_missing_capture() {
    let (mut parser, mut function, state) = parsed_state();
    let index = operation_index(&function, &state, capture);
    function.body.cull(index..index + 1);
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_capture_before_initialization() {
    let (mut parser, mut function, state) = parsed_state();
    let initialized = operation_index(&function, &state, initialize);
    let captured = operation_index(&function, &state, capture);
    function.body.swap(initialized, captured);
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_nested_initialization() {
    let (mut parser, mut function, state) = parsed_state();
    let index = operation_index(&function, &state, initialize);
    function.body[index] =
        Statement::Block(crate::Block::from_vec(vec![function.body[index].clone()]));
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_const_qualification_loss() {
    let (mut parser, function, mut state) = parsed_state();
    let object = state
        .pointers
        .cells
        .iter()
        .find_map(|(&local, cell)| {
            matches!(cell.kind, PointerCellKind::Object { .. }).then_some(local)
        })
        .unwrap();
    state.pointers.cells.get_mut(&object).unwrap().is_const = true;
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_readonly_resource_with_mutable_pointer() {
    let (mut parser, function, state) = parsed_state();
    for (_, global) in parser.module.global_variables.iter_mut() {
        global.space = AddressSpace::Storage {
            access: StorageAccess::LOAD,
        };
    }
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_changed_pointee_type() {
    let (mut parser, function, mut state) = parsed_state();
    let object = state
        .pointers
        .cells
        .iter()
        .find_map(|(&local, cell)| {
            matches!(cell.kind, PointerCellKind::Object { .. }).then_some(local)
        })
        .unwrap();
    state.pointers.cells.get_mut(&object).unwrap().pointee = function.local_variables[object].ty;
    assert_fallback(&mut parser, &function, &state);
}

#[test]
fn immutable_pointer_proof_falls_back_for_unsupported_statements() {
    let (mut parser, mut function, state) = parsed_state();
    function.body.push(Statement::Kill, TEST_SPAN);
    assert_fallback(&mut parser, &function, &state);
}
