use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const CANONICAL_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        finite_results(),
        special_results(),
        tiny_exact_results(),
        conversions_and_side_effects(),
        paired_output_effects(),
    ]
}

fn ordered_bits(bits: u32) -> u32 {
    if bits & 0x8000_0000 != 0 {
        !bits
    } else {
        bits | 0x8000_0000
    }
}

fn finite_comparison(name: &str, actual: &[u32], expected: &[Vec<u32>]) -> bool {
    let [expected] = expected else {
        panic!("{name}: expected one reference buffer")
    };
    if actual.len() != expected.len() {
        eprintln!(
            "{name}: output length {}, expected {}",
            actual.len(),
            expected.len()
        );
        return false;
    }
    for (index, (&actual, &expected)) in actual.iter().zip(expected).enumerate() {
        let valid = if expected == SENTINEL || expected & 0x7fff_ffff == 0 {
            actual == expected
        } else {
            actual & 0x7fff_ffff < 0x7f80_0000
                && ordered_bits(actual).abs_diff(ordered_bits(expected)) <= 2
        };
        if !valid {
            eprintln!("{name}: word {index}: received {actual:08x}, expected {expected:08x} within 2 ULP for finite nonzero results");
            return false;
        }
    }
    true
}

fn special_comparison(name: &str, actual: &[u32], expected: &[Vec<u32>]) -> bool {
    let [expected] = expected else {
        panic!("{name}: expected one reference buffer")
    };
    if actual.len() != expected.len() {
        eprintln!(
            "{name}: output length {}, expected {}",
            actual.len(),
            expected.len()
        );
        return false;
    }
    for (index, (&actual, &expected)) in actual.iter().zip(expected).enumerate() {
        let valid = if expected == CANONICAL_NAN {
            actual & 0x7fc0_0000 == 0x7fc0_0000
        } else {
            actual == expected
        };
        if !valid {
            eprintln!(
                "{name}: word {index}: received {actual:08x}, expected class/bits {expected:08x}"
            );
            return false;
        }
    }
    true
}

fn finite_results() -> ShaderTest {
    let mut inputs = Vec::new();
    let mut expected = Vec::new();
    let mut exponent_bands = [[false; 255]; 2];
    for (line_index, line) in include_str!("trigonometry-values.csv").lines().enumerate() {
        let line = line.split('#').next().unwrap().trim();
        if line.is_empty() {
            continue;
        }
        let words: Vec<u32> = line
            .split(|character: char| character == ',' || character.is_ascii_whitespace())
            .filter(|word| !word.is_empty())
            .map(|word| u32::from_str_radix(word.trim_start_matches("0x"), 16).unwrap())
            .collect();
        let [input, sine, cosine] = words[..] else {
            panic!(
                "trigonometry reference line {} must contain three hexadecimal words",
                line_index + 1
            )
        };
        assert!(input & 0x7fff_ffff < 0x7f80_0000);
        assert!(sine & 0x7fff_ffff <= 0x3f80_0000);
        assert!(cosine & 0x7fff_ffff <= 0x3f80_0000);
        exponent_bands[(input >> 31) as usize][((input >> 23) & 0xff) as usize] = true;
        inputs.push(input);
        expected.extend_from_slice(&[
            sine,
            cosine,
            if sine & 0x7fff_ffff < 0x0080_0000 {
                sine & 0x8000_0000
            } else {
                sine
            },
            cosine,
            sine,
            cosine,
        ]);
    }
    assert_eq!(inputs.len(), 3072);
    assert!(exponent_bands.iter().flatten().all(|&covered| covered));
    let count = u32::try_from(inputs.len()).unwrap();
    inputs.extend_from_slice(&[0x0123_4567; 16]);
    expected.extend_from_slice(&[SENTINEL; 16]);
    let initial = vec![SENTINEL; expected.len()];
    let source = format!(
        "__global__ void trigonometry(const unsigned *input, unsigned *out) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= {count}u) return;
            float value = __uint_as_float(input[index]);
            out[6u * index] = __float_as_uint(sinf(value));
            out[6u * index + 1u] = __float_as_uint(cosf(value));
            out[6u * index + 2u] = __float_as_uint(__sinf(value));
            out[6u * index + 3u] = __float_as_uint(__cosf(value));
            float sine; float cosine;
            sincosf(value, &sine, &cosine);
            out[6u * index + 4u] = __float_as_uint(sine);
            out[6u * index + 5u] = __float_as_uint(cosine);
        }}"
    );
    let mut test = module_case(
        "sinf and cosf independent MPFR results across both signs, all finite exponent bands and reduction boundaries",
        &source,
        [64, 1, 1],
        &expected,
    ).module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &inputs),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &initial),
        ],
        1,
        [count.div_ceil(64), 1, 1],
    );
    test.output_comparison_fn = finite_comparison;
    test
}

