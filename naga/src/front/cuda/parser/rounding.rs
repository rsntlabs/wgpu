use super::*;

#[derive(Clone, Copy)]
pub(super) enum Rounding {
    Floor,
    Ceil,
}

impl Parser<'_> {
    pub(super) fn round_float(
        &mut self,
        value: Handle<Expression>,
        rounding: Rounding,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let input_bits = self.append(
            Expression::As {
                expr: value,
                kind: ScalarKind::Uint,
                convert: None,
            },
            span,
        )?;
        let zero = self.rounding_literal(0, span)?;
        let one = self.rounding_literal(1, span)?;
        let magnitude_mask = self.rounding_literal(0x7fff_ffff, span)?;
        let sign_mask = self.rounding_literal(0x8000_0000, span)?;
        let magnitude =
            self.rounding_binary(BinaryOperator::And, input_bits, magnitude_mask, span)?;
        let sign = self.rounding_binary(BinaryOperator::And, input_bits, sign_mask, span)?;
        let is_negative = self.rounding_binary(BinaryOperator::NotEqual, sign, zero, span)?;

        let fraction_width = self.rounding_literal(23, span)?;
        let exponent_bits =
            self.rounding_binary(BinaryOperator::ShiftRight, magnitude, fraction_width, span)?;
        let exponent_offset = self.rounding_literal(150, span)?;
        let fractional_width = self.rounding_binary(
            BinaryOperator::Subtract,
            exponent_offset,
            exponent_bits,
            span,
        )?;
        let shift_mask = self.rounding_literal(31, span)?;
        // Select evaluates both sides, so every shift count must stay below 32.
        let shift =
            self.rounding_binary(BinaryOperator::And, fractional_width, shift_mask, span)?;
        let integral_unit = self.rounding_binary(BinaryOperator::ShiftLeft, one, shift, span)?;
        let fraction_mask =
            self.rounding_binary(BinaryOperator::Subtract, integral_unit, one, span)?;
        let discarded_bits =
            self.rounding_binary(BinaryOperator::And, input_bits, fraction_mask, span)?;
        let has_fraction =
            self.rounding_binary(BinaryOperator::NotEqual, discarded_bits, zero, span)?;
        let integral_mask = self.append(
            Expression::Unary {
                op: UnaryOperator::BitwiseNot,
                expr: fraction_mask,
            },
            span,
        )?;
        let truncated_bits =
            self.rounding_binary(BinaryOperator::And, input_bits, integral_mask, span)?;
        let adjusted_bits =
            self.rounding_binary(BinaryOperator::Add, truncated_bits, integral_unit, span)?;
        let rounds_away_from_zero = match rounding {
            Rounding::Floor => is_negative,
            Rounding::Ceil => self.rounding_binary(BinaryOperator::Equal, sign, zero, span)?,
        };
        let adjust = self.rounding_binary(
            BinaryOperator::LogicalAnd,
            rounds_away_from_zero,
            has_fraction,
            span,
        )?;
        let integral_bits = self.rounding_select(adjust, adjusted_bits, truncated_bits, span)?;

        let small_bits = match rounding {
            Rounding::Floor => {
                let negative_one = self.rounding_literal(0xbf80_0000, span)?;
                self.rounding_select(is_negative, negative_one, zero, span)?
            }
            Rounding::Ceil => {
                let positive_one = self.rounding_literal(0x3f80_0000, span)?;
                self.rounding_select(is_negative, sign_mask, positive_one, span)?
            }
        };
        let is_zero = self.rounding_binary(BinaryOperator::Equal, magnitude, zero, span)?;
        let small_bits = self.rounding_select(is_zero, input_bits, small_bits, span)?;
        let one_bits = self.rounding_literal(0x3f80_0000, span)?;
        let is_small = self.rounding_binary(BinaryOperator::Less, magnitude, one_bits, span)?;
        let result_bits = self.rounding_select(is_small, small_bits, integral_bits, span)?;

        let integral_threshold = self.rounding_literal(0x4b00_0000, span)?;
        let is_large = self.rounding_binary(
            BinaryOperator::GreaterEqual,
            magnitude,
            integral_threshold,
            span,
        )?;
        let result_bits = self.rounding_select(is_large, input_bits, result_bits, span)?;
        let infinity = self.rounding_literal(0x7f80_0000, span)?;
        let is_nan = self.rounding_binary(BinaryOperator::Greater, magnitude, infinity, span)?;
        let quiet_nan = self.rounding_literal(0x7fc0_0000, span)?;
        let result_bits = self.rounding_select(is_nan, quiet_nan, result_bits, span)?;

        // Keep non-finite results out of WGSL constant evaluation.
        let pointer = self.temporary_pointer(&scalar_resolution(Scalar::U32), span)?;
        self.push_statement(
            Statement::Store {
                pointer,
                value: result_bits,
            },
            span,
        );
        let result_bits = self.append(Expression::Load { pointer }, span)?;
        self.append(
            Expression::As {
                expr: result_bits,
                kind: ScalarKind::Float,
                convert: None,
            },
            span,
        )
    }

    fn rounding_literal(
        &mut self,
        value: u32,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Literal(Literal::U32(value)), span)
    }

    fn rounding_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

    fn rounding_select(
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
}
