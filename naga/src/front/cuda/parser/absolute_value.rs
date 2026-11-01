use super::*;

impl Parser<'_> {
    pub(super) fn absolute_value_bits(
        &mut self,
        input_bits: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let magnitude_mask = self.append(Expression::Literal(Literal::U32(0x7fff_ffff)), span)?;
        let magnitude = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: input_bits,
                right: magnitude_mask,
            },
            span,
        )?;
        let infinity = self.append(Expression::Literal(Literal::U32(0x7f80_0000)), span)?;
        let is_nan = self.append(
            Expression::Binary {
                op: BinaryOperator::Greater,
                left: magnitude,
                right: infinity,
            },
            span,
        )?;
        let quiet_nan = self.append(Expression::Literal(Literal::U32(0x7fc0_0000)), span)?;
        let result_bits = self.append(
            Expression::Select {
                condition: is_nan,
                accept: quiet_nan,
                reject: magnitude,
            },
            span,
        )?;
        Ok(result_bits)
    }
}
