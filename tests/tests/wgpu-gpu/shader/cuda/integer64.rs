use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};

const SENTINEL: u32 = 0xdead_beef;
const CAPACITY: usize = 160;
const COUNTS: [usize; 7] = [0, 1, 2, 63, 64, 65, CAPACITY];
const SHIFTS: [u32; 5] = [0, 1, 31, 32, 63];
const SIGNED_DIVISORS: [i64; 6] = [1, -1, 3, -3, 7, -7];
const UNSIGNED_DIVISORS: [u64; 8] = [1, 2, 3, 7, 0xffff_ffff, 0x1_0000_0001, 1 << 63, u64::MAX];

fn integer64_case(name: &str, source: &str, expected: &[u32]) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &naga::front::cuda::Options {
            workgroup_size: [64, 1, 1],
            ..Default::default()
        },
        expected,
        naga::valid::Capabilities::SHADER_INT64,
    );
    test.output_comparison_fn = compare_words;
    test
}

fn storage_buffer<T: bytemuck::Pod>(binding: u32, read_only: bool, values: &[T]) -> ShaderBuffer {
    ShaderBuffer::new(
        binding,
        wgpu::BufferBindingType::Storage { read_only },
        values,
    )
}

fn count_buffer(binding: u32, count: usize) -> ShaderBuffer {
    ShaderBuffer::new(
        binding,
        wgpu::BufferBindingType::Uniform,
        &[count as u32, 0x1234_5678, 0x9abc_def0, 0x55aa_55aa],
    )
}

fn append_pair(words: &mut Vec<u32>, value: u64) {
    words.extend([value as u32, (value >> 32) as u32]);
}

fn data_bits() -> Vec<u64> {
    let mut values = vec![
        0,
        1,
        u64::MAX,
        1 << 63,
        i64::MAX as u64,
        1 << 32,
        (1 << 32) + 1,
        u32::MAX as u64,
        0x0123_4567_89ab_cdef,
        0xfedc_ba98_7654_3210,
        0xaaaa_aaaa_5555_5555,
        0x5555_5555_aaaa_aaaa,
    ];
    for bit in 0..64 {
        values.extend([1_u64 << bit, !(1_u64 << bit)]);
    }
    let mut mixed = 0x9e37_79b9_7f4a_7c15_u64;
    while values.len() < CAPACITY {
        mixed = mixed
            .wrapping_mul(6_364_136_223_846_793_005)
            .wrapping_add(1_442_695_040_888_963_407);
        values.push(mixed);
    }
    assert_eq!(values.len(), CAPACITY);
    values
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![literal_types(), float_to_integer(), integer_to_float()];
    for count in COUNTS {
        tests.push(arithmetic(count));
    }
    tests
}

pub(super) fn storage_cases() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for count in COUNTS {
        tests.push(copy(false, count));
        tests.push(copy(true, count));
    }
    tests.push(records());
    tests
}

