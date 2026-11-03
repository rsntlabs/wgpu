use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const CANONICAL_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        rounded_results(),
        conversions_and_overloads(),
        selected_calls(),
    ]
}

fn expected_bits(input_bits: u32) -> u32 {
    let magnitude = input_bits & 0x7fff_ffff;
    if magnitude == 0 || magnitude == 0x7f80_0000 {
        input_bits
    } else if magnitude > 0x7f80_0000 {
        CANONICAL_NAN
    } else {
        (f64::from(f32::from_bits(input_bits)).round() as f32).to_bits()
    }
}

fn input_bits() -> Vec<u32> {
    let mut inputs = super::floorf::input_bits();
    let mut add_neighbors = |value: f32| {
        let center = value.to_bits();
        for bits in [center - 1, center, center + 1] {
            for sign in [0, 0x8000_0000] {
                let input = bits | sign;
                if !inputs.contains(&input) {
                    inputs.push(input);
                }
            }
        }
    };
    add_neighbors(0.5);
    for exponent in 0..23 {
        let lower = 1_u32 << exponent;
        let upper = lower * 2;
        add_neighbors(lower as f32 + 0.5);
        add_neighbors((lower + lower / 2) as f32 + 0.5);
        add_neighbors(upper as f32 - 0.5);
    }
    for exponent in 0..25 {
        add_neighbors((1_u32 << exponent) as f32);
    }
    inputs
}

fn rounded_results() -> ShaderTest {
    let inputs = input_bits();
    let count = inputs.len();
    let dispatch_count = (count as u32).div_ceil(64);
    let buffer_len = dispatch_count as usize * 64 + 64;
    let mut input_buffer = vec![0x0123_4567_u32; buffer_len];
    input_buffer[..count].copy_from_slice(&inputs);
    let mut expected = vec![SENTINEL; buffer_len];
    for (output, &input) in expected.iter_mut().zip(&inputs) {
        *output = expected_bits(input);
    }
    let source = format!(
        "__global__ void rounds(const unsigned *input, unsigned *output) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= {count}u) return;
            output[index] = __float_as_uint(roundf(__uint_as_float(input[index])));
        }}"
    );
    module_case(
        "roundf both signs, all exponent bands, halfinteger ties and neighbors, subnormals and exceptional classes",
        &source,
        [64, 1, 1],
        &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input_buffer),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL; buffer_len]),
    ], 1, [dispatch_count, 1, 1])
}

fn conversions_and_overloads() -> ShaderTest {
    let mut expected = [SENTINEL; 64];
    expected[..41].copy_from_slice(&[
        0,
        0x8000_0000,
        1.0_f32.to_bits(),
        (-2.0_f32).to_bits(),
        3.0_f32.to_bits(),
        5.0_f32.to_bits(),
        7,
        9,
        1.0_f32.to_bits(),
        0,
        0,
        0x8000_0000,
        0,
        0x8000_0000,
        0x8000_0000,
        0x4b00_0000,
        0xcb00_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        CANONICAL_NAN,
        CANONICAL_NAN,
        2.0_f32.to_bits(),
        3.25_f32.to_bits(),
        5.0_f32.to_bits(),
        0x4f80_0000,
        0xcf00_0000,
        0x5015_02f9,
        2.0_f32.to_bits(),
        (-2.0_f32).to_bits(),
        3.0_f32.to_bits(),
        (-3.0_f32).to_bits(),
        0,
        1.0_f32.to_bits(),
        0x8000_0000,
        (-1.0_f32).to_bits(),
        4194305.0_f32.to_bits(),
        (-4194305.0_f32).to_bits(),
        8388607.0_f32.to_bits(),
        (-8388607.0_f32).to_bits(),
    ]);
    output_case(
        "roundf scalar conversions, aliases, overloads, exceptional literals and one argument update",
        include_str!("../../../../../naga/tests/in/cuda/roundf.cu"), &expected,
    )
}

fn selected_calls() -> ShaderTest {
    let mut expected = [SENTINEL; 64];
    expected[..18].copy_from_slice(&[
        (-1.0_f32).to_bits(),
        (-0.25_f32).to_bits(),
        0x8000_0000,
        0.75_f32.to_bits(),
        1.0_f32.to_bits(),
        2.0_f32.to_bits(),
        2.75_f32.to_bits(),
        0,
        1,
        2.75_f32.to_bits(),
        33.75_f32.to_bits(),
        4.75_f32.to_bits(),
        1.0_f32.to_bits(),
        1.75_f32.to_bits(),
        2.0_f32.to_bits(),
        2.75_f32.to_bits(),
        1,
        3.75_f32.to_bits(),
    ]);
    output_case(
        "roundf snapshots reference helpers and arguments once across selected calls, comma and continue",
        "__device__ float take_next(float &value) { return roundf(value++); }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void effects(unsigned *output) {
            float value = -1.25f;
            output[0] = __float_as_uint(roundf(value++));
            output[1] = __float_as_uint(value);
            output[2] = __float_as_uint(roundf(take_next(value)));
            output[3] = __float_as_uint(value);
            bool choose = true;
            output[4] = __float_as_uint(choose ? roundf(value++) : roundf(value++));
            choose = false;
            output[5] = __float_as_uint(choose ? roundf(value++) : roundf(value++));
            output[6] = __float_as_uint(value);
            bool run = false;
            output[7] = unsigned(run && roundf(value++));
            run = true;
            output[8] = unsigned(run || roundf(value++));
            output[9] = __float_as_uint(value);
            output[10] = __float_as_uint(pair(roundf(value++), value++));
            output[11] = __float_as_uint(value);
            value = -0.25f;
            output[12] = __float_as_uint((roundf(value++), roundf(value++)));
            output[13] = __float_as_uint(value);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[14] = __float_as_uint(roundf(value++));
            }
            output[15] = __float_as_uint(value);
            output[16] = unsigned(run && roundf(value++));
            output[17] = __float_as_uint(value);
        }",
        &expected,
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
