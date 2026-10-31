use super::sqrtf::{expected_bits, input_bits};
use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/sqrt.cu");
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![rounded_results(), overloads_and_values(), selected_calls()]
}

fn rounded_results() -> ShaderTest {
    let inputs = input_bits();
    assert_eq!(inputs.len(), 1732);
    let mut input_buffer = [0x0123_4567_u32; 2048];
    input_buffer[..inputs.len()].copy_from_slice(&inputs);
    let mut expected = [SENTINEL; 2048];
    for (output, &input) in expected.iter_mut().zip(&inputs) {
        *output = expected_bits(input);
    }
    module_case(
        "float sqrt preserves root rounding across exponent bands, subnormals and exceptional classes",
        "__global__ void roots(const unsigned *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 1732u) return;
            output[index] = __float_as_uint(sqrt(__uint_as_float(input[index])));
        }",
        [64, 1, 1],
        &expected,
    ).module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input_buffer),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 2048]),
        ],
        1,
        [32, 1, 1],
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

fn overloads_and_values() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..18].copy_from_slice(&[
        0x0000_0000,
        0x8000_0000,
        2.5_f32.to_bits(),
        3.0_f32.to_bits(),
        37,
        53,
        7,
        9,
        0x1a35_04f3,
        0x7f80_0000,
        0x7fc0_0000,
        0x7fc0_0000,
        2.0_f32.to_bits(),
        5.0_f32.to_bits(),
        7,
        4.0_f32.to_bits(),
        3.0_f32.to_bits(),
        4.0_f32.to_bits(),
    ]);
    output_case(
        "float sqrt and sqrtf keep const aliases, exact user overloads, vectors and independent exact root values",
        FIXTURE,
        &expected,
    )
}

fn selected_calls() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..16].copy_from_slice(&[
        3.0_f32.to_bits(),
        10.0_f32.to_bits(),
        57.0_f32.to_bits(),
        18.0_f32.to_bits(),
        18.0_f32.sqrt().to_bits(),
        19.0_f32.to_bits(),
        0,
        19.0_f32.to_bits(),
        1,
        19.0_f32.to_bits(),
        5.0_f32.to_bits(),
        26.0_f32.to_bits(),
        1,
        27.0_f32.to_bits(),
        6.0_f32.to_bits(),
        7.0_f32.to_bits(),
    ]);
    output_case(
        "float sqrt captures reference-helper arguments once and keeps lazy branches and scalar helper argument order",
        "__device__ float next(float &value) { return value++; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void effects(unsigned *output) {
            float value = 9.0f;
            output[0] = __float_as_uint(sqrt(next(value))); output[1] = __float_as_uint(value);
            value = 16.0f;
            output[2] = __float_as_uint(pair(sqrt(next(value)), next(value)));
            output[3] = __float_as_uint(value);
            bool choose = false;
            output[4] = __float_as_uint(choose ? sqrt(next(value)) : sqrtf(next(value)));
            output[5] = __float_as_uint(value);
            output[6] = unsigned(false && sqrt(next(value))); output[7] = __float_as_uint(value);
            output[8] = unsigned(true || sqrt(next(value))); output[9] = __float_as_uint(value);
            choose = true; value = 25.0f;
            output[10] = __float_as_uint(choose ? sqrt(next(value)) : sqrtf(next(value)));
            output[11] = __float_as_uint(value);
            output[12] = unsigned(true && sqrt(next(value))); output[13] = __float_as_uint(value);
            output[14] = __float_as_uint(sqrtf(36.0f)); output[15] = __float_as_uint(sqrt(49.0f));
        }",
        &expected,
    )
}
