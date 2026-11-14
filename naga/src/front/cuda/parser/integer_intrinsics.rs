use super::*;
use crate::MathFunction;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FunnelShiftDirection {
    Left,
    Right,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) struct FunnelShiftBuiltin {
    pub(super) direction: FunnelShiftDirection,
    pub(super) clamped: bool,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) struct HalfAddBuiltin {
    pub(super) scalar: Scalar,
    pub(super) rounded: bool,
}

impl Parser<'_> {
    pub(super) fn sum_absolute_difference(
        &mut self,
        scalar: Scalar,
        left: Handle<Expression>,
        right: Handle<Expression>,
        accumulator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut keys = [left, right];
        if scalar == Scalar::I32 {
            let sign = self.append(Expression::Literal(Literal::U32(0x8000_0000)), span)?;
            // Biasing signed words preserves their order and mathematical differences.
            for key in &mut keys {
                let bits = self.bitcast_scalar(*key, Scalar::U32, span)?;
                *key = self.sad_binary(BinaryOperator::ExclusiveOr, bits, sign, span)?;
            }
        }
        let [left, right] = keys;
        let minimum = self.append(
            Expression::Math {
                fun: MathFunction::Min,
                arg: left,
                arg1: Some(right),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let maximum = self.append(
            Expression::Math {
                fun: MathFunction::Max,
                arg: left,
                arg1: Some(right),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let difference = self.sad_binary(BinaryOperator::Subtract, maximum, minimum, span)?;
        let mask = self.append(Expression::Literal(Literal::U32(0xffff)), span)?;
        let width = self.append(Expression::Literal(Literal::U32(16)), span)?;
        // Limb sums stay in range even when a backend evaluates literal arguments.
        let low = self.sad_binary(BinaryOperator::And, difference, mask, span)?;
        let low_accumulator = self.sad_binary(BinaryOperator::And, accumulator, mask, span)?;
        let low_sum = self.sad_binary(BinaryOperator::Add, low, low_accumulator, span)?;
        let carry = self.sad_binary(BinaryOperator::ShiftRight, low_sum, width, span)?;
        let high = self.sad_binary(BinaryOperator::ShiftRight, difference, width, span)?;
        let high_accumulator =
            self.sad_binary(BinaryOperator::ShiftRight, accumulator, width, span)?;
        let high_sum = self.sad_binary(BinaryOperator::Add, high, high_accumulator, span)?;
        let high_sum = self.sad_binary(BinaryOperator::Add, high_sum, carry, span)?;
        let high_word = self.sad_binary(BinaryOperator::And, high_sum, mask, span)?;
        let high_word = self.sad_binary(BinaryOperator::ShiftLeft, high_word, width, span)?;
        let low_word = self.sad_binary(BinaryOperator::And, low_sum, mask, span)?;
        self.sad_binary(BinaryOperator::InclusiveOr, high_word, low_word, span)
    }

    fn sad_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    pub(super) fn half_add(
        &mut self,
        rounded: bool,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let different = self.append(
            Expression::Binary {
                op: BinaryOperator::ExclusiveOr,
                left,
                right,
            },
            span,
        )?;
        let one = self.append(Expression::Literal(Literal::U32(1)), span)?;
        let half_difference = self.append(
            Expression::Binary {
                op: BinaryOperator::ShiftRight,
                left: different,
                right: one,
            },
            span,
        )?;
        // These identities preserve floor/ceil rounding without overflowing the sum.
        let common = self.append(
            Expression::Binary {
                op: if rounded {
                    BinaryOperator::InclusiveOr
                } else {
                    BinaryOperator::And
                },
                left,
                right,
            },
            span,
        )?;
        self.append(
            Expression::Binary {
                op: if rounded {
                    BinaryOperator::Subtract
                } else {
                    BinaryOperator::Add
                },
                left: common,
                right: half_difference,
            },
            span,
        )
    }

    pub(super) fn multiply_high(
        &mut self,
        scalar: Scalar,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mask = self.append(
            Expression::Literal(if scalar == Scalar::I32 {
                Literal::I32(0xffff)
            } else {
                Literal::U32(0xffff)
            }),
            span,
        )?;
        let width = self.append(Expression::Literal(Literal::U32(16)), span)?;
        let left_low = self.multiply_high_binary(BinaryOperator::And, left, mask, span)?;
        let right_low = self.multiply_high_binary(BinaryOperator::And, right, mask, span)?;
        let left_high = self.multiply_high_binary(BinaryOperator::ShiftRight, left, width, span)?;
        let right_high =
            self.multiply_high_binary(BinaryOperator::ShiftRight, right, width, span)?;
        let mut low_words = [left_low, right_low];
        if scalar == Scalar::I32 {
            for word in &mut low_words {
                *word = self.append(
                    Expression::As {
                        expr: *word,
                        target: Scalar::U32,
                    },
                    span,
                )?;
            }
        }
        // Only the low-limb product needs unsigned range; signed cross products fit i32.
        let product =
            self.multiply_high_binary(BinaryOperator::Multiply, low_words[0], low_words[1], span)?;
        let mut carry =
            self.multiply_high_binary(BinaryOperator::ShiftRight, product, width, span)?;
        if scalar == Scalar::I32 {
            carry = self.append(
                Expression::As {
                    expr: carry,
                    target: scalar,
                },
                span,
            )?;
        }
        let first_cross =
            self.multiply_high_binary(BinaryOperator::Multiply, left_high, right_low, span)?;
        let first_cross =
            self.multiply_high_binary(BinaryOperator::Add, first_cross, carry, span)?;
        let middle = self.multiply_high_binary(BinaryOperator::And, first_cross, mask, span)?;
        let upper =
            self.multiply_high_binary(BinaryOperator::ShiftRight, first_cross, width, span)?;
        let second_cross =
            self.multiply_high_binary(BinaryOperator::Multiply, left_low, right_high, span)?;
        let second_cross =
            self.multiply_high_binary(BinaryOperator::Add, second_cross, middle, span)?;
        let carry =
            self.multiply_high_binary(BinaryOperator::ShiftRight, second_cross, width, span)?;
        let high_product =
            self.multiply_high_binary(BinaryOperator::Multiply, left_high, right_high, span)?;
        let high_product =
            self.multiply_high_binary(BinaryOperator::Add, high_product, upper, span)?;
        self.multiply_high_binary(BinaryOperator::Add, high_product, carry, span)
    }

    fn multiply_high_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    pub(super) fn funnel_shift(
        &mut self,
        builtin: FunnelShiftBuiltin,
        low: Handle<Expression>,
        high: Handle<Expression>,
        shift: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mask = self.append(Expression::Literal(Literal::U32(31)), span)?;
        let amount = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: shift,
                right: mask,
            },
            span,
        )?;
        let width = self.append(Expression::Literal(Literal::U32(32)), span)?;
        let complement = self.append(
            Expression::Binary {
                op: BinaryOperator::Subtract,
                left: width,
                right: amount,
            },
            span,
        )?;
        let complement = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: complement,
                right: mask,
            },
            span,
        )?;
        let (base, incoming, primary_op, incoming_op) = match builtin.direction {
            FunnelShiftDirection::Left => (
                high,
                low,
                BinaryOperator::ShiftLeft,
                BinaryOperator::ShiftRight,
            ),
            FunnelShiftDirection::Right => (
                low,
                high,
                BinaryOperator::ShiftRight,
                BinaryOperator::ShiftLeft,
            ),
        };
        let primary = self.append(
            Expression::Binary {
                op: primary_op,
                left: base,
                right: amount,
            },
            span,
        )?;
        let carry = self.append(
            Expression::Binary {
                op: incoming_op,
                left: incoming,
                right: complement,
            },
            span,
        )?;
        let combined = self.append(
            Expression::Binary {
                op: BinaryOperator::InclusiveOr,
                left: primary,
                right: carry,
            },
            span,
        )?;
        let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let nonzero = self.append(
            Expression::Binary {
                op: BinaryOperator::NotEqual,
                left: amount,
                right: zero,
            },
            span,
        )?;
        let shifted = self.append(
            Expression::Select {
                condition: nonzero,
                accept: combined,
                reject: base,
            },
            span,
        )?;
        if !builtin.clamped {
            return Ok(shifted);
        }
        let at_limit = self.append(
            Expression::Binary {
                op: BinaryOperator::GreaterEqual,
                left: shift,
                right: width,
            },
            span,
        )?;
        self.append(
            Expression::Select {
                condition: at_limit,
                accept: incoming,
                reject: shifted,
            },
            span,
        )
    }

    fn split_integer64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<(Handle<Expression>, Handle<Expression>), ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let low = self.append(
            Expression::As {
                expr: value,
                target: Scalar::U32,
            },
            span,
        )?;
        let shift = self.append(Expression::Literal(Literal::U32(32)), span)?;
        // Truncation preserves the high word after either signed or unsigned shifts.
        let upper = self.append(
            Expression::Binary {
                op: BinaryOperator::ShiftRight,
                left: value,
                right: shift,
            },
            span,
        )?;
        let high = self.append(
            Expression::As {
                expr: upper,
                target: Scalar::U32,
            },
            span,
        )?;
        Ok((low, high))
    }

    pub(super) fn population_count64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        // Some backends only provide population count for 32-bit inputs.
        let (low, high) = self.split_integer64(value, span)?;
        let low_count = self.append(
            Expression::Math {
                fun: MathFunction::CountOneBits,
                arg: low,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let high_count = self.append(
            Expression::Math {
                fun: MathFunction::CountOneBits,
                arg: high,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let count = self.append(
            Expression::Binary {
                op: BinaryOperator::Add,
                left: low_count,
                right: high_count,
            },
            span,
        )?;
        self.append(
            Expression::As {
                expr: count,
                target: Scalar::I32,
            },
            span,
        )
    }

    pub(super) fn reverse_bits64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let (low, high) = self.split_integer64(value, span)?;
        let mut reversed = [low, high];
        for word in &mut reversed {
            let bits = self.append(
                Expression::Math {
                    fun: MathFunction::ReverseBits,
                    arg: *word,
                    arg1: None,
                    arg2: None,
                    arg3: None,
                },
                span,
            )?;
            *word = self.append(
                Expression::As {
                    expr: bits,
                    target: Scalar::U64,
                },
                span,
            )?;
        }
        let [low, high] = reversed;
        let shift = self.append(Expression::Literal(Literal::U32(32)), span)?;
        let upper = self.append(
            Expression::Binary {
                op: BinaryOperator::ShiftLeft,
                left: low,
                right: shift,
            },
            span,
        )?;
        self.append(
            Expression::Binary {
                op: BinaryOperator::InclusiveOr,
                left: upper,
                right: high,
            },
            span,
        )
    }

    pub(super) fn count_leading_zeros64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let (low, high) = self.split_integer64(value, span)?;
        let mut counts = [low, high];
        for word in &mut counts {
            *word = self.append(
                Expression::Math {
                    fun: MathFunction::CountLeadingZeros,
                    arg: *word,
                    arg1: None,
                    arg2: None,
                    arg3: None,
                },
                span,
            )?;
        }
        let [low_count, high_count] = counts;
        let width = self.append(Expression::Literal(Literal::U32(32)), span)?;
        let low_count = self.append(
            Expression::Binary {
                op: BinaryOperator::Add,
                left: width,
                right: low_count,
            },
            span,
        )?;
        let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let nonzero = self.append(
            Expression::Binary {
                op: BinaryOperator::NotEqual,
                left: high,
                right: zero,
            },
            span,
        )?;
        let count = self.append(
            Expression::Select {
                condition: nonzero,
                accept: high_count,
                reject: low_count,
            },
            span,
        )?;
        self.append(
            Expression::As {
                expr: count,
                target: Scalar::I32,
            },
            span,
        )
    }

    pub(super) fn first_set_bit64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let (low, high) = self.split_integer64(value, span)?;
        let mut positions = [low, high];
        for (word, offset) in positions.iter_mut().zip([1, 33]) {
            let count = self.append(
                Expression::Math {
                    fun: MathFunction::CountTrailingZeros,
                    arg: *word,
                    arg1: None,
                    arg2: None,
                    arg3: None,
                },
                span,
            )?;
            let offset = self.append(Expression::Literal(Literal::U32(offset)), span)?;
            *word = self.append(
                Expression::Binary {
                    op: BinaryOperator::Add,
                    left: count,
                    right: offset,
                },
                span,
            )?;
        }
        let [low_position, high_position] = positions;
        let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let high_nonzero = self.append(
            Expression::Binary {
                op: BinaryOperator::NotEqual,
                left: high,
                right: zero,
            },
            span,
        )?;
        let high_position = self.append(
            Expression::Select {
                condition: high_nonzero,
                accept: high_position,
                reject: zero,
            },
            span,
        )?;
        let low_nonzero = self.append(
            Expression::Binary {
                op: BinaryOperator::NotEqual,
                left: low,
                right: zero,
            },
            span,
        )?;
        let position = self.append(
            Expression::Select {
                condition: low_nonzero,
                accept: low_position,
                reject: high_position,
            },
            span,
        )?;
        self.append(
            Expression::As {
                expr: position,
                target: Scalar::I32,
            },
            span,
        )
    }
}