fn literal_types() -> ShaderTest {
    let mut expected = vec![SENTINEL; 64];
    let mut values = Vec::new();
    for value in [
        i64::MIN as u64,
        i64::MAX as u64,
        u64::MAX,
        1 << 63,
        1 << 63,
        1 << 32,
        (-4_294_967_297_i64) as u64,
        0x1234_5678_9abc_def0,
        1,
    ] {
        append_pair(&mut values, value);
    }
    values.extend([6, 6, 3, 3, 3, 3, 3, 3, 3, 3]);
    values.extend([3, 6, 6, 3, 1, 0, 6, 3]);
    values.extend([6, 1, 3, 1, 3, 1, 3, 1, 6, 2, 3, 2, 3, 2, 3, 2]);
    assert_eq!(values.len(), 52);
    expected[2..54].copy_from_slice(&values);
    integer64_case(
        "long long literals, native suffix typing, signed minimum, aliases and high words",
        "using Signed = long long;
        typedef unsigned long long Unsigned;
        __device__ unsigned kind(Signed value) { return 6u; }
        __device__ unsigned kind(Unsigned value) { return 3u; }
        __device__ void put(unsigned *output, unsigned offset, Unsigned value) {
            output[offset] = unsigned(value); output[offset + 1u] = unsigned(value >> 32u);
        }
        __global__ void literal_types(unsigned *output) {
            if (threadIdx.x != 0u) return;
            Signed minimum = -9223372036854775807LL - 1LL;
            put(output, 2u, minimum);
            put(output, 4u, 9223372036854775807LL);
            put(output, 6u, 18446744073709551615ULL);
            put(output, 8u, 9223372036854775808LL);
            put(output, 10u, -9223372036854775808LL);
            put(output, 12u, 1LL + 0xffffffffu);
            put(output, 14u, -4294967297LL);
            put(output, 16u, 0x1234'5678'9abc'def0uLL);
            Unsigned empty = Unsigned(); put(output, 18u, empty + 1ULL);
            output[20] = kind(1lL); output[21] = kind(1Ll);
            output[22] = kind(1ulL); output[23] = kind(1uLl);
            output[24] = kind(1UlL); output[25] = kind(1ULl);
            output[26] = kind(1lLu); output[27] = kind(1lLU);
            output[28] = kind(1Llu); output[29] = kind(1LlU);
            output[30] = kind(9223372036854775808LL);
            output[31] = kind(minimum);
            output[32] = kind(9223372036854775807LL);
            output[33] = kind(0x8000000000000000LL);
            output[34] = unsigned(bool(minimum)); output[35] = unsigned(bool(0ULL));
            output[36] = kind(1LL + 0xffffffffu); output[37] = kind(-1LL + 1ULL);
            output[38] = kind(min(1LL, 2LL)); output[39] = unsigned(min(1LL, 2LL));
            output[40] = kind(min(1ULL, 2ULL)); output[41] = unsigned(min(1ULL, 2ULL));
            output[42] = kind(min(1LL, 2ULL)); output[43] = unsigned(min(1LL, 2ULL));
            output[44] = kind(min(1ULL, 2LL)); output[45] = unsigned(min(1ULL, 2LL));
            output[46] = kind(max(1LL, 2LL)); output[47] = unsigned(max(1LL, 2LL));
            output[48] = kind(max(1ULL, 2ULL)); output[49] = unsigned(max(1ULL, 2ULL));
            output[50] = kind(max(1LL, 2ULL)); output[51] = unsigned(max(1LL, 2ULL));
            output[52] = kind(max(1ULL, 2LL)); output[53] = unsigned(max(1ULL, 2LL));
        }",
        &expected,
    )
    .module_buffers(
        vec![storage_buffer(0, false, &[SENTINEL; 64])],
        0,
        [1, 1, 1],
    )
}

fn arithmetic(count: usize) -> ShaderTest {
    const WORDS: usize = 48;
    const SIGNED_VALUES: [i64; 16] = [
        0,
        1,
        -1,
        7,
        -7,
        2_147_483_647,
        -2_147_483_647,
        2_147_483_649,
        -2_147_483_649,
        4_294_967_295,
        4_294_967_296,
        -4_294_967_297,
        1_099_511_627_783,
        -1_099_511_627_783,
        63,
        -65,
    ];
    let bits = data_bits();
    let mut signed_input = vec![0x5aa5_5aa5_5aa5_5aa5_i64];
    let mut unsigned_input = vec![0x5aa5_5aa5_5aa5_5aa5_u64; 2];
    let mut controls = vec![0x5aa5_5aa5_u32; 2];
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * WORDS];
    for (index, &unsigned) in bits.iter().enumerate() {
        let signed = SIGNED_VALUES[index % SIGNED_VALUES.len()];
        let shift = SHIFTS[index % SHIFTS.len()];
        let signed_divisor = SIGNED_DIVISORS[index % SIGNED_DIVISORS.len()];
        let unsigned_divisor = UNSIGNED_DIVISORS[index % UNSIGNED_DIVISORS.len()];
        signed_input.push(signed);
        unsigned_input.extend([unsigned, unsigned_divisor]);
        controls.extend([shift, signed_divisor as u32]);
        if index >= count {
            continue;
        }
        let mut row = Vec::new();
        for value in [
            (signed + i64::from(u32::MAX)) as u64,
            (signed - i64::from(u32::MAX)) as u64,
            (signed as u64).wrapping_add(unsigned),
            unsigned.wrapping_add(0x1_0000_0001),
            (signed * 3) as u64,
            (signed / signed_divisor) as u64,
            (signed % signed_divisor) as u64,
            unsigned / unsigned_divisor,
            unsigned % unsigned_divisor,
            unsigned & 0xffff_ffff_0000_0000,
            unsigned ^ 0x5aa5_5aa5_a55a_a55a,
            !unsigned,
            unsigned.wrapping_shl(shift),
            unsigned >> shift,
            (signed >> shift) as u64,
            (signed as u64).wrapping_shl(shift),
            signed as u64,
            (signed + 2) as u64,
            (signed + 2 + i64::from(u32::MAX)) as u64,
            if index & 1 != 0 {
                signed as u64
            } else {
                u64::from(u32::MAX)
            },
        ] {
            append_pair(&mut row, value);
        }
        row.extend([
            signed as u32,
            u32::from(signed != 0),
            u32::from(signed < i64::from(u32::MAX)),
            u32::from((signed as u64) < unsigned),
            6,
            3,
            6,
            3,
        ]);
        assert_eq!(row.len(), WORDS);
        expected[(index + 1) * WORDS..(index + 2) * WORDS].copy_from_slice(&row);
    }
    signed_input.extend([0x5aa5_5aa5_5aa5_5aa5; 3]);
    unsigned_input.extend([0x5aa5_5aa5_5aa5_5aa5; 6]);
    controls.extend([0x5aa5_5aa5; 6]);
    integer64_case(
        &format!(
            "long long runtime arithmetic, promotions, shifts, div/rem and updates, count {count}"
        ),
        include_str!("../../../../../naga/tests/in/cuda/integer64.cu"),
        &expected,
    )
    .module_buffers(
        vec![
            storage_buffer(0, true, &signed_input),
            storage_buffer(1, true, &unsigned_input),
            storage_buffer(2, true, &controls),
            storage_buffer(3, false, &vec![SENTINEL; expected.len()]),
            count_buffer(4, count),
        ],
        3,
        [3, 1, 1],
    )
}

