use super::*;

#[derive(Clone, Copy)]
enum SqrtRounding {
    NearestEven,
    TowardZero,
    TowardPositive,
}

impl Parser<'_> {
    pub(super) fn lower_sqrt_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_sqrt_with_rounding(arguments, SqrtRounding::NearestEven, span)
    }

    pub(super) fn lower_sqrt_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_sqrt_with_rounding(arguments, SqrtRounding::TowardZero, span)
    }

    pub(super) fn lower_sqrt_ru_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_sqrt_with_rounding(arguments, SqrtRounding::TowardPositive, span)
    }

    fn lower_sqrt_with_rounding(
        &mut self,
        arguments: Vec<Value>,
        rounding: SqrtRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let argument =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
        let handle = match rounding {
            SqrtRounding::NearestEven => self.call_sqrtf(argument.handle, span)?,
            SqrtRounding::TowardZero => self.call_sqrtf_rz(argument.handle, span)?,
            SqrtRounding::TowardPositive => {
                self.call_sqrtf_with_rounding(argument.handle, rounding, span)?
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

    pub(super) fn call_sqrtf(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_sqrtf_with_rounding(value, SqrtRounding::NearestEven, span)
    }

    pub(super) fn call_sqrtf_rz(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_sqrtf_with_rounding(value, SqrtRounding::TowardZero, span)
    }

    fn call_sqrtf_with_rounding(
        &mut self,
        value: Handle<Expression>,
        rounding: SqrtRounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let bits = self.bitcast_scalar(value, Scalar::U32, span)?;
        let result = match rounding {
            SqrtRounding::NearestEven => self.call_sqrtf_bits(bits, rounding, span)?,
            SqrtRounding::TowardZero => self.call_sqrtf_rz_bits(bits, span)?,
            SqrtRounding::TowardPositive => self.call_sqrtf_bits(bits, rounding, span)?,
        };
        self.bitcast_scalar(result, Scalar::F32, span)
    }

    pub(super) fn call_sqrtf_rz_bits(
        &mut self,
        bits: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_sqrtf_bits(bits, SqrtRounding::TowardZero, span)
    }

    fn call_sqrtf_bits(
        &mut self,
        bits: Handle<Expression>,
        rounding: SqrtRounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = match rounding {
            SqrtRounding::NearestEven => self.sqrtf_function(span)?,
            SqrtRounding::TowardZero | SqrtRounding::TowardPositive => {
                self.cached_sqrtf_function(rounding, span)?
            }
        };
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![bits],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    pub(super) fn sqrtf_function(&mut self, span: Span) -> Result<Handle<Function>, ParseError> {
        self.cached_sqrtf_function(SqrtRounding::NearestEven, span)
    }

    fn cached_sqrtf_function(
        &mut self,
        rounding: SqrtRounding,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match rounding {
            SqrtRounding::NearestEven => self.sqrtf_function,
            SqrtRounding::TowardZero => self.sqrtf_rz_function,
            SqrtRounding::TowardPositive => self.sqrtf_ru_function,
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
        let result = self.build_sqrtf_function(rounding, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match rounding {
            SqrtRounding::NearestEven => self.sqrtf_function = Some(function),
            SqrtRounding::TowardZero => self.sqrtf_rz_function = Some(function),
            SqrtRounding::TowardPositive => self.sqrtf_ru_function = Some(function),
        }
        Ok(function)
    }

    fn build_sqrtf_function(
        &mut self,
        rounding: SqrtRounding,
        span: Span,
    ) -> Result<(), ParseError> {
        self.prepare_parameter_bindings(span)?;
        let scalar_ty = self.sqrtf_scalar_handle(span)?;
        let name = match rounding {
            SqrtRounding::NearestEven => "_naga_sqrtf",
            SqrtRounding::TowardZero => "_naga_sqrtf_rz",
            SqrtRounding::TowardPositive => "_naga_sqrtf_ru",
        };
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len() + "input_bits".len(), span)?;
        self.function.ir.name = Some(String::from(name));
        self.function.ir.arguments.push(FunctionArgument {
            name: Some(String::from("input_bits")),
            ty: scalar_ty,
            binding: None,
        });
        self.function.ir.result = Some(crate::FunctionResult {
            ty: scalar_ty,
            binding: None,
        });

        let input_bits = self.append(Expression::FunctionArgument(0), span)?;
        let zero = self.sqrtf_literal(0, span)?;
        let one = self.sqrtf_literal(1, span)?;
        let magnitude_mask = self.sqrtf_literal(0x7fff_ffff, span)?;
        let infinity = self.sqrtf_literal(0x7f80_0000, span)?;
        let magnitude = self.sqrtf_binary(BinaryOperator::And, input_bits, magnitude_mask, span)?;
        let is_zero = self.sqrtf_binary(BinaryOperator::Equal, magnitude, zero, span)?;
        let is_positive_infinity =
            self.sqrtf_binary(BinaryOperator::Equal, input_bits, infinity, span)?;
        let preserve_input = self.sqrtf_binary(
            BinaryOperator::LogicalOr,
            is_zero,
            is_positive_infinity,
            span,
        )?;
        self.sqrtf_return_if(preserve_input, input_bits, span)?;

        let sign_mask = self.sqrtf_literal(0x8000_0000, span)?;
        let sign = self.sqrtf_binary(BinaryOperator::And, input_bits, sign_mask, span)?;
        let is_negative = self.sqrtf_binary(BinaryOperator::NotEqual, sign, zero, span)?;
        let is_nan = self.sqrtf_binary(BinaryOperator::Greater, magnitude, infinity, span)?;
        let invalid = self.sqrtf_binary(BinaryOperator::LogicalOr, is_negative, is_nan, span)?;
        let quiet_nan = self.sqrtf_literal(0x7fc0_0000, span)?;
        self.sqrtf_return_if(invalid, quiet_nan, span)?;

        let fraction_mask = self.sqrtf_literal(0x007f_ffff, span)?;
        let implicit_bit = self.sqrtf_literal(0x0080_0000, span)?;
        let twenty_three = self.sqrtf_literal(23, span)?;
        let exponent_bias = self.sqrtf_literal(127, span)?;
        let fraction = self.sqrtf_binary(BinaryOperator::And, input_bits, fraction_mask, span)?;
        let exponent_bits =
            self.sqrtf_binary(BinaryOperator::ShiftRight, magnitude, twenty_three, span)?;
        let significand = self.sqrtf_local("significand", span)?;
        // Keep the unbiased exponent plus 254 so subnormal exponents stay unsigned.
        let adjusted_exponent = self.sqrtf_local("adjusted_exponent", span)?;
        let normal_significand =
            self.sqrtf_binary(BinaryOperator::InclusiveOr, fraction, implicit_bit, span)?;
        self.sqrtf_store(significand, normal_significand, span)?;
        let normal_exponent =
            self.sqrtf_binary(BinaryOperator::Add, exponent_bits, exponent_bias, span)?;
        self.sqrtf_store(adjusted_exponent, normal_exponent, span)?;

        let is_subnormal = self.sqrtf_binary(BinaryOperator::Equal, exponent_bits, zero, span)?;
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
            let eight = parser.sqrtf_literal(8, span)?;
            let normalization_shift =
                parser.sqrtf_binary(BinaryOperator::Subtract, leading_zeros, eight, span)?;
            let normalized_significand = parser.sqrtf_binary(
                BinaryOperator::ShiftLeft,
                fraction,
                normalization_shift,
                span,
            )?;
            parser.sqrtf_store(significand, normalized_significand, span)?;
            let subnormal_bias = parser.sqrtf_literal(128, span)?;
            let normalized_exponent = parser.sqrtf_binary(
                BinaryOperator::Subtract,
                subnormal_bias,
                normalization_shift,
                span,
            )?;
            parser.sqrtf_store(adjusted_exponent, normalized_exponent, span)?;
            Ok(())
        })?;
        self.sqrtf_statement(
            Statement::If {
                condition: is_subnormal,
                accept: normalize,
                reject: crate::Block::new(),
            },
            span,
        )?;

        let normalized_significand = self.sqrtf_load(significand, span)?;
        let normalized_exponent = self.sqrtf_load(adjusted_exponent, span)?;
        let exponent_parity =
            self.sqrtf_binary(BinaryOperator::And, normalized_exponent, one, span)?;
        let lower_shift =
            self.sqrtf_binary(BinaryOperator::Add, twenty_three, exponent_parity, span)?;
        let nine = self.sqrtf_literal(9, span)?;
        let upper_shift =
            self.sqrtf_binary(BinaryOperator::Subtract, nine, exponent_parity, span)?;
        // The 48-bit radicand is significand << (23 + exponent parity).
        let upper_bits = self.sqrtf_binary(
            BinaryOperator::ShiftRight,
            normalized_significand,
            upper_shift,
            span,
        )?;
        let lower_bits = self.sqrtf_binary(
            BinaryOperator::ShiftLeft,
            normalized_significand,
            lower_shift,
            span,
        )?;
        let upper_word = self.sqrtf_local("upper_word", span)?;
        let lower_word = self.sqrtf_local("lower_word", span)?;
        let root = self.sqrtf_local("root", span)?;
        let remainder = self.sqrtf_local("remainder", span)?;
        let iteration = self.sqrtf_local("iteration", span)?;
        self.sqrtf_store(upper_word, upper_bits, span)?;
        self.sqrtf_store(lower_word, lower_bits, span)?;
        self.sqrtf_store(root, zero, span)?;
        self.sqrtf_store(remainder, zero, span)?;
        self.sqrtf_store(iteration, zero, span)?;

        let two = self.sqrtf_literal(2, span)?;
        let fourteen = self.sqrtf_literal(14, span)?;
        let thirty = self.sqrtf_literal(30, span)?;
        let upper_mask = self.sqrtf_literal(0xffff, span)?;
        let iteration_count = self.sqrtf_literal(24, span)?;
        let ((), body) = self.capture_block(|parser| {
            let current_iteration = parser.sqrtf_load(iteration, span)?;
            let finished = parser.sqrtf_binary(
                BinaryOperator::GreaterEqual,
                current_iteration,
                iteration_count,
                span,
            )?;
            parser.parameter_expansion_budget.charge_nodes(1, span)?;
            parser
                .parameter_expansion_budget
                .charge_slice::<(Statement, Span)>(1, span)?;
            let mut accept = crate::Block::new();
            accept.push(Statement::Break, span);
            parser.sqrtf_statement(
                Statement::If {
                    condition: finished,
                    accept,
                    reject: crate::Block::new(),
                },
                span,
            )?;

            let current_upper = parser.sqrtf_load(upper_word, span)?;
            let current_lower = parser.sqrtf_load(lower_word, span)?;
            let current_root = parser.sqrtf_load(root, span)?;
            let current_remainder = parser.sqrtf_load(remainder, span)?;
            let digit_pair =
                parser.sqrtf_binary(BinaryOperator::ShiftRight, current_upper, fourteen, span)?;
            let shifted_upper =
                parser.sqrtf_binary(BinaryOperator::ShiftLeft, current_upper, two, span)?;
            let carry_bits =
                parser.sqrtf_binary(BinaryOperator::ShiftRight, current_lower, thirty, span)?;
            let combined_upper = parser.sqrtf_binary(
                BinaryOperator::InclusiveOr,
                shifted_upper,
                carry_bits,
                span,
            )?;
            let next_upper =
                parser.sqrtf_binary(BinaryOperator::And, combined_upper, upper_mask, span)?;
            let next_lower =
                parser.sqrtf_binary(BinaryOperator::ShiftLeft, current_lower, two, span)?;
            let shifted_remainder =
                parser.sqrtf_binary(BinaryOperator::ShiftLeft, current_remainder, two, span)?;
            let expanded_remainder = parser.sqrtf_binary(
                BinaryOperator::InclusiveOr,
                shifted_remainder,
                digit_pair,
                span,
            )?;
            let shifted_trial =
                parser.sqrtf_binary(BinaryOperator::ShiftLeft, current_root, two, span)?;
            let trial =
                parser.sqrtf_binary(BinaryOperator::InclusiveOr, shifted_trial, one, span)?;
            let take_digit = parser.sqrtf_binary(
                BinaryOperator::GreaterEqual,
                expanded_remainder,
                trial,
                span,
            )?;
            let subtracted_remainder =
                parser.sqrtf_binary(BinaryOperator::Subtract, expanded_remainder, trial, span)?;
            let next_remainder = parser.append(
                Expression::Select {
                    condition: take_digit,
                    accept: subtracted_remainder,
                    reject: expanded_remainder,
                },
                span,
            )?;
            let doubled_root =
                parser.sqrtf_binary(BinaryOperator::ShiftLeft, current_root, one, span)?;
            let incremented_root =
                parser.sqrtf_binary(BinaryOperator::InclusiveOr, doubled_root, one, span)?;
            let next_root = parser.append(
                Expression::Select {
                    condition: take_digit,
                    accept: incremented_root,
                    reject: doubled_root,
                },
                span,
            )?;
            parser.sqrtf_store(upper_word, next_upper, span)?;
            parser.sqrtf_store(lower_word, next_lower, span)?;
            parser.sqrtf_store(remainder, next_remainder, span)?;
            parser.sqrtf_store(root, next_root, span)?;
            Ok(())
        })?;
        let ((), continuing) = self.capture_block(|parser| {
            let current_iteration = parser.sqrtf_load(iteration, span)?;
            let next_iteration =
                parser.sqrtf_binary(BinaryOperator::Add, current_iteration, one, span)?;
            parser.sqrtf_store(iteration, next_iteration, span)?;
            Ok(())
        })?;
        self.sqrtf_statement(
            Statement::Loop {
                body,
                continuing,
                break_if: None,
            },
            span,
        )?;

        let floor_root = self.sqrtf_load(root, span)?;
        let rounded_root = match rounding {
            SqrtRounding::NearestEven | SqrtRounding::TowardPositive => {
                let final_remainder = self.sqrtf_load(remainder, span)?;
                // Integer radicands cannot tie. Upward rounding increments any inexact root.
                let threshold = if matches!(rounding, SqrtRounding::TowardPositive) {
                    zero
                } else {
                    floor_root
                };
                let round_up =
                    self.sqrtf_binary(BinaryOperator::Greater, final_remainder, threshold, span)?;
                let incremented_root =
                    self.sqrtf_binary(BinaryOperator::Add, floor_root, one, span)?;
                self.append(
                    Expression::Select {
                        condition: round_up,
                        accept: incremented_root,
                        reject: floor_root,
                    },
                    span,
                )?
            }
            SqrtRounding::TowardZero => floor_root,
        };
        let result_exponent =
            self.sqrtf_binary(BinaryOperator::ShiftRight, normalized_exponent, one, span)?;
        let result_exponent = if matches!(rounding, SqrtRounding::TowardPositive) {
            let width = self.sqrtf_literal(24, span)?;
            let carry = self.sqrtf_binary(BinaryOperator::ShiftRight, rounded_root, width, span)?;
            self.sqrtf_binary(BinaryOperator::Add, result_exponent, carry, span)?
        } else {
            result_exponent
        };
        let fraction_bits =
            self.sqrtf_binary(BinaryOperator::And, rounded_root, fraction_mask, span)?;
        let exponent_bits = self.sqrtf_binary(
            BinaryOperator::ShiftLeft,
            result_exponent,
            twenty_three,
            span,
        )?;
        let result_bits = self.sqrtf_binary(
            BinaryOperator::InclusiveOr,
            exponent_bits,
            fraction_bits,
            span,
        )?;
        self.sqrtf_statement(
            Statement::Return {
                value: Some(result_bits),
            },
            span,
        )?;
        Ok(())
    }

    fn sqrtf_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn sqrtf_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn sqrtf_local(&mut self, name: &str, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(LocalVariable, Span)>(1, span)?;
        self.parameter_expansion_budget
            .charge_bytes(name.len(), span)?;
        let ty = self.sqrtf_scalar_handle(span)?;
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

    fn sqrtf_load(
        &mut self,
        pointer: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Load { pointer }, span)
    }

    fn sqrtf_store(
        &mut self,
        pointer: Handle<Expression>,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(), ParseError> {
        self.sqrtf_statement(Statement::Store { pointer, value }, span)
    }

    fn sqrtf_return_if(
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
        self.sqrtf_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }

    fn sqrtf_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn sqrtf_scalar_handle(&mut self, span: Span) -> Result<Handle<Type>, ParseError> {
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(Scalar::U32),
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
    fn sqrtf_local_and_first_cache_build_preflight_exhausted_budgets() {
        for rounding in [
            SqrtRounding::NearestEven,
            SqrtRounding::TowardZero,
            SqrtRounding::TowardPositive,
        ] {
            for build_helper in [false, true] {
                for exhaust_bytes in [false, true] {
                    let span = Span::new(0, 1);
                    let mut parser = Parser::new(Lexer::new("1").unwrap(), &Options::default());
                    parser.parameter_expansion_budget.activate();
                    parser.prepare_parameter_bindings(span).unwrap();
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
                    let error = if build_helper {
                        parser.cached_sqrtf_function(rounding, span).unwrap_err()
                    } else {
                        parser.sqrtf_local("pending", span).unwrap_err()
                    };
                    assert_eq!(error.span, span);
                    assert!(parser.parameter_expansion_budget.is_exhausted());
                    assert_eq!(format!("{:?}", parser.function.ir), caller);
                    assert_eq!(format!("{:?}", parser.module.types), types);
                    assert!(parser.module.functions.is_empty());
                    assert_eq!(parser.sqrtf_function, None);
                    assert_eq!(parser.sqrtf_rz_function, None);
                    assert_eq!(parser.sqrtf_ru_function, None);
                }
            }
        }
    }
}
