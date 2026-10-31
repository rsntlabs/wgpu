use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

const BIT_PATTERNS: [(u32, u32); 40] = [
    (0x0000_0000, 0x0000_0000),
    (0x8000_0000, 0x0000_0000),
    (0x0000_0001, 0x0000_0001),
    (0x8000_0001, 0x0000_0000),
    (0x007f_ffff, 0x007f_ffff),
    (0x807f_ffff, 0x0000_0000),
    (0x0080_0000, 0x0080_0000),
    (0x8080_0000, 0x0000_0000),
    (0x0080_0001, 0x0080_0001),
    (0x8080_0001, 0x0000_0000),
    (0x0100_0001, 0x0100_0001),
    (0x8100_0001, 0x0000_0000),
    (0x3e80_0000, 0x3e80_0000),
    (0xbe80_0000, 0x0000_0000),
    (0x3f00_0000, 0x3f00_0000),
    (0xbf00_0000, 0x0000_0000),
    (0x3f40_0000, 0x3f40_0000),
    (0xbf40_0000, 0x0000_0000),
    (0x3f7f_ffff, 0x3f7f_ffff),
    (0xbf7f_ffff, 0x0000_0000),
    (0x3f80_0000, 0x3f80_0000),
    (0xbf80_0000, 0x0000_0000),
    (0x3f80_0001, 0x3f80_0000),
    (0xbf80_0001, 0x0000_0000),
    (0x4000_0000, 0x3f80_0000),
    (0xc000_0000, 0x0000_0000),
    (0x7f7f_ffff, 0x3f80_0000),
    (0xff7f_ffff, 0x0000_0000),
    (0x7f80_0000, 0x3f80_0000),
    (0xff80_0000, 0x0000_0000),
    (0x7fc0_0000, 0x0000_0000),
    (0xffc0_0000, 0x0000_0000),
    (0x7fc1_2345, 0x0000_0000),
    (0xffc5_4321, 0x0000_0000),
    (0x7f80_0001, 0x0000_0000),
    (0xff80_0001, 0x0000_0000),
    (0x7fbf_ffff, 0x0000_0000),
    (0xffbf_ffff, 0x0000_0000),
    (0x7fff_ffff, 0x0000_0000),
    (0xffff_ffff, 0x0000_0000),
];

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        bit_patterns(),
        conversions_and_side_effects(),
        selected_calls(),
    ]
}

fn bit_patterns() -> ShaderTest {
    let mut input = [0x0123_4567_u32; 64];
    let mut expected = [SENTINEL; 64];
    for (index, &(input_bits, output_bits)) in BIT_PATTERNS.iter().enumerate() {
        input[index] = input_bits;
        expected[index] = output_bits;
    }
    module_case(
        "__saturatef exact boundaries, signed zeros, subnormals, infinities and NaN classes",
        "__global__ void saturate_bits(const unsigned *input, unsigned *out) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 40u) return;
            out[index] = __float_as_uint(__saturatef(__uint_as_float(input[index])));
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
        [8, 1, 1],
    )
}

fn conversions_and_side_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..30].copy_from_slice(&[
        0x0000_0000,
        0x0000_0000,
        0x0000_0000,
        0x3e80_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x0000_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x0000_0000,
        7,
        9,
        0x3e80_0000,
        0x3fa0_0000,
        0x0000_0000,
        0x3f00_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x3f80_0000,
        0x0000_0000,
        0x3f40_0000,
        0x3fa0_0000,
        0x4010_0000,
        0x4010_0000,
        0x3f80_0000,
        0x3fa0_0000,
        0,
        0x3fa0_0000,
        0x3f80_0000,
        0x4010_0000,
    ]);
    output_case(
        "__saturatef conversions, aliases, overloads, argument snapshots, reference expansion and fields",
        include_str!("../../../../../naga/tests/in/cuda/saturate.cu"),
        &expected,
    )
}

fn selected_calls() -> ShaderTest {
    let mut expected = [SENTINEL; 16];
    expected[..8].copy_from_slice(&[
        0x0000_0000,
        0x3e80_0000,
        0x3e80_0000,
        0x3fa0_0000,
        0,
        0x3fa0_0000,
        0x3f80_0000,
        0x4010_0000,
    ]);
    output_case(
        "__saturatef skipped branches, loop continue and once-only nested helper evaluation",
        "__device__ float next(float &value) { return value++; }
        __global__ void selected(unsigned *out) {
            float value = -0.75f;
            out[0] = __float_as_uint(false ? __saturatef(next(value)) : __saturatef(value++));
            out[1] = __float_as_uint(value);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                out[2] = __float_as_uint(__saturatef(next(value)));
            }
            out[3] = __float_as_uint(value);
            bool active = false && __saturatef(next(value));
            out[4] = unsigned(active);
            out[5] = __float_as_uint(value);
            out[6] = __float_as_uint(__saturatef(next(value)));
            out[7] = __float_as_uint(value);
        }",
        &expected,
    )
}

fn output_case(name: &str, source: &str, expected: &[u32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &vec![SENTINEL; expected.len()],
        )],
        0,
        [1, 1, 1],
    )
}
