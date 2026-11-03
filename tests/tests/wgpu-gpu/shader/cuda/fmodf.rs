use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const CANONICAL_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        runtime_value(),
        exact_results(),
        conversions_and_effects(),
        float_buffer_results(),
    ]
}

fn runtime_value() -> ShaderTest {
    let input = [5.5_f32.to_bits(), 2.0_f32.to_bits()];
    let expected = [1.5_f32.to_bits(), SENTINEL, SENTINEL, SENTINEL];
    module_case(
        "fmodf computes the remainder of runtime operands",
        "__global__ void remainders(const unsigned *input, unsigned *output) {
            output[0] = __float_as_uint(fmodf(__uint_as_float(input[0]), __uint_as_float(input[1])));
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
    if numerator_magnitude >= 0x7f80_0000
        || denominator_magnitude > 0x7f80_0000
        || denominator_magnitude == 0
    {
        CANONICAL_NAN
    } else if numerator_magnitude == 0 || denominator_magnitude == 0x7f80_0000 {
        numerator_bits
    } else {
        let numerator = f64::from(f32::from_bits(numerator_bits));
        let denominator = f64::from(f32::from_bits(denominator_bits));
        ((numerator % denominator) as f32).to_bits()
    }
}

fn input_pairs() -> Vec<[u32; 2]> {
    let mut pairs = Vec::new();
    for numerator in super::floorf::input_bits() {
        for denominator in [
            0x0000_0001,
            0x0000_0003,
            0x007f_ffff,
            0x0080_0000,
            0x3f00_0001,
            0x4000_0000,
            0x4040_0000,
            0x4204_0000,
            0x7f7f_ffff,
        ] {
            pairs.push([numerator, denominator]);
            pairs.push([numerator, denominator ^ 0x8000_0000]);
        }
    }
    let special = [
        0x0000_0000,
        0x8000_0000,
        0x0000_0001,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x3f80_0000,
        0xbf80_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
        0xff80_0001,
        0x7fc1_2345,
        0xffc1_2345,
    ];
    for numerator in special {
        for denominator in special {
            pairs.push([numerator, denominator]);
        }
    }
    for exponent in 0..255_u32 {
        let denominator = (exponent << 23) | 0x0040_0001;
        for numerator in [denominator - 1, denominator, denominator + 1] {
            for numerator_sign in [0, 0x8000_0000] {
                for denominator_sign in [0, 0x8000_0000] {
                    pairs.push([numerator | numerator_sign, denominator | denominator_sign]);
                }
            }
        }
    }
    for denominator in [0.5_f32, 1.5, 3.0, 12.0, 33.0, 16777215.0] {
        for quotient in [1.0_f32, 2.0, 3.0, 127.0, 65535.0, 1048576.0] {
            let center = (denominator * quotient).to_bits();
            for numerator in [center - 1, center, center + 1] {
                for numerator_sign in [0, 0x8000_0000] {
                    for denominator_sign in [0, 0x8000_0000] {
                        pairs.push([
                            numerator | numerator_sign,
                            denominator.to_bits() | denominator_sign,
                        ]);
                    }
                }
            }
        }
    }
    let mut state = 0x4571_9ab3_u32;
    for _ in 0..1024 {
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        let numerator = state;
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        pairs.push([numerator, state]);
    }
    pairs.sort_unstable();
    pairs.dedup();
    pairs
}

fn exact_results() -> ShaderTest {
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
        "__global__ void remainders(const unsigned *input, unsigned *output) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= {count}u) return;
            output[index] = __float_as_uint(fmodf(__uint_as_float(input[index * 2u]),
                __uint_as_float(input[index * 2u + 1u])));
        }}"
    );
    module_case(
        "fmodf exact signed remainders across exponent bands, neighboring multiples, subnormals and exceptional classes",
        &source,
        [64, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL; output_len]),
        ],
        1,
        [dispatch_count, 1, 1],
    )
}

