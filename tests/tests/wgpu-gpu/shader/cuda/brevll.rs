use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, Options, ShaderBuffer,
    ShaderTest,
};

const SENTINEL: u64 = 0xdead_beef_dead_beef;

fn packed_words(values: &[u64]) -> Vec<u32> {
    values
        .iter()
        .flat_map(|&value| [value as u32, (value >> 32) as u32])
        .collect()
}

fn case(name: &str, source: &str, size: u32, expected: &[u64]) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &Options {
            workgroup_size: [size, 1, 1],
            ..Default::default()
        },
        &packed_words(expected),
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
        *output = input.reverse_bits();
    }
    case(
        "64-bit reversal swaps words and reverses every bit, complements, and mixed patterns",
        include_str!("../../../../../naga/tests/in/cuda/brevll.cu"),
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
    let mut expected = [SENTINEL; 20];
    expected[4..16].copy_from_slice(&[
        u64::MAX,
        0xffff_ffff_0000_0000,
        0xc000_0000_0000_0000,
        0x8000_0000_0000_0000,
        0,
        u64::MAX,
        u64::MAX,
        0x8000_0000,
        1,
        0,
        17,
        0x0123_4567_89ab_cdefu64.reverse_bits(),
    ]);
    case(
        "64-bit reversal converts argument types and retains unsigned long long result identity",
        "using Word = unsigned long long;
        __device__ int result_tag(Word value) { return 17; }
        __device__ int result_tag(unsigned long value) { return 29; }
        __device__ int result_tag(int value) { return 31; }
        __global__ void kernel(Word *output) {
            output[4] = __brevll(-1);
            output[5] = __brevll(0xffffffffu);
            output[6] = __brevll(3.75f);
            output[7] = __brevll(true);
            output[8] = __brevll(false);
            output[9] = __brevll(-1L);
            output[10] = __brevll(0xffffffffffffffffUL);
            output[11] = __brevll(0x100000000ULL);
            output[12] = __brevll(1ULL) >> 63;
            output[13] = Word(__brevll(1ULL) < 0);
            auto reversed = __brevll(1ULL);
            output[14] = Word(result_tag(reversed));
            output[15] = __brevll(0x0123456789abcdefULL);
        }",
        1,
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 20],
        )],
        0,
        [1, 1, 1],
    )
}

fn overloads_and_side_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 28];
    expected[4..24].copy_from_slice(&[
        77,
        99,
        98,
        0x8000_0000_0000_0000,
        0x8000_0000_0000_0001,
        0xc000_0000_0000_0004,
        5,
        17,
        0,
        5,
        0xa000_0000_0000_0000,
        1,
        7,
        0xc000_0000_0000_0000,
        1,
        0xffff_ffff_0000_0000,
        11,
        11,
        0xe000_0000_0000_0000,
        8,
    ]);
    case(
        "64-bit reversal preserves overload identity, argument snapshots, and lazy effects",
        "using Word = unsigned long long;
        __device__ Word __brevll(const Word value);
        __device__ Word __brevll(unsigned long value) { return 77ULL; }
        __device__ Word __brevll(bool value) { return value ? 99ULL : 98ULL; }
        __device__ Word next(int value) { return Word(value); }
        __device__ Word pair(Word first, int second) { return first | Word(second); }
        __device__ int result_tag(Word value) { return 11; }
        __device__ int result_tag(unsigned long value) { return 22; }
        __device__ int result_tag(int value) { return 33; }
        __global__ void kernel(Word *output) {
            output[4] = __brevll(1UL);
            output[5] = __brevll(true);
            output[6] = __brevll(false);
            output[7] = __brevll(1ULL);
            Word word = 0x8000000000000001ULL;
            output[8] = __brevll(word);
            int counter = 3;
            output[9] = pair(__brevll(next(counter++)), counter++);
            output[10] = Word(counter);
            bool choose = false;
            output[11] = choose ? __brevll(Word(counter++)) : 17ULL;
            bool active = choose && __brevll(Word(counter++));
            output[12] = Word(active);
            output[13] = Word(counter);
            choose = true;
            output[14] = choose ? __brevll(Word(counter++)) : 17ULL;
            active = choose && __brevll(Word(counter++));
            output[15] = Word(active);
            output[16] = Word(counter);
            output[17] = __brevll(3ULL);
            output[18] = __brevll(1ULL) >> 63;
            output[19] = __brevll(0xffffffffULL);
            output[20] = Word(result_tag(__brevll(1ULL)));
            output[21] = Word(result_tag(__brevll(1UL)));
            output[22] = __brevll(Word(counter++));
            output[23] = Word(counter);
        }",
        1,
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 28],
        )],
        0,
        [1, 1, 1],
    )
}
