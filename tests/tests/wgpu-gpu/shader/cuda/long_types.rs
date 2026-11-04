use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};

const SENTINEL: u32 = 0xdead_beef;
const CAPACITY: usize = 160;
const COUNTS: [usize; 7] = [0, 1, 2, 63, 64, 65, CAPACITY];
const SHIFTS: [u32; 5] = [0, 1, 31, 32, 63];
const SIGNED_DIVISORS: [i64; 6] = [1, -1, 3, -3, 7, -7];
const UNSIGNED_DIVISORS: [u64; 8] = [1, 2, 3, 7, 0xffff_ffff, 0x1_0000_0001, 1 << 63, u64::MAX];

const ARITHMETIC_SOURCE: &str = r#"#include <cstddef>

using Signed = long;
using Unsigned = unsigned long;

__device__ unsigned source_type(int value) { return 4u; }
__device__ unsigned source_type(unsigned value) { return 1u; }
__device__ unsigned source_type(long value) { return 5u; }
__device__ unsigned source_type(unsigned long value) { return 2u; }
__device__ unsigned source_type(long long value) { return 6u; }
__device__ unsigned source_type(unsigned long long value) { return 3u; }

__device__ void store_pair(unsigned *output, unsigned offset, unsigned long long value) {
    output[offset] = unsigned(value);
    output[offset + 1u] = unsigned(value >> 32u);
}

extern "C" __global__ void long_scalars(const Signed *signed_values,
                                      const Unsigned *unsigned_values,
                                      const unsigned *controls,
                                      unsigned *output,
                                      const size_t count) {
    size_t index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    std::size_t standard_index = index;
    Signed signed_value = signed_values[index + 1UL];
    Unsigned unsigned_value = unsigned_values[(index + 1UL) * 2UL];
    Unsigned unsigned_divisor = unsigned_values[(index + 1UL) * 2UL + 1UL];
    unsigned shift = controls[(index + 1UL) * 2UL];
    Signed signed_divisor = int(controls[(index + 1UL) * 2UL + 1UL]);
    long long signed_longlong = static_cast<long long>(signed_value);
    unsigned long long unsigned_longlong = static_cast<unsigned long long>(unsigned_value);
    unsigned offset = unsigned(index + 1UL) * 48u;

    store_pair(output, offset, signed_value + 0xffffffffu);
    store_pair(output, offset + 2u, signed_value + 1LL);
    store_pair(output, offset + 4u, signed_value + unsigned_value);
    store_pair(output, offset + 6u, signed_longlong + unsigned_value);
    store_pair(output, offset + 8u, unsigned_value + 1ULL);
    store_pair(output, offset + 10u, signed_value * 3L);
    store_pair(output, offset + 12u, signed_value / signed_divisor);
    store_pair(output, offset + 14u, signed_value % signed_divisor);
    store_pair(output, offset + 16u, unsigned_value / unsigned_divisor);
    store_pair(output, offset + 18u, unsigned_value % unsigned_divisor);
    store_pair(output, offset + 20u, unsigned_value << shift);
    store_pair(output, offset + 22u, unsigned_value >> shift);
    store_pair(output, offset + 24u, signed_value >> shift);
    Signed updated = signed_value;
    Signed previous = updated++;
    Signed next = ++updated;
    updated += 0xffffffffu;
    store_pair(output, offset + 26u, previous);
    store_pair(output, offset + 28u, next);
    store_pair(output, offset + 30u, updated);
    output[offset + 32u] = source_type(signed_value);
    output[offset + 33u] = source_type(unsigned_value);
    output[offset + 34u] = source_type(signed_longlong);
    output[offset + 35u] = source_type(unsigned_longlong);
    output[offset + 36u] = source_type(signed_value + 0xffffffffu);
    output[offset + 37u] = source_type(signed_value + 1LL);
    output[offset + 38u] = source_type(signed_value + unsigned_value);
    output[offset + 39u] = source_type(signed_longlong + unsigned_value);
    output[offset + 40u] = source_type(unsigned_value + 1ULL);
    output[offset + 41u] = source_type(index);
    output[offset + 42u] = source_type(standard_index);
    output[offset + 43u] = source_type((index & 1UL) ? signed_value : unsigned_value);
    output[offset + 44u] = source_type((index & 1UL) ? signed_longlong : unsigned_value);
    output[offset + 45u] = unsigned(signed_value < unsigned_value);
    output[offset + 46u] = unsigned(signed_value < 0xffffffffu);
    output[offset + 47u] = unsigned(bool(unsigned_value));
}
"#;

