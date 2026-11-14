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

#[derive(Clone, Copy, PartialEq)]
pub(super) enum PackedArithmeticSaturation {
    Wrapping,
    Unsigned,
    Signed,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum PackedAverageMode {
    SignedAwayFromZero,
    UnsignedUp,
    UnsignedDown,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum PackedArithmeticOperation {
    Add(PackedArithmeticSaturation),
    Subtract(PackedArithmeticSaturation),
    Average(PackedAverageMode),
    AbsoluteDifference { signed: bool },
    SumAbsoluteDifferences { signed: bool },
    Minimum { signed: bool },
    Maximum { signed: bool },
    Equal { mask: bool },
    NotEqual { mask: bool },
    LessThan { signed: bool, mask: bool },
}

#[derive(Clone, Copy)]
enum PackedSignedRounding {
    Saturate {
        minimum: Handle<Expression>,
        maximum: Handle<Expression>,
    },
    Average {
        zero: Handle<Expression>,
        negative_one: Handle<Expression>,
        one: Handle<Expression>,
        two: Handle<Expression>,
    },
}

#[derive(Clone, Copy)]
struct PackedSignedConstants {
    sign_bit: Handle<Expression>,
    bias: Handle<Expression>,
    radix: Handle<Expression>,
    rounding: PackedSignedRounding,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) struct PackedArithmeticBuiltin {
    pub(super) lane_width: u32,
    pub(super) operation: PackedArithmeticOperation,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum PackedUnaryOperation {
    Absolute,
    Negate,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) struct PackedUnaryBuiltin {
    pub(super) lane_width: u32,
    pub(super) operation: PackedUnaryOperation,
    pub(super) saturating: bool,
}

impl Parser<'_> {
    pub(super) fn lower_packed_unary_call(
        &mut self,
        builtin: PackedUnaryBuiltin,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let value =
            self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::U32)?;
        let handle = self.packed_unary(builtin, value.handle, span)?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty: scalar_resolution(Scalar::U32),
            span,
        }
        .into())
    }

    pub(super) fn packed_unary(
        &mut self,
        builtin: PackedUnaryBuiltin,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let lane_radix = 1u32 << builtin.lane_width;
        let mask = self.append(Expression::Literal(Literal::U32(lane_radix - 1)), span)?;
        let sign_bit = self.append(Expression::Literal(Literal::U32(lane_radix / 2)), span)?;
        let radix = self.append(Expression::Literal(Literal::U32(lane_radix)), span)?;
        let maximum = if builtin.saturating {
            Some(self.append(Expression::Literal(Literal::U32(lane_radix / 2 - 1)), span)?)
        } else {
            None
        };
        let mut result = None;
        for lane in 0..32 / builtin.lane_width {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let shift = if lane == 0 {
                None
            } else {
                Some(self.append(
                    Expression::Literal(Literal::U32(lane * builtin.lane_width)),
                    span,
                )?)
            };
            let lane = if let Some(shift) = shift {
                self.integer_binary(BinaryOperator::ShiftRight, value, shift, span)?
            } else {
                value
            };
            let lane = self.integer_binary(BinaryOperator::And, lane, mask, span)?;
            let lane_value = match builtin.operation {
                PackedUnaryOperation::Absolute => {
                    let negative =
                        self.integer_binary(BinaryOperator::GreaterEqual, lane, sign_bit, span)?;
                    let negated =
                        self.integer_binary(BinaryOperator::Subtract, radix, lane, span)?;
                    let magnitude = self.append(
                        Expression::Select {
                            condition: negative,
                            accept: negated,
                            reject: lane,
                        },
                        span,
                    )?;
                    if let Some(maximum) = maximum {
                        self.append(
                            Expression::Math {
                                fun: MathFunction::Min,
                                arg: magnitude,
                                arg1: Some(maximum),
                                arg2: None,
                                arg3: None,
                            },
                            span,
                        )?
                    } else {
                        magnitude
                    }
                }
                PackedUnaryOperation::Negate => {
                    let negated =
                        self.integer_binary(BinaryOperator::Subtract, radix, lane, span)?;
                    let negated = self.integer_binary(BinaryOperator::And, negated, mask, span)?;
                    if let Some(maximum) = maximum {
                        let minimum =
                            self.integer_binary(BinaryOperator::Equal, lane, sign_bit, span)?;
                        self.append(
                            Expression::Select {
                                condition: minimum,
                                accept: maximum,
                                reject: negated,
                            },
                            span,
                        )?
                    } else {
                        negated
                    }
                }
            };
            let lane_value = if let Some(shift) = shift {
                self.integer_binary(BinaryOperator::ShiftLeft, lane_value, shift, span)?
            } else {
                lane_value
            };
            result = Some(if let Some(result) = result {
                self.integer_binary(BinaryOperator::InclusiveOr, result, lane_value, span)?
            } else {
                lane_value
            });
        }
        Ok(result.unwrap())
    }

    pub(super) fn packed_arithmetic(
        &mut self,
        builtin: PackedArithmeticBuiltin,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let lane_radix = 1u32 << builtin.lane_width;
        let mask = self.append(Expression::Literal(Literal::U32(lane_radix - 1)), span)?;
        let subtract = matches!(builtin.operation, PackedArithmeticOperation::Subtract(_));
        let radix = if builtin.operation
            == PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Wrapping)
        {
            Some(self.append(Expression::Literal(Literal::U32(lane_radix)), span)?)
        } else {
            None
        };
        let unsigned_average = if matches!(
            builtin.operation,
            PackedArithmeticOperation::Average(
                PackedAverageMode::UnsignedUp | PackedAverageMode::UnsignedDown
            )
        ) {
            Some(self.append(Expression::Literal(Literal::U32(1)), span)?)
        } else {
            None
        };
        let comparison_constants = match builtin.operation {
            PackedArithmeticOperation::Equal { mask: output_mask }
            | PackedArithmeticOperation::NotEqual { mask: output_mask }
            | PackedArithmeticOperation::LessThan {
                mask: output_mask, ..
            } => {
                let zero = self.append(Expression::Literal(Literal::U32(0)), span)?;
                let true_value = if output_mask {
                    mask
                } else {
                    self.append(Expression::Literal(Literal::U32(1)), span)?
                };
                Some((zero, true_value))
            }
            _ => None,
        };
        let ordered_sign_bit = if matches!(
            builtin.operation,
            PackedArithmeticOperation::AbsoluteDifference { signed: true }
                | PackedArithmeticOperation::SumAbsoluteDifferences { signed: true }
                | PackedArithmeticOperation::Minimum { signed: true }
                | PackedArithmeticOperation::Maximum { signed: true }
                | PackedArithmeticOperation::LessThan { signed: true, .. }
        ) {
            Some(self.append(Expression::Literal(Literal::U32(lane_radix / 2)), span)?)
        } else {
            None
        };
        let signed_constants = if matches!(
            builtin.operation,
            PackedArithmeticOperation::Add(PackedArithmeticSaturation::Signed)
                | PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Signed)
                | PackedArithmeticOperation::Average(PackedAverageMode::SignedAwayFromZero)
        ) {
            let bias = (lane_radix / 2) as i32;
            let sign_bit = self.append(Expression::Literal(Literal::U32(lane_radix / 2)), span)?;
            let bias_handle = self.append(Expression::Literal(Literal::I32(bias)), span)?;
            let rounding = if matches!(builtin.operation, PackedArithmeticOperation::Average(_)) {
                PackedSignedRounding::Average {
                    zero: self.append(Expression::Literal(Literal::I32(0)), span)?,
                    negative_one: self.append(Expression::Literal(Literal::I32(-1)), span)?,
                    one: self.append(Expression::Literal(Literal::I32(1)), span)?,
                    two: self.append(Expression::Literal(Literal::I32(2)), span)?,
                }
            } else {
                PackedSignedRounding::Saturate {
                    minimum: self.append(Expression::Literal(Literal::I32(-bias)), span)?,
                    maximum: self.append(Expression::Literal(Literal::I32(bias - 1)), span)?,
                }
            };
            Some(PackedSignedConstants {
                sign_bit,
                bias: bias_handle,
                radix: self.append(Expression::Literal(Literal::I32(lane_radix as i32)), span)?,
                rounding,
            })
        } else {
            None
        };
        let mut result = None;
        for lane in 0..32 / builtin.lane_width {
            self.parameter_expansion_budget.charge_work(1, span)?;
            let shift = if lane == 0 {
                None
            } else {
                Some(self.append(
                    Expression::Literal(Literal::U32(lane * builtin.lane_width)),
                    span,
                )?)
            };
            let (left, right) = if let Some(shift) = shift {
                (
                    self.integer_binary(BinaryOperator::ShiftRight, left, shift, span)?,
                    self.integer_binary(BinaryOperator::ShiftRight, right, shift, span)?,
                )
            } else {
                (left, right)
            };
            let left = self.integer_binary(BinaryOperator::And, left, mask, span)?;
            let right = self.integer_binary(BinaryOperator::And, right, mask, span)?;
            let value = if let Some((zero, true_value)) = comparison_constants {
                let (left, right) = if let Some(sign_bit) = ordered_sign_bit {
                    (
                        self.integer_binary(BinaryOperator::ExclusiveOr, left, sign_bit, span)?,
                        self.integer_binary(BinaryOperator::ExclusiveOr, right, sign_bit, span)?,
                    )
                } else {
                    (left, right)
                };
                let condition = self.integer_binary(
                    match builtin.operation {
                        PackedArithmeticOperation::Equal { .. } => BinaryOperator::Equal,
                        PackedArithmeticOperation::NotEqual { .. } => BinaryOperator::NotEqual,
                        PackedArithmeticOperation::LessThan { .. } => BinaryOperator::Less,
                        _ => unreachable!(),
                    },
                    left,
                    right,
                    span,
                )?;
                self.append(
                    Expression::Select {
                        condition,
                        accept: true_value,
                        reject: zero,
                    },
                    span,
                )?
            } else if matches!(
                builtin.operation,
                PackedArithmeticOperation::AbsoluteDifference { .. }
                    | PackedArithmeticOperation::SumAbsoluteDifferences { .. }
            ) {
                let (left, right) = if let Some(sign_bit) = ordered_sign_bit {
                    // Flipping the sign bit biases signed lanes without changing distances.
                    (
                        self.integer_binary(BinaryOperator::ExclusiveOr, left, sign_bit, span)?,
                        self.integer_binary(BinaryOperator::ExclusiveOr, right, sign_bit, span)?,
                    )
                } else {
                    (left, right)
                };
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
                self.integer_binary(BinaryOperator::Subtract, maximum, minimum, span)?
            } else if matches!(
                builtin.operation,
                PackedArithmeticOperation::Minimum { .. }
                    | PackedArithmeticOperation::Maximum { .. }
            ) {
                let (left, right) = if let Some(sign_bit) = ordered_sign_bit {
                    (
                        self.integer_binary(BinaryOperator::ExclusiveOr, left, sign_bit, span)?,
                        self.integer_binary(BinaryOperator::ExclusiveOr, right, sign_bit, span)?,
                    )
                } else {
                    (left, right)
                };
                let selected = self.append(
                    Expression::Math {
                        fun: if matches!(
                            builtin.operation,
                            PackedArithmeticOperation::Minimum { .. }
                        ) {
                            MathFunction::Min
                        } else {
                            MathFunction::Max
                        },
                        arg: left,
                        arg1: Some(right),
                        arg2: None,
                        arg3: None,
                    },
                    span,
                )?;
                if let Some(sign_bit) = ordered_sign_bit {
                    self.integer_binary(BinaryOperator::ExclusiveOr, selected, sign_bit, span)?
                } else {
                    selected
                }
            } else if let Some(constants) = signed_constants {
                self.packed_signed_arithmetic(subtract, left, right, constants, span)?
            } else if let Some(one) = unsigned_average {
                let sum = self.integer_binary(BinaryOperator::Add, left, right, span)?;
                let sum = if builtin.operation
                    == PackedArithmeticOperation::Average(PackedAverageMode::UnsignedUp)
                {
                    self.integer_binary(BinaryOperator::Add, sum, one, span)?
                } else {
                    sum
                };
                self.integer_binary(BinaryOperator::ShiftRight, sum, one, span)?
            } else if matches!(
                builtin.operation,
                PackedArithmeticOperation::Add(PackedArithmeticSaturation::Unsigned)
                    | PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Unsigned)
            ) {
                if subtract {
                    let left = self.append(
                        Expression::Math {
                            fun: MathFunction::Max,
                            arg: left,
                            arg1: Some(right),
                            arg2: None,
                            arg3: None,
                        },
                        span,
                    )?;
                    self.integer_binary(BinaryOperator::Subtract, left, right, span)?
                } else {
                    let sum = self.integer_binary(BinaryOperator::Add, left, right, span)?;
                    self.append(
                        Expression::Math {
                            fun: MathFunction::Min,
                            arg: sum,
                            arg1: Some(mask),
                            arg2: None,
                            arg3: None,
                        },
                        span,
                    )?
                }
            } else if let Some(radix) = radix {
                let left = self.integer_binary(BinaryOperator::Add, left, radix, span)?;
                self.integer_binary(BinaryOperator::Subtract, left, right, span)?
            } else {
                self.integer_binary(BinaryOperator::Add, left, right, span)?
            };
            let value = self.integer_binary(BinaryOperator::And, value, mask, span)?;
            if matches!(
                builtin.operation,
                PackedArithmeticOperation::SumAbsoluteDifferences { .. }
            ) {
                result = Some(if let Some(result) = result {
                    self.integer_binary(BinaryOperator::Add, result, value, span)?
                } else {
                    value
                });
                continue;
            }
            let value = if let Some(shift) = shift {
                self.integer_binary(BinaryOperator::ShiftLeft, value, shift, span)?
            } else {
                value
            };
            result = Some(if let Some(result) = result {
                self.integer_binary(BinaryOperator::InclusiveOr, result, value, span)?
            } else {
                value
            });
        }
        Ok(result.unwrap())
    }

    fn packed_signed_arithmetic(
        &mut self,
        subtract: bool,
        left: Handle<Expression>,
        right: Handle<Expression>,
        constants: PackedSignedConstants,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let PackedSignedConstants {
            sign_bit,
            bias,
            radix,
            rounding,
        } = constants;
        let left = self.integer_binary(BinaryOperator::ExclusiveOr, left, sign_bit, span)?;
        let right = self.integer_binary(BinaryOperator::ExclusiveOr, right, sign_bit, span)?;
        let left = self.append(
            Expression::As {
                expr: left,
                target: Scalar::I32,
            },
            span,
        )?;
        let right = self.append(
            Expression::As {
                expr: right,
                target: Scalar::I32,
            },
            span,
        )?;
        let left = self.integer_binary(BinaryOperator::Subtract, left, bias, span)?;
        let right = self.integer_binary(BinaryOperator::Subtract, right, bias, span)?;
        let value = self.integer_binary(
            if subtract {
                BinaryOperator::Subtract
            } else {
                BinaryOperator::Add
            },
            left,
            right,
            span,
        )?;
        let value = match rounding {
            PackedSignedRounding::Saturate { minimum, maximum } => self.append(
                Expression::Math {
                    fun: MathFunction::Clamp,
                    arg: value,
                    arg1: Some(minimum),
                    arg2: Some(maximum),
                    arg3: None,
                },
                span,
            )?,
            PackedSignedRounding::Average {
                zero,
                negative_one,
                one,
                two,
            } => {
                let negative = self.integer_binary(BinaryOperator::Less, value, zero, span)?;
                let bias = self.append(
                    Expression::Select {
                        condition: negative,
                        accept: negative_one,
                        reject: one,
                    },
                    span,
                )?;
                let biased = self.integer_binary(BinaryOperator::Add, value, bias, span)?;
                self.integer_binary(BinaryOperator::Divide, biased, two, span)?
            }
        };
        // Add the radix so constant evaluation converts only nonnegative values.
        let value = self.integer_binary(BinaryOperator::Add, value, radix, span)?;
        self.append(
            Expression::As {
                expr: value,
                target: Scalar::U32,
            },
            span,
        )
    }

    pub(super) fn byte_swap32(
        &mut self,
        value: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let byte_mask = self.append(Expression::Literal(Literal::U32(0xff)), span)?;
        let second_byte_mask = self.append(Expression::Literal(Literal::U32(0xff00)), span)?;
        let eight = self.append(Expression::Literal(Literal::U32(8)), span)?;
        let twenty_four = self.append(Expression::Literal(Literal::U32(24)), span)?;
        let first = self.integer_binary(BinaryOperator::And, value, byte_mask, span)?;
        let first = self.integer_binary(BinaryOperator::ShiftLeft, first, twenty_four, span)?;
        let second = self.integer_binary(BinaryOperator::And, value, second_byte_mask, span)?;
        let second = self.integer_binary(BinaryOperator::ShiftLeft, second, eight, span)?;
        let third = self.integer_binary(BinaryOperator::ShiftRight, value, eight, span)?;
        let third = self.integer_binary(BinaryOperator::And, third, second_byte_mask, span)?;
        let fourth = self.integer_binary(BinaryOperator::ShiftRight, value, twenty_four, span)?;
        let low = self.integer_binary(BinaryOperator::InclusiveOr, third, fourth, span)?;
        let high = self.integer_binary(BinaryOperator::InclusiveOr, first, second, span)?;
        self.integer_binary(BinaryOperator::InclusiveOr, high, low, span)
    }

    pub(super) fn dot2_accumulate(
        &mut self,
        high: bool,
        scalar: Scalar,
        left: Handle<Expression>,
        right: Handle<Expression>,
        accumulator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let half_word = self.append(Expression::Literal(Literal::U32(16)), span)?;
        let byte = self.append(Expression::Literal(Literal::U32(8)), span)?;
        let mut dot = self.append(
            Expression::Literal(if scalar == Scalar::I32 {
                Literal::I32(0)
            } else {
                Literal::U32(0)
            }),
            span,
        )?;
        for lane in 0..2 {
            let left_offset = self.append(Expression::Literal(Literal::U32(lane * 16)), span)?;
            let right_offset = self.append(
                Expression::Literal(Literal::U32((if high { 16 } else { 0 }) + lane * 8)),
                span,
            )?;
            let left_lane = self.append(
                Expression::Math {
                    fun: MathFunction::ExtractBits,
                    arg: left,
                    arg1: Some(left_offset),
                    arg2: Some(half_word),
                    arg3: None,
                },
                span,
            )?;
            let right_lane = self.append(
                Expression::Math {
                    fun: MathFunction::ExtractBits,
                    arg: right,
                    arg1: Some(right_offset),
                    arg2: Some(byte),
                    arg3: None,
                },
                span,
            )?;
            let product =
                self.integer_binary(BinaryOperator::Multiply, left_lane, right_lane, span)?;
            dot = self.integer_binary(BinaryOperator::Add, dot, product, span)?;
        }
        self.accumulate32(scalar, dot, accumulator, span)
    }

    pub(super) fn dot4_accumulate(
        &mut self,
        scalar: Scalar,
        left: Handle<Expression>,
        right: Handle<Expression>,
        accumulator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mut packed = [left, right];
        if scalar == Scalar::I32 {
            for word in &mut packed {
                *word = self.bitcast_scalar(*word, Scalar::U32, span)?;
            }
        }
        let dot = self.append(
            Expression::Math {
                fun: if scalar == Scalar::I32 {
                    MathFunction::Dot4I8Packed
                } else {
                    MathFunction::Dot4U8Packed
                },
                arg: packed[0],
                arg1: Some(packed[1]),
                arg2: None,
                arg3: None,
            },
            span,
        )?;
        self.accumulate32(scalar, dot, accumulator, span)
    }

    fn accumulate32(
        &mut self,
        scalar: Scalar,
        value: Handle<Expression>,
        accumulator: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let (value, accumulator) = if scalar == Scalar::I32 {
            (
                self.bitcast_scalar(value, Scalar::U32, span)?,
                self.bitcast_scalar(accumulator, Scalar::U32, span)?,
            )
        } else {
            (value, accumulator)
        };
        let result = self.wrapping_add32(value, accumulator, span)?;
        if scalar == Scalar::I32 {
            self.bitcast_scalar(result, Scalar::I32, span)
        } else {
            Ok(result)
        }
    }

    pub(super) fn byte_permutation(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        selector: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let selector_mask = self.append(Expression::Literal(Literal::U32(7)), span)?;
        let byte_index_mask = self.append(Expression::Literal(Literal::U32(3)), span)?;
        let byte_bits = self.append(Expression::Literal(Literal::U32(8)), span)?;
        let word_bytes = self.append(Expression::Literal(Literal::U32(4)), span)?;
        let byte_mask = self.append(Expression::Literal(Literal::U32(255)), span)?;
        let mut result = self.append(Expression::Literal(Literal::U32(0)), span)?;
        for byte in 0..4 {
            let selector_shift = self.append(Expression::Literal(Literal::U32(byte * 4)), span)?;
            let nibble =
                self.byte_perm_binary(BinaryOperator::ShiftRight, selector, selector_shift, span)?;
            let index = self.byte_perm_binary(BinaryOperator::And, nibble, selector_mask, span)?;
            let in_left = self.byte_perm_binary(BinaryOperator::Less, index, word_bytes, span)?;
            let word = self.append(
                Expression::Select {
                    condition: in_left,
                    accept: left,
                    reject: right,
                },
                span,
            )?;
            let offset =
                self.byte_perm_binary(BinaryOperator::And, index, byte_index_mask, span)?;
            let offset =
                self.byte_perm_binary(BinaryOperator::Multiply, offset, byte_bits, span)?;
            let unpacked = self.byte_perm_binary(BinaryOperator::ShiftRight, word, offset, span)?;
            let extracted =
                self.byte_perm_binary(BinaryOperator::And, unpacked, byte_mask, span)?;
            let output_shift = self.append(Expression::Literal(Literal::U32(byte * 8)), span)?;
            let placed =
                self.byte_perm_binary(BinaryOperator::ShiftLeft, extracted, output_shift, span)?;
            result = self.byte_perm_binary(BinaryOperator::InclusiveOr, result, placed, span)?;
        }
        Ok(result)
    }

    fn byte_perm_binary(
        &mut self,
        op: BinaryOperator,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.append(Expression::Binary { op, left, right }, span)
    }

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
                *key = self.integer_binary(BinaryOperator::ExclusiveOr, bits, sign, span)?;
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
        let difference = self.integer_binary(BinaryOperator::Subtract, maximum, minimum, span)?;
        self.wrapping_add32(difference, accumulator, span)
    }

    fn wrapping_add32(
        &mut self,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let mask = self.append(Expression::Literal(Literal::U32(0xffff)), span)?;
        let width = self.append(Expression::Literal(Literal::U32(16)), span)?;
        // Limb sums stay in range even when a backend evaluates literal arguments.
        let low = self.integer_binary(BinaryOperator::And, left, mask, span)?;
        let right_low = self.integer_binary(BinaryOperator::And, right, mask, span)?;
        let low_sum = self.integer_binary(BinaryOperator::Add, low, right_low, span)?;
        let carry = self.integer_binary(BinaryOperator::ShiftRight, low_sum, width, span)?;
        let high = self.integer_binary(BinaryOperator::ShiftRight, left, width, span)?;
        let right_high = self.integer_binary(BinaryOperator::ShiftRight, right, width, span)?;
        let high_sum = self.integer_binary(BinaryOperator::Add, high, right_high, span)?;
        let high_sum = self.integer_binary(BinaryOperator::Add, high_sum, carry, span)?;
        let high_word = self.integer_binary(BinaryOperator::And, high_sum, mask, span)?;
        let high_word = self.integer_binary(BinaryOperator::ShiftLeft, high_word, width, span)?;
        let low_word = self.integer_binary(BinaryOperator::And, low_sum, mask, span)?;
        self.integer_binary(BinaryOperator::InclusiveOr, high_word, low_word, span)
    }

    fn integer_binary(
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
