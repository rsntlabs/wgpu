use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, Options, ShaderBuffer,
    ShaderTest,
};

const SENTINEL: u32 = 0xdead_beef;

fn case(name: &str, source: &str, size: u32, expected: &[u32]) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &Options {
            workgroup_size: [size, 1, 1],
            ..Default::default()
        },
        expected,
        naga::valid::Capabilities::SHADER_INT64,
    );
    test.output_comparison_fn = compare_words;
    test
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![dynamic_words(), conversions(), overloads_and_side_effects()]
}

fn dynamic_words() -> ShaderTest {
    let mut words = vec![
        0u64,
        1,
        2,
        u64::MAX,
        0xffff_ffff,
        0xffff_ffff_0000_0000,
        0x8000_0000_0000_0000,
        0x7fff_ffff_ffff_ffff,
        0xaaaa_aaaa_5555_5555,
        0x5555_5555_aaaa_aaaa,
        0x0123_4567_89ab_cdef,
        0xfedc_ba98_7654_3210,
    ];
    for bit in 0..64 {
        words.extend([1u64 << bit, !(1u64 << bit)]);
    }
    let mut mixed = 0x9e37_79b9_7f4a_7c15u64;
    for _ in 0..20 {
        mixed = mixed
            .wrapping_mul(6_364_136_223_846_793_005)
            .wrapping_add(1_442_695_040_888_963_407);
        words.push(mixed);
    }
    assert_eq!(words.len(), 160);
    let mut expected = vec![SENTINEL; words.len() + 8];
    for (output, &input) in expected[4..4 + words.len()].iter_mut().zip(&words) {
        *output = input.leading_zeros();
    }
    case(
        "64-bit leading zeros span both words, every bit position, complements, and mixed patterns",
        include_str!("../../../../../naga/tests/in/cuda/clzll.cu"),
        64,
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &vec![SENTINEL; expected.len()],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &words,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[words.len() as u32, 0x1234_5678, 0x9abc_def0, 0x55aa_55aa],
            ),
        ],
        0,
        [3, 1, 1],
    )
}

fn conversions() -> ShaderTest {
    let mut expected = [SENTINEL; 26];
    expected[4..22].copy_from_slice(&[
        64,
        0,
        32,
        62,
        63,
        64,
        0,
        0,
        31,
        32,
        0,
        1,
        1,
        31,
        0,
        1,
        17,
        u32::MAX,
    ]);
    case(
        "64-bit leading-zero counts convert source arguments and retain signed int results",
        "using Word = long long;
        __device__ int result_tag(int value) { return 17; }
        __device__ int result_tag(long value) { return 29; }
        __device__ int result_tag(Word value) { return 31; }
        __global__ void kernel(int *output) {
            output[4] = __clzll(0LL);
            output[5] = __clzll(-1);
            output[6] = __clzll(0xffffffffu);
            output[7] = __clzll(3.75f);
            output[8] = __clzll(true);
            output[9] = __clzll(false);
            output[10] = __clzll(-1L);
            output[11] = __clzll(0xffffffffffffffffUL);
            output[12] = __clzll(0x100000000ULL);
            output[13] = __clzll(0x80000000ULL);
            output[14] = __clzll(-9223372036854775807LL - 1LL);
            output[15] = __clzll(9223372036854775807LL);
            output[16] = __clzll(0x7fffffffffffffffULL);
            output[17] = __clzll(0x1ffffffffULL);
            output[18] = __clzll(0x8000000000000000ULL);
            output[19] = int((__clzll(1LL) - 64) < 0);
            auto count = __clzll(1LL);
            output[20] = result_tag(count);
            output[21] = __clzll(1LL) - 64;
        }",
        1,
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 26],
        )],
        0,
        [1, 1, 1],
    )
}

fn overloads_and_side_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 27];
    expected[4..23].copy_from_slice(&[
        77, 99, 98, 63, 0, 6204, 5, 17, 0, 5, 61, 1, 7, 62, 63, 32, 11, 11, 8,
    ]);
    case(
        "64-bit leading-zero counts preserve source overloads, snapshots, and lazy effects",
        "using Word = long long;
        __device__ int __clzll(const Word value);
        __device__ int __clzll(long value) { return 77; }
        __device__ int __clzll(bool value) { return value ? 99 : 98; }
        __device__ Word next(int value) { return Word(value); }
        __device__ int pair(int first, int second) { return first * 100 + second; }
        __device__ int result_tag(int value) { return 11; }
        __device__ int result_tag(long value) { return 22; }
        __device__ int result_tag(Word value) { return 33; }
        __global__ void kernel(int *output) {
            output[4] = __clzll(1L);
            output[5] = __clzll(true);
            output[6] = __clzll(false);
            output[7] = __clzll(1LL);
            output[8] = __clzll(-1LL);
            int counter = 3;
            output[9] = pair(__clzll(next(counter++)), counter++);
            output[10] = counter;
            bool choose = false;
            output[11] = choose ? __clzll(Word(counter++)) : 17;
            bool active = choose && __clzll(Word(counter++));
            output[12] = int(active);
            output[13] = counter;
            choose = true;
            output[14] = choose ? __clzll(Word(counter++)) : 17;
            active = choose && __clzll(Word(counter++));
            output[15] = int(active);
            output[16] = counter;
            output[17] = __clzll(3LL);
            output[18] = __clzll(1LL);
            output[19] = __clzll(0xffffffffLL);
            output[20] = result_tag(__clzll(1LL));
            output[21] = result_tag(__clzll(1L));
            __clzll(Word(counter++));
            output[22] = counter;
        }",
        1,
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 27],
        )],
        0,
        [1, 1, 1],
    )
}
