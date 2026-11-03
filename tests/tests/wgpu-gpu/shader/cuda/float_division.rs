use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const CANONICAL_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        runtime_boundary(),
        rounded_results(),
        conversions_and_effects(),
        float_buffer_results(),
    ]
}

fn runtime_boundary() -> ShaderTest {
    let input = [0xc1ef_ffff_u32, 12.0_f32.to_bits()];
    let expected = [0xc01f_ffff_u32, SENTINEL, SENTINEL, SENTINEL];
    module_case(
        "float division rounds a runtime negative halfinteger neighbor to nearest even",
        "__global__ void quotients(const unsigned *input, unsigned *output) {
            output[0] = __float_as_uint(__uint_as_float(input[0]) / __uint_as_float(input[1]));
        }",
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 4],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn expected_bits(numerator_bits: u32, denominator_bits: u32) -> u32 {
    let numerator_magnitude = numerator_bits & 0x7fff_ffff;
    let denominator_magnitude = denominator_bits & 0x7fff_ffff;
    let sign = (numerator_bits ^ denominator_bits) & 0x8000_0000;
    if numerator_magnitude > 0x7f80_0000
        || denominator_magnitude > 0x7f80_0000
        || (numerator_magnitude == 0 && denominator_magnitude == 0)
        || (numerator_magnitude == 0x7f80_0000 && denominator_magnitude == 0x7f80_0000)
    {
        CANONICAL_NAN
    } else if numerator_magnitude == 0x7f80_0000 || denominator_magnitude == 0 {
        sign | 0x7f80_0000
    } else if numerator_magnitude == 0 || denominator_magnitude == 0x7f80_0000 {
        sign
    } else {
        let numerator = f64::from(f32::from_bits(numerator_bits));
        let denominator = f64::from(f32::from_bits(denominator_bits));
        ((numerator / denominator) as f32).to_bits()
    }
}

fn input_pairs() -> Vec<[u32; 2]> {
    let mut pairs = Vec::new();
    for bits in super::floorf::input_bits() {
        for divisor in [
            0x3f00_0000,
            0x3f80_0000,
            0x4000_0000,
            0x4040_0000,
            0x4140_0000,
            0x4204_0000,
            0x0080_0000,
            0x0000_0001,
            0x7f7f_ffff,
        ] {
            pairs.push([bits, divisor]);
            pairs.push([divisor, bits]);
            pairs.push([bits ^ 0x8000_0000, divisor ^ 0x8000_0000]);
        }
    }
    let special = [
        0x0000_0000,
        0x8000_0000,
        0x3f80_0000,
        0xbf80_0000,
        0x7f80_0000,
        0xff80_0000,
        0x7fc1_2345,
        0xffc1_2345,
        0x7f80_0001,
        0xff80_0001,
        0x0000_0001,
        0x8000_0001,
        0x0080_0000,
        0x8080_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
    ];
    for numerator in special {
        for denominator in special {
            pairs.push([numerator, denominator]);
        }
    }
    for [numerator, denominator] in [
        [0xc1ef_ffff, 0x4140_0000],
        [1, 0x4000_0000],
        [2, 0x4000_0000],
        [3, 0x4000_0000],
        [5, 0x4000_0000],
        [7, 0x4000_0000],
        [0x007f_ffff, 0x4000_0000],
        [0x0080_0000, 0x4000_0000],
        [0x0080_0001, 0x4000_0000],
        [0x00ff_ffff, 0x4000_0000],
        [0x0100_0001, 0x4000_0000],
        [0x7f7f_ffff, 0x3f7f_ffff],
        [0x7f7f_ffff, 0x3f80_0001],
        [0x0080_0000, 0x7f7f_ffff],
        [0x7f7f_ffff, 0x0080_0000],
        [0x0000_0001, 0x007f_ffff],
        [0x007f_ffff, 0x0000_0001],
        [0x0000_0001, 0x3f00_0001],
        [0x007f_ffff, 0x3f00_0001],
    ] {
        for numerator_sign in [0, 0x8000_0000] {
            for denominator_sign in [0, 0x8000_0000] {
                pairs.push([numerator ^ numerator_sign, denominator ^ denominator_sign]);
            }
        }
    }
    let mut state = 0x6471_5293_u32;
    for _ in 0..1024 {
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        let numerator = state;
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        pairs.push([numerator, state]);
    }
    pairs
}

fn rounded_results() -> ShaderTest {
    let pairs = input_pairs();
    let count = pairs.len();
    let dispatch_count = (count as u32).div_ceil(64);
    let output_len = dispatch_count as usize * 64 + 64;
    let mut input = vec![0x0123_4567_u32; count * 2 + 64];
    let mut expected = vec![SENTINEL; output_len];
    for (index, &[numerator, denominator]) in pairs.iter().enumerate() {
        input[index * 2] = numerator;
        input[index * 2 + 1] = denominator;
        expected[index] = expected_bits(numerator, denominator);
    }
    let source = format!(
        "__global__ void quotients(const unsigned *input, unsigned *output) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= {count}u) return;
            output[index] = __float_as_uint(__uint_as_float(input[index * 2u])
                                           / __uint_as_float(input[index * 2u + 1u]));
        }}"
    );
    module_case(
        "float division rounds runtime operand pairs across all exponent bands, subnormal ties, overflow and exceptional classes",
        &source,
        [64, 1, 1],
        &expected,
    ).module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL; output_len]),
        ],
        1,
        [dispatch_count, 1, 1],
    )
}

