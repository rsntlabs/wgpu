use super::{
    float_truthiness::FLOAT_BITS, integer16::compare_words,
    module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};
use naga::valid::Capabilities;

const SENTINEL: u32 = 0xdead_beef;
const VALUE_COUNT: usize = 9;

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
    tests.push(shared_case());
    tests.extend(canonical_cases());
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
        let input: Vec<u32> = (0..65536_u32)
            .flat_map(|index| {
                (0..4_u32).map(move |component| match prefix {
                    "float" if (index as usize) < FLOAT_BITS.len() => FLOAT_BITS[index as usize],
                    "float" => {
                        let exponent = 1 + index % 254;
                        let sign = (index / 254) & 1;
                        let fraction = (index + component).wrapping_mul(123457) & 0x007f_ffff;
                        (sign << 31) | (exponent << 23) | fraction
                    }
                    "short" | "ushort" => (index + component) & 0xffff,
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
                65536,
                65536,
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
        for (element, value) in [
            fields, fields, [0; 4], fields, fields, [0; 4], fields, [0; 4], [0; 4],
        ]
        .into_iter()
        .enumerate()
        {
            let destination = (index + 1) * record_words + element * width;
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
                format!("values[element].{field}")
            } else {
                String::from("values[element]")
            };
            let encoded = if prefix == "float" {
                format!("__float_as_uint({value})")
            } else {
                format!("unsigned({value})")
            };
            format!("output[base + element * {width}u + {component}u] = {encoded};")
        })
        .collect::<Vec<_>>()
        .join("\n");
    let source = format!(
        "using Value = {name};
        typedef Value Row[3];
        using Matrix = Row[2];
        using InputRow = unsigned[4];
        using Input = InputRow[2];
        __global__ void initialize(const Input input, unsigned *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            Value source = {construction};
            Row fixed(source, source);
            Matrix matrix{{{{source, source}}, {{source}}}};
            {mutation}
            Value values[{VALUE_COUNT}]{{fixed[0], fixed[1], fixed[2],
                matrix[0][0], matrix[0][1], matrix[0][2],
                matrix[1][0], matrix[1][1], matrix[1][2]}};
            unsigned base = (index + 1u) * {record_words}u;
            for (unsigned element = 0; element < {VALUE_COUNT}u; ++element) {{
                {stores}
            }}
        }}"
    );
    let mut test = module_case_with_options_and_capabilities(
        &format!("{name} array aliases count {count} preserve nested copies, defaults and guards"),
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

fn shared_case() -> ShaderTest {
    let source = "using Row = unsigned[3]; using Rows = Row[4];
        __global__ void storage(unsigned *output) {
            __shared__ Rows fixed;
            extern __shared__ Row dynamic[];
            unsigned lane = threadIdx.x;
            for (unsigned component = 0; component < 3u; ++component) {
                fixed[lane][component] = lane * 11u + component + 3u;
                dynamic[lane][component] = lane * 17u + component + 5u;
            }
            __syncthreads();
            unsigned neighbor = (lane + 1u) % 4u;
            for (unsigned component = 0; component < 3u; ++component) {
                output[(lane + 1u) * 6u + component] = fixed[neighbor][component];
                output[(lane + 1u) * 6u + 3u + component] = dynamic[neighbor][component];
            }
        }";
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    for lane in 0..4 {
        let neighbor = (lane + 1) % 4;
        for component in 0..3 {
            expected[(lane + 1) * 6 + component] = (neighbor * 11 + component + 3) as u32;
            expected[(lane + 1) * 6 + 3 + component] = (neighbor * 17 + component + 5) as u32;
        }
    }
    let mut test = module_case_with_options_and_capabilities(
        "array aliases preserve static and dynamic shared rows across a barrier",
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

fn reference_observations(value: u32) -> [u32; 32] {
    [
        value,
        value + 5,
        0,
        value + 5,
        value + 7,
        value + 8,
        0,
        value + 2,
        0,
        0,
        value + 3,
        value + 4,
        value + 13,
        value * 2 + 15,
        value * 2 + 7,
        value + 5,
        value + 6,
        0,
        value + 7,
        1,
        1,
        1,
        1,
        1,
        1,
        value + 10,
        0,
        0,
        value + 11,
        value + 12,
        0,
        value + 9,
    ]
}

fn canonical_cases() -> Vec<ShaderTest> {
    let values = [i32::MIN, -1, i32::MAX, 1, 127, 128, 254, 255];
    let input: Vec<i32> = values
        .into_iter()
        .flat_map(|value| [value, 17, 17])
        .collect();
    let initial = [SENTINEL; 384];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7, 8] {
        let mut expected = initial;
        for (index, &value) in values.iter().take(count as usize).enumerate() {
            expected[(index + 1) * 32..(index + 2) * 32]
                .copy_from_slice(&reference_observations(value as u32 & 255));
        }
        let mut test = module_case_with_options_and_capabilities(
            &format!("array aliases count {count} preserve decay, row mutations and defaults"),
            include_str!("../../../../../naga/tests/in/cuda/array-aliases.cu"),
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
