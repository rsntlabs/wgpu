use super::*;

use super::atomics::{WrappingAtomicFunction, INTEGER_ATOMICS, WRAPPING_ATOMICS};
use super::float_classification::FloatClassification;
use super::float_helpers::FloatMathFunction;
use super::function_declarations::Inlining;
use super::integer_intrinsics::{
    FunnelShiftBuiltin, FunnelShiftDirection, HalfAddBuiltin, PackedArithmeticBuiltin,
    PackedArithmeticOperation, PackedArithmeticSaturation, PackedAverageMode, PackedUnaryBuiltin,
    PackedUnaryOperation,
};
use super::launch_bounds::LaunchBounds;
use super::types::{IntegerSpecifiers, VECTOR_TYPES};
use crate::MathFunction;

const MATH_BUILTINS: [(&str, MathFunction); 4] = [
    ("min", MathFunction::Min),
    ("max", MathFunction::Max),
    ("fminf", MathFunction::Min),
    ("fmaxf", MathFunction::Max),
];

const MATH_SIGNATURES: [([SourceScalar; 2], SourceScalar); 13] = [
    (
        [
            SourceScalar::Scalar(Scalar::I32),
            SourceScalar::Scalar(Scalar::I32),
        ],
        SourceScalar::Scalar(Scalar::I32),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::U32),
            SourceScalar::Scalar(Scalar::U32),
        ],
        SourceScalar::Scalar(Scalar::U32),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::I32),
            SourceScalar::Scalar(Scalar::U32),
        ],
        SourceScalar::Scalar(Scalar::U32),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::U32),
            SourceScalar::Scalar(Scalar::I32),
        ],
        SourceScalar::Scalar(Scalar::U32),
    ),
    (
        [
            SourceScalar::Long(ScalarKind::Sint),
            SourceScalar::Long(ScalarKind::Sint),
        ],
        SourceScalar::Long(ScalarKind::Sint),
    ),
    (
        [
            SourceScalar::Long(ScalarKind::Uint),
            SourceScalar::Long(ScalarKind::Uint),
        ],
        SourceScalar::Long(ScalarKind::Uint),
    ),
    (
        [
            SourceScalar::Long(ScalarKind::Sint),
            SourceScalar::Long(ScalarKind::Uint),
        ],
        SourceScalar::Long(ScalarKind::Uint),
    ),
    (
        [
            SourceScalar::Long(ScalarKind::Uint),
            SourceScalar::Long(ScalarKind::Sint),
        ],
        SourceScalar::Long(ScalarKind::Uint),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::I64),
            SourceScalar::Scalar(Scalar::I64),
        ],
        SourceScalar::Scalar(Scalar::I64),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::U64),
            SourceScalar::Scalar(Scalar::U64),
        ],
        SourceScalar::Scalar(Scalar::U64),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::I64),
            SourceScalar::Scalar(Scalar::U64),
        ],
        SourceScalar::Scalar(Scalar::U64),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::U64),
            SourceScalar::Scalar(Scalar::I64),
        ],
        SourceScalar::Scalar(Scalar::U64),
    ),
    (
        [
            SourceScalar::Scalar(Scalar::F32),
            SourceScalar::Scalar(Scalar::F32),
        ],
        SourceScalar::Scalar(Scalar::F32),
    ),
];

const MULTIPLY24_BUILTINS: [(&str, Scalar); 2] =
    [("__mul24", Scalar::I32), ("__umul24", Scalar::U32)];

const MULTIPLY_HIGH_BUILTINS: [(&str, Scalar); 2] =
    [("__mulhi", Scalar::I32), ("__umulhi", Scalar::U32)];

const SAD_BUILTINS: [(&str, Scalar); 2] = [("__sad", Scalar::I32), ("__usad", Scalar::U32)];

const PACKED_UNARY_BUILTINS: [(&str, PackedUnaryBuiltin); 8] = [
    (
        "__vabs2",
        PackedUnaryBuiltin {
            lane_width: 16,
            operation: PackedUnaryOperation::Absolute,
            saturating: false,
        },
    ),
    (
        "__vabs4",
        PackedUnaryBuiltin {
            lane_width: 8,
            operation: PackedUnaryOperation::Absolute,
            saturating: false,
        },
    ),
    (
        "__vabsss2",
        PackedUnaryBuiltin {
            lane_width: 16,
            operation: PackedUnaryOperation::Absolute,
            saturating: true,
        },
    ),
    (
        "__vabsss4",
        PackedUnaryBuiltin {
            lane_width: 8,
            operation: PackedUnaryOperation::Absolute,
            saturating: true,
        },
    ),
    (
        "__vneg2",
        PackedUnaryBuiltin {
            lane_width: 16,
            operation: PackedUnaryOperation::Negate,
            saturating: false,
        },
    ),
    (
        "__vneg4",
        PackedUnaryBuiltin {
            lane_width: 8,
            operation: PackedUnaryOperation::Negate,
            saturating: false,
        },
    ),
    (
        "__vnegss2",
        PackedUnaryBuiltin {
            lane_width: 16,
            operation: PackedUnaryOperation::Negate,
            saturating: true,
        },
    ),
    (
        "__vnegss4",
        PackedUnaryBuiltin {
            lane_width: 8,
            operation: PackedUnaryOperation::Negate,
            saturating: true,
        },
    ),
];

const PACKED_ARITHMETIC_BUILTINS: &[(&str, PackedArithmeticBuiltin)] = &[
    (
        "__vadd2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Wrapping),
        },
    ),
    (
        "__vadd4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Wrapping),
        },
    ),
    (
        "__vsub2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Wrapping),
        },
    ),
    (
        "__vsub4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Wrapping),
        },
    ),
    (
        "__vaddus2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Unsigned),
        },
    ),
    (
        "__vaddus4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Unsigned),
        },
    ),
    (
        "__vsubus2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Unsigned),
        },
    ),
    (
        "__vsubus4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Unsigned),
        },
    ),
    (
        "__vaddss2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Signed),
        },
    ),
    (
        "__vaddss4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Add(PackedArithmeticSaturation::Signed),
        },
    ),
    (
        "__vsubss2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Signed),
        },
    ),
    (
        "__vsubss4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Subtract(PackedArithmeticSaturation::Signed),
        },
    ),
    (
        "__vavgs2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::SignedAwayFromZero),
        },
    ),
    (
        "__vavgs4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::SignedAwayFromZero),
        },
    ),
    (
        "__vavgu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::UnsignedUp),
        },
    ),
    (
        "__vavgu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::UnsignedUp),
        },
    ),
    (
        "__vhaddu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::UnsignedDown),
        },
    ),
    (
        "__vhaddu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Average(PackedAverageMode::UnsignedDown),
        },
    ),
    (
        "__vabsdiffs2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::AbsoluteDifference { signed: true },
        },
    ),
    (
        "__vabsdiffs4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::AbsoluteDifference { signed: true },
        },
    ),
    (
        "__vabsdiffu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::AbsoluteDifference { signed: false },
        },
    ),
    (
        "__vabsdiffu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::AbsoluteDifference { signed: false },
        },
    ),
    (
        "__vmins2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Minimum { signed: true },
        },
    ),
    (
        "__vmins4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Minimum { signed: true },
        },
    ),
    (
        "__vminu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Minimum { signed: false },
        },
    ),
    (
        "__vminu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Minimum { signed: false },
        },
    ),
    (
        "__vmaxs2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Maximum { signed: true },
        },
    ),
    (
        "__vmaxs4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Maximum { signed: true },
        },
    ),
    (
        "__vmaxu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Maximum { signed: false },
        },
    ),
    (
        "__vmaxu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Maximum { signed: false },
        },
    ),
    (
        "__vsads2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::SumAbsoluteDifferences { signed: true },
        },
    ),
    (
        "__vsads4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::SumAbsoluteDifferences { signed: true },
        },
    ),
    (
        "__vsadu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::SumAbsoluteDifferences { signed: false },
        },
    ),
    (
        "__vsadu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::SumAbsoluteDifferences { signed: false },
        },
    ),
    (
        "__vcmpeq2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Equal { mask: true },
        },
    ),
    (
        "__vcmpeq4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Equal { mask: true },
        },
    ),
    (
        "__vcmpne2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::NotEqual { mask: true },
        },
    ),
    (
        "__vcmpne4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::NotEqual { mask: true },
        },
    ),
    (
        "__vseteq2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::Equal { mask: false },
        },
    ),
    (
        "__vseteq4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::Equal { mask: false },
        },
    ),
    (
        "__vsetne2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::NotEqual { mask: false },
        },
    ),
    (
        "__vsetne4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::NotEqual { mask: false },
        },
    ),
    (
        "__vcmplts2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessThan {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmplts4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessThan {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpltu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessThan {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vcmpltu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessThan {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vsetlts2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessThan {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetlts4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessThan {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetltu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessThan {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vsetltu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessThan {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vcmples2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessEqual {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmples4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessEqual {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpleu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessEqual {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vcmpleu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessEqual {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vsetles2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessEqual {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetles4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessEqual {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetleu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::LessEqual {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vsetleu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::LessEqual {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vcmpgts2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpgts4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpgtu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vcmpgtu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vsetgts2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetgts4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetgtu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vsetgtu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterThan {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vcmpges2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpges4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: true,
                mask: true,
            },
        },
    ),
    (
        "__vcmpgeu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vcmpgeu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: false,
                mask: true,
            },
        },
    ),
    (
        "__vsetges2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetges4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: true,
                mask: false,
            },
        },
    ),
    (
        "__vsetgeu2",
        PackedArithmeticBuiltin {
            lane_width: 16,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: false,
                mask: false,
            },
        },
    ),
    (
        "__vsetgeu4",
        PackedArithmeticBuiltin {
            lane_width: 8,
            operation: PackedArithmeticOperation::GreaterEqual {
                signed: false,
                mask: false,
            },
        },
    ),
];

const HALF_ADD_BUILTINS: [(&str, HalfAddBuiltin); 4] = [
    (
        "__hadd",
        HalfAddBuiltin {
            scalar: Scalar::I32,
            rounded: false,
        },
    ),
    (
        "__rhadd",
        HalfAddBuiltin {
            scalar: Scalar::I32,
            rounded: true,
        },
    ),
    (
        "__uhadd",
        HalfAddBuiltin {
            scalar: Scalar::U32,
            rounded: false,
        },
    ),
    (
        "__urhadd",
        HalfAddBuiltin {
            scalar: Scalar::U32,
            rounded: true,
        },
    ),
];

const BITCAST_BUILTINS: [(&str, Scalar, Scalar); 4] = [
    ("__float_as_int", Scalar::F32, Scalar::I32),
    ("__float_as_uint", Scalar::F32, Scalar::U32),
    ("__int_as_float", Scalar::I32, Scalar::F32),
    ("__uint_as_float", Scalar::U32, Scalar::F32),
];

const FLOAT_MATH_BUILTINS: [(&str, FloatMathFunction); 5] = [
    ("floorf", FloatMathFunction::Floor),
    ("ceilf", FloatMathFunction::Ceil),
    ("fabsf", FloatMathFunction::AbsoluteValue),
    ("fabs", FloatMathFunction::AbsoluteValue),
    ("roundf", FloatMathFunction::Round),
];

const FLOAT_CLASSIFICATION_BUILTINS: &[(&str, FloatClassification)] = &[
    ("isfinite", FloatClassification::Finite),
    ("isinf", FloatClassification::Infinite),
    ("isnan", FloatClassification::NaN),
    ("signbit", FloatClassification::SignBit),
];

const UNARY_BUILTINS: [(&str, MathFunction, Scalar, Scalar); 12] = [
    (
        "__clz",
        MathFunction::CountLeadingZeros,
        Scalar::I32,
        Scalar::I32,
    ),
    (
        "__clzll",
        MathFunction::CountLeadingZeros,
        Scalar::I64,
        Scalar::I32,
    ),
    (
        "__ffs",
        MathFunction::FirstTrailingBit,
        Scalar::I32,
        Scalar::I32,
    ),
    (
        "__ffsll",
        MathFunction::FirstTrailingBit,
        Scalar::I64,
        Scalar::I32,
    ),
    (
        "__popc",
        MathFunction::CountOneBits,
        Scalar::U32,
        Scalar::I32,
    ),
    (
        "__brev",
        MathFunction::ReverseBits,
        Scalar::U32,
        Scalar::U32,
    ),
    (
        "__brevll",
        MathFunction::ReverseBits,
        Scalar::U64,
        Scalar::U64,
    ),
    (
        "__popcll",
        MathFunction::CountOneBits,
        Scalar::U64,
        Scalar::I32,
    ),
    ("sinf", MathFunction::Sin, Scalar::F32, Scalar::F32),
    ("cosf", MathFunction::Cos, Scalar::F32, Scalar::F32),
    (
        "rsqrtf",
        MathFunction::InverseSqrt,
        Scalar::F32,
        Scalar::F32,
    ),
    (
        "__saturatef",
        MathFunction::Saturate,
        Scalar::F32,
        Scalar::F32,
    ),
];

