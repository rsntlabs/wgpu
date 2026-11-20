use super::*;

impl Parser<'_> {
    pub(super) fn lower_nextafterf_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let from = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let toward = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let from_bits = self.bitcast_scalar(from.handle, Scalar::U32, span)?;
        let toward_bits = self.bitcast_scalar(toward.handle, Scalar::U32, span)?;
        let result = self.call_nextafterf_bits(from_bits, toward_bits, span)?;
        let handle = self.bitcast_scalar(result, Scalar::F32, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty: scalar_resolution(Scalar::F32),
            span,
        }
        .into())
    }

    pub(super) fn call_nextafterf_bits(
        &mut self,
        from_bits: Handle<Expression>,
        toward_bits: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(2, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_nextafterf_function(span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![from_bits, toward_bits],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_nextafterf_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.nextafterf_function {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_nextafterf_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        self.nextafterf_function = Some(function);
        Ok(function)
    }

    fn build_nextafterf_function(&mut self, span: Span) -> Result<(), ParseError> {
        use BinaryOperator as Op;

        self.prepare_parameter_bindings(span)?;
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(Scalar::U32),
        };
        let ty = match self.module.types.get(&ty) {
            Some(handle) => handle,
            None => {
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(Type, Span)>(1, span)?;
                self.module.types.insert(ty, span)
            }
        };
        let name = "_naga_nextafterf";
        let arguments = ["from_bits", "toward_bits"];
        self.parameter_expansion_budget
            .charge_nodes(arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(arguments.len(), span)?;
        self.parameter_expansion_budget.charge_bytes(
            name.len() + arguments.iter().map(|name| name.len()).sum::<usize>(),
            span,
        )?;
        self.function.ir.name = Some(String::from(name));
        for name in arguments {
            self.function.ir.arguments.push(FunctionArgument {
                name: Some(String::from(name)),
                ty,
                binding: None,
            });
        }
        self.function.ir.result = Some(crate::FunctionResult { ty, binding: None });

        let literal = |parser: &mut Self, value| {
            parser.append(Expression::Literal(Literal::U32(value)), span)
        };
        let binary = |parser: &mut Self, op, left, right| {
            parser.append(Expression::Binary { op, left, right }, span)
        };
        let return_if = |parser: &mut Self, condition, value| -> Result<(), ParseError> {
            parser.parameter_expansion_budget.charge_nodes(2, span)?;
            parser
                .parameter_expansion_budget
                .charge_slice::<(Statement, Span)>(2, span)?;
            let mut accept = crate::Block::new();
            accept.push(Statement::Return { value: Some(value) }, span);
            parser.push_statement(
                Statement::If {
                    condition,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            );
            Ok(())
        };

        let from = self.append(Expression::FunctionArgument(0), span)?;
        let toward = self.append(Expression::FunctionArgument(1), span)?;
        let zero = literal(self, 0)?;
        let one = literal(self, 1)?;
        let sign_mask = literal(self, 0x8000_0000)?;
        let magnitude_mask = literal(self, 0x7fff_ffff)?;
        let infinity = literal(self, 0x7f80_0000)?;
        let quiet_nan = literal(self, 0x7fc0_0000)?;

        let from_magnitude = binary(self, Op::And, from, magnitude_mask)?;
        let toward_magnitude = binary(self, Op::And, toward, magnitude_mask)?;
        let from_nan = binary(self, Op::Greater, from_magnitude, infinity)?;
        let toward_nan = binary(self, Op::Greater, toward_magnitude, infinity)?;
        let either_nan = binary(self, Op::LogicalOr, from_nan, toward_nan)?;
        return_if(self, either_nan, quiet_nan)?;

        let from_zero = binary(self, Op::Equal, from_magnitude, zero)?;
        let toward_zero = binary(self, Op::Equal, toward_magnitude, zero)?;
        let both_zero = binary(self, Op::LogicalAnd, from_zero, toward_zero)?;
        let same_bits = binary(self, Op::Equal, from, toward)?;
        let equal = binary(self, Op::LogicalOr, both_zero, same_bits)?;
        return_if(self, equal, toward)?;

        let toward_sign = binary(self, Op::And, toward, sign_mask)?;
        let smallest = binary(self, Op::InclusiveOr, toward_sign, one)?;
        return_if(self, from_zero, smallest)?;

        // The encoding advances in magnitude within each sign.
        let differing_bits = binary(self, Op::ExclusiveOr, from, toward)?;
        let same_sign = binary(self, Op::Less, differing_bits, sign_mask)?;
        let larger_magnitude = binary(self, Op::Greater, toward_magnitude, from_magnitude)?;
        let away_from_zero = binary(self, Op::LogicalAnd, same_sign, larger_magnitude)?;
        let incremented = binary(self, Op::Add, from, one)?;
        let decremented = binary(self, Op::Subtract, from, one)?;
        let result = self.append(
            Expression::Select {
                condition: away_from_zero,
                accept: incremented,
                reject: decremented,
            },
            span,
        )?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
        Ok(())
    }
}
