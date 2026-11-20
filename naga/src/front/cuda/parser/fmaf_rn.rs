use super::*;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FmaRounding {
    NearestEven,
    TowardZero,
    TowardNegative,
    TowardPositive,
}

#[derive(Clone, Copy)]
struct FmaPair {
    low: Handle<Expression>,
    high: Handle<Expression>,
}

impl Parser<'_> {
    pub(super) fn lower_fmaf_rn_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmaf_call(arguments, FmaRounding::NearestEven, span)
    }

    pub(super) fn lower_fmaf_rz_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmaf_call(arguments, FmaRounding::TowardZero, span)
    }

    pub(super) fn lower_fmaf_rd_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmaf_call(arguments, FmaRounding::TowardNegative, span)
    }

    pub(super) fn lower_fmaf_ru_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.lower_fmaf_call(arguments, FmaRounding::TowardPositive, span)
    }

    fn lower_fmaf_call(
        &mut self,
        arguments: Vec<Value>,
        rounding: FmaRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let left = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let right = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let addend = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let left = self.bitcast_scalar(left.handle, Scalar::U32, span)?;
        let right = self.bitcast_scalar(right.handle, Scalar::U32, span)?;
        let addend = self.bitcast_scalar(addend.handle, Scalar::U32, span)?;
        let bits = match rounding {
            FmaRounding::NearestEven => self.call_fmaf_rn_bits(left, right, addend, span)?,
            FmaRounding::TowardZero => self.call_fmaf_rz_bits(left, right, addend, span)?,
            FmaRounding::TowardNegative | FmaRounding::TowardPositive => {
                self.call_fmaf_bits(left, right, addend, rounding, span)?
            }
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

    pub(super) fn lower_ffma2_call(
        &mut self,
        arguments: Vec<Value>,
        rounding: FmaRounding,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let arguments: [Value; 3] = arguments.try_into().ok().unwrap();
        self.lower_float2_lanes(arguments, span, |parser, [left, right, addend]| {
            parser.call_fmaf_bits(left, right, addend, rounding, span)
        })
    }

    pub(super) fn call_fmaf_rn_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        addend: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fmaf_bits(left, right, addend, FmaRounding::NearestEven, span)
    }

    pub(super) fn call_fmaf_rz_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        addend: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.call_fmaf_bits(left, right, addend, FmaRounding::TowardZero, span)
    }

    fn call_fmaf_bits(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        addend: Handle<Expression>,
        rounding: FmaRounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        self.prepare_append(1, span)?;
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<Handle<Expression>>(3, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        let function = self.cached_fmaf_function(rounding, span)?;
        self.function
            .ir
            .body
            .extend(self.function.emitter.finish(&self.function.ir.expressions));
        let result = self.append_prepared(Expression::CallResult(function), 1, span);
        self.function.emitter.start(&self.function.ir.expressions);
        self.push_statement(
            Statement::Call {
                function,
                arguments: alloc::vec![left, right, addend],
                result: Some(result),
            },
            span,
        );
        Ok(result)
    }

    fn cached_fmaf_function(
        &mut self,
        rounding: FmaRounding,
        span: Span,
    ) -> Result<Handle<Function>, ParseError> {
        let cached = match rounding {
            FmaRounding::NearestEven => self.fmaf_rn_function,
            FmaRounding::TowardZero => self.fmaf_rz_function,
            FmaRounding::TowardNegative => self.fmaf_rd_function,
            FmaRounding::TowardPositive => self.fmaf_ru_function,
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
        let result = self.build_fmaf_function(rounding, span);
        let helper = core::mem::replace(&mut self.function, caller);
        result?;
        self.parameter_expansion_budget
            .inventory_function(&helper.ir, span, 1)?;
        let function = self.module.functions.append(helper.ir, span);
        match rounding {
            FmaRounding::NearestEven => self.fmaf_rn_function = Some(function),
            FmaRounding::TowardZero => self.fmaf_rz_function = Some(function),
            FmaRounding::TowardNegative => self.fmaf_rd_function = Some(function),
            FmaRounding::TowardPositive => self.fmaf_ru_function = Some(function),
        }
        Ok(function)
    }

    fn build_fmaf_function(&mut self, rounding: FmaRounding, span: Span) -> Result<(), ParseError> {
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
            FmaRounding::NearestEven => "_naga_fmaf_rn",
            FmaRounding::TowardZero => "_naga_fmaf_rz",
            FmaRounding::TowardNegative => "_naga_fmaf_rd",
            FmaRounding::TowardPositive => "_naga_fmaf_ru",
        };
        let argument_names = ["left_bits", "right_bits", "addend_bits"];
        self.parameter_expansion_budget.charge_nodes(3, span)?;
        self.parameter_expansion_budget
            .charge_slice::<FunctionArgument>(3, span)?;
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
        let addend = self.append(Expression::FunctionArgument(2), span)?;
        let zero = self.fmaf_literal(0, span)?;
        let one = self.fmaf_literal(1, span)?;
        let width = self.fmaf_literal(23, span)?;
        let mask = self.fmaf_literal(0x7fff_ffff, span)?;
        let sign_mask = self.fmaf_literal(0x8000_0000, span)?;
        let infinity = self.fmaf_literal(0x7f80_0000, span)?;
        let nan = self.fmaf_literal(0x7fc0_0000, span)?;
        let fraction_mask = self.fmaf_literal(0x007f_ffff, span)?;
        let implicit = self.fmaf_literal(0x0080_0000, span)?;
        let am = self.fmaf_binary(BinaryOperator::And, left, mask, span)?;
        let anan = self.fmaf_binary(BinaryOperator::Greater, am, infinity, span)?;
        let ainf = self.fmaf_binary(BinaryOperator::Equal, am, infinity, span)?;
        let azero = self.fmaf_binary(BinaryOperator::Equal, am, zero, span)?;
        let bm = self.fmaf_binary(BinaryOperator::And, right, mask, span)?;
        let bnan = self.fmaf_binary(BinaryOperator::Greater, bm, infinity, span)?;
        let binf = self.fmaf_binary(BinaryOperator::Equal, bm, infinity, span)?;
        let bzero = self.fmaf_binary(BinaryOperator::Equal, bm, zero, span)?;
        let cm = self.fmaf_binary(BinaryOperator::And, addend, mask, span)?;
        let cnan = self.fmaf_binary(BinaryOperator::Greater, cm, infinity, span)?;
        let cinf = self.fmaf_binary(BinaryOperator::Equal, cm, infinity, span)?;
        let czero = self.fmaf_binary(BinaryOperator::Equal, cm, zero, span)?;
        let any_nan = self.fmaf_binary(BinaryOperator::LogicalOr, anan, bnan, span)?;
        let any_nan = self.fmaf_binary(BinaryOperator::LogicalOr, any_nan, cnan, span)?;
        self.fmaf_return_if(any_nan, nan, span)?;
        let invalid_left = self.fmaf_binary(BinaryOperator::LogicalAnd, azero, binf, span)?;
        let invalid_right = self.fmaf_binary(BinaryOperator::LogicalAnd, bzero, ainf, span)?;
        let invalid_product =
            self.fmaf_binary(BinaryOperator::LogicalOr, invalid_left, invalid_right, span)?;
        self.fmaf_return_if(invalid_product, nan, span)?;
        let psign = self.fmaf_binary(BinaryOperator::ExclusiveOr, left, right, span)?;
        let psign = self.fmaf_binary(BinaryOperator::And, psign, sign_mask, span)?;
        let csign = self.fmaf_binary(BinaryOperator::And, addend, sign_mask, span)?;
        let signs_differ = self.fmaf_binary(BinaryOperator::NotEqual, psign, csign, span)?;
        let product_inf = self.fmaf_binary(BinaryOperator::LogicalOr, ainf, binf, span)?;
        let opposite_inf =
            self.fmaf_binary(BinaryOperator::LogicalAnd, cinf, signs_differ, span)?;
        let invalid_sum =
            self.fmaf_binary(BinaryOperator::LogicalAnd, product_inf, opposite_inf, span)?;
        self.fmaf_return_if(invalid_sum, nan, span)?;
        let signed_inf = self.fmaf_binary(BinaryOperator::InclusiveOr, psign, infinity, span)?;
        self.fmaf_return_if(product_inf, signed_inf, span)?;
        self.fmaf_return_if(cinf, addend, span)?;
        let product_zero = self.fmaf_binary(BinaryOperator::LogicalOr, azero, bzero, span)?;
        let both_zero = self.fmaf_binary(BinaryOperator::LogicalAnd, product_zero, czero, span)?;
        let zero_sign_op = if matches!(rounding, FmaRounding::TowardNegative) {
            BinaryOperator::InclusiveOr
        } else {
            BinaryOperator::And
        };
        let zero_sign = self.fmaf_binary(zero_sign_op, psign, csign, span)?;
        self.fmaf_return_if(both_zero, zero_sign, span)?;
        self.fmaf_return_if(product_zero, addend, span)?;
        let aexp = self.fmaf_binary(BinaryOperator::ShiftRight, am, width, span)?;
        let anormal = self.fmaf_binary(BinaryOperator::NotEqual, aexp, zero, span)?;
        let ahidden = self.fmaf_select(anormal, implicit, zero, span)?;
        let afraction = self.fmaf_binary(BinaryOperator::And, am, fraction_mask, span)?;
        let asig = self.fmaf_binary(BinaryOperator::InclusiveOr, afraction, ahidden, span)?;
        let aexp = self.fmaf_select(anormal, aexp, one, span)?;
        let aexp = self.fmaf_cast(aexp, Scalar::I32, span)?;
        let decode_bias = self.fmaf_signed_literal(150, span)?;
        let aexp = self.fmaf_binary(BinaryOperator::Subtract, aexp, decode_bias, span)?;
        let bexp = self.fmaf_binary(BinaryOperator::ShiftRight, bm, width, span)?;
        let bnormal = self.fmaf_binary(BinaryOperator::NotEqual, bexp, zero, span)?;
        let bhidden = self.fmaf_select(bnormal, implicit, zero, span)?;
        let bfraction = self.fmaf_binary(BinaryOperator::And, bm, fraction_mask, span)?;
        let bsig = self.fmaf_binary(BinaryOperator::InclusiveOr, bfraction, bhidden, span)?;
        let bexp = self.fmaf_select(bnormal, bexp, one, span)?;
        let bexp = self.fmaf_cast(bexp, Scalar::I32, span)?;
        let decode_bias = self.fmaf_signed_literal(150, span)?;
        let bexp = self.fmaf_binary(BinaryOperator::Subtract, bexp, decode_bias, span)?;
        let cexp = self.fmaf_binary(BinaryOperator::ShiftRight, cm, width, span)?;
        let cnormal = self.fmaf_binary(BinaryOperator::NotEqual, cexp, zero, span)?;
        let chidden = self.fmaf_select(cnormal, implicit, zero, span)?;
        let cfraction = self.fmaf_binary(BinaryOperator::And, cm, fraction_mask, span)?;
        let csig = self.fmaf_binary(BinaryOperator::InclusiveOr, cfraction, chidden, span)?;
        let cexp = self.fmaf_select(cnormal, cexp, one, span)?;
        let cexp = self.fmaf_cast(cexp, Scalar::I32, span)?;
        let decode_bias = self.fmaf_signed_literal(150, span)?;
        let cexp = self.fmaf_binary(BinaryOperator::Subtract, cexp, decode_bias, span)?;
        let product = self.fmaf_product(asig, bsig, span)?;
        let product = self.fmaf_materialize_pair(product, unsigned, span)?;
        let kp = self.fmaf_leading(product, span)?;
        let kp = self.fmaf_cast(kp, Scalar::I32, span)?;
        let fifty = self.fmaf_signed_literal(50, span)?;
        let p_shift = self.fmaf_binary(BinaryOperator::Subtract, fifty, kp, span)?;
        let normalized_product = self.fmaf_shift_left(product, p_shift, span)?;
        let normalized_product = self.fmaf_materialize_pair(normalized_product, unsigned, span)?;
        let pe = self.fmaf_binary(BinaryOperator::Add, aexp, bexp, span)?;
        let pe = self.fmaf_binary(BinaryOperator::Add, pe, kp, span)?;
        let addend_pair = FmaPair {
            low: csig,
            high: zero,
        };
        let kc = self.fmaf_leading(addend_pair, span)?;
        let kc = self.fmaf_cast(kc, Scalar::I32, span)?;
        let c_shift = self.fmaf_binary(BinaryOperator::Subtract, fifty, kc, span)?;
        let normalized_addend = self.fmaf_shift_left(addend_pair, c_shift, span)?;
        let normalized_addend = self.fmaf_materialize_pair(normalized_addend, unsigned, span)?;
        let ce = self.fmaf_binary(BinaryOperator::Add, cexp, kc, span)?;
        let ce = self.fmaf_select(czero, pe, ce, span)?;
        let exponent_less = self.fmaf_binary(BinaryOperator::Less, pe, ce, span)?;
        let exponents_equal = self.fmaf_binary(BinaryOperator::Equal, pe, ce, span)?;
        let magnitude_less = self.fmaf_pair_less(normalized_product, normalized_addend, span)?;
        let equal_less = self.fmaf_binary(
            BinaryOperator::LogicalAnd,
            exponents_equal,
            magnitude_less,
            span,
        )?;
        let swap = self.fmaf_binary(BinaryOperator::LogicalOr, exponent_less, equal_less, span)?;
        let larger = self.fmaf_select_pair(swap, normalized_addend, normalized_product, span)?;
        let smaller = self.fmaf_select_pair(swap, normalized_product, normalized_addend, span)?;
        let le = self.fmaf_select(swap, ce, pe, span)?;
        let re = self.fmaf_select(swap, pe, ce, span)?;
        let result_sign = self.fmaf_select(swap, csign, psign, span)?;
        let le = self.fmaf_materialize_signed(le, span)?;
        let re = self.fmaf_materialize_signed(re, span)?;
        let result_sign = self.fmaf_materialize(result_sign, unsigned, span)?;
        let distance = self.fmaf_binary(BinaryOperator::Subtract, le, re, span)?;
        let distance = self.fmaf_materialize_signed(distance, span)?;
        let aligned = self.fmaf_shift_jam(smaller, distance, span)?;
        let aligned = self.fmaf_materialize_pair(aligned, unsigned, span)?;
        let sum = self.fmaf_add_pair(larger, aligned, span)?;
        let difference = self.fmaf_subtract_pair(larger, aligned, span)?;
        let total = self.fmaf_select_pair(signs_differ, difference, sum, span)?;
        let total = self.fmaf_materialize_pair(total, unsigned, span)?;
        let nonzero = self.fmaf_binary(BinaryOperator::InclusiveOr, total.low, total.high, span)?;
        let cancelled = self.fmaf_binary(BinaryOperator::Equal, nonzero, zero, span)?;
        // Exact cancellation of nonzero terms yields negative zero when rounding down.
        let cancelled_zero = if matches!(rounding, FmaRounding::TowardNegative) {
            sign_mask
        } else {
            zero
        };
        self.fmaf_return_if(cancelled, cancelled_zero, span)?;
        let leading = self.fmaf_leading(total, span)?;
        let leading = self.fmaf_cast(leading, Scalar::I32, span)?;
        let base = self.fmaf_binary(BinaryOperator::Subtract, le, fifty, span)?;
        let quantum = self.fmaf_binary(BinaryOperator::Add, leading, base, span)?;
        let twenty_three = self.fmaf_signed_literal(23, span)?;
        let quantum = self.fmaf_binary(BinaryOperator::Subtract, quantum, twenty_three, span)?;
        let minimum_quantum = self.fmaf_signed_literal(-149, span)?;
        let quantum = self.fmaf_math(crate::MathFunction::Max, quantum, minimum_quantum, span)?;
        let shift = self.fmaf_binary(BinaryOperator::Subtract, quantum, base, span)?;
        let three_signed = self.fmaf_signed_literal(3, span)?;
        let distance = self.fmaf_binary(BinaryOperator::Subtract, shift, three_signed, span)?;
        let quantum = self.fmaf_materialize_signed(quantum, span)?;
        let distance = self.fmaf_materialize_signed(distance, span)?;
        let grs = self.fmaf_shift_jam(total, distance, span)?;
        let grs = self.fmaf_materialize_pair(grs, unsigned, span)?;
        let three = self.fmaf_literal(3, span)?;
        let away_from_zero = match rounding {
            FmaRounding::TowardNegative => {
                Some(self.fmaf_binary(BinaryOperator::NotEqual, result_sign, zero, span)?)
            }
            FmaRounding::TowardPositive => {
                Some(self.fmaf_binary(BinaryOperator::Equal, result_sign, zero, span)?)
            }
            FmaRounding::NearestEven | FmaRounding::TowardZero => None,
        };
        let (rounded, quantum) = match rounding {
            FmaRounding::NearestEven
            | FmaRounding::TowardNegative
            | FmaRounding::TowardPositive => {
                let seven = self.fmaf_literal(7, span)?;
                let threshold = if away_from_zero.is_some() {
                    zero
                } else {
                    self.fmaf_literal(4, span)?
                };
                let rounded = self.fmaf_binary(BinaryOperator::ShiftRight, grs.low, three, span)?;
                let tail = self.fmaf_binary(BinaryOperator::And, grs.low, seven, span)?;
                let increment = if let Some(away) = away_from_zero {
                    let inexact =
                        self.fmaf_binary(BinaryOperator::Greater, tail, threshold, span)?;
                    self.fmaf_binary(BinaryOperator::LogicalAnd, away, inexact, span)?
                } else {
                    let odd = self.fmaf_binary(BinaryOperator::And, rounded, one, span)?;
                    let odd = self.fmaf_binary(BinaryOperator::NotEqual, odd, zero, span)?;
                    let tie = self.fmaf_binary(BinaryOperator::Equal, tail, threshold, span)?;
                    let tie_up = self.fmaf_binary(BinaryOperator::LogicalAnd, tie, odd, span)?;
                    let above_half =
                        self.fmaf_binary(BinaryOperator::Greater, tail, threshold, span)?;
                    self.fmaf_binary(BinaryOperator::LogicalOr, above_half, tie_up, span)?
                };
                let increment = self.fmaf_cast(increment, Scalar::U32, span)?;
                let rounded = self.fmaf_binary(BinaryOperator::Add, rounded, increment, span)?;
                let carry_bit = self.fmaf_literal(0x0100_0000, span)?;
                let carry =
                    self.fmaf_binary(BinaryOperator::GreaterEqual, rounded, carry_bit, span)?;
                let shifted = self.fmaf_binary(BinaryOperator::ShiftRight, rounded, one, span)?;
                let rounded = self.fmaf_select(carry, shifted, rounded, span)?;
                let carry = self.fmaf_cast(carry, Scalar::I32, span)?;
                let quantum = self.fmaf_binary(BinaryOperator::Add, quantum, carry, span)?;
                (rounded, quantum)
            }
            FmaRounding::TowardZero => {
                let rounded = self.fmaf_binary(BinaryOperator::ShiftRight, grs.low, three, span)?;
                (rounded, quantum)
            }
        };
        let exponent_bias = self.fmaf_signed_literal(150, span)?;
        let encoded_exp = self.fmaf_binary(BinaryOperator::Add, quantum, exponent_bias, span)?;
        let max_exp = self.fmaf_signed_literal(255, span)?;
        let overflow =
            self.fmaf_binary(BinaryOperator::GreaterEqual, encoded_exp, max_exp, span)?;
        let overflow_magnitude = match rounding {
            FmaRounding::NearestEven => infinity,
            FmaRounding::TowardZero | FmaRounding::TowardNegative | FmaRounding::TowardPositive => {
                let maximum = self.fmaf_literal(0x7f7f_ffff, span)?;
                if let Some(away) = away_from_zero {
                    self.fmaf_select(away, infinity, maximum, span)?
                } else {
                    maximum
                }
            }
        };
        let signed_overflow = self.fmaf_binary(
            BinaryOperator::InclusiveOr,
            result_sign,
            overflow_magnitude,
            span,
        )?;
        self.fmaf_return_if(overflow, signed_overflow, span)?;
        let normal = self.fmaf_binary(BinaryOperator::GreaterEqual, rounded, implicit, span)?;
        let signed_zero = self.fmaf_signed_literal(0, span)?;
        let encoded_exp =
            self.fmaf_math(crate::MathFunction::Max, encoded_exp, signed_zero, span)?;
        let encoded_exp = self.fmaf_cast(encoded_exp, Scalar::U32, span)?;
        let encoded_exp = self.fmaf_select(normal, encoded_exp, zero, span)?;
        let exp_bits = self.fmaf_binary(BinaryOperator::ShiftLeft, encoded_exp, width, span)?;
        let fraction = self.fmaf_binary(BinaryOperator::And, rounded, fraction_mask, span)?;
        let magnitude = self.fmaf_binary(BinaryOperator::InclusiveOr, exp_bits, fraction, span)?;
        let result = self.fmaf_binary(BinaryOperator::InclusiveOr, result_sign, magnitude, span)?;
        self.fmaf_statement(
            Statement::Return {
                value: Some(result),
            },
            span,
        )
    }

    fn fmaf_safe_shift(
        &mut self,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let zero = self.fmaf_signed_literal(0, span)?;
        let last_signed = self.fmaf_signed_literal(31, span)?;
        let nonnegative = self.fmaf_math(crate::MathFunction::Max, distance, zero, span)?;
        let bounded = self.fmaf_math(crate::MathFunction::Min, nonnegative, last_signed, span)?;
        let unsigned = self.fmaf_cast(bounded, Scalar::U32, span)?;
        let last = self.fmaf_literal(31, span)?;
        self.fmaf_binary(BinaryOperator::And, unsigned, last, span)
    }

    fn fmaf_signed_literal(
        &mut self,
        value: i32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::I32(value)), span)
    }

    fn fmaf_cast(
        &mut self,
        expr: Handle<Expression>,
        target: Scalar,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::As { expr, target }, span)
    }

    fn fmaf_clz(
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

    fn fmaf_math(
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

    fn fmaf_literal(&mut self, value: u32, span: Span) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn fmaf_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn fmaf_select(
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

    fn fmaf_statement(&mut self, statement: Statement, span: Span) -> Result<(), ParseError> {
        self.parameter_expansion_budget.charge_nodes(1, span)?;
        self.parameter_expansion_budget
            .charge_slice::<(Statement, Span)>(1, span)?;
        self.push_statement(statement, span);
        Ok(())
    }

    fn fmaf_return_if(
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
        self.fmaf_statement(
            Statement::If {
                condition,
                accept,
                reject: crate::Block::new(),
            },
            span,
        )
    }

    fn fmaf_product(
        &mut self,
        a: Handle<Expression>,
        b: Handle<Expression>,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let mask = self.fmaf_literal(4095, span)?;
        let width = self.fmaf_literal(12, span)?;
        let a0 = self.fmaf_binary(BinaryOperator::And, a, mask, span)?;
        let a1 = self.fmaf_binary(BinaryOperator::ShiftRight, a, width, span)?;
        let b0 = self.fmaf_binary(BinaryOperator::And, b, mask, span)?;
        let b1 = self.fmaf_binary(BinaryOperator::ShiftRight, b, width, span)?;
        let p0 = self.fmaf_binary(BinaryOperator::Multiply, a0, b0, span)?;
        let p1a = self.fmaf_binary(BinaryOperator::Multiply, a0, b1, span)?;
        let p1b = self.fmaf_binary(BinaryOperator::Multiply, a1, b0, span)?;
        let p1 = self.fmaf_binary(BinaryOperator::Add, p1a, p1b, span)?;
        let carry = self.fmaf_binary(BinaryOperator::ShiftRight, p0, width, span)?;
        let p1 = self.fmaf_binary(BinaryOperator::Add, p1, carry, span)?;
        let p2 = self.fmaf_binary(BinaryOperator::Multiply, a1, b1, span)?;
        let carry = self.fmaf_binary(BinaryOperator::ShiftRight, p1, width, span)?;
        let high24 = self.fmaf_binary(BinaryOperator::Add, p2, carry, span)?;
        let d0 = self.fmaf_binary(BinaryOperator::And, p0, mask, span)?;
        let d1 = self.fmaf_binary(BinaryOperator::And, p1, mask, span)?;
        let d1 = self.fmaf_binary(BinaryOperator::ShiftLeft, d1, width, span)?;
        let low24 = self.fmaf_binary(BinaryOperator::InclusiveOr, d0, d1, span)?;
        let twenty_four = self.fmaf_literal(24, span)?;
        let eight = self.fmaf_literal(8, span)?;
        let low_high = self.fmaf_binary(BinaryOperator::ShiftLeft, high24, twenty_four, span)?;
        let low = self.fmaf_binary(BinaryOperator::InclusiveOr, low24, low_high, span)?;
        let high = self.fmaf_binary(BinaryOperator::ShiftRight, high24, eight, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_leading(
        &mut self,
        value: FmaPair,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let zero = self.fmaf_literal(0, span)?;
        let one = self.fmaf_literal(1, span)?;
        let sixty_three = self.fmaf_literal(63, span)?;
        let thirty_one = self.fmaf_literal(31, span)?;
        let high_nonzero = self.fmaf_binary(BinaryOperator::NotEqual, value.high, zero, span)?;
        let high_safe = self.fmaf_binary(BinaryOperator::InclusiveOr, value.high, one, span)?;
        let low_safe = self.fmaf_binary(BinaryOperator::InclusiveOr, value.low, one, span)?;
        let high_clz = self.fmaf_clz(high_safe, span)?;
        let low_clz = self.fmaf_clz(low_safe, span)?;
        let high = self.fmaf_binary(BinaryOperator::Subtract, sixty_three, high_clz, span)?;
        let low = self.fmaf_binary(BinaryOperator::Subtract, thirty_one, low_clz, span)?;
        self.fmaf_select(high_nonzero, high, low, span)
    }

    fn fmaf_select_pair(
        &mut self,
        condition: Handle<Expression>,
        accept: FmaPair,
        reject: FmaPair,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let low = self.fmaf_select(condition, accept.low, reject.low, span)?;
        let high = self.fmaf_select(condition, accept.high, reject.high, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_pair_less(
        &mut self,
        a: FmaPair,
        b: FmaPair,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let high_less = self.fmaf_binary(BinaryOperator::Less, a.high, b.high, span)?;
        let high_equal = self.fmaf_binary(BinaryOperator::Equal, a.high, b.high, span)?;
        let low_less = self.fmaf_binary(BinaryOperator::Less, a.low, b.low, span)?;
        let low_less = self.fmaf_binary(BinaryOperator::LogicalAnd, high_equal, low_less, span)?;
        self.fmaf_binary(BinaryOperator::LogicalOr, high_less, low_less, span)
    }

    fn fmaf_add_pair(&mut self, a: FmaPair, b: FmaPair, span: Span) -> Result<FmaPair, ParseError> {
        let low = self.fmaf_binary(BinaryOperator::Add, a.low, b.low, span)?;
        let carry = self.fmaf_binary(BinaryOperator::Less, low, a.low, span)?;
        let carry = self.fmaf_cast(carry, Scalar::U32, span)?;
        let high = self.fmaf_binary(BinaryOperator::Add, a.high, b.high, span)?;
        let high = self.fmaf_binary(BinaryOperator::Add, high, carry, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_subtract_pair(
        &mut self,
        a: FmaPair,
        b: FmaPair,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let borrow = self.fmaf_binary(BinaryOperator::Less, a.low, b.low, span)?;
        let borrow = self.fmaf_cast(borrow, Scalar::U32, span)?;
        let low = self.fmaf_binary(BinaryOperator::Subtract, a.low, b.low, span)?;
        let high = self.fmaf_binary(BinaryOperator::Subtract, a.high, b.high, span)?;
        let high = self.fmaf_binary(BinaryOperator::Subtract, high, borrow, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_shift_left(
        &mut self,
        value: FmaPair,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let zero = self.fmaf_literal(0, span)?;
        let zero_signed = self.fmaf_signed_literal(0, span)?;
        let word = self.fmaf_signed_literal(32, span)?;
        let shift = self.fmaf_safe_shift(distance, span)?;
        let complement = self.fmaf_binary(BinaryOperator::Subtract, word, distance, span)?;
        let complement = self.fmaf_safe_shift(complement, span)?;
        let positive = self.fmaf_binary(BinaryOperator::Greater, distance, zero_signed, span)?;
        let cross = self.fmaf_binary(BinaryOperator::ShiftRight, value.low, complement, span)?;
        let cross = self.fmaf_select(positive, cross, zero, span)?;
        let low = self.fmaf_binary(BinaryOperator::ShiftLeft, value.low, shift, span)?;
        let high = self.fmaf_binary(BinaryOperator::ShiftLeft, value.high, shift, span)?;
        let high = self.fmaf_binary(BinaryOperator::InclusiveOr, high, cross, span)?;
        let long_distance = self.fmaf_binary(BinaryOperator::Subtract, distance, word, span)?;
        let long_distance = self.fmaf_safe_shift(long_distance, span)?;
        let long_high =
            self.fmaf_binary(BinaryOperator::ShiftLeft, value.low, long_distance, span)?;
        let short = self.fmaf_binary(BinaryOperator::Less, distance, word, span)?;
        let low = self.fmaf_select(short, low, zero, span)?;
        let high = self.fmaf_select(short, high, long_high, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_shift_jam(
        &mut self,
        value: FmaPair,
        distance: Handle<Expression>,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let zero = self.fmaf_literal(0, span)?;
        let one = self.fmaf_literal(1, span)?;
        let zero_signed = self.fmaf_signed_literal(0, span)?;
        let word = self.fmaf_signed_literal(32, span)?;
        let pair = self.fmaf_signed_literal(64, span)?;
        let shift = self.fmaf_safe_shift(distance, span)?;
        let complement = self.fmaf_binary(BinaryOperator::Subtract, word, distance, span)?;
        let complement = self.fmaf_safe_shift(complement, span)?;
        let positive = self.fmaf_binary(BinaryOperator::Greater, distance, zero_signed, span)?;
        let cross = self.fmaf_binary(BinaryOperator::ShiftLeft, value.high, complement, span)?;
        let cross = self.fmaf_select(positive, cross, zero, span)?;
        let low = self.fmaf_binary(BinaryOperator::ShiftRight, value.low, shift, span)?;
        let low = self.fmaf_binary(BinaryOperator::InclusiveOr, low, cross, span)?;
        let high = self.fmaf_binary(BinaryOperator::ShiftRight, value.high, shift, span)?;
        let mask = self.fmaf_binary(BinaryOperator::ShiftLeft, one, shift, span)?;
        let mask = self.fmaf_binary(BinaryOperator::Subtract, mask, one, span)?;
        let lost = self.fmaf_binary(BinaryOperator::And, value.low, mask, span)?;
        let lost = self.fmaf_binary(BinaryOperator::NotEqual, lost, zero, span)?;
        let lost = self.fmaf_cast(lost, Scalar::U32, span)?;
        let low = self.fmaf_binary(BinaryOperator::InclusiveOr, low, lost, span)?;
        let long_distance = self.fmaf_binary(BinaryOperator::Subtract, distance, word, span)?;
        let long_shift = self.fmaf_safe_shift(long_distance, span)?;
        let long_low =
            self.fmaf_binary(BinaryOperator::ShiftRight, value.high, long_shift, span)?;
        let long_mask = self.fmaf_binary(BinaryOperator::ShiftLeft, one, long_shift, span)?;
        let long_mask = self.fmaf_binary(BinaryOperator::Subtract, long_mask, one, span)?;
        let high_lost = self.fmaf_binary(BinaryOperator::And, value.high, long_mask, span)?;
        let all_lost = self.fmaf_binary(BinaryOperator::InclusiveOr, high_lost, value.low, span)?;
        let all_lost = self.fmaf_binary(BinaryOperator::NotEqual, all_lost, zero, span)?;
        let all_lost = self.fmaf_cast(all_lost, Scalar::U32, span)?;
        let long_low = self.fmaf_binary(BinaryOperator::InclusiveOr, long_low, all_lost, span)?;
        let short = self.fmaf_binary(BinaryOperator::Less, distance, word, span)?;
        let low = self.fmaf_select(short, low, long_low, span)?;
        let high = self.fmaf_select(short, high, zero, span)?;
        let nonzero = self.fmaf_binary(BinaryOperator::InclusiveOr, value.high, value.low, span)?;
        let nonzero = self.fmaf_binary(BinaryOperator::NotEqual, nonzero, zero, span)?;
        let nonzero = self.fmaf_cast(nonzero, Scalar::U32, span)?;
        let below_pair = self.fmaf_binary(BinaryOperator::Less, distance, pair, span)?;
        let low = self.fmaf_select(below_pair, low, nonzero, span)?;
        let high = self.fmaf_select(below_pair, high, zero, span)?;
        let left_distance =
            self.fmaf_binary(BinaryOperator::Subtract, zero_signed, distance, span)?;
        let left = self.fmaf_shift_left(value, left_distance, span)?;
        let nonpositive =
            self.fmaf_binary(BinaryOperator::LessEqual, distance, zero_signed, span)?;
        let low = self.fmaf_select(nonpositive, left.low, low, span)?;
        let high = self.fmaf_select(nonpositive, left.high, high, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_materialize_pair(
        &mut self,
        value: FmaPair,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<FmaPair, ParseError> {
        let low = self.fmaf_materialize(value.low, ty, span)?;
        let high = self.fmaf_materialize(value.high, ty, span)?;
        Ok(FmaPair { low, high })
    }

    fn fmaf_materialize(
        &mut self,
        value: Handle<Expression>,
        ty: Handle<Type>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let name = "stage";
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
        let pointer = self.append(Expression::LocalVariable(local), span)?;
        self.fmaf_statement(Statement::Store { pointer, value }, span)?;
        self.append(Expression::Load { pointer }, span)
    }

    fn fmaf_materialize_signed(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let ty = Type {
            name: None,
            inner: TypeInner::Scalar(Scalar::I32),
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
        self.fmaf_materialize(value, ty, span)
    }
}