fn copy(signed: bool, count: usize) -> ShaderTest {
    let values = data_bits();
    let mut input = vec![0x5aa5_5aa5_5aa5_5aa5_u64];
    input.extend(&values);
    input.extend([0x5aa5_5aa5_5aa5_5aa5; 3]);
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * 2];
    for (index, &value) in values.iter().take(count).enumerate() {
        expected[(index + 1) * 2..(index + 2) * 2]
            .copy_from_slice(&[value as u32, (value >> 32) as u32]);
    }
    let ty = if signed {
        "long long"
    } else {
        "unsigned long long"
    };
    let source = format!(
        "__global__ void copy(const {ty} *input, {ty} *output, unsigned count) {{
        unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
        if (index < count) output[index + 1u] = input[index + 1u];
    }}"
    );
    integer64_case(
        &format!("{ty} storage preserves all64bits and8-byte stride, count {count}"),
        &source,
        &expected,
    )
    .module_buffers(
        vec![
            storage_buffer(0, true, &input),
            storage_buffer(1, false, &vec![SENTINEL; expected.len()]),
            count_buffer(2, count),
        ],
        1,
        [3, 1, 1],
    )
}

fn records() -> ShaderTest {
    let values = data_bits();
    let mut input = vec![0x5aa5_5aa5_u32; 6];
    for (index, &value) in values.iter().enumerate() {
        input.extend([index as u32 * 31 + 7, index as u32 * 43 + 11]);
        append_pair(&mut input, value);
        append_pair(&mut input, values[(index + 17) % CAPACITY]);
    }
    input.extend([0x5aa5_5aa5; 18]);
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * 6];
    expected[6..66 * 6].copy_from_slice(&input[6..66 * 6]);
    integer64_case("mixed32/64 record fields retain24-byte stride and partial tails",
        "struct Record { unsigned first; unsigned second; long long signed_value; unsigned long long unsigned_value; };
        __global__ void copy_records(const Record *input, Record *output, unsigned count) {
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index < count) output[index + 1u] = input[index + 1u];
        }", &expected).module_buffers(vec![storage_buffer(0, true, &input),
            storage_buffer(1, false, &vec![SENTINEL; expected.len()]), count_buffer(2, 65)], 1, [3, 1, 1])
}

