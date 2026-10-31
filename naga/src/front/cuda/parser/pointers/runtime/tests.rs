use alloc::vec;

use super::*;

const TEST_SPAN: Span = Span::new(7, 19);

fn parsed_state(source: &'static str) -> (Parser<'static>, Function, FunctionParameterState) {
    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
    assert!(matches!(
        parser.function_definition().unwrap(),
        FunctionKind::Kernel
    ));
    let mut context = parser.kernel_context.take().unwrap();
    let state = context.take_parameter_state();
    (parser, context.ir, state)
}

fn install_destination(
    parser: &mut Parser<'_>,
    function: &Function,
    source: &FunctionParameterState,
    runtime: &PointerRuntime,
) {
    parser.function.ir = function.clone();
    parser.function.ir.body = crate::Block::new();
    for &local in source.pointers.cells.keys() {
        parser.function.ir.local_variables[local].ty = runtime.state_type;
    }
    parser.function.expression_graph_depths = source.expression_graph_depths.clone();
    parser.function.emitter = crate::proc::Emitter::default();
    parser
        .function
        .emitter
        .start(&parser.function.ir.expressions);
}

#[derive(Default)]
struct IdentityMapper {
    mapped: Vec<Handle<Expression>>,
    restored: Vec<usize>,
}

impl PointerRemapper for IdentityMapper {
    fn expression(
        &mut self,
        _parser: &mut Parser<'_>,
        source: Handle<Expression>,
    ) -> Result<MappedExpression, ParseError> {
        self.mapped.push(source);
        Ok(MappedExpression::Value(source))
    }

    fn parameter(&self, _index: u32) -> Result<PointerValue, ParseError> {
        Err(runtime_error(TEST_SPAN))
    }

    fn checkpoint(&self) -> usize {
        self.mapped.len()
    }

    fn restore(&mut self, _parser: &mut Parser<'_>, checkpoint: usize) -> Result<(), ParseError> {
        assert!(checkpoint <= self.mapped.len());
        self.mapped.truncate(checkpoint);
        self.restored.push(checkpoint);
        Ok(())
    }
}

#[test]
fn assignment_cycles_close_over_distinct_allocations() {
    let (mut parser, function, source) = parsed_state(
        "__global__ void retained() {
            int first[3]{2, 3, 5}, second[3]{7, 11, 13};
            int *left = first;
            int *right = second;
            left = right;
            right = left;
        }",
    );
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    assert_eq!(runtime.families.len(), 2);
    assert_ne!(runtime.families[0].root, runtime.families[1].root);
    assert_eq!(runtime.coordinate_count, 0);
    for families in runtime.cell_families.values() {
        assert_eq!(families.len(), 2);
        assert!(families.contains(&0));
        assert!(families.contains(&1));
    }
}

#[test]
fn direct_array_origin_accepts_the_existing_expression_depth_limit() {
    let (mut parser, function, mut source) = parsed_state(
        "__global__ void retained() {
            int values[2]{2, 3};
            unsigned int amount = threadIdx.x;
            int *pointer = values;
        }",
    );
    let amount = function
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            let Expression::LocalVariable(local) = *expression else {
                return None;
            };
            (function.local_variables[local].name.as_deref() == Some("amount")).then_some(handle)
        })
        .unwrap();
    let marker = *source.pointers.operations.keys().next().unwrap();
    let PointerOperation::Initialize { ref value, .. } = source.pointers.operations[&marker] else {
        unreachable!()
    };
    let mut expression = value.expression;
    let pointee = source.pointers.expressions[expression].pointee;
    assert_eq!(source.pointers.expressions[expression].depth, 1);
    for depth in 2..=64 {
        expression = source.pointers.expressions.append(
            PointerExpression {
                kind: PointerExpressionKind::Offset {
                    base: expression,
                    offset: amount,
                    subtract: false,
                },
                pointee,
                depth,
            },
            TEST_SPAN,
        );
    }
    let PointerOperation::Initialize { ref mut value, .. } =
        *source.pointers.operations.get_mut(&marker).unwrap()
    else {
        unreachable!()
    };
    value.expression = expression;
    parser
        .validate_pointer_state(&source, &function, TEST_SPAN)
        .unwrap();
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    assert_eq!(runtime.families.len(), 1);
}

#[test]
fn dynamic_ancestor_coordinates_do_not_split_families() {
    let (mut parser, mut function, mut source) = parsed_state(
        "__global__ void retained() {
            int matrix[3][2]{{2, 3}, {5, 7}, {11, 13}};
            unsigned int row = threadIdx.x;
            int *first = &matrix[row][0];
            row += 1;
            int *second = &matrix[row][1];
        }",
    );
    let root = source
        .bound_addresses
        .iter()
        .find_map(|(_, address)| {
            let Expression::LocalVariable(local) = function.expressions[address.root] else {
                return None;
            };
            (function.local_variables[local].name.as_deref() == Some("matrix"))
                .then_some(address.root)
        })
        .unwrap();
    let alias = function
        .expressions
        .append(function.expressions[root].clone(), TEST_SPAN);
    let address = source
        .bound_addresses
        .iter()
        .find_map(|(handle, address)| (address.root == root).then_some(handle))
        .unwrap();
    source.bound_addresses[address].root = alias;
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    let pointee = source.pointers.cells.values().next().unwrap().pointee;
    let scalar_families: Vec<_> = runtime
        .families
        .iter()
        .enumerate()
        .filter(|&(_, family)| family.pointee == pointee)
        .collect();
    assert_eq!(scalar_families.len(), 1);
    let (tag, family) = scalar_families[0];
    assert_eq!(family.kind, OriginKind::Array);
    assert_eq!(family.projections, vec![OriginProjection::Index]);
    assert_eq!(runtime.coordinate_count, 1);
    assert!(runtime
        .cell_families
        .values()
        .all(|families| families == &[tag as u32]));
}

