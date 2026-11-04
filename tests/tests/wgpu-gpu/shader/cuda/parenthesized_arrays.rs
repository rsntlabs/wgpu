use super::{
    float_truthiness::FLOAT_BITS, integer16::compare_words,
    module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};
use naga::valid::Capabilities;

const SENTINEL: u32 = 0xdead_beef;
const VALUE_COUNT: usize = 11;

fn array_case(
    name: &str,
    source: &str,
    workgroup_size: [u32; 3],
    expected: &[u32],
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
    let mut tests = value_cases(
        &["float", "int", "uint", "bool"],
        false,
        Capabilities::empty(),
    );
    tests.extend(value_cases(
        &["float", "int", "uint"],
        true,
        Capabilities::empty(),
    ));
    tests.push(result_objects_case());
    tests.extend(float_boolean_cases());
    tests
}

pub(super) fn integer16_cases() -> Vec<ShaderTest> {
    let mut tests = value_cases(&["short", "ushort"], false, Capabilities::SHADER_INT16);
    tests.extend(value_cases(
        &["short", "ushort"],
        true,
        Capabilities::SHADER_INT16,
    ));
    tests.extend(canonical_cases());
    tests
}

fn value_cases(prefixes: &[&str], vectors: bool, capabilities: Capabilities) -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for &prefix in prefixes {
        let mut input: Vec<u32> = (0..65540_u32)
            .map(|index| match prefix {
                "float" => {
                    let exponent = 1 + index % 254;
                    let sign = (index / 254) & 1;
                    let fraction = index.wrapping_mul(123457) & 0x007f_ffff;
                    (sign << 31) | (exponent << 23) | fraction
                }
                "short" | "ushort" => index & 0xffff,
                _ => index.wrapping_mul(0x9e37_79b9),
            })
            .collect();
        if prefix == "float" {
            input[..FLOAT_BITS.len()].copy_from_slice(&FLOAT_BITS);
            input[FLOAT_BITS.len()..2 * FLOAT_BITS.len()].copy_from_slice(&FLOAT_BITS);
        }
        if prefix == "bool" {
            input[..8].copy_from_slice(&[0, 1, u32::MAX, 0x8000_0000, 7, 0, 42, 0]);
        }
        let widths = if vectors { 1..=4 } else { 1..=1 };
        for width in widths {
            tests.push(value_case(
                prefix,
                width,
                vectors,
                65536,
                &input,
                65536,
                capabilities,
            ));
            for count in [0, 1, 3, 4, 5, 7] {
                tests.push(value_case(
                    prefix,
                    width,
                    vectors,
                    count,
                    &input,
                    8,
                    capabilities,
                ));
            }
        }
    }
    tests
}

fn encoded_field(prefix: &str, bits: u32) -> u32 {
    match prefix {
        "bool" => u32::from(bits != 0),
        "short" => i32::from(bits as i16) as u32,
        "ushort" => u32::from(bits as u16),
        _ => bits,
    }
}