fn special_results() -> ShaderTest {
    let inputs = [
        0x0000_0000_u32,
        0x8000_0000,
        0x0000_0001,
        0x8000_0001,
        0x0000_0002,
        0x8000_0002,
        0x003f_ffff,
        0x803f_ffff,
        0x0040_0000,
        0x8040_0000,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
        0xff80_0001,
        0x7fbf_ffff,
        0xffbf_ffff,
        0x7fc0_0000,
        0xffc0_0000,
        0x7fc1_2345,
        0xffc1_2345,
        0x7fff_ffff,
        0xffff_ffff,
    ];
    let mut expected = Vec::new();
    for &input in &inputs {
        if input & 0x7fff_ffff >= 0x7f80_0000 {
            expected.extend_from_slice(&[CANONICAL_NAN; 6]);
        } else {
            expected.extend_from_slice(&[
                input,
                1.0_f32.to_bits(),
                if input & 0x7fff_ffff < 0x0080_0000 {
                    input & 0x8000_0000
                } else {
                    input
                },
                1.0_f32.to_bits(),
                input,
                1.0_f32.to_bits(),
            ]);
        }
    }
    expected.extend_from_slice(&[SENTINEL; 16]);
    let initial = vec![SENTINEL; expected.len()];
    let mut test = module_case(
        "sinf and cosf signed zeros, subnormal bit preservation and quiet NaN classes",
        "__global__ void trigonometry(const unsigned *input, unsigned *out) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 26u) return;
            float value = __uint_as_float(input[index]);
            out[6u * index] = __float_as_uint(sinf(value));
            out[6u * index + 1u] = __float_as_uint(cosf(value));
            out[6u * index + 2u] = __float_as_uint(__sinf(value));
            out[6u * index + 3u] = __float_as_uint(__cosf(value));
            float sine; float cosine;
            sincosf(value, &sine, &cosine);
            out[6u * index + 4u] = __float_as_uint(sine);
            out[6u * index + 5u] = __float_as_uint(cosine);
        }",
        [32, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &inputs,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
        ],
        1,
        [1, 1, 1],
    );
    test.output_comparison_fn = special_comparison;
    test
}

fn conversions_and_side_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 40];
    expected[..29].copy_from_slice(&[
        0x0000_0000,
        0x8000_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x0000_0000,
        0x3f80_0000,
        17,
        19,
        27,
        0x3f80_0000,
        0x40a0_0000,
        0x40a0_0000,
        0x0000_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x0000_0000,
        0x3f80_0000,
        0x4000_0000,
        0,
        1,
        1,
        0,
        0x3f80_0000,
        0,
        2,
        0x3f80_0000,
        0,
        1,
        0x3f80_0000,
    ]);
    expected[29..37].copy_from_slice(&[
        0,
        0x8000_0000,
        0,
        0x8000_0000,
        0x3f80_0000,
        0,
        0x3f80_0000,
        0x3f80_0000,
    ]);
    module_case(
        "sinf and cosf aliases, conversions, overloads, sequenced calls, selected branches, pending arrays and loop updates",
        include_str!("../../../../../naga/tests/in/cuda/trigonometry.cu"),
        [1, 1, 1],
        &expected,
    ).module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 40])],
        0,
        [1, 1, 1],
    )
}

