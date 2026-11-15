use super::*;

impl Parser<'_> {
    pub(super) fn lower_frsqrt_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let input =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
        let input = self.bitcast_scalar(input.handle, Scalar::U32, span)?;
        let bits = self.call_frsqrt_rn_bits(input, span)?;
        let handle = self.bitcast_scalar(bits, Scalar::F32, span)?;
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

    pub(super) fn call_frsqrt_rn_bits(
        &mut self,
        input: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_frsqrt_rn_function(span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![input],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_frsqrt_rn_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.frsqrt_rn_function {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_frsqrt_rn_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        self.frsqrt_rn_function = Some(function);
        Ok(function)
    }

    fn build_frsqrt_rn_function(&mut self, span: Span) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(Scalar::U32),
        };
        let unsigned = match self.module.types.get(&ty) {
            Some(handle) => handle,
            None => {
                self.parameter_expansion_budget.charge_nodes(1, span)?;
                self.parameter_expansion_budget
                    .charge_slice::<(Type, Span)>(1, span)?;
                self.module.types.insert(ty, span)
            }
        };
        let name = "_naga_frsqrt_rn";
        let argument_name = "input_bits";
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len() + argument_name.len(), span)?;
        self.function.ir.name = Some(String::from(name));
        self.function.ir.arguments.push(FunctionArgument {
            name: Some(String::from(argument_name)),
            ty: unsigned,
            binding: None,
        });
        self.function.ir.result = Some(crate::FunctionResult {
            ty: unsigned,
            binding: None,
        });
        let input = self.append(Expression::FunctionArgument(0), span)?;
        let zero = self.frsqrt_literal(0, span)?;
        let one = self.frsqrt_literal(1, span)?;
        let magnitude_mask = self.frsqrt_literal(0x7fff_ffff, span)?;
        let sign_mask = self.frsqrt_literal(0x8000_0000, span)?;
        let infinity = self.frsqrt_literal(0x7f80_0000, span)?;
        let nan = self.frsqrt_literal(0x7fc0_0000, span)?;
        let magnitude = self.frsqrt_binary(BinaryOperator::And, input, magnitude_mask, span)?;
        let sign = self.frsqrt_binary(BinaryOperator::And, input, sign_mask, span)?;
        let is_zero = self.frsqrt_binary(BinaryOperator::Equal, magnitude, zero, span)?;
        let signed_infinity =
            self.frsqrt_binary(BinaryOperator::InclusiveOr, sign, infinity, span)?;
        self.frsqrt_return_if(is_zero, signed_infinity, span)?;
        let negative = self.frsqrt_binary(BinaryOperator::NotEqual, sign, zero, span)?;
        let is_nan = self.frsqrt_binary(BinaryOperator::Greater, magnitude, infinity, span)?;
        let invalid = self.frsqrt_binary(BinaryOperator::LogicalOr, negative, is_nan, span)?;
        self.frsqrt_return_if(invalid, nan, span)?;
        let is_infinite = self.frsqrt_binary(BinaryOperator::Equal, magnitude, infinity, span)?;
        self.frsqrt_return_if(is_infinite, zero, span)?;

        let width = self.frsqrt_literal(23, span)?;
        let fraction_mask = self.frsqrt_literal(0x007f_ffff, span)?;
        let implicit = self.frsqrt_literal(0x0080_0000, span)?;
        let exponent = self.frsqrt_binary(BinaryOperator::ShiftRight, magnitude, width, span)?;
        let fraction = self.frsqrt_binary(BinaryOperator::And, magnitude, fraction_mask, span)?;
        let normal = self.frsqrt_binary(BinaryOperator::NotEqual, exponent, zero, span)?;
        let normal_significand =
            self.frsqrt_binary(BinaryOperator::InclusiveOr, fraction, implicit, span)?;
        let nonzero_fraction =
            self.frsqrt_binary(BinaryOperator::InclusiveOr, fraction, one, span)?;
        let clz = self.frsqrt_clz(nonzero_fraction, span)?;
        let eight = self.frsqrt_literal(8, span)?;
        let shift = self.frsqrt_binary(BinaryOperator::Subtract, clz, eight, span)?;
        let last = self.frsqrt_literal(31, span)?;
        let safe_shift = self.frsqrt_binary(BinaryOperator::And, shift, last, span)?;
        let subnormal_significand =
            self.frsqrt_binary(BinaryOperator::ShiftLeft, fraction, safe_shift, span)?;
        let significand =
            self.frsqrt_select(normal, normal_significand, subnormal_significand, span)?;
        let zero_signed = self.frsqrt_signed_literal(0, span)?;
        let one_signed = self.frsqrt_signed_literal(1, span)?;
        let exponent_signed = self.frsqrt_cast(exponent, Scalar::I32, span)?;
        let shift_signed = self.frsqrt_cast(shift, Scalar::I32, span)?;
        let subnormal_exponent =
            self.frsqrt_binary(BinaryOperator::Subtract, one_signed, shift_signed, span)?;
        let exponent = self.frsqrt_select(normal, exponent_signed, subnormal_exponent, span)?;
        let bias = self.frsqrt_signed_literal(127, span)?;
        let unbiased = self.frsqrt_binary(BinaryOperator::Subtract, exponent, bias, span)?;
        let incremented = self.frsqrt_binary(BinaryOperator::Add, unbiased, one_signed, span)?;
        let negated = self.append(
            Expression::Unary {
                op: UnaryOperator::Negate,
                expr: incremented,
            },
            span,
        )?;
        let result_exponent = self.frsqrt_binary(BinaryOperator::ShiftRight, negated, one, span)?;
        let parity = self.frsqrt_binary(BinaryOperator::And, unbiased, one_signed, span)?;
        let even = self.frsqrt_binary(BinaryOperator::Equal, parity, zero_signed, span)?;
        let power_of_two =
            self.frsqrt_binary(BinaryOperator::Equal, significand, implicit, span)?;
        let exact_power =
            self.frsqrt_binary(BinaryOperator::LogicalAnd, even, power_of_two, span)?;
        let correction = self.frsqrt_cast(exact_power, Scalar::I32, span)?;
        let result_exponent =
            self.frsqrt_binary(BinaryOperator::Add, result_exponent, correction, span)?;
        let two_signed = self.frsqrt_signed_literal(2, span)?;
        let twice_exponent =
            self.frsqrt_binary(BinaryOperator::Multiply, result_exponent, two_signed, span)?;
        let power_bias = self.frsqrt_signed_literal(198, span)?;
        let power = self.frsqrt_binary(BinaryOperator::Subtract, power_bias, exponent, span)?;
        let power = self.frsqrt_binary(BinaryOperator::Subtract, power, twice_exponent, span)?;
        let power = self.frsqrt_cast(power, Scalar::U32, span)?;
        let q = self.frsqrt_local("significand", unsigned, span)?;
        let bit = self.frsqrt_local("trial_bit", unsigned, span)?;
        self.frsqrt_statement(
            Statement::Store {
                pointer: q,
                value: implicit,
            },
            span,
        )?;
        let twenty_two = self.frsqrt_literal(22, span)?;
        self.frsqrt_statement(
            Statement::Store {
                pointer: bit,
                value: twenty_two,
            },
            span,
        )?;
        let ((), body) = self.capture_block(|parser| {
            let current = parser.append(Expression::Load { pointer: q }, span)?;
            let current_bit = parser.append(Expression::Load { pointer: bit }, span)?;
            let safe_bit = parser.frsqrt_binary(BinaryOperator::And, current_bit, last, span)?;
            let trial_bit = parser.frsqrt_binary(BinaryOperator::ShiftLeft, one, safe_bit, span)?;
            let candidate =
                parser.frsqrt_binary(BinaryOperator::InclusiveOr, current, trial_bit, span)?;
            let multiplier =
                parser.frsqrt_binary(BinaryOperator::ShiftLeft, candidate, one, span)?;
            let leading = parser.frsqrt_product_leading(significand, multiplier, span)?;
            let accept = parser.frsqrt_binary(BinaryOperator::Less, leading, power, span)?;
            let next = parser.frsqrt_select(accept, candidate, current, span)?;
            parser.frsqrt_statement(
                Statement::Store {
                    pointer: q,
                    value: next,
                },
                span,
            )?;
            let final_bit = parser.frsqrt_binary(BinaryOperator::Equal, current_bit, zero, span)?;
            parser.frsqrt_break_if(final_bit, span)?;
            let next_bit =
                parser.frsqrt_binary(BinaryOperator::Subtract, current_bit, one, span)?;
            parser.frsqrt_statement(
                Statement::Store {
                    pointer: bit,
                    value: next_bit,
                },
                span,
            )
        })?;
        self.frsqrt_statement(
            Statement::Loop {
                body,
                continuing: crate::Block::new(),
                break_if: None,
            },
            span,
        )?;
        let q = self.append(Expression::Load { pointer: q }, span)?;
        let midpoint = self.frsqrt_binary(BinaryOperator::ShiftLeft, q, one, span)?;
        let midpoint = self.frsqrt_binary(BinaryOperator::Add, midpoint, one, span)?;
        let leading = self.frsqrt_product_leading(significand, midpoint, span)?;
        // Each trial and midpoint has an odd factor greater than one, so exact ties are impossible.
        let round_up = self.frsqrt_binary(BinaryOperator::Less, leading, power, span)?;
        let increment = self.frsqrt_bool_as_uint(round_up, span)?;
        let rounded = self.frsqrt_binary(BinaryOperator::Add, q, increment, span)?;
        let carry_bit = self.frsqrt_literal(0x0100_0000, span)?;
        let carry = self.frsqrt_binary(BinaryOperator::GreaterEqual, rounded, carry_bit, span)?;
        let shifted = self.frsqrt_binary(BinaryOperator::ShiftRight, rounded, one, span)?;
        let rounded = self.frsqrt_select(carry, shifted, rounded, span)?;
        let carry = self.frsqrt_cast(carry, Scalar::I32, span)?;
        let result_exponent =
            self.frsqrt_binary(BinaryOperator::Add, result_exponent, carry, span)?;
        let encoded_exponent =
            self.frsqrt_binary(BinaryOperator::Add, result_exponent, bias, span)?;
        let encoded_exponent = self.frsqrt_cast(encoded_exponent, Scalar::U32, span)?;
        let exponent_bits =
            self.frsqrt_binary(BinaryOperator::ShiftLeft, encoded_exponent, width, span)?;
        let fraction = self.frsqrt_binary(BinaryOperator::And, rounded, fraction_mask, span)?;
        let result =
            self.frsqrt_binary(BinaryOperator::InclusiveOr, exponent_bits, fraction, span)?;
        self.frsqrt_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        )
    }

    fn frsqrt_product_leading(
        &mut self,
        x: Handle<Expression>,
        w: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        // For x in [2^23, 2^24) and w in (2^24, 2^25), x*w*w has leading bit 71..=73.
        let mask = self.frsqrt_literal(4095, span)?;
        let width = self.frsqrt_literal(12, span)?;
        let two = self.frsqrt_literal(2, span)?;
        let a = self.frsqrt_binary(BinaryOperator::And, w, mask, span)?;
        let b = self.frsqrt_binary(BinaryOperator::ShiftRight, w, width, span)?;
        let s0 = self.frsqrt_binary(BinaryOperator::Multiply, a, a, span)?;
        let ab = self.frsqrt_binary(BinaryOperator::Multiply, a, b, span)?;
        let twice_ab = self.frsqrt_binary(BinaryOperator::Multiply, two, ab, span)?;
        let carry0 = self.frsqrt_binary(BinaryOperator::ShiftRight, s0, width, span)?;
        let s1 = self.frsqrt_binary(BinaryOperator::Add, twice_ab, carry0, span)?;
        let bb = self.frsqrt_binary(BinaryOperator::Multiply, b, b, span)?;
        let carry1 = self.frsqrt_binary(BinaryOperator::ShiftRight, s1, width, span)?;
        let s2 = self.frsqrt_binary(BinaryOperator::Add, bb, carry1, span)?;
        let d0 = self.frsqrt_binary(BinaryOperator::And, s0, mask, span)?;
        let d1 = self.frsqrt_binary(BinaryOperator::And, s1, mask, span)?;
        let d2 = self.frsqrt_binary(BinaryOperator::And, s2, mask, span)?;
        let d3 = self.frsqrt_binary(BinaryOperator::ShiftRight, s2, width, span)?;
        let d3 = self.frsqrt_binary(BinaryOperator::And, d3, mask, span)?;
        let twenty_four = self.frsqrt_literal(24, span)?;
        let d4 = self.frsqrt_binary(BinaryOperator::ShiftRight, s2, twenty_four, span)?;
        let x0 = self.frsqrt_binary(BinaryOperator::And, x, mask, span)?;
        let x1 = self.frsqrt_binary(BinaryOperator::ShiftRight, x, width, span)?;
        let t0 = self.frsqrt_binary(BinaryOperator::Multiply, x0, d0, span)?;
        let mut carry = self.frsqrt_binary(BinaryOperator::ShiftRight, t0, width, span)?;
        for (low_digit, high_digit) in [(d1, d0), (d2, d1), (d3, d2), (d4, d3)] {
            let low = self.frsqrt_binary(BinaryOperator::Multiply, x0, low_digit, span)?;
            let high = self.frsqrt_binary(BinaryOperator::Multiply, x1, high_digit, span)?;
            let column = self.frsqrt_binary(BinaryOperator::Add, low, high, span)?;
            let column = self.frsqrt_binary(BinaryOperator::Add, column, carry, span)?;
            carry = self.frsqrt_binary(BinaryOperator::ShiftRight, column, width, span)?;
        }
        let top = self.frsqrt_binary(BinaryOperator::Multiply, x1, d4, span)?;
        let top = self.frsqrt_binary(BinaryOperator::Add, top, carry, span)?;
        let top = self.frsqrt_binary(BinaryOperator::ShiftRight, top, width, span)?;
        let zero = self.frsqrt_literal(0, span)?;
        let nonzero = self.frsqrt_binary(BinaryOperator::NotEqual, top, zero, span)?;
        let high = self.frsqrt_binary(BinaryOperator::GreaterEqual, top, two, span)?;
        let nonzero = self.frsqrt_bool_as_uint(nonzero, span)?;
        let high = self.frsqrt_bool_as_uint(high, span)?;
        let base = self.frsqrt_literal(71, span)?;
        let leading = self.frsqrt_binary(BinaryOperator::Add, base, nonzero, span)?;
        self.frsqrt_binary(BinaryOperator::Add, leading, high, span)
    }

    fn frsqrt_local(
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

    fn frsqrt_break_if(
        &mut self,
        condition: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let mut accept = crate::Block::new();
        accept.push(Statement::Break, span);
        self.frsqrt_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }

    fn frsqrt_signed_literal(
        &mut self,
        value: i32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::I32(value)), span)
    }

    fn frsqrt_cast(
        &mut self,
        expr: Handle<Expression>,
        target: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::As { expr, target }, span)
    }

    fn frsqrt_clz(
        &mut self,
        arg: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            Expression::Math {
                fun: crate::MathFunction::CountLeadingZeros,
                arg,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )
    }

    fn frsqrt_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn frsqrt_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn frsqrt_select(
        &mut self,
        condition: Handle<Expression>,
        accept: Handle<Expression>,
        reject: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            Expression::Select {
                condition,
                accept,
                reject,
            },
            span,
        )
    }

    fn frsqrt_bool_as_uint(
        &mut self,
        expr: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            Expression::As {
                expr,
                target: Scalar::U32,
            },
            span,
        )
    }

    fn frsqrt_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn frsqrt_return_if(
        &mut self,
        condition: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let mut accept = crate::Block::new();
        accept.push(Statement::Return { value: Some(value) }, span);
        self.frsqrt_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }
}
