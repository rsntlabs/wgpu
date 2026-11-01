use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..16].copy_from_slice(&[
        (-31.0_f32).to_bits(),
        (-0.75_f32).to_bits(),
        0.75_f32.to_bits(),
        0.25_f32.to_bits(),
        1.25_f32.to_bits(),
        2.0_f32.to_bits(),
        2.25_f32.to_bits(),
        0,
        2.25_f32.to_bits(),
        2.0_f32.to_bits(),
        4.0_f32.to_bits(),
        4.25_f32.to_bits(),
        5.25_f32.to_bits(),
        42,
        54,
        66,
    ]);
    vec![module_case(
        "cached floor, ceiling and absolute helpers preserve mixed calls, argument order, laziness and colliding source names",
        "__device__ float lower(float &value) { return floorf(value++); }
        __device__ float upper(float &value) { return ceilf(value++); }
        __device__ float magnitude(float &value) { return fabsf(value++); }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __device__ unsigned _naga_floorf(unsigned value) { return value + 40u; }
        __device__ unsigned _naga_ceilf(unsigned value) { return value + 50u; }
        __device__ unsigned _naga_fabsf(unsigned value) { return value + 60u; }
        __global__ void effects(unsigned *output) {
            float value = -2.75f;
            output[0] = __float_as_uint(pair(lower(value), upper(value)));
            output[1] = __float_as_uint(value);
            output[2] = __float_as_uint(fabs(value++));
            output[3] = __float_as_uint(magnitude(value)); output[4] = __float_as_uint(value);
            bool choose = true;
            output[5] = __float_as_uint(choose ? ceilf(value++) : floorf(value++));
            output[6] = __float_as_uint(value);
            output[7] = unsigned(false && fabsf(value++)); output[8] = __float_as_uint(value);
            output[9] = __float_as_uint(floorf(value++));
            output[10] = __float_as_uint(ceilf(value++));
            output[11] = __float_as_uint(fabsf(-value++)); output[12] = __float_as_uint(value);
            output[13] = _naga_floorf(2u); output[14] = _naga_ceilf(4u); output[15] = _naga_fabsf(6u);
        }",
        [1, 1, 1],
        &expected,
    ).module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial)],
        0,
        [1, 1, 1],
    )]
}
