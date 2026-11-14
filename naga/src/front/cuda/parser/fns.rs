use super::*;

impl Parser<'_> {
    pub(super) fn call_fns(
        &mut self,
        mask: Handle<Expression>,
        base: Handle<Expression>,
        offset: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(3, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_fns_function(span)?;
        let result = self.append_call_result(function, span)?;
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![mask, base, offset],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_fns_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.fns_function {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_fns_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        self.fns_function = Some(function);
        Ok(function)
    }

    fn build_fns_function(&mut self, span: Span) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let unsigned = self.fns_type(Scalar::U32, span)?;
        let signed = self.fns_type(Scalar::I32, span)?;
        let name = "_naga_fns";
        let arguments = [("mask", unsigned), ("base", unsigned), ("offset", signed)];
        self.parameter_expansion_budget
            .charge_nodes(arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(arguments.len(), span)?;
        self.parameter_expansion_budget.charge_bytes(
            name.len() + arguments.iter().map(|&(name, _)| name.len()).sum::<usize>(),
            span,
        )?;
        self.function.ir.name = Some(String::from(name));
        for (name, ty) in arguments {
            self.function.ir.arguments.push(FunctionArgument {
                name: Some(String::from(name)),
                ty,
                binding: None,
            });
        }
        self.function.ir.result = Some(crate::FunctionResult {
            ty: unsigned,
            binding: None,
        });
        let mask = self.append(Expression::FunctionArgument(0), span)?;
        let base = self.append(Expression::FunctionArgument(1), span)?;
        let offset = self.append(Expression::FunctionArgument(2), span)?;
        let last = self.append(Expression::Literal(Literal::U32(31)), span)?;
        let sentinel = self.append(Expression::Literal(Literal::U32(u32::MAX)), span)?;
        let invalid_base = self.fns_binary(BinaryOperator::Greater, base, last, span)?;
        self.fns_return_if(invalid_base, sentinel, span);
        let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let one = self.append(Expression::Literal(Literal::U32(1)), span)?;
        let safe_base = self.fns_binary(BinaryOperator::And, base, last, span)?;
        let base_word = self.fns_binary(BinaryOperator::ShiftRight, mask, safe_base, span)?;
        let base_bit = self.fns_binary(BinaryOperator::And, base_word, one, span)?;
        let base_set = self.fns_binary(BinaryOperator::NotEqual, base_bit, zero, span)?;
        let base_result = self.append(
            Expression::Select {
                condition: base_set,
                accept: base,
                reject: sentinel,
            },
            span,
        )?;
        let signed_zero = self.append(Expression::Literal(Literal::I32(0)), span)?;
        let is_zero = self.fns_binary(BinaryOperator::Equal, offset, signed_zero, span)?;
        self.fns_return_if(is_zero, base_result, span);
        let positive = self.fns_binary(BinaryOperator::Greater, offset, signed_zero, span)?;
        let forward = self.append(Expression::Literal(Literal::I32(1)), span)?;
        let backward = self.append(Expression::Literal(Literal::I32(-1)), span)?;
        let direction = self.append(
            Expression::Select {
                condition: positive,
                accept: forward,
                reject: backward,
            },
            span,
        )?;
        let position = self.fns_local("position", signed, span)?;
        let remaining = self.fns_local("remaining", signed, span)?;
        let initial_position = self.append(
            Expression::As {
                expr: safe_base,
                target: Scalar::I32,
            },
            span,
        )?;
        self.push_statement(
            Statement::Store {
                pointer: position,
                value: initial_position,
            },
            span,
        );
        self.push_statement(
            Statement::Store {
                pointer: remaining,
                value: offset,
            },
            span,
        );
        let signed_last = self.append(Expression::Literal(Literal::I32(31)), span)?;
        let ((), body) = self.capture_block(|parser| {
            let current = parser.append(Expression::Load { pointer: position }, span)?;
            let below = parser.fns_binary(BinaryOperator::Less, current, signed_zero, span)?;
            let above = parser.fns_binary(BinaryOperator::Greater, current, signed_last, span)?;
            let finished = parser.fns_binary(BinaryOperator::LogicalOr, below, above, span)?;
            let mut accept = crate::Block::new();
            accept.push(Statement::Break, span);
            parser.push_statement(
                Statement::If {
                    condition: finished,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            );
            let current_unsigned = parser.append(
                Expression::As {
                    expr: current,
                    target: Scalar::U32,
                },
                span,
            )?;
            let shift = parser.fns_binary(BinaryOperator::And, current_unsigned, last, span)?;
            let word = parser.fns_binary(BinaryOperator::ShiftRight, mask, shift, span)?;
            let bit = parser.fns_binary(BinaryOperator::And, word, one, span)?;
            let is_set = parser.fns_binary(BinaryOperator::NotEqual, bit, zero, span)?;
            let ((), accept) = parser.capture_block(|parser| {
                let rank = parser.append(Expression::Load { pointer: remaining }, span)?;
                let found = parser.fns_binary(BinaryOperator::Equal, rank, direction, span)?;
                parser.fns_return_if(found, current_unsigned, span);
                // Moving a nonzero rank toward its sign avoids negating INT_MIN.
                let next_rank =
                    parser.fns_binary(BinaryOperator::Subtract, rank, direction, span)?;
                parser.push_statement(
                    Statement::Store {
                        pointer: remaining,
                        value: next_rank,
                    },
                    span,
                );
                Ok(())
            })?;
            parser.push_statement(
                Statement::If {
                    condition: is_set,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            );
            let next = parser.fns_binary(BinaryOperator::Add, current, direction, span)?;
            parser.push_statement(
                Statement::Store {
                    pointer: position,
                    value: next,
                },
                span,
            );
            Ok(())
        })?;
        self.push_statement(
            Statement::Loop {
                body,
                continuing: crate::Block::new(),
                break_if: None,
            },
            span,
        );
        self.push_statement(
            Statement::Return {
                value: Some(sentinel),
            },
            span,
        );
        Ok(())
    }

    fn fns_type(&mut self, scalar: Scalar, span: Span) -> Result<Handle<Type>, ParseError> {
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(scalar),
        };
        if let Some(handle) = self.module.types.get(&ty) {
            return Ok(handle);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Type, Span)>(1, span)?;
        Ok(self.module.types.insert(ty, span))
    }

    fn fns_local(
        &mut self,
        name: &str,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(LocalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        let local = self.function.ir.local_variables.append(
            LocalVariable {
                name: Some(String::from(name)),
                ty,
                init: None,
            },
            span,
        );
        self.append(Expression::LocalVariable(local), span)
    }

    fn fns_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn fns_return_if(
        &mut self,
        condition: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) {
        let mut accept = crate::Block::new();
        accept.push(Statement::Return { value: Some(value) }, span);
        self.push_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        );
    }
}