fn conversions_and_effects() -> ShaderTest {
    let numerator = 0xc1ef_ffff_u32;
    let denominator = 12.0_f32.to_bits();
    let quotient = expected_bits(numerator, denominator);
    let mut expected = [SENTINEL; 64];
    expected[..4].copy_from_slice(&[
        quotient,
        quotient,
        expected_bits(numerator, 3.0_f32.to_bits()),
        expected_bits(3.0_f32.to_bits(), numerator),
    ]);
    let values = [numerator, 1.0_f32.to_bits(), 0x8000_0000, 0x7f80_0000];
    let divisors = [
        denominator,
        3.0_f32.to_bits(),
        3.0_f32.to_bits(),
        2.0_f32.to_bits(),
    ];
    for index in 0..4 {
        expected[4 + index] = expected_bits(values[index], divisors[index]);
        expected[8 + index] = expected_bits(values[index], 3.0_f32.to_bits());
        expected[12 + index] = expected_bits(3.0_f32.to_bits(), divisors[index]);
        expected[16 + index] = expected[4 + index];
        expected[20 + index] = expected[8 + index];
    }
    let next_numerator = (f32::from_bits(numerator) + 1.0).to_bits();
    expected[24..61].copy_from_slice(&[
        quotient,
        quotient,
        quotient,
        quotient,
        1,
        13.0_f32.to_bits(),
        7.0_f32.to_bits(),
        (-2_i32) as u32,
        0x5555_5555,
        5.0_f32.to_bits(),
        5.0_f32.to_bits(),
        5.0_f32.to_bits(),
        expected_bits(1.0_f32.to_bits(), 3.0_f32.to_bits()),
        expected_bits(2.0_f32.to_bits(), 3.0_f32.to_bits()),
        3.0_f32.to_bits(),
        4.0_f32.to_bits(),
        quotient,
        next_numerator,
        13.0_f32.to_bits(),
        0,
        next_numerator,
        1,
        13.0_f32.to_bits(),
        1.0_f32.to_bits(),
        1.0_f32.to_bits(),
        4.0_f32.to_bits(),
        expected_bits(2.0_f32.to_bits(), 3.0_f32.to_bits()),
        3.0_f32.to_bits(),
        4.0_f32.to_bits(),
        expected_bits(quotient, 3.0_f32.to_bits()),
        1.0_f32.to_bits(),
        4.0_f32.to_bits(),
        numerator,
        expected_bits(4294967296.0_f32.to_bits(), denominator),
        0xff80_0000,
        CANONICAL_NAN,
        CANONICAL_NAN,
    ]);
    module_case(
        "float division preserves mixed conversions, scalar and vector operators, assignments, snapshots and lazy control flow",
        include_str!("../../../../../naga/tests/in/cuda/float-division.cu"),
        [1, 1, 1],
        &expected,
    ).module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &[numerator, denominator, 0, 0x7f80_0000]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 64]),
        ],
        1,
        [1, 1, 1],
    )
}

fn float_buffer_results() -> ShaderTest {
    let pairs = [
        [0xc1ef_ffff, 0x4140_0000],
        [0x0000_0001, 0x4000_0000],
        [0x0000_0003, 0x4000_0000],
        [0x0080_0000, 0x4000_0000],
        [0x0000_0001, 0xc000_0000],
        [0x0000_0000, 0x4040_0000],
        [0x8000_0000, 0x4040_0000],
        [0x0000_0000, 0xc040_0000],
        [0x8000_0000, 0xc040_0000],
        [0x7f80_0000, 0x4040_0000],
        [0xff80_0000, 0xc040_0000],
        [0x4040_0000, 0x7f80_0000],
        [0xc040_0000, 0x7f80_0000],
        [0x0000_0000, 0x0000_0000],
        [0x7f80_0000, 0x7f80_0000],
        [0x7fc1_2345, 0x4040_0000],
        [0x4040_0000, 0xff80_0001],
        [0x7f7f_ffff, 0x3f00_0000],
        [0x7f7f_ffff, 0x3f80_0001],
        [0x3f80_0000, 0x4040_0000],
        [0x3f80_0000, 0x0000_0000],
        [0x00ff_ffff, 0x4000_0000],
    ];
    let mut input = Vec::new();
    let mut expected = [SENTINEL; 32];
    for (index, [numerator, denominator]) in pairs.into_iter().enumerate() {
        input.extend([numerator, denominator]);
        expected[index] = expected_bits(numerator, denominator);
    }
    module_case(
        "float division classifies typed float storage loads, subnormal ties and exceptional values",
        "__global__ void quotients(const float *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 22u) return;
            output[index] = __float_as_uint(input[index * 2u] / input[index * 2u + 1u]);
        }",
        [8, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 32],
            ),
        ],
        1,
        [4, 1, 1],
    )
}
