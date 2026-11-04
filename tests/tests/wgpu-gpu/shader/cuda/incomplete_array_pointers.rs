use super::{
    float_truthiness::FLOAT_BITS, integer16::compare_words,
    module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};
use naga::valid::Capabilities;

const SENTINEL: u32 = 0xdead_beef;
const VALUE_COUNT: usize = 15;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = value_cases(
        &["bool", "float", "int", "uint"],
        false,
        Capabilities::empty(),
    );
    tests.extend(value_cases(
        &["float", "int", "uint"],
        true,
        Capabilities::empty(),
    ));
    tests.extend(canonical_cases());
    tests.push(shared_case());
    tests.extend(kernel_row_cases());
    tests
}

pub(super) fn integer16_cases() -> Vec<ShaderTest> {
    let mut tests = value_cases(&["short", "ushort"], false, Capabilities::SHADER_INT16);
    tests.extend(value_cases(
        &["short", "ushort"],
        true,
        Capabilities::SHADER_INT16,
    ));
    tests
}

fn value_cases(prefixes: &[&str], vector: bool, capabilities: Capabilities) -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for &prefix in prefixes {
        let input: Vec<u32> = (0..256_u32)
            .flat_map(|index| {
                (0..4_u32).map(move |component| match prefix {
                    "float" if (index as usize) < FLOAT_BITS.len() => {
                        FLOAT_BITS[(index + component) as usize % FLOAT_BITS.len()]
                    }
                    "float" => {
                        let exponent = 1 + index % 254;
                        let sign = (index / 254) & 1;
                        let fraction = (index + component).wrapping_mul(123457) & 0x007f_ffff;
                        (sign << 31) | (exponent << 23) | fraction
                    }
                    "short" | "ushort" if index < 8 => {
                        [0, 32767, 32768, 65535, 1, 32766, 32769, 65534]
                            [(index + component) as usize % 8]
                    }
                    "short" | "ushort" => (index * 257 + component * 10007) & 0xffff,
                    "bool" if index < 8 => {
                        [0, 1, u32::MAX, 0x8000_0000, 7, 0, 42, 0][index as usize]
                    }
                    _ => index.wrapping_mul(0x9e37_79b9).wrapping_add(component),
                })
            })
            .collect();
        let widths = if vector { 1..=4 } else { 1..=1 };
        for width in widths {
            tests.push(value_case(
                prefix,
                width,
                vector,
                256,
                256,
                &input,
                capabilities,
            ));
            for count in [0, 1, 3, 4, 5, 7] {
                tests.push(value_case(
                    prefix,
                    width,
                    vector,
                    count,
                    8,
                    &input,
                    capabilities,
                ));
            }
        }
    }
    tests
}

