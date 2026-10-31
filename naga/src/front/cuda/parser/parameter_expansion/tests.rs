use super::*;

#[test]
fn value_cache_does_not_reserve_inline_reference_types() {
    assert!(size_of::<Option<CachedExpression>>() < size_of::<Option<MappedExpression>>());
}

#[test]
fn branch_cache_rematerializes_values_and_deferred_references() {
    let source = "__global__ void retained() {
        int values[2]{2, 3};
        int *pointer = values;
        int result = *pointer + 1;
    }";
    let span = Span::new(0, source.len() as u32);
    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
    assert!(matches!(
        parser.function_definition().unwrap(),
        FunctionKind::Kernel
    ));
    let mut context = parser.kernel_context.take().unwrap();
    let state = context.take_parameter_state();
    let function = context.ir;
    parser
        .validate_pointer_state(&state, &function, span)
        .unwrap();
    let local = function
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            let Expression::LocalVariable(local) = *expression else {
                return None;
            };
            (function.local_variables[local].name.as_deref() == Some("values")).then_some(handle)
        })
        .unwrap();
    let emitted = function
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            (matches!(
                expression,
                Expression::Binary {
                    op: BinaryOperator::Add,
                    ..
                }
            ) && !state.pointers.operation_markers.contains(&handle))
            .then_some(handle)
        })
        .unwrap();
    let deferred = function
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            let Expression::LocalVariable(local) = *expression else {
                return None;
            };
            state
                .pointers
                .validation_addresses
                .contains_key(&local)
                .then_some(handle)
        })
        .unwrap();
    parser.function = FunctionContext::new(FunctionKind::Device);
    parser.prepare_parameter_bindings(span).unwrap();
    let locals = parser
        .clone_invocation_locals(&function, Some(&state), span)
        .unwrap();
    let mut invocation = Invocation {
        source: &function,
        source_state: Some(&state),
        arguments: Vec::new(),
        expressions: alloc::vec![None; function.expressions.len()],
        mapped_handles: Vec::new(),
        locals,
        result: None,
        returned: None,
        span,
    };
    let checkpoint = invocation.checkpoint();
    let ((first_local, first_emitted, first_binding), _) = parser
        .capture_block(|parser| {
            let local = parser.invocation_value(&mut invocation, local)?;
            let emitted = parser.invocation_value(&mut invocation, emitted)?;
            let MappedExpression::Reference { binding, .. } =
                parser.invocation_expression(&mut invocation, deferred)?
            else {
                panic!("expected a deferred pointer reference");
            };
            Ok((local, emitted, binding))
        })
        .unwrap();
    invocation.restore(&mut parser, checkpoint).unwrap();
    assert!(invocation.expressions[local.index()].is_none());
    assert!(invocation.expressions[emitted.index()].is_none());
    assert!(invocation.expressions[deferred.index()].is_none());
    let ((second_local, second_emitted, second_binding), _) = parser
        .capture_block(|parser| {
            let local = parser.invocation_value(&mut invocation, local)?;
            let emitted = parser.invocation_value(&mut invocation, emitted)?;
            let MappedExpression::Reference { binding, .. } =
                parser.invocation_expression(&mut invocation, deferred)?
            else {
                panic!("expected a deferred pointer reference");
            };
            Ok((local, emitted, binding))
        })
        .unwrap();
    assert_eq!(
        parser.function.ir.expressions[first_local],
        parser.function.ir.expressions[second_local]
    );
    assert_ne!(first_local, second_local);
    assert_ne!(first_emitted, second_emitted);
    assert_ne!(first_binding, second_binding);
}
