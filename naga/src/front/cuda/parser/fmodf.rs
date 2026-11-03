use super::*;

impl Parser<'_> {
    pub(super) fn call_fmodf(
        &mut self,
        dividend: Handle<Expression>,
        divisor: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let dividend_bits = self.fmodf_cast(dividend, ScalarKind::Uint, None, span)?;
        let divisor_bits = self.fmodf_cast(divisor, ScalarKind::Uint, None, span)?;
        let function = self.cached_fmodf_function(span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(2, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let result = self.append_call_result(function, span)?;
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![dividend_bits, divisor_bits],
                result: Some(result),
            },
            span,
        );
        self.fmodf_cast(result, ScalarKind::Float, None, span)
    }

    fn cached_fmodf_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        if let Some(function) = self.fmodf_function {
            return Ok(function);
        }
        let caller = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Device),
        );
        let result = self.build_fmodf_function(span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        self.parameter_expansion_budget
            .charge_slice::<(Function, Span)>(1, span)?;
        let function = self.module.functions.append(helper.ir, span);
        self.fmodf_function = Some(function);
        Ok(function)
    }

    fn build_fmodf_function(&mut self, span: Span) -> Result<(), ParseError> {
        let scalar_ty = self.scalar_handle(Scalar::U32, span);
        self.function.ir.name = Some(String::from("_naga_fmodf"));
        for name in ["dividend_bits", "divisor_bits"] {
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
        let dividend_bits = self.append(Expression::FunctionArgument(0), span)?;
        let divisor_bits = self.append(Expression::FunctionArgument(1), span)?;
        let zero = self.fmodf_literal(0, span)?;
        let one = self.fmodf_literal(1, span)?;
        let magnitude_mask = self.fmodf_literal(0x7fff_ffff, span)?;
        let sign_mask = self.fmodf_literal(0x8000_0000, span)?;
        let infinity = self.fmodf_literal(0x7f80_0000, span)?;
        let quiet_nan = self.fmodf_literal(0x7fc0_0000, span)?;
        let dividend_magnitude =
            self.fmodf_binary(BinaryOperator::And, dividend_bits, magnitude_mask, span)?;
        let divisor_magnitude =
            self.fmodf_binary(BinaryOperator::And, divisor_bits, magnitude_mask, span)?;
        let sign = self.fmodf_binary(BinaryOperator::And, dividend_bits, sign_mask, span)?;
        let invalid_dividend = self.fmodf_binary(
            BinaryOperator::GreaterEqual,
            dividend_magnitude,
            infinity,
            span,
        )?;
        let divisor_nan =
            self.fmodf_binary(BinaryOperator::Greater, divisor_magnitude, infinity, span)?;
        let divisor_zero =
            self.fmodf_binary(BinaryOperator::Equal, divisor_magnitude, zero, span)?;
        let invalid_divisor =
            self.fmodf_binary(BinaryOperator::LogicalOr, divisor_nan, divisor_zero, span)?;
        let invalid = self.fmodf_binary(
            BinaryOperator::LogicalOr,
            invalid_dividend,
            invalid_divisor,
            span,
        )?;
        self.fmodf_return_if(invalid, quiet_nan, span);
        let below_divisor = self.fmodf_binary(
            BinaryOperator::Less,
            dividend_magnitude,
            divisor_magnitude,
            span,
        )?;
        self.fmodf_return_if(below_divisor, dividend_bits, span);
        let equal_magnitudes = self.fmodf_binary(
            BinaryOperator::Equal,
            dividend_magnitude,
            divisor_magnitude,
            span,
        )?;
        self.fmodf_return_if(equal_magnitudes, sign, span);

        let (dividend_significand, dividend_exponent) = self.division_normalize(
            dividend_magnitude,
            "dividend_significand",
            "dividend_exponent",
            span,
        )?;
        let (divisor_significand, divisor_exponent) = self.division_normalize(
            divisor_magnitude,
            "divisor_significand",
            "divisor_exponent",
            span,
        )?;
        let remainder = self.fmodf_local("remainder", span)?;
        let remaining_bits = self.fmodf_local("remaining_bits", span)?;
        self.fmodf_store(remainder, dividend_significand, span);
        let exponent_difference = self.fmodf_binary(
            BinaryOperator::Subtract,
            dividend_exponent,
            divisor_exponent,
            span,
        )?;
        let exponent_difference =
            self.fmodf_cast(exponent_difference, ScalarKind::Uint, Some(4), span)?;
        self.fmodf_store(remaining_bits, exponent_difference, span);
        let ((), body) = self.capture_block(|parser| {
            let current_bits = parser.append(
                Expression::Load {
                    pointer: remaining_bits,
                },
                span,
            )?;
            let finished = parser.fmodf_binary(BinaryOperator::Equal, current_bits, zero, span)?;
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
            let current_remainder = parser.append(Expression::Load { pointer: remainder }, span)?;
            let reduced = parser.fmodf_reduce(current_remainder, divisor_significand, span)?;
            let shifted = parser.fmodf_binary(BinaryOperator::ShiftLeft, reduced, one, span)?;
            parser.fmodf_store(remainder, shifted, span);
            let next_bits =
                parser.fmodf_binary(BinaryOperator::Subtract, current_bits, one, span)?;
            parser.fmodf_store(remaining_bits, next_bits, span);
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
        let remainder = self.append(Expression::Load { pointer: remainder }, span)?;
        let remainder = self.fmodf_reduce(remainder, divisor_significand, span)?;
        let is_zero = self.fmodf_binary(BinaryOperator::Equal, remainder, zero, span)?;
        self.fmodf_return_if(is_zero, sign, span);
        let leading_zeros = self.append(
            Expression::Math {
                fun: crate::MathFunction::CountLeadingZeros,
                arg: remainder,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let eight = self.fmodf_literal(8, span)?;
        let shift = self.fmodf_binary(BinaryOperator::Subtract, leading_zeros, eight, span)?;
        let significand = self.fmodf_binary(BinaryOperator::ShiftLeft, remainder, shift, span)?;
        let shift = self.fmodf_cast(shift, ScalarKind::Sint, Some(4), span)?;
        let exponent =
            self.fmodf_binary(BinaryOperator::Subtract, divisor_exponent, shift, span)?;
        let minimum_exponent = self.append(Expression::Literal(Literal::I32(-126)), span)?;
        let is_normal = self.fmodf_binary(
            BinaryOperator::GreaterEqual,
            exponent,
            minimum_exponent,
            span,
        )?;
        let bias = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let biased_exponent = self.fmodf_binary(BinaryOperator::Add, exponent, bias, span)?;
        let biased_exponent = self.fmodf_cast(biased_exponent, ScalarKind::Uint, Some(4), span)?;
        let fraction_width = self.fmodf_literal(23, span)?;
        let exponent_bits = self.fmodf_binary(
            BinaryOperator::ShiftLeft,
            biased_exponent,
            fraction_width,
            span,
        )?;
        let fraction_mask = self.fmodf_literal(0x007f_ffff, span)?;
        let fraction = self.fmodf_binary(BinaryOperator::And, significand, fraction_mask, span)?;
        let normal_bits =
            self.fmodf_binary(BinaryOperator::InclusiveOr, exponent_bits, fraction, span)?;
        let subnormal_shift =
            self.fmodf_binary(BinaryOperator::Subtract, minimum_exponent, exponent, span)?;
        let subnormal_shift = self.fmodf_cast(subnormal_shift, ScalarKind::Uint, Some(4), span)?;
        let shift_mask = self.fmodf_literal(31, span)?;
        let subnormal_shift =
            self.fmodf_binary(BinaryOperator::And, subnormal_shift, shift_mask, span)?;
        let subnormal_bits = self.fmodf_binary(
            BinaryOperator::ShiftRight,
            significand,
            subnormal_shift,
            span,
        )?;
        let magnitude = self.append(
            Expression::Select {
                condition: is_normal,
                accept: normal_bits,
                reject: subnormal_bits,
            },
            span,
        )?;
        let result = self.fmodf_binary(BinaryOperator::InclusiveOr, sign, magnitude, span)?;
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
        Ok(())
    }

    fn fmodf_reduce(
        &mut self,
        remainder: Handle<Expression>,
        divisor: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let subtract = self.fmodf_binary(BinaryOperator::GreaterEqual, remainder, divisor, span)?;
        let reduced = self.fmodf_binary(BinaryOperator::Subtract, remainder, divisor, span)?;
        self.append(
            Expression::Select {
                condition: subtract,
                accept: reduced,
                reject: remainder,
            },
            span,
        )
    }

    fn fmodf_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn fmodf_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn fmodf_cast(
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

    fn fmodf_local(&mut self, name: &str, span: Span) -> Result<Handle<Expression>, ParseError> {
        let ty = self.scalar_handle(Scalar::U32, span);
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

    fn fmodf_store(&mut self, pointer: Handle<Expression>, value: Handle<Expression>, span: Span) {
        self.push_statement(Statement::Store { pointer, value }, span);
    }

    fn fmodf_return_if(
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
