use super::*;

impl Parser<'_> {
    pub(super) fn prepare_atomic_validation(
        &mut self,
        validation: &mut Module,
        order: &[Handle<Function>],
        span: Span,
    ) -> Result<(), ParseError> {
        if !self.has_atomics {
            return Ok(());
        }
        for &handle in order {
            let mut function = core::mem::take(&mut validation.functions[handle]);
            self.parameter_expansion_budget
                .charge_work(function.expressions.len(), span)?;
            let first_result = function
                .expressions
                .iter()
                .find_map(|(handle, expression)| {
                    matches!(*expression, Expression::AtomicResult { .. }).then_some(handle)
                });
            if let Some(first_result) = first_result {
                self.parameter_expansion_budget
                    .charge_work(function.expressions.len(), span)?;
                self.parameter_expansion_budget
                    .charge_slice::<TypeResolution>(function.expressions.len(), span)?;
                let mut types = crate::front::Typifier::new();
                types
                    .grow(
                        first_result,
                        &function.expressions,
                        &crate::proc::ResolveContext::with_locals(
                            validation,
                            &function.local_variables,
                            &function.arguments,
                        ),
                    )
                    .map_err(|_| expansion_error(span))?;
                self.prepare_atomic_validation_body(&mut function, validation, &types, span)?;
            }
            validation.functions[handle] = function;
        }
        Ok(())
    }

    fn prepare_atomic_validation_body(
        &mut self,
        function: &mut Function,
        validation: &Module,
        types: &crate::front::Typifier,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget
            .charge_slice::<&mut crate::Block>(1, span)?;
        let mut pending = alloc::vec![&mut function.body];
        while let Some(block) = pending.pop() {
            let source = core::mem::take(block);
            for (statement, span) in source.span_into_iter() {
                self.parameter_expansion_budget.charge_work(1, span)?;
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(Statement, Span)>(1, span)?;
                let statement = match statement {
                    Statement::Atomic {
                        pointer,
                        fun,
                        value,
                        result,
                    } => {
                        function
                            .expressions
                            .check_contains_handle(pointer)
                            .map_err(|_| expansion_error(span))?;
                        function
                            .expressions
                            .check_contains_handle(value)
                            .map_err(|_| expansion_error(span))?;
                        let scalar = match *types.get(pointer, &validation.types) {
                            TypeInner::Pointer { base, .. } => match validation.types[base].inner {
                                TypeInner::Scalar(scalar) => scalar,
                                _ => return Err(expansion_error(span)),
                            },
                            TypeInner::ValuePointer {
                                size: None, scalar, ..
                            } => scalar,
                            _ => return Err(expansion_error(span)),
                        };
                        if !super::super::atomics::supports_integer_atomic(fun)
                            || !matches!(scalar, Scalar::I32 | Scalar::U32)
                            || *types.get(value, &validation.types) != TypeInner::Scalar(scalar)
                        {
                            return Err(expansion_error(span));
                        }
                        if let Some(result) = result {
                            let expression = function
                                .expressions
                                .try_get(result)
                                .map_err(|_| expansion_error(span))?;
                            let &Expression::AtomicResult {
                                ty,
                                comparison: false,
                            } = expression
                            else {
                                return Err(expansion_error(span));
                            };
                            validation
                                .types
                                .check_contains_handle(ty)
                                .map_err(|_| expansion_error(span))?;
                            if validation.types[ty].inner != TypeInner::Scalar(scalar) {
                                return Err(expansion_error(span));
                            }
                            function.expressions[result] = Expression::Load { pointer };
                            self.parameter_expansion_budget.charge_nodes(1, span)?;
                            self.parameter_expansion_budget
                                .charge_slice::<(Statement, Span)>(1, span)?;
                            block.push(
                                Statement::Emit(crate::Range::new_from_bounds(result, result)),
                                span,
                            );
                        }
                        Statement::Store { pointer, value }
                    }
                    statement => statement,
                };
                block.push(statement, span);
            }
            for statement in block.iter_mut() {
                self.parameter_expansion_budget.charge_work(1, span)?;
                let mut child = |body| -> Result<(), ParseError> {
                    self.parameter_expansion_budget
                        .charge_slice::<&mut crate::Block>(1, span)?;
                    pending.push(body);
                    Ok(())
                };
                match *statement {
                    Statement::Block(ref mut body) => child(body)?,
                    Statement::If {
                        ref mut accept,
                        ref mut reject,
                        ..
                    } => {
                        child(accept)?;
                        child(reject)?;
                    }
                    Statement::Switch { ref mut cases, .. } => {
                        for case in cases {
                            child(&mut case.body)?;
                        }
                    }
                    Statement::Loop {
                        ref mut body,
                        ref mut continuing,
                        ..
                    } => {
                        child(body)?;
                        child(continuing)?;
                    }
                    _ => {}
                }
            }
        }
        Ok(())
    }
}
