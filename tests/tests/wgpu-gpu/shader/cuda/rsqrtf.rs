use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const CANONICAL_NAN: u32 = 0x7fc0_0000;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        runtime_value(),
        rounded_results(),
        conversions_and_effects(),
        float_buffer_results(),
    ]
}

fn runtime_value() -> ShaderTest {
    let input = [4.0_f32.to_bits()];
    let expected = [0.5_f32.to_bits(), SENTINEL, SENTINEL, SENTINEL];
    module_case(
        "rsqrtf computes the reciprocal square root of a runtime operand",
        "__global__ void inverse_roots(const unsigned *input, unsigned *output) {
            output[0] = __float_as_uint(rsqrtf(__uint_as_float(input[0])));
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

fn expected_bits(input_bits: u32) -> u32 {
    let magnitude = input_bits & 0x7fff_ffff;
    if magnitude == 0 {
        input_bits | 0x7f80_0000
    } else if input_bits == 0x7f80_0000 {
        0
    } else if input_bits & 0x8000_0000 != 0 || magnitude > 0x7f80_0000 {
        CANONICAL_NAN
    } else {
        let root = f32::from_bits(input_bits).sqrt();
        ((1.0_f64 / f64::from(root)) as f32).to_bits()
    }
}

fn input_bits() -> Vec<u32> {
    let mut inputs = super::sqrtf::input_bits();
    for bits in inputs.clone() {
        let opposite_sign = bits ^ 0x8000_0000;
        if !inputs.contains(&opposite_sign) {
            inputs.push(opposite_sign);
        }
    }
    let mut add = |bits| {
        if !inputs.contains(&bits) {
            inputs.push(bits);
        }
    };
    for significand in [
        0x0080_0000,
        0x0080_0001,
        0x0080_0002,
        0x008a_bcde,
        0x00aa_aaaa,
        0x00b5_04f3,
        0x00c0_0000,
        0x00ff_ffff,
    ] {
        for exponent in [-64, -32, -1, 0, 1, 32, 63, 74] {
            let midpoint = f64::from(2 * significand + 1) * 2.0_f64.powi(exponent - 24);
            let inverse_square = 1.0 / (midpoint * midpoint);
            let center = (inverse_square as f32).to_bits();
            if center == 0 || center >= 0x7f80_0000 {
                continue;
            }
            for offset in [-2, -1, 0, 1, 2] {
                let bits = i64::from(center) + offset;
                if bits > 0 && bits < 0x7f80_0000 {
                    add(bits as u32);
                    add(bits as u32 | 0x8000_0000);
                }
            }
        }
    }
    let mut state = 0x7285_3a19_u32;
    for _ in 0..1024 {
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        add(state);
    }
    inputs
}

fn rounded_results() -> ShaderTest {
    let inputs = input_bits();
    let count = inputs.len();
    let dispatch_count = (count as u32).div_ceil(64);
    let buffer_len = dispatch_count as usize * 64 + 64;
    let mut input = vec![0x0123_4567_u32; buffer_len];
    input[..count].copy_from_slice(&inputs);
    let mut expected = vec![SENTINEL; buffer_len];
    for (output, &input_bits) in expected.iter_mut().zip(&inputs) {
        *output = expected_bits(input_bits);
    }
    let source = format!(
        "__global__ void inverse_roots(const unsigned *input, unsigned *output) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= {count}u) return;
            output[index] = __float_as_uint(rsqrtf(__uint_as_float(input[index])));
        }}"
    );
    module_case(
        "rsqrtf reciprocal of rounded sqrt across exponent bands, inverse-root boundaries, signed inputs and exceptional classes",
        &source,
        [64, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL; buffer_len]),
        ],
        1,
        [dispatch_count, 1, 1],
    )
}

fn conversions_and_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 64];
    expected[..49].copy_from_slice(&[
        0x7f80_0000,
        0xff80_0000,
        1.0_f32.to_bits(),
        0.5_f32.to_bits(),
        expected_bits(9.0_f32.to_bits()),
        expected_bits(6.25_f32.to_bits()),
        expected_bits(2.0_f32.to_bits()),
        expected_bits(1),
        expected_bits(0x007f_ffff),
        expected_bits(0x0080_0000),
        expected_bits(0x7f7f_ffff),
        0,
        CANONICAL_NAN,
        CANONICAL_NAN,
        0.5_f32.to_bits(),
        5.0_f32.to_bits(),
        7,
        9,
        5.0_f32.to_bits(),
        expected_bits(0x3f80_0001),
        expected_bits(0x3f80_0002),
        expected_bits(0x3f7f_ffff),
        expected_bits(4294967296.0_f32.to_bits()),
        CANONICAL_NAN,
        0.25_f32.to_bits(),
        2.0_f32.to_bits(),
        CANONICAL_NAN,
        0x7f80_0000,
        1.0_f32.to_bits(),
        expected_bits(0.5_f32.to_bits()),
        2.0_f32.sqrt().to_bits(),
        expected_bits(2.0_f32.to_bits()),
        expected_bits(2.0_f32.to_bits()),
        0.5_f32.to_bits(),
        5.0_f32.to_bits(),
        0,
        1,
        5.0_f32.to_bits(),
        (5.0 + f32::from_bits(expected_bits(9.0_f32.to_bits()))).to_bits(),
        5.0_f32.to_bits(),
        10.0_f32.to_bits(),
        expected_bits(6.0_f32.to_bits()),
        7.0_f32.to_bits(),
        expected_bits(7.0_f32.to_bits()),
        8.0_f32.to_bits(),
        expected_bits(8.0_f32.to_bits()),
        9.0_f32.to_bits(),
        1,
        10.0_f32.to_bits(),
    ]);
    module_case(
        "rsqrtf conversions, aliases, overloads, shared sqrt and division helpers, ordered effects and lazy branches",
        include_str!("../../../../../naga/tests/in/cuda/rsqrtf.cu"),
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 64])],
        0,
        [1, 1, 1],
    )
}

fn float_buffer_results() -> ShaderTest {
    let input = [
        0x0000_0000_u32,
        0x8000_0000,
        0x3f80_0000,
        0x4080_0000,
        0x4000_0000,
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
        0x007f_ffff,
        0x3f7f_ffff,
        0x3f80_0001,
        0x3f80_0002,
        0xbf80_0000,
    ];
    let mut expected = [SENTINEL; 32];
    for (output, input_bits) in expected.iter_mut().zip(input) {
        *output = expected_bits(input_bits);
    }
    module_case(
        "rsqrtf classifies typed float storage loads across subnormals, signed zeros and exceptional values",
        "__global__ void inverse_roots(const float *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 22u) return;
            output[index] = __float_as_uint(rsqrtf(input[index]));
        }",
        [8, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 32]),
        ],
        1,
        [4, 1, 1],
    )
}
