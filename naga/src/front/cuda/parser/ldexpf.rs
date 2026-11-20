use super::*;

impl Parser<'_> {
    pub(super) fn lower_ldexpf_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let value = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let exponent = self.convert_scalar(arguments.next().unwrap().into(), Scalar::I32)?;
        let bits = self.bitcast_scalar(value.handle, Scalar::U32, span)?;
        let result = self.call_ldexpf_bits(bits, exponent.handle, span)?;
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

    pub(super) fn call_ldexpf_bits(
        &mut self,
        bits: Handle<Expression>,
        exponent: Handle<Expression>,
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
        let function = self.cached_ldexpf_function(span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![bits, exponent],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_ldexpf_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.ldexpf_function {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_ldexpf_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        self.ldexpf_function = Some(function);
        Ok(function)
    }

    fn build_ldexpf_function(&mut self, span: Span) -> Result<(), ParseError> {
        use crate::MathFunction as Math;
        use BinaryOperator as Op;

        self.prepare_parameter_bindings(span)?;
        let name = "_naga_ldexpf";
        let arguments = [("bits", Scalar::U32), ("exponent", Scalar::I32)];
        self.parameter_expansion_budget
            .charge_nodes(arguments.len(), span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(arguments.len(), span)?;
        self.parameter_expansion_budget.charge_bytes(
            name.len() + arguments.iter().map(|&(name, _)| name.len()).sum::<usize>(),
            span,
        )?;
        self.function.ir.name = Some(String::from(name));
        for (name, scalar) in arguments {
            let ty = Type {
                name: None,
                inner: TypeInner::Scalar(scalar),
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
            self.function.ir.arguments.push(FunctionArgument {
                name: Some(String::from(name)),
                ty,
                binding: None,
            });
        }
        self.function.ir.result = Some(crate::FunctionResult {
            ty: self.function.ir.arguments[0].ty,
            binding: None,
        });

        let literal = |parser: &mut Self, value| parser.append(Expression::Literal(value), span);
        let binary = |parser: &mut Self, op, left, right| {
            parser.append(Expression::Binary { op, left, right }, span)
        };
        let convert =
            |parser: &mut Self, expr, target| parser.append(Expression::As { expr, target }, span);
        let math = |parser: &mut Self, fun, arg, arg1, arg2| {
            parser.append(
                Expression::Math {
                    fun,
                    arg,
                    arg1,
                    arg2,
                    arg3: None,
                },
                span,
            )
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

        let bits = self.append(Expression::FunctionArgument(0), span)?;
        let exponent = self.append(Expression::FunctionArgument(1), span)?;
        let zero = literal(self, Literal::U32(0))?;
        let one = literal(self, Literal::U32(1))?;
        let signed_one = literal(self, Literal::I32(1))?;
        let exponent_shift = literal(self, Literal::U32(23))?;
        let magnitude_mask = literal(self, Literal::U32(0x7fff_ffff))?;
        let fraction_mask = literal(self, Literal::U32(0x007f_ffff))?;
        let implicit_bit = literal(self, Literal::U32(0x0080_0000))?;
        let sign_mask = literal(self, Literal::U32(0x8000_0000))?;
        let infinity = literal(self, Literal::U32(0x7f80_0000))?;
        let quiet_nan = literal(self, Literal::U32(0x7fc0_0000))?;
        let magnitude = binary(self, Op::And, bits, magnitude_mask)?;
        let sign = binary(self, Op::And, bits, sign_mask)?;
        let is_nan = binary(self, Op::Greater, magnitude, infinity)?;
        return_if(self, is_nan, quiet_nan)?;
        let is_zero = binary(self, Op::Equal, magnitude, zero)?;
        let is_infinite = binary(self, Op::Equal, magnitude, infinity)?;
        let zero_or_infinite = binary(self, Op::LogicalOr, is_zero, is_infinite)?;
        return_if(self, zero_or_infinite, bits)?;

        // Shift the leading bit of a subnormal to position 23. Normals need no shift.
        let leading_zeros = math(self, Math::CountLeadingZeros, magnitude, None, None)?;
        let normal_leading_zeros = literal(self, Literal::U32(8))?;
        let leading_zeros = math(
            self,
            Math::Max,
            leading_zeros,
            Some(normal_leading_zeros),
            None,
        )?;
        let normalize = binary(self, Op::Subtract, leading_zeros, normal_leading_zeros)?;
        let normalized = binary(self, Op::ShiftLeft, magnitude, normalize)?;
        let fraction = binary(self, Op::And, normalized, fraction_mask)?;
        let significand = binary(self, Op::InclusiveOr, fraction, implicit_bit)?;
        let biased = binary(self, Op::ShiftRight, magnitude, exponent_shift)?;
        let biased = convert(self, biased, Scalar::I32)?;
        let biased = math(self, Math::Max, biased, Some(signed_one), None)?;
        let normalize = convert(self, normalize, Scalar::I32)?;
        let biased = binary(self, Op::Subtract, biased, normalize)?;

        // The clamped extremes still force underflow or overflow for any finite input.
        let min_scale = literal(self, Literal::I32(-512))?;
        let max_scale = literal(self, Literal::I32(512))?;
        let exponent = math(
            self,
            Math::Clamp,
            exponent,
            Some(min_scale),
            Some(max_scale),
        )?;
        let scaled = binary(self, Op::Add, biased, exponent)?;
        let infinity_exponent = literal(self, Literal::I32(255))?;
        let overflow = binary(self, Op::GreaterEqual, scaled, infinity_exponent)?;
        let signed_infinity = binary(self, Op::InclusiveOr, infinity, sign)?;
        return_if(self, overflow, signed_infinity)?;

        let normal = binary(self, Op::GreaterEqual, scaled, signed_one)?;
        let scaled_bits = convert(self, scaled, Scalar::U32)?;
        let exponent_bits = binary(self, Op::ShiftLeft, scaled_bits, exponent_shift)?;
        let normal_bits = binary(self, Op::InclusiveOr, exponent_bits, fraction)?;
        let normal_bits = binary(self, Op::InclusiveOr, normal_bits, sign)?;
        return_if(self, normal, normal_bits)?;

        // Keep only significant shifts. A 24-bit significand shifted by 25 rounds to zero.
        let distance = binary(self, Op::Subtract, signed_one, scaled)?;
        let max_distance = literal(self, Literal::I32(25))?;
        let distance = math(
            self,
            Math::Clamp,
            distance,
            Some(signed_one),
            Some(max_distance),
        )?;
        let distance = convert(self, distance, Scalar::U32)?;
        let whole = binary(self, Op::ShiftRight, significand, distance)?;
        let limit = binary(self, Op::ShiftLeft, one, distance)?;
        let mask = binary(self, Op::Subtract, limit, one)?;
        let discarded = binary(self, Op::And, significand, mask)?;
        let half = binary(self, Op::ShiftRight, limit, one)?;
        let above_half = binary(self, Op::Greater, discarded, half)?;
        let tie = binary(self, Op::Equal, discarded, half)?;
        let low_bit = binary(self, Op::And, whole, one)?;
        let odd = binary(self, Op::NotEqual, low_bit, zero)?;
        let odd_tie = binary(self, Op::LogicalAnd, tie, odd)?;
        let round_up = binary(self, Op::LogicalOr, above_half, odd_tie)?;
        let increment = self.append(
            Expression::Select {
                condition: round_up,
                accept: one,
                reject: zero,
            },
            span,
        )?;
        let rounded = binary(self, Op::Add, whole, increment)?;
        let result = binary(self, Op::InclusiveOr, rounded, sign)?;
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
