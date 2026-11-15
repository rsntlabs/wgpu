use super::*;

#[derive(Clone, Copy)]
enum MultiplyRounding {
    NearestEven,
    TowardZero,
}

impl Parser<'_> {
    pub(super) fn lower_fmul_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmul_call(arguments, MultiplyRounding::NearestEven, span)
    }

    pub(super) fn lower_fmul_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmul_call(arguments, MultiplyRounding::TowardZero, span)
    }

    fn lower_fmul_call(
        &mut self,
        arguments: Vec<Value>,
        rounding: MultiplyRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let left = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let right = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let left = self.bitcast_scalar(left.handle, Scalar::U32, span)?;
        let right = self.bitcast_scalar(right.handle, Scalar::U32, span)?;
        let bits = match rounding {
            MultiplyRounding::NearestEven => self.call_fmul_rn_bits(left, right, span)?,
            MultiplyRounding::TowardZero => self.call_fmul_rz_bits(left, right, span)?,
        };
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

    pub(super) fn call_fmul_rn_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fmul_bits(left, right, MultiplyRounding::NearestEven, span)
    }

    pub(super) fn call_fmul_rz_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fmul_bits(left, right, MultiplyRounding::TowardZero, span)
    }

    fn call_fmul_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        rounding: MultiplyRounding,
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
        let function = self.cached_fmul_function(rounding, span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![left, right],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_fmul_function(
        &mut self,
        rounding: MultiplyRounding,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match rounding {
            MultiplyRounding::NearestEven => self.fmul_rn_function,
            MultiplyRounding::TowardZero => self.fmul_rz_function,
        };
        if let Some(function) = cached {
            return Ok(function);
        }
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_fmul_function(rounding, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match rounding {
            MultiplyRounding::NearestEven => self.fmul_rn_function = Some(function),
            MultiplyRounding::TowardZero => self.fmul_rz_function = Some(function),
        }
        Ok(function)
    }

    fn build_fmul_function(
        &mut self,
        rounding: MultiplyRounding,
        span: Span,
    ) -> Result<(), ParseError> {
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
        let name = match rounding {
            MultiplyRounding::NearestEven => "_naga_fmul_rn",
            MultiplyRounding::TowardZero => "_naga_fmul_rz",
        };
        let argument_names = ["left_bits", "right_bits"];
        self.parameter_expansion_budget.charge_nodes(2, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(2, span)?;
        self.parameter_expansion_budget.charge_bytes(
            name.len() + argument_names.iter().map(|name| name.len()).sum::<usize>(),
            span,
        )?;
        self.function.ir.name = Some(String::from(name));
        for name in argument_names {
            self.function.ir.arguments.push(FunctionArgument {
                name: Some(String::from(name)),
                ty: unsigned,
                binding: None,
            });
        }
        self.function.ir.result = Some(crate::FunctionResult {
            ty: unsigned,
            binding: None,
        });
        let left = self.append(Expression::FunctionArgument(0), span)?;
        let right = self.append(Expression::FunctionArgument(1), span)?;
        let zero = self.fmul_literal(0, span)?;
        let one = self.fmul_literal(1, span)?;
        let magnitude_mask = self.fmul_literal(0x7fff_ffff, span)?;
        let sign_mask = self.fmul_literal(0x8000_0000, span)?;
        let infinity = self.fmul_literal(0x7f80_0000, span)?;
        let nan = self.fmul_literal(0x7fc0_0000, span)?;
        let left_magnitude = self.fmul_binary(BinaryOperator::And, left, magnitude_mask, span)?;
        let right_magnitude = self.fmul_binary(BinaryOperator::And, right, magnitude_mask, span)?;
        let signs = self.fmul_binary(BinaryOperator::ExclusiveOr, left, right, span)?;
        let sign = self.fmul_binary(BinaryOperator::And, signs, sign_mask, span)?;
        let left_nan = self.fmul_binary(BinaryOperator::Greater, left_magnitude, infinity, span)?;
        let right_nan =
            self.fmul_binary(BinaryOperator::Greater, right_magnitude, infinity, span)?;
        let invalid = self.fmul_binary(BinaryOperator::LogicalOr, left_nan, right_nan, span)?;
        self.fmul_return_if(invalid, nan, span)?;
        let left_infinite =
            self.fmul_binary(BinaryOperator::Equal, left_magnitude, infinity, span)?;
        let right_infinite =
            self.fmul_binary(BinaryOperator::Equal, right_magnitude, infinity, span)?;
        let infinite = self.fmul_binary(
            BinaryOperator::LogicalOr,
            left_infinite,
            right_infinite,
            span,
        )?;
        let left_zero = self.fmul_binary(BinaryOperator::Equal, left_magnitude, zero, span)?;
        let right_zero = self.fmul_binary(BinaryOperator::Equal, right_magnitude, zero, span)?;
        let either_zero =
            self.fmul_binary(BinaryOperator::LogicalOr, left_zero, right_zero, span)?;
        let invalid = self.fmul_binary(BinaryOperator::LogicalAnd, infinite, either_zero, span)?;
        self.fmul_return_if(invalid, nan, span)?;
        let signed_infinity =
            self.fmul_binary(BinaryOperator::InclusiveOr, sign, infinity, span)?;
        self.fmul_return_if(infinite, signed_infinity, span)?;
        self.fmul_return_if(either_zero, sign, span)?;

        let width = self.fmul_literal(23, span)?;
        let fraction_mask = self.fmul_literal(0x007f_ffff, span)?;
        let implicit = self.fmul_literal(0x0080_0000, span)?;
        let left_exponent =
            self.fmul_binary(BinaryOperator::ShiftRight, left_magnitude, width, span)?;
        let right_exponent =
            self.fmul_binary(BinaryOperator::ShiftRight, right_magnitude, width, span)?;
        let left_normal = self.fmul_binary(BinaryOperator::NotEqual, left_exponent, zero, span)?;
        let right_normal =
            self.fmul_binary(BinaryOperator::NotEqual, right_exponent, zero, span)?;
        let left_hidden = self.fmul_select(left_normal, implicit, zero, span)?;
        let right_hidden = self.fmul_select(right_normal, implicit, zero, span)?;
        let left_fraction =
            self.fmul_binary(BinaryOperator::And, left_magnitude, fraction_mask, span)?;
        let right_fraction =
            self.fmul_binary(BinaryOperator::And, right_magnitude, fraction_mask, span)?;
        let left = self.fmul_binary(
            BinaryOperator::InclusiveOr,
            left_fraction,
            left_hidden,
            span,
        )?;
        let right = self.fmul_binary(
            BinaryOperator::InclusiveOr,
            right_fraction,
            right_hidden,
            span,
        )?;
        let limb_mask = self.fmul_literal(4095, span)?;
        let limb_width = self.fmul_literal(12, span)?;
        let left_low = self.fmul_binary(BinaryOperator::And, left, limb_mask, span)?;
        let right_low = self.fmul_binary(BinaryOperator::And, right, limb_mask, span)?;
        let left_high = self.fmul_binary(BinaryOperator::ShiftRight, left, limb_width, span)?;
        let right_high = self.fmul_binary(BinaryOperator::ShiftRight, right, limb_width, span)?;
        // Radix-4096 columns keep the exact 48-bit product in two 24-bit words.
        let p0 = self.fmul_binary(BinaryOperator::Multiply, left_low, right_low, span)?;
        let p1a = self.fmul_binary(BinaryOperator::Multiply, left_low, right_high, span)?;
        let p1b = self.fmul_binary(BinaryOperator::Multiply, left_high, right_low, span)?;
        let p1 = self.fmul_binary(BinaryOperator::Add, p1a, p1b, span)?;
        let carry = self.fmul_binary(BinaryOperator::ShiftRight, p0, limb_width, span)?;
        let p1 = self.fmul_binary(BinaryOperator::Add, p1, carry, span)?;
        let p2 = self.fmul_binary(BinaryOperator::Multiply, left_high, right_high, span)?;
        let carry = self.fmul_binary(BinaryOperator::ShiftRight, p1, limb_width, span)?;
        let high = self.fmul_binary(BinaryOperator::Add, p2, carry, span)?;
        let low0 = self.fmul_binary(BinaryOperator::And, p0, limb_mask, span)?;
        let low1 = self.fmul_binary(BinaryOperator::And, p1, limb_mask, span)?;
        let low1 = self.fmul_binary(BinaryOperator::ShiftLeft, low1, limb_width, span)?;
        let low = self.fmul_binary(BinaryOperator::InclusiveOr, low0, low1, span)?;
        let high_nonzero = self.fmul_binary(BinaryOperator::NotEqual, high, zero, span)?;
        let high_clz = self.fmul_clz(high, span)?;
        let low_nonzero = self.fmul_binary(BinaryOperator::InclusiveOr, low, one, span)?;
        let low_clz = self.fmul_clz(low_nonzero, span)?;
        let fifty_five = self.fmul_literal(55, span)?;
        let thirty_one = self.fmul_literal(31, span)?;
        let high_leading =
            self.fmul_binary(BinaryOperator::Subtract, fifty_five, high_clz, span)?;
        let low_leading = self.fmul_binary(BinaryOperator::Subtract, thirty_one, low_clz, span)?;
        let leading = self.fmul_select(high_nonzero, high_leading, low_leading, span)?;
        let leading = self.fmul_cast(leading, Scalar::I32, span)?;
        let left_exponent = self.fmul_select(left_normal, left_exponent, one, span)?;
        let right_exponent = self.fmul_select(right_normal, right_exponent, one, span)?;
        let left_exponent = self.fmul_cast(left_exponent, Scalar::I32, span)?;
        let right_exponent = self.fmul_cast(right_exponent, Scalar::I32, span)?;
        let exponent_sum =
            self.fmul_binary(BinaryOperator::Add, left_exponent, right_exponent, span)?;
        let exponent = self.fmul_binary(BinaryOperator::Add, leading, exponent_sum, span)?;
        let bias = self.fmul_signed_literal(173, span)?;
        let exponent = self.fmul_binary(BinaryOperator::Subtract, exponent, bias, span)?;
        let twenty_three = self.fmul_signed_literal(23, span)?;
        let normal_shift =
            self.fmul_binary(BinaryOperator::Subtract, leading, twenty_three, span)?;
        let underflow_bias = self.fmul_signed_literal(151, span)?;
        let subnormal_shift =
            self.fmul_binary(BinaryOperator::Subtract, underflow_bias, exponent_sum, span)?;
        let shift = self.fmul_math(
            crate::MathFunction::Max,
            normal_shift,
            subnormal_shift,
            span,
        )?;
        let three_signed = self.fmul_signed_literal(3, span)?;
        let distance = self.fmul_binary(BinaryOperator::Subtract, shift, three_signed, span)?;
        let significand = self.fmul_shift_right_jam(high, low, distance, span)?;
        let (rounded, exponent) = match rounding {
            MultiplyRounding::NearestEven => {
                let seven = self.fmul_literal(7, span)?;
                let four = self.fmul_literal(4, span)?;
                let three = self.fmul_literal(3, span)?;
                let tail = self.fmul_binary(BinaryOperator::And, significand, seven, span)?;
                let rounded =
                    self.fmul_binary(BinaryOperator::ShiftRight, significand, three, span)?;
                let odd = self.fmul_binary(BinaryOperator::And, rounded, one, span)?;
                let odd = self.fmul_binary(BinaryOperator::NotEqual, odd, zero, span)?;
                let tie = self.fmul_binary(BinaryOperator::Equal, tail, four, span)?;
                let tie_up = self.fmul_binary(BinaryOperator::LogicalAnd, tie, odd, span)?;
                let above_half = self.fmul_binary(BinaryOperator::Greater, tail, four, span)?;
                let increment =
                    self.fmul_binary(BinaryOperator::LogicalOr, above_half, tie_up, span)?;
                let increment = self.fmul_bool_as_uint(increment, span)?;
                let rounded = self.fmul_binary(BinaryOperator::Add, rounded, increment, span)?;
                let carry_bit = self.fmul_literal(0x0100_0000, span)?;
                let carry =
                    self.fmul_binary(BinaryOperator::GreaterEqual, rounded, carry_bit, span)?;
                let shifted = self.fmul_binary(BinaryOperator::ShiftRight, rounded, one, span)?;
                let rounded = self.fmul_select(carry, shifted, rounded, span)?;
                let carry = self.fmul_cast(carry, Scalar::I32, span)?;
                let exponent = self.fmul_binary(BinaryOperator::Add, exponent, carry, span)?;
                (rounded, exponent)
            }
            MultiplyRounding::TowardZero => {
                let three = self.fmul_literal(3, span)?;
                let rounded =
                    self.fmul_binary(BinaryOperator::ShiftRight, significand, three, span)?;
                (rounded, exponent)
            }
        };
        let maximum_exponent = self.fmul_signed_literal(255, span)?;
        let overflow = self.fmul_binary(
            BinaryOperator::GreaterEqual,
            exponent,
            maximum_exponent,
            span,
        )?;
        let signed_overflow = match rounding {
            MultiplyRounding::NearestEven => signed_infinity,
            MultiplyRounding::TowardZero => {
                let maximum = self.fmul_literal(0x7f7f_ffff, span)?;
                self.fmul_binary(BinaryOperator::InclusiveOr, sign, maximum, span)?
            }
        };
        self.fmul_return_if(overflow, signed_overflow, span)?;
        let normal = self.fmul_binary(BinaryOperator::GreaterEqual, rounded, implicit, span)?;
        let one_signed = self.fmul_signed_literal(1, span)?;
        let exponent = self.fmul_math(crate::MathFunction::Max, exponent, one_signed, span)?;
        let exponent = self.fmul_cast(exponent, Scalar::U32, span)?;
        let exponent = self.fmul_select(normal, exponent, zero, span)?;
        let exponent_bits = self.fmul_binary(BinaryOperator::ShiftLeft, exponent, width, span)?;
        let fraction = self.fmul_binary(BinaryOperator::And, rounded, fraction_mask, span)?;
        let magnitude =
            self.fmul_binary(BinaryOperator::InclusiveOr, exponent_bits, fraction, span)?;
        let result = self.fmul_binary(BinaryOperator::InclusiveOr, sign, magnitude, span)?;
        self.fmul_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        )
    }

    fn fmul_shift_right_jam(
        &mut self,
        high: Handle<Expression>,
        low: Handle<Expression>,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let zero = self.fmul_literal(0, span)?;
        let one = self.fmul_literal(1, span)?;
        let twenty_four = self.fmul_literal(24, span)?;
        let zero_signed = self.fmul_signed_literal(0, span)?;
        let twenty_four_signed = self.fmul_signed_literal(24, span)?;
        let forty_eight = self.fmul_signed_literal(48, span)?;
        let left_distance =
            self.fmul_binary(BinaryOperator::Subtract, zero_signed, distance, span)?;
        let left_distance = self.fmul_safe_shift(left_distance, span)?;
        let full_high = self.fmul_binary(BinaryOperator::ShiftLeft, high, twenty_four, span)?;
        let full = self.fmul_binary(BinaryOperator::InclusiveOr, full_high, low, span)?;
        let left = self.fmul_binary(BinaryOperator::ShiftLeft, full, left_distance, span)?;
        let right_distance = self.fmul_safe_shift(distance, span)?;
        let short_high_distance =
            self.fmul_binary(BinaryOperator::Subtract, twenty_four_signed, distance, span)?;
        let short_high_distance = self.fmul_safe_shift(short_high_distance, span)?;
        let short_high =
            self.fmul_binary(BinaryOperator::ShiftLeft, high, short_high_distance, span)?;
        let short_low = self.fmul_binary(BinaryOperator::ShiftRight, low, right_distance, span)?;
        let low_mask = self.fmul_binary(BinaryOperator::ShiftLeft, one, right_distance, span)?;
        let low_mask = self.fmul_binary(BinaryOperator::Subtract, low_mask, one, span)?;
        let low_lost = self.fmul_binary(BinaryOperator::And, low, low_mask, span)?;
        let low_lost = self.fmul_binary(BinaryOperator::NotEqual, low_lost, zero, span)?;
        let low_lost = self.fmul_bool_as_uint(low_lost, span)?;
        let short = self.fmul_binary(BinaryOperator::InclusiveOr, short_high, short_low, span)?;
        let short = self.fmul_binary(BinaryOperator::InclusiveOr, short, low_lost, span)?;
        let at_word = self.fmul_binary(BinaryOperator::NotEqual, low, zero, span)?;
        let at_word = self.fmul_bool_as_uint(at_word, span)?;
        let at_word = self.fmul_binary(BinaryOperator::InclusiveOr, high, at_word, span)?;
        let high_distance =
            self.fmul_binary(BinaryOperator::Subtract, distance, twenty_four_signed, span)?;
        let high_distance = self.fmul_safe_shift(high_distance, span)?;
        let high_mask = self.fmul_binary(BinaryOperator::ShiftLeft, one, high_distance, span)?;
        let high_mask = self.fmul_binary(BinaryOperator::Subtract, high_mask, one, span)?;
        let high_lost = self.fmul_binary(BinaryOperator::And, high, high_mask, span)?;
        let high_lost = self.fmul_binary(BinaryOperator::NotEqual, high_lost, zero, span)?;
        let low_nonzero = self.fmul_binary(BinaryOperator::NotEqual, low, zero, span)?;
        let lost = self.fmul_binary(BinaryOperator::LogicalOr, high_lost, low_nonzero, span)?;
        let lost = self.fmul_bool_as_uint(lost, span)?;
        let long = self.fmul_binary(BinaryOperator::ShiftRight, high, high_distance, span)?;
        let long = self.fmul_binary(BinaryOperator::InclusiveOr, long, lost, span)?;
        let nonzero = self.fmul_binary(BinaryOperator::InclusiveOr, high, low, span)?;
        let nonzero = self.fmul_binary(BinaryOperator::NotEqual, nonzero, zero, span)?;
        let nonzero = self.fmul_bool_as_uint(nonzero, span)?;
        let below_pair = self.fmul_binary(BinaryOperator::Less, distance, forty_eight, span)?;
        let result = self.fmul_select(below_pair, long, nonzero, span)?;
        let at_word_condition =
            self.fmul_binary(BinaryOperator::Equal, distance, twenty_four_signed, span)?;
        let result = self.fmul_select(at_word_condition, at_word, result, span)?;
        let below_word =
            self.fmul_binary(BinaryOperator::Less, distance, twenty_four_signed, span)?;
        let result = self.fmul_select(below_word, short, result, span)?;
        let nonpositive =
            self.fmul_binary(BinaryOperator::LessEqual, distance, zero_signed, span)?;
        self.fmul_select(nonpositive, left, result, span)
    }

    fn fmul_safe_shift(
        &mut self,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let zero = self.fmul_signed_literal(0, span)?;
        let last_signed = self.fmul_signed_literal(31, span)?;
        let nonnegative = self.fmul_math(crate::MathFunction::Max, distance, zero, span)?;
        let bounded = self.fmul_math(crate::MathFunction::Min, nonnegative, last_signed, span)?;
        let unsigned = self.fmul_cast(bounded, Scalar::U32, span)?;
        let last = self.fmul_literal(31, span)?;
        self.fmul_binary(BinaryOperator::And, unsigned, last, span)
    }

    fn fmul_signed_literal(
        &mut self,
        value: i32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::I32(value)), span)
    }

    fn fmul_cast(
        &mut self,
        expr: Handle<Expression>,
        target: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::As { expr, target }, span)
    }

    fn fmul_clz(
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

    fn fmul_math(
        &mut self,
        fun: crate::MathFunction,
        arg: Handle<Expression>,
        arg1: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            Expression::Math {
                fun,
                arg,
                arg1: Some(arg1),
                arg2: None,
                arg3: None,
            },
            span,
        )
    }

    fn fmul_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn fmul_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn fmul_select(
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

    fn fmul_bool_as_uint(
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

    fn fmul_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn fmul_return_if(
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
        self.fmul_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }
}
