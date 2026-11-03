use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};
use naga::valid::Capabilities;

const SENTINEL: u32 = 0xdead_beef;
const CONSTRUCTION_COUNT: usize = 7;

fn aggregate_case(
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
    let mut tests = vector_cases(&["float", "int", "uint"], Capabilities::empty());
    tests.push(braced_copy_case());
    tests.push(result_object_case());
    tests
}

pub(super) fn integer16_cases() -> Vec<ShaderTest> {
    let mut tests = vector_cases(&["short", "ushort"], Capabilities::SHADER_INT16);
    tests.extend(canonical_cases());
    tests
}

fn vector_cases(prefixes: &[&str], capabilities: Capabilities) -> Vec<ShaderTest> {
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
            input[..exceptional_bits.len()].copy_from_slice(&exceptional_bits);
        }
        for width in 1..=4 {
            tests.push(vector_case(
                prefix,
                width,
                65536,
                &input,
                65536,
                capabilities,
            ));
            for count in [0, 1, 3, 4, 5, 7] {
                tests.push(vector_case(prefix, width, count, &input, 8, capabilities));
            }
        }
    }
    tests
}

fn encoded_field(prefix: &str, bits: u32) -> u32 {
    match prefix {
        "short" => i32::from(bits as i16) as u32,
        "ushort" => u32::from(bits as u16),
        _ => bits,
    }
}

