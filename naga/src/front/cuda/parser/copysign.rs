use super::*;

impl Parser<'_> {
    pub(super) fn lower_copysign_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut arguments = arguments.into_iter();
        let magnitude = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let sign = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
        let magnitude_bits = self.bitcast_scalar(magnitude.handle, Scalar::U32, span)?;
        let sign_bits = self.bitcast_scalar(sign.handle, Scalar::U32, span)?;
        let magnitude_mask = self.append(Expression::Literal(Literal::U32(0x7fff_ffff)), span)?;
        let sign_mask = self.append(Expression::Literal(Literal::U32(0x8000_0000)), span)?;
        let magnitude = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: magnitude_bits,
                right: magnitude_mask,
            },
            span,
        )?;
        let sign = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: sign_bits,
                right: sign_mask,
            },
            span,
        )?;
        let bits = self.append(
            Expression::Binary {
                op: BinaryOperator::InclusiveOr,
                left: magnitude,
                right: sign,
            },
            span,
        )?;
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
}
