use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const POSITIVE_INFINITY: u32 = 0x7f80_0000;
const NEGATIVE_INFINITY: u32 = 0xff80_0000;
const QUIET_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        initial_values(),
        arithmetic_and_predicates(),
        declarations_and_effects(),
        typed_copies(),
    ]
}

fn initial_values() -> ShaderTest {
    let expected = [0x7f80_0000_u32, 1, SENTINEL, SENTINEL];
    module_case(
        "nonfinite constexpr values preserve infinity bits and NaN classification",
        "constexpr float Positive = 1.0f / 0.0f;
        __global__ void nonfinite(unsigned *output) {
            constexpr float NotANumber = 0.0f / 0.0f;
            unsigned nan_bits = __float_as_uint(NotANumber);
            output[0] = __float_as_uint(Positive);
            output[1] = unsigned((nan_bits & 0x7f800000u) == 0x7f800000u
                                 && (nan_bits & 0x007fffffu) != 0u);
        }",
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 4],
        )],
        0,
        [1, 1, 1],
    )
}

fn arithmetic_and_predicates() -> ShaderTest {
    let floating_expressions = [
        ("Positive", POSITIVE_INFINITY),
        ("Negative", NEGATIVE_INFINITY),
        ("NotANumber", QUIET_NAN),
        ("-NotANumber", QUIET_NAN | 0x8000_0000),
        ("+NotANumber", QUIET_NAN),
        ("Positive + Positive", POSITIVE_INFINITY),
        ("Positive + Negative", QUIET_NAN),
        ("Negative + Negative", NEGATIVE_INFINITY),
        ("Positive - Positive", QUIET_NAN),
        ("Negative - Positive", NEGATIVE_INFINITY),
        ("Positive - Negative", POSITIVE_INFINITY),
        ("NotANumber - NotANumber", QUIET_NAN),
        ("Positive * 0.0f", QUIET_NAN),
        ("Positive * -1.0f", NEGATIVE_INFINITY),
        ("Negative * -1.0f", POSITIVE_INFINITY),
        ("NotANumber * 1.0f", QUIET_NAN),
        ("Positive / Positive", QUIET_NAN),
        ("Positive / Negative", QUIET_NAN),
        ("1.0f / Positive", 0),
        ("1.0f / Negative", 0x8000_0000),
        ("-1.0f / Positive", 0x8000_0000),
        ("-1.0f / Negative", 0),
        ("0.0f / NotANumber", QUIET_NAN),
        ("NotANumber / 1.0f", QUIET_NAN),
        ("0.0f / 0.0f", QUIET_NAN),
        ("1.0f / -0.0f", NEGATIVE_INFINITY),
        ("3.4e38f * 2.0f", POSITIVE_INFINITY),
        ("-3.4e38f * 2.0f", NEGATIVE_INFINITY),
        ("3.4e38f + 3.4e38f", POSITIVE_INFINITY),
        ("-3.4e38f - 3.4e38f", NEGATIVE_INFINITY),
        ("NotANumber + 42.0f", QUIET_NAN),
        ("-(-NotANumber)", QUIET_NAN),
    ];
    let predicates = [
        ("Positive > Negative", 1),
        ("Positive == Positive", 1),
        ("Negative <= Positive", 1),
        ("Positive < Positive", 0),
        ("Positive != Positive", 0),
        ("NotANumber == NotANumber", 0),
        ("NotANumber != NotANumber", 1),
        ("NotANumber < 0.0f", 0),
        ("NotANumber <= 0.0f", 0),
        ("NotANumber > 0.0f", 0),
        ("NotANumber >= 0.0f", 0),
        ("bool(Positive)", 1),
        ("bool(Negative)", 1),
        ("bool(NotANumber)", 1),
        ("!Positive", 0),
        ("!NotANumber", 0),
        ("Positive && NotANumber", 1),
        ("NotANumber || false", 1),
        ("false && NotANumber", 0),
        ("true || Positive", 1),
        ("bool(1.0f / Negative)", 0),
        ("(Positive, true)", 1),
        ("(NotANumber, false)", 0),
        ("NotANumber ? true : false", 1),
    ];
    let mut source = String::from(
        "constexpr float Positive = 1.0f / 0.0f;
        constexpr float Negative = -Positive;
        constexpr float NotANumber = 0.0f / 0.0f;
        __global__ void classes(unsigned *output) {",
    );
    let mut expected = [SENTINEL; 64];
    for (index, (expression, bits)) in floating_expressions.into_iter().enumerate() {
        source.push_str(&format!(
            "constexpr float value_{index} = {expression}; output[{index}] = __float_as_uint(value_{index});"
        ));
        expected[index] = bits;
    }
    for (offset, (expression, result)) in predicates.into_iter().enumerate() {
        let index = floating_expressions.len() + offset;
        source.push_str(&format!(
            "constexpr bool predicate_{offset} = {expression}; output[{index}] = unsigned(predicate_{offset});"
        ));
        expected[index] = result;
    }
    source.push('}');
    output_case(
        "nonfinite constexpr arithmetic, signed zeros, unordered comparisons, boolean conversions and lazy predicates",
        &source,
        &expected,
    )
}

fn declarations_and_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 64];
    expected[..53].copy_from_slice(&[
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        QUIET_NAN,
        QUIET_NAN | 0x8000_0000,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        QUIET_NAN,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        1,
        1,
        0,
        1,
        0,
        QUIET_NAN,
        QUIET_NAN,
        0,
        0x8000_0000,
        QUIET_NAN,
        QUIET_NAN,
        QUIET_NAN,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        QUIET_NAN,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        QUIET_NAN,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        QUIET_NAN,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        3,
        3,
        1,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        POSITIVE_INFINITY,
        POSITIVE_INFINITY,
        1,
        QUIET_NAN,
        2,
        NEGATIVE_INFINITY,
        3,
        3,
        0,
        1,
        1,
    ]);
    output_case(
        "nonfinite constexpr globals, inferred locals, aggregate initialization, references, templates and sequenced effects",
        include_str!("../../../../../naga/tests/in/cuda/nonfinite-constants.cu"),
        &expected,
    )
}

fn typed_copies() -> ShaderTest {
    let input = [
        0x0000_0000_u32,
        0x8000_0000,
        POSITIVE_INFINITY,
        NEGATIVE_INFINITY,
        QUIET_NAN,
        QUIET_NAN | 0x8000_0000,
        0x7fc1_2345,
        0xffc1_2345,
        0x3f80_0000,
        0xbf80_0000,
        0x0000_0001,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x3f00_0000,
        0xbf00_0000,
    ];
    let mut expected = [SENTINEL; 64];
    for (index, input_bits) in input.into_iter().enumerate() {
        expected[index * 2] = input_bits;
        expected[index * 2 + 1] = POSITIVE_INFINITY;
    }
    module_case(
        "nonfinite constexpr values copy alongside typed float storage through record fields and local references",
        "constexpr float Positive = 1.0f / 0.0f;
        struct Pair { float input_value; float constant_value; };
        __global__ void copies(const float *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 20u) return;
            Pair value{input[index], Positive};
            const float &view = value.input_value;
            output[index * 2u] = __float_as_uint(view);
            output[index * 2u + 1u] = __float_as_uint(value.constant_value);
        }",
        [8, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 64]),
        ],
        1,
        [3, 1, 1],
    )
}

fn output_case(name: &str, source: &str, expected: &[u32; 64]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 64],
        )],
        0,
        [1, 1, 1],
    )
}
