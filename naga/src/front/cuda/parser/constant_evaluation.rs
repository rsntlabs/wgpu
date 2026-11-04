use crate::{
    proc::{ConstantEvaluator, ConstantEvaluatorError, ExpressionKindTracker, Layouter},
    BinaryOperator, Expression, Handle, Literal, Module, Scalar, Span, UnaryOperator,
};

#[allow(unused_imports)]
use num_traits::float::FloatCore as _;

pub(super) fn unary(op: UnaryOperator, value: Literal) -> Option<Literal> {
    if !supported_literal(value) {
        return None;
    }
    match (op, value) {
        (UnaryOperator::Negate, Literal::I64(value)) => {
            value.checked_neg()?;
        }
        (UnaryOperator::Negate, Literal::I32(value)) => {
            value.checked_neg()?;
        }
        (UnaryOperator::Negate, Literal::U32(_)) => {
            return binary(BinaryOperator::Subtract, Literal::U32(0), value);
        }
        (UnaryOperator::Negate, Literal::U64(_)) => {
            return binary(BinaryOperator::Subtract, Literal::U64(0), value);
        }
        _ => {}
    }
    evaluate(|evaluator| {
        let expr = evaluator.try_eval_and_append(Expression::Literal(value), Span::UNDEFINED)?;
        evaluator.try_eval_and_append(Expression::Unary { op, expr }, Span::UNDEFINED)
    })
    .or_else(|| match (op, value) {
        (UnaryOperator::Negate, Literal::F32(value)) => {
            Some(Literal::F32(f32::from_bits(value.to_bits() ^ 0x8000_0000)))
        }
        _ => None,
    })
}

pub(super) fn binary(op: BinaryOperator, left: Literal, mut right: Literal) -> Option<Literal> {
    if !supported_literal(left) || !supported_literal(right) {
        return None;
    }
    if matches!(op, BinaryOperator::ShiftLeft | BinaryOperator::ShiftRight) {
        let width = u32::from(left.width()) * 8;
        let count = match right {
            Literal::I32(count) => u32::try_from(count).ok()?,
            Literal::U32(count) => count,
            Literal::I64(count) => u32::try_from(count).ok()?,
            Literal::U64(count) => u32::try_from(count).ok()?,
            _ => return None,
        };
        if count >= width {
            return None;
        }
        if op == BinaryOperator::ShiftLeft {
            // C++20 shifts wrap; WGSL constant evaluation rejects lost bits.
            return match left {
                Literal::I32(value) => Some(Literal::I32(value.wrapping_shl(count))),
                Literal::U32(value) => Some(Literal::U32(value.wrapping_shl(count))),
                Literal::I64(value) => Some(Literal::I64(value.wrapping_shl(count))),
                Literal::U64(value) => Some(Literal::U64(value.wrapping_shl(count))),
                _ => None,
            };
        }
        right = Literal::U32(count);
    }
    match (op, left, right) {
        (BinaryOperator::Add, Literal::I64(left), Literal::I64(right)) => {
            left.checked_add(right)?;
        }
        (BinaryOperator::Subtract, Literal::I64(left), Literal::I64(right)) => {
            left.checked_sub(right)?;
        }
        (BinaryOperator::Multiply, Literal::I64(left), Literal::I64(right)) => {
            left.checked_mul(right)?;
        }
        (BinaryOperator::Divide, Literal::I64(left), Literal::I64(right)) => {
            left.checked_div(right)?;
        }
        (BinaryOperator::Modulo, Literal::I64(left), Literal::I64(right)) => {
            left.checked_rem(right)?;
        }
        (BinaryOperator::Add, Literal::I32(left), Literal::I32(right)) => {
            left.checked_add(right)?;
        }
        (BinaryOperator::Subtract, Literal::I32(left), Literal::I32(right)) => {
            left.checked_sub(right)?;
        }
        (BinaryOperator::Multiply, Literal::I32(left), Literal::I32(right)) => {
            left.checked_mul(right)?;
        }
        (BinaryOperator::Divide, Literal::I32(left), Literal::I32(right)) => {
            left.checked_div(right)?;
        }
        (BinaryOperator::Modulo, Literal::I32(left), Literal::I32(right)) => {
            left.checked_rem(right)?;
        }
        (BinaryOperator::Divide | BinaryOperator::Modulo, Literal::U32(_), Literal::U32(0))
        | (BinaryOperator::Divide | BinaryOperator::Modulo, Literal::U64(_), Literal::U64(0)) => {
            return None
        }
        (BinaryOperator::Modulo, Literal::F32(_), Literal::F32(_)) => return None,
        _ => {}
    }
    evaluate(|evaluator| {
        let left = evaluator.try_eval_and_append(Expression::Literal(left), Span::UNDEFINED)?;
        let right = evaluator.try_eval_and_append(Expression::Literal(right), Span::UNDEFINED)?;
        evaluator.try_eval_and_append(Expression::Binary { op, left, right }, Span::UNDEFINED)
    })
    .or_else(|| float_binary(op, left, right))
}

