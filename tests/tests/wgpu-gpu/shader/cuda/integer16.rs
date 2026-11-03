use super::{module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const HALFWORD_SENTINEL: u16 = 0xa55a;

pub(super) fn compare_words(name: &str, actual: &[u32], expected: &[Vec<u32>]) -> bool {
    let [expected] = expected else {
        panic!("{name}: expected one reference buffer")
    };
    if actual == expected {
        return true;
    }
    eprintln!(
        "{name}: output length {}, expected {}",
        actual.len(),
        expected.len()
    );
    if let Some(index) = actual
        .iter()
        .zip(expected)
        .position(|(actual, expected)| actual != expected)
    {
        eprintln!(
            "{name}: word {index}: received {:08x}, expected {:08x}",
            actual[index], expected[index]
        );
    }
    false
}

fn integer16_case<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
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
    let mut tests = vec![
        unsigned_copy(),
        signed_copy(),
        signed_float_conversion(),
        unsigned_float_conversion(),
        exhaustive_promotions(),
        arithmetic_boundaries(),
        promoted_shifts(),
        shared_updates(),
    ];
    tests.extend(canonical_cases());
    tests
}

fn unsigned_copy() -> ShaderTest {
    let input = [1_u16, 32768, 65535, 4660];
    let mut expected = [HALFWORD_SENTINEL; 8];
    expected[1..4].copy_from_slice(&input[..3]);
    integer16_case(
        "unsigned short copies preserve adjacent halfwords and guards",
        "__global__ void copy(const unsigned short *input, unsigned short *output) {
            unsigned lane = threadIdx.x;
            if (lane < 3u) output[lane + 1u] = input[lane];
        }",
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
                &[HALFWORD_SENTINEL; 8],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn signed_copy() -> ShaderTest {
    let input = [i16::MIN, -1, i16::MAX, 0];
    let mut expected = [HALFWORD_SENTINEL as i16; 8];
    expected[1..4].copy_from_slice(&input[..3]);
    integer16_case(
        "short copies preserve signs, adjacent halfwords and guards",
        "__global__ void copy(const short *input, short *output) {
            unsigned lane = threadIdx.x;
            if (lane < 3u) output[lane + 1u] = input[lane];
        }",
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
                &[HALFWORD_SENTINEL as i16; 8],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn signed_float_conversion() -> ShaderTest {
    let input = [
        -32768.75_f32,
        -32768.0,
        -32767.75,
        -1.75,
        -0.75,
        -0.0,
        0.0,
        0.75,
        1.75,
        32766.75,
        32767.0,
        32767.75,
    ];
    let mut expected = [HALFWORD_SENTINEL as i16; 20];
    for (destination, value) in expected[1..13].iter_mut().zip(input) {
        *destination = value as i16;
    }
    integer16_case(
        "float to short truncates representable boundary values and preserves guards",
        "__global__ void convert(const float *input, short *output) {
            unsigned lane = threadIdx.x;
            if (lane < 12u) output[lane + 1u] = short(input[lane]);
        }",
        [16, 1, 1],
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
                &[HALFWORD_SENTINEL as i16; 20],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn unsigned_float_conversion() -> ShaderTest {
    let input = [
        -0.75_f32, -0.0, 0.0, 0.75, 1.75, 32767.75, 32768.0, 65534.75, 65535.0, 65535.75,
    ];
    let mut expected = [HALFWORD_SENTINEL; 20];
    for (destination, value) in expected[1..11].iter_mut().zip(input) {
        *destination = value as u16;
    }
    integer16_case(
        "float to unsigned short truncates representable boundary values and preserves guards",
        "__global__ void convert(const float *input, unsigned short *output) {
            unsigned lane = threadIdx.x;
            if (lane < 10u) output[lane + 1u] = (unsigned short)input[lane];
        }",
        [16, 1, 1],
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
                &[HALFWORD_SENTINEL; 20],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn exhaustive_promotions() -> ShaderTest {
    let mut input: Vec<u16> = (0..=u16::MAX).collect();
    input.extend([HALFWORD_SENTINEL; 64]);
    let output_len = (65536 + 64) * 12 + 12;
    let mut expected = vec![SENTINEL; output_len];
    for unsigned in 0..=u16::MAX {
        let signed = i32::from(unsigned as i16);
        let promoted = i32::from(unsigned);
        let shifted = promoted.wrapping_shl(16);
        let converted = unsigned.wrapping_add(32768) as i16;
        let values = [
            signed as u32,
            promoted as u32,
            (-promoted) as u32,
            (!promoted) as u32,
            (-signed) as u32,
            (!signed) as u32,
            i32::from(converted) as u32,
            u32::from(unsigned != 0),
            (signed as f32).to_bits(),
            (promoted as f32).to_bits(),
            (promoted + promoted) as u32,
            shifted as u32,
        ];
        let offset = 4 + usize::from(unsigned) * values.len();
        expected[offset..offset + values.len()].copy_from_slice(&values);
    }
    integer16_case(
        "all 65536 halfwords preserve promotions, integer casts, truth and exact float conversion",
        "typedef unsigned short UnsignedShort;
        __global__ void promote(const UnsignedShort *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 65536u) return;
            UnsignedShort unsigned_value = input[index];
            short signed_value = (short)unsigned_value;
            unsigned base = 4u + index * 12u;
            output[base] = signed_value;
            output[base + 1u] = +unsigned_value;
            output[base + 2u] = -unsigned_value;
            output[base + 3u] = ~unsigned_value;
            output[base + 4u] = -signed_value;
            output[base + 5u] = ~signed_value;
            output[base + 6u] = short(unsigned_value + 32768u);
            output[base + 7u] = bool(unsigned_value);
            output[base + 8u] = __float_as_uint(float(signed_value));
            output[base + 9u] = __float_as_uint(float(unsigned_value));
            output[base + 10u] = unsigned_value + unsigned_value;
            output[base + 11u] = unsigned_value << 16;
        }",
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
                &vec![SENTINEL; output_len],
            ),
        ],
        1,
        [1025, 1, 1],
    )
}

fn arithmetic_boundaries() -> ShaderTest {
    let mut signed_input = Vec::new();
    let mut unsigned_input = Vec::new();
    let mut expected = vec![SENTINEL; 4 + 64 * 14 + 4];
    for signed in [i16::MIN, -1, 0, 1, i16::MAX] {
        for unsigned in [0_u16, 1, 2, 32767, 32768, 65535] {
            let index = signed_input.len();
            signed_input.push(signed);
            unsigned_input.push(unsigned);
            let signed = i32::from(signed);
            let unsigned = i32::from(unsigned);
            let signed_divisor = if signed == 0 { 1 } else { signed };
            let unsigned_divisor = if unsigned == 0 { 1 } else { unsigned };
            let values = [
                (signed + unsigned) as u32,
                (signed - unsigned) as u32,
                (signed * unsigned) as u32,
                (signed / unsigned_divisor) as u32,
                (signed % unsigned_divisor) as u32,
                (unsigned / signed_divisor) as u32,
                (unsigned % signed_divisor) as u32,
                u32::from(signed < unsigned),
                u32::from(signed == unsigned),
                (signed & unsigned) as u32,
                (signed | unsigned) as u32,
                (signed ^ unsigned) as u32,
                unsigned.wrapping_shl(16) as u32,
                if signed < 0 {
                    signed as u32
                } else {
                    unsigned as u32
                },
            ];
            let offset = 4 + index * values.len();
            expected[offset..offset + values.len()].copy_from_slice(&values);
        }
    }
    integer16_case(
        "short arithmetic and comparisons use signed int across signedness boundaries",
        "__global__ void arithmetic(const short *signed_input,
                                   const unsigned short *unsigned_input, unsigned *output) {
            unsigned index = threadIdx.x;
            if (index >= 30u) return;
            short signed_value = signed_input[index];
            unsigned short unsigned_value = unsigned_input[index];
            int signed_divisor = signed_value == 0 ? 1 : signed_value;
            int unsigned_divisor = unsigned_value == 0 ? 1 : unsigned_value;
            unsigned base = 4u + index * 14u;
            output[base] = signed_value + unsigned_value;
            output[base + 1u] = signed_value - unsigned_value;
            output[base + 2u] = signed_value * unsigned_value;
            output[base + 3u] = signed_value / unsigned_divisor;
            output[base + 4u] = signed_value % unsigned_divisor;
            output[base + 5u] = unsigned_value / signed_divisor;
            output[base + 6u] = unsigned_value % signed_divisor;
            output[base + 7u] = signed_value < unsigned_value;
            output[base + 8u] = signed_value == unsigned_value;
            output[base + 9u] = signed_value & unsigned_value;
            output[base + 10u] = signed_value | unsigned_value;
            output[base + 11u] = signed_value ^ unsigned_value;
            output[base + 12u] = unsigned_value << 16;
            output[base + 13u] = signed_value < 0 ? signed_value : unsigned_value;
        }",
        [64, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &signed_input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &unsigned_input,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Storage { read_only: false },
                &vec![SENTINEL; expected.len()],
            ),
        ],
        2,
        [1, 1, 1],
    )
}

