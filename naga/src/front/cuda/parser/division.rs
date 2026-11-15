use super::*;

#[derive(Clone, Copy)]
enum DivisionRounding {
    NearestEven,
    TowardZero,
}

impl Parser<'_> {
    pub(super) fn lower_fdiv_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fdiv_call(arguments, DivisionRounding::NearestEven, span)
    }

    pub(super) fn lower_fdiv_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fdiv_call(arguments, DivisionRounding::TowardZero, span)
    }

    fn lower_fdiv_call(
        &mut self,
        arguments: Vec<Value>,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let numerator = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let denominator = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let handle = match rounding {
            DivisionRounding::NearestEven => {
                self.divide_f32(numerator.handle, denominator.handle, span)?
            }
            DivisionRounding::TowardZero => {
                self.divide_f32_rz(numerator.handle, denominator.handle, span)?
            }
        };
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

    pub(super) fn lower_frcp_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_frcp_call(arguments, DivisionRounding::NearestEven, span)
    }

    pub(super) fn lower_frcp_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_frcp_call(arguments, DivisionRounding::TowardZero, span)
    }

    fn lower_frcp_call(
        &mut self,
        arguments: Vec<Value>,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let argument =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
        let one = self.append(Expression::Literal(Literal::F32(1.0)), span)?;
        let handle = match rounding {
            DivisionRounding::NearestEven => self.divide_f32(one, argument.handle, span)?,
            DivisionRounding::TowardZero => self.divide_f32_rz(one, argument.handle, span)?,
        };
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

    pub(super) fn divide_f32(
        &mut self,
        numerator: Handle<Expression>,
        denominator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.divide_f32_with_rounding(numerator, denominator, DivisionRounding::NearestEven, span)
    }

    pub(super) fn divide_f32_rz(
        &mut self,
        numerator: Handle<Expression>,
        denominator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.divide_f32_with_rounding(numerator, denominator, DivisionRounding::TowardZero, span)
    }

    fn divide_f32_with_rounding(
        &mut self,
        numerator: Handle<Expression>,
        denominator: Handle<Expression>,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let numerator_bits = self.bitcast_scalar(numerator, Scalar::U32, span)?;
        let denominator_bits = self.bitcast_scalar(denominator, Scalar::U32, span)?;
        let result = match rounding {
            DivisionRounding::NearestEven => {
                self.call_division_bits(numerator_bits, denominator_bits, rounding, span)?
            }
            DivisionRounding::TowardZero => {
                self.call_division_rz_bits(numerator_bits, denominator_bits, span)?
            }
        };
        self.bitcast_scalar(result, Scalar::F32, span)
    }

    pub(super) fn call_division_rz_bits(
        &mut self,
        numerator_bits: Handle<Expression>,
        denominator_bits: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_division_bits(
            numerator_bits,
            denominator_bits,
            DivisionRounding::TowardZero,
            span,
        )
    }

    fn call_division_bits(
        &mut self,
        numerator_bits: Handle<Expression>,
        denominator_bits: Handle<Expression>,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(2, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_division_function(rounding, span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![numerator_bits, denominator_bits],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_division_function(
        &mut self,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match rounding {
            DivisionRounding::NearestEven => self.division_function,
            DivisionRounding::TowardZero => self.division_rz_function,
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
        let result = self.build_division_function(rounding, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match rounding {
            DivisionRounding::NearestEven => self.division_function = Some(function),
            DivisionRounding::TowardZero => self.division_rz_function = Some(function),
        }
        Ok(function)
    }

    fn build_division_function(
        &mut self,
        rounding: DivisionRounding,
        span: Span,
    ) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let scalar_ty = self.division_scalar_handle(Scalar::U32, span)?;
        let name = match rounding {
            DivisionRounding::NearestEven => "_naga_divide_f32",
            DivisionRounding::TowardZero => "_naga_divide_f32_rz",
        };
        let argument_names = ["numerator_bits", "denominator_bits"];
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
                ty: scalar_ty,
                binding: None,
            });
        }
        self.function.ir.result = Some(crate::FunctionResult {
            ty: scalar_ty,
            binding: None,
        });
        let numerator_bits = self.append(Expression::FunctionArgument(0), span)?;
        let denominator_bits = self.append(Expression::FunctionArgument(1), span)?;
        let zero = self.division_literal(0, span)?;
        let one = self.division_literal(1, span)?;
        let magnitude_mask = self.division_literal(0x7fff_ffff, span)?;
        let sign_mask = self.division_literal(0x8000_0000, span)?;
        let infinity = self.division_literal(0x7f80_0000, span)?;
        let quiet_nan = self.division_literal(0x7fc0_0000, span)?;
        let numerator_magnitude =
            self.division_binary(BinaryOperator::And, numerator_bits, magnitude_mask, span)?;
        let denominator_magnitude =
            self.division_binary(BinaryOperator::And, denominator_bits, magnitude_mask, span)?;
        let combined_sign = self.division_binary(
            BinaryOperator::ExclusiveOr,
            numerator_bits,
            denominator_bits,
            span,
        )?;
        let sign = self.division_binary(BinaryOperator::And, combined_sign, sign_mask, span)?;
        let signed_infinity =
            self.division_binary(BinaryOperator::InclusiveOr, sign, infinity, span)?;
        let numerator_nan =
            self.division_binary(BinaryOperator::Greater, numerator_magnitude, infinity, span)?;
        let denominator_nan = self.division_binary(
            BinaryOperator::Greater,
            denominator_magnitude,
            infinity,
            span,
        )?;
        let has_nan = self.division_binary(
            BinaryOperator::LogicalOr,
            numerator_nan,
            denominator_nan,
            span,
        )?;
        let numerator_zero =
            self.division_binary(BinaryOperator::Equal, numerator_magnitude, zero, span)?;
        let denominator_zero =
            self.division_binary(BinaryOperator::Equal, denominator_magnitude, zero, span)?;
        let both_zero = self.division_binary(
            BinaryOperator::LogicalAnd,
            numerator_zero,
            denominator_zero,
            span,
        )?;
        let numerator_infinite =
            self.division_binary(BinaryOperator::Equal, numerator_magnitude, infinity, span)?;
        let denominator_infinite =
            self.division_binary(BinaryOperator::Equal, denominator_magnitude, infinity, span)?;
        let both_infinite = self.division_binary(
            BinaryOperator::LogicalAnd,
            numerator_infinite,
            denominator_infinite,
            span,
        )?;
        let invalid = self.division_binary(BinaryOperator::LogicalOr, has_nan, both_zero, span)?;
        let invalid =
            self.division_binary(BinaryOperator::LogicalOr, invalid, both_infinite, span)?;
        self.division_return_if(invalid, quiet_nan, span)?;
        let infinite_result = self.division_binary(
            BinaryOperator::LogicalOr,
            numerator_infinite,
            denominator_zero,
            span,
        )?;
        self.division_return_if(infinite_result, signed_infinity, span)?;
        let zero_result = self.division_binary(
            BinaryOperator::LogicalOr,
            numerator_zero,
            denominator_infinite,
            span,
        )?;
        self.division_return_if(zero_result, sign, span)?;

        let (numerator_significand, numerator_exponent) = self.division_normalize(
            numerator_magnitude,
            "numerator_significand",
            "numerator_exponent",
            span,
        )?;
        let (denominator_significand, denominator_exponent) = self.division_normalize(
            denominator_magnitude,
            "denominator_significand",
            "denominator_exponent",
            span,
        )?;
        let ratio_below_one = self.division_binary(
            BinaryOperator::Less,
            numerator_significand,
            denominator_significand,
            span,
        )?;
        let shifted_numerator =
            self.division_binary(BinaryOperator::ShiftLeft, numerator_significand, one, span)?;
        let normalized_numerator = self.division_select(
            ratio_below_one,
            shifted_numerator,
            numerator_significand,
            span,
        )?;
        let exponent_difference = self.division_binary(
            BinaryOperator::Subtract,
            numerator_exponent,
            denominator_exponent,
            span,
        )?;
        let exponent_adjustment = self.division_cast(ratio_below_one, Scalar::I32, span)?;
        let exponent = self.division_binary(
            BinaryOperator::Subtract,
            exponent_difference,
            exponent_adjustment,
            span,
        )?;
        let minimum_exponent = self.append(Expression::Literal(Literal::I32(-150)), span)?;
        let too_small =
            self.division_binary(BinaryOperator::Less, exponent, minimum_exponent, span)?;
        self.division_return_if(too_small, sign, span)?;

        let quotient = self.division_local("quotient", Scalar::U32, span)?;
        let remainder = self.division_local("remainder", Scalar::U32, span)?;
        let iteration = self.division_local("iteration", Scalar::U32, span)?;
        let initial_remainder = self.division_binary(
            BinaryOperator::Subtract,
            normalized_numerator,
            denominator_significand,
            span,
        )?;
        self.division_store(quotient, one, span)?;
        self.division_store(remainder, initial_remainder, span)?;
        self.division_store(iteration, zero, span)?;
        let fraction_width = self.division_literal(23, span)?;
        let ((), body) = self.capture_block(|parser| {
            let current_iteration = parser.division_load(iteration, span)?;
            let finished = parser.division_binary(
                BinaryOperator::GreaterEqual,
                current_iteration,
                fraction_width,
                span,
            )?;
            parser.parameter_expansion_budget.charge_nodes(1, span)?;
            parser
                .parameter_expansion_budget
                .charge_slice::<(Statement, Span)>(1, span)?;
            let mut accept = crate::Block::new();
            accept.push(Statement::Break, span);
            parser.division_statement(
                Statement::If {
                    condition: finished,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            )?;
            let current_remainder = parser.division_load(remainder, span)?;
            let current_quotient = parser.division_load(quotient, span)?;
            let expanded_remainder =
                parser.division_binary(BinaryOperator::ShiftLeft, current_remainder, one, span)?;
            let digit = parser.division_binary(
                BinaryOperator::GreaterEqual,
                expanded_remainder,
                denominator_significand,
                span,
            )?;
            let reduced_remainder = parser.division_binary(
                BinaryOperator::Subtract,
                expanded_remainder,
                denominator_significand,
                span,
            )?;
            let next_remainder =
                parser.division_select(digit, reduced_remainder, expanded_remainder, span)?;
            let shifted_quotient =
                parser.division_binary(BinaryOperator::ShiftLeft, current_quotient, one, span)?;
            let digit_bits = parser.division_select(digit, one, zero, span)?;
            let next_quotient = parser.division_binary(
                BinaryOperator::InclusiveOr,
                shifted_quotient,
                digit_bits,
                span,
            )?;
            parser.division_store(remainder, next_remainder, span)?;
            parser.division_store(quotient, next_quotient, span)?;
            Ok(())
        })?;
        let ((), continuing) = self.capture_block(|parser| {
            let current = parser.division_load(iteration, span)?;
            let next = parser.division_binary(BinaryOperator::Add, current, one, span)?;
            parser.division_store(iteration, next, span)?;
            Ok(())
        })?;
        self.division_statement(
            Statement::Loop {
                body,
                continuing,
                break_if: None,
            },
            span,
        )?;
        let quotient = self.division_load(quotient, span)?;
        let remainder = self.division_load(remainder, span)?;
        let minimum_normal_exponent = self.append(Expression::Literal(Literal::I32(-126)), span)?;
        let is_subnormal = self.division_binary(
            BinaryOperator::Less,
            exponent,
            minimum_normal_exponent,
            span,
        )?;
        let ((), subnormal) = self.capture_block(|parser| {
            let shift = parser.division_binary(
                BinaryOperator::Subtract,
                minimum_normal_exponent,
                exponent,
                span,
            )?;
            let shift = parser.division_cast(shift, Scalar::U32, span)?;
            let shift_mask = parser.division_literal(31, span)?;
            let shift = parser.division_binary(BinaryOperator::And, shift, shift_mask, span)?;
            let rounded = match rounding {
                DivisionRounding::NearestEven => {
                    let integral_unit =
                        parser.division_binary(BinaryOperator::ShiftLeft, one, shift, span)?;
                    let discarded_mask = parser.division_binary(
                        BinaryOperator::Subtract,
                        integral_unit,
                        one,
                        span,
                    )?;
                    let discarded = parser.division_binary(
                        BinaryOperator::And,
                        quotient,
                        discarded_mask,
                        span,
                    )?;
                    let half = parser.division_binary(
                        BinaryOperator::ShiftRight,
                        integral_unit,
                        one,
                        span,
                    )?;
                    let truncated = parser.division_binary(
                        BinaryOperator::ShiftRight,
                        quotient,
                        shift,
                        span,
                    )?;
                    let above_half =
                        parser.division_binary(BinaryOperator::Greater, discarded, half, span)?;
                    let at_half =
                        parser.division_binary(BinaryOperator::Equal, discarded, half, span)?;
                    let sticky =
                        parser.division_binary(BinaryOperator::NotEqual, remainder, zero, span)?;
                    let odd_bits =
                        parser.division_binary(BinaryOperator::And, truncated, one, span)?;
                    let is_odd =
                        parser.division_binary(BinaryOperator::NotEqual, odd_bits, zero, span)?;
                    let sticky_or_odd =
                        parser.division_binary(BinaryOperator::LogicalOr, sticky, is_odd, span)?;
                    let round_tie = parser.division_binary(
                        BinaryOperator::LogicalAnd,
                        at_half,
                        sticky_or_odd,
                        span,
                    )?;
                    let rounds_up = parser.division_binary(
                        BinaryOperator::LogicalOr,
                        above_half,
                        round_tie,
                        span,
                    )?;
                    let increment = parser.division_select(rounds_up, one, zero, span)?;
                    parser.division_binary(BinaryOperator::Add, truncated, increment, span)?
                }
                DivisionRounding::TowardZero => {
                    parser.division_binary(BinaryOperator::ShiftRight, quotient, shift, span)?
                }
            };
            let result =
                parser.division_binary(BinaryOperator::InclusiveOr, sign, rounded, span)?;
            parser.division_statement(
                Statement::Return {
                    value: Some(result),
                },
                span,
            )?;
            Ok(())
        })?;
        self.division_statement(
            Statement::If {
                condition: is_subnormal,
                accept: subnormal,
                reject: crate::Block::new(),
            },
            span,
        )?;
        let (normalized, exponent) = match rounding {
            DivisionRounding::NearestEven => {
                let twice_remainder =
                    self.division_binary(BinaryOperator::ShiftLeft, remainder, one, span)?;
                let above_half = self.division_binary(
                    BinaryOperator::Greater,
                    twice_remainder,
                    denominator_significand,
                    span,
                )?;
                let at_half = self.division_binary(
                    BinaryOperator::Equal,
                    twice_remainder,
                    denominator_significand,
                    span,
                )?;
                let odd_bits = self.division_binary(BinaryOperator::And, quotient, one, span)?;
                let is_odd =
                    self.division_binary(BinaryOperator::NotEqual, odd_bits, zero, span)?;
                let round_tie =
                    self.division_binary(BinaryOperator::LogicalAnd, at_half, is_odd, span)?;
                let rounds_up =
                    self.division_binary(BinaryOperator::LogicalOr, above_half, round_tie, span)?;
                let increment = self.division_select(rounds_up, one, zero, span)?;
                let rounded =
                    self.division_binary(BinaryOperator::Add, quotient, increment, span)?;
                let significand_width = self.division_literal(24, span)?;
                let carry = self.division_binary(
                    BinaryOperator::ShiftRight,
                    rounded,
                    significand_width,
                    span,
                )?;
                let normalized =
                    self.division_binary(BinaryOperator::ShiftRight, rounded, carry, span)?;
                let carry = self.division_cast(carry, Scalar::I32, span)?;
                let exponent = self.division_binary(BinaryOperator::Add, exponent, carry, span)?;
                (normalized, exponent)
            }
            DivisionRounding::TowardZero => (quotient, exponent),
        };
        let maximum_exponent = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let overflow =
            self.division_binary(BinaryOperator::Greater, exponent, maximum_exponent, span)?;
        let signed_overflow = match rounding {
            DivisionRounding::NearestEven => signed_infinity,
            DivisionRounding::TowardZero => {
                let maximum = self.division_literal(0x7f7f_ffff, span)?;
                self.division_binary(BinaryOperator::InclusiveOr, sign, maximum, span)?
            }
        };
        self.division_return_if(overflow, signed_overflow, span)?;
        let biased_exponent =
            self.division_binary(BinaryOperator::Add, exponent, maximum_exponent, span)?;
        let exponent_bits = self.division_cast(biased_exponent, Scalar::U32, span)?;
        let exponent_bits = self.division_binary(
            BinaryOperator::ShiftLeft,
            exponent_bits,
            fraction_width,
            span,
        )?;
        let fraction_mask = self.division_literal(0x007f_ffff, span)?;
        let fraction =
            self.division_binary(BinaryOperator::And, normalized, fraction_mask, span)?;
        let magnitude =
            self.division_binary(BinaryOperator::InclusiveOr, exponent_bits, fraction, span)?;
        let result = self.division_binary(BinaryOperator::InclusiveOr, sign, magnitude, span)?;
        self.division_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        )?;
        Ok(())
    }

    pub(super) fn division_normalize(
        &mut self,
        magnitude: Handle<Expression>,
        significand_name: &str,
        exponent_name: &str,
        span: Span,
    ) -> Result<(Handle<Expression>, Handle<Expression>), ParseError> {
        let zero = self.division_literal(0, span)?;
        let fraction_mask = self.division_literal(0x007f_ffff, span)?;
        let implicit_bit = self.division_literal(0x0080_0000, span)?;
        let fraction_width = self.division_literal(23, span)?;
        let fraction = self.division_binary(BinaryOperator::And, magnitude, fraction_mask, span)?;
        let exponent_bits =
            self.division_binary(BinaryOperator::ShiftRight, magnitude, fraction_width, span)?;
        let significand = self.division_local(significand_name, Scalar::U32, span)?;
        let exponent = self.division_local(exponent_name, Scalar::I32, span)?;
        let normal_significand =
            self.division_binary(BinaryOperator::InclusiveOr, fraction, implicit_bit, span)?;
        let exponent_value = self.division_cast(exponent_bits, Scalar::I32, span)?;
        let bias = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let normal_exponent =
            self.division_binary(BinaryOperator::Subtract, exponent_value, bias, span)?;
        self.division_store(significand, normal_significand, span)?;
        self.division_store(exponent, normal_exponent, span)?;
        let is_subnormal =
            self.division_binary(BinaryOperator::Equal, exponent_bits, zero, span)?;
        let ((), normalize) = self.capture_block(|parser| {
            let leading_zeros = parser.append(
                Expression::Math {
                    fun: crate::MathFunction::CountLeadingZeros,
                    arg: fraction,
                    arg1: None,
                    arg2: None,
                    arg3: None,
                },
                span,
            )?;
            let eight = parser.division_literal(8, span)?;
            let shift =
                parser.division_binary(BinaryOperator::Subtract, leading_zeros, eight, span)?;
            let normalized =
                parser.division_binary(BinaryOperator::ShiftLeft, fraction, shift, span)?;
            parser.division_store(significand, normalized, span)?;
            let minimum_exponent = parser.append(Expression::Literal(Literal::I32(-126)), span)?;
            let shift = parser.division_cast(shift, Scalar::I32, span)?;
            let adjusted =
                parser.division_binary(BinaryOperator::Subtract, minimum_exponent, shift, span)?;
            parser.division_store(exponent, adjusted, span)?;
            Ok(())
        })?;
        self.division_statement(
            Statement::If {
                condition: is_subnormal,
                accept: normalize,
                reject: crate::Block::new(),
            },
            span,
        )?;
        Ok((
            self.division_load(significand, span)?,
            self.division_load(exponent, span)?,
        ))
    }

    fn division_literal(
        &mut self,
        value: u32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn division_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn division_cast(
        &mut self,
        expr: Handle<Expression>,
        target: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::As { expr, target }, span)
    }

    fn division_select(
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

    fn division_local(
        &mut self,
        name: &str,
        scalar: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(LocalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        let ty = self.division_scalar_handle(scalar, span)?;
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

    fn division_load(
        &mut self,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Load { pointer }, span)
    }

    fn division_store(
        &mut self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.division_statement(Statement::Store { pointer, value }, span)
    }

    fn division_return_if(
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
        self.division_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }

    fn division_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn division_scalar_handle(
        &mut self,
        scalar: Scalar,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
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
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn division_local_and_first_cache_build_preflight_exhausted_budgets() {
        for rounding in [DivisionRounding::NearestEven, DivisionRounding::TowardZero] {
            for cached_helper in [false, true] {
                for exhaust_bytes in [false, true] {
                    let source = "1";
                    let span = Span::new(0, 1);
                    let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
                    parser.parameter_expansion_budget.activate();
                    parser.prepare_parameter_bindings(span).unwrap();
                    // Consume the remaining allowance without copying private budget limits.
                    for bit in (0..usize::BITS).rev() {
                        let count = 1usize << bit;
                        let _ = if exhaust_bytes {
                            parser.parameter_expansion_budget.charge_bytes(count, span)
                        } else {
                            parser.parameter_expansion_budget.charge_nodes(count, span)
                        };
                    }
                    let caller = format!("{:?}", parser.function.ir);
                    let types = format!("{:?}", parser.module.types);
                    let error = if cached_helper {
                        parser.cached_division_function(rounding, span).unwrap_err()
                    } else {
                        parser
                            .division_local("pending", Scalar::U32, span)
                            .unwrap_err()
                    };
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert!(parser.module.functions.is_empty());
                    assert_eq!(parser.division_function, None);
                    assert_eq!(parser.division_rz_function, None);
                }
            }
        }
    }
}