fn float_to_integer() -> ShaderTest {
    let signed = [
        i64::MIN as f32,
        -(1_i64 << 40) as f32,
        -2.0,
        0.0,
        2.0,
        (1_i64 << 40) as f32,
    ];
    let unsigned = [
        0_f32,
        1.0,
        2.0,
        (1_u64 << 32) as f32,
        (1_u64 << 40) as f32,
        (1_u64 << 63) as f32,
    ];
    let mut expected = vec![SENTINEL; 40];
    for index in 0..6 {
        let mut row = Vec::new();
        append_pair(&mut row, (signed[index] as i64) as u64);
        append_pair(&mut row, unsigned[index] as u64);
        expected[(index + 1) * 4..(index + 2) * 4].copy_from_slice(&row);
    }
    integer64_case("finite exactly representable float powers convert to64-bit integer boundaries",
        "__device__ void put(unsigned *output, unsigned offset, unsigned long long value) {
            output[offset] = unsigned(value); output[offset + 1u] = unsigned(value >> 32u);
        }
        __global__ void convert(const float *signed_values, const float *unsigned_values, unsigned *output) {
            unsigned index = threadIdx.x;
            if (index >= 6u) return;
            put(output, (index+1u)*4u, static_cast<long long>(signed_values[index]));
            put(output, (index+1u)*4u+2u, static_cast<unsigned long long>(unsigned_values[index]));
        }", &expected).module_buffers(vec![storage_buffer(0, true, &signed), storage_buffer(1, true, &unsigned),
            storage_buffer(2, false, &[SENTINEL; 40])], 2, [1, 1, 1])
}

fn integer_to_float() -> ShaderTest {
    let signed = [i64::MIN, -1_099_511_627_776, -2, 0, 2, 1_099_511_627_776];
    let unsigned = [0_u64, 1, 2, 1 << 32, 1 << 40, 1 << 63];
    let mut expected = vec![SENTINEL; 20];
    for index in 0..6 {
        expected[(index + 1) * 2] = (signed[index] as f32).to_bits();
        expected[(index + 1) * 2 + 1] = (unsigned[index] as f32).to_bits();
    }
    integer64_case("signed and unsigned64-bit exact powers convert to float without high-word loss",
        "__global__ void convert(const long long *signed_values, const unsigned long long *unsigned_values, unsigned *output) {
            unsigned index = threadIdx.x;
            if (index >= 6u) return;
            output[(index+1u)*2u] = __float_as_uint(static_cast<float>(signed_values[index]));
            output[(index+1u)*2u+1u] = __float_as_uint(static_cast<float>(unsigned_values[index]));
        }", &expected).module_buffers(vec![storage_buffer(0, true, &signed), storage_buffer(1, true, &unsigned),
            storage_buffer(2, false, &[SENTINEL; 20])], 2, [1, 1, 1])
}