fn vector_case(
    prefix: &str,
    width: usize,
    count: u32,
    input: &[u32],
    record_count: usize,
    capabilities: Capabilities,
) -> ShaderTest {
    let name = format!("{prefix}{width}");
    let record_words = CONSTRUCTION_COUNT * width;
    let initial = vec![SENTINEL; (record_count + 4) * record_words];
    let mut expected = initial.clone();
    for index in 0..count as usize {
        let mut full = [0; 4];
        for component in 0..width {
            full[component] = encoded_field(prefix, input[index + component]);
        }
        let partial = [full[0], 0, 0, 0];
        for (construction, fields) in [full, full, partial, partial, partial, full, partial]
            .into_iter()
            .enumerate()
        {
            let destination = (index + 1) * record_words + construction * width;
            expected[destination..destination + width].copy_from_slice(&fields[..width]);
        }
    }
    let arguments = (0..width)
        .map(|component| format!("input[index + {component}u]"))
        .collect::<Vec<_>>()
        .join(", ");
    let stores = ["x", "y", "z", "w"]
        .into_iter()
        .take(width)
        .enumerate()
        .map(|(component, field)| {
            let field = format!("values[construction].{field}");
            let encoded = if prefix == "float" {
                format!("__float_as_uint({field})")
            } else {
                format!("unsigned({field})")
            };
            format!("output[base + construction * {width}u + {component}u] = {encoded};")
        })
        .collect::<Vec<_>>()
        .join("\n");
    let scalar = if prefix == "float" { "float" } else { "int" };
    let source = format!(
        "using Vector = {name};
        __global__ void construct(const {scalar} *input, unsigned *output, unsigned count) {{
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= count) return;
            Vector direct({arguments});
            Vector functional = Vector({arguments});
            Vector partial = Vector(input[index]);
            Vector named = static_cast<Vector>(input[index]);
            Vector c_style = (Vector)input[index];
            Vector copied = Vector(direct);
            Vector direct_partial(input[index]);
            Vector values[{CONSTRUCTION_COUNT}]{{direct, functional, partial, named, c_style, copied, direct_partial}};
            unsigned base = (index + 1u) * {record_words}u;
            for (unsigned construction = 0; construction < {CONSTRUCTION_COUNT}u; ++construction) {{
                {stores}
            }}
        }}"
    );
    aggregate_case(
        &format!("{name} count {count} parenthesized forms preserve fields, defaults and guards"),
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

fn braced_copy_case() -> ShaderTest {
    let source = "struct Pair { int first; int second; };
        struct Outer { Pair value; int tail; };
        __global__ void copies(unsigned *output) {
            Pair direct({1, 2}); Pair functional = Pair({3, 5});
            int2 vector({7, 11}); int2 converted = int2({13, 17});
            Outer partial = Outer({19, 23}); Outer whole = Outer({29, 31, 37});
            output[1] = unsigned(direct.first); output[2] = unsigned(direct.second);
            output[3] = unsigned(functional.first); output[4] = unsigned(functional.second);
            output[5] = unsigned(vector.x); output[6] = unsigned(vector.y);
            output[7] = unsigned(converted.x); output[8] = unsigned(converted.y);
            output[9] = unsigned(partial.value.first); output[10] = unsigned(partial.value.second);
            output[11] = unsigned(partial.tail); output[12] = unsigned(whole.value.first);
            output[13] = unsigned(whole.value.second); output[14] = unsigned(whole.tail);
        }";
    let initial = [SENTINEL; 20];
    let mut expected = initial;
    expected[1..15].copy_from_slice(&[1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 0, 29, 31, 37]);
    aggregate_case(
        "single braced arguments copy the complete aggregate and preserve guards",
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

fn result_object_case() -> ShaderTest {
    let source = "struct Pair { int first; int second; };
        struct Envelope { Pair value; };
        __global__ void result_objects(unsigned *output) {
            Pair self = Pair(3, self.first + 1);
            Pair modified = Pair(5, ++modified.first);
            int2 vector = int2(7, vector.x + 1);
            Pair grouped = (Pair(11, grouped.first + 1));
            Pair nested = Pair(Pair(13, nested.first + 1));
            Pair direct(Pair(17, direct.first + 1));
            Pair casted = static_cast<Pair>(Pair(19, casted.first + 1));
            int counter = 0;
            Pair comma = (++counter, Pair(23, comma.first + counter));
            int choose_first = 1;
            Pair first = choose_first ? Pair(29, first.first + 1) : Pair(31, first.first + 2);
            int choose_second = 0;
            Pair second = choose_second ? Pair(37, second.first + 1) : Pair(41, second.first + 2);
            Pair array[1]{Pair(47, array[0].first + 1)};
            Envelope object{Pair(53, object.value.first + 1)};
            Pair existing{11, 13};
            existing = Pair(17, existing.first + 2);
            Pair original{59, 61};
            Pair copied = Pair(original);
            original.first = 67;
            Pair source{71, 73};
            Pair mixed_first = true ? Pair(79, mixed_first.first + 1) : source;
            Pair mixed_second = false ? Pair(83, mixed_second.first + 1) : source;
            source.first = 89;
            const Pair &retained = Pair(97, 101);
            Pair reference_copy = Pair(retained);
            reference_copy.first = 103;
            output[1] = unsigned(self.first); output[2] = unsigned(self.second);
            output[3] = unsigned(modified.first); output[4] = unsigned(modified.second);
            output[5] = unsigned(vector.x); output[6] = unsigned(vector.y);
            output[7] = unsigned(grouped.first); output[8] = unsigned(grouped.second);
            output[9] = unsigned(nested.first); output[10] = unsigned(nested.second);
            output[11] = unsigned(direct.first); output[12] = unsigned(direct.second);
            output[13] = unsigned(casted.first); output[14] = unsigned(casted.second);
            output[15] = unsigned(comma.first); output[16] = unsigned(comma.second);
            output[17] = unsigned(counter);
            output[18] = unsigned(first.first); output[19] = unsigned(first.second);
            output[20] = unsigned(second.first); output[21] = unsigned(second.second);
            output[22] = unsigned(array[0].first); output[23] = unsigned(array[0].second);
            output[24] = unsigned(object.value.first); output[25] = unsigned(object.value.second);
            output[26] = unsigned(existing.first); output[27] = unsigned(existing.second);
            output[28] = unsigned(copied.first); output[29] = unsigned(copied.second);
            output[30] = unsigned(mixed_first.first); output[31] = unsigned(mixed_first.second);
            output[32] = unsigned(mixed_second.first); output[33] = unsigned(mixed_second.second);
            output[34] = unsigned(retained.first); output[35] = unsigned(reference_copy.first);
            output[36] = unsigned(reference_copy.second);
        }";
    let initial = [SENTINEL; 44];
    let mut expected = initial;
    expected[1..37].copy_from_slice(&[
        3, 4, 6, 6, 7, 8, 11, 12, 13, 14, 17, 18, 19, 20, 23, 24, 1, 29, 30, 41, 43, 47, 48, 53,
        54, 17, 13, 59, 61, 79, 80, 71, 73, 97, 103, 101,
    ]);
    aggregate_case(
        "aggregate prvalues initialize their destination while assignments retain independent values",
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

fn reference_observations(input: i32) -> [u32; 64] {
    let value = input as u32 & 255;
    let mut expected = [0; 64];
    expected[0..4].fill((value as f32 + 0.5).to_bits());
    expected[4..8].fill((value as i32 - 128) as u32);
    expected[8..12].fill(value + 65535);
    expected[12..16].fill(i32::from((value + 32768) as i16) as u32);
    expected[16..20].fill(value);
    expected[21..40].copy_from_slice(&[
        value,
        value + 1,
        value,
        value + 2,
        i32::from((value + 32771) as i16) as u32,
        value,
        value + 1,
        value + 100,
        value + 100,
        0,
        0,
        1,
        1,
        3,
        0,
        7,
        3,
        value + 1,
        value + 1,
    ]);
    expected[40..64].copy_from_slice(&[
        value,
        value + 1,
        value + 2,
        value,
        value + 3,
        value + 4,
        0,
        0,
        value + 5,
        value + 6,
        0,
        value + 8,
        value + 9,
        0,
        value + 10,
        0,
        0,
        value + 11,
        0,
        0,
        2,
        1,
        1,
        3,
    ]);
    expected
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
            aggregate_case(
                &format!("parenthesized aggregates count {count} preserve sequencing and CUDA member elision"),
                include_str!("../../../../../naga/tests/in/cuda/parenthesized-aggregates.cu"),
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
