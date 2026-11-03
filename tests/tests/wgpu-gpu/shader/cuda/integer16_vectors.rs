use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};

const HALFWORD_SENTINEL: u16 = 0xa55a;
const SENTINEL: u32 = 0xdead_beef;
const SOURCE: &str = include_str!("../../../../../naga/tests/in/cuda/integer16-vectors.cu");

fn vector_case<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    workgroup_size: [u32; 3],
    expected: &[O],
) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &naga::front::cuda::Options {
            workgroup_size,
            ..Default::default()
        },
        expected,
        naga::valid::Capabilities::SHADER_INT16,
    );
    test.output_comparison_fn = compare_words;
    test
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for prefix in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let name = format!("{prefix}{width}");
            tests.push(copy_case(&name, width, 65536, 65536));
            tests.push(shared_case(&name, width));
            for count in [0, 1, 3, 4, 5, 7] {
                tests.push(copy_case(&name, width, count, 8));
            }
        }
    }
    tests.extend(canonical_cases());
    tests
}

fn copy_case(name: &str, width: usize, count: u32, record_count: usize) -> ShaderTest {
    let input: Vec<u16> = (0..record_count)
        .flat_map(|index| {
            (0..width).map(move |field| {
                (index as u16)
                    .wrapping_mul(32767)
                    .wrapping_add(field as u16 * 10007)
            })
        })
        .collect();
    let initial = vec![HALFWORD_SENTINEL; (record_count + 4) * width];
    let mut expected = initial.clone();
    let copied_halfwords = count as usize * width;
    expected[width..width + copied_halfwords].copy_from_slice(&input[..copied_halfwords]);
    let source = format!(
        "__global__ void copy(const {name} *input, {name} *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            output[index + 1u] = input[index];
        }}"
    );
    vector_case(
        &format!("{name} count {count} copies preserve native stride, adjacent fields and guards"),
        &source,
        [64, 1, 1],
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

fn shared_case(name: &str, width: usize) -> ShaderTest {
    let mut input: Vec<u16> = (0..width * 4)
        .map(|index| (index as u16).wrapping_mul(10007))
        .collect();
    for (record, value) in [u16::MAX, 32767, 32768, 0].into_iter().enumerate() {
        input[(record + 1) * width - 1] = value;
    }
    let initial = vec![HALFWORD_SENTINEL; 8 * width];
    let mut expected = initial.clone();
    for lane in 0..4 {
        let neighbor = (lane + 1) % 4;
        let destination = (lane + 1) * width;
        expected[destination..destination + width]
            .copy_from_slice(&input[neighbor * width..(neighbor + 1) * width]);
        expected[destination + width - 1] = expected[destination + width - 1].wrapping_add(1);
    }
    let last_field = ["x", "y", "z", "w"][width - 1];
    let source = format!(
        "__global__ void exchange(const {name} *input, {name} *output) {{
            __shared__ {name} tile[4];
            unsigned lane = threadIdx.x;
            tile[lane] = input[lane];
            __syncthreads();
            {name} value = tile[(lane + 1u) & 3u];
            ++value.{last_field};
            output[lane + 1u] = value;
        }}"
    );
    vector_case(
        &format!("{name} shared vector exchange and narrowing field update preserve guards"),
        &source,
        [4, 1, 1],
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
                &initial,
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn reference_triple(value: [i16; 3]) -> ([i16; 3], [u32; 16]) {
    let [horizontal, vertical, depth] = value;
    let unsigned_horizontal = horizontal as u16;
    let unsigned_vertical = vertical as u16;
    let unsigned_depth = depth as u16;
    let output = [
        horizontal.wrapping_add(3),
        vertical.wrapping_neg(),
        depth ^ 0x1357,
    ];
    let observations = [
        i32::from(horizontal) as u32,
        i32::from(vertical) as u32,
        i32::from(horizontal) as u32,
        i32::from(vertical) as u32,
        i32::from(depth) as u32,
        i32::from(horizontal.wrapping_add(7)) as u32,
        u32::from(unsigned_horizontal.wrapping_add(1)),
        u32::from(unsigned_vertical.wrapping_add(1)),
        u32::from(unsigned_horizontal) + 3 * u32::from(unsigned_vertical),
        u32::from(unsigned_depth),
        u32::from(unsigned_depth),
        u32::from(unsigned_vertical),
        u32::from(unsigned_horizontal),
        1,
        31,
        43,
    ];
    (output, observations)
}

fn canonical_cases() -> Vec<ShaderTest> {
    let input = [
        [i16::MIN, -1, i16::MAX],
        [0, 1, 2],
        [i16::MAX, i16::MIN, -2],
        [-3, -32767, 32766],
        [1, 32767, i16::MIN],
        [-1, 0, -1],
        [1234, -2345, 32765],
        [-32766, 32766, 7],
    ];
    let initial_triples = [HALFWORD_SENTINEL as i16; 36];
    let initial_observations = [SENTINEL; 160];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7] {
        let mut expected_triples = initial_triples;
        let mut expected_observations = initial_observations;
        for (index, &value) in input.iter().take(count as usize).enumerate() {
            let (triple, observations) = reference_triple(value);
            expected_triples[index * 3..index * 3 + 3].copy_from_slice(&triple);
            expected_observations[index * 16..index * 16 + 16].copy_from_slice(&observations);
        }
        for (name, binding, expected) in [
            (
                "packed triples",
                1,
                bytemuck::pod_collect_to_vec::<i16, u32>(&expected_triples),
            ),
            ("observations", 2, expected_observations.to_vec()),
        ] {
            tests.push(
                vector_case(
                    &format!("16-bit vector constructors, helpers and fields count {count} {name}"),
                    SOURCE,
                    [4, 1, 1],
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
                            &initial_triples,
                        ),
                        ShaderBuffer::new(
                            2,
                            wgpu::BufferBindingType::Storage { read_only: false },
                            &initial_observations,
                        ),
                        ShaderBuffer::new(
                            3,
                            wgpu::BufferBindingType::Uniform,
                            &[count | 0xa55a_0000, 0x0123_4567, 0x89ab_cdef, 0x1357_9bdf],
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