const SQRT_BUILTINS: [&str; 3] = ["sqrtf", "sqrt", "__fsqrt_rn"];
const FMA_BUILTINS: [&str; 2] = ["__fmaf_rn", "fmaf"];
const INTEGRAL_DOUBLE_BUILTINS: [&str; 2] = ["fabs", "sqrt"];

#[derive(Clone, Copy, PartialEq)]
pub(super) struct MathBuiltin {
    function: MathFunction,
    parameters: [SourceScalar; 2],
    result: SourceScalar,
}

fn math_builtins(name: &str) -> impl Iterator<Item = MathBuiltin> + Clone {
    let function = MATH_BUILTINS
        .into_iter()
        .find_map(|(candidate, function)| (candidate == name).then_some(function));
    let signatures = if matches!(name, "fminf" | "fmaxf") {
        &MATH_SIGNATURES[12..]
    } else {
        &MATH_SIGNATURES[..]
    };
    signatures
        .iter()
        .copied()
        .filter_map(move |(parameters, result)| {
            function.map(|function| MathBuiltin {
                function,
                parameters,
                result,
            })
        })
}

fn vector_constructor(name: &str) -> Option<(u8, Scalar)> {
    VECTOR_TYPES
        .into_iter()
        .find_map(|(_, constructor, component_count, scalar)| {
            (name == constructor).then_some((component_count, scalar))
        })
}

const FUNNEL_SHIFT_BUILTINS: [(&str, FunnelShiftBuiltin); 4] = [
    (
        "__funnelshift_l",
        FunnelShiftBuiltin {
            direction: FunnelShiftDirection::Left,
            clamped: false,
        },
    ),
    (
        "__funnelshift_r",
        FunnelShiftBuiltin {
            direction: FunnelShiftDirection::Right,
            clamped: false,
        },
    ),
    (
        "__funnelshift_lc",
        FunnelShiftBuiltin {
            direction: FunnelShiftDirection::Left,
            clamped: true,
        },
    ),
    (
        "__funnelshift_rc",
        FunnelShiftBuiltin {
            direction: FunnelShiftDirection::Right,
            clamped: true,
        },
    ),
];

