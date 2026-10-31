use super::*;

impl Parser<'_> {
    pub(super) fn saturate(
        &mut self,
        value: Handle<Expression>,
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
        // Unsigned bits order nonnegative floats and place negatives and NaNs above infinity.
        let one_bits = self.append(Expression::Literal(Literal::U32(0x3f80_0000)), span)?;
        let upper_bounded_bits = self.append(
            Expression::Math {
                fun: crate::MathFunction::Min,
                arg: input_bits,
                arg1: Some(one_bits),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let infinity_bits = self.append(Expression::Literal(Literal::U32(0x7f80_0000)), span)?;
        let is_negative_or_nan = self.append(
            Expression::Binary {
                op: BinaryOperator::Greater,
                left: input_bits,
                right: infinity_bits,
            },
            span,
        )?;
        let zero_bits = self.append(Expression::Literal(Literal::U32(0)), span)?;
        let result_bits = self.append(
            Expression::Select {
                condition: is_negative_or_nan,
                accept: zero_bits,
                reject: upper_bounded_bits,
            },
            span,
        )?;
        self.append(
            Expression::As {
                expr: result_bits,
                kind: ScalarKind::Float,
                convert: None,
            },
            span,
        )
    }
}
