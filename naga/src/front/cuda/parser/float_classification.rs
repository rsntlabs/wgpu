use super::functions::FunctionCandidate;
use super::*;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FloatClassification {
    Finite,
    Infinite,
    NaN,
    SignBit,
}

impl Parser<'_> {
    pub(super) fn check_float_classification_argument(
        &self,
        candidate: FunctionCandidate,
        arguments: &[impl CallArgument],
        span: Span,
    ) -> Result<(), ParseError> {
        if matches!(candidate, FunctionCandidate::FloatClassification(_))
            && arguments[0].ty().and_then(|ty| self.source_scalar(ty))
                != Some(SourceScalar::Scalar(Scalar::F32))
        {
            return Err(ParseError {
                message: String::from(
                    "classification intrinsics require float arguments; cast integral arguments explicitly",
                ),
                span,
            });
        }
        Ok(())
    }

    pub(super) fn lower_float_classification_call(
        &mut self,
        classification: FloatClassification,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let value = arguments.into_iter().next().unwrap();
        let bits = self.bitcast_scalar(value.handle, Scalar::U32, span)?;
        let (mask, comparison, bound) = match classification {
            FloatClassification::Finite => (0x7fff_ffff, BinaryOperator::Less, 0x7f80_0000),
            FloatClassification::Infinite => (0x7fff_ffff, BinaryOperator::Equal, 0x7f80_0000),
            FloatClassification::NaN => (0x7fff_ffff, BinaryOperator::Greater, 0x7f80_0000),
            FloatClassification::SignBit => (0x8000_0000, BinaryOperator::NotEqual, 0),
        };
        let mask = self.append(Expression::Literal(Literal::U32(mask)), span)?;
        let masked = self.append(
            Expression::Binary {
                op: BinaryOperator::And,
                left: bits,
                right: mask,
            },
            span,
        )?;
        let bound = self.append(Expression::Literal(Literal::U32(bound)), span)?;
        let predicate = self.append(
            Expression::Binary {
                op: comparison,
                left: masked,
                right: bound,
            },
            span,
        )?;
        let handle = self.append(
            Expression::As {
                expr: predicate,
                target: Scalar::I32,
            },
            span,
        )?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty: scalar_resolution(Scalar::I32),
            span,
        }
        .into())
    }
}
