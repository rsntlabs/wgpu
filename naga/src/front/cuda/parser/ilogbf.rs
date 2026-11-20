use super::*;

impl Parser<'_> {
    pub(super) fn lower_ilogbf_call(
        &mut self,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        use BinaryOperator as Op;

        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let value =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
        let bits = self.bitcast_scalar(value.handle, Scalar::U32, span)?;

        let literal = |parser: &mut Self, value| parser.append(Expression::Literal(value), span);
        let binary = |parser: &mut Self, op, left, right| {
            parser.append(Expression::Binary { op, left, right }, span)
        };
        let select = |parser: &mut Self, condition, accept, reject| {
            parser.append(
                Expression::Select {
                    condition,
                    accept,
                    reject,
                },
                span,
            )
        };
        let zero = literal(self, Literal::U32(0))?;
        let magnitude_mask = literal(self, Literal::U32(0x7fff_ffff))?;
        let infinity = literal(self, Literal::U32(0x7f80_0000))?;
        let exponent_shift = literal(self, Literal::U32(23))?;
        let exponent_bias = literal(self, Literal::I32(127))?;
        // A subnormal with highest set bit p has exponent p - 149.
        let subnormal_base = literal(self, Literal::I32(31 - 149))?;
        let minimum = literal(self, Literal::I32(i32::MIN))?;
        let maximum = literal(self, Literal::I32(i32::MAX))?;

        let magnitude = binary(self, Op::And, bits, magnitude_mask)?;
        let biased = binary(self, Op::ShiftRight, magnitude, exponent_shift)?;
        let exponent_is_zero = binary(self, Op::Equal, biased, zero)?;
        let biased = self.append(
            Expression::As {
                expr: biased,
                target: Scalar::I32,
            },
            span,
        )?;
        let normal = binary(self, Op::Subtract, biased, exponent_bias)?;
        let leading_zeros = self.append(
            Expression::Math {
                fun: crate::MathFunction::CountLeadingZeros,
                arg: magnitude,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let leading_zeros = self.append(
            Expression::As {
                expr: leading_zeros,
                target: Scalar::I32,
            },
            span,
        )?;
        let subnormal = binary(self, Op::Subtract, subnormal_base, leading_zeros)?;
        let finite = select(self, exponent_is_zero, subnormal, normal)?;

        let is_zero = binary(self, Op::Equal, magnitude, zero)?;
        let is_nan = binary(self, Op::Greater, magnitude, infinity)?;
        let is_infinite = binary(self, Op::Equal, magnitude, infinity)?;
        let zero_or_nan = binary(self, Op::LogicalOr, is_zero, is_nan)?;
        let result = select(self, is_infinite, maximum, finite)?;
        let handle = select(self, zero_or_nan, minimum, result)?;
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