fn tiny_exact_results() -> ShaderTest {
    const INPUT: [u32; 10] = [
        0,
        0x8000_0000,
        1,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x3900_0000,
        0xb900_0000,
    ];
    let mut expected = [SENTINEL; 188];
    for (index, bits) in INPUT.into_iter().enumerate() {
        expected[4 + index * 18..22 + index * 18].copy_from_slice(&[
            bits,
            0x3f80_0000,
            bits,
            0x3f80_0000,
            0,
            0x8000_0000,
            0x3f80_0000,
            0x3f80_0000,
            bits,
            0x3f80_0000,
            1,
            2,
            if bits & 0x7fff_ffff < 0x0080_0000 {
                bits & 0x8000_0000
            } else {
                bits
            },
            0x3f80_0000,
            if bits & 0x7fff_ffff < 0x0080_0000 {
                bits & 0x8000_0000
            } else {
                bits
            },
            1,
            0x3f80_0000,
            2,
        ]);
    }
    module_case(
        "tiny sinf and cosf preserve exact signed bits through direct wrapper literal and sequenced paths",
        "__device__ float sine_value(float value) { return sinf(value); }
        __device__ float cosine_value(float value) { return cosf(value); }
        __global__ void tiny_trig(const unsigned *input, unsigned *output) {
            unsigned index = threadIdx.x;
            unsigned bits = input[index];
            unsigned base = 4u + index * 18u;
            output[base] = __float_as_uint(sinf(__uint_as_float(bits)));
            output[base + 1u] = __float_as_uint(cosf(__uint_as_float(bits)));
            output[base + 2u] = __float_as_uint(sine_value(__uint_as_float(bits)));
            output[base + 3u] = __float_as_uint(cosine_value(__uint_as_float(bits)));
            output[base + 4u] = __float_as_uint(sinf(0.0f));
            output[base + 5u] = __float_as_uint(sinf(-0.0f));
            output[base + 6u] = __float_as_uint(cosf(0.0f));
            output[base + 7u] = __float_as_uint(cosf(-0.0f));
            int cursor = 0;
            output[base + 8u] = __float_as_uint(sine_value(__uint_as_float(input[index + unsigned(cursor++)])));
            output[base + 9u] = __float_as_uint(cosine_value(float(cursor++ - 1)));
            output[base + 10u] = unsigned(cursor - 1);
            output[base + 11u] = unsigned(cursor);
            output[base + 12u] = __float_as_uint(__sinf(__uint_as_float(bits)));
            output[base + 13u] = __float_as_uint(__cosf(__uint_as_float(bits)));
            cursor = 0;
            output[base + 14u] = __float_as_uint(__sinf(__uint_as_float(input[index + unsigned(cursor++)])));
            output[base + 15u] = unsigned(cursor);
            output[base + 16u] = __float_as_uint(__cosf(float(cursor++ - 1)));
            output[base + 17u] = unsigned(cursor);
        }",
        [10, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 188]),
    ], 1, [1, 1, 1])
}

fn paired_output_effects() -> ShaderTest {
    const INPUT: [u32; 4] = [0, 0x8000_0000, 1, 0x8000_0001];
    let mut expected = [SENTINEL; 40];
    for (lane, bits) in INPUT.into_iter().enumerate() {
        let base = 4 + lane * 8;
        expected[base..base + 8].copy_from_slice(&[
            bits,
            0x3f80_0000,
            bits,
            0x3f80_0000,
            ((base + 4) as f32).to_bits(),
            0x3f80_0000,
            0x3f80_0000,
            0x3f80_0000,
        ]);
    }
    module_case(
        "sincosf writes local and storage outputs with once-only input and pointer effects",
        include_str!("../../../../../naga/tests/in/cuda/sincosf.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &INPUT,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 40],
            ),
        ],
        1,
        [1, 1, 1],
    )
}
