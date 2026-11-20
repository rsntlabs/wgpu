use super::*;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum RemainderMode {
    Truncate,
    NearestEven,
}

impl Parser<'_> {
    pub(super) fn lower_float_remainder_call(
        &mut self,
        mode: RemainderMode,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let conversions = arguments
            .iter()
            .filter(|argument| {
                self.source_scalar(&argument.ty) != Some(SourceScalar::Scalar(Scalar::F32))
            })
            .count();
        self.parameter_expansion_budget
            .preflight_expressions(conversions + 2, span)?;
        let mut arguments = arguments.into_iter();
        let dividend = self
            .convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?
            .handle;
        let divisor = self
            .convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?
            .handle;
        let dividend_bits = self.bitcast_scalar(dividend, Scalar::U32, span)?;
        let divisor_bits = self.bitcast_scalar(divisor, Scalar::U32, span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(2, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_remainder_function(mode, span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![dividend_bits, divisor_bits],
                result: Some(result),
            },
            span,
        );
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

    fn cached_remainder_function(
        &mut self,
        mode: RemainderMode,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match mode {
            RemainderMode::Truncate => self.fmodf_function,
            RemainderMode::NearestEven => self.remainderf_function,
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
        let result = self.build_remainder_function(mode, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match mode {
            RemainderMode::Truncate => self.fmodf_function = Some(function),
            RemainderMode::NearestEven => self.remainderf_function = Some(function),
        }
        Ok(function)
    }

    fn build_remainder_function(
        &mut self,
        mode: RemainderMode,
        span: Span,
    ) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let scalar_ty = self.scalar_handle(Scalar::U32, span);
        let name = match mode {
            RemainderMode::Truncate => "_naga_fmodf",
            RemainderMode::NearestEven => "_naga_remainderf",
        };
        let arguments = ["dividend_bits", "divisor_bits"];
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
        self.fmodf_return_if(invalid, quiet_nan, span)?;
        let unchanged = match mode {
            RemainderMode::Truncate => self.fmodf_binary(
                BinaryOperator::Less,
                dividend_magnitude,
                divisor_magnitude,
                span,
            )?,
            RemainderMode::NearestEven => {
                let dividend_zero =
                    self.fmodf_binary(BinaryOperator::Equal, dividend_magnitude, zero, span)?;
                let divisor_infinite =
                    self.fmodf_binary(BinaryOperator::Equal, divisor_magnitude, infinity, span)?;
                self.fmodf_binary(
                    BinaryOperator::LogicalOr,
                    dividend_zero,
                    divisor_infinite,
                    span,
                )?
            }
        };
        self.fmodf_return_if(unchanged, dividend_bits, span)?;
        let equal_magnitudes = self.fmodf_binary(
            BinaryOperator::Equal,
            dividend_magnitude,
            divisor_magnitude,
            span,
        )?;
        self.fmodf_return_if(equal_magnitudes, sign, span)?;

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
        self.fmodf_store(remainder, dividend_significand, span)?;
        let exponent_difference = self.fmodf_binary(
            BinaryOperator::Subtract,
            dividend_exponent,
            divisor_exponent,
            span,
        )?;
        let (divisor_significand, unit_exponent, exponent_difference) = match mode {
            RemainderMode::Truncate => (divisor_significand, divisor_exponent, exponent_difference),
            RemainderMode::NearestEven => {
                let minus_one = self.append(Expression::Literal(Literal::I32(-1)), span)?;
                let too_small =
                    self.fmodf_binary(BinaryOperator::Less, exponent_difference, minus_one, span)?;
                self.fmodf_return_if(too_small, dividend_bits, span)?;
                let signed_zero = self.append(Expression::Literal(Literal::I32(0)), span)?;
                let one_below =
                    self.fmodf_binary(BinaryOperator::Equal, exponent_difference, minus_one, span)?;
                // With one less exponent bit, use the dividend's units and double the divisor.
                let doubled =
                    self.fmodf_binary(BinaryOperator::ShiftLeft, divisor_significand, one, span)?;
                (
                    self.fmodf_select(one_below, doubled, divisor_significand, span)?,
                    self.fmodf_select(one_below, dividend_exponent, divisor_exponent, span)?,
                    self.fmodf_select(one_below, signed_zero, exponent_difference, span)?,
                )
            }
        };
        let exponent_difference = self.fmodf_cast(exponent_difference, Scalar::U32, span)?;
        self.fmodf_store(remaining_bits, exponent_difference, span)?;
        let ((), body) = self.capture_block(|parser| {
            let current_bits = parser.append(
                Expression::Load {
                    pointer: remaining_bits,
                },
                span,
            )?;
            let finished = parser.fmodf_binary(BinaryOperator::Equal, current_bits, zero, span)?;
            parser.charge_fmodf_statements(2, span)?;
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
            parser.fmodf_store(remainder, shifted, span)?;
            let next_bits =
                parser.fmodf_binary(BinaryOperator::Subtract, current_bits, one, span)?;
            parser.fmodf_store(remaining_bits, next_bits, span)?;
            Ok(())
        })?;
        self.charge_fmodf_statements(1, span)?;
        self.push_statement(
            Statement::Loop {
                body,
                continuing: crate::Block::new(),
                break_if: None,
            },
            span,
        );
        let remainder = self.append(Expression::Load { pointer: remainder }, span)?;
        let (remainder, sign) = match mode {
            RemainderMode::Truncate => (
                self.fmodf_reduce(remainder, divisor_significand, span)?,
                sign,
            ),
            RemainderMode::NearestEven => {
                self.nearest_remainder(remainder, divisor_significand, sign, span)?
            }
        };
        let is_zero = self.fmodf_binary(BinaryOperator::Equal, remainder, zero, span)?;
        self.fmodf_return_if(is_zero, sign, span)?;
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
        let shift = self.fmodf_cast(shift, Scalar::I32, span)?;
        let exponent = self.fmodf_binary(BinaryOperator::Subtract, unit_exponent, shift, span)?;
        let minimum_exponent = self.append(Expression::Literal(Literal::I32(-126)), span)?;
        let is_normal = self.fmodf_binary(
            BinaryOperator::GreaterEqual,
            exponent,
            minimum_exponent,
            span,
        )?;
        let bias = self.append(Expression::Literal(Literal::I32(127)), span)?;
        let biased_exponent = self.fmodf_binary(BinaryOperator::Add, exponent, bias, span)?;
        let biased_exponent = self.fmodf_cast(biased_exponent, Scalar::U32, span)?;
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
        let subnormal_shift = self.fmodf_cast(subnormal_shift, Scalar::U32, span)?;
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
        self.charge_fmodf_statements(1, span)?;
        self.push_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        );
        Ok(())
    }

    fn nearest_remainder(
        &mut self,
        unreduced: Handle<Expression>,
        divisor: Handle<Expression>,
        sign: Handle<Expression>,
        span: Span,
    ) -> Result<(Handle<Expression>, Handle<Expression>), ParseError> {
        use BinaryOperator as Op;

        // The final reduction determines the low bit of the truncated quotient.
        let odd = self.fmodf_binary(Op::GreaterEqual, unreduced, divisor, span)?;
        let reduced = self.fmodf_binary(Op::Subtract, unreduced, divisor, span)?;
        let remainder = self.fmodf_select(odd, reduced, unreduced, span)?;
        let twice = self.fmodf_binary(Op::Add, remainder, remainder, span)?;
        let above_half = self.fmodf_binary(Op::Greater, twice, divisor, span)?;
        let at_half = self.fmodf_binary(Op::Equal, twice, divisor, span)?;
        let odd_tie = self.fmodf_binary(Op::LogicalAnd, at_half, odd, span)?;
        let round_up = self.fmodf_binary(Op::LogicalOr, above_half, odd_tie, span)?;
        let complement = self.fmodf_binary(Op::Subtract, divisor, remainder, span)?;
        let sign_mask = self.fmodf_literal(0x8000_0000, span)?;
        let flipped = self.fmodf_binary(Op::ExclusiveOr, sign, sign_mask, span)?;
        Ok((
            self.fmodf_select(round_up, complement, remainder, span)?,
            self.fmodf_select(round_up, flipped, sign, span)?,
        ))
    }

    fn fmodf_reduce(
        &mut self,
        remainder: Handle<Expression>,
        divisor: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let subtract = self.fmodf_binary(BinaryOperator::GreaterEqual, remainder, divisor, span)?;
        let reduced = self.fmodf_binary(BinaryOperator::Subtract, remainder, divisor, span)?;
        self.fmodf_select(subtract, reduced, remainder, span)
    }

    fn fmodf_select(
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
        target: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::As { expr, target }, span)
    }

    fn fmodf_local(&mut self, name: &str, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(LocalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
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

    fn charge_fmodf_statements(&mut self, count: usize, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(count, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(count, span)
    }

    fn fmodf_store(
        &mut self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.charge_fmodf_statements(1, span)?;
        self.push_statement(Statement::Store { pointer, value }, span);
        Ok(())
    }

    fn fmodf_return_if(
        &mut self,
        condition: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.charge_fmodf_statements(2, span)?;
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
        Ok(())
    }
}
