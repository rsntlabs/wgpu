use super::*;

#[derive(Clone, Copy)]
enum AddRounding {
    NearestEven,
    TowardZero,
}

impl Parser<'_> {
    pub(super) fn lower_fadd_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_add_sub_call(arguments, false, AddRounding::NearestEven, span)
    }

    pub(super) fn lower_fsub_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_add_sub_call(arguments, true, AddRounding::NearestEven, span)
    }

    pub(super) fn lower_fadd_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_add_sub_call(arguments, false, AddRounding::TowardZero, span)
    }

    fn lower_add_sub_call(
        &mut self,
        arguments: Vec<Value>,
        subtract: bool,
        rounding: AddRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let left = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let right = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let left = self.bitcast_scalar(left.handle, Scalar::U32, span)?;
        let right = self.bitcast_scalar(right.handle, Scalar::U32, span)?;
        let right = if subtract {
            let sign = self.append(Expression::Literal(Literal::U32(0x8000_0000)), span)?;
            self.append(
                Expression::Binary {
                    op: BinaryOperator::ExclusiveOr,
                    left: right,
                    right: sign,
                },
                span,
            )?
        } else {
            right
        };
        let bits = match rounding {
            AddRounding::NearestEven => self.call_fadd_rn_bits(left, right, span)?,
            AddRounding::TowardZero => self.call_fadd_rz_bits(left, right, span)?,
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

    pub(super) fn call_fadd_rn_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fadd_bits(left, right, AddRounding::NearestEven, span)
    }

    pub(super) fn call_fadd_rz_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fadd_bits(left, right, AddRounding::TowardZero, span)
    }

    fn call_fadd_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        rounding: AddRounding,
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
        let function = self.cached_fadd_function(rounding, span)?;
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

    fn cached_fadd_function(
        &mut self,
        rounding: AddRounding,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match rounding {
            AddRounding::NearestEven => self.fadd_rn_function,
            AddRounding::TowardZero => self.fadd_rz_function,
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
        let result = self.build_fadd_function(rounding, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match rounding {
            AddRounding::NearestEven => self.fadd_rn_function = Some(function),
            AddRounding::TowardZero => self.fadd_rz_function = Some(function),
        }
        Ok(function)
    }

    fn build_fadd_function(&mut self, rounding: AddRounding, span: Span) -> Result<(), ParseError> {
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
            AddRounding::NearestEven => "_naga_fadd_rn",
            AddRounding::TowardZero => "_naga_fadd_rz",
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
        let zero = self.fadd_literal(0, span)?;
        let one = self.fadd_literal(1, span)?;
        let three = self.fadd_literal(3, span)?;
        let magnitude_mask = self.fadd_literal(0x7fff_ffff, span)?;
        let sign_mask = self.fadd_literal(0x8000_0000, span)?;
        let infinity = self.fadd_literal(0x7f80_0000, span)?;
        let nan = self.fadd_literal(0x7fc0_0000, span)?;
        let left_magnitude = self.fadd_binary(BinaryOperator::And, left, magnitude_mask, span)?;
        let right_magnitude = self.fadd_binary(BinaryOperator::And, right, magnitude_mask, span)?;
        let left_sign = self.fadd_binary(BinaryOperator::And, left, sign_mask, span)?;
        let right_sign = self.fadd_binary(BinaryOperator::And, right, sign_mask, span)?;
        let left_nan = self.fadd_binary(BinaryOperator::Greater, left_magnitude, infinity, span)?;
        let right_nan =
            self.fadd_binary(BinaryOperator::Greater, right_magnitude, infinity, span)?;
        let invalid = self.fadd_binary(BinaryOperator::LogicalOr, left_nan, right_nan, span)?;
        self.fadd_return_if(invalid, nan, span)?;
        let left_infinite =
            self.fadd_binary(BinaryOperator::Equal, left_magnitude, infinity, span)?;
        let right_infinite =
            self.fadd_binary(BinaryOperator::Equal, right_magnitude, infinity, span)?;
        let same_sign = self.fadd_binary(BinaryOperator::Equal, left_sign, right_sign, span)?;
        let different_sign =
            self.fadd_binary(BinaryOperator::NotEqual, left_sign, right_sign, span)?;
        let both_infinite = self.fadd_binary(
            BinaryOperator::LogicalAnd,
            left_infinite,
            right_infinite,
            span,
        )?;
        let invalid = self.fadd_binary(
            BinaryOperator::LogicalAnd,
            both_infinite,
            different_sign,
            span,
        )?;
        self.fadd_return_if(invalid, nan, span)?;
        self.fadd_return_if(left_infinite, left, span)?;
        self.fadd_return_if(right_infinite, right, span)?;

        let left_larger = self.fadd_binary(
            BinaryOperator::GreaterEqual,
            left_magnitude,
            right_magnitude,
            span,
        )?;
        let larger = self.fadd_select(left_larger, left_magnitude, right_magnitude, span)?;
        let smaller = self.fadd_select(left_larger, right_magnitude, left_magnitude, span)?;
        let sign = self.fadd_select(left_larger, left_sign, right_sign, span)?;
        let width = self.fadd_literal(23, span)?;
        let fraction_mask = self.fadd_literal(0x007f_ffff, span)?;
        let implicit = self.fadd_literal(0x0080_0000, span)?;
        let larger_exponent = self.fadd_binary(BinaryOperator::ShiftRight, larger, width, span)?;
        let smaller_exponent =
            self.fadd_binary(BinaryOperator::ShiftRight, smaller, width, span)?;
        let larger_normal =
            self.fadd_binary(BinaryOperator::NotEqual, larger_exponent, zero, span)?;
        let smaller_normal =
            self.fadd_binary(BinaryOperator::NotEqual, smaller_exponent, zero, span)?;
        let larger_hidden = self.fadd_select(larger_normal, implicit, zero, span)?;
        let smaller_hidden = self.fadd_select(smaller_normal, implicit, zero, span)?;
        let larger_fraction = self.fadd_binary(BinaryOperator::And, larger, fraction_mask, span)?;
        let smaller_fraction =
            self.fadd_binary(BinaryOperator::And, smaller, fraction_mask, span)?;
        let larger_significand = self.fadd_binary(
            BinaryOperator::InclusiveOr,
            larger_fraction,
            larger_hidden,
            span,
        )?;
        let smaller_significand = self.fadd_binary(
            BinaryOperator::InclusiveOr,
            smaller_fraction,
            smaller_hidden,
            span,
        )?;
        // Three low bits retain guard, round, and sticky information.
        let larger_significand =
            self.fadd_binary(BinaryOperator::ShiftLeft, larger_significand, three, span)?;
        let smaller_significand =
            self.fadd_binary(BinaryOperator::ShiftLeft, smaller_significand, three, span)?;
        let larger_exponent = self.fadd_select(larger_normal, larger_exponent, one, span)?;
        let smaller_exponent = self.fadd_select(smaller_normal, smaller_exponent, one, span)?;
        let distance = self.fadd_binary(
            BinaryOperator::Subtract,
            larger_exponent,
            smaller_exponent,
            span,
        )?;
        let aligned = self.fadd_shift_right_jam(smaller_significand, distance, span)?;
        let sum = self.fadd_binary(BinaryOperator::Add, larger_significand, aligned, span)?;
        let difference =
            self.fadd_binary(BinaryOperator::Subtract, larger_significand, aligned, span)?;
        let significand = self.fadd_select(same_sign, sum, difference, span)?;
        let is_zero = self.fadd_binary(BinaryOperator::Equal, significand, zero, span)?;
        let zero_sign = self.fadd_binary(BinaryOperator::And, left_sign, right_sign, span)?;
        self.fadd_return_if(is_zero, zero_sign, span)?;

        let carry_bit = self.fadd_literal(0x0800_0000, span)?;
        let carry = self.fadd_binary(BinaryOperator::GreaterEqual, significand, carry_bit, span)?;
        let shifted = self.fadd_shift_right_jam(significand, one, span)?;
        let significand = self.fadd_select(carry, shifted, significand, span)?;
        let carry = self.fadd_bool_as_uint(carry, span)?;
        let exponent = self.fadd_binary(BinaryOperator::Add, larger_exponent, carry, span)?;
        let leading_zeros = self.append(
            Expression::Math {
                fun: crate::MathFunction::CountLeadingZeros,
                arg: significand,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let five = self.fadd_literal(5, span)?;
        let normalization =
            self.fadd_binary(BinaryOperator::Subtract, leading_zeros, five, span)?;
        let available = self.fadd_binary(BinaryOperator::Subtract, exponent, one, span)?;
        let normalization = self.append(
            Expression::Math {
                fun: crate::MathFunction::Min,
                arg: normalization,
                arg1: Some(available),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let significand =
            self.fadd_binary(BinaryOperator::ShiftLeft, significand, normalization, span)?;
        let exponent = self.fadd_binary(BinaryOperator::Subtract, exponent, normalization, span)?;
        let (rounded, exponent) = match rounding {
            AddRounding::NearestEven => {
                let seven = self.fadd_literal(7, span)?;
                let four = self.fadd_literal(4, span)?;
                let tail = self.fadd_binary(BinaryOperator::And, significand, seven, span)?;
                let rounded =
                    self.fadd_binary(BinaryOperator::ShiftRight, significand, three, span)?;
                let odd = self.fadd_binary(BinaryOperator::And, rounded, one, span)?;
                let odd = self.fadd_binary(BinaryOperator::NotEqual, odd, zero, span)?;
                let tie = self.fadd_binary(BinaryOperator::Equal, tail, four, span)?;
                let tie_up = self.fadd_binary(BinaryOperator::LogicalAnd, tie, odd, span)?;
                let above_half = self.fadd_binary(BinaryOperator::Greater, tail, four, span)?;
                let increment =
                    self.fadd_binary(BinaryOperator::LogicalOr, above_half, tie_up, span)?;
                let increment = self.fadd_bool_as_uint(increment, span)?;
                let rounded = self.fadd_binary(BinaryOperator::Add, rounded, increment, span)?;
                let rounded_carry_bit = self.fadd_literal(0x0100_0000, span)?;
                let carry = self.fadd_binary(
                    BinaryOperator::GreaterEqual,
                    rounded,
                    rounded_carry_bit,
                    span,
                )?;
                let shifted = self.fadd_binary(BinaryOperator::ShiftRight, rounded, one, span)?;
                let rounded = self.fadd_select(carry, shifted, rounded, span)?;
                let carry = self.fadd_bool_as_uint(carry, span)?;
                let exponent = self.fadd_binary(BinaryOperator::Add, exponent, carry, span)?;
                (rounded, exponent)
            }
            AddRounding::TowardZero => {
                let rounded =
                    self.fadd_binary(BinaryOperator::ShiftRight, significand, three, span)?;
                (rounded, exponent)
            }
        };
        let maximum_exponent = self.fadd_literal(255, span)?;
        let overflow = self.fadd_binary(
            BinaryOperator::GreaterEqual,
            exponent,
            maximum_exponent,
            span,
        )?;
        let overflow_magnitude = match rounding {
            AddRounding::NearestEven => infinity,
            AddRounding::TowardZero => self.fadd_literal(0x7f7f_ffff, span)?,
        };
        let signed_overflow =
            self.fadd_binary(BinaryOperator::InclusiveOr, sign, overflow_magnitude, span)?;
        self.fadd_return_if(overflow, signed_overflow, span)?;
        let normal = self.fadd_binary(BinaryOperator::GreaterEqual, rounded, implicit, span)?;
        let exponent = self.fadd_select(normal, exponent, zero, span)?;
        let exponent_bits = self.fadd_binary(BinaryOperator::ShiftLeft, exponent, width, span)?;
        let fraction = self.fadd_binary(BinaryOperator::And, rounded, fraction_mask, span)?;
        let magnitude =
            self.fadd_binary(BinaryOperator::InclusiveOr, exponent_bits, fraction, span)?;
        let result = self.fadd_binary(BinaryOperator::InclusiveOr, sign, magnitude, span)?;
        self.fadd_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        )
    }

    fn fadd_shift_right_jam(
        &mut self,
        value: Handle<Expression>,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let zero = self.fadd_literal(0, span)?;
        let one = self.fadd_literal(1, span)?;
        let last = self.fadd_literal(31, span)?;
        let width = self.fadd_literal(32, span)?;
        let safe_shift = self.fadd_binary(BinaryOperator::And, distance, last, span)?;
        let mask = self.fadd_binary(BinaryOperator::ShiftLeft, one, safe_shift, span)?;
        let mask = self.fadd_binary(BinaryOperator::Subtract, mask, one, span)?;
        let lost = self.fadd_binary(BinaryOperator::And, value, mask, span)?;
        let sticky = self.fadd_binary(BinaryOperator::NotEqual, lost, zero, span)?;
        let sticky = self.fadd_bool_as_uint(sticky, span)?;
        let shifted = self.fadd_binary(BinaryOperator::ShiftRight, value, safe_shift, span)?;
        let shifted = self.fadd_binary(BinaryOperator::InclusiveOr, shifted, sticky, span)?;
        let nonzero = self.fadd_binary(BinaryOperator::NotEqual, value, zero, span)?;
        let nonzero = self.fadd_bool_as_uint(nonzero, span)?;
        let short = self.fadd_binary(BinaryOperator::Less, distance, width, span)?;
        self.fadd_select(short, shifted, nonzero, span)
    }

    fn fadd_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn fadd_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn fadd_select(
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

    fn fadd_bool_as_uint(
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

    fn fadd_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn fadd_return_if(
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
        self.fadd_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }
}