fn float_binary(op: BinaryOperator, left: Literal, right: Literal) -> Option<Literal> {
    let (Literal::F32(left), Literal::F32(right)) = (left, right) else {
        return None;
    };
    let value = match op {
        BinaryOperator::Add => left + right,
        BinaryOperator::Subtract => left - right,
        BinaryOperator::Multiply => left * right,
        BinaryOperator::Divide => left / right,
        BinaryOperator::Equal => return Some(Literal::Bool(left == right)),
        BinaryOperator::NotEqual => return Some(Literal::Bool(left != right)),
        BinaryOperator::Less => return Some(Literal::Bool(left < right)),
        BinaryOperator::LessEqual => return Some(Literal::Bool(left <= right)),
        BinaryOperator::Greater => return Some(Literal::Bool(left > right)),
        BinaryOperator::GreaterEqual => return Some(Literal::Bool(left >= right)),
        _ => return None,
    };
    Some(Literal::F32(if value.is_nan() {
        f32::from_bits(0x7fc0_0000)
    } else {
        value
    }))
}

pub(super) fn convert(value: Literal, target: Scalar) -> Option<Literal> {
    if !supported_literal(value)
        || ![
            Scalar::BOOL,
            Scalar::I16,
            Scalar::U16,
            Scalar::I32,
            Scalar::U32,
            Scalar::I64,
            Scalar::U64,
            Scalar::F32,
        ]
        .contains(&target)
    {
        return None;
    }
    if let Literal::F32(value) = value {
        let truncated = value.trunc();
        let in_range = match target {
            Scalar::I16 => (-32_768.0..32_768.0).contains(&truncated),
            Scalar::U16 => (0.0..65_536.0).contains(&truncated),
            Scalar::I32 => (-2_147_483_648.0..2_147_483_648.0).contains(&truncated),
            Scalar::U32 => (0.0..4_294_967_296.0).contains(&truncated),
            Scalar::I64 => {
                (-9_223_372_036_854_775_808.0..9_223_372_036_854_775_808.0).contains(&truncated)
            }
            Scalar::U64 => (0.0..18_446_744_073_709_551_616.0).contains(&truncated),
            _ => true,
        };
        if !in_range {
            return None;
        }
    }
    evaluate(|evaluator| {
        let expr = evaluator.try_eval_and_append(Expression::Literal(value), Span::UNDEFINED)?;
        evaluator.try_eval_and_append(
            Expression::As {
                expr,
                kind: target.kind,
                convert: Some(target.width),
            },
            Span::UNDEFINED,
        )
    })
    .or(match (value, target) {
        (Literal::F32(value), Scalar::F32) => Some(Literal::F32(value)),
        (Literal::F32(value), Scalar::BOOL) => Some(Literal::Bool(value != 0.0)),
        _ => None,
    })
}

const fn supported_literal(value: Literal) -> bool {
    match value {
        Literal::Bool(_)
        | Literal::I16(_)
        | Literal::U16(_)
        | Literal::I32(_)
        | Literal::U32(_)
        | Literal::I64(_)
        | Literal::U64(_)
        | Literal::F32(_) => true,
        _ => false,
    }
}

fn evaluate(
    operation: impl FnOnce(
        &mut ConstantEvaluator<'_>,
    ) -> Result<Handle<Expression>, ConstantEvaluatorError>,
) -> Option<Literal> {
    let mut module = Module::default();
    let mut expression_kind_tracker = ExpressionKindTracker::new();
    let mut layouter = Layouter::default();
    let handle = operation(&mut ConstantEvaluator::for_wgsl_module(
        &mut module,
        &mut expression_kind_tracker,
        &mut layouter,
        false,
    ))
    .ok()?;
    match module.global_expressions[handle] {
        Expression::Literal(value) if supported_literal(value) => Some(value),
        _ => None,
    }
}
