use super::*;
use crate::MathFunction;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FunnelShiftDirection {
    Left,
    Right,
}

impl Parser<'_> {
    pub(super) fn funnel_shift(
        &mut self,
        direction: FunnelShiftDirection,
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
        let (base, incoming, primary_op, incoming_op) = match direction {
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
        self.append(
            Expression::Select {
                condition: nonzero,
                accept: combined,
                reject: base,
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
