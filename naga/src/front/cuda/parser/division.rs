use super::*;

impl Parser<'_> {
    pub(super) fn divide_f32(
        &mut self,
        numerator: Handle<Expression>,
        denominator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let numerator_bits = self.division_cast(numerator, ScalarKind::Uint, None, span)?;
        let denominator_bits = self.division_cast(denominator, ScalarKind::Uint, None, span)?;
        let function = self.cached_division_function(span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(2, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let result = self.append_call_result(function, span)?;
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![numerator_bits, denominator_bits],
                result: Some(result),
            },
            span,
        );
        self.division_cast(result, ScalarKind::Float, None, span)
    }

    fn cached_division_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.division_function {
            return Ok(function);
        }
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_division_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let function = self.module.functions.append(helper.ir, span);
        self.division_function = Some(function);
        Ok(function)
    }

    fn build_division_function(&mut self, span: Span) -> Result<(), ParseError> {
        let scalar_ty = self.scalar_handle(Scalar::U32, span);
        self.function.ir.name = Some(String::from("_naga_divide_f32"));
        for name in ["numerator_bits", "denominator_bits"] {
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
        self.division_return_if(invalid, quiet_nan, span);
        let infinite_result = self.division_binary(
            BinaryOperator::LogicalOr,
            numerator_infinite,
            denominator_zero,
            span,
        )?;
        self.division_return_if(infinite_result, signed_infinity, span);
        let zero_result = self.division_binary(
            BinaryOperator::LogicalOr,
            numerator_zero,
            denominator_infinite,
            span,
        )?;
        self.division_return_if(zero_result, sign, span);

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
        let exponent_adjustment =
            self.division_cast(ratio_below_one, ScalarKind::Sint, Some(4), span)?;
        let exponent = self.division_binary(
            BinaryOperator::Subtract,
            exponent_difference,
            exponent_adjustment,
            span,
        )?;
        let minimum_exponent = self.append(Expression::Literal(Literal::I32(-150)), span)?;
        let too_small =
            self.division_binary(BinaryOperator::Less, exponent, minimum_exponent, span)?;
        self.division_return_if(too_small, sign, span);

        let quotient = self.division_local("quotient", Scalar::U32, span)?;
        let remainder = self.division_local("remainder", Scalar::U32, span)?;
        let iteration = self.division_local("iteration", Scalar::U32, span)?;
        let initial_remainder = self.division_binary(
            BinaryOperator::Subtract,
            normalized_numerator,
            denominator_significand,
            span,
        )?;
        self.division_store(quotient, one, span);
        self.division_store(remainder, initial_remainder, span);
        self.division_store(iteration, zero, span);
        let fraction_width = self.division_literal(23, span)?;
        let ((), body) = self.capture_block(|parser| {
            let current_iteration = parser.division_load(iteration, span)?;
            let finished = parser.division_binary(
                BinaryOperator::GreaterEqual,
                current_iteration,
                fraction_width,
                span,
            )?;
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
            parser.division_store(remainder, next_remainder, span);
            parser.division_store(quotient, next_quotient, span);
            Ok(())
        })?;
        let ((), continuing) = self.capture_block(|parser| {
            let current = parser.division_load(iteration, span)?;
            let next = parser.division_binary(BinaryOperator::Add, current, one, span)?;
            parser.division_store(iteration, next, span);
            Ok(())
        })?;
        self.push_statement(
            Statement::Loop {
                body,
                continuing,
                break_if: None,
            },
            span,
        );
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
            let shift = parser.division_cast(shift, ScalarKind::Uint, Some(4), span)?;
            let shift_mask = parser.division_literal(31, span)?;
            let shift = parser.division_binary(BinaryOperator::And, shift, shift_mask, span)?;
            let integral_unit =
                parser.division_binary(BinaryOperator::ShiftLeft, one, shift, span)?;
            let discarded_mask =
                parser.division_binary(BinaryOperator::Subtract, integral_unit, one, span)?;
            let discarded =
                parser.division_binary(BinaryOperator::And, quotient, discarded_mask, span)?;
            let half =
                parser.division_binary(BinaryOperator::ShiftRight, integral_unit, one, span)?;
            let truncated =
                parser.division_binary(BinaryOperator::ShiftRight, quotient, shift, span)?;
            let above_half =
                parser.division_binary(BinaryOperator::Greater, discarded, half, span)?;
            let at_half = parser.division_binary(BinaryOperator::Equal, discarded, half, span)?;
            let sticky = parser.division_binary(BinaryOperator::NotEqual, remainder, zero, span)?;
            let odd_bits = parser.division_binary(BinaryOperator::And, truncated, one, span)?;
            let is_odd = parser.division_binary(BinaryOperator::NotEqual, odd_bits, zero, span)?;
            let sticky_or_odd =
                parser.division_binary(BinaryOperator::LogicalOr, sticky, is_odd, span)?;
            let round_tie =
                parser.division_binary(BinaryOperator::LogicalAnd, at_half, sticky_or_odd, span)?;
            let rounds_up =
                parser.division_binary(BinaryOperator::LogicalOr, above_half, round_tie, span)?;
            let increment = parser.division_select(rounds_up, one, zero, span)?;
            let rounded =
                parser.division_binary(BinaryOperator::Add, truncated, increment, span)?;
            let result =
                parser.division_binary(BinaryOperator::InclusiveOr, sign, rounded, span)?;
            parser.push_statement(
                Statement::Return {
                    value: Some(result),
                },
                span,
            );
            Ok(())
        })?;
        self.push_statement(
            Statement::If {
                condition: is_subnormal,
                accept: subnormal,
                reject: crate::Block::new(),
            },
            span,
        );
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
        let is_odd = self.division_binary(BinaryOperator::NotEqual, odd_bits, zero, span)?;
        let round_tie = self.division_binary(BinaryOperator::LogicalAnd, at_half, is_odd, span)?;
        let rounds_up =
            self.division_binary(BinaryOperator::LogicalOr, above_half, round_tie, span)?;
        let increment = self.division_select(rounds_up, one, zero, span)?;
        let rounded = self.division_binary(BinaryOperator::Add, quotient, increment, span)?;
        let significand_width = self.division_literal(24, span)?;
        let carry =
            self.division_binary(BinaryOperator::ShiftRight, rounded, significand_width, span)?;
        let normalized = self.division_binary(BinaryOperator::ShiftRight, rounded, carry, span)?;
        let carry = self.division_cast(carry, ScalarKind::Sint, Some(4), span)?;
        let exponent = self.division_binary(BinaryOperator::Add, exponent, carry, span)?;
        let maximum_exponent = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let overflow =
            self.division_binary(BinaryOperator::Greater, exponent, maximum_exponent, span)?;
        self.division_return_if(overflow, signed_infinity, span);
        let biased_exponent =
            self.division_binary(BinaryOperator::Add, exponent, maximum_exponent, span)?;
        let exponent_bits = self.division_cast(biased_exponent, ScalarKind::Uint, Some(4), span)?;
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
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
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
        let exponent_value = self.division_cast(exponent_bits, ScalarKind::Sint, Some(4), span)?;
        let bias = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let normal_exponent =
            self.division_binary(BinaryOperator::Subtract, exponent_value, bias, span)?;
        self.division_store(significand, normal_significand, span);
        self.division_store(exponent, normal_exponent, span);
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
            parser.division_store(significand, normalized, span);
            let minimum_exponent = parser.append(Expression::Literal(Literal::I32(-126)), span)?;
            let shift = parser.division_cast(shift, ScalarKind::Sint, Some(4), span)?;
            let adjusted =
                parser.division_binary(BinaryOperator::Subtract, minimum_exponent, shift, span)?;
            parser.division_store(exponent, adjusted, span);
            Ok(())
        })?;
        self.push_statement(
            Statement::If {
                condition: is_subnormal,
                accept: normalize,
                reject: crate::Block::new(),
            },
            span,
        );
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
        kind: ScalarKind,
        convert: Option<u8>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(
            Expression::As {
                expr,
                kind,
                convert,
            },
            span,
        )
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
        let ty = self.scalar_handle(scalar, span);
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
    ) {
        self.push_statement(Statement::Store { pointer, value }, span);
    }

    fn division_return_if(
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