fn value_case(
    prefix: &str,
    width: usize,
    vector: bool,
    count: u32,
    record_count: usize,
    input: &[u32],
    capabilities: Capabilities,
) -> ShaderTest {
    let name = if vector {
        format!("{prefix}{width}")
    } else {
        match prefix {
            "uint" => String::from("unsigned"),
            "ushort" => String::from("unsigned short"),
            _ => String::from(prefix),
        }
    };
    let record_words = VALUE_COUNT * width;
    let initial = vec![SENTINEL; (record_count + 4) * record_words];
    let mut expected = initial.clone();
    for index in 0..count as usize {
        let mut fields = [0; 4];
        for component in 0..width {
            let bits = input[index * 4 + component];
            fields[component] = match prefix {
                "bool" => u32::from(bits != 0),
                "short" => i32::from(bits as i16) as u32,
                "ushort" => u32::from(bits as u16),
                _ => bits,
            };
        }
        let copies_source = [
            true,
            false,
            true,
            false,
            true,
            true,
            index % 2 == 0,
            index % 2 != 0,
            index % 3 != 0 && index % 2 == 0,
            false,
            false,
            true,
            true,
            index % 2 == 0,
            false,
        ];
        for (observation, copies_source) in copies_source.into_iter().enumerate() {
            let value = if copies_source { fields } else { [0; 4] };
            let destination = (index + 1) * record_words + observation * width;
            expected[destination..destination + width].copy_from_slice(&value[..width]);
        }
    }
    let arguments = (0..width)
        .map(|component| {
            let value = format!("input[index][{component}u]");
            if prefix == "float" {
                format!("__uint_as_float({value})")
            } else {
                value
            }
        })
        .collect::<Vec<_>>()
        .join(", ");
    let construction = if vector {
        format!("make_{name}({arguments})")
    } else {
        format!("Value({arguments})")
    };
    let mutation = if vector {
        "source.x = 0;"
    } else {
        "source = 0;"
    };
    let stores = ["x", "y", "z", "w"]
        .into_iter()
        .take(width)
        .enumerate()
        .map(|(component, field)| {
            let value = if vector {
                format!("observations[observation].{field}")
            } else {
                String::from("observations[observation]")
            };
            let encoded = if prefix == "float" {
                format!("__float_as_uint({value})")
            } else {
                format!("unsigned({value})")
            };
            format!("output[base + observation * {width}u + {component}u] = {encoded};")
        })
        .collect::<Vec<_>>()
        .join("\n");
    let source = format!(
        "using Value = {name};
        using Values = Value[];
        using Three = Value[3];
        using Five = Value[5];
        using Pair = Value[2];
        using InputRow = unsigned[4];
        using Input = InputRow[];
        __device__ Value element(const Values *view, unsigned component) {{
            return (*view)[component];
        }}
        __device__ void clear(Value &value) {{ value = Value{{}}; }}
        __global__ void initialize(const Input input, unsigned *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            Value source = {construction};
            Three small{{source, {{}}, source}};
            Five large{{{{}}, source, {{}}, source, source}};
            Pair pairs[2]{{{{source, {{}}}}, {{{{}}, source}}}};
            {mutation}
            Value observations[{VALUE_COUNT}]{{}};
            Values *view = &small;
            Values *capture = view;
            Values *large_view = &large;
            observations[0] = element(view, 0u);
            observations[1] = element(view, 1u);
            view = large_view;
            observations[2] = element(capture, 2u);
            observations[3] = element(view, 0u);
            observations[4] = element(view, 1u);
            (*view)[2] = small[0];
            observations[5] = element(view, 2u);
            Values *selected = (index & 1u) == 0u ? capture : view;
            observations[6] = element(selected, 0u);
            observations[7] = element(selected, 1u);
            Values *nullable = nullptr;
            if (index % 3u != 0u) nullable = selected;
            Value optional{{}};
            if (nullable) optional = element(nullable, 0u);
            observations[8] = optional;
            for (unsigned phase = 0u; phase < 3u; ++phase) {{
                view = phase == 0u ? capture : large_view;
            }}
            observations[9] = element(view, 0u);
            Pair *row = &pairs[1];
            Values *row_view = row;
            observations[10] = element(row_view, 0u);
            observations[11] = element(row_view, 1u);
            Value *elements = *row_view;
            ++elements;
            observations[12] = *elements;
            Values *roundtrip = &*selected;
            observations[13] = element(roundtrip, 0u);
            clear((*capture)[0]);
            observations[14] = element(capture, 0u);
            unsigned base = (index + 1u) * {record_words}u;
            for (unsigned observation = 0; observation < {VALUE_COUNT}u; ++observation) {{
                {stores}
            }}
        }}"
    );
    let mut test = module_case_with_options_and_capabilities(
        &format!("{name} incomplete array pointer views count {count} preserve assignments, snapshots and guards"),
        &source,
        &naga::front::cuda::Options {
            workgroup_size: [64, 1, 1],
            ..Default::default()
        },
        &expected,
        capabilities,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input[..record_count * 4],
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
    );
    test.output_comparison_fn = compare_words;
    test
}

fn reference_observations(value: u32, index: usize) -> [u32; 12] {
    let even = index.is_multiple_of(2);
    let present = !index.is_multiple_of(3);
    let snapshot_second = value + if even { 8 } else { 1 };
    let large_second = value + if even { 4 } else { 11 };
    let selected_first = value + if even { 0 } else { 3 };
    let selected_second = if even { snapshot_second } else { large_second };
    [
        value + 1,
        value + 6,
        snapshot_second,
        large_second,
        selected_second,
        if present { selected_first } else { u32::MAX },
        selected_first,
        u32::from(present),
        value + 10,
        value + 11,
        value + 12,
        snapshot_second,
    ]
}