#[test]
fn large_element_offsets_are_copied_without_byte_scaling() {
    let (mut parser, function, source) = parsed_state(
        "__global__ void retained() {
            int4 values[4];
            unsigned int index = 4294967294u;
            int4 *pointer = &values[index];
        }",
    );
    assert!(function.expressions.iter().any(|(_, expression)| {
        matches!(expression, Expression::Literal(Literal::U32(0xffff_fffe)))
    }));
    let operation = source
        .pointers
        .operations
        .values()
        .find(|operation| matches!(operation, PointerOperation::Initialize { .. }))
        .unwrap();
    let PointerOperation::Initialize {
        destination,
        ref value,
    } = *operation
    else {
        unreachable!()
    };
    let PointerExpressionKind::Offset {
        offset: captured_index,
        ..
    } = source.pointers.expressions[value.expression].kind
    else {
        panic!("expected an element offset");
    };
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    assert_eq!(runtime.coordinate_count, 0);
    install_destination(&mut parser, &function, &source, &runtime);
    let first_expression = parser.function.ir.expressions.len();
    runtime
        .lower_operation(
            &mut parser,
            &source,
            operation,
            &mut IdentityMapper::default(),
            TEST_SPAN,
        )
        .unwrap();
    let state = source.pointers.cells[&destination].expression;
    let stored_position = parser
        .function
        .ir
        .body
        .iter()
        .filter_map(|statement| {
            let Statement::Store { pointer, value } = *statement else {
                return None;
            };
            matches!(
                parser.function.ir.expressions[pointer],
                Expression::AccessIndex { base, index: 1 } if base == state
            )
            .then_some(value)
        })
        .next_back();
    let position = stored_position.unwrap();
    let Expression::Binary {
        op: BinaryOperator::Add,
        right,
        ..
    } = parser.function.ir.expressions[position]
    else {
        panic!("expected an element offset addition");
    };
    assert!(matches!(
        parser.function.ir.expressions[right],
        Expression::Load { pointer } if pointer == captured_index
    ));
    assert!(!parser
        .function
        .ir
        .expressions
        .iter()
        .skip(first_expression)
        .any(|(_, expression)| matches!(
            expression,
            Expression::Binary {
                op: BinaryOperator::Multiply,
                ..
            }
        )));
}

#[test]
fn nested_pointer_selection_restores_each_branch_mapping() {
    let (mut parser, function, source) = parsed_state(
        "__global__ void retained() {
            int first[2]{2, 3}, second[2]{5, 7};
            bool choose = bool(threadIdx.x);
            int *pointer = first;
            pointer = choose ? (choose ? first + 0 : second + 0) : second + 0;
        }",
    );
    let operation = source
        .pointers
        .operations
        .values()
        .find(|operation| matches!(operation, PointerOperation::Assign { .. }))
        .unwrap();
    let PointerOperation::Assign { ref value, .. } = *operation else {
        unreachable!()
    };
    let PointerExpressionKind::Select {
        selector, accept, ..
    } = source.pointers.expressions[value.expression].kind
    else {
        panic!("expected an outer pointer selection");
    };
    let PointerExpressionKind::Select {
        selector: nested_selector,
        ..
    } = source.pointers.expressions[accept].kind
    else {
        panic!("expected a nested pointer selection");
    };
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    install_destination(&mut parser, &function, &source, &runtime);
    let mut mapper = IdentityMapper::default();
    runtime
        .lower_operation(&mut parser, &source, operation, &mut mapper, TEST_SPAN)
        .unwrap();
    assert!(mapper.mapped.contains(&selector));
    assert!(!mapper.mapped.contains(&nested_selector));
    for family in &runtime.families {
        assert!(!mapper.mapped.contains(&family.root_expression));
    }
}

#[test]
fn runtime_rejects_a_scalar_mapped_pointer_cell() {
    let (mut parser, function, source) = parsed_state(
        "__global__ void retained() {
            int values[2]{2, 3};
            int *pointer = values;
        }",
    );
    let runtime = PointerRuntime::new(&mut parser, &function, &source, TEST_SPAN).unwrap();
    let (&cell, _) = source.pointers.cells.iter().next().unwrap();
    parser.function.ir = function;
    let error = runtime
        .cell_pointer(
            &mut parser,
            &source,
            cell,
            &mut IdentityMapper::default(),
            TEST_SPAN,
        )
        .unwrap_err();
    assert_eq!(error.message, "invalid CUDA runtime pointer state");
    assert_eq!(error.span, TEST_SPAN);
}
