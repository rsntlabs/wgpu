use super::{floorf::input_bits, module_case, ShaderBuffer, ShaderTest};

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
    } else if input_bits & 0x8000_0000 != 0 && magnitude < 0x3f80_0000 {
        0x8000_0000
    } else {
        (f64::from(f32::from_bits(input_bits)).ceil() as f32).to_bits()
    }
}

fn rounded_results() -> ShaderTest {
    let inputs = input_bits();
    assert_eq!(inputs.len(), 3037);
    let mut input_buffer = [0x0123_4567_u32; 4096];
    input_buffer[..inputs.len()].copy_from_slice(&inputs);
    let mut expected = [SENTINEL; 4096];
    for (output, &input) in expected.iter_mut().zip(&inputs) {
        *output = expected_bits(input);
    }
    module_case(
        "ceilf both signs and all exponent bands, integer boundaries, subnormals and exceptional classes",
        "__global__ void ceilings(const unsigned *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 3037u) return;
            output[index] = __float_as_uint(ceilf(__uint_as_float(input[index])));
        }",
        [64, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input_buffer),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 4096]),
    ], 1, [64, 1, 1])
}

fn conversions_and_overloads() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..29].copy_from_slice(&[
        0,
        0x8000_0000,
        2.0_f32.to_bits(),
        (-1.0_f32).to_bits(),
        3.0_f32.to_bits(),
        5.0_f32.to_bits(),
        7,
        9,
        1.0_f32.to_bits(),
        0,
        1.0_f32.to_bits(),
        0x8000_0000,
        1.0_f32.to_bits(),
        0x8000_0000,
        0x8000_0000,
        0x4b00_0000,
        0xcaff_fffe,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        CANONICAL_NAN,
        CANONICAL_NAN,
        3.0_f32.to_bits(),
        3.25_f32.to_bits(),
        5.0_f32.to_bits(),
        0x4f80_0000,
        0xcf00_0000,
        0x5015_02f9,
    ]);
    output_case(
        "ceilf scalar conversions, aliases, overloads, exceptional literals and one argument update",
        include_str!("../../../../../naga/tests/in/cuda/ceilf.cu"), &expected,
    )
}

fn selected_calls() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
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
        "ceilf snapshots reference helpers and arguments once across selected calls, comma and continue",
        "__device__ float take_next(float &value) { return ceilf(value++); }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void effects(unsigned *output) {
            float value = -1.25f;
            output[0] = __float_as_uint(ceilf(value++));
            output[1] = __float_as_uint(value);
            output[2] = __float_as_uint(ceilf(take_next(value)));
            output[3] = __float_as_uint(value);
            bool choose = true;
            output[4] = __float_as_uint(choose ? ceilf(value++) : ceilf(value++));
            choose = false;
            output[5] = __float_as_uint(choose ? ceilf(value++) : ceilf(value++));
            output[6] = __float_as_uint(value);
            bool run = false;
            output[7] = unsigned(run && ceilf(value++));
            run = true;
            output[8] = unsigned(run || ceilf(value++));
            output[9] = __float_as_uint(value);
            output[10] = __float_as_uint(pair(ceilf(value++), value++));
            output[11] = __float_as_uint(value);
            value = -0.25f;
            output[12] = __float_as_uint((ceilf(value++), ceilf(value++)));
            output[13] = __float_as_uint(value);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[14] = __float_as_uint(ceilf(value++));
            }
            output[15] = __float_as_uint(value);
            output[16] = unsigned(run && ceilf(value++));
            output[17] = __float_as_uint(value);
        }",
        &expected,
    )
}

fn output_case(name: &str, source: &str, expected: &[u32; 32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [1, 1, 1],
    )
}