fn long_case(name: &str, source: &str, expected: &[u32]) -> ShaderTest {
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

fn uniform_buffer(binding: u32, low: u32, high: u32) -> ShaderBuffer {
    ShaderBuffer::new(
        binding,
        wgpu::BufferBindingType::Uniform,
        &[low, high, 0x1234_5678, 0x9abc_def0],
    )
}

fn count_buffer(binding: u32, count: usize) -> ShaderBuffer {
    uniform_buffer(binding, count as u32, 0)
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
    values
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![literal_types(), conversions(), kernel_parameters()];
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
    let mut values = Vec::new();
    for value in [
        i64::MIN as u64,
        i64::MAX as u64,
        u64::MAX,
        0x1_0000_0001,
        1 << 63,
        1 << 63,
        1 << 63,
        1 << 32,
        1,
    ] {
        append_pair(&mut values, value);
    }
    values.extend([5, 2, 5, 5, 1, 2, 3, 3, 2, 3, 2, 3, 2, 2, 5, 2, 5, 6]);
    values.extend([
        5,
        1,
        2,
        1,
        2,
        1,
        2,
        1,
        5,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        0,
        2,
        u32::MAX,
        u32::MAX,
        5,
        1,
        1,
        2,
        3,
        1,
    ]);
    assert_eq!(values.len(), 64);
    let mut expected = vec![SENTINEL; 80];
    expected[4..68].copy_from_slice(&values);
    long_case(
        "long and long long literal identities, suffix candidates and SDK min/max",
        r#"#include <cstddef>
        using Signed = long;
        typedef unsigned long Unsigned;
        __device__ unsigned source_type(int value) { return 4u; }
        __device__ unsigned source_type(unsigned value) { return 1u; }
        __device__ unsigned source_type(long value) { return 5u; }
        __device__ unsigned source_type(unsigned long value) { return 2u; }
        __device__ unsigned source_type(long long value) { return 6u; }
        __device__ unsigned source_type(unsigned long long value) { return 3u; }
        __device__ void put(unsigned *output, unsigned offset, unsigned long long value) {
            output[offset] = unsigned(value);
            output[offset + 1u] = unsigned(value >> 32u);
        }
        __global__ void literal_types(unsigned *output) {
            if (threadIdx.x != 0u) return;
            Signed minimum = -9223372036854775807L - 1L;
            put(output, 4u, minimum);
            put(output, 6u, 9223372036854775807L);
            put(output, 8u, 18446744073709551615UL);
            put(output, 10u, 0x100000001UL);
            put(output, 12u, 9223372036854775808L);
            put(output, 14u, 0x8000000000000000L);
            put(output, 16u, -9223372036854775808L);
            put(output, 18u, 1L + 0xffffffffu);
            Unsigned empty{};
            put(output, 20u, empty + 1UL);
            output[22] = source_type(1L);
            output[23] = source_type(1UL);
            output[24] = source_type(2147483648);
            output[25] = source_type(4294967295);
            output[26] = source_type(0xffffffff);
            output[27] = source_type(4294967296U);
            output[28] = source_type(9223372036854775808);
            output[29] = source_type(9223372036854775808L);
            output[30] = source_type(0x8000000000000000L);
            output[31] = source_type(0x8000000000000000LL);
            output[32] = source_type(18446744073709551615UL);
            output[33] = source_type(18446744073709551615L);
            output[34] = source_type(0xffffffffffffffff);
            output[35] = source_type(std::size_t(3));
            output[36] = source_type(long(3));
            output[37] = source_type(static_cast<Unsigned>(3));
            output[38] = source_type(minimum);
            output[39] = source_type(-9223372036854775807LL - 1LL);
            output[40] = source_type(min(1L, 2L));
            output[41] = unsigned(min(1L, 2L));
            output[42] = source_type(min(1UL, 2UL));
            output[43] = unsigned(min(1UL, 2UL));
            output[44] = source_type(min(1L, 2UL));
            output[45] = unsigned(min(1L, 2UL));
            output[46] = source_type(min(1UL, 2L));
            output[47] = unsigned(min(1UL, 2L));
            output[48] = source_type(max(1L, 2L));
            output[49] = unsigned(max(1L, 2L));
            output[50] = source_type(max(1UL, 2UL));
            output[51] = unsigned(max(1UL, 2UL));
            output[52] = source_type(max(1L, 2UL));
            output[53] = unsigned(max(1L, 2UL));
            output[54] = source_type(max(1UL, 2L));
            output[55] = unsigned(max(1UL, 2L));
            output[56] = source_type(min(-1L, 2UL));
            put(output, 57u, min(-1L, 2UL));
            output[59] = source_type(max(-1L, 2UL));
            put(output, 60u, max(-1L, 2UL));
            output[62] = source_type(min(4294967297L, 4294967299L));
            put(output, 63u, min(4294967297L, 4294967299L));
            output[65] = source_type(max(4294967297UL, 4294967299UL));
            put(output, 66u, max(4294967297UL, 4294967299UL));
        }"#,
        &expected,
    )
    .module_buffers(
        vec![storage_buffer(0, false, &[SENTINEL; 80])],
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
    let mut signed_input = vec![0x5aa5_5aa5_5aa5_5aa5_i64];
    let mut unsigned_input = vec![0x5aa5_5aa5_5aa5_5aa5_u64; 2];
    let mut controls = vec![0x5aa5_5aa5_u32; 2];
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * WORDS];
    for (index, unsigned) in data_bits().into_iter().enumerate() {
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
            (signed + 1) as u64,
            (signed as u64).wrapping_add(unsigned),
            (signed as u64).wrapping_add(unsigned),
            unsigned.wrapping_add(1),
            (signed * 3) as u64,
            (signed / signed_divisor) as u64,
            (signed % signed_divisor) as u64,
            unsigned / unsigned_divisor,
            unsigned % unsigned_divisor,
            unsigned.wrapping_shl(shift),
            unsigned >> shift,
            (signed >> shift) as u64,
            signed as u64,
            (signed + 2) as u64,
            (signed + 2 + i64::from(u32::MAX)) as u64,
        ] {
            append_pair(&mut row, value);
        }
        row.extend([
            5,
            2,
            6,
            3,
            5,
            6,
            2,
            3,
            3,
            2,
            2,
            2,
            3,
            u32::from((signed as u64) < unsigned),
            u32::from(signed < i64::from(u32::MAX)),
            u32::from(unsigned != 0),
        ]);
        assert_eq!(row.len(), WORDS);
        expected[(index + 1) * WORDS..(index + 2) * WORDS].copy_from_slice(&row);
    }
    signed_input.extend([0x5aa5_5aa5_5aa5_5aa5; 3]);
    unsigned_input.extend([0x5aa5_5aa5_5aa5_5aa5; 6]);
    controls.extend([0x5aa5_5aa5; 6]);
    long_case(
        &format!("long/long long rank, size_t indices and arithmetic, count {count}"),
        ARITHMETIC_SOURCE,
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

fn conversions() -> ShaderTest {
    let signed = [i64::MIN, -(1_i64 << 40), -2, 0, 2, 1_i64 << 40];
    let unsigned = [0_u64, 1, 2, 1 << 32, 1 << 40, 1 << 63];
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 80];
    for index in 0..6 {
        let signed_float = (signed[index] as f32).to_bits();
        let unsigned_float = (unsigned[index] as f32).to_bits();
        input.extend([signed_float, unsigned_float]);
        append_pair(&mut input, signed[index] as u64);
        append_pair(&mut input, unsigned[index]);
        let mut row = Vec::new();
        append_pair(&mut row, signed[index] as u64);
        append_pair(&mut row, unsigned[index]);
        row.extend([signed_float, unsigned_float, 5, 2]);
        expected[(index + 1) * 8..(index + 2) * 8].copy_from_slice(&row);
    }
    long_case(
        "exact finite F32/long conversions preserve nominal result types and high words",
        r#"__device__ unsigned source_type(long value) { return 5u; }
        __device__ unsigned source_type(unsigned long value) { return 2u; }
        __device__ void put(unsigned *output, unsigned offset, unsigned long long value) {
            output[offset] = unsigned(value);
            output[offset + 1u] = unsigned(value >> 32u);
        }
        struct Input {
            float signed_float;
            float unsigned_float;
            long signed_integer;
            unsigned long unsigned_integer;
        };
        __global__ void convert(const Input *input, unsigned *output) {
            unsigned index = threadIdx.x;
            if (index >= 6u) return;
            Input value = input[index];
            unsigned offset = (index + 1u) * 8u;
            long signed_value = static_cast<long>(value.signed_float);
            unsigned long unsigned_value = static_cast<unsigned long>(value.unsigned_float);
            put(output, offset, signed_value);
            put(output, offset + 2u, unsigned_value);
            output[offset + 4u] = __float_as_uint(static_cast<float>(value.signed_integer));
            output[offset + 5u] = __float_as_uint(static_cast<float>(value.unsigned_integer));
            output[offset + 6u] = source_type(signed_value);
            output[offset + 7u] = source_type(unsigned_value);
        }"#,
        &expected,
    )
    .module_buffers(
        vec![
            storage_buffer(0, true, &input),
            storage_buffer(1, false, &[SENTINEL; 80]),
        ],
        1,
        [1, 1, 1],
    )
}

fn kernel_parameters() -> ShaderTest {
    const SIGNED: i64 = -4_294_967_297;
    const UNSIGNED: u64 = 0xfedc_ba98_7654_3210;
    let mut expected = vec![SENTINEL; 8 * 24];
    for index in 0..4 {
        let mut row = Vec::new();
        for value in [
            SIGNED as u64,
            UNSIGNED,
            (SIGNED + index + 1) as u64,
            UNSIGNED - (index as u64 + 1),
            (SIGNED + index + 4) as u64,
            (SIGNED + index + 3) as u64,
            SIGNED as u64,
            UNSIGNED - (index as u64 + 1) + 2,
            UNSIGNED - (index as u64 + 1) + 2,
            4,
        ] {
            append_pair(&mut row, value);
        }
        row.extend([5, 2, 5, 2]);
        let offset = (index as usize + 1) * 24;
        expected[offset..offset + 24].copy_from_slice(&row);
    }
    long_case(
        "64-bit long uniforms retain private parameter copies, references, pointers and templates",
        r#"#include <cstddef>
        using Signed = long;
        typedef unsigned long Unsigned;
        __device__ unsigned source_type(Signed value) { return 5u; }
        __device__ unsigned source_type(Unsigned value) { return 2u; }
        template<class T> __device__ T copy_value(T value) { return value; }
        __device__ Signed add_reference(Signed &value) { value += 3L; return value; }
        __device__ Signed subtract_pointer(Signed *value) { *value -= 1L; return *value; }
        __device__ Unsigned add_unsigned_reference(Unsigned &value) { value += 2UL; return value; }
        __device__ Unsigned read_pointer(const Unsigned *value) { return *value; }
        __device__ void put(unsigned *output, unsigned offset, unsigned long long value) {
            output[offset] = unsigned(value);
            output[offset + 1u] = unsigned(value >> 32u);
        }
        __global__ void parameters(unsigned *output, Signed signed_parameter,
                                   Unsigned unsigned_parameter, size_t count) {
            unsigned index = threadIdx.x;
            if (index >= count) return;
            std::size_t copied_count = count;
            Signed before_signed = signed_parameter;
            Unsigned before_unsigned = unsigned_parameter;
            Signed copied_value = copy_value(signed_parameter);
            signed_parameter += index + 1u;
            unsigned_parameter -= index + 1u;
            Signed updated_signed = signed_parameter;
            Unsigned updated_unsigned = unsigned_parameter;
            Signed after_reference = add_reference(signed_parameter);
            Signed after_pointer = subtract_pointer(&signed_parameter);
            Unsigned after_unsigned_reference = add_unsigned_reference(unsigned_parameter);
            Unsigned after_unsigned_pointer = read_pointer(&unsigned_parameter);
            unsigned offset = (index + 1u) * 24u;
            put(output, offset, before_signed);
            put(output, offset + 2u, before_unsigned);
            put(output, offset + 4u, updated_signed);
            put(output, offset + 6u, updated_unsigned);
            put(output, offset + 8u, after_reference);
            put(output, offset + 10u, after_pointer);
            put(output, offset + 12u, copied_value);
            put(output, offset + 14u, after_unsigned_reference);
            put(output, offset + 16u, after_unsigned_pointer);
            put(output, offset + 18u, copied_count);
            output[offset + 20u] = source_type(signed_parameter);
            output[offset + 21u] = source_type(unsigned_parameter);
            output[offset + 22u] = source_type(copied_value);
            output[offset + 23u] = source_type(copied_count);
        }"#,
        &expected,
    )
    .module_buffers(
        vec![
            storage_buffer(0, false, &vec![SENTINEL; expected.len()]),
            uniform_buffer(1, SIGNED as u32, ((SIGNED as u64) >> 32) as u32),
            uniform_buffer(2, UNSIGNED as u32, (UNSIGNED >> 32) as u32),
            count_buffer(3, 4),
        ],
        0,
        [1, 1, 1],
    )
}

fn copy(signed: bool, count: usize) -> ShaderTest {
    let values = data_bits();
    let mut input = vec![0x5aa5_5aa5_5aa5_5aa5_u64];
    input.extend(&values);
    input.extend([0x5aa5_5aa5_5aa5_5aa5; 3]);
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * 2];
    for (index, value) in values.into_iter().take(count).enumerate() {
        expected[(index + 1) * 2..(index + 2) * 2]
            .copy_from_slice(&[value as u32, (value >> 32) as u32]);
    }
    let ty = if signed { "long" } else { "unsigned long" };
    let source = format!(
        "#include <cstddef>\n
        __global__ void copy(const {ty} *input, {ty} *output, std::size_t count) {{
            size_t index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index < count) output[index + 1UL] = input[index + 1UL];
        }}"
    );
    long_case(
        &format!("{ty} storage retains complete 64-bit payload and 8-byte stride, count {count}"),
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
    let mut input = vec![0x5aa5_5aa5_u32; 8];
    for (index, &value) in values.iter().enumerate() {
        append_pair(&mut input, value);
        append_pair(&mut input, values[(index + 17) % CAPACITY]);
        append_pair(&mut input, values[(index + 31) % CAPACITY]);
        append_pair(&mut input, values[(index + 61) % CAPACITY]);
    }
    input.extend([0x5aa5_5aa5; 24]);
    let mut expected = vec![SENTINEL; (CAPACITY + 4) * 8];
    expected[8..66 * 8].copy_from_slice(&input[8..66 * 8]);
    long_case(
        "long/unsigned long/long long/unsigned long long record copies retain 32-byte stride",
        r#"#include <cstddef>
        struct Record {
            long first;
            unsigned long second;
            long long third;
            unsigned long long fourth;
        };
        __global__ void copy_records(const Record *input, Record *output, size_t count) {
            size_t index = blockIdx.x * blockDim.x + threadIdx.x;
            if (index < count) output[index + 1UL] = input[index + 1UL];
        }"#,
        &expected,
    )
    .module_buffers(
        vec![
            storage_buffer(0, true, &input),
            storage_buffer(1, false, &vec![SENTINEL; expected.len()]),
            count_buffer(2, 65),
        ],
        1,
        [3, 1, 1],
    )
}
