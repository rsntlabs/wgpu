use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};
use naga::valid::Capabilities;

const SENTINEL: u32 = 0xdead_beef;
const HALFWORD_SENTINEL: u16 = 0xa55a;

fn vector_case<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    workgroup_size: [u32; 3],
    expected: &[O],
    capabilities: Capabilities,
) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &naga::front::cuda::Options {
            workgroup_size,
            ..Default::default()
        },
        expected,
        capabilities,
    );
    test.output_comparison_fn = compare_words;
    test
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for name in ["float1", "int1", "uint1"] {
        let input: Vec<u32> = (0..65536_u32)
            .map(|index| {
                if name == "float1" {
                    let exponent = 1 + index % 254;
                    let sign = (index / 254) & 1;
                    let fraction = index.wrapping_mul(123457) & 0x007f_ffff;
                    (sign << 31) | (exponent << 23) | fraction
                } else {
                    index.wrapping_mul(0x9e37_79b9)
                }
            })
            .collect();
        tests.push(copy_case(
            name,
            65536,
            &input,
            SENTINEL,
            Capabilities::empty(),
        ));
        tests.push(shared_case(
            name,
            &input[..4],
            SENTINEL,
            Capabilities::empty(),
        ));
        for count in [0, 1, 3, 4, 5, 7] {
            tests.push(copy_case(
                name,
                count,
                &input[..8],
                SENTINEL,
                Capabilities::empty(),
            ));
        }
    }
    let exceptional_bits = [
        0x0000_0000,
        0x8000_0000,
        0x0000_0001,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        0x7fc0_0000,
        0xffc0_0000,
        0x7fc1_2345,
        0xffc5_4321,
        0x7f80_0001,
        0xff80_0001,
        0x7fbf_ffff,
        0xffbf_ffff,
        0x3f80_0000,
        0xbf80_0000,
        0x4000_0000,
        0xc000_0000,
    ];
    tests.push(copy_case(
        "float1",
        exceptional_bits.len() as u32,
        &exceptional_bits,
        SENTINEL,
        Capabilities::empty(),
    ));
    tests
}

pub(super) fn integer16_cases() -> Vec<ShaderTest> {
    let input: Vec<u16> = (0..65536).map(|index| index as u16).collect();
    let mut tests = Vec::new();
    for name in ["short1", "ushort1"] {
        tests.push(copy_case(
            name,
            65536,
            &input,
            HALFWORD_SENTINEL,
            Capabilities::SHADER_INT16,
        ));
        tests.push(shared_case(
            name,
            &[u16::MAX, 32767, 32768, 0],
            HALFWORD_SENTINEL,
            Capabilities::SHADER_INT16,
        ));
        for count in [0, 1, 3, 4, 5, 7] {
            tests.push(copy_case(
                name,
                count,
                &input[..8],
                HALFWORD_SENTINEL,
                Capabilities::SHADER_INT16,
            ));
        }
    }
    tests.extend(canonical_cases());
    tests
}

fn copy_case<T: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    count: u32,
    input: &[T],
    sentinel: T,
    capabilities: Capabilities,
) -> ShaderTest {
    let initial = vec![sentinel; input.len() + 4];
    let mut expected = initial.clone();
    expected[1..count as usize + 1].copy_from_slice(&input[..count as usize]);
    let source = format!(
        "__global__ void copy(const {name} *input, {name} *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            output[index + 1u] = input[index];
        }}"
    );
    vector_case(
        &format!("{name} count {count} copies preserve scalar field bits, stride and guards"),
        &source,
        [64, 1, 1],
        &expected,
        capabilities,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[count, 0x0123_4567, 0x89ab_cdef, 0x1357_9bdf],
            ),
        ],
        1,
        [count.div_ceil(64) + 1, 1, 1],
    )
}

fn shared_case<T: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    input: &[T],
    sentinel: T,
    capabilities: Capabilities,
) -> ShaderTest {
    let initial = [sentinel; 8];
    let mut expected = initial;
    for lane in 0..4 {
        expected[lane + 1] = input[(lane + 1) % 4];
    }
    let source = format!(
        "__global__ void exchange(const {name} *input, {name} *output) {{
            __shared__ {name} tile[4];
            unsigned lane = threadIdx.x;
            tile[lane] = input[lane];
            __syncthreads();
            output[lane + 1u] = tile[(lane + 1u) & 3u];
        }}"
    );
    vector_case(
        &format!("{name} shared aggregate copies preserve neighboring fields and guards"),
        &source,
        [4, 1, 1],
        &expected,
        capabilities,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn reference_value(value: i32) -> (i32, [u32; 16]) {
    let output = value ^ 0x1357_9bdf;
    let observations = [
        value as u32,
        output as u32,
        value as u32,
        ((value & 7) as f32 + 0.5).to_bits(),
        i32::from((value as i16).wrapping_add(1)) as u32,
        u32::from((value as u16).wrapping_add(1)),
        11,
        13,
        17,
        19,
        23,
        31,
        37,
        41,
        43,
        47,
    ];
    (output, observations)
}

fn canonical_cases() -> Vec<ShaderTest> {
    let input = [i32::MIN, -1, i32::MAX, 0, 32767, -32768, 65535, -65536];
    let initial_output = [SENTINEL as i32; 12];
    let initial_observations = [SENTINEL; 160];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7] {
        let mut expected_output = initial_output;
        let mut expected_observations = initial_observations;
        for (index, &value) in input.iter().take(count as usize).enumerate() {
            let (output, observations) = reference_value(value);
            expected_output[index] = output;
            expected_observations[index * 16..(index + 1) * 16].copy_from_slice(&observations);
        }
        for (name, binding, expected) in [
            (
                "aggregate output",
                1,
                expected_output.map(|value| value as u32).to_vec(),
            ),
            ("observations", 2, expected_observations.to_vec()),
        ] {
            tests.push(
                vector_case(
                    &format!(
                        "single-component constructors, helpers and overloads count {count} {name}"
                    ),
                    include_str!("../../../../../naga/tests/in/cuda/single-component-vectors.cu"),
                    [4, 1, 1],
                    &expected,
                    Capabilities::SHADER_INT16,
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
                            &initial_output,
                        ),
                        ShaderBuffer::new(
                            2,
                            wgpu::BufferBindingType::Storage { read_only: false },
                            &initial_observations,
                        ),
                        ShaderBuffer::new(
                            3,
                            wgpu::BufferBindingType::Uniform,
                            &[count, 0x0123_4567, 0x89ab_cdef, 0x1357_9bdf],
                        ),
                    ],
                    binding,
                    [count.div_ceil(4) + 1, 1, 1],
                ),
            );
        }
    }
    tests
}
