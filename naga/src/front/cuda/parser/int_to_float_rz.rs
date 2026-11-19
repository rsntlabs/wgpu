use super::*;
use crate::MathFunction;
use BinaryOperator::{
    Add, And, ExclusiveOr, InclusiveOr, NotEqual, ShiftLeft, ShiftRight, Subtract,
};

impl Parser<'_> {
    pub(super) fn lower_integer_to_float_rz_call(
        &mut self,
        source: Scalar,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut argument = arguments.into_iter().next().unwrap();
        let needs_int_conversion =
            self.source_scalar(&argument.ty) != Some(SourceScalar::Scalar(source));
        self.parameter_expansion_budget
            .preflight_expressions(1 + usize::from(needs_int_conversion), span)?;
        argument.constant = ConstantValue::default();
        let argument = self.convert_scalar(argument.into(), source)?;
        let signed_bits = match source {
            Scalar::I32 => Some(self.bitcast_scalar(argument.handle, Scalar::U32, span)?),
            Scalar::U32 => None,
            _ => unreachable!(),
        };

        let literal = |parser: &mut Self, value| {
            parser.append(Expression::Literal(Literal::U32(value)), span)
        };
        let binary = |parser: &mut Self, op, left, right| {
            parser.append(Expression::Binary { op, left, right }, span)
        };
        let zero = literal(self, 0)?;
        let one = literal(self, 1)?;
        let top_bit = literal(self, 31)?;
        let (magnitude, negative_digit) = if let Some(bits) = signed_bits {
            let negative_digit = binary(self, ShiftRight, bits, top_bit)?;
            let negative = binary(self, NotEqual, negative_digit, zero)?;
            let all_ones = literal(self, u32::MAX)?;
            let negative_mask = self.append(
                Expression::Select {
                    condition: negative,
                    accept: all_ones,
                    reject: zero,
                },
                span,
            )?;
            // Use the unsigned magnitude so INT_MIN never needs signed negation.
            let flipped = binary(self, ExclusiveOr, bits, negative_mask)?;
            (
                binary(self, Add, flipped, negative_digit)?,
                Some(negative_digit),
            )
        } else {
            (argument.handle, None)
        };
        let nonzero_magnitude = binary(self, InclusiveOr, magnitude, one)?;
        let leading_zeros = self.append(
            Expression::Math {
                fun: MathFunction::CountLeadingZeros,
                arg: nonzero_magnitude,
                arg1: None,
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        let exponent = binary(self, Subtract, top_bit, leading_zeros)?;
        let fraction_width = literal(self, 23)?;
        let pivot = self.append(
            Expression::Math {
                fun: MathFunction::Min,
                arg: exponent,
                arg1: Some(fraction_width),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        // These shifts move the leading bit to position 23 and discard excess low bits.
        let left_shift = binary(self, Subtract, fraction_width, pivot)?;
        let right_shift = binary(self, Subtract, exponent, pivot)?;
        let shifted = binary(self, ShiftLeft, magnitude, left_shift)?;
        let significand = binary(self, ShiftRight, shifted, right_shift)?;

        let fraction_mask = literal(self, 0x007f_ffff)?;
        let fraction = binary(self, And, significand, fraction_mask)?;
        let bias = literal(self, 127)?;
        let biased = binary(self, Add, exponent, bias)?;
        let exponent_bits = binary(self, ShiftLeft, biased, fraction_width)?;
        let sign_bits = if let Some(negative_digit) = negative_digit {
            Some(binary(self, ShiftLeft, negative_digit, top_bit)?)
        } else {
            None
        };
        let magnitude_bits = binary(self, InclusiveOr, exponent_bits, fraction)?;
        let encoded = if let Some(sign_bits) = sign_bits {
            binary(self, InclusiveOr, sign_bits, magnitude_bits)?
        } else {
            magnitude_bits
        };
        let nonzero = binary(self, NotEqual, magnitude, zero)?;
        let result_bits = self.append(
            Expression::Select {
                condition: nonzero,
                accept: encoded,
                reject: zero,
            },
            span,
        )?;
        let handle = self.bitcast_scalar(result_bits, Scalar::F32, span)?;
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