fn conversions_and_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 80];
    expected[..62].copy_from_slice(&[
        1.5_f32.to_bits(),
        (-1.5_f32).to_bits(),
        1.5_f32.to_bits(),
        (-1.5_f32).to_bits(),
        0,
        0x8000_0000,
        0,
        0x8000_0000,
        1.0_f32.to_bits(),
        0,
        0,
        0x8000_0000,
        2,
        1,
        1,
        0x3400_0000,
        1.0_f32.to_bits(),
        CANONICAL_NAN,
        CANONICAL_NAN,
        CANONICAL_NAN,
        CANONICAL_NAN,
        CANONICAL_NAN,
        CANONICAL_NAN,
        5.5_f32.to_bits(),
        (-5.5_f32).to_bits(),
        1.0_f32.to_bits(),
        1.0_f32.to_bits(),
        0,
        0,
        7,
        9,
        6.0_f32.to_bits(),
        1.5_f32.to_bits(),
        6.5_f32.to_bits(),
        1.0_f32.to_bits(),
        3.0_f32.to_bits(),
        5.5_f32.to_bits(),
        7.5_f32.to_bits(),
        1.5_f32.to_bits(),
        8.5_f32.to_bits(),
        0,
        1,
        8.5_f32.to_bits(),
        0.5_f32.to_bits(),
        10.5_f32.to_bits(),
        1.5_f32.to_bits(),
        11.5_f32.to_bits(),
        1.5_f32.to_bits(),
        12.5_f32.to_bits(),
        1,
        13.5_f32.to_bits(),
        1.0_f32.to_bits(),
        (-2.0_f32).to_bits(),
        0,
        0x8000_0000,
        CANONICAL_NAN,
        1.25_f32.to_bits(),
        0,
        0.5_f32.to_bits(),
        0x8000_0000,
        1,
        2,
    ]);
    module_case(
        "fmodf aliases, prototype, scalar conversions, overloads, argument snapshots, selected branches, comma and continue",
        include_str!("../../../../../naga/tests/in/cuda/fmodf.cu"),
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 80],
        )],
        0,
        [1, 1, 1],
    )
}

fn float_buffer_results() -> ShaderTest {
    let pairs = [
        [5.5_f32.to_bits(), 2.0_f32.to_bits()],
        [(-5.5_f32).to_bits(), 2.0_f32.to_bits()],
        [5.5_f32.to_bits(), (-2.0_f32).to_bits()],
        [(-5.5_f32).to_bits(), (-2.0_f32).to_bits()],
        [0x7f7f_ffff, 1],
        [0xff7f_ffff, 3],
        [0x0080_0000, 3],
        [1, 0x0080_0000],
        [0x007f_ffff, 0x0080_0000],
        [0, 0xc000_0000],
        [0x8000_0000, 0x4000_0000],
        [0x3f80_0000, 0x7f80_0000],
        [0xbf80_0000, 0xff80_0000],
        [0x7f80_0000, 0x4000_0000],
        [0xff80_0000, 0xc000_0000],
        [0, 0],
        [0x3f80_0000, 0],
        [0x7fc1_2345, 0x4000_0000],
        [0x3f80_0000, 0x7fc1_2345],
        [0xffc1_2345, 0x4000_0000],
        [0x0080_0001, 0x007f_ffff],
        [0x3f80_0001, 0x3f80_0000],
        [0x3f80_0000, 0x3f80_0001],
        [1, 0xff80_0000],
    ];
    let mut input = vec![0x0123_4567_u32; 64];
    let mut expected = [SENTINEL; 64];
    for (index, &[numerator, denominator]) in pairs.iter().enumerate() {
        input[index * 2] = numerator;
        input[index * 2 + 1] = denominator;
        expected[index * 2] = expected_bits(numerator, denominator);
        expected[index * 2 + 1] = expected_bits(numerator, denominator);
    }
    module_case(
        "fmodf typed float buffer loads, const scalar references and mutable vector references",
        "__device__ float vector_remainder(float2 &operands) {
            return fmodf(operands.x, operands.y);
        }
        __global__ void remainders(const float *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 24u) return;
            const float &numerator = input[index * 2u];
            const float &denominator = input[index * 2u + 1u];
            output[index * 2u] = __float_as_uint(fmodf(numerator, denominator));
            float2 operands = make_float2(numerator, denominator);
            output[index * 2u + 1u] = __float_as_uint(vector_remainder(operands));
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
                &[SENTINEL; 64],
            ),
        ],
        1,
        [4, 1, 1],
    )
}
