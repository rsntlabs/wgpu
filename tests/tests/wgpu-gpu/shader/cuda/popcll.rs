use super::{module_case_with_options_and_capabilities, Options, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn case(name: &str, source: &str, size: u32, expected: &[u32]) -> ShaderTest {
    module_case_with_options_and_capabilities(
        name,
        source,
        &Options {
            workgroup_size: [size, 1, 1],
            ..Default::default()
        },
        expected,
        naga::valid::Capabilities::SHADER_INT64,
    )
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
        0xaaaa_aaaa_aaaa_aaaa,
        0x5555_5555_5555_5555,
        0x0123_4567_89ab_cdef,
        0xfedc_ba98_7654_3210,
    ];
    for bit in 0..64 {
        words.push(1u64 << bit);
        words.push(!(1u64 << bit));
    }
    let mut mixed = 0x9e37_79b9_7f4a_7c15u64;
    for _ in 0..32 {
        mixed = mixed
            .wrapping_mul(6_364_136_223_846_793_005)
            .wrapping_add(1_442_695_040_888_963_407);
        words.push(mixed);
    }
    let mut expected = vec![SENTINEL; words.len() + 8];
    for (output, input) in expected[4..4 + words.len()].iter_mut().zip(&words) {
        *output = input.count_ones();
    }
    let source = format!("__global__ void kernel(int *output, const unsigned long long *input) {{ unsigned index = threadIdx.x; if (index < {}u) output[index + 4u] = __popcll(input[index]); }}", words.len());
    case("64-bit population counts cover both words, every bit position, complements, and mixed patterns", &source, 256, &expected)
        .module_buffers(vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL; expected.len()]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &words),
        ], 0, [1, 1, 1])
}

fn conversions() -> ShaderTest {
    let mut expected = [SENTINEL; 18];
    expected[4..14].copy_from_slice(&[64, 32, 2, u32::MAX, 1, 0, 64, 64, 1, 0]);
    case("64-bit population count converts signed, unsigned, Boolean, and floating arguments before counting", "__global__ void kernel(int *output) {
        output[4] = __popcll(-1);
        output[5] = __popcll(0xffffffffu);
        output[6] = __popcll(3.75f);
        output[7] = __popcll(3ULL) - 3;
        output[8] = __popcll(true);
        output[9] = __popcll(false);
        output[10] = __popcll(-1L);
        output[11] = __popcll(0xffffffffffffffffUL);
        output[12] = __popcll(0x100000000ULL);
        output[13] = __popcll(0ULL);
    }", 1, &expected).module_buffers(vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 18])], 0, [1, 1, 1])
}

fn overloads_and_side_effects() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[4..20].copy_from_slice(&[77, 99, 98, 1, 2, 204, 5, 17, 0, 5, 2, 1, 7, 2, 1, 32]);
    case("64-bit population count preserves source overload identity, captured arguments, and lazy branches", "using Word = unsigned long long;
    __device__ int __popcll(unsigned long value) { return 77; }
    __device__ int __popcll(bool value) { return value ? 99 : 98; }
    __device__ Word next(int value) { return Word(value); }
    __device__ int pair(int first, int second) { return first * 100 + second; }
    __global__ void kernel(int *output) {
        output[4] = __popcll(1UL);
        output[5] = __popcll(true);
        output[6] = __popcll(false);
        output[7] = __popcll(1ULL);
        Word word = 0x8000000000000001ULL;
        output[8] = __popcll(word);
        int counter = 3;
        output[9] = pair(__popcll(next(counter++)), counter++);
        output[10] = counter;
        bool choose = false;
        output[11] = choose ? __popcll(Word(counter++)) : 17;
        bool active = choose && __popcll(Word(counter++));
        output[12] = int(active); output[13] = counter;
        choose = true;
        output[14] = choose ? __popcll(Word(counter++)) : 17;
        active = choose && __popcll(Word(counter++));
        output[15] = int(active); output[16] = counter;
        output[17] = __popcll(3ULL);
        output[18] = __popcll(1ULL);
        output[19] = __popcll(0xffffffffULL);
    }", 1, &expected).module_buffers(vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 24])], 0, [1, 1, 1])
}
