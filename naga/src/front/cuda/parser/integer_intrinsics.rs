use super::*;
use crate::MathFunction;

impl Parser<'_> {
    pub(super) fn population_count64(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        // Some backends only provide population count for 32-bit inputs.
        let low = self.append(
            Expression::As {
                expr: value,
                target: Scalar::U32,
            },
            span,
        )?;
        let shift = self.append(Expression::Literal(Literal::U32(32)), span)?;
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
}