fn canonical_cases() -> Vec<ShaderTest> {
    let input: Vec<u32> = (0..256)
        .map(|index| {
            if index & 1 == 0 {
                0x8000_0000 | index
            } else {
                0x7fff_ff00 | index
            }
        })
        .collect();
    let initial = vec![SENTINEL; 260 * 12];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7, 8, 256] {
        let mut expected = initial.clone();
        for (index, &value) in input.iter().take(count as usize).enumerate() {
            expected[(index + 1) * 12..(index + 2) * 12]
                .copy_from_slice(&reference_observations(value & 255, index));
        }
        let mut test = module_case_with_options_and_capabilities(
            &format!("incomplete array pointers count {count} preserve canonical views, mutations and guards"),
            include_str!("../../../../../naga/tests/in/cuda/incomplete-array-pointers.cu"),
            &naga::front::cuda::Options {
                workgroup_size: [4, 1, 1],
                ..Default::default()
            },
            &expected,
            Capabilities::empty(),
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
            [count.div_ceil(4) + 1, 1, 1],
        );
        test.output_comparison_fn = compare_words;
        tests.push(test);
    }
    tests
}

fn shared_case() -> ShaderTest {
    let source = "using Values = unsigned[];
        using Row = unsigned[3];
        using Rows = Row[];
        __device__ unsigned element(const Values *view, unsigned component) {
            return (*view)[component];
        }
        __global__ void storage(unsigned *output) {
            extern __shared__ Rows values;
            unsigned lane = threadIdx.x;
            for (unsigned component = 0; component < 3u; ++component) {
                values[lane][component] = lane * 17u + component + 5u;
            }
            __syncthreads();
            unsigned neighbor = (lane + 1u) % 4u;
            Row *known = &values[neighbor];
            Values *view = known;
            for (unsigned component = 0; component < 3u; ++component) {
                output[(lane + 1u) * 3u + component] = element(view, component);
            }
        }";
    let initial = [SENTINEL; 24];
    let mut expected = initial;
    for lane in 0..4 {
        let neighbor = (lane + 1) % 4;
        for component in 0..3 {
            expected[(lane + 1) * 3 + component] = (neighbor * 17 + component + 5) as u32;
        }
    }
    let mut test = module_case_with_options_and_capabilities(
        "incomplete array pointer views preserve shared rows across a barrier",
        source,
        &naga::front::cuda::Options {
            workgroup_size: [4, 1, 1],
            dynamic_shared_memory_size: 48,
        },
        &expected,
        Capabilities::empty(),
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    );
    test.output_comparison_fn = compare_words;
    test
}

fn kernel_row_cases() -> Vec<ShaderTest> {
    let source = "using Values = unsigned[];
        using Row = unsigned[3];
        using Rows = Row[];
        __device__ unsigned element(const Values *view, unsigned component) {
            return (*view)[component];
        }
        __global__ void copy_rows(const Rows *input, Rows *output, unsigned count) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            const Row *known = &(*input)[index];
            const Values *view = known;
            for (unsigned component = 0; component < 3u; ++component) {
                (*output)[index + 1u][component] = element(view, component);
            }
        }";
    let input = [2_u32, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37];
    let initial = [SENTINEL; 24];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4] {
        let mut expected = initial;
        for index in 0..count as usize {
            expected[(index + 1) * 3..(index + 2) * 3]
                .copy_from_slice(&input[index * 3..(index + 1) * 3]);
        }
        let mut test = module_case_with_options_and_capabilities(
            &format!("incomplete array pointer kernel rows count {count} preserve stride, values and guards"),
            source,
            &naga::front::cuda::Options {
                workgroup_size: [4, 1, 1],
                ..Default::default()
            },
            &expected,
            Capabilities::empty(),
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
            [count.div_ceil(4) + 1, 1, 1],
        );
        test.output_comparison_fn = compare_words;
        tests.push(test);
    }
    tests
}