pub(super) fn builtin_declarations<'a>() -> FastHashMap<&'a str, GlobalDeclaration> {
    let mut declarations = MATH_BUILTINS
        .into_iter()
        .map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        })
        .chain(MULTIPLY24_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(MULTIPLY_HIGH_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(HALF_ADD_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(SAD_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(FUNNEL_SHIFT_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(BITCAST_BUILTINS.into_iter().map(|(name, _, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(UNARY_BUILTINS.into_iter().map(|(name, _, _, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(FLOAT_MATH_BUILTINS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(SQRT_BUILTINS.into_iter().map(|name| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(core::iter::once((
            "fmodf",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(core::iter::once((
            "__byte_perm",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(core::iter::once((
            "__nv_bswap32",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(core::iter::once((
            "__fns",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(core::iter::once((
            "__dp4a",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(["__dp2a_lo", "__dp2a_hi"].into_iter().map(|name| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(INTEGER_ATOMICS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(core::iter::once((
            "atomicCAS",
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )))
        .chain(WRAPPING_ATOMICS.into_iter().map(|(name, _)| {
            (
                name,
                GlobalDeclaration::Functions(FunctionOverloads::default()),
            )
        }))
        .chain(core::iter::once((
            "cooperative_groups",
            GlobalDeclaration::Namespace(Namespace::CooperativeGroups),
        )))
        .chain(core::iter::once((
            "std",
            GlobalDeclaration::Namespace(Namespace::Standard),
        )))
        .chain(core::iter::once((
            "dim3",
            GlobalDeclaration::Type(QualifiedType {
                ty: TypeSpecifier::Dim3,
                qualifiers: Qualifiers::NONE,
            }),
        )))
        .chain(core::iter::once((
            "size_t",
            GlobalDeclaration::Type(QualifiedType {
                ty: TypeSpecifier::Long {
                    kind: ScalarKind::Uint,
                },
                qualifiers: Qualifiers::NONE,
            }),
        )))
        .collect::<FastHashMap<_, _>>();
    declarations.extend(VECTOR_TYPES.into_iter().flat_map(
        |(name, constructor, component_count, scalar)| {
            [
                (
                    name,
                    GlobalDeclaration::Type(QualifiedType {
                        ty: TypeSpecifier::Vector {
                            component_count,
                            scalar,
                        },
                        qualifiers: Qualifiers::NONE,
                    }),
                ),
                (
                    constructor,
                    GlobalDeclaration::Functions(FunctionOverloads::default()),
                ),
            ]
        },
    ));
    declarations.extend(PACKED_ARITHMETIC_BUILTINS.iter().map(|&(name, _)| {
        (
            name,
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )
    }));
    declarations.extend(PACKED_UNARY_BUILTINS.iter().map(|&(name, _)| {
        (
            name,
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )
    }));
    declarations.extend(FLOAT_CLASSIFICATION_BUILTINS.iter().map(|&(name, _)| {
        (
            name,
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )
    }));
    declarations.insert(
        "copysignf",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fadd_rz",
        GlobalDeclaration::Functions(Default::default()),
    );
    declarations.insert(
        "__fadd_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fsub_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fsub_rz",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fmul_rz",
        GlobalDeclaration::Functions(Default::default()),
    );
    declarations.insert(
        "__fmul_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fsqrt_rz",
        GlobalDeclaration::Functions(Default::default()),
    );
    declarations.insert(
        "__fdiv_rz",
        GlobalDeclaration::Functions(Default::default()),
    );
    declarations.insert(
        "__fdiv_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__frcp_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__frcp_rz",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations.insert(
        "__fmaf_rz",
        GlobalDeclaration::Functions(Default::default()),
    );
    declarations.extend(FMA_BUILTINS.into_iter().map(|name| {
        (
            name,
            GlobalDeclaration::Functions(FunctionOverloads::default()),
        )
    }));
    declarations.insert(
        "__frsqrt_rn",
        GlobalDeclaration::Functions(FunctionOverloads::default()),
    );
    declarations
}

#[derive(Clone, Copy, Eq, PartialEq)]
pub(super) enum ReturnType {
    Void,
    Value(TypeSpecifier),
}

#[derive(Clone)]
pub(super) struct FunctionHeader<'a> {
    pub(super) kind: FunctionKind,
    pub(super) result: ReturnType,
    pub(super) result_span: Span,
    pub(super) result_qualifiers: Qualifiers,
    pub(super) name: &'a str,
    pub(super) name_span: Span,
    pub(super) has_host: bool,
    pub(super) is_static: bool,
    pub(super) inlining: Option<Inlining>,
    pub(super) operator: Option<operators::Operator>,
    pub(super) launch_bounds: Option<LaunchBounds>,
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum FunctionCandidate {
    Defined(Handle<Function>),
    Current,
    Builtin(MathBuiltin),
    Multiply24(Scalar),
    MultiplyHigh(Scalar),
    HalfAdd(HalfAddBuiltin),
    PackedArithmetic(PackedArithmeticBuiltin),
    Sad(Scalar),
    BytePerm,
    ByteSwap32,
    PackedUnary(PackedUnaryBuiltin),
    Fns,
    Dot4(Scalar),
    Dot2 {
        high: bool,
        scalar: Scalar,
    },
    FunnelShift(FunnelShiftBuiltin),
    Atomic {
        function: crate::AtomicFunction,
        scalar: Scalar,
    },
    AtomicCompareExchange(Scalar),
    WrappingAtomic(WrappingAtomicFunction),
    Bitcast {
        source: Scalar,
        result: Scalar,
    },
    Unary {
        function: MathFunction,
        source: Scalar,
        result: Scalar,
    },
    FloatMath(FloatMathFunction),
    FloatClassification(FloatClassification),
    IntegralDouble {
        source: Scalar,
    },
    Sqrt,
    SqrtRoundZero,
    Fmodf,
    CopySign,
    AddRoundNearest,
    AddRoundZero,
    SubtractRoundNearest,
    SubtractRoundZero,
    MultiplyRoundNearest,
    MultiplyRoundZero,
    FusedMultiplyAddRoundNearest,
    FusedMultiplyAddRoundZero,
    DivideRoundNearest,
    DivideRoundZero,
    ReciprocalRoundNearest,
    ReciprocalRoundZero,
    ReciprocalSqrtRoundNearest,
    Constructor {
        component_count: u8,
        scalar: Scalar,
    },
}

pub(super) enum OverloadResolution<C = FunctionCandidate> {
    Selected(C),
    NoViable,
    Ambiguous,
}

#[derive(Clone, Copy)]
pub(super) struct ArgumentConversion {
    pub(super) rank: u8,
    pub(super) mode: ParameterMode,
}

pub(super) fn better_conversion_sequences(
    conversions: impl Iterator<Item = Option<(ArgumentConversion, ArgumentConversion)>>,
) -> bool {
    let mut has_better_conversion = false;
    for conversion in conversions {
        let Some((left, right)) = conversion else {
            return false;
        };
        if left.rank > right.rank {
            return false;
        }
        has_better_conversion |= left.rank < right.rank;
        if left.rank == right.rank {
            if let (
                ParameterMode::Reference { qualifiers: left },
                ParameterMode::Reference { qualifiers: right },
            ) = (left.mode, right.mode)
            {
                if left != right && left.contains(right) {
                    return false;
                }
                has_better_conversion |= left != right && right.contains(left);
            }
        }
    }
    has_better_conversion
}

pub(super) fn select_ranked_candidate<C: Copy + PartialEq>(
    candidates: impl Iterator<Item = C> + Clone,
    mut better: impl FnMut(C, C) -> bool,
) -> OverloadResolution<C> {
    let mut remaining = candidates.clone();
    let Some(mut best) = remaining.next() else {
        return OverloadResolution::NoViable;
    };
    for candidate in remaining {
        if better(candidate, best) {
            best = candidate;
        }
    }
    if candidates
        .clone()
        .any(|candidate| candidate != best && !better(best, candidate))
    {
        OverloadResolution::Ambiguous
    } else {
        OverloadResolution::Selected(best)
    }
}

impl<'a> Parser<'a> {
    fn scalar_conversion_rank(source: SourceScalar, target: SourceScalar) -> u8 {
        if source == target {
            0
        } else if matches!(source.scalar(), Scalar::BOOL | Scalar::I16 | Scalar::U16)
            && target == SourceScalar::Scalar(Scalar::I32)
        {
            1
        } else {
            2
        }
    }

    fn conversion_rank(
        &self,
        source: &TypeResolution,
        target: &TypeResolution,
        user_conversion: bool,
    ) -> Option<u8> {
        if self.source_types_equal(source, target) {
            return Some(0);
        }
        match (self.source_scalar(source), self.source_scalar(target)) {
            (Some(source), Some(target)) => Some(Self::scalar_conversion_rank(source, target)),
            _ => user_conversion.then_some(3),
        }
    }

    pub(super) fn parameters(&mut self) -> Result<(), ParseError> {
        self.lexer.expect_span(Token::Paren('('))?;
        if !self.lexer.next_if(Token::Paren(')'))? {
            if self.take_ident("void")? {
                self.lexer.expect_span(Token::Paren(')'))?;
            } else {
                let mut parameter_index = 0u32;
                loop {
                    self.parameter(parameter_index)?;
                    self.parameter_default()?;
                    if self.lexer.next_if(Token::Paren(')'))? {
                        break;
                    }
                    let separator_span = self.lexer.expect_span(Token::Separator(','))?;
                    parameter_index = parameter_index.checked_add(1).ok_or_else(|| ParseError {
                        message: String::from("too many CUDA function parameters"),
                        span: separator_span,
                    })?;
                }
            }
        }
        self.function.replay_default_header = None;
        Ok(())
    }

    fn check_function_name(
        &self,
        name: &str,
        span: Span,
        kind: FunctionKind,
    ) -> Result<(), ParseError> {
        self.check_name(name, span)?;
        self.check_dynamic_shared_linkage(name, span)?;
        let compatible = match self.global_declarations.get(name) {
            None => true,
            Some(&GlobalDeclaration::Functions(_)) => {
                kind == FunctionKind::Device && !self.has_kernel_template(name)
            }
            Some(_) => false,
        };
        if !compatible {
            return Err(ParseError {
                message: format!("incompatible function declaration `{name}`"),
                span,
            });
        }
        Ok(())
    }

    pub(super) fn function_header(
        &mut self,
        extern_c: bool,
    ) -> Result<FunctionHeader<'a>, ParseError> {
        let mut kind = None;
        let mut host_span = None;
        let mut result = None;
        let mut result_span = None;
        let mut inlining = None;
        let mut seen_static = false;
        let mut cuda_inline_span = None;
        let mut explicit_const = false;
        let mut explicit_volatile = false;
        let mut volatile_result = false;
        let mut const_result = false;
        let mut integers = IntegerSpecifiers::default();
        let mut launch_bounds = None;
        loop {
            let token = self.lexer.peek()?;
            if result.is_none() {
                if token.0 == Token::Word("decltype") {
                    self.lexer.next()?;
                    let (ty, end) = self.decltype_operand_type()?;
                    volatile_result = ty.qualifiers.is_volatile;
                    const_result = ty.qualifiers.is_const;
                    result = Some(ReturnType::Value(ty.ty));
                    result_span.get_or_insert(token.1.until(&end));
                    continue;
                }
                if let Some(name) = self.qualified_item()? {
                    let cooperative_groups::QualifiedItem::Type(ty) = name.item else {
                        return self.fail("expected a supported function return type");
                    };
                    volatile_result = ty.qualifiers.is_volatile;
                    const_result = ty.qualifiers.is_const;
                    result = Some(ReturnType::Value(ty.ty));
                    result_span.get_or_insert(name.span);
                    continue;
                }
            }
            match token.0 {
                Token::Word("__launch_bounds__") => {
                    let bounds = self.launch_bounds()?;
                    launch_bounds.get_or_insert(bounds);
                    continue;
                }
                Token::Word("inline") => {
                    if inlining == Some(Inlining::Inline) {
                        return self.fail("duplicate inline specifier");
                    }
                    if cuda_inline_span.is_some() {
                        return self.fail("incompatible inlining specifiers");
                    }
                    inlining = Some(Inlining::Inline);
                }
                Token::Word("static") => {
                    if extern_c {
                        return self.fail("static conflicts with an extern C declaration");
                    }
                    if seen_static {
                        return self.fail("duplicate static specifier");
                    }
                    seen_static = true;
                }
                Token::Word("__forceinline__" | "__noinline__") => {
                    if inlining.is_some() {
                        return self.fail("duplicate or incompatible inlining specifiers");
                    }
                    cuda_inline_span = Some(token.1);
                    inlining = Some(if token.0 == Token::Word("__forceinline__") {
                        Inlining::ForceInline
                    } else {
                        Inlining::NoInline
                    });
                }
                Token::Word("__host__") => {
                    if host_span.is_some() || kind == Some(FunctionKind::Kernel) {
                        return self
                            .fail("duplicate or incompatible CUDA execution space specifier");
                    }
                    host_span = Some(token.1);
                }
                Token::Word("__device__" | "__global__") => {
                    if kind.is_some()
                        || (host_span.is_some() && token.0 == Token::Word("__global__"))
                    {
                        return self
                            .fail("duplicate or incompatible CUDA execution space specifier");
                    }
                    kind = Some(if token.0 == Token::Word("__device__") {
                        FunctionKind::Device
                    } else {
                        FunctionKind::Kernel
                    });
                }
                Token::Word("const") => {
                    if explicit_const {
                        return self.fail("duplicate const qualifier");
                    }
                    explicit_const = true;
                    result_span.get_or_insert(token.1);
                }
                Token::Word("volatile") => {
                    if explicit_volatile {
                        return self.fail("duplicate volatile qualifier");
                    }
                    explicit_volatile = true;
                    result_span.get_or_insert(token.1);
                }
                Token::Word(specifier @ ("int" | "short" | "long" | "signed" | "unsigned")) => {
                    if result.is_some() && integers.is_empty() {
                        return self.fail("incompatible or repeated return type specifier");
                    }
                    let Some(scalar) = integers.consume(specifier) else {
                        return self.fail("incompatible or repeated return type specifier");
                    };
                    result = Some(ReturnType::Value(TypeSpecifier::from_scalar(scalar)));
                    result_span.get_or_insert(token.1);
                }
                Token::Word("void" | "float" | "bool") => {
                    if result.is_some() {
                        return self.fail("incompatible or repeated return type specifier");
                    }
                    result = Some(match token.0 {
                        Token::Word("void") => ReturnType::Void,
                        Token::Word("float") => {
                            ReturnType::Value(TypeSpecifier::Scalar(Scalar::F32))
                        }
                        _ => ReturnType::Value(TypeSpecifier::Scalar(Scalar::BOOL)),
                    });
                    result_span.get_or_insert(token.1);
                }
                Token::Word(name) if result.is_none() => {
                    let Some(ty) = self.type_name(name) else {
                        break;
                    };
                    volatile_result = ty.qualifiers.is_volatile;
                    const_result = ty.qualifiers.is_const;
                    result = Some(ReturnType::Value(ty.ty));
                    result_span.get_or_insert(token.1);
                }
                _ => break,
            }
            self.lexer.next()?;
        }
        if let (Some(span), None) = (host_span, kind) {
            return Err(ParseError {
                message: String::from("host-only functions are unsupported"),
                span,
            });
        }
        let Some(result) = result else {
            return self.fail("expected a supported function return type");
        };
        if matches!(result, ReturnType::Value(TypeSpecifier::Array(_))) {
            return self.fail("array return types are unsupported");
        }
        if (explicit_volatile || volatile_result)
            && !matches!(
                result,
                ReturnType::Void
                    | ReturnType::Value(
                        TypeSpecifier::Scalar(_)
                            | TypeSpecifier::Long { .. }
                            | TypeSpecifier::TemplateParameter(_)
                            | TypeSpecifier::NullPointer
                    )
            )
        {
            return self.fail("volatile class return types are unsupported");
        }
        if matches!(result, ReturnType::Value(TypeSpecifier::ThreadBlock)) {
            return self.fail("thread_block return types are unsupported");
        }
        if matches!(result, ReturnType::Value(TypeSpecifier::Pointer { .. })) {
            return self.fail("pointer return types are unsupported");
        }
        let Some(kind) = kind else {
            return self.fail("expected a CUDA execution space specifier");
        };
        if let (FunctionKind::Kernel, Some(span)) = (kind, cuda_inline_span) {
            return Err(ParseError {
                message: String::from("CUDA inlining specifiers are unsupported for kernels"),
                span,
            });
        }
        let token = self.lexer.peek()?;
        let (name, name_span, operator) = if self.take_ident("operator")? {
            let (operator, span) = self.operator_name(token.1)?;
            (operator.name(), span, Some(operator))
        } else {
            let (name, span) = self.identifier()?;
            (name, span, None)
        };
        if operator.is_some() && kind != FunctionKind::Device {
            return Err(ParseError {
                message: String::from("operator functions must be device helpers"),
                span: name_span,
            });
        }
        Ok(FunctionHeader {
            kind,
            result,
            result_span: result_span.unwrap(),
            result_qualifiers: Qualifiers {
                is_const: explicit_const || const_result,
                is_volatile: explicit_volatile || volatile_result,
            },
            name,
            name_span,
            has_host: host_span.is_some(),
            is_static: seen_static,
            inlining,
            operator,
            launch_bounds,
        })
    }

    pub(super) fn function_definition(&mut self) -> Result<FunctionKind, ParseError> {
        let extern_c = self.take_ident("extern")?;
        if extern_c {
            if self.lexer.peek()?.0 != Token::String("C") {
                return self.fail("expected `\"C\"` after `extern`");
            }
            self.lexer.next()?;
        }
        let header = self.function_header(extern_c)?;
        self.check_function_name(header.name, header.name_span, header.kind)?;
        self.function = FunctionContext::new(header.kind);
        match header.kind {
            FunctionKind::Device => {
                if extern_c {
                    return Err(ParseError {
                        message: String::from("extern C device helpers are unsupported"),
                        span: header.name_span,
                    });
                }
                self.device_function(header)?;
                Ok(FunctionKind::Device)
            }
            FunctionKind::Kernel => {
                self.kernel(header)?;
                Ok(FunctionKind::Kernel)
            }
        }
    }

    pub(super) fn kernel(&mut self, header: FunctionHeader<'a>) -> Result<(), ParseError> {
        if !self.kernels.is_empty() {
            self.activate_parameter_expansion(header.name_span)?;
        }
        let bounds = self.kernel_body(&header)?;
        self.check_launch_bounds(bounds)?;
        let function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Kernel),
        );
        self.parameter_expansion_budget
            .charge_slice::<Kernel<'_>>(1, header.name_span)?;
        self.parameter_expansion_budget
            .charge_slice::<EntryPoint>(1, header.name_span)?;
        self.parameter_expansion_budget
            .charge_bytes(header.name.len(), header.name_span)?;
        self.parameter_expansion_budget
            .charge_work(1, header.name_span)?;
        self.module.entry_points.push(EntryPoint {
            name: String::from(header.name),
            stage: ShaderStage::Compute,
            early_depth_test: None,
            workgroup_size: self.workgroup_size,
            workgroup_size_overrides: None,
            function: Function::default(),
            mesh_info: None,
            task_payload: None,
            incoming_ray_payload: None,
        });
        self.kernels.push(Kernel {
            context: Some(function),
            parameter_state: None,
            calls: Vec::new(),
        });
        self.global_declarations
            .insert(header.name, GlobalDeclaration::Kernel);
        Ok(())
    }

    pub(super) fn kernel_body(
        &mut self,
        header: &FunctionHeader<'a>,
    ) -> Result<Option<LaunchBounds>, ParseError> {
        if !matches!(header.result, ReturnType::Void) {
            return Err(ParseError {
                message: String::from("CUDA kernels must return void"),
                span: header.result_span,
            });
        }
        let mut bounds = header.launch_bounds;
        self.parameters_with_launch_bounds(&mut bounds)?;
        self.reject_noexcept("kernels")?;
        self.lexer.expect_span(Token::Paren('{'))?;
        self.initialize_helper_builtins()?;
        self.block_contents()?;
        self.flush_emitter();
        Ok(bounds)
    }

    pub(super) fn initialize_function_header(
        &mut self,
        header: &FunctionHeader<'a>,
    ) -> Result<(), ParseError> {
        self.function.ir.name = Some(String::from(header.name));
        self.function.source_result = header.result;
        if let ReturnType::Value(ty) = header.result {
            if ty != TypeSpecifier::NullPointer {
                let ty = self.lower_type(ty, header.result_span)?;
                self.function.ir.result = Some(crate::FunctionResult {
                    ty: self.type_handle(&ty, header.result_span),
                    binding: None,
                });
            }
        }
        Ok(())
    }

    pub(super) fn reject_noexcept(&mut self, context: &str) -> Result<(), ParseError> {
        if self.lexer.peek()?.0 == Token::Word("noexcept") {
            return self.fail(&format!(
                "noexcept specifications on {context} are unsupported"
            ));
        }
        Ok(())
    }

    pub(super) fn trailing_noexcept(&mut self) -> Result<Option<bool>, ParseError> {
        let span = self.lexer.peek()?.1;
        if !self.take_ident("noexcept")? {
            return Ok(None);
        }
        self.activate_parameter_expansion(span)?;
        self.prepare_parameter_bindings(span)?;
        let value = if self.lexer.next_if(Token::Paren('('))? {
            let previous =
                core::mem::replace(&mut self.function.parsing_exception_specification, true);
            let parsed = self.capture_block(|parser| {
                let expression = parser.conditional_expression()?;
                let value = parser.rvalue(expression)?;
                let literal = Self::required_constant(&value)?;
                let result = match literal {
                    Literal::Bool(value) => Some(value),
                    Literal::I16(value) if value == 0 || value == 1 => Some(value != 0),
                    Literal::U16(value) if value <= 1 => Some(value != 0),
                    Literal::I32(value) if value == 0 || value == 1 => Some(value != 0),
                    Literal::U32(value) if value <= 1 => Some(value != 0),
                    Literal::I64(value) if value == 0 || value == 1 => Some(value != 0),
                    Literal::U64(value) if value <= 1 => Some(value != 0),
                    _ => None,
                };
                result.ok_or_else(|| ParseError {
                    message: String::from(
                        "noexcept requires a non-narrowing integral constant expression of bool",
                    ),
                    span: value.span,
                })
            });
            self.function.parsing_exception_specification = previous;
            let (value, _) = parsed?;
            self.lexer.expect_span(Token::Paren(')'))?;
            value
        } else {
            true
        };
        if self.lexer.peek()?.0 == Token::Word("noexcept") {
            return self.fail("duplicate noexcept specification");
        }
        Ok(Some(value))
    }

    pub(super) fn device_function(&mut self, header: FunctionHeader<'a>) -> Result<(), ParseError> {
        self.device_function_with_target(header, None)
    }

    pub(super) fn device_function_with_target(
        &mut self,
        mut header: FunctionHeader<'a>,
        target: Option<Handle<Function>>,
    ) -> Result<(), ParseError> {
        self.initialize_function_header(&header)?;
        if let Some(target) = target {
            self.parameter_expansion_budget.charge_bytes(
                self.module.functions[target]
                    .name
                    .as_ref()
                    .map_or(0, String::len),
                header.name_span,
            )?;
            self.function.ir.name = self.module.functions[target].name.clone();
        }
        self.parameters_with_launch_bounds(&mut header.launch_bounds)?;
        let exception_specification = self.trailing_noexcept()?;
        let is_noexcept = exception_specification.unwrap_or(false);
        if let Some(target) = target {
            if self.function_declarations[&target].parameters != self.function.parameters {
                return self.fail("incompatible instantiated function parameter types");
            }
        }
        if header.operator.is_some() && !self.function.defaults.is_empty() {
            return self.fail("operator default arguments are unsupported");
        }
        if let Some(operator) = header.operator {
            self.check_operator_parameters(operator, header.name_span)?;
        }
        let is_prototype = self.lexer.peek()?.0 == Token::Separator(';');
        if !is_prototype {
            if let Some(span) = self.function.volatile_parameter_object {
                return Err(ParseError {
                    message: String::from("volatile parameter objects are unsupported"),
                    span,
                });
            }
        }
        let intrinsic = self.function_candidates(header.name).find(|&candidate| {
            target.is_none()
                && matches!(
                    candidate,
                    FunctionCandidate::Builtin(_)
                        | FunctionCandidate::Multiply24(_)
                        | FunctionCandidate::MultiplyHigh(_)
                        | FunctionCandidate::HalfAdd(_)
                        | FunctionCandidate::PackedArithmetic(_)
                        | FunctionCandidate::Sad(_)
                        | FunctionCandidate::BytePerm
                        | FunctionCandidate::ByteSwap32
                        | FunctionCandidate::PackedUnary(_)
                        | FunctionCandidate::Fns
                        | FunctionCandidate::Dot4(_)
                        | FunctionCandidate::Dot2 { .. }
                        | FunctionCandidate::FunnelShift(_)
                        | FunctionCandidate::Atomic { .. }
                        | FunctionCandidate::AtomicCompareExchange(_)
                        | FunctionCandidate::WrappingAtomic(_)
                        | FunctionCandidate::Bitcast { .. }
                        | FunctionCandidate::Unary { .. }
                        | FunctionCandidate::FloatMath(_)
                        | FunctionCandidate::FloatClassification(_)
                        | FunctionCandidate::SqrtRoundZero
                        | FunctionCandidate::Sqrt
                        | FunctionCandidate::Fmodf
                        | FunctionCandidate::CopySign
                        | FunctionCandidate::AddRoundZero
                        | FunctionCandidate::AddRoundNearest
                        | FunctionCandidate::SubtractRoundNearest
                        | FunctionCandidate::SubtractRoundZero
                        | FunctionCandidate::FusedMultiplyAddRoundZero
                        | FunctionCandidate::FusedMultiplyAddRoundNearest
                        | FunctionCandidate::MultiplyRoundZero
                        | FunctionCandidate::MultiplyRoundNearest
                        | FunctionCandidate::DivideRoundZero
                        | FunctionCandidate::DivideRoundNearest
                        | FunctionCandidate::ReciprocalRoundNearest
                        | FunctionCandidate::ReciprocalRoundZero
                        | FunctionCandidate::ReciprocalSqrtRoundNearest
                        | FunctionCandidate::Constructor { .. }
                )
                && self.function.parameters.len() == self.candidate_arity(candidate)
                && (0..self.candidate_arity(candidate)).all(|index| {
                    self.function.parameters[index].mode() == self.candidate_mode(candidate, index)
                        && self
                            .candidate_type(FunctionCandidate::Current, index)
                            .is_some_and(|source| {
                                if let FunctionCandidate::Builtin(builtin) = candidate {
                                    self.source_scalar(&source) == Some(builtin.parameters[index])
                                } else {
                                    self.candidate_type(candidate, index).is_some_and(|target| {
                                        self.source_types_equal(&source, &target)
                                    })
                                }
                            })
                })
        });
        if intrinsic.is_some() && exception_specification.is_some() {
            return self.fail("noexcept specifications on intrinsics are unsupported");
        }
        if intrinsic.is_some() && !self.function.defaults.is_empty() {
            return self.fail("intrinsic default arguments are unsupported");
        }
        if let Some(candidate) = intrinsic {
            if !is_prototype {
                return Err(ParseError {
                    message: format!("duplicate builtin definition `{}`", header.name),
                    span: header.name_span,
                });
            }
            let result = self.candidate_result(candidate, header.result_span)?;
            if self.function.ir.result.as_ref().map(|result| result.ty) != result
                || header.result_qualifiers != Qualifiers::NONE
            {
                return Err(ParseError {
                    message: format!("incompatible builtin result type `{}`", header.name),
                    span: header.name_span,
                });
            }
            let parameters: Vec<_> = self
                .function
                .ir
                .arguments
                .iter()
                .map(|argument| argument.ty)
                .collect();
            if let Some(previous) = self
                .intrinsic_declarations
                .iter_mut()
                .find(|previous| previous.name == header.name && previous.parameters == parameters)
            {
                function_declarations::check_redeclaration(
                    previous.has_host,
                    previous.is_static,
                    previous.inlining,
                    header.has_host,
                    header.is_static,
                    header.inlining,
                    header.name_span,
                )?;
                previous.inlining = previous.inlining.or(header.inlining);
            } else {
                self.intrinsic_declarations.push(IntrinsicDeclaration {
                    name: header.name,
                    parameters,
                    has_host: header.has_host,
                    is_static: header.is_static,
                    inlining: header.inlining,
                });
            }
            self.lexer.expect_span(Token::Separator(';'))?;
            self.function = FunctionContext::new(FunctionKind::Kernel);
            return Ok(());
        }
        let previous = target.or_else(|| match self.global_declarations.get(header.name) {
            Some(&GlobalDeclaration::Functions(ref functions)) => {
                functions.functions.iter().copied().find(|&function| {
                    self.function_declarations[&function].parameters == self.function.parameters
                })
            }
            _ => None,
        });
        self.merge_parameter_defaults(previous, header.name_span)?;
        if let Some(previous) = previous {
            let declaration = self.function_declarations.get_mut(&previous).unwrap();
            function_declarations::check_redeclaration(
                declaration.has_host,
                declaration.is_static,
                declaration.inlining,
                header.has_host,
                header.is_static,
                header.inlining,
                header.name_span,
            )?;
            if declaration.is_noexcept != is_noexcept {
                return Err(ParseError {
                    message: String::from(
                        "incompatible noexcept specification in helper redeclaration",
                    ),
                    span: header.name_span,
                });
            }
            if !is_prototype && declaration.is_defined {
                return Err(ParseError {
                    message: format!("duplicate device helper definition `{}`", header.name),
                    span: header.name_span,
                });
            }
            if declaration.source_result != header.result
                || declaration.result_qualifiers != header.result_qualifiers
                || self.module.functions[previous]
                    .result
                    .as_ref()
                    .map(|result| result.ty)
                    != self.function.ir.result.as_ref().map(|result| result.ty)
            {
                return Err(ParseError {
                    message: format!("incompatible device helper result type `{}`", header.name),
                    span: header.name_span,
                });
            }
            declaration.inlining = declaration.inlining.or(header.inlining);
        }
        if is_prototype {
            if previous.is_none() {
                let function = Function {
                    name: self.function.ir.name.clone(),
                    arguments: self.function.ir.arguments.clone(),
                    result: self.function.ir.result.clone(),
                    ..Function::default()
                };
                let handle = self.module.functions.append(function, header.name_span);
                self.register_function(header.name, handle);
                self.function_declarations.insert(
                    handle,
                    FunctionDeclaration {
                        parameters: core::mem::take(&mut self.function.parameters),
                        defaults: core::mem::take(&mut self.function.defaults),
                        is_noexcept,
                        source_result: header.result,
                        result_qualifiers: header.result_qualifiers,
                        has_host: header.has_host,
                        is_static: header.is_static,
                        inlining: header.inlining,
                        is_defined: false,
                        calls: Vec::new(),
                    },
                );
            }
            if let Some(previous) = previous {
                self.function_declarations
                    .get_mut(&previous)
                    .unwrap()
                    .defaults = core::mem::take(&mut self.function.defaults);
            }
            self.lexer.expect_span(Token::Separator(';'))?;
            self.function = FunctionContext::new(FunctionKind::Kernel);
            return Ok(());
        }
        self.function.current_declaration = previous;
        self.lexer.expect_span(Token::Paren('{'))?;
        let terminated = self.block_contents()?;
        if self.function.source_result != ReturnType::Void && !terminated {
            return Err(ParseError {
                message: String::from("device helper must return a value on every supported path"),
                span: header.name_span,
            });
        }
        self.flush_emitter();
        if self.function.ir.result.is_none() {
            crate::proc::ensure_block_returns(&mut self.function.ir.body);
        }
        let parameter_state = if self.parameter_state_needed() {
            self.prepare_parameter_bindings(header.name_span)?;
            self.parameter_expansion_budget.charge_slice::<u32>(
                self.function.expression_graph_depths.len(),
                header.name_span,
            )?;
            self.parameter_expansion_budget
                .charge_map_entry::<Handle<Function>, FunctionParameterState>(
                    1,
                    header.name_span,
                )?;
            Some(self.function.take_parameter_state())
        } else {
            None
        };
        let function = core::mem::replace(
            &mut self.function,
            FunctionContext::new(FunctionKind::Kernel),
        );
        if let Some(previous) = previous {
            self.module.functions[previous] = function.ir;
            let declaration = self.function_declarations.get_mut(&previous).unwrap();
            declaration.parameters = function.parameters;
            declaration.defaults = function.defaults;
            declaration.is_defined = true;
            declaration.calls = function.calls;
            if let Some(state) = parameter_state {
                self.parameter_states.insert(previous, state);
            }
        } else {
            let handle = self.module.functions.append(function.ir, header.name_span);
            self.register_function(header.name, handle);
            self.function_declarations.insert(
                handle,
                FunctionDeclaration {
                    parameters: function.parameters,
                    defaults: function.defaults,
                    is_noexcept,
                    source_result: header.result,
                    result_qualifiers: header.result_qualifiers,
                    has_host: header.has_host,
                    is_static: header.is_static,
                    inlining: header.inlining,
                    is_defined: true,
                    calls: function.calls,
                },
            );
            if let Some(state) = parameter_state {
                self.parameter_states.insert(handle, state);
            }
        }
        Ok(())
    }

    fn register_function(&mut self, name: &'a str, handle: Handle<Function>) {
        match *self
            .global_declarations
            .entry(name)
            .or_insert_with(|| GlobalDeclaration::Functions(FunctionOverloads::default()))
        {
            GlobalDeclaration::Functions(ref mut functions) => functions.functions.push(handle),
            _ => unreachable!(),
        }
    }

    fn candidate_result(
        &mut self,
        candidate: FunctionCandidate,
        span: Span,
    ) -> Result<Option<Handle<Type>>, ParseError> {
        let ty = match candidate {
            FunctionCandidate::Defined(function) => {
                return Ok(self.module.functions[function]
                    .result
                    .as_ref()
                    .map(|result| result.ty))
            }
            FunctionCandidate::Current => {
                return Ok(self.function.ir.result.as_ref().map(|result| result.ty))
            }
            FunctionCandidate::Builtin(builtin) => TypeSpecifier::from_scalar(builtin.result),
            FunctionCandidate::Multiply24(result)
            | FunctionCandidate::MultiplyHigh(result)
            | FunctionCandidate::Dot4(result)
            | FunctionCandidate::Dot2 { scalar: result, .. }
            | FunctionCandidate::HalfAdd(HalfAddBuiltin { scalar: result, .. })
            | FunctionCandidate::Atomic { scalar: result, .. }
            | FunctionCandidate::AtomicCompareExchange(result)
            | FunctionCandidate::Bitcast { result, .. }
            | FunctionCandidate::Unary { result, .. } => TypeSpecifier::Scalar(result),
            FunctionCandidate::FloatClassification(_) => TypeSpecifier::Scalar(Scalar::I32),
            FunctionCandidate::WrappingAtomic(_)
            | FunctionCandidate::FunnelShift(_)
            | FunctionCandidate::Sad(_)
            | FunctionCandidate::BytePerm
            | FunctionCandidate::ByteSwap32
            | FunctionCandidate::Fns
            | FunctionCandidate::PackedArithmetic(_)
            | FunctionCandidate::PackedUnary(_) => TypeSpecifier::Scalar(Scalar::U32),
            FunctionCandidate::IntegralDouble { .. } => unreachable!(),
            FunctionCandidate::FloatMath(_)
            | FunctionCandidate::SqrtRoundZero
            | FunctionCandidate::Sqrt
            | FunctionCandidate::Fmodf
            | FunctionCandidate::CopySign
            | FunctionCandidate::AddRoundZero
            | FunctionCandidate::AddRoundNearest
            | FunctionCandidate::SubtractRoundNearest
            | FunctionCandidate::SubtractRoundZero
            | FunctionCandidate::FusedMultiplyAddRoundZero
            | FunctionCandidate::FusedMultiplyAddRoundNearest
            | FunctionCandidate::MultiplyRoundZero
            | FunctionCandidate::MultiplyRoundNearest
            | FunctionCandidate::DivideRoundZero
            | FunctionCandidate::DivideRoundNearest
            | FunctionCandidate::ReciprocalRoundNearest
            | FunctionCandidate::ReciprocalRoundZero
            | FunctionCandidate::ReciprocalSqrtRoundNearest => TypeSpecifier::Scalar(Scalar::F32),
            FunctionCandidate::Constructor {
                component_count,
                scalar,
            } => TypeSpecifier::Vector {
                component_count,
                scalar,
            },
        };
        let ty = self.lower_type(ty, span)?;
        Ok(Some(self.type_handle(&ty, span)))
    }

    pub(super) fn null_pointer_parameter(
        &mut self,
        qualifiers: Qualifiers,
        is_reference: bool,
        is_pointer: bool,
        span: Span,
    ) -> Result<(), ParseError> {
        if self.function.kind == FunctionKind::Kernel {
            return self.fail("nullptr_t kernel parameters are unsupported");
        }
        if is_pointer || self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("pointers and arrays of nullptr_t objects are unsupported");
        }
        if qualifiers.is_volatile {
            return self.fail("volatile nullptr_t parameters are unsupported");
        }
        self.activate_parameter_expansion(span)?;
        if self.function.physical_parameter_modes.is_none() {
            self.parameter_expansion_budget
                .charge_slice::<ParameterMode>(self.function.parameters.len(), span)?;
            self.parameter_expansion_budget
                .charge_work(self.function.parameters.len(), span)?;
            self.function.physical_parameter_modes = Some(
                self.function
                    .parameters
                    .iter()
                    .filter_map(|parameter| parameter.shader_type().map(|_| parameter.mode()))
                    .collect(),
            );
        }
        let mode = if is_reference {
            ParameterMode::Reference { qualifiers }
        } else {
            ParameterMode::Value
        };
        self.parameter_expansion_budget
            .charge_slice::<SourceParameter>(1, span)?;
        self.parameter_expansion_budget.charge_work(1, span)?;
        self.function
            .parameters
            .push(SourceParameter::NullPointer { mode });
        if matches!(
            self.lexer.peek()?.0,
            Token::Separator(',') | Token::Paren(')')
        ) {
            return Ok(());
        }
        let (name, name_span) = self.identifier()?;
        self.check_name(name, name_span)?;
        if self.lexer.peek()?.0 == Token::Paren('[') {
            return self.fail("arrays of nullptr_t objects are unsupported");
        }
        self.insert_symbol(name, Symbol::PendingAuto, name_span)?;
        self.bind_null_pointer_symbol(name, name_span, qualifiers)
    }

    pub(super) fn device_parameter(
        &mut self,
        name: Option<&'a str>,
        span: Span,
        parameter_ty: &TypeResolution,
        is_const: bool,
        mode: ParameterMode,
    ) -> Result<(), ParseError> {
        let ty = self.type_handle(parameter_ty, span);
        self.parameter_expansion_budget
            .charge_slice::<SourceParameter>(1, span)?;
        self.function
            .parameters
            .push(SourceParameter::Shader { ty, mode });
        if let Some(modes) = self.function.physical_parameter_modes.as_mut() {
            self.parameter_expansion_budget
                .charge_slice::<ParameterMode>(1, span)?;
            self.parameter_expansion_budget.charge_work(1, span)?;
            modes.push(mode);
        }
        let argument_ty = self.physical_parameter_type(ty, mode, span)?;
        let argument_index = self.function.ir.arguments.len() as u32;
        self.function.ir.arguments.push(FunctionArgument {
            name: name.map(String::from),
            ty: argument_ty,
            binding: None,
        });
        let Some(name) = name else {
            return Ok(());
        };
        if let ParameterMode::Pointer { qualifiers } = mode {
            let pointer = self.parameter_pointer(argument_index, parameter_ty, qualifiers, span)?;
            let pointer = self.source_pointer_variable(name, pointer, is_const, span)?;
            let pointer = self.retain_pointer_symbol(pointer)?;
            return self.insert_symbol(name, Symbol::Pointer(pointer), span);
        }
        let value = self.append(Expression::FunctionArgument(argument_index), span)?;
        if let ParameterMode::Reference { qualifiers } = mode {
            self.insert_symbol(
                name,
                Symbol::Variable {
                    pointer: value,
                    ty: parameter_ty.clone(),
                    qualifiers,
                },
                span,
            )
        } else {
            self.initialize_parameter(name, span, parameter_ty, is_const, value)
        }
    }

    pub(super) fn physical_parameter_type(
        &mut self,
        ty: Handle<Type>,
        mode: ParameterMode,
        span: Span,
    ) -> Result<Handle<Type>, ParseError> {
        let base = if matches!(mode, ParameterMode::Pointer { .. }) {
            let Some(pointee) = self.source_pointer_pointee(&TypeResolution::Handle(ty)) else {
                return Ok(ty);
            };
            if !self.is_incomplete_array(pointee) {
                return Ok(ty);
            }
            self.activate_parameter_expansion(span)?;
            self.prepare_parameter_bindings(span)?;
            self.parameter_expansion_budget.charge_nodes(1, span)?;
            self.parameter_expansion_budget
                .charge_slice::<(Type, Span)>(1, span)?;
            self.pointer_validation_type(&TypeResolution::Handle(pointee), span)?
        } else if matches!(mode, ParameterMode::Reference { .. }) {
            ty
        } else {
            return Ok(ty);
        };
        Ok(self.module.types.insert(
            Type {
                name: None,
                inner: TypeInner::Pointer {
                    base,
                    space: AddressSpace::Function,
                },
            },
            span,
        ))
    }

    pub(super) fn call(&mut self, name: &str, span: Span) -> Result<ExpressionResult, ParseError> {
        if self.lookup_symbol(name).is_some() {
            return Err(ParseError {
                message: format!("local value `{name}` cannot be called"),
                span,
            });
        }
        if self.has_function_template(name) {
            return self.deduced_template_call(name, span);
        }
        self.ordinary_call(name, span)
    }

    fn ordinary_call(&mut self, name: &str, span: Span) -> Result<ExpressionResult, ParseError> {
        if self.function_candidates(name).next().is_none() {
            return Err(ParseError {
                message: format!("unknown or not previously declared device helper `{name}`"),
                span,
            });
        }
        self.lexer.expect_span(Token::Paren('('))?;
        if self.has_captured_candidate(name) {
            let mut arguments = Vec::new();
            if self.lexer.peek()?.0 != Token::Paren(')') {
                loop {
                    arguments.push(self.capture_call_argument()?);
                    if self.lexer.peek()?.0 == Token::Paren(')') {
                        break;
                    }
                    self.lexer.expect_span(Token::Separator(','))?;
                }
            }
            let end = self.lexer.expect_span(Token::Paren(')'))?;
            return self.call_with_captured_arguments(name, arguments, span, span.until(&end));
        }
        let mut arguments = Vec::new();
        if self.lexer.peek()?.0 != Token::Paren(')') {
            loop {
                let value = self.expression(0)?;
                arguments.push(self.rvalue(value)?);
                if self.lexer.peek()?.0 == Token::Paren(')') {
                    break;
                }
                self.lexer.expect_span(Token::Separator(','))?;
            }
        }
        let end = self.lexer.expect_span(Token::Paren(')'))?;
        self.call_with_arguments(name, arguments, span, span.until(&end))
    }

    pub(super) fn call_with_arguments(
        &mut self,
        name: &str,
        arguments: Vec<Value>,
        name_span: Span,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let candidate = self.resolve_overload(name, &arguments, name_span)?;
        let mut arguments = arguments;
        self.append_default_arguments(candidate, &mut arguments, span)?;
        self.lower_call(candidate, arguments, span)
    }

    fn lower_vector_constructor_call(
        &mut self,
        component_count: u8,
        scalar: Scalar,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        let components = arguments
            .into_iter()
            .map(|value| {
                self.convert_scalar(value.into(), scalar)
                    .map(|value| value.handle)
            })
            .collect::<Result<Vec<_>, _>>()?;
        let ty = self.lower_type(
            TypeSpecifier::Vector {
                component_count,
                scalar,
            },
            span,
        )?;
        let handle_ty = self.type_handle(&ty, span);
        let handle = self.append(
            Expression::Compose {
                ty: handle_ty,
                components,
            },
            span,
        )?;
        Ok(Value {
            category: ValueCategory::Prvalue,
            qualifiers: Qualifiers::NONE,
            constant: ConstantValue::default(),
            handle,
            ty,
            span,
        }
        .into())
    }

    pub(super) fn lower_call(
        &mut self,
        candidate: FunctionCandidate,
        arguments: Vec<Value>,
        span: Span,
    ) -> Result<ExpressionResult, ParseError> {
        self.check_float_classification_argument(candidate, &arguments, span)?;
        if let FunctionCandidate::FloatClassification(classification) = candidate {
            return self.lower_float_classification_call(classification, arguments, span);
        }
        if candidate == FunctionCandidate::CopySign {
            return self.lower_copysign_call(arguments, span);
        }
        if candidate == FunctionCandidate::AddRoundZero {
            return self.lower_fadd_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::AddRoundNearest {
            return self.lower_fadd_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::SubtractRoundNearest {
            return self.lower_fsub_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::SubtractRoundZero {
            return self.lower_fsub_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::FusedMultiplyAddRoundZero {
            return self.lower_fmaf_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::FusedMultiplyAddRoundNearest {
            return self.lower_fmaf_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::MultiplyRoundZero {
            return self.lower_fmul_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::MultiplyRoundNearest {
            return self.lower_fmul_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::DivideRoundZero {
            return self.lower_fdiv_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::DivideRoundNearest {
            return self.lower_fdiv_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::ReciprocalRoundNearest {
            return self.lower_frcp_rn_call(arguments, span);
        }
        if candidate == FunctionCandidate::ReciprocalRoundZero {
            return self.lower_frcp_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::ReciprocalSqrtRoundNearest {
            return self.lower_frsqrt_rn_call(arguments, span);
        }
        if let FunctionCandidate::Constructor {
            component_count,
            scalar,
        } = candidate
        {
            return self.lower_vector_constructor_call(component_count, scalar, arguments, span);
        }
        if let FunctionCandidate::Bitcast { source, result } = candidate {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), source)?;
            let mut expr = argument.handle;
            if result == Scalar::F32 {
                // Keep non-finite results out of WGSL constant evaluation.
                let pointer = self.temporary_pointer(&argument.ty, span)?;
                self.push_statement(
                    Statement::Store {
                        pointer,
                        value: expr,
                    },
                    span,
                );
                expr = self.append(Expression::Load { pointer }, span)?;
            }
            let handle = self.bitcast_scalar(expr, result, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(result),
                span,
            }
            .into());
        }
        if candidate == FunctionCandidate::Fmodf {
            let mut arguments = arguments.into_iter();
            let dividend = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
            let divisor = self.convert_scalar(arguments.next().unwrap().into(), Scalar::F32)?;
            let handle = self.call_fmodf(dividend.handle, divisor.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::F32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::FloatMath(operation) = candidate {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::F32)?;
            let handle = self.call_float_math(argument.handle, operation, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::F32),
                span,
            }
            .into());
        }
        if candidate == FunctionCandidate::SqrtRoundZero {
            return self.lower_sqrt_rz_call(arguments, span);
        }
        if candidate == FunctionCandidate::Sqrt {
            return self.lower_sqrt_call(arguments, span);
        }
        if let FunctionCandidate::Unary {
            function,
            source,
            result,
        } = candidate
        {
            let argument =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), source)?;
            let count = match (function, source) {
                (MathFunction::CountOneBits, Scalar::U64) => {
                    Some(self.population_count64(argument.handle, span)?)
                }
                (MathFunction::CountLeadingZeros, Scalar::I64) => {
                    Some(self.count_leading_zeros64(argument.handle, span)?)
                }
                (MathFunction::FirstTrailingBit, Scalar::I64) => {
                    Some(self.first_set_bit64(argument.handle, span)?)
                }
                _ => None,
            };
            if let Some(handle) = count {
                return Ok(Value {
                    category: ValueCategory::Prvalue,
                    qualifiers: Qualifiers::NONE,
                    constant: ConstantValue::default(),
                    handle,
                    ty: scalar_resolution(result),
                    span,
                }
                .into());
            }
            let handle = match function {
                MathFunction::ReverseBits if source == Scalar::U64 => {
                    self.reverse_bits64(argument.handle, span)?
                }
                MathFunction::Saturate => self.saturate(argument.handle, span)?,
                MathFunction::Sin | MathFunction::Cos => {
                    self.trigonometry(argument.handle, function == MathFunction::Cos, span)?
                }
                MathFunction::InverseSqrt => {
                    let root = self.call_sqrtf(argument.handle, span)?;
                    let one = self.append(Expression::Literal(Literal::F32(1.0)), span)?;
                    self.divide_f32(one, root, span)?
                }
                _ => self.append(
                    Expression::Math {
                        fun: function,
                        arg: argument.handle,
                        arg1: None,
                        arg2: None,
                        arg3: None,
                    },
                    span,
                )?,
            };
            let mut value = Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(source),
                span,
            };
            if function == MathFunction::FirstTrailingBit {
                // CUDA numbers set bits from one and returns zero for no set bits.
                let one = self.append(Expression::Literal(Literal::I32(1)), span)?;
                value.handle = self.append(
                    Expression::Binary {
                        op: BinaryOperator::Add,
                        left: value.handle,
                        right: one,
                    },
                    span,
                )?;
            }
            return Ok(self.convert_scalar(value.into(), result)?.into());
        }
        if let FunctionCandidate::FunnelShift(builtin) = candidate {
            let mut arguments = arguments.into_iter();
            let low = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let high = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let shift = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let handle = self.funnel_shift(builtin, low.handle, high.handle, shift.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Dot2 { high, scalar } = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let accumulator = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let handle = self.dot2_accumulate(
                high,
                scalar,
                left.handle,
                right.handle,
                accumulator.handle,
                span,
            )?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(scalar),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Dot4(scalar) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let accumulator = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let handle =
                self.dot4_accumulate(scalar, left.handle, right.handle, accumulator.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(scalar),
                span,
            }
            .into());
        }
        if candidate == FunctionCandidate::Fns {
            let mut arguments = arguments.into_iter();
            let mask = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let base = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let offset = self.convert_scalar(arguments.next().unwrap().into(), Scalar::I32)?;
            let handle = self.call_fns(mask.handle, base.handle, offset.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::PackedUnary(builtin) = candidate {
            return self.lower_packed_unary_call(builtin, arguments, span);
        }
        if candidate == FunctionCandidate::ByteSwap32 {
            let value =
                self.convert_scalar(arguments.into_iter().next().unwrap().into(), Scalar::U32)?;
            let handle = self.byte_swap32(value.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if candidate == FunctionCandidate::BytePerm {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let selector = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let handle = self.byte_permutation(left.handle, right.handle, selector.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Sad(scalar) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let accumulator = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let handle = self.sum_absolute_difference(
                scalar,
                left.handle,
                right.handle,
                accumulator.handle,
                span,
            )?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::PackedArithmetic(builtin) = candidate {
            self.activate_parameter_expansion(span)?;
            self.prepare_parameter_bindings(span)?;
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), Scalar::U32)?;
            let handle = self.packed_arithmetic(builtin, left.handle, right.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(Scalar::U32),
                span,
            }
            .into());
        }
        if let FunctionCandidate::HalfAdd(builtin) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), builtin.scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), builtin.scalar)?;
            let handle = self.half_add(builtin.rounded, left.handle, right.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(builtin.scalar),
                span,
            }
            .into());
        }
        if let FunctionCandidate::MultiplyHigh(scalar) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let handle = self.multiply_high(scalar, left.handle, right.handle, span)?;
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(scalar),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Multiply24(scalar) = candidate {
            let mut arguments = arguments.into_iter();
            let left = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let right = self.convert_scalar(arguments.next().unwrap().into(), scalar)?;
            let offset = self.append(Expression::Literal(Literal::U32(0)), span)?;
            let count = self.append(Expression::Literal(Literal::U32(24)), span)?;
            let mut operands = [left.handle, right.handle];
            for operand in &mut operands {
                let extracted = self.append(
                    Expression::Math {
                        fun: MathFunction::ExtractBits,
                        arg: *operand,
                        arg1: Some(offset),
                        arg2: Some(count),
                        arg3: None,
                    },
                    span,
                )?;
                *operand = if scalar == Scalar::I32 {
                    self.bitcast_scalar(extracted, Scalar::U32, span)?
                } else {
                    extracted
                };
            }
            let [left, right] = operands;
            let product = self.append(
                Expression::Binary {
                    op: BinaryOperator::Multiply,
                    left,
                    right,
                },
                span,
            )?;
            let handle = if scalar == Scalar::I32 {
                self.bitcast_scalar(product, Scalar::I32, span)?
            } else {
                product
            };
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: scalar_resolution(scalar),
                span,
            }
            .into());
        }
        if let FunctionCandidate::Builtin(builtin) = candidate {
            let mut arguments = arguments.into_iter();
            let left =
                self.convert_source_scalar(arguments.next().unwrap().into(), builtin.result)?;
            let right =
                self.convert_source_scalar(arguments.next().unwrap().into(), builtin.result)?;
            let handle = if builtin.result.scalar() == Scalar::F32 {
                self.float_minmax(builtin.function, left.handle, right.handle, span)?
            } else {
                self.append(
                    Expression::Math {
                        fun: builtin.function,
                        arg: left.handle,
                        arg1: Some(right.handle),
                        arg2: None,
                        arg3: None,
                    },
                    span,
                )?
            };
            return Ok(Value {
                category: ValueCategory::Prvalue,
                qualifiers: Qualifiers::NONE,
                constant: ConstantValue::default(),
                handle,
                ty: self.source_scalar_resolution(builtin.result, span)?,
                span,
            }
            .into());
        }
        let FunctionCandidate::Defined(function) = candidate else {
            unreachable!()
        };
        self.function.calls.push(FunctionCall { function, span });
        let mut converted = Vec::with_capacity(arguments.len());
        for (argument_index, value) in arguments.into_iter().enumerate() {
            let parameter = &self.module.functions[function].arguments[argument_index];
            let ty = TypeResolution::Handle(parameter.ty);
            converted.push(self.convert_value(value.into(), &ty)?.handle);
        }
        let ty = self.module.functions[function]
            .result
            .as_ref()
            .map(|result| TypeResolution::Handle(result.ty));
        let value = if let Some(ty) = ty {
            let handle = self.append_call_result(function, span)?;
            Some(Value {
                category: ValueCategory::Prvalue,
                qualifiers: self.prvalue_qualifiers(
                    &ty,
                    self.function_declarations[&function].result_qualifiers,
                ),
                constant: ConstantValue::default(),
                handle,
                ty,
                span,
            })
        } else {
            None
        };
        self.push_statement(
            Statement::Call {
                function,
                arguments: converted,
                result: value.as_ref().map(|value| value.handle),
            },
            span,
        );
        Ok(match value {
            Some(value) => value.into(),
            None => self.erased_call_result(function, span),
        })
    }

    pub(super) fn erased_call_result(
        &self,
        function: Handle<Function>,
        span: Span,
    ) -> ExpressionResult {
        if self.function_declarations[&function].source_result
            == ReturnType::Value(TypeSpecifier::NullPointer)
        {
            let mut value = NullPointerValue::literal(span);
            value.is_constant = false;
            value.constant = ConstantValue::default();
            ExpressionValue::NullPointer(value).into()
        } else {
            ExpressionResult::Void(VoidValue::runtime(span))
        }
    }

    fn float_minmax(
        &mut self,
        function: MathFunction,
        left: Handle<Expression>,
        right: Handle<Expression>,
        span: Span,
    ) -> Result<Handle<Expression>, ParseError> {
        let sign_bit = self.append(Expression::Literal(Literal::U32(0x8000_0000)), span)?;
        let magnitude_mask = self.append(Expression::Literal(Literal::U32(0x7fff_ffff)), span)?;
        let infinity_bits = self.append(Expression::Literal(Literal::U32(0x7f80_0000)), span)?;
        let canonical_nan_bits =
            self.append(Expression::Literal(Literal::U32(0x7fc0_0000)), span)?;
        let operands = [left, right].map(|value| {
            let bits = self.bitcast_scalar(value, Scalar::U32, span)?;
            let is_negative = self.append(
                Expression::Binary {
                    op: BinaryOperator::GreaterEqual,
                    left: bits,
                    right: sign_bit,
                },
                span,
            )?;
            let reversed_bits = self.append(
                Expression::Unary {
                    op: UnaryOperator::BitwiseNot,
                    expr: bits,
                },
                span,
            )?;
            let positive_key = self.append(
                Expression::Binary {
                    op: BinaryOperator::ExclusiveOr,
                    left: bits,
                    right: sign_bit,
                },
                span,
            )?;
            let ordering_key = self.append(
                Expression::Select {
                    condition: is_negative,
                    accept: reversed_bits,
                    reject: positive_key,
                },
                span,
            )?;
            let absolute_bits = self.append(
                Expression::Binary {
                    op: BinaryOperator::And,
                    left: bits,
                    right: magnitude_mask,
                },
                span,
            )?;
            let is_nan = self.append(
                Expression::Binary {
                    op: BinaryOperator::Greater,
                    left: absolute_bits,
                    right: infinity_bits,
                },
                span,
            )?;
            Ok::<_, ParseError>((bits, ordering_key, is_nan))
        });
        let [left, right] = operands;
        let (left_bits, left_key, left_is_nan) = left?;
        let (right_bits, right_key, right_is_nan) = right?;
        let choose_left = self.append(
            Expression::Binary {
                op: if function == MathFunction::Min {
                    BinaryOperator::Less
                } else {
                    BinaryOperator::Greater
                },
                left: left_key,
                right: right_key,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: choose_left,
                accept: left_bits,
                reject: right_bits,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: left_is_nan,
                accept: right_bits,
                reject: selected_bits,
            },
            span,
        )?;
        let selected_bits = self.append(
            Expression::Select {
                condition: right_is_nan,
                accept: left_bits,
                reject: selected_bits,
            },
            span,
        )?;
        let both_are_nan = self.append(
            Expression::Binary {
                op: BinaryOperator::LogicalAnd,
                left: left_is_nan,
                right: right_is_nan,
            },
            span,
        )?;
        let bits = self.append(
            Expression::Select {
                condition: both_are_nan,
                accept: canonical_nan_bits,
                reject: selected_bits,
            },
            span,
        )?;
        self.bitcast_scalar(bits, Scalar::F32, span)
    }

    pub(super) fn has_function_candidate(&self, name: &str) -> bool {
        self.function_candidates(name).next().is_some()
    }

    pub(super) fn function_candidates<'b>(
        &'b self,
        name: &str,
    ) -> impl Iterator<Item = FunctionCandidate> + Clone + 'b {
        let functions = match self.global_declarations.get(name) {
            Some(&GlobalDeclaration::Functions(ref functions)) => functions.functions.as_slice(),
            _ => &[],
        };
        let current = (self.function.kind == FunctionKind::Device
            && self.function.ir.name.as_deref() == Some(name))
        .then_some(FunctionCandidate::Current);
        let builtin_visible = matches!(
            self.global_declarations.get(name),
            Some(&GlobalDeclaration::Functions(_))
        );
        let atomic_function = INTEGER_ATOMICS
            .into_iter()
            .find_map(|(candidate, function)| {
                (builtin_visible && name == candidate).then_some(function)
            });
        let compare_exchange_visible = builtin_visible && name == "atomicCAS";
        let dot4_visible = builtin_visible && name == "__dp4a";
        let dot2_half = match (builtin_visible, name) {
            (true, "__dp2a_lo") => Some(false),
            (true, "__dp2a_hi") => Some(true),
            _ => None,
        };
        functions
            .iter()
            .copied()
            .filter(move |&function| self.function.current_declaration != Some(function))
            .map(FunctionCandidate::Defined)
            .chain(current)
            .chain(
                math_builtins(name)
                    .filter(move |_| builtin_visible)
                    .map(FunctionCandidate::Builtin),
            )
            .chain(
                MULTIPLY24_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, scalar)| FunctionCandidate::Multiply24(scalar)),
            )
            .chain(
                MULTIPLY_HIGH_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, scalar)| FunctionCandidate::MultiplyHigh(scalar)),
            )
            .chain(
                PACKED_ARITHMETIC_BUILTINS
                    .iter()
                    .find(|&&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|&(_, builtin)| FunctionCandidate::PackedArithmetic(builtin)),
            )
            .chain(
                HALF_ADD_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, builtin)| FunctionCandidate::HalfAdd(builtin)),
            )
            .chain(
                SAD_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, scalar)| FunctionCandidate::Sad(scalar)),
            )
            .chain(
                FUNNEL_SHIFT_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, builtin)| FunctionCandidate::FunnelShift(builtin)),
            )
            .chain(
                BITCAST_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, source, result)| FunctionCandidate::Bitcast { source, result }),
            )
            .chain(
                UNARY_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _, _, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, function, source, result)| FunctionCandidate::Unary {
                        function,
                        source,
                        result,
                    }),
            )
            .chain(
                FLOAT_MATH_BUILTINS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, operation)| FunctionCandidate::FloatMath(operation)),
            )
            .chain(
                FLOAT_CLASSIFICATION_BUILTINS
                    .iter()
                    .find(|&&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|&(_, operation)| FunctionCandidate::FloatClassification(operation)),
            )
            .chain(
                (builtin_visible && name == "__fsqrt_rz")
                    .then_some(FunctionCandidate::SqrtRoundZero),
            )
            .chain(
                (builtin_visible && SQRT_BUILTINS.contains(&name))
                    .then_some(FunctionCandidate::Sqrt),
            )
            .chain((builtin_visible && name == "fmodf").then_some(FunctionCandidate::Fmodf))
            .chain((builtin_visible && name == "copysignf").then_some(FunctionCandidate::CopySign))
            .chain(
                (builtin_visible && name == "__fadd_rz").then_some(FunctionCandidate::AddRoundZero),
            )
            .chain(
                (builtin_visible && name == "__fadd_rn")
                    .then_some(FunctionCandidate::AddRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__fsub_rn")
                    .then_some(FunctionCandidate::SubtractRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__fsub_rz")
                    .then_some(FunctionCandidate::SubtractRoundZero),
            )
            .chain(
                (builtin_visible && name == "__fmul_rz")
                    .then_some(FunctionCandidate::MultiplyRoundZero),
            )
            .chain(
                (builtin_visible && name == "__fmul_rn")
                    .then_some(FunctionCandidate::MultiplyRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__fdiv_rz")
                    .then_some(FunctionCandidate::DivideRoundZero),
            )
            .chain(
                (builtin_visible && name == "__fdiv_rn")
                    .then_some(FunctionCandidate::DivideRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__frcp_rn")
                    .then_some(FunctionCandidate::ReciprocalRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__frcp_rz")
                    .then_some(FunctionCandidate::ReciprocalRoundZero),
            )
            .chain(
                (builtin_visible && name == "__fmaf_rz")
                    .then_some(FunctionCandidate::FusedMultiplyAddRoundZero),
            )
            .chain(
                (builtin_visible && FMA_BUILTINS.contains(&name))
                    .then_some(FunctionCandidate::FusedMultiplyAddRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__frsqrt_rn")
                    .then_some(FunctionCandidate::ReciprocalSqrtRoundNearest),
            )
            .chain(
                (builtin_visible && name == "__byte_perm").then_some(FunctionCandidate::BytePerm),
            )
            .chain(
                (builtin_visible && name == "__nv_bswap32")
                    .then_some(FunctionCandidate::ByteSwap32),
            )
            .chain(
                PACKED_UNARY_BUILTINS
                    .iter()
                    .find(|&&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|&(_, builtin)| FunctionCandidate::PackedUnary(builtin)),
            )
            .chain((builtin_visible && name == "__fns").then_some(FunctionCandidate::Fns))
            .chain(
                [Scalar::I32, Scalar::U32]
                    .into_iter()
                    .filter(move |_| dot4_visible)
                    .map(FunctionCandidate::Dot4),
            )
            .chain(dot2_half.into_iter().flat_map(|high| {
                [Scalar::I32, Scalar::U32].map(|scalar| FunctionCandidate::Dot2 { high, scalar })
            }))
            .chain(atomic_function.into_iter().flat_map(|function| {
                [Scalar::I32, Scalar::U32]
                    .map(|scalar| FunctionCandidate::Atomic { function, scalar })
            }))
            .chain(
                [Scalar::I32, Scalar::U32]
                    .into_iter()
                    .filter(move |_| compare_exchange_visible)
                    .map(FunctionCandidate::AtomicCompareExchange),
            )
            .chain(
                WRAPPING_ATOMICS
                    .into_iter()
                    .find(|&(candidate, _)| candidate == name)
                    .filter(move |_| builtin_visible)
                    .map(|(_, function)| FunctionCandidate::WrappingAtomic(function)),
            )
            .chain(
                vector_constructor(name)
                    .filter(move |_| builtin_visible)
                    .map(|(component_count, scalar)| FunctionCandidate::Constructor {
                        component_count,
                        scalar,
                    }),
            )
    }

    pub(super) fn candidate_arity(&self, candidate: FunctionCandidate) -> usize {
        match candidate {
            FunctionCandidate::Defined(handle) => self.function_declarations.get(&handle).map_or(
                self.module.functions[handle].arguments.len(),
                |declaration| declaration.parameters.len(),
            ),
            FunctionCandidate::Current => self.function.parameters.len(),
            FunctionCandidate::Builtin(builtin) => builtin.parameters.len(),
            FunctionCandidate::Multiply24(_)
            | FunctionCandidate::MultiplyHigh(_)
            | FunctionCandidate::HalfAdd(_)
            | FunctionCandidate::PackedArithmetic(_)
            | FunctionCandidate::Atomic { .. }
            | FunctionCandidate::WrappingAtomic(_)
            | FunctionCandidate::Fmodf
            | FunctionCandidate::CopySign
            | FunctionCandidate::AddRoundZero
            | FunctionCandidate::AddRoundNearest
            | FunctionCandidate::SubtractRoundNearest
            | FunctionCandidate::SubtractRoundZero
            | FunctionCandidate::MultiplyRoundZero
            | FunctionCandidate::MultiplyRoundNearest
            | FunctionCandidate::DivideRoundZero
            | FunctionCandidate::DivideRoundNearest => 2,
            FunctionCandidate::AtomicCompareExchange(_)
            | FunctionCandidate::FunnelShift(_)
            | FunctionCandidate::Sad(_)
            | FunctionCandidate::BytePerm
            | FunctionCandidate::Dot4(_)
            | FunctionCandidate::Dot2 { .. }
            | FunctionCandidate::Fns
            | FunctionCandidate::FusedMultiplyAddRoundZero
            | FunctionCandidate::FusedMultiplyAddRoundNearest => 3,
            FunctionCandidate::Bitcast { .. }
            | FunctionCandidate::ByteSwap32
            | FunctionCandidate::PackedUnary(_)
            | FunctionCandidate::Unary { .. }
            | FunctionCandidate::FloatMath(_)
            | FunctionCandidate::FloatClassification(_)
            | FunctionCandidate::IntegralDouble { .. }
            | FunctionCandidate::SqrtRoundZero
            | FunctionCandidate::Sqrt
            | FunctionCandidate::ReciprocalRoundNearest
            | FunctionCandidate::ReciprocalRoundZero
            | FunctionCandidate::ReciprocalSqrtRoundNearest => 1,
            FunctionCandidate::Constructor {
                component_count, ..
            } => usize::from(component_count),
        }
    }

    pub(super) fn candidate_type(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
    ) -> Option<TypeResolution> {
        match candidate {
            FunctionCandidate::Defined(handle) => {
                if let Some(declaration) = self.function_declarations.get(&handle) {
                    return declaration.parameters[logical_index]
                        .shader_type()
                        .map(TypeResolution::Handle);
                }
            }
            FunctionCandidate::Current => {
                return self.function.parameters[logical_index]
                    .shader_type()
                    .map(TypeResolution::Handle)
            }
            _ => {}
        }
        let argument = match candidate {
            FunctionCandidate::Defined(handle) => {
                &self.module.functions[handle].arguments[logical_index]
            }
            FunctionCandidate::Current => &self.function.ir.arguments[logical_index],
            FunctionCandidate::Builtin(builtin) => {
                return Some(scalar_resolution(
                    builtin.parameters[logical_index].scalar(),
                ))
            }
            FunctionCandidate::Bitcast { source, .. }
            | FunctionCandidate::Unary { source, .. }
            | FunctionCandidate::Multiply24(source)
            | FunctionCandidate::MultiplyHigh(source)
            | FunctionCandidate::Dot4(source)
            | FunctionCandidate::Dot2 { scalar: source, .. }
            | FunctionCandidate::HalfAdd(HalfAddBuiltin { scalar: source, .. })
            | FunctionCandidate::IntegralDouble { source } => {
                return Some(scalar_resolution(source))
            }
            FunctionCandidate::FloatMath(_)
            | FunctionCandidate::FloatClassification(_)
            | FunctionCandidate::SqrtRoundZero
            | FunctionCandidate::Sqrt
            | FunctionCandidate::Fmodf
            | FunctionCandidate::CopySign
            | FunctionCandidate::AddRoundZero
            | FunctionCandidate::AddRoundNearest
            | FunctionCandidate::SubtractRoundNearest
            | FunctionCandidate::SubtractRoundZero
            | FunctionCandidate::FusedMultiplyAddRoundZero
            | FunctionCandidate::FusedMultiplyAddRoundNearest
            | FunctionCandidate::MultiplyRoundZero
            | FunctionCandidate::MultiplyRoundNearest
            | FunctionCandidate::DivideRoundZero
            | FunctionCandidate::DivideRoundNearest
            | FunctionCandidate::ReciprocalRoundNearest
            | FunctionCandidate::ReciprocalRoundZero
            | FunctionCandidate::ReciprocalSqrtRoundNearest => {
                return Some(scalar_resolution(Scalar::F32))
            }
            FunctionCandidate::FunnelShift(_)
            | FunctionCandidate::BytePerm
            | FunctionCandidate::ByteSwap32
            | FunctionCandidate::PackedArithmetic(_)
            | FunctionCandidate::PackedUnary(_) => return Some(scalar_resolution(Scalar::U32)),
            FunctionCandidate::Sad(scalar) => {
                return Some(scalar_resolution(if logical_index < 2 {
                    scalar
                } else {
                    Scalar::U32
                }))
            }
            FunctionCandidate::Fns => {
                return Some(scalar_resolution(if logical_index < 2 {
                    Scalar::U32
                } else {
                    Scalar::I32
                }))
            }
            FunctionCandidate::Constructor { scalar, .. } => {
                return Some(scalar_resolution(scalar))
            }
            FunctionCandidate::Atomic { scalar, .. }
            | FunctionCandidate::AtomicCompareExchange(scalar) => {
                return Some(if logical_index == 0 {
                    TypeResolution::Value(TypeInner::ValuePointer {
                        size: None,
                        scalar,
                        space: AddressSpace::Function,
                    })
                } else {
                    scalar_resolution(scalar)
                })
            }
            FunctionCandidate::WrappingAtomic(_) => {
                return Some(if logical_index == 0 {
                    TypeResolution::Value(TypeInner::ValuePointer {
                        size: None,
                        scalar: Scalar::U32,
                        space: AddressSpace::Function,
                    })
                } else {
                    scalar_resolution(Scalar::U32)
                })
            }
        };
        Some(TypeResolution::Handle(argument.ty))
    }

    pub(super) fn candidate_mode(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
    ) -> ParameterMode {
        match candidate {
            FunctionCandidate::Defined(handle) => self
                .function_declarations
                .get(&handle)
                .map_or(ParameterMode::Value, |declaration| {
                    declaration.parameters[logical_index].mode()
                }),
            FunctionCandidate::Current => self.function.parameters[logical_index].mode(),
            FunctionCandidate::Atomic { .. }
            | FunctionCandidate::AtomicCompareExchange(_)
            | FunctionCandidate::WrappingAtomic(_)
                if logical_index == 0 =>
            {
                ParameterMode::Pointer {
                    qualifiers: Qualifiers::NONE,
                }
            }
            _ => ParameterMode::Value,
        }
    }

    pub(super) fn candidate_conversion(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        if let Some(SourceParameter::NullPointer { mode }) =
            self.candidate_source_parameter(candidate, logical_index)
        {
            return self.null_pointer_argument_conversion(mode, argument);
        }
        if let FunctionCandidate::Builtin(builtin) = candidate {
            let source = self.source_scalar(argument.ty()?)?;
            return Some(Self::scalar_conversion_rank(
                source,
                builtin.parameters[logical_index],
            ));
        }
        let target = self.candidate_type(candidate, logical_index);
        if target.is_none() {
            return argument.is_thread_block().then_some(0);
        }
        if argument.is_thread_block() {
            return None;
        }
        let atomic_scalar = match candidate {
            FunctionCandidate::Atomic { scalar, .. }
            | FunctionCandidate::AtomicCompareExchange(scalar) => Some(scalar),
            FunctionCandidate::WrappingAtomic(_) => Some(Scalar::U32),
            _ => None,
        };
        if let Some(scalar) = atomic_scalar {
            if logical_index == 0 {
                let pointer = argument.pointer_type(&self.module)?;
                return (pointer.qualifiers == Qualifiers::NONE
                    && self.module.types[pointer.pointee].inner == TypeInner::Scalar(scalar))
                .then_some(0);
            }
        }
        let target = target?;
        let mode = self.candidate_mode(candidate, logical_index);
        if let ParameterMode::Pointer { qualifiers } = mode {
            let TypeInner::Pointer { base, .. } = *target.inner_with(&self.module.types) else {
                return None;
            };
            return self.pointer_argument_conversion(
                &TypeResolution::Handle(base),
                qualifiers,
                argument,
            );
        }
        self.value_argument_conversion(&target, mode, argument)
    }

    pub(super) fn candidate_source_parameter(
        &self,
        candidate: FunctionCandidate,
        logical_index: usize,
    ) -> Option<SourceParameter> {
        match candidate {
            FunctionCandidate::Defined(handle) => self
                .function_declarations
                .get(&handle)?
                .parameters
                .get(logical_index)
                .copied(),
            FunctionCandidate::Current => self.function.parameters.get(logical_index).copied(),
            _ => None,
        }
    }

    pub(super) fn null_pointer_argument_conversion(
        &self,
        mode: ParameterMode,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let rank = if argument.is_null_pointer() {
            0
        } else if argument.is_null_pointer_constant() {
            2
        } else {
            return None;
        };
        match mode {
            ParameterMode::Value => Some(rank),
            ParameterMode::Reference { qualifiers } => {
                if rank == 0 {
                    if let Some(source) = argument.reference_qualifiers() {
                        return qualifiers.contains(source).then_some(rank);
                    }
                }
                (qualifiers.is_const && !qualifiers.is_volatile).then_some(rank)
            }
            ParameterMode::Pointer { .. } => None,
        }
    }

    pub(super) fn pointer_argument_conversion(
        &self,
        pointee: &TypeResolution,
        qualifiers: Qualifiers,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        if argument.is_null_pointer_constant() {
            return Some(2);
        }
        let source = argument.pointer_type(&self.module)?;
        if self.source_types_equal(&TypeResolution::Handle(source.pointee), pointee) {
            return qualifiers.qualification_rank(source.qualifiers);
        }
        let target = match *pointee {
            TypeResolution::Handle(handle) => handle,
            TypeResolution::Value(_) => return None,
        };
        if !self.pointer_pointee_compatible(source.pointee, target) {
            return None;
        }
        qualifiers.contains(source.qualifiers).then_some(1)
    }

    pub(super) fn value_argument_conversion(
        &self,
        target: &TypeResolution,
        mode: ParameterMode,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let source = argument.ty()?;
        let rank = if *target.inner_with(&self.module.types) == TypeInner::Scalar(Scalar::BOOL)
            && argument.pointer_type(&self.module).is_some()
        {
            2
        } else {
            self.conversion_rank(source, target, self.dimension_conversion(source, target))?
        };
        match mode {
            ParameterMode::Value => Some(rank),
            ParameterMode::Reference { qualifiers } => {
                if rank == 0 {
                    if let Some(source) = argument.reference_qualifiers() {
                        return qualifiers.contains(source).then_some(rank);
                    }
                    if argument
                        .value_qualifiers()
                        .is_some_and(|source| !qualifiers.contains(source))
                    {
                        return None;
                    }
                }
                (qualifiers.is_const && !qualifiers.is_volatile).then_some(rank)
            }
            ParameterMode::Pointer { .. } => unreachable!(),
        }
    }

    pub(super) fn pointer_reference_conversion(
        &self,
        pointee: Handle<Type>,
        pointee_qualifiers: Qualifiers,
        object_qualifiers: Qualifiers,
        argument: &impl CallArgument,
    ) -> Option<u8> {
        let rank = self.pointer_argument_conversion(
            &TypeResolution::Handle(pointee),
            pointee_qualifiers,
            argument,
        )?;
        if rank == 0 {
            if let Some(source) = argument.pointer_object_qualifiers() {
                return object_qualifiers.contains(source).then_some(rank);
            }
        }
        (object_qualifiers.is_const && !object_qualifiers.is_volatile).then_some(rank)
    }

    fn better_candidate(
        &self,
        left_candidate: FunctionCandidate,
        right_candidate: FunctionCandidate,
        arguments: &[impl CallArgument],
    ) -> bool {
        better_conversion_sequences(arguments.iter().enumerate().map(|(index, argument)| {
            let left = self.candidate_conversion(left_candidate, index, argument)?;
            let right = self.candidate_conversion(right_candidate, index, argument)?;
            Some((
                ArgumentConversion {
                    rank: left,
                    mode: self.candidate_mode(left_candidate, index),
                },
                ArgumentConversion {
                    rank: right,
                    mode: self.candidate_mode(right_candidate, index),
                },
            ))
        }))
    }

    pub(super) fn resolve_overload(
        &mut self,
        name: &str,
        arguments: &[impl CallArgument],
        span: Span,
    ) -> Result<FunctionCandidate, ParseError> {
        let best_candidate =
            match self.select_overload(name, arguments, self.lexer.position(), span)? {
                OverloadResolution::Selected(candidate) => candidate,
                OverloadResolution::NoViable => {
                    let argument_span = self
                        .function_candidates(name)
                        .filter(|&candidate| {
                            self.candidate_accepts_arity(
                                candidate,
                                arguments.len(),
                                self.lexer.position(),
                            )
                        })
                        .find_map(|candidate| {
                            arguments.iter().enumerate().find_map(|(index, argument)| {
                                (matches!(
                                    self.candidate_mode(candidate, index),
                                    ParameterMode::Pointer { .. }
                                ) && self
                                    .candidate_conversion(candidate, index, argument)
                                    .is_none())
                                .then(|| argument.span())
                            })
                        });
                    return Err(ParseError {
                        message: format!("no matching device helper overload `{name}`"),
                        span: argument_span.unwrap_or(span),
                    });
                }
                OverloadResolution::Ambiguous => {
                    return Err(ParseError {
                        message: format!("ambiguous device helper overload `{name}`"),
                        span,
                    })
                }
            };
        match best_candidate {
            FunctionCandidate::Current => Err(ParseError {
                message: String::from("recursive device helper calls are unsupported"),
                span,
            }),
            FunctionCandidate::IntegralDouble { .. } => Err(ParseError {
                message: format!("integral {name} requires unsupported double precision"),
                span,
            }),
            _ => Ok(best_candidate),
        }
    }

    pub(super) fn select_overload(
        &mut self,
        name: &str,
        arguments: &[impl CallArgument],
        position: super::super::lexer::LexerPosition,
        span: Span,
    ) -> Result<OverloadResolution, ParseError> {
        let mut work = 0usize;
        for candidate in self.function_candidates(name) {
            work = work
                .checked_add(
                    self.candidate_arity(candidate)
                        .saturating_sub(arguments.len()),
                )
                .ok_or_else(|| ParseError {
                    message: String::from("CUDA helper parameter expansion limit exceeded"),
                    span,
                })?;
        }
        self.parameter_expansion_budget.charge_work(work, span)?;
        let integral_double = self.integral_double_candidate(name, arguments);
        Ok(self.select_candidates(
            self.function_candidates(name).chain(integral_double),
            arguments,
            position,
        ))
    }

    pub(super) fn select_candidates(
        &self,
        candidates: impl Iterator<Item = FunctionCandidate> + Clone,
        arguments: &[impl CallArgument],
        position: super::super::lexer::LexerPosition,
    ) -> OverloadResolution {
        let viable_candidates = candidates.filter(|&candidate| {
            self.candidate_accepts_arity(candidate, arguments.len(), position)
                && arguments.iter().enumerate().all(|(index, argument)| {
                    self.candidate_conversion(candidate, index, argument)
                        .is_some()
                })
        });
        select_ranked_candidate(viable_candidates, |left, right| {
            self.better_candidate(left, right, arguments)
        })
    }

    pub(super) fn integral_double_candidate(
        &self,
        name: &str,
        arguments: &[impl CallArgument],
    ) -> Option<FunctionCandidate> {
        if !INTEGRAL_DOUBLE_BUILTINS.contains(&name)
            || arguments.len() != 1
            || !matches!(
                self.global_declarations.get(name),
                Some(&GlobalDeclaration::Functions(_))
            )
        {
            return None;
        }
        let argument_type = arguments[0].ty()?;
        let &TypeInner::Scalar(source) = argument_type.inner_with(&self.module.types) else {
            return None;
        };
        if ![
            Scalar::BOOL,
            Scalar::I16,
            Scalar::U16,
            Scalar::I32,
            Scalar::U32,
            Scalar::I64,
            Scalar::U64,
        ]
        .contains(&source)
        {
            return None;
        }
        // An exact ordinary overload wins its tie with the arithmetic template.
        let exact_ordinary = self.function_candidates(name).any(|candidate| {
            matches!(
                candidate,
                FunctionCandidate::Defined(_) | FunctionCandidate::Current
            ) && self.candidate_accepts_arity(candidate, 1, self.lexer.position())
                && self
                    .candidate_type(candidate, 0)
                    .is_some_and(|target| self.source_types_equal(&target, argument_type))
                && self
                    .candidate_conversion(candidate, 0, &arguments[0])
                    .is_some()
        });
        (!exact_ordinary).then_some(FunctionCandidate::IntegralDouble { source })
    }
}