fn promoted_shifts() -> ShaderTest {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4 + 256 * 3 + 4];
    for signed in [i16::MIN, -32767, -3, -1, 0, 1, i16::MAX] {
        for count in 0..32 {
            let index = input.len();
            input.push(signed);
            let signed = i32::from(signed);
            let values = [
                signed.wrapping_shl(count) as u32,
                (signed >> count) as u32,
                u32::from(signed as u16).wrapping_shl(count),
            ];
            expected[4 + index * 3..7 + index * 3].copy_from_slice(&values);
        }
    }
    integer16_case(
        "all promoted shift counts retain int width and arithmetic right shift",
        "__global__ void shifts(const short *input, unsigned *output) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index >= 224u) return;
            short value = input[index];
            short shift = short(index % 32u);
            unsigned short unsigned_value = (unsigned short)value;
            unsigned base = 4u + index * 3u;
            output[base] = value << shift;
            output[base + 1u] = value >> shift;
            output[base + 2u] = unsigned_value << shift;
        }",
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
                &vec![SENTINEL; expected.len()],
            ),
        ],
        1,
        [4, 1, 1],
    )
}

fn shared_updates() -> ShaderTest {
    let signed_input = [i16::MAX, i16::MIN, -1, 0];
    let unsigned_input = [u16::MAX, 0, 32767, 32768];
    let mut expected = vec![SENTINEL; 40];
    let mut signed_results = [0_i16; 4];
    let mut unsigned_results = [0_u16; 4];
    for lane in 0..4 {
        let signed = signed_input[lane].wrapping_add(2);
        let unsigned = unsigned_input[lane].wrapping_add(2);
        signed_results[lane] = (i32::from(signed) + i32::from(unsigned)) as i16;
        unsigned_results[lane] = (i32::from(unsigned) - i32::from(signed_results[lane])) as u16;
    }
    for lane in 0..4 {
        let neighbor = (lane + 1) % 4;
        let values = [
            i32::from(signed_input[lane]) as u32,
            i32::from(signed_input[lane].wrapping_add(2)) as u32,
            u32::from(unsigned_input[lane]),
            u32::from(unsigned_input[lane].wrapping_add(2)),
            i32::from(signed_results[lane]) as u32,
            u32::from(unsigned_results[lane]),
            i32::from(signed_results[neighbor]) as u32,
            u32::from(unsigned_results[neighbor]),
        ];
        expected[4 + lane * 8..12 + lane * 8].copy_from_slice(&values);
    }
    integer16_case(
        "short updates narrow after int arithmetic and synchronize native shared values",
        "__global__ void updated(const short *signed_input,
                                const unsigned short *unsigned_input, unsigned *output) {
            __shared__ short signed_tile[4];
            __shared__ unsigned short unsigned_tile[4];
            unsigned lane = threadIdx.x;
            short signed_value = signed_input[lane];
            unsigned short unsigned_value = unsigned_input[lane];
            unsigned base = 4u + lane * 8u;
            output[base] = signed_value++;
            output[base + 1u] = ++signed_value;
            output[base + 2u] = unsigned_value++;
            output[base + 3u] = ++unsigned_value;
            signed_value += unsigned_value;
            unsigned_value -= signed_value;
            signed_tile[lane] = signed_value;
            unsigned_tile[lane] = unsigned_value;
            __syncthreads();
            unsigned neighbor = (lane + 1u) % 4u;
            output[base + 4u] = signed_value;
            output[base + 5u] = unsigned_value;
            output[base + 6u] = signed_tile[neighbor];
            output[base + 7u] = unsigned_tile[neighbor];
        }",
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &signed_input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &unsigned_input,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Storage { read_only: false },
                &vec![SENTINEL; expected.len()],
            ),
        ],
        2,
        [1, 1, 1],
    )
}