fn value_case(
    prefix: &str,
    width: usize,
    vector: bool,
    count: u32,
    input: &[u32],
    record_count: usize,
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
        let mut full = [0; 4];
        for component in 0..width {
            full[component] = encoded_field(prefix, input[index + component]);
        }
        let zero = [0; 4];
        for (element, fields) in [
            full, full, zero, full, full, full, zero, zero, full, full, zero,
        ]
        .into_iter()
        .enumerate()
        {
            let destination = (index + 1) * record_words + element * width;
            expected[destination..destination + width].copy_from_slice(&fields[..width]);
        }
    }
    let arguments = (0..width)
        .map(|component| format!("input[index + {component}u]"))
        .collect::<Vec<_>>()
        .join(", ");
    let source_value = if vector {
        format!("make_{name}({arguments})")
    } else {
        String::from("Value(input[index])")
    };
    let source_mutation = if vector {
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
    let input_type = if prefix == "float" { "float" } else { "int" };
    let source = format!(
        "using Value = {name};
        __global__ void initialize(const {input_type} *input, unsigned *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            Value source = {source_value};
            Value fixed[3](source, source);
            Value inferred[](source, source);
            Value partial[3](source);
            Value braced[3]({{source}}, {{source}});
            {source_mutation}
            Value values[{VALUE_COUNT}]{{fixed[0], fixed[1], fixed[2], inferred[0], inferred[1],
                partial[0], partial[1], partial[2], braced[0], braced[1], braced[2]}};
            unsigned base = (index + 1u) * {record_words}u;
            for (unsigned element = 0; element < {VALUE_COUNT}u; ++element) {{
                {stores}
            }}
        }}"
    );
    array_case(
        &format!(
            "{name} arrays count {count} preserve copies, inferred bounds, defaults and guards"
        ),
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
                &input[..record_count + width - 1],
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

fn result_objects_case() -> ShaderTest {
    let source = "struct Pair { int first; int second; };
        __global__ void result_objects(unsigned *output) {
            Pair fixed[2](Pair(7, fixed[0].first + 1), Pair(11, fixed[1].first + 1));
            Pair inferred[](Pair(3, inferred[0].first + 1), Pair(5, ++inferred[0].first));
            Pair braced[](Pair{11, braced[0].first + 1}, Pair{13, ++braced[0].first});
            Pair source{17, 19};
            Pair copied[](source, Pair(23, 29));
            source.first = 31;
            int local = 7;
            int *non_null = &local;
            int *typed_null = (int *)0;
            bool flags[4](non_null, typed_null, bool(nullptr), 7);
            output[1] = unsigned(fixed[0].first); output[2] = unsigned(fixed[0].second);
            output[3] = unsigned(fixed[1].first); output[4] = unsigned(fixed[1].second);
            output[5] = unsigned(inferred[0].first); output[6] = unsigned(inferred[0].second);
            output[7] = unsigned(inferred[1].first); output[8] = unsigned(inferred[1].second);
            output[9] = unsigned(braced[0].first); output[10] = unsigned(braced[0].second);
            output[11] = unsigned(braced[1].first); output[12] = unsigned(braced[1].second);
            output[13] = unsigned(copied[0].first); output[14] = unsigned(copied[0].second);
            output[15] = unsigned(copied[1].first); output[16] = unsigned(copied[1].second);
            output[17] = unsigned(flags[0]); output[18] = unsigned(flags[1]);
            output[19] = unsigned(flags[2]); output[20] = unsigned(flags[3]);
        }";
    let initial = [SENTINEL; 28];
    let mut expected = initial;
    expected[1..21].copy_from_slice(&[
        7, 8, 11, 12, 4, 4, 5, 4, 12, 12, 13, 12, 17, 19, 23, 29, 1, 0, 0, 1,
    ]);
    array_case(
        "array elements use their own result objects and keep existing-object copies independent",
        source,
        [1, 1, 1],
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
    )
}

fn float_boolean_cases() -> Vec<ShaderTest> {
    let source = "__global__ void booleans(const float *input, unsigned *output, unsigned count) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            bool fixed[3](input[index], input[index]);
            bool inferred[](input[index], 0.0f);
            unsigned base = (index + 1u) * 5u;
            output[base] = unsigned(fixed[0]); output[base + 1u] = unsigned(fixed[1]);
            output[base + 2u] = unsigned(fixed[2]); output[base + 3u] = unsigned(inferred[0]);
            output[base + 4u] = unsigned(inferred[1]);
        }";
    let initial = [SENTINEL; 140];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7, 24] {
        let mut expected = initial;
        for (index, &bits) in FLOAT_BITS.iter().take(count as usize).enumerate() {
            let truth = u32::from(bits & 0x7fff_ffff != 0);
            let base = (index + 1) * 5;
            expected[base..base + 5].copy_from_slice(&[truth, truth, 0, truth, 0]);
        }
        tests.push(
            array_case(
                &format!(
                    "float to bool array conversions count {count} preserve IEEE truth values"
                ),
                source,
                [4, 1, 1],
                &expected,
                Capabilities::empty(),
            )
            .module_buffers(
                vec![
                    ShaderBuffer::new(
                        0,
                        wgpu::BufferBindingType::Storage { read_only: true },
                        &FLOAT_BITS,
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
            ),
        );
    }
    tests
}

fn reference_observations(input: i32) -> [u32; 64] {
    let value = input as u32 & 255;
    [
        value,
        value + 1,
        0,
        0,
        value,
        value + 2,
        value + 4,
        value + 1,
        value + 1,
        value + 1,
        value + 1,
        value + 3,
        0,
        value,
        value + 1,
        value + 2,
        value + 2,
        i32::from((value + 32768) as i16) as u32,
        u32::MAX,
        0,
        value,
        65535,
        0,
        (value as f32 + 0.5).to_bits(),
        3.75_f32.to_bits(),
        0,
        u32::from(value != 0),
        0,
        0,
        value,
        value + 1,
        0,
        value,
        value + 1,
        value + 2,
        0,
        0,
        0,
        value,
        value + 1,
        value + 2,
        0,
        value + 1,
        2,
        value + 3,
        0,
        value,
        1,
        1,
        1,
        1,
        1,
        value * 2 + 1,
        value + 7,
        value,
        value + 9,
        value + 100,
        value,
        u32::MAX,
        0,
        0,
        value + 11,
        value + 12,
        value + 12,
    ]
}

fn canonical_cases() -> Vec<ShaderTest> {
    let input = [i32::MIN, -1, i32::MAX, 1, 127, 128, 254, 255];
    let initial = [SENTINEL; 640];
    let mut tests = Vec::new();
    for count in [0_u32, 1, 3, 4, 5, 7, 8] {
        let mut expected = initial;
        for (index, &value) in input.iter().take(count as usize).enumerate() {
            expected[index * 64..(index + 1) * 64].copy_from_slice(&reference_observations(value));
        }
        tests.push(
            array_case(
                &format!("parenthesized arrays count {count} preserve sequencing, defaults and CUDA elision"),
                include_str!("../../../../../naga/tests/in/cuda/parenthesized-arrays.cu"),
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
            ),
        );
    }
    tests
}