fn canonical_cases() -> Vec<ShaderTest> {
    let records = [
        (i16::MIN, u16::MAX, 0x0123_4567, -1_i16, u16::MAX),
        (i16::MAX, 0, 0x89ab_cdef, 0, 0),
        (32765, 32768, 0xffff_fffe, i16::MAX, 32768),
        (-3, 32767, 0x8000_0000, i16::MIN, 32767),
        (0, 1, 0, 1, 0x1234),
        (1, 65534, u32::MAX, -2, u16::MAX),
        (-1, 32769, 0x5555_aaaa, 2, 65534),
        (2, 2, 0xaaaa_aaaa, -32767, 32767),
    ];
    let input: Vec<_> = records
        .iter()
        .flat_map(|&(signed, unsigned, wide, tail, tag)| {
            [
                u32::from(signed as u16) | (u32::from(unsigned) << 16),
                wide,
                u32::from(tail as u16) | (u32::from(tag) << 16),
            ]
        })
        .collect();
    let mut tests = Vec::new();
    for count in [0_u16, 1, 3, 4, 5, 7] {
        let mut expected_records = vec![SENTINEL; 30];
        let mut expected_observations = vec![SENTINEL; 160];
        for index in 0..usize::from(count) {
            let (signed, unsigned, _, tail, tag) = records[index];
            let changed_signed = -(i32::from(signed.wrapping_add(3)));
            let changed_signed = changed_signed as i16;
            let changed_unsigned = unsigned.wrapping_add(1).wrapping_shl(1);
            let promoted_sum = u32::from(unsigned) * 2;
            let changed_tail = !tail;
            let changed_tag = tag.wrapping_add(1);
            expected_records[index * 3..index * 3 + 3].copy_from_slice(&[
                u32::from(changed_signed as u16) | (u32::from(changed_unsigned) << 16),
                promoted_sum,
                u32::from(changed_tail as u16) | (u32::from(changed_tag) << 16),
            ]);
            let promoted_unsigned = i32::from(unsigned);
            let values = [
                promoted_sum,
                31,
                41,
                43,
                41,
                43,
                u32::from(unsigned),
                (-promoted_unsigned) as u32,
                (!promoted_unsigned) as u32,
                32768,
                u32::from(i32::from(signed) < promoted_unsigned),
                u32::from((i32::from(signed) as u32) < 1),
                i32::from(changed_signed) as u32,
                u32::from(changed_unsigned),
                i32::from(tail) as u32,
                41,
            ];
            expected_observations[index * 16..index * 16 + 16].copy_from_slice(&values);
        }
        let uniform = [
            u32::from(count) | 0xa55a_0000,
            0x0123_4567,
            0x89ab_cdef,
            0x55aa_33cc,
        ];
        for (name, output_binding, expected) in [
            ("records", 1, expected_records),
            ("observations", 2, expected_observations),
        ] {
            tests.push(
                integer16_case(
                    &format!("canonical short {name} preserve packed layout and scalar uniform count {count}"),
                    include_str!("../../../../../naga/tests/in/cuda/integer16.cu"),
                    [4, 1, 1],
                    &expected,
                )
                .module_buffers(
                    vec![
                        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
                        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 30]),
                        ShaderBuffer::new(2, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 160]),
                        ShaderBuffer::new(3, wgpu::BufferBindingType::Uniform, &uniform),
                    ],
                    output_binding,
                    [u32::from(count).div_ceil(4).max(1), 1, 1],
                ),
            );
        }
    }
    tests
}
