use naga::front::cuda::Options;
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

#[test]
fn cuda_type_queries_return_size_and_alignment_in_bytes() {
    let source = "__global__ void kernel(unsigned long *output) {
        output[0] = sizeof(int);
        output[1] = alignof(int);
    }";
    let (module, _) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
    let function = &module.entry_points[0].function;
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { value, .. } = *statement {
            values.push(function.expressions[value].clone());
        }
        false
    });
    assert_eq!(
        values,
        [
            naga::Expression::Literal(naga::Literal::U64(4)),
            naga::Expression::Literal(naga::Literal::U64(4)),
        ]
    );
}

fn roundtrip(source: &str) -> naga::Module {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    module
}

fn assert_query_results(source: &str, expected: &[u64]) {
    let module = roundtrip(source);
    let function = &module.entry_points[0].function;
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            let root = super::helpers::root_expression(function, pointer);
            if matches!(
                function.expressions[root],
                naga::Expression::GlobalVariable(_)
            ) {
                values.push(function.expressions[value].clone());
            }
        }
        false
    });
    let expected: Vec<_> = expected
        .iter()
        .map(|&value| naga::Expression::Literal(naga::Literal::U64(value)))
        .collect();
    assert_eq!(values, expected, "{source}");
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_record_offsetof_folds_source_layout_with_qualified_and_local_types() {
    assert_query_results(
        "struct Record {
            short head; float2 pair; float3 packed; float scalar; float4 aligned; int row[2];
        };
        using Alias = const Record;
        constexpr size_t Packed = __builtin_offsetof(Record, packed);
        static_assert(Packed == 16);
        struct Other { static_assert(__builtin_offsetof(Record, row) == 48); int value; };
        __global__ void kernel(unsigned long *output) {
            struct Local { int head; float2 pair; };
            output[0] = __builtin_offsetof(Record, head);
            output[1] = __builtin_offsetof(volatile Alias, pair);
            output[2] = __builtin_offsetof(Record, packed);
            output[3] = __builtin_offsetof(Record, scalar);
            output[4] = __builtin_offsetof(Record, aligned);
            output[5] = __builtin_offsetof(Alias, row);
            output[6] = __builtin_offsetof(Local, pair);
            int values[__builtin_offsetof(Record, scalar)];
            output[7] = sizeof(values);
            unsigned long offsetof = 7UL;
            static_assert(__builtin_offsetof(Record, row) == 48);
        }",
        &[0, 8, 16, 28, 32, 48, 8, 112],
    );
}

#[test]
fn cuda_record_offsetof_uses_concrete_template_types() {
    let module = roundtrip(
        "struct Inner { int head; float4 data; };
        struct Record { int head; Inner inner; };
        template<class T> __device__ size_t offset(size_t value = __builtin_offsetof(Record, inner)) {
            static_assert(__builtin_offsetof(T, inner.data) == 32u);
            return value + __builtin_offsetof(T, inner.data);
        }
        __global__ void kernel(unsigned long *output) { output[0] = offset<Record>(); }",
    );
    assert_eq!(module.functions.len(), 1);
}

#[test]
fn cuda_record_offsetof_sums_nested_record_padding() {
    assert_query_results(
        "#include <cstddef>\n#define MEMBER middle.leaf.value\n
        struct Leaf { short head; int value; int row[3]; float2 pair; };
        struct Middle { int head; Leaf leaf; int last; };
        struct Outer { float4 first; int guard; Middle middle; int second; };
        using Alias = const Outer;
        static_assert(offsetof(Alias, MEMBER) == 36u);
        __global__ void kernel(unsigned long *output) {
            struct Local { int head; Leaf leaf; };
            int leaf = 0;
            output[0] = offsetof(volatile Alias, MEMBER);
            output[1] = __builtin_offsetof(Outer, middle.leaf.row);
            output[2] = offsetof(Outer, middle.leaf.pair);
            output[3] = offsetof(Outer, middle.last);
            output[4] = offsetof(Outer, middle.leaf);
            output[5] = offsetof(Local, leaf.value);
            static_assert(offsetof(Outer, middle.leaf.value) ==
                offsetof(Outer, middle) + offsetof(Middle, leaf) + offsetof(Leaf, value));
        }",
        &[36, 40, 56, 64, 32, 12],
    );
}

#[test]
fn cuda_record_offsetof_indexes_fixed_arrays_at_their_declared_strides() {
    assert_query_results(
        "#include <stddef.h>\n#define ROW_INDEX 01u\n
        struct Leaf { int first; int values[3]; };
        using Row = int[3];
        struct Outer { int prefix; Leaf leaves[2]; Row grid[2]; float3 packed[2]; short3 compact[2]; };
        using Alias = const Outer;
        static_assert(offsetof(Outer, leaves[1].values[2]) == 32u);
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(volatile Alias, leaves[ROW_INDEX].values[0b10]);
            output[1] = __builtin_offsetof(Outer, grid[0ULL][0x1ul]);
            output[2] = offsetof(Outer, grid[1][2U]);
            output[3] = offsetof(Outer, grid[0'1]);
            output[4] = offsetof(Outer, leaves[1]);
            output[5] = offsetof(Outer, packed[1]);
            output[6] = offsetof(Outer, compact[1]);
        }",
        &[32, 40, 56, 48, 20, 72, 90],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_array_indices_without_evaluating_them() {
    for (path, message) in [
        ("row[-1]", "integer literal"),
        ("row[1.0f]", "integer literal"),
        ("row[nullptr]", "integer literal"),
        ("row[0b2]", "integer literal"),
        ("row[4294967296ULL]", "integer literal"),
        ("row[]", "integer literal"),
        ("row[()]", "integer literal"),
        ("row[((1)]", "expected"),
        ("row[(1))]", "expected"),
        ("row[(1=0)]", "expected"),
        ("row[(1,2)]", "expected"),
        ("row[index]", "integer literal"),
        ("row[helper()]", "integer literal"),
        ("row[index++]", "integer literal"),
        ("row[0=1]", "expected"),
        ("row[0,1]", "expected"),
        ("row[1", "expected"),
        ("row[3]", "out of bounds"),
        ("row[0xffffffffu]", "out of bounds"),
        ("grid[2][0]", "out of bounds"),
        ("grid[0][3]", "out of bounds"),
        ("grid[0][2][0]", "fixed array"),
        ("scalar[0]", "fixed array"),
        ("vector[0]", "fixed array"),
        ("vectors[0].x", "complete record"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[3]; int grid[2][3]; int scalar; float2 vector; float3 vectors[2]; }};
            __device__ unsigned helper() {{ return 1u; }}
            __global__ void kernel(unsigned *output) {{
                unsigned index = 0u;
                output[0] = unsigned(true ? 0u : __builtin_offsetof(Record, {path}));
            }}"
        ));
        assert!(error.message.contains(message), "{path}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_integral_unary_indices() {
    assert_query_results(
        "#include <cstddef>\n#define INVERT(value) (~(value))\n
        struct Record { int head; int row[3]; };
        constexpr short Negative = -2;
        constexpr unsigned All = 0xffffffffu;
        constexpr unsigned long long Wide = 0xffffffffffffffffULL;
        constexpr bool Flag = true;
        template<int Index> __device__ size_t index_offset() {
            return offsetof(Record, row[-Index]);
        }
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[-Negative]);
            output[1] = offsetof(Record, row[INVERT(Negative)]);
            output[2] = offsetof(Record, row[+Flag]);
            output[3] = offsetof(Record, row[!Flag]);
            output[4] = offsetof(Record, row[-All]);
            output[5] = offsetof(Record, row[~All]);
            output[6] = offsetof(Record, row[-Wide]);
            output[7] = offsetof(Record, row[~Wide]);
            output[8] = offsetof(Record, row[-(-2)]);
            output[9] = offsetof(Record, row[!!2]);
            size_t instantiated = index_offset<-1>();
        }",
        &[12, 8, 8, 4, 8, 4, 8, 4, 12, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_unary_indices() {
    for (index, message) in [
        ("-Min", "signed overflow"),
        ("-(-WideMin)", "signed overflow"),
        ("!Real", "integer literal"),
        ("~Zero", "nonnegative"),
        ("-1u", "out of bounds"),
        ("--Zero", "integer literal"),
        ("++Zero", "integer literal"),
        ("+Zero++", "expected"),
        ("+Zero,1", "expected"),
        ("+dynamic", "integer literal"),
    ] {
        let source = format!(
            "struct Record {{ int row[3]; }};
             constexpr int Min = -2147483647 - 1;
             constexpr long long WideMin = -9223372036854775807LL - 1;
             constexpr float Real = 1.0f;
             __global__ void kernel(unsigned *out, int dynamic) {{
                 constexpr short Zero = 0;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_additive_indices() {
    assert_query_results(
        "#include <cstddef>
        #define ADJUST(value) ((value) + 1)
        struct Record { int head; int row[3]; };
        constexpr unsigned All = 0xffffffffu;
        constexpr unsigned long Wide = 0xfffffffffffffffful;
        constexpr bool Flag = true;
        constexpr unsigned short Narrow = 65535;
        template<int Index> __device__ size_t index_offset() {
            return offsetof(Record, row[Index - 1]);
        }
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[2 - 1 - 1]);
            output[1] = offsetof(Record, row[2 - (2 - 1)]);
            output[2] = offsetof(Record, row[0 - 2 + 4]);
            output[3] = offsetof(Record, row[ADJUST(-1)]);
            output[4] = offsetof(Record, row[All + 2]);
            output[5] = offsetof(Record, row[Wide + 2ll]);
            output[6] = offsetof(Record, row[+Flag + !0]);
            output[7] = offsetof(Record, row[0 - Narrow + 65536]);
            output[8] = offsetof(Record, row[1 + -1]);
            output[9] = offsetof(Record, row[(0u - 1) + 2u]);
            output[10] = offsetof(Record, row[-(1l + 1u) + 3]);
            size_t instantiated = index_offset<2>();
        }",
        &[4, 8, 12, 4, 8, 8, 12, 8, 4, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_additive_indices() {
    for (index, message) in [
        ("2147483647 + 1 - 2147483647", "signed overflow"),
        ("-2147483647 - 2 + 2147483647", "signed overflow"),
        (
            "9223372036854775807l + 1u - 9223372036854775807l",
            "signed overflow",
        ),
        ("-1 + 0u", "out of bounds"),
        ("-4294967296l + 1u", "nonnegative"),
        ("1 + 2", "out of bounds"),
        ("1 + runtime", "integer literal"),
        ("1 + 1.0f", "integer literal"),
        ("1 +", "integer literal"),
        ("0 += 1", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[3]; }};
             __global__ void kernel(unsigned *out, int runtime) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_multiplicative_indices() {
    assert_query_results(
        "#include <cstddef>
        #define PRODUCT(left, right) ((left) * (right))
        struct Record { int head; int row[4]; };
        constexpr unsigned Max = 0xffffffffu;
        constexpr unsigned long Wide = 0xfffffffffffffffful;
        constexpr unsigned short Narrow = 65535;
        constexpr bool Flag = true;
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[PRODUCT(2, 3) - 4]);
            output[1] = offsetof(Record, row[2 * (3 - 2)]);
            output[2] = offsetof(Record, row[1 + 4 / 2]);
            output[3] = offsetof(Record, row[8 / 4 / 2]);
            output[4] = offsetof(Record, row[8 / (4 / 2) - 4]);
            output[5] = offsetof(Record, row[7 % 4 / 2]);
            output[6] = offsetof(Record, row[-7 / 3 + 3]);
            output[7] = offsetof(Record, row[-7 % 3 + 2]);
            output[8] = offsetof(Record, row[-1 % 2u]);
            output[9] = offsetof(Record, row[-1 / Max]);
            output[10] = offsetof(Record, row[Max * Max]);
            output[11] = offsetof(Record, row[Wide * 0xffffffffffffffffULL]);
            output[12] = offsetof(Record, row[-1l % Wide]);
            output[13] = offsetof(Record, row[Flag * (Narrow % 2)]);
            output[14] = offsetof(Record, row[-(2 * 3) / -2]);
        }",
        &[12, 12, 16, 8, 4, 8, 8, 8, 8, 8, 8, 8, 4, 8, 16],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_multiplicative_indices() {
    for (index, message) in [
        ("2147483647 * 2 - 2147483647", "signed overflow"),
        ("9223372036854775807LL * 2", "signed overflow"),
        ("Min / -1", "signed overflow"),
        ("Min % -1", "signed overflow"),
        ("WideMin / -1", "signed overflow"),
        ("WideMin % -1", "signed overflow"),
        ("1 / (2 - 2)", "division by zero"),
        ("0u % Zero", "remainder by zero"),
        ("1ULL / !1", "division by zero"),
        ("2 * 2", "out of bounds"),
        ("-7 / 3", "nonnegative"),
        ("2 * runtime", "integral constant"),
        ("2 % 1.0f", "integer literal"),
        ("1 *", "integer literal"),
        ("1 ** 1", "integer literal"),
        ("*Zero", "integer literal"),
        ("1 *= 2", "expected"),
        ("1 /= 2", "expected"),
        ("1 %= 2", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             constexpr int Min = -2147483647 - 1;
             constexpr long WideMin = -9223372036854775807L - 1;
             __global__ void kernel(unsigned *out, int runtime) {{
                 constexpr unsigned short Zero = 0;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_shift_indices() {
    assert_query_results(
        "#include <cstddef>
        #define SHIFT(value, count) ((value) << (count))
        struct Record { int head; int row[5]; };
        constexpr unsigned Max = 0xffffffffu;
        constexpr unsigned long Wide = 0xfffffffffffffffful;
        constexpr short Narrow = 1;
        constexpr bool Flag = true;
        constexpr int Min = -2147483647 - 1;
        constexpr long WideMin = -9223372036854775807L - 1;
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[1 << 1 + 1]);
            output[1] = offsetof(Record, row[1 + 3 >> 1]);
            output[2] = offsetof(Record, row[8 >> 1 >> 1]);
            output[3] = offsetof(Record, row[2 >> (1 >> 1)]);
            output[4] = offsetof(Record, row[SHIFT(1, Flag)]);
            output[5] = offsetof(Record, row[Max >> 31]);
            output[6] = offsetof(Record, row[Wide >> 63]);
            output[7] = offsetof(Record, row[(-3 >> 1ULL) + 3]);
            output[8] = offsetof(Record, row[(-1 << 1) + 3]);
            output[9] = offsetof(Record, row[(1 << 31) / Min]);
            output[10] = offsetof(Record, row[(1L << 63) / WideMin]);
            output[11] = offsetof(Record, row[(Narrow << 16) >> 16]);
            output[12] = offsetof(Record, row[(Max << 31) >> 31]);
            output[13] = offsetof(Record, row[(Wide << 63) >> 63]);
            output[14] = offsetof(Record, row[+Flag << !Flag]);
        }",
        &[20, 12, 12, 12, 12, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_shift_indices() {
    for (index, message) in [
        ("1 << -1", "shift count"),
        ("1 << 32ULL", "shift count"),
        ("1u >> 32", "shift count"),
        ("1ULL << 64", "shift count"),
        ("1L >> 0x100000000ULL", "shift count"),
        ("Narrow << 32", "shift count"),
        ("(-3 >> 1)", "nonnegative"),
        ("1 << 3", "out of bounds"),
        ("1 >> runtime", "integral constant"),
        ("1.0f << 1", "integer literal"),
        ("1 << 1.0f", "integer literal"),
        ("1 >>", "integer literal"),
        ("1 <<= 1", "expected"),
        ("1 >>= 1", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[5]; }};
             constexpr unsigned short Narrow = 1;
             __global__ void kernel(unsigned *out, int runtime) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_bitwise_indices() {
    assert_query_results(
        "#include <cstddef>
        #define MASK(value, bits) ((value) & (bits))
        struct Record { int head; int row[4]; };
        constexpr unsigned Max = 0xffffffffu;
        constexpr unsigned long Wide = 0xfffffffffffffffful;
        constexpr unsigned short Narrow = 65535;
        constexpr bool Flag = true;
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[1 | 2 & 0]);
            output[1] = offsetof(Record, row[(1 | 2) & 0]);
            output[2] = offsetof(Record, row[3 ^ 2 & 1]);
            output[3] = offsetof(Record, row[1 | 3 ^ 1]);
            output[4] = offsetof(Record, row[2 & 1 << 1]);
            output[5] = offsetof(Record, row[2 + 3 & 1]);
            output[6] = offsetof(Record, row[MASK(-1, 3u)]);
            output[7] = offsetof(Record, row[Max ^ 0xfffffffeu]);
            output[8] = offsetof(Record, row[Wide ^ 0xfffffffffffffffeULL]);
            output[9] = offsetof(Record, row[(-4 | 1) + 4]);
            output[10] = offsetof(Record, row[(Flag & Flag) + 1]);
            output[11] = offsetof(Record, row[(Narrow | 0) >> 15]);
            output[12] = offsetof(Record, row[(~0 & 0xfffffffffffffffful) >> 63]);
            output[13] = offsetof(Record, row[(2 * 3 ^ 7) | 2]);
        }",
        &[8, 4, 16, 16, 12, 8, 16, 8, 8, 8, 12, 8, 8, 16],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_bitwise_indices() {
    for (index, message) in [
        ("1 | 4", "out of bounds"),
        ("-1 | 0", "nonnegative"),
        ("1 | runtime", "integral constant"),
        ("1 & 1.0f", "integer literal"),
        ("1 ^", "integer literal"),
        ("&Zero", "integer literal"),
        ("1 & &Zero", "integer literal"),
        ("1 &= 1", "expected"),
        ("1 ^= 1", "expected"),
        ("1 |= 1", "expected"),
        ("1, 0", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             __global__ void kernel(unsigned *out, int runtime) {{
                 constexpr int Zero = 0;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_comparison_indices() {
    assert_query_results(
        "#include <cstddef>
        #define SMALLER(left, right) ((left) < (right))
        struct Record { int head; int row[4]; };
        constexpr unsigned Max = 0xffffffffu;
        constexpr unsigned long Wide = 0xfffffffffffffffful;
        constexpr unsigned short Narrow = 65535;
        constexpr bool Flag = true;
        template<int Index> __device__ size_t index_offset() {
            return offsetof(Record, row[Index >= -1]);
        }
        __global__ void kernel(unsigned long *output) {
            output[0] = offsetof(Record, row[SMALLER(-1, 1u)]);
            output[1] = offsetof(Record, row[-1L < 1u]);
            output[2] = offsetof(Record, row[-1LL < 1ul]);
            output[3] = offsetof(Record, row[-1L == 0xffffffffffffffffULL]);
            output[4] = offsetof(Record, row[Max != -1]);
            output[5] = offsetof(Record, row[Wide > Max]);
            output[6] = offsetof(Record, row[Flag <= Narrow]);
            output[7] = offsetof(Record, row[2 >= 3]);
            output[8] = offsetof(Record, row[2 < 1 < 1]);
            output[9] = offsetof(Record, row[2 == 1 < 2]);
            output[10] = offsetof(Record, row[2 | 1 == 1]);
            output[11] = offsetof(Record, row[1 << 2 > 2]);
            output[12] = offsetof(Record, row[!(2 < 1) + (3 >= 3)]);
            size_t instantiated = index_offset<-1>();
        }",
        &[4, 8, 4, 8, 4, 8, 8, 4, 8, 4, 16, 8, 12],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_comparison_indices() {
    for (index, message) in [
        ("1 < runtime", "integral constant"),
        ("1.0f == 1", "integer literal"),
        ("1 != 1.0f", "integer literal"),
        ("1 <=", "integer literal"),
        ("1 > > 1", "integer literal"),
        ("1 <=> 1", "integer literal"),
        ("1 = 1", "expected"),
        ("1 == (1 / 0)", "division by zero"),
        ("(1 << 32) > 0", "shift count"),
        ("(1 < 2) - 2", "nonnegative"),
        ("3 + (2 >= 2)", "out of bounds"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             __global__ void kernel(unsigned *out, int runtime) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_short_circuits_logical_indices() {
    assert_query_results(
        "#include <cstddef>
        #define EITHER(left, right) ((left) || (right))
        struct Record { int head; int row[4]; };
        constexpr int Min = -2147483647 - 1;
        __constant__ int Storage;
        __global__ void kernel(unsigned long *output, int input, volatile int *values) {
            volatile int &observed = values[0];
            const int &ref_value = input;
            output[0] = offsetof(Record, row[0 && (1 / 0)]);
            output[1] = offsetof(Record, row[EITHER(2, 2147483647 + 1)]);
            output[2] = offsetof(Record, row[0 && -Min]);
            output[3] = offsetof(Record, row[1 || (Min % -1)]);
            output[4] = offsetof(Record, row[1 || (1 << 32)]);
            output[5] = offsetof(Record, row[0 && input]);
            output[6] = offsetof(Record, row[1 || observed]);
            output[7] = offsetof(Record, row[0 && (Storage + ref_value)]);
            output[8] = offsetof(Record, row[1 || 0 && (1 / 0)]);
            output[9] = offsetof(Record, row[0 && 1 / 0 || 1]);
            output[10] = offsetof(Record, row[1 || (0 || (1 / 0))]);
            output[11] = offsetof(Record, row[0 && (1 && (1 << -1))]);
            output[12] = offsetof(Record, row[!(0 && input) + (2 && 4)]);
            output[13] = offsetof(Record, row[1 && 0 || 0]);
            output[14] = offsetof(Record, row[1 || 1 && 0]);
        }",
        &[4, 8, 4, 8, 8, 4, 8, 4, 8, 8, 8, 4, 12, 4, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_logical_indices() {
    for (index, message) in [
        ("1 && (1 / 0)", "division by zero"),
        ("0 || (1 / 0)", "division by zero"),
        ("0 & (1 / 0)", "division by zero"),
        ("1 | (1 / 0)", "division by zero"),
        ("0 || (2147483647 + 1)", "signed overflow"),
        ("1 && (1u << 32)", "shift count"),
        ("1 && runtime", "integral constant"),
        ("0 || runtime", "integral constant"),
        ("runtime || 1", "integral constant"),
        ("0 && Missing", "integer literal"),
        ("0 && real", "integer literal"),
        ("0 && values", "integer literal"),
        ("1 || 18446744073709551616ULL", "integer literal"),
        ("1 || (0 && )", "integer literal"),
        ("0 && (runtime++)", "expected"),
        ("0 && (runtime = 0)", "expected"),
        ("0 && (runtime, 0)", "expected"),
        ("3 + (0 || 1)", "out of bounds"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             __global__ void kernel(unsigned *out, int runtime, float real) {{
                 int values[1];
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_conditional_indices() {
    assert_query_results(
        "#include <cstddef>
        #define PICK(test, first, second) ((test) ? (first) : (second))
        struct Record { int head; int row[4]; };
        constexpr short Narrow = 2;
        constexpr short Small = 1;
        constexpr int Known = 1;
        constexpr bool Yes = true;
        constexpr bool No = false;
        __global__ void kernel(unsigned long *output, unsigned input, volatile int *observed) {
            volatile int &live = observed[0];
            const volatile int &readonly = observed[0];
            output[0] = offsetof(Record, row[1 ? 2 : input]);
            output[1] = offsetof(Record, row[0 ? 1 / 0 : 3]);
            output[2] = offsetof(Record, row[PICK(1, 1, 2147483647 + 1)]);
            output[3] = offsetof(Record, row[0 ? 1 : 1 ? 2 : 3]);
            output[4] = offsetof(Record, row[1 ? 0 ? 1 : 2 : 3]);
            output[5] = offsetof(Record, row[(1 ? -1 : input) < 1]);
            output[6] = offsetof(Record, row[(1 ? -1L : input) < 1]);
            output[7] = offsetof(Record, row[(1 ? Narrow : Small) + 1]);
            output[8] = offsetof(Record, row[0 ? No : Yes]);
            output[9] = offsetof(Record, row[1 || input ? 2 : 3]);
            output[10] = offsetof(Record, row[0 && (input ? 1 / 0 : 1 << 32)]);
            output[11] = offsetof(Record, row[1 ? Known : live]);
            output[12] = offsetof(Record, row[1 || (1 ? Known : readonly)]);
            output[13] = offsetof(Record, row[(0 ? input << 33 : -1) == 0xffffffffu]);
        }",
        &[12, 16, 8, 12, 12, 4, 8, 16, 8, 12, 4, 8, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_conditional_indices() {
    for (index, message) in [
        ("input ? 1 : 1", "integral constant"),
        ("0 ? 1 : input", "integral constant"),
        ("1 ? 1 / 0 : 0", "division by zero"),
        ("0 ? 1 : 2147483647 + 1", "signed overflow"),
        ("0 ? 1 : 1 << 32", "shift count"),
        ("1 ? 0 : Missing", "integer literal"),
        ("1 ? 0 : 1.0f", "integer literal"),
        ("1 ? 0 : observed", "integer literal"),
        ("1 ? Known : readonly", "volatile"),
        ("1 ? (0 ? Known : Known) : (readonly)", "volatile"),
        ("1 ? -1 : input", "out of bounds"),
        ("1 ? 4 : 0", "out of bounds"),
        ("1 ?: 0", "integer literal"),
        ("1 ? 0", "expected"),
        ("1 ? 0 :", "integer literal"),
        ("1 ? 0, 1 : 2", "expected"),
        ("1 ? (0, 1) : 2", "expected"),
        ("1 ? 0 : input = 2", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             constexpr int Known = 1;
             __global__ void kernel(unsigned *out, unsigned input, volatile int *observed) {{
                 const volatile int &readonly = observed[0];
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_boolean_literal_indices() {
    assert_query_results(
        "#include <cstddef>
        #define YES true
        #define NO false
        struct Record { int head; int row[3]; };
        __global__ void kernel(unsigned long *output, unsigned input) {
            output[0] = __builtin_offsetof(Record, row[true]);
            output[1] = offsetof(Record, row[false]);
            output[2] = offsetof(Record, row[YES + true]);
            output[3] = offsetof(Record, row[!NO]);
            output[4] = offsetof(Record, row[-true + 2]);
            output[5] = offsetof(Record, row[true << true]);
            output[6] = offsetof(Record, row[false || true && false]);
            output[7] = offsetof(Record, row[true || input]);
            output[8] = offsetof(Record, row[false && (1 / 0)]);
            output[9] = offsetof(Record, row[true ? false : true]);
            output[10] = offsetof(Record, row[false ? input : true]);
            output[11] = offsetof(Record, row[true || (false ? true : false)]);
        }",
        &[8, 4, 12, 8, 8, 12, 4, 8, 4, 4, 8, 8],
    );
    let error = rejected(
        "struct Record { int row[1]; };
         __global__ void kernel(unsigned *out) {
             out[0] = unsigned(__builtin_offsetof(Record, row[true]));
         }",
    );
    assert!(error.message.contains("out of bounds"), "{error}");
}

#[test]
fn cuda_record_offsetof_evaluates_integral_static_cast_indices() {
    assert_query_results(
        "#include <cstddef>
        #define NARROW short
        struct Record { int head; int row[4]; };
        using Index = unsigned short;
        using Wide = unsigned long long;
        constexpr int Known = 1;
        __global__ void kernel(unsigned long *output, unsigned input, volatile int *observed) {
            using Alias = Index;
            const volatile int &readonly = observed[0];
            output[0] = offsetof(Record, row[static_cast<NARROW>(65537u)]);
            output[1] = offsetof(Record, row[static_cast<Alias>(65538u)]);
            output[2] = offsetof(Record, row[static_cast<int>(0xffffffffu) + 2]);
            output[3] = offsetof(Record, row[static_cast<long>(0xffffffffffffffffULL) + 2]);
            output[4] = offsetof(Record, row[static_cast<long long>(0xffffffffffffffffULL) + 2]);
            output[5] = offsetof(Record, row[static_cast<unsigned>(-1) % 2]);
            output[6] = offsetof(Record, row[static_cast<bool>(-7)]);
            output[7] = offsetof(Record, row[static_cast<bool>(0)]);
            output[8] = offsetof(Record, row[static_cast<bool>(2)]);
            output[9] = offsetof(Record, row[static_cast<const volatile int>(Known)]);
            output[10] = offsetof(Record, row[true ? static_cast<int>(Known) : readonly]);
            output[11] = offsetof(Record, row[(true ? -1 : static_cast<Wide>(input)) == 0xffffffffffffffffULL]);
            output[12] = offsetof(Record, row[true || static_cast<int>(1 / 0)]);
            output[13] = offsetof(Record, row[static_cast<unsigned>(static_cast<short>(4))>>2]);
            output[14] = offsetof(Record, row[static_cast<decltype(input)>(2)]);
            output[15] = offsetof(Record, row[static_cast<std::size_t>(3)]);
            output[16] = offsetof(Record, row[static_cast<long>(-1) < 1u]);
            output[17] = offsetof(Record, row[static_cast<long long>(-1) < 1ul]);
        }",
        &[8, 12, 8, 8, 8, 8, 8, 4, 8, 8, 8, 8, 8, 8, 12, 16, 8, 4],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_static_cast_indices() {
    for (index, message) in [
        ("static_cast<int>(input)", "integral constant"),
        ("static_cast<int>(readonly)", "integral constant"),
        ("static_cast<int>(1 / 0)", "division by zero"),
        ("static_cast<int>(true ? Known : readonly)", "volatile"),
        ("static_cast<float>(1)", "integral scalar target"),
        ("true || static_cast<float>(1)", "integral scalar target"),
        ("static_cast<Record>(1)", "integral scalar target"),
        ("static_cast<float2>(1)", "integral scalar target"),
        ("static_cast<Pointer>(0)", "integral scalar target"),
        ("static_cast<int *>(0)", "expected"),
        ("static_cast<int &>(Known)", "expected"),
        ("static_cast<Missing>(1)", "type"),
        ("static_cast<int>(1.0f)", "integer literal"),
        ("true || static_cast<int>(nullptr)", "integer literal"),
        ("static_cast<int>()", "integer literal"),
        ("static_cast<int>>(1)", "expected"),
        ("static_cast<int>(0, 1)", "expected"),
        ("static_cast<int>(4)", "out of bounds"),
        ("static_cast<short>(65535u)", "nonnegative"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             using Pointer = int *;
             constexpr int Known = 1;
             __global__ void kernel(unsigned *out, unsigned input, volatile int *observed) {{
                 const volatile int &readonly = observed[0];
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_functional_integral_cast_indices() {
    assert_query_results(
        "#include <cstddef>
        #define TO_INT(value) int(value)
        struct Record { int head; int row[4]; };
        using Index = unsigned short;
        using Wide = unsigned long long;
        using Volatile = const volatile int;
        constexpr int Known = 1;
        template<class T> __device__ size_t instantiated_index() {
            return offsetof(Record, row[T(65537u) + T()]);
        }
        __global__ void kernel(unsigned long *output, unsigned input, volatile int *observed) {
            using Alias = Index;
            const volatile int &readonly = observed[0];
            output[0] = offsetof(Record, row[int()]);
            output[1] = offsetof(Record, row[bool()]);
            output[2] = offsetof(Record, row[TO_INT(0xffffffffu) + 2]);
            output[3] = offsetof(Record, row[short(65537u)]);
            output[4] = offsetof(Record, row[Alias(65538u)]);
            output[5] = offsetof(Record, row[unsigned(-1) % 2]);
            output[6] = offsetof(Record, row[bool(2)]);
            output[7] = offsetof(Record, row[long(0xffffffffffffffffULL) + 2]);
            output[8] = offsetof(Record, row[true ? Volatile(Known) : readonly]);
            output[9] = offsetof(Record, row[true || bool(1 / 0)]);
            output[10] = offsetof(Record, row[(true ? -1 : Wide(input)) == 0xffffffffffffffffULL]);
            output[11] = offsetof(Record, row[unsigned(static_cast<short>(4)) >> 2]);
            output[12] = offsetof(Record, row[signed(false) + long()]);
            size_t instantiated = instantiated_index<Index>();
        }",
        &[4, 4, 8, 8, 12, 8, 8, 8, 8, 8, 8, 8, 4],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_functional_cast_indices() {
    for (index, message) in [
        ("int(input)", "integral constant"),
        ("int(readonly)", "integral constant"),
        ("int(1 / 0)", "division by zero"),
        ("int(true ? Known : readonly)", "volatile"),
        ("float(1)", "integral scalar target"),
        ("true || Pointer(0)", "integral scalar target"),
        ("Record(1)", "integral scalar target"),
        ("int(1.0f)", "integer literal"),
        ("int(nullptr)", "integer literal"),
        ("int((1, 0))", "expected"),
        ("int(0, 1)", "expected"),
        ("int{1}", "integer literal"),
        ("unsigned int(1)", "integer literal"),
        ("signed long(1)", "integer literal"),
        ("Unknown(1)", "integer literal"),
        ("Shadowed(0)", "integral constant"),
        ("true || Shadowed(0)", "expected"),
        ("int(4)", "out of bounds"),
    ] {
        let error = rejected(&format!(
            "#include <cstddef>
             struct Record {{ int row[4]; }};
             using Pointer = int *;
             using Shadowed = int;
             constexpr int Known = 1;
             __global__ void kernel(unsigned *out, unsigned input, volatile int *observed) {{
                 const volatile int &readonly = observed[0];
                 int Shadowed = 0;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_c_style_integral_cast_indices() {
    assert_query_results(
        "#include <cstddef>
        #define CAST(value) ((short)(value))
        struct Record { int head; int row[4]; };
        using Index = short;
        using Wide = unsigned long long;
        constexpr int Known = 1;
        __global__ void kernel(unsigned long *output, unsigned input, volatile int *observed) {
            const volatile int &readonly = observed[0];
            output[0] = offsetof(Record, row[(unsigned short)(int)65537ULL]);
            output[1] = offsetof(Record, row[(int)0xffffffffu + 2]);
            output[2] = offsetof(Record, row[CAST(65538u)]);
            output[3] = offsetof(Record, row[(short)65535u < 0]);
            output[4] = offsetof(Record, row[(short)(65535u < 0)]);
            output[5] = offsetof(Record, row[(bool)0 ? 1 : 2]);
            output[6] = offsetof(Record, row[(bool)-7]);
            output[7] = offsetof(Record, row[(std::size_t)3]);
            output[8] = offsetof(Record, row[(::size_t)2]);
            output[9] = offsetof(Record, row[(decltype(input))2]);
            output[10] = offsetof(Record, row[(true ? -1 : (Wide)input) == 0xffffffffffffffffULL]);
            output[11] = offsetof(Record, row[true || (int)(1 / 0)]);
            output[12] = offsetof(Record, row[true ? (const volatile int)Known : readonly]);
            output[13] = offsetof(Record, row[(int(1))]);
            output[14] = offsetof(Record, row[(Index)+1]);
            {
                constexpr int Index = 2;
                output[15] = offsetof(Record, row[(Index)+1]);
            }
            output[16] = offsetof(Record, row[(Index)+1]);
        }",
        &[8, 8, 12, 8, 4, 12, 8, 16, 12, 12, 8, 8, 8, 8, 8, 16, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_c_style_cast_indices() {
    for (index, message) in [
        ("(int)input", "integral constant"),
        ("(int)readonly", "integral constant"),
        ("(int)(1 / 0)", "division by zero"),
        ("(int)(true ? Known : readonly)", "volatile"),
        ("(float)1", "integral scalar target"),
        ("true || (Pointer)0", "integral scalar target"),
        ("(Record)1", "integral scalar target"),
        ("(int *)0", "integer literal"),
        ("(int &)Known", "integer literal"),
        ("(int)1.0f", "integer literal"),
        ("(int)(0, 1)", "expected"),
        ("(int){1}", "integer literal"),
        ("(int)()", "integer literal"),
        ("(int)", "integer literal"),
        ("(int)4", "out of bounds"),
        ("(short)65535u", "nonnegative"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             using Pointer = int *;
             constexpr int Known = 1;
             __global__ void kernel(unsigned *out, unsigned input, volatile int *observed) {{
                 const volatile int &readonly = observed[0];
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_qualified_and_decltype_cast_indices() {
    assert_query_results(
        "#include <cstddef>
        #define INDEX_TYPE std::size_t
        namespace S = std;
        using Narrow = unsigned short;
        constexpr short Count = 2;
        struct Record { int head; int row[4]; };
        __global__ void kernel(unsigned long *output, unsigned input) {
            namespace Local = S;
            const Narrow local = 1;
            output[0] = offsetof(Record, row[std::size_t(1)]);
            output[1] = offsetof(Record, row[::size_t(2)]);
            output[2] = offsetof(Record, row[::Narrow(65539u)]);
            output[3] = offsetof(Record, row[Local::size_t()]);
            output[4] = offsetof(Record, row[decltype(Count)(65537u)]);
            output[5] = offsetof(Record, row[decltype(Count)()]);
            output[6] = offsetof(Record, row[decltype(input)(2)]);
            output[7] = offsetof(Record, row[decltype(local)(65538u)]);
            output[8] = offsetof(Record, row[(INDEX_TYPE(2))]);
            output[9] = offsetof(Record, row[(true ? -1 : S::size_t(input)) == 0xffffffffffffffffULL]);
            output[10] = offsetof(Record, row[true || decltype(input)(1 / 0)]);
            output[11] = offsetof(Record, row[std::size_t(decltype(Count)(65537u))]);
        }",
        &[8, 12, 16, 4, 8, 4, 12, 12, 12, 8, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_qualified_and_decltype_cast_indices() {
    for (index, message) in [
        ("std::size_t(input)", "integral constant"),
        ("decltype(input)(1 / 0)", "division by zero"),
        ("true || std::nullptr_t(0)", "integral scalar target"),
        ("decltype(nullptr)(0)", "integral scalar target"),
        ("decltype(observed)(0)", "integral scalar target"),
        ("decltype(real)(0)", "integral scalar target"),
        ("decltype((input))(0)", "decltype"),
        ("decltype(Missing)(0)", "decltype"),
        ("decltype(reference)(0)", "decltype"),
        ("Missing::size_t(0)", "unknown CUDA namespace"),
        ("std::Missing(0)", "unsupported standard name"),
        ("std::size_t const(1)", "expected"),
        ("decltype(input) const(1)", "expected"),
        ("std::size_t", "expected"),
        ("decltype(input)", "expected"),
        ("std::size_t(1, 0)", "expected"),
        ("decltype(input){1}", "expected"),
        ("std::size_t(4)", "out of bounds"),
    ] {
        let error = rejected(&format!(
            "#include <cstddef>
             struct Record {{ int row[4]; }};
             __global__ void kernel(unsigned *out, unsigned input, float real, int *observed) {{
                 const unsigned &reference = input;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_scalar_layout_queries_in_indices() {
    assert_query_results(
        "#include <cstddef>
        #define WORD_BYTES sizeof(int)
        struct Record { int head; int row[4]; };
        using Half = const unsigned short;
        template<class T> __device__ size_t selected() {
            return offsetof(Record, row[sizeof(T) / alignof(T)]);
        }
        __global__ void kernel(unsigned long *output, unsigned input) {
            output[0] = offsetof(Record, row[WORD_BYTES / sizeof(short)]);
            output[1] = offsetof(Record, row[alignof(long) / WORD_BYTES]);
            output[2] = offsetof(Record, row[sizeof(volatile float) / alignof(bool) - 1]);
            output[3] = offsetof(Record, row[alignof(Half)]);
            output[4] = offsetof(Record, row[sizeof(decltype(input)) / WORD_BYTES]);
            output[5] = offsetof(Record, row[sizeof(std::size_t) / alignof(unsigned long long)]);
            output[6] = offsetof(Record, row[(true ? -1 : sizeof(int)) == 0xffffffffffffffffULL]);
            output[7] = offsetof(Record, row[true || alignof(int) / 0]);
            output[8] = offsetof(Record, row[sizeof(bool) + alignof(bool)]);
            size_t instantiated = selected<short>();
        }",
        &[12, 12, 16, 12, 8, 8, 8, 8, 12],
    );
}

#[test]
fn cuda_record_offsetof_rejects_unsupported_layout_queries_in_indices() {
    for (index, message) in [
        ("sizeof(int && &)", "expected"),
        ("sizeof(int())", "expected"),
        ("sizeof()", "type"),
        ("sizeof int", "expected"),
        ("alignof(int", "expected"),
        ("alignof(Shadowed)", "type"),
        ("sizeof(int)", "out of bounds"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             using Shadowed = int;
             __global__ void kernel(unsigned *out, unsigned input) {{
                 int Shadowed = 0;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_evaluates_aggregate_sizeof_in_indices() {
    assert_query_results(
        "#include <cstddef>
        struct Record { int head; int row[5]; };
        struct Padded { short first; int middle; short last; };
        using Pair = Padded[2];
        using Grid = int[2][3];
        using Packed = float3[2];
        template<class T> __device__ size_t selected() {
            return offsetof(Record, row[sizeof(T) / sizeof(int)]);
        }
        __global__ void kernel(unsigned long *output) {
            Padded object;
            short local[4];
            output[0] = offsetof(Record, row[sizeof(float1) / 4]);
            output[1] = offsetof(Record, row[sizeof(float2) / 4]);
            output[2] = offsetof(Record, row[sizeof(float3) / 4]);
            output[3] = offsetof(Record, row[sizeof(float4) / 4]);
            output[4] = offsetof(Record, row[sizeof(short3) / 2]);
            output[5] = offsetof(Record, row[sizeof(const Padded) / 4]);
            output[6] = offsetof(Record, row[sizeof(Pair) / 8]);
            output[7] = offsetof(Record, row[sizeof(Grid) / 6]);
            output[8] = offsetof(Record, row[sizeof(Packed) / 8]);
            output[9] = offsetof(Record, row[sizeof(decltype(object)) / 4]);
            output[10] = offsetof(Record, row[sizeof(decltype(local)) / 4]);
            output[11] = offsetof(Record, row[(true ? -1 : sizeof(Pair)) == 0xffffffffffffffffULL]);
            output[12] = offsetof(Record, row[true || sizeof(Pair) / 0]);
            size_t instantiated = selected<Padded>();
        }",
        &[8, 12, 16, 20, 16, 16, 16, 20, 16, 16, 12, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_incomplete_or_unsupported_sizeof_in_indices() {
    for index in [
        "sizeof(Incomplete)",
        "true || sizeof(Incomplete)",
        "sizeof(dim3)",
        "sizeof(std::nullptr_t)",
    ] {
        let error = rejected(&format!(
            "#include <cstddef>
             struct Record {{ int row[4]; }};
             using Incomplete = int[];
             __global__ void kernel(unsigned *out) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(
            error.message.contains("complete record"),
            "{index}: {error}"
        );
    }
}

#[test]
fn cuda_record_offsetof_evaluates_aggregate_alignof_in_indices() {
    assert_query_results(
        "#include <cstddef>
        struct Record { int head; int row[5]; };
        struct Padded { short first; int middle; short last; };
        struct Aligned { int tag; float4 value; };
        using Packed = float3[2];
        using Narrow = short3[2];
        using Grid = Padded[2][3];
        using Open = Aligned[][2];
        using Native = float2[3];
        template<class T> __device__ size_t selected() {
            return offsetof(Record, row[alignof(T) / 4]);
        }
        __global__ void kernel(unsigned long *output) {
            Aligned object;
            output[0] = offsetof(Record, row[alignof(float1) / 4]);
            output[1] = offsetof(Record, row[alignof(float2) / 4]);
            output[2] = offsetof(Record, row[alignof(float3) / 4]);
            output[3] = offsetof(Record, row[alignof(float4) / 4]);
            output[4] = offsetof(Record, row[alignof(short3) / 2]);
            output[5] = offsetof(Record, row[alignof(const Padded) / 4]);
            output[6] = offsetof(Record, row[alignof(Grid) / 4]);
            output[7] = offsetof(Record, row[alignof(Packed) / 4]);
            output[8] = offsetof(Record, row[alignof(Narrow) / 2]);
            output[9] = offsetof(Record, row[alignof(Open) / 4]);
            output[10] = offsetof(Record, row[alignof(decltype(object)) / 4]);
            output[11] = offsetof(Record, row[alignof(Native) / 4]);
            output[12] = offsetof(Record, row[alignof(Padded) < sizeof(Padded)]);
            output[13] = offsetof(Record, row[true || alignof(Grid) / 0]);
            size_t instantiated = selected<Aligned>();
        }",
        &[8, 12, 8, 20, 8, 8, 8, 8, 8, 20, 20, 12, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_unsupported_aggregate_alignof_in_indices() {
    for index in ["alignof(dim3)", "alignof(std::nullptr_t)"] {
        let error = rejected(&format!(
            "#include <cstddef>
             struct Record {{ int row[4]; }};
             __global__ void kernel(unsigned *out) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(
            error.message.contains("complete record"),
            "{index}: {error}"
        );
    }
}

#[test]
fn cuda_record_offsetof_evaluates_named_sizeof_in_indices() {
    assert_query_results(
        "#include <cstddef>
        struct Record { int head; int row[5]; };
        struct Padded { short first; int middle; short last; };
        using Open = int[];
        using Shadowed = long;
        constexpr short Constant = 1;
        __constant__ int Pool[3];
        __device__ size_t checked(int value) noexcept(offsetof(Record, row[sizeof value / 4]) == 8) {
            return offsetof(Record, row[sizeof value / 4]);
        }
        __device__ size_t adjusted(volatile int values[3]) {
            return offsetof(Record, row[sizeof(values) / 4]);
        }
        __global__ void kernel(unsigned long *output, unsigned input, volatile int *values) {
            Padded object;
            Padded &alias = object;
            float3 packed;
            short grid[2][3];
            Open *pointer = nullptr;
            auto null_value = nullptr;
            volatile int &referent = values[0];
            output[0] = offsetof(Record, row[sizeof(input) / 4]);
            output[1] = offsetof(Record, row[sizeof input / 4 + 1]);
            output[2] = offsetof(Record, row[sizeof object / 4]);
            output[3] = offsetof(Record, row[sizeof(alias) / 4]);
            output[4] = offsetof(Record, row[sizeof packed / 4]);
            output[5] = offsetof(Record, row[sizeof(grid) / 4]);
            output[6] = offsetof(Record, row[sizeof pointer / 4]);
            output[7] = offsetof(Record, row[sizeof(null_value) / 4]);
            output[8] = offsetof(Record, row[sizeof referent / 4]);
            output[9] = offsetof(Record, row[sizeof(Constant)]);
            output[10] = offsetof(Record, row[sizeof Pool / 4]);
            output[11] = offsetof(Record, row[sizeof(Shadowed) / 4]);
            {
                short Shadowed;
                output[12] = offsetof(Record, row[sizeof(Shadowed) / 2]);
            }
            output[13] = offsetof(Record, row[true || sizeof(input) / 0]);
            size_t result = adjusted(values) + checked(0);
        }",
        &[8, 12, 16, 16, 16, 16, 12, 12, 8, 12, 16, 12, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_unsupported_named_sizeof_in_indices() {
    for (index, message) in [
        ("sizeof(scratch)", "complete"),
        ("true || sizeof scratch", "complete"),
        ("sizeof local[0++]", "expected"),
        ("sizeof(object.row[0)", "expected"),
        ("sizeof(input++)", "expected"),
        ("sizeof helper()", "named object"),
        ("sizeof Missing", "named object"),
        ("sizeof Index", "parenthesized type"),
        ("alignof(input)", "type"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[5]; }};
             using Index = int;
             __device__ int helper() {{ return 0; }}
             __global__ void kernel(unsigned *out, unsigned input) {{
                 extern __shared__ int scratch[];
                 int local[3];
                 Record object;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
    let error = rejected(
        "struct Record { int row[5]; };
         __global__ void kernel() {
             int pending[] = { int(__builtin_offsetof(Record, row[sizeof(pending)])) };
         }",
    );
    assert!(error.message.contains("complete"), "{error}");
}

#[test]
fn cuda_record_offsetof_evaluates_indirect_type_queries_in_indices() {
    assert_query_results(
        "#include <cstddef>
        struct Record { int head; int row[5]; };
        struct Padded { short first; int middle; short last; };
        using Pointer = int *;
        using Row = int[3];
        using Open = int[];
        __global__ void kernel(unsigned long *output, int *input) {
            output[0] = offsetof(Record, row[sizeof(int *) / 4]);
            output[1] = offsetof(Record, row[alignof(const volatile void *) / 4]);
            output[2] = offsetof(Record, row[sizeof(void const * volatile *&&) / 4]);
            output[3] = offsetof(Record, row[sizeof(Pointer const &) / 4]);
            output[4] = offsetof(Record, row[alignof(Pointer *) / 4]);
            output[5] = offsetof(Record, row[sizeof(int &) / 4]);
            output[6] = offsetof(Record, row[alignof(int &&) / 4]);
            output[7] = offsetof(Record, row[sizeof(const Row &) / 4]);
            output[8] = offsetof(Record, row[alignof(Row &&) / 4]);
            output[9] = offsetof(Record, row[sizeof(Open *) / 4]);
            output[10] = offsetof(Record, row[alignof(Open &) / 4]);
            output[11] = offsetof(Record, row[sizeof(Padded &) / 4]);
            output[12] = offsetof(Record, row[sizeof(decltype(input)) / 4]);
            output[13] = offsetof(Record, row[alignof(std::size_t *) / 4]);
            output[14] = offsetof(Record, row[true || sizeof(int *) / 0]);
        }",
        &[12, 12, 12, 12, 12, 8, 8, 16, 8, 12, 8, 16, 12, 12, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_indirect_type_queries_in_indices() {
    for (index, message) in [
        ("sizeof(void)", "complete object type"),
        ("alignof(const void &)", "complete object type"),
        ("true || sizeof(void &&)", "complete object type"),
        ("sizeof(Open &)", "fixed-array type"),
        ("sizeof(int &*)", "expected"),
        ("sizeof(int *)", "out of bounds"),
        ("sizeof(int (*)(int))", "expected"),
        ("alignof(int (&)[2])", "expected"),
        ("sizeof(int &[2])", "direct arrays"),
        ("alignof(int * const const)", "duplicate const"),
        (
            "true || sizeof(int * volatile volatile)",
            "duplicate volatile",
        ),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[4]; }};
             using Open = int[];
             __global__ void kernel(unsigned *out) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }

    let stars = "*".repeat(65);
    let error = rejected(&format!(
        "struct Record {{ int row[4]; }};
         __global__ void kernel(unsigned *out) {{
             out[0] = unsigned(__builtin_offsetof(Record, row[sizeof(void {stars}) / 8]));
         }}"
    ));
    assert!(error.message.contains("pointer nesting limit"), "{error}");
}

#[test]
fn cuda_record_offsetof_evaluates_array_type_queries_in_indices() {
    assert_query_results(
        "#include <cstddef>
        #define ROWS 2
        struct Record { int head; int row[5]; };
        struct Padded { short first; int middle; short last; };
        using Row = int[3];
        constexpr int Count = 2;
        template<int N> __device__ size_t selected() {
            return offsetof(Record, row[sizeof(int[N]) / sizeof(int)]);
        }
        __global__ void kernel(unsigned long *output, unsigned input) {
            output[0] = offsetof(Record, row[sizeof(int[ROWS][3]) / 8]);
            output[1] = offsetof(Record, row[sizeof(Row[Count][2]) / 12]);
            output[2] = offsetof(Record, row[alignof(int[2][3]) / 4]);
            output[3] = offsetof(Record, row[alignof(float4[][3]) / 4]);
            output[4] = offsetof(Record, row[sizeof(Padded[2]) / 8]);
            output[5] = offsetof(Record, row[sizeof(float3[2]) / 8]);
            output[6] = offsetof(Record, row[sizeof(short3[2]) / 4]);
            output[7] = offsetof(Record, row[sizeof(bool[2][2])]);
            output[8] = offsetof(Record, row[sizeof(int[sizeof(int)]) / 4]);
            output[9] = offsetof(Record, row[sizeof(int[true || input]) / 4]);
            output[10] = offsetof(Record, row[sizeof(int[static_cast<unsigned>(1 + 1)]) / 4]);
            output[11] = offsetof(Record, row[alignof(Row[][2]) / 4]);
            size_t instantiated = selected<3>();
        }",
        &[16, 20, 8, 20, 16, 16, 16, 20, 20, 8, 12, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_invalid_array_type_queries_in_indices() {
    for (index, message) in [
        ("sizeof(int[0])", "positive"),
        ("sizeof(int[-1])", "positive"),
        ("sizeof(int[0x100000000ULL])", "positive"),
        ("sizeof(int[input])", "integral constant"),
        ("true || sizeof(int[1 / 0])", "division by zero"),
        ("true || alignof(int[1 << 32])", "shift count"),
        ("sizeof(int[536870912])", "type size limit"),
        ("alignof(int[][536870912])", "type size limit"),
        ("sizeof(int[][2])", "complete"),
        ("alignof(int[2][])", "outermost"),
        ("alignof(Open[2])", "complete"),
        ("sizeof(int *[2])", "direct arrays"),
        ("sizeof(int &[2])", "direct arrays"),
        ("sizeof(int[2)", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int row[5]; }};
             using Open = int[];
             __global__ void kernel(unsigned *out, unsigned input) {{
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
    let suffixes = "[1]".repeat(64);
    let error = rejected(&format!(
        "struct Record {{ int row[5]; }};
         using Row = int[3];
         __global__ void kernel(unsigned *out) {{
             out[0] = unsigned(__builtin_offsetof(Record, row[alignof(Row{suffixes})]));
         }}"
    ));
    assert!(error.message.contains("array rank limit"), "{error}");
}

#[test]
fn cuda_record_offsetof_evaluates_member_sizeof_in_indices() {
    assert_query_results(
        "#include <cstddef>
        struct Record { int head; int row[5]; };
        struct Payload { float3 vector; short grid[2][3]; };
        struct Outer { int tag; Payload payload; };
        __constant__ Outer Global[2];
        __global__ void kernel(unsigned long *output, volatile Outer *input) {
            extern __shared__ Outer scratch[];
            Outer object;
            Outer &alias = object;
            Outer local[2];
            Outer *missing = nullptr;
            float4 wide;
            int grid = 0;
            output[0] = offsetof(Record, row[sizeof(object.payload.grid) / 4]);
            output[1] = offsetof(Record, row[sizeof alias.payload / 8]);
            output[2] = offsetof(Record, row[sizeof input->payload.vector.z / 4 + 1]);
            output[3] = offsetof(Record, row[sizeof(missing->payload.grid) / 4]);
            output[4] = offsetof(Record, row[sizeof(local->payload.grid) / 4]);
            output[5] = offsetof(Record, row[sizeof(Global->payload.grid) / 4]);
            output[6] = offsetof(Record, row[sizeof(scratch->payload.grid) / 4]);
            output[7] = offsetof(Record, row[sizeof(wide.w) / 4]);
            output[8] = offsetof(Record, row[sizeof input->tag / 4]);
            output[9] = offsetof(Record, row[true || sizeof(input->tag) / 0]);
        }",
        &[16, 16, 12, 16, 16, 16, 16, 8, 8, 8],
    );
}

#[test]
fn cuda_record_offsetof_rejects_unsupported_member_sizeof_in_indices() {
    for (index, message) in [
        ("sizeof(pointer.tag)", "member access"),
        ("sizeof(object->tag)", "member access"),
        ("sizeof(local.tag)", "field"),
        ("sizeof(none->tag)", "member access"),
        ("sizeof(object.missing)", "field"),
        ("true || sizeof(pointer->missing)", "field"),
        ("sizeof(pointer->tag.other)", "field"),
        ("sizeof(vector.w)", "field"),
        ("sizeof(object.)", "identifier"),
        ("sizeof(pointer->tag++)", "expected"),
        ("alignof(object.tag)", "type"),
    ] {
        let error = rejected(&format!(
            "struct Record {{ int tag; int row[5]; }};
             __global__ void kernel(unsigned *out, Record *pointer) {{
                 Record object;
                 Record local[2];
                 auto none = nullptr;
                 float3 vector;
                 out[0] = unsigned(__builtin_offsetof(Record, row[{index}]));
             }}"
        ));
        assert!(error.message.contains(message), "{index}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_resolves_named_integral_indices_in_scope() {
    assert_query_results(
        "#include <cstddef>\n#define COLUMN column\n
        constexpr unsigned row = 1u;
        constexpr short column = 2;
        struct Outer { int prefix; int grid[2][3]; };
        template<unsigned Index = 1, bool Last = true>
        __device__ size_t choose() { return offsetof(Outer, grid[Last][Index]); }
        static_assert(offsetof(Outer, grid[row][column]) == 24u);
        __global__ void kernel(unsigned long *output) {
            const auto zero = 0U;
            constexpr unsigned long long first = 1ULL;
            output[0] = offsetof(Outer, grid[row][COLUMN]);
            {
                const int row = 0;
                output[1] = __builtin_offsetof(Outer, grid[row][first]);
            }
            output[2] = offsetof(Outer, grid[row][zero]);
            constexpr bool start = false;
            output[3] = offsetof(Outer, grid[start][first]);
            static_assert(offsetof(Outer, grid[row][first]) == 20u);
            size_t local = choose<>();
        }",
        &[24, 8, 16, 8],
    );
}

#[test]
fn cuda_record_offsetof_accepts_grouped_indices_and_parenthesizing_macros() {
    assert_query_results(
        "#include <cstddef>\n#define COLUMN (column)\n#define WRAP(value) ((value))\n
        constexpr unsigned column = 2u;
        struct Leaf { int first; int values[3]; };
        struct Record { int prefix; Leaf leaves[2]; int grid[2][3]; };
        template<unsigned Row> __device__ size_t offset() {
            return offsetof(Record, grid[(Row)][COLUMN]);
        }
        __global__ void kernel(unsigned long *output) {
            const unsigned row = 1u;
            output[0] = offsetof(Record, leaves[WRAP(row)].values[((0x2ULL))]);
            output[1] = __builtin_offsetof(Record, grid[((0U))][COLUMN]);
            output[2] = offsetof(Record, leaves[(1)].values[(0)]);
            size_t instantiated = offset<1u>();
        }",
        &[32, 44, 24],
    );
}

#[test]
fn cuda_record_offsetof_rejects_nonconstant_and_invalid_named_indices() {
    for (body, message) in [
        ("unsigned Index = 1u; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("unsigned Index = 1u; __builtin_offsetof(Record, row[((Index))]);", "integral constant"),
        ("const unsigned Index = input; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("const unsigned value = 1u; const unsigned &Index = value; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("constexpr float Index = 1.0f; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("constexpr int Index = -1; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("constexpr unsigned long long Index = 4294967296ULL; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("constexpr unsigned Index = 3u; __builtin_offsetof(Record, row[Index]);", "out of bounds"),
        ("constexpr unsigned Index = 3u; __builtin_offsetof(Record, row[((Index))]);", "out of bounds"),
        ("using Index = int; __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("const auto Index = __builtin_offsetof(Record, row[Index]);", "integral constant"),
        ("__builtin_offsetof(Record, row[input]);", "integral constant"),
        ("__builtin_offsetof(Record, row[StorageIndex]);", "integral constant"),
        ("__builtin_offsetof(Record, row[Index + input]);", "integral constant"),
        ("__builtin_offsetof(Record, row[(Index, 1)]);", "expected"),
        ("__builtin_offsetof(Record, row[::Index]);", "unknown CUDA namespace or type qualifier"),
    ] {
        let error = rejected(&format!(
            "constexpr unsigned Index = 1u;
            __constant__ unsigned StorageIndex;
            struct Record {{ int row[3]; }};
            __global__ void kernel(const unsigned input) {{ {body} }}"
        ));
        assert!(error.message.contains(message), "{body}: {error}");
    }
}

#[test]
fn cuda_record_offsetof_rejects_non_record_types_and_indirect_designators() {
    for (operands, message) in [
        ("int, x", "complete record"),
        ("float2, x", "complete record"),
        ("float3, x", "complete record"),
        ("dim3, x", "complete record"),
        ("Pointer, row", "complete record"),
        ("Array, row", "complete record"),
        ("Record, absent", "unknown or unsupported field"),
        ("Record, nested.absent", "unknown or unsupported field"),
        ("Record, absent.member", "unknown or unsupported field"),
        ("Record, row.member", "complete record"),
        ("Record, native.x", "complete record"),
        ("Record, packed.x", "complete record"),
        ("Record, nested.member.next", "complete record"),
        ("Record, .nested.member", "expected"),
        ("Record, nested..member", "expected"),
        ("Record, nested.", "expected"),
        ("Record, nested.member()", "expected"),
        ("Record, nested->member", "expected"),
        ("Record, Record::row", "expected"),
        ("Record, row + 1", "expected"),
        ("Record, 0", "expected"),
        ("Record row", "expected"),
    ] {
        let error = rejected(&format!(
            "struct Inner {{ int member; }};
            struct Record {{ Inner nested; int row[3]; float2 native; float3 packed; }};
            using Pointer = Record *; using Array = Record[2];
            __global__ void kernel(unsigned *output) {{
                output[0] = unsigned(__builtin_offsetof({operands}));
            }}"
        ));
        assert!(error.message.contains(message), "{operands}: {error}");
    }
    let error = rejected(
        "struct Record { int head; static_assert(__builtin_offsetof(Record, head) == 0u); };
         __global__ void kernel() {}",
    );
    assert!(error.message.contains("Record"), "{error}");
    let error = rejected(
        "struct Record { int head; }; using Alias = Record;
         __global__ void kernel(unsigned *output) {
             int Alias; output[0] = unsigned(__builtin_offsetof(Alias, head));
         }",
    );
    assert!(error.message.contains("Alias"), "{error}");
    let error = rejected("__global__ void kernel() { int __builtin_offsetof; }");
    assert!(error.message.contains("reserved"), "{error}");
}

#[test]
fn cuda_type_queries_cover_scalar_spellings_qualifiers_and_aliases() {
    for (spelling, size) in [
        ("bool", 1),
        ("short", 2),
        ("unsigned short int", 2),
        ("int", 4),
        ("signed int", 4),
        ("unsigned int", 4),
        ("float", 4),
        ("long", 8),
        ("long unsigned int", 8),
        ("long long", 8),
        ("unsigned long long", 8),
        ("size_t", 8),
        ("std::size_t", 8),
        ("::size_t", 8),
    ] {
        assert_query_results(
            &format!(
                "#include <cstddef>\n
                using Element = {spelling};
                typedef const volatile Element Frozen;
                __global__ void kernel(unsigned long *output) {{
                    output[0] = sizeof({spelling});
                    output[1] = alignof({spelling});
                    output[2] = sizeof(Frozen);
                    output[3] = alignof(Frozen);
                }}"
            ),
            &[size, size, size, size],
        );
    }
}

#[test]
fn cuda_type_queries_use_cuda_vector_and_dimension_layouts() {
    for (prefix, scalar_size) in [
        ("float", 4),
        ("int", 4),
        ("uint", 4),
        ("short", 2),
        ("ushort", 2),
    ] {
        for (width, alignment_factor) in [(1, 1), (2, 2), (3, 1), (4, 4)] {
            let name = format!("{prefix}{width}");
            assert_query_results(
                &format!(
                    "__global__ void kernel(unsigned long *output) {{
                        output[0] = sizeof({name});
                        output[1] = alignof({name});
                        output[2] = sizeof({name}[3]);
                        output[3] = alignof({name}[3]);
                    }}"
                ),
                &[
                    scalar_size * width,
                    scalar_size * alignment_factor,
                    scalar_size * width * 3,
                    scalar_size * alignment_factor,
                ],
            );
        }
    }
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            output[0] = sizeof(dim3);
            output[1] = alignof(dim3);
        }",
        &[12, 4],
    );
}

#[test]
fn cuda_type_queries_preserve_record_padding_and_multidimensional_arrays() {
    assert_query_results(
        "struct Record { short head; long payload; float3 vector; unsigned tail; };
        using Row = float3[2];
        using Grid = Row[3];
        __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Record);
            output[1] = alignof(Record);
            output[2] = sizeof(Record[3]);
            output[3] = alignof(Record[3]);
            output[4] = sizeof(Grid);
            output[5] = alignof(Grid);
            output[6] = sizeof(short3[5]);
            output[7] = alignof(short3[5]);
            output[8] = sizeof(int[2][3]);
            output[9] = sizeof(int[alignof(float4)]);
        }",
        &[32, 8, 96, 8, 72, 4, 30, 2, 24, 64],
    );
}

#[test]
fn cuda_type_queries_use_lp64_pointer_and_referent_layouts() {
    for (spelling, size, alignment) in [
        ("int *", 8, 8),
        ("const volatile long *const", 8, 8),
        ("void *", 8, 8),
        ("const void *", 8, 8),
        ("int **const *", 8, 8),
        ("int &", 4, 4),
        ("const bool &", 1, 1),
        ("long *&", 8, 8),
        ("decltype(nullptr)", 8, 8),
    ] {
        assert_query_results(
            &format!(
                "__global__ void kernel(unsigned long *output) {{
                    output[0] = sizeof({spelling});
                    output[1] = alignof({spelling});
                }}"
            ),
            &[size, alignment],
        );
    }
    assert_query_results(
        "using Row = int[3];
        using Pointer = const long *;
        using Null = decltype(nullptr);
        __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Row &);
            output[1] = alignof(Row &);
            output[2] = sizeof(Row *);
            output[3] = alignof(Row *);
            output[4] = sizeof(Pointer);
            output[5] = alignof(Pointer);
            output[6] = sizeof(Null);
            output[7] = alignof(Null);
        }",
        &[12, 4, 8, 8, 8, 8, 8, 8],
    );
}

#[test]
fn cuda_type_queries_align_unknown_bound_arrays_without_completing_them() {
    assert_query_results(
        "using Unknown = int[];
        using Rows = short3[][2];
        __global__ void kernel(unsigned long *output) {
            output[0] = alignof(Unknown);
            output[1] = alignof(int[]);
            output[2] = alignof(Rows);
            output[3] = sizeof(Unknown *);
            output[4] = alignof(Unknown *);
        }",
        &[4, 4, 2, 8, 8],
    );
    for spelling in ["Unknown", "int[]", "Rows"] {
        rejected(&format!(
            "using Unknown = int[]; using Rows = short3[][2];
            __global__ void kernel(unsigned long *output) {{ output[0] = sizeof({spelling}); }}"
        ));
    }
}

#[test]
fn cuda_type_queries_keep_builtin_size_t_identity_when_aliases_are_shadowed() {
    let module = roundtrip(
        "__device__ unsigned kind(unsigned value) { return 1u; }
        __device__ unsigned kind(unsigned long value) { return 2u; }
        __device__ unsigned kind(unsigned long long value) { return 3u; }
        __global__ void kernel(unsigned *output) {
            using size_t = unsigned;
            output[0] = kind(sizeof(int));
            output[1] = kind(alignof(float3));
            { using size_t = unsigned long long; output[2] = kind(sizeof(bool)); }
        }",
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 3);
    assert!(targets.iter().all(|&target| target == targets[0]));
    let function = &module.functions[targets[0]];
    let mut returned = None;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Return { value: Some(value) } = *statement {
            returned = Some(value);
        }
        false
    });
    assert_eq!(
        function.expressions[returned.unwrap()],
        naga::Expression::Literal(naga::Literal::U32(2))
    );
}

#[test]
fn cuda_type_queries_supply_global_local_array_and_launch_bound_constants() {
    let source = "constexpr size_t Bytes = sizeof(float3[2]);
        constexpr size_t Alignment = alignof(float3);
        using Row = unsigned[sizeof(float)];
        __global__ __launch_bounds__(sizeof(float) * alignof(float))
        void kernel(unsigned *output) {
            const size_t local_count = sizeof(short[3]);
            unsigned local[local_count] = {1};
            Row row = {1, 2, 3, 4};
            __shared__ unsigned tile[Bytes / Alignment];
            output[0] = local[0] + row[3];
        }";
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options {
            workgroup_size: [8, 1, 1],
            ..Default::default()
        },
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
    for (name, count) in [("local", 6), ("row", 4)] {
        let local = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find(|(_, variable)| variable.name.as_deref() == Some(name))
            .unwrap()
            .1;
        assert!(
            matches!(module.types[local.ty].inner,
                naga::TypeInner::Array { size: naga::ArraySize::Constant(actual), stride: 4, .. }
                    if actual.get() == count),
            "{name}"
        );
    }
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, variable)| variable.space == naga::AddressSpace::WorkGroup)
        .collect();
    assert_eq!(shared.len(), 1);
    assert!(matches!(module.types[shared[0].1.ty].inner,
        naga::TypeInner::Array { size: naga::ArraySize::Constant(count), stride: 4, .. }
            if count.get() == 6));
    assert_eq!(module.entry_points[0].workgroup_size, [8, 1, 1]);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
    let _ = info;
}

#[test]
fn cuda_type_queries_support_dependent_types_and_template_deduction() {
    let module = roundtrip(
        "template<class Value> __device__ Value keep(Value value) { return value; }
        template<class Value> __device__ size_t footprint() { return sizeof(Value) + alignof(Value); }
        template<size_t Bytes> __device__ unsigned extent() { return unsigned(Bytes); }
        template<class Value> __device__ unsigned width() { return extent<sizeof(Value)>(); }
        __global__ void kernel(unsigned long *output) {
            output[0] = keep(sizeof(int));
            output[1] = keep(4UL);
            output[2] = keep(4ULL);
            output[3] = footprint<float3>();
            output[4] = width<short>();
        }",
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 5);
    assert_eq!(targets[0], targets[1]);
    assert_ne!(targets[0], targets[2]);
    rejected(
        "template<class Value> __device__ size_t footprint() { return sizeof(Value); }
        using Unknown = int[];
        __global__ void kernel(unsigned long *output) { output[0] = footprint<Unknown>(); }",
    );
}

#[test]
fn cuda_type_queries_support_byte_counted_grid_stride_copy() {
    let module = roundtrip(
        "__global__ void copy(int *output, const int *input, size_t bytes) {
            unsigned stride = gridDim.x * blockDim.x;
            unsigned index = blockDim.x * blockIdx.x + threadIdx.x;
            for (size_t position = index; position < bytes / sizeof(int); position += stride) {
                output[position] = input[position];
            }
        }",
    );
    assert_eq!(module.global_variables.len(), 3);
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| matches!(statement, naga::Statement::Loop { .. })
    ));
}

#[test]
fn cuda_type_queries_preserve_macro_expansion_and_alias_scope() {
    assert_query_results(
        "#define WORD_BYTES sizeof(float)\n
        using Triple = float3;
        __global__ void kernel(unsigned long *output) {
            output[0] = WORD_BYTES;
            output[1] = sizeof(Triple);
            { using Triple = short3; output[2] = sizeof(Triple); }
            output[3] = sizeof(Triple);
        }",
        &[4, 12, 6, 12],
    );
    for condition in ["sizeof(int)", "alignof(int)"] {
        rejected(&format!(
            "#if {condition}\n#error invalid preprocessing expression\n#endif\n__global__ void kernel() {{}}"
        ));
    }
}

#[test]
fn cuda_type_queries_reject_invalid_types_syntax_and_expression_operands() {
    for query in [
        "sizeof(void)",
        "alignof(void)",
        "sizeof(double)",
        "alignof(half)",
        "sizeof(Unknown)",
        "sizeof(int())",
        "alignof(int())",
        "sizeof(int[0])",
        "sizeof(int[-1])",
        "sizeof(int[18446744073709551615ULL])",
        "sizeof(int[2][])",
        "sizeof(int*[2])",
        "sizeof(int&[3])",
        "sizeof(int(*)[3])",
        "sizeof(int int)",
        "alignof(const const int)",
        "sizeof()",
        "alignof()",
        "sizeof(int, float)",
        "alignof(int, float)",
        "sizeof int",
        "alignof int",
        "alignof(1)",
        "sizeof(++value)",
        "sizeof(sizeof(int))",
        "sizeof(cooperative_groups::thread_block)",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                unsigned value = 0u; unsigned values[2] = {{0u, 1u}};
                output[0] = {query};
            }}"
        ));
    }
    for declaration in [
        "int sizeof = 0;",
        "using alignof = int;",
        "typedef int sizeof;",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_type_queries_bound_nested_queries_and_pointer_depth() {
    let mut query = String::from("sizeof(int)");
    for _ in 0..70 {
        query = format!("sizeof(int[{query}])");
    }
    rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ output[0] = {query}; }}"
    ));
    let pointers = "*".repeat(70);
    rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ output[0] = sizeof(int{pointers}); }}"
    ));
}

#[test]
fn cuda_sizeof_named_objects_preserves_arrays_references_and_pointer_sizes() {
    assert_query_results(
        "struct Record { float3 vector; long tag; };
        __global__ void kernel(unsigned long *output, unsigned parameter) {
            short scalar;
            float3 vector;
            Record record;
            int matrix[2][3];
            Record &reference = record;
            int *pointer;
            auto null_value = nullptr;
            output[0] = sizeof(scalar);
            output[1] = sizeof(vector);
            output[2] = sizeof(record);
            output[3] = sizeof(matrix);
            output[4] = sizeof(reference);
            output[5] = sizeof(pointer);
            output[6] = sizeof(output);
            output[7] = sizeof(null_value);
            output[8] = sizeof(parameter);
        }",
        &[2, 12, 24, 24, 24, 8, 8, 8, 4],
    );
}

#[test]
fn cuda_sizeof_named_objects_is_unevaluated_and_accepts_unparenthesized_names() {
    let module = roundtrip(
        "__global__ void kernel(unsigned long *output, volatile unsigned *input) {
            volatile unsigned &reference = input[0];
            unsigned uninitialized;
            output[0] = sizeof reference;
            output[1] = sizeof(uninitialized);
            output[2] = sizeof input + 1UL;
        }",
    );
    let function = &module.entry_points[0].function;
    assert!(function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            int values[3];
            output[0] = sizeof values;
            constexpr size_t Doubled = sizeof values * 2UL;
            output[1] = sizeof(int[Doubled]);
        }",
        &[12, 96],
    );
}

#[test]
fn cuda_sizeof_named_objects_respects_shadowing_and_supplies_template_constants() {
    assert_query_results(
        "constexpr unsigned Global = 3u;
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Bytes = sizeof(value);
            int array[sizeof(value)];
            output[0] = sizeof(Global);
            output[1] = sizeof(Bytes);
            output[2] = sizeof(array);
            using Name = int;
            { short Name; output[3] = sizeof(Name); }
            output[4] = sizeof(Name);
        }
        template __global__ void kernel<short>(unsigned long *);",
        &[4, 8, 8, 2, 4],
    );
    let module = roundtrip(
        "template<size_t Count> __device__ size_t bytes() { return sizeof(Count); }
        __global__ void kernel(unsigned long *output) {
            int array[3];
            output[0] = bytes<sizeof(array)>();
        }",
    );
    assert_eq!(module.functions.len(), 1);
    let (_, function) = module.functions.iter().next().unwrap();
    assert!(function
        .expressions
        .iter()
        .any(|(_, expression)| *expression == naga::Expression::Literal(naga::Literal::U64(8))));
}

#[test]
fn cuda_sizeof_named_shared_and_constant_memory_keeps_source_layouts() {
    assert_query_results(
        "__constant__ float3 coefficients[2];
        constexpr size_t Bytes = sizeof(coefficients);
        __global__ void kernel(unsigned long *output) {
            __shared__ short shared_values[3];
            output[0] = sizeof(coefficients);
            output[1] = sizeof(shared_values);
            output[2] = sizeof(int[Bytes]);
        }",
        &[24, 6, 96],
    );
    for bytes in [0, 16, 128] {
        let error = naga::front::cuda::parse_str(
            "extern __shared__ unsigned dynamic[];
            __global__ void kernel(unsigned long *output) { output[0] = sizeof(dynamic); }",
            &Options {
                dynamic_shared_memory_size: bytes,
                ..Options::default()
            },
        )
        .unwrap_err();
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_named_objects_rejects_nonobjects_and_unsupported_operands() {
    assert_query_results(
        "__global__ void kernel(unsigned long *output) { unsigned value; int *pointer; int index;
            output[0] = sizeof(value + 1); output[1] = sizeof(*pointer + 1);
            output[2] = sizeof((value + 1)); output[3] = sizeof(1 + 1);
            output[4] = sizeof(pointer[index + 1]);
        }",
        &[4, 4, 4, 4, 4],
    );
    for operand in [
        "missing",
        "helper",
        "group",
        "value++",
        "value + pointer",
        "value, value++",
    ] {
        rejected(&format!(
            "__device__ int helper() {{ return 1; }}
            __global__ void kernel(unsigned long *output) {{
                unsigned value = 0; int *pointer;
                auto group = cooperative_groups::this_thread_block();
                output[0] = sizeof({operand});
            }}"
        ));
    }
    for expression in ["alignof(value)", "sizeof value++", "sizeof(value)++"] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                unsigned value = 0; int *pointer;
                output[0] = {expression};
            }}"
        ));
    }
    rejected("__global__ void kernel() { auto value = sizeof(value); }");
}

#[test]
fn cuda_sizeof_named_objects_rejects_incomplete_inferred_array_during_initialization() {
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            int fixed[2] = { int(sizeof(fixed)), 0 };
            int scalar = int(sizeof scalar);
            output[0] = sizeof(fixed);
            output[1] = sizeof(scalar);
        }",
        &[8, 4],
    );
    for declaration in [
        "int values[] = { int(sizeof(values)) };",
        "using Incomplete = int[]; Incomplete values = { int(sizeof values) };",
    ] {
        let error = rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_named_objects_uses_adjusted_array_parameter_type() {
    let module = roundtrip(
        "__device__ size_t bytes(int values[3]) { return sizeof(values); }
        __global__ void kernel(unsigned long *output) {
            int array[3];
            output[0] = bytes(array);
        }",
    );
    let function = &module.entry_points[0].function;
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { value, .. } = *statement {
            if let naga::Expression::Literal(naga::Literal::U64(value)) =
                function.expressions[value]
            {
                values.push(value);
            }
        }
        false
    });
    assert_eq!(values, [8]);
}

#[test]
fn cuda_sizeof_members_preserves_nested_fields_arrays_and_source_pointer_types() {
    assert_query_results(
        "struct Inner { float3 vector; int matrix[2][3]; };
        struct Record { Inner nested; long tag; };
        __global__ void kernel(unsigned long *output, const Record *records) {
            Record record;
            Record &reference = record;
            Record *null_record = nullptr;
            Record *uninitialized;
            dim3 dimensions;
            float4 vector;
            output[0] = sizeof(record.nested.vector);
            output[1] = sizeof reference.nested.matrix;
            output[2] = sizeof(records->tag);
            output[3] = sizeof null_record->nested.vector.z;
            output[4] = sizeof(uninitialized->nested.matrix);
            output[5] = sizeof(dimensions.x);
            output[6] = sizeof vector.w;
        }",
        &[12, 24, 8, 4, 24, 4, 4],
    );
}

#[test]
fn cuda_sizeof_members_is_unevaluated_for_volatile_views_and_array_decay() {
    let module = roundtrip(
        "struct Record { float3 vector; int values[3]; };
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            volatile Record &reference = input[0];
            Record records[2];
            output[0] = sizeof(input->vector);
            output[1] = sizeof reference.values;
            output[2] = sizeof(records->values);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
    assert_query_results(
        "struct Record { float3 vector; int values[3]; };
        __global__ void kernel(unsigned long *output) {
            Record records[2];
            output[0] = sizeof(records->vector);
            output[1] = sizeof(records->values);
        }",
        &[12, 12],
    );
}

#[test]
fn cuda_sizeof_members_supports_incomplete_array_arrow_without_launch_storage() {
    for bytes in [0, 16, 128] {
        let (module, _) = validate_with_options_and_capabilities(
            "struct Record { float3 vector; int values[3]; };
            extern __shared__ Record records[];
            __global__ void kernel(unsigned long *output) {
                output[0] = sizeof(records->vector);
                output[1] = sizeof records->values;
            }",
            &Options {
                dynamic_shared_memory_size: bytes,
                ..Options::default()
            },
            Capabilities::SHADER_INT64,
        );
        assert_eq!(module.global_variables.len(), 1);
        let function = &module.entry_points[0].function;
        let mut values = Vec::new();
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Store { value, .. } = *statement {
                values.push(function.expressions[value].clone());
            }
            false
        });
        assert_eq!(
            values,
            [
                naga::Expression::Literal(naga::Literal::U64(12)),
                naga::Expression::Literal(naga::Literal::U64(12))
            ]
        );
    }
    roundtrip(
        "struct Record { int value; };
        __global__ void kernel(unsigned long *output) {
            Record records[] = {{int(sizeof(records->value))}};
            output[0] = sizeof(records);
        }",
    );
}

#[test]
fn cuda_sizeof_members_remains_constant_through_templates_and_constant_memory() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __constant__ Record constant_record;
        constexpr size_t Count = sizeof(constant_record.vector);
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Bytes = sizeof(value.matrix);
            output[0] = sizeof(int[Count]);
            output[1] = sizeof(int[Bytes]);
            output[2] = sizeof(constant_record.matrix);
        }
        template __global__ void kernel<Record>(unsigned long *);",
        &[48, 96, 24],
    );
    roundtrip(
        "struct Record { float3 vector; };
        template<class Value> __device__ size_t bytes(const Value *value) { return sizeof(value->vector); }
        __global__ void kernel(unsigned long *output, const Record *records) {
            output[0] = bytes(records);
        }",
    );
}

#[test]
fn cuda_sizeof_members_rejects_invalid_access_and_unsupported_expressions() {
    for operand in [
        "pointer.vector",
        "record->vector",
        "record.missing",
        "record.vector.w",
        "scalar.x",
        "scalar->x",
        "null_value->vector",
        "records.vector",
        "record.matrix.x",
        "record.matrix->x",
        "record.vector.x.y",
        "record.vector.x++",
        "pointer->vector.x % 1",
        "pointer->vector()",
        "record.missing, scalar",
    ] {
        rejected(&format!(
            "struct Record {{ float3 vector; int matrix[2][3]; }};
            __global__ void kernel(unsigned long *output) {{
                Record record; Record *pointer; Record records[2];
                int scalar; auto null_value = nullptr;
                output[0] = sizeof({operand});
            }}"
        ));
    }
    rejected("struct Record { int value; }; __global__ void kernel() { Record record; alignof(record.value); }");
}

#[test]
fn cuda_sizeof_dereference_preserves_pointee_and_array_layouts() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        using Row = int[3];
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            int *uninitialized;
            float3 *null_pointer = nullptr;
            Row *rows;
            int matrix[2][3];
            output[0] = sizeof *uninitialized;
            output[1] = sizeof(*null_pointer);
            output[2] = sizeof(*rows);
            output[3] = sizeof(*input);
            output[4] = sizeof(*matrix);
            output[5] = sizeof(**matrix);
            output[6] = sizeof(*input->matrix);
        }",
        &[4, 12, 12, 36, 12, 4, 12],
    );
}

#[test]
fn cuda_sizeof_dereference_does_not_read_or_allocate_storage() {
    let module = roundtrip(
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned long *output, volatile int *input) {
            constexpr size_t Bytes = sizeof(*values);
            output[0] = sizeof(int[Bytes]);
            output[1] = sizeof(*input);
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_dereference_rejects_invalid_operands() {
    for operand in [
        "*value",
        "**pointer",
        "*null_value",
        "*pointer++",
        "*pointer + pointer",
        "*value, value",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                int value; int *pointer; auto null_value = nullptr;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_dereference_checks_incomplete_pointees_and_nesting_limit() {
    assert_query_results(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            output[0] = sizeof(**view);
        }",
        &[4],
    );
    assert_query_results(
        "using Grid = int[2][3];
        __global__ void kernel(unsigned long *output, Grid *view) {
            output[0] = sizeof(*view);
            output[1] = sizeof(**view);
            output[2] = sizeof(***view);
        }",
        &[24, 12, 4],
    );
    let error = rejected(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            output[0] = sizeof(*view);
        }",
    );
    assert!(error.message.contains("complete"), "{error}");
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output, int *input) {{
            output[0] = sizeof({}input);
        }}",
        "*".repeat(65)
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}

#[test]
fn cuda_sizeof_grouping_preserves_operand_precedence_and_array_extents() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __global__ void kernel(unsigned long *output) {
            Record record;
            Record *pointer = nullptr;
            int array[2][3];
            output[0] = sizeof((array));
            output[1] = sizeof *(pointer);
            output[2] = sizeof((*pointer).matrix);
            output[3] = sizeof *((*pointer).matrix);
            output[4] = sizeof (record).vector.x;
            output[5] = sizeof (*pointer).matrix;
            output[6] = sizeof (((record).matrix));
            output[7] = sizeof **((record).matrix);
        }",
        &[24, 36, 24, 12, 4, 24, 24, 4],
    );
}

#[test]
fn cuda_sizeof_grouping_keeps_volatile_and_dynamic_shared_operands_unevaluated() {
    let module = roundtrip(
        "struct Record { int matrix[2][3]; };
        extern __shared__ Record values[];
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            output[0] = sizeof(((*input).matrix));
            output[1] = sizeof (*(values)).matrix;
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_grouping_rejects_invalid_syntax_and_bounds_nesting() {
    for operand in [
        "()",
        "(int)",
        "(missing)",
        "(value + pointer)",
        "(value++)",
        "(helper())",
        "(value",
        "((value)",
    ] {
        rejected(&format!(
            "__device__ int helper() {{ return 1; }}
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer;
                output[0] = sizeof({operand});
            }}"
        ));
    }
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{
            int value; output[0] = sizeof({}value{});
        }}",
        "(".repeat(65),
        ")".repeat(65)
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}

#[test]
fn cuda_sizeof_grouping_remains_constant_and_stops_before_binary_operators() {
    assert_query_results(
        "struct Record { int matrix[2][3]; };
        __constant__ Record constant_record;
        constexpr size_t Bytes = sizeof (constant_record).matrix + 1;
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Count = sizeof ((value).matrix) + 1;
            output[0] = sizeof(int[Bytes]);
            output[1] = sizeof(int[Count]);
        }
        template __global__ void kernel<Record>(unsigned long *);",
        &[100, 100],
    );
}

#[test]
fn cuda_sizeof_literals_uses_existing_source_scalar_types() {
    for (literal, size) in [
        ("0", 4),
        ("1u", 4),
        ("2147483648", 8),
        ("0xffffffff", 4),
        ("1L", 8),
        ("1ul", 8),
        ("1LL", 8),
        ("0xffffffffffffffffULL", 8),
        ("1.0f", 4),
        ("0x1.8p+2f", 4),
        ("1'000", 4),
        ("true", 1),
        ("false", 1),
        ("nullptr", 8),
    ] {
        assert_query_results(
            &format!(
                "__global__ void kernel(unsigned long *output) {{
                output[0] = sizeof({literal});
                output[1] = sizeof {literal};
                output[2] = sizeof((({literal})));
            }}"
            ),
            &[size, size, size],
        );
    }
}

#[test]
fn cuda_sizeof_literals_supply_constants_without_evaluating_values() {
    assert_query_results(
        "constexpr size_t Count = sizeof(true) + sizeof(nullptr);
        template<class Value> __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Value[sizeof(1LL)]);
            output[1] = sizeof(int[Count]);
        }
        template __global__ void kernel<short>(unsigned long *);",
        &[16, 36],
    );
}

#[test]
fn cuda_sizeof_literals_rejects_unsupported_literal_forms_and_invalid_uses() {
    for operand in [
        "1.0",
        "1.0L",
        "1e100f",
        "18446744073709551616u",
        "true.x",
        "nullptr->x",
        "*nullptr",
        "*1",
        "1 + nullptr",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{ output[0] = sizeof({operand}); }}"
        ));
    }
}

#[test]
fn cuda_sizeof_unary_uses_builtin_scalar_promotions_and_pointer_decay() {
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            short small; unsigned short narrow; bool flag; float value;
            int *pointer; int matrix[2][3];
            output[0] = sizeof(+small);
            output[1] = sizeof(-narrow);
            output[2] = sizeof(~flag);
            output[3] = sizeof(+true);
            output[4] = sizeof(-false);
            output[5] = sizeof(!small);
            output[6] = sizeof(-value);
            output[7] = sizeof(-1L);
            output[8] = sizeof(~0xffffffffffffffffULL);
            output[9] = sizeof(!nullptr);
            output[10] = sizeof(+pointer);
            output[11] = sizeof(*+pointer);
            output[12] = sizeof(+matrix);
            output[13] = sizeof(*+matrix);
            output[14] = sizeof(**+matrix);
            output[15] = sizeof(!matrix);
            output[16] = sizeof(-2147483648);
        }",
        &[4, 4, 4, 4, 4, 1, 4, 8, 8, 1, 8, 4, 8, 12, 4, 1, 8],
    );
}

#[test]
fn cuda_sizeof_unary_does_not_read_volatile_operands_or_allocate_shared_storage() {
    let module = roundtrip(
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned long *output, volatile short *input) {
            output[0] = sizeof(-*input);
            output[1] = sizeof(+values);
            output[2] = sizeof(*+values);
            output[3] = sizeof(!values);
            output[4] = sizeof(!input);
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_unary_rejects_invalid_builtin_operand_types() {
    for operand in [
        "~1.0f", "+nullptr", "-nullptr", "~nullptr", "-pointer", "~pointer", "-matrix", "~matrix",
        "+record", "-record", "!record", "~record", "+vector", "!vector", "++value", "value++",
    ] {
        rejected(&format!(
            "struct Record {{ int member; }};
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer; int matrix[2][3]; Record record; float3 vector;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_subscripts_preserves_element_layout_and_builtin_precedence() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __global__ void kernel(unsigned long *output) {
            int matrix[2][3]; Record records[2];
            float3 *pointer = nullptr; short *short_pointer; long index;
            output[0] = sizeof(matrix[0]);
            output[1] = sizeof(matrix[0][1]);
            output[2] = sizeof pointer[index];
            output[3] = sizeof records[999].matrix;
            output[4] = sizeof(0[matrix]);
            output[5] = sizeof(1[2[matrix]]);
            output[6] = sizeof records[index].vector.z;
            output[7] = sizeof matrix[true];
            output[8] = sizeof matrix[0xffffffffffffffffULL];
            output[9] = sizeof -1[short_pointer];
            output[10] = sizeof (-1)[short_pointer];
            output[11] = sizeof matrix[-1];
            output[12] = sizeof(*(matrix[0]));
            output[13] = sizeof +matrix[0];
            output[14] = sizeof *+matrix[0];
        }",
        &[12, 4, 12, 24, 12, 4, 4, 12, 12, 4, 2, 12, 4, 8, 4],
    );
}

#[test]
fn cuda_sizeof_subscripts_does_not_read_indices_or_allocate_dynamic_shared_storage() {
    let module = roundtrip(
        "struct Record { float3 vector; int matrix[2][3]; };
        extern __shared__ Record values[];
        __global__ void kernel(unsigned long *output, volatile int *input) {
            volatile int &index = input[0];
            output[0] = sizeof input[index];
            output[1] = sizeof values[index].matrix;
            output[2] = sizeof index[values].vector;
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_subscripts_requires_complete_element_types_before_pointer_arithmetic() {
    assert_query_results(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            int inferred[] = {int(sizeof(inferred[0]))};
            output[0] = sizeof((*view)[0]);
            output[1] = sizeof(0[*view]);
            output[2] = sizeof(inferred);
        }",
        &[4, 4, 4],
    );
    for operand in ["view[0]", "view[0][0]", "0[view][0]"] {
        let error = rejected(&format!(
            "using Values = int[];
            __global__ void kernel(unsigned long *output, Values *view) {{
                output[0] = sizeof({operand});
            }}"
        ));
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_subscripts_rejects_invalid_types_and_unsupported_index_expressions() {
    for operand in [
        "pointer[1.0f]",
        "pointer[nullptr]",
        "pointer[pointer]",
        "index[index]",
        "pointer[record]",
        "record[index]",
        "vector[index]",
        "pointer[missing]",
        "pointer[index++]",
        "pointer[index + 1.0f]",
        "pointer[helper()]",
        "pointer[]",
    ] {
        rejected(&format!(
            "struct Record {{ int member; }};
            __device__ int helper() {{ return 0; }}
            __global__ void kernel(unsigned long *output) {{
                int *pointer; int index; Record record; float3 vector;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_subscripts_bounds_nested_index_expressions() {
    let operand = format!("{}array{}", "0[".repeat(65), "]".repeat(65));
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ int array[2]; output[0] = sizeof({operand}); }}"
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscripts_preserve_unevaluated_shapes() {
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        struct Record { int matrix[2][3]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            extern __shared__ Record scratch[];
            int grid[2][3];
            int index = -1;
            volatile int &watched = input[0];
            Record *records;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(grid[0])]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(grid[true])]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof(grid[0xffffffffffffffffULL])]);
            output[3] = __builtin_offsetof(Offsets, bytes[sizeof(grid[(index)])]);
            output[4] = __builtin_offsetof(Offsets, bytes[sizeof(grid[((watched))])]);
            output[5] = __builtin_offsetof(Offsets, bytes[sizeof(grid[index][watched])]);
            output[6] = __builtin_offsetof(Offsets, bytes[sizeof(records[index].matrix)]);
            output[7] = __builtin_offsetof(Offsets, bytes[sizeof(records[watched].matrix[index])]);
            output[8] = __builtin_offsetof(Offsets, bytes[sizeof scratch[index].matrix]);
        }",
        &[48, 48, 48, 48, 48, 16, 96, 48, 96],
    );
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            int grid[2][3];
            volatile int &index = input[0];
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(grid[index])]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscripts_allow_unevaluated_default_parameters() {
    roundtrip(
        "struct Offsets { int bytes[64]; };
        __device__ unsigned selected(int *parameter, int index,
            unsigned bytes = unsigned(__builtin_offsetof(Offsets, bytes[sizeof(parameter[index + index * 2])]))) {
            return bytes;
        }
        __global__ void kernel(unsigned *output, int *input) {
            output[0] = selected(input, -1);
        }",
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscripts_reject_invalid_or_broader_index_syntax() {
    for operand in [
        "grid[1.0f]",
        "grid[nullptr]",
        "grid[pointer]",
        "grid[record]",
        "grid[vector]",
        "grid[missing]",
        "grid[Integer]",
        "grid[index++]",
        "grid[helper()]",
        "grid[(index, 0)]",
        "grid[]",
        "index[grid]",
        "incomplete[0]",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[64]; }};
            struct Record {{ int value; }};
            __device__ int helper() {{ return 0; }}
            using Unknown = int[];
            __global__ void kernel(unsigned long *output) {{
                int grid[2][3]; int index; int *pointer; Unknown *incomplete;
                Record record; float2 vector; using Integer = int;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        ));
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscript_integral_expressions_never_evaluate_values() {
    for index in [
        "+index",
        "-index",
        "~index",
        "!index",
        "index + watched * 2",
        "1 / 0",
        "1 % 0",
        "2147483647 + 1",
        "-(-2147483647 - 1)",
        "1 << 999",
        "1 >> -1",
        "index & 3 | watched ^ 1",
        "index < watched",
        "index == watched",
        "index && watched",
        "index || watched",
        "index ? watched : 1 / 0",
        "false ? 1 / 0 : index",
        "static_cast<unsigned>(watched)",
        "int(index)",
        "unsigned()",
        "(short)watched",
        "sizeof(int) + alignof(int)",
        "sizeof(int[2])",
        "sizeof(index)",
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
                __global__ void kernel(unsigned long *output, volatile int *input) {{
                    int grid[2][3]; int index = -1;
                    volatile int &watched = input[0];
                    output[0] = __builtin_offsetof(Offsets, bytes[sizeof(grid[{index}])]);
                }}"
            ),
            &[48],
        );
    }
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            int grid[2][3]; volatile int &index = input[0];
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(grid[index + index * 2])]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscript_checks_skipped_operand_types() {
    for index in [
        "false && pointer",
        "true || record",
        "true ? 0 : pointer",
        "false ? vector : 1",
        "index + 1.0f",
        "static_cast<int>(pointer)",
        "false && helper()",
        "true ? 0 : index++",
        "index, 0",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[64]; }};
            struct Record {{ int value; }};
            __device__ int helper() {{ return 0; }}
            __global__ void kernel(unsigned long *output) {{
                int grid[2][3]; int index; int *pointer; Record record; float2 vector;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof(grid[{index}])]);
            }}"
        ));
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_subscript_type_bounds_keep_default_and_noexcept_guards() {
    let error = rejected(
        "struct Offsets { int bytes[64]; };
        __device__ unsigned selected(int *grid, int parameter,
            unsigned bytes = unsigned(__builtin_offsetof(Offsets, bytes[sizeof(grid[sizeof(int[true || parameter])])]))) {
            return bytes;
        }
        __global__ void kernel() {}",
    );
    assert!(error.message.contains("integral constant"), "{error}");
    let error = rejected(
        "struct Offsets { int bytes[64]; };
        __device__ unsigned selected(int *grid, int parameter)
            noexcept(__builtin_offsetof(Offsets, bytes[sizeof(grid[sizeof(int[true || parameter])])]) != 0) {
            return 0u;
        }
        __global__ void kernel() {}",
    );
    assert!(error.message.contains("integral constant"), "{error}");
}

#[test]
fn cuda_record_offsetof_nested_sizeof_groups_and_dereferences_preserve_postfix_types() {
    assert_query_results(
        "struct Offsets { int bytes[128]; };
        struct Record { int field; int matrix[2][3]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            using Row = int[3];
            Row *rows = nullptr;
            Record *pointer = nullptr;
            int array[2][3];
            volatile int &index = input[0];
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(*input)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof((*pointer).field)]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof *array]);
            output[3] = __builtin_offsetof(Offsets, bytes[sizeof(((*rows)))]);
            output[4] = __builtin_offsetof(Offsets, bytes[sizeof((array)[index])]);
            output[5] = __builtin_offsetof(Offsets, bytes[sizeof((pointer[index]).matrix)]);
            output[6] = __builtin_offsetof(Offsets, bytes[sizeof(*rows[index])]);
            output[7] = __builtin_offsetof(Offsets, bytes[sizeof(*(rows[index]))]);
            output[8] = __builtin_offsetof(Offsets, bytes[sizeof((*pointer).matrix[index])]);
            output[9] = __builtin_offsetof(Offsets, bytes[sizeof *array + 1]);
            output[10] = __builtin_offsetof(Offsets, bytes[sizeof (*pointer).matrix]);
            output[11] = __builtin_offsetof(Offsets, bytes[sizeof *pointer->matrix]);
        }",
        &[16, 16, 48, 48, 48, 96, 16, 16, 48, 52, 96, 48],
    );
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof((*(input)))]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_dereferences_allow_default_parameter_types() {
    roundtrip(
        "struct Offsets { int bytes[64]; };
        __device__ unsigned selected(int *parameter,
            unsigned bytes = unsigned(__builtin_offsetof(Offsets, bytes[sizeof *parameter]))) {
            return bytes;
        }
        __global__ void kernel(unsigned *output, int *input) { output[0] = selected(input); }",
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_groups_and_dereferences_reject_invalid_operands() {
    for operand in [
        "*nullptr",
        "*none",
        "*value",
        "*incomplete",
        "(*pointer).missing",
        "(pointer).field",
        "*",
        "((pointer)",
        "(*pointer).",
        "&value",
        "helper()",
        "(*pointer).field++",
        "*(pointer + 1)",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[128]; }};
            struct Record {{ int field; }};
            using Unknown = int[];
            __device__ int helper() {{ return 0; }}
            __global__ void kernel(unsigned long *output) {{
                Record *pointer = nullptr; Unknown *incomplete = nullptr;
                int value; auto none = nullptr;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        ));
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_literals_preserve_source_sizes_and_unary_binding() {
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(1)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof 1u]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof((0L))]);
            output[3] = __builtin_offsetof(Offsets, bytes[sizeof 18446744073709551615ULL]);
            output[4] = __builtin_offsetof(Offsets, bytes[sizeof(1.0f)]);
            output[5] = __builtin_offsetof(Offsets, bytes[sizeof true]);
            output[6] = __builtin_offsetof(Offsets, bytes[sizeof((false))]);
            output[7] = __builtin_offsetof(Offsets, bytes[sizeof(nullptr)]);
            output[8] = __builtin_offsetof(Offsets, bytes[sizeof nullptr]);
            output[9] = __builtin_offsetof(Offsets, bytes[sizeof 1 + 1]);
            output[10] = __builtin_offsetof(Offsets, bytes[sizeof true ? 7 : 9]);
            output[11] = __builtin_offsetof(Offsets, bytes[sizeof(0x10u)]);
            output[12] = __builtin_offsetof(Offsets, bytes[sizeof(1'000)]);
            output[13] = __builtin_offsetof(Offsets, bytes[sizeof(1'000.0f)]);
            output[14] = __builtin_offsetof(Offsets, bytes[sizeof(0x1.8p+2f)]);
        }",
        &[16, 16, 32, 32, 16, 4, 4, 32, 32, 20, 28, 16, 16, 16, 16],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_literals_emit_only_final_offsets() {
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(18446744073709551615ULL)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(1.5f)]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof(nullptr)]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| {
            !matches!(
                expression,
                naga::Expression::Literal(naga::Literal::U64(u64::MAX) | naga::Literal::F32(_))
                    | naga::Expression::Load { .. }
            )
        }));
    assert!(module.types.iter().all(|(_, ty)| ty
        .inner
        .scalar()
        .is_none_or(|scalar| scalar.kind != naga::ScalarKind::Float)));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_literals_reject_bad_literals_and_null_dereferences() {
    for operand in [
        "18446744073709551616ULL",
        "1.0",
        "1e100f",
        "0x",
        "1uuu",
        "*nullptr",
        "*(nullptr)",
        "nullptr[0]",
        "true[0]",
        "1[0]",
        "()",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output) {{
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        ));
    }
    rejected(
        "struct Offsets { int bytes[2]; }; __global__ void kernel(unsigned long *output) {
        output[0] = __builtin_offsetof(Offsets, bytes[sizeof(1)]);
    }",
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_unary_types_and_array_decay_preserve_precedence() {
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            short small; bool flag; int grid[2][3]; int *pointer = nullptr;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(+small)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(-small)]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof(~flag)]);
            output[3] = __builtin_offsetof(Offsets, bytes[sizeof(!small)]);
            output[4] = __builtin_offsetof(Offsets, bytes[sizeof(-*input)]);
            output[5] = __builtin_offsetof(Offsets, bytes[sizeof(+pointer)]);
            output[6] = __builtin_offsetof(Offsets, bytes[sizeof(!pointer)]);
            output[7] = __builtin_offsetof(Offsets, bytes[sizeof(!nullptr)]);
            output[8] = __builtin_offsetof(Offsets, bytes[sizeof(+grid)]);
            output[9] = __builtin_offsetof(Offsets, bytes[sizeof(*+grid)]);
            output[10] = __builtin_offsetof(Offsets, bytes[sizeof(+*grid)]);
            output[11] = __builtin_offsetof(Offsets, bytes[sizeof(*+grid[0])]);
            output[12] = __builtin_offsetof(Offsets, bytes[sizeof -1]);
            output[13] = __builtin_offsetof(Offsets, bytes[sizeof(~0xffffffffffffffffULL)]);
        }",
        &[16, 16, 16, 4, 16, 32, 4, 4, 32, 48, 32, 16, 16, 32],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_unary_never_reads_volatile_or_materializes_null() {
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            extern __shared__ int rows[][3];
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(~*input)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(!nullptr)]);
            output[2] = __builtin_offsetof(Offsets, bytes[sizeof(*+rows)]);
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Load { .. } | naga::Expression::Unary { .. }
        )));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_unary_rejects_invalid_types_even_when_skipped() {
    for operand in [
        "+record",
        "-record",
        "~record",
        "!record",
        "+vector",
        "!vector",
        "-pointer",
        "~pointer",
        "+nullptr",
        "-nullptr",
        "~nullptr",
        "~1.0f",
        "++value",
        "value++",
        "*+nullptr",
    ] {
        for prefix in ["", "true || "] {
            rejected(&format!(
                "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
                __global__ void kernel(unsigned long *output) {{
                    int value; int *pointer; Record record; float2 vector;
                    output[0] = __builtin_offsetof(Offsets, bytes[{prefix}sizeof({operand})]);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_scalar_binary_types_match_standalone_promotions() {
    for (operand, size) in [
        ("small + small", 4),
        ("flag + flag", 4),
        ("small - value", 4),
        ("value * real", 4),
        ("1 / 0", 4),
        ("1 % 0", 4),
        ("2147483647 + 1", 4),
        ("1 << 999", 4),
        ("1 >> -1", 4),
        ("small & value", 4),
        ("value ^ bits | 1u", 4),
        ("value < bits", 1),
        ("value <= bits", 1),
        ("value > bits", 1),
        ("value >= bits", 1),
        ("value == bits", 1),
        ("value != bits", 1),
        ("value && bits", 1),
        ("value || bits", 1),
        ("value + bits * 2 == 7", 1),
        ("1L + bits", 8),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
                __global__ void kernel(unsigned long *output) {{
                    short small; bool flag; int value; unsigned bits; float real;
                    output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
                }}"
            ),
            &[size * 4],
        );
    }
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            short small;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof small + 1]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(small + 1)]);
            output[2] = __builtin_offsetof(Offsets, bytes[true || sizeof(1 / 0)]);
        }",
        &[12, 16, 4],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_scalar_binary_never_emits_volatile_reads_or_operations() {
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(*input + *input * 2)]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Load { .. } | naga::Expression::Binary { .. }
        )));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_scalar_binary_rejects_invalid_types_and_broader_operators() {
    for operand in [
        "pointer + 1",
        "pointer - pointer",
        "pointer == pointer",
        "pointer && value",
        "record + value",
        "vector + vector",
        "real % value",
        "real & value",
        "value << real",
        "value = 1",
        "value += 1",
        "value++ + 1",
        "value + helper()",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
            __device__ int helper() {{ return 0; }}
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer; float real; Record record; float2 vector;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        ));
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_conditionals_preserve_scalar_and_pointer_arm_types() {
    for (operand, size) in [
        ("flag ? small : other", 2),
        ("flag ? true : false", 1),
        ("flag ? small : value", 4),
        ("flag ? flag : small", 4),
        ("flag ? value : 1.0f", 4),
        ("flag ? small : flag ? other : small", 2),
        ("flag ? flag ? small : other : small", 2),
        ("flag ? pointer : nullptr", 8),
        ("flag ? nullptr : pointer", 8),
        ("flag ? pointer : 0u", 8),
        ("flag ? 0 : pointer", 8),
        ("flag ? pointer : another", 8),
        ("flag ? nullptr : nullptr", 8),
        ("*(flag ? pointer : nullptr)", 4),
        ("(flag ? record : nullptr)->field", 4),
        ("*(flag ? row : nullptr)", 12),
        ("pointer ? small : other", 2),
        ("nullptr ? true : false", 1),
        ("grid ? small : other", 2),
        ("flag ? 1 / 0 : value", 4),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
            __global__ void kernel(unsigned long *output) {{
                short small; short other; bool flag; int value; int grid[2][3];
                int *pointer = nullptr; const int *another = nullptr;
                Record *record = nullptr; using Row = int[3]; Row *row = nullptr;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[size * 4],
        );
    }
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            bool flag;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof flag ? 7 : 9]);
        }",
        &[28],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_conditionals_never_lower_volatile_operands() {
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(*input ? *input : *input)]);
        }",
    );
    let function = &module.entry_points[0].function;
    assert!(function.expressions.iter().all(|(_, expression)| !matches!(
        expression,
        naga::Expression::Load { .. } | naga::Expression::Select { .. }
    )));
    assert!(!naga::proc::any_statement(
        &function.body,
        &mut |statement| matches!(statement, naga::Statement::If { .. })
    ));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_conditionals_reject_invalid_types_even_when_unselected() {
    for operand in [
        "record ? 1 : 2",
        "vector ? 1 : 2",
        "true ? 1 : record",
        "false ? vector : 1",
        "flag ? pointer : 1",
        "flag ? pointer : false",
        "flag ? pointer : real_pointer",
        "flag ? pointer : (1 - 1)",
        "flag ? nullptr : 0",
        "flag ? grid : grid",
        "flag ? value :",
        "flag ? : value",
        "flag ? value",
    ] {
        rejected(&format!(
            "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
            __global__ void kernel(unsigned long *output) {{
                bool flag; int value; Record record; float2 vector; int grid[2][3];
                int *pointer; float *real_pointer;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        ));
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_comma_preserves_final_types_and_conditional_precedence() {
    for (operand, size) in [
        ("value, flag", 1),
        ("flag, small", 2),
        ("value, grid", 24),
        ("(value, grid)[0]", 12),
        ("value, record", 28),
        ("(value, record).matrix", 24),
        ("value, pointer", 8),
        ("value, nullptr", 8),
        ("value, 0", 4),
        ("flag ? value, small : other", 2),
        ("flag ? small : other, flag", 1),
        ("flag ? (value, small) : (value, other)", 2),
        ("flag ? flag ? value, small : other : small", 2),
        ("flag ? pointer : (value, nullptr)", 8),
        ("1 / 0, value, flag", 1),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
            struct Record {{ int first; int matrix[2][3]; }};
            __global__ void kernel(unsigned long *output) {{
                int value; bool flag; short small; short other; int grid[2][3];
                Record record; int *pointer = nullptr;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[size * 4],
        );
    }
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            short small; bool flag;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof small + 1]);
        }",
        &[12],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_comma_never_reads_discarded_or_final_volatile_operands() {
    let module = roundtrip(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output, volatile int *input) {
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(*input, *input)]);
        }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_comma_rejects_early_errors_and_nonliteral_zero() {
    for operand in [
        "missing, value",
        "Integer, value",
        "helper(), value",
        "value++, value",
        "value = 1, value",
        "pointer + 1, value",
        "value,, flag",
        "value,",
        ",value",
        "flag ? pointer : (1, 0)",
        "flag ? (0, 0) : pointer",
        "flag ? pointer : ((nullptr, 0))",
    ] {
        for prefix in ["", "true || "] {
            rejected(&format!(
                "struct Offsets {{ int bytes[64]; }};
                __device__ int helper() {{ return 0; }}
                __global__ void kernel(unsigned long *output) {{
                    int value; bool flag; int *pointer; using Integer = int;
                    output[0] = __builtin_offsetof(Offsets, bytes[{prefix}sizeof({operand})]);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_static_casts_match_scalar_conversion_types() {
    for (operand, size) in [
        ("static_cast<short>(value)", 2),
        ("static_cast<unsigned short>(value)", 2),
        ("static_cast<long long>(value)", 8),
        ("static_cast<unsigned long>(value)", 8),
        ("static_cast<float>(value)", 4),
        ("static_cast<const volatile Number>(value)", 4),
        ("static_cast<bool>(pointer)", 1),
        ("static_cast<Truth>(grid)", 1),
        ("static_cast<bool>(nullptr)", 1),
        ("static_cast<bool>(value, pointer)", 1),
        ("static_cast<short>(flag ? value : 1 / 0)", 2),
        ("static_cast<short>(value) + small", 4),
        ("flag ? static_cast<short>(value) : small", 2),
        ("static_cast<unsigned>(-1.0f)", 4),
        ("static_cast<int>(static_cast<float>(value))", 4),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output) {{
                int value; short small; bool flag; int grid[2][3]; int *pointer = nullptr;
                using Number = unsigned; using Truth = bool;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[size * 4],
        );
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_static_casts_never_emit_conversions_or_reads() {
    let source = |operand| {
        format!(
            "struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output, volatile int *input) {{
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
        )
    };
    let baseline = roundtrip(&source("short"));
    let module = roundtrip(&source("static_cast<short>(*input)"));
    let expressions = &module.entry_points[0].function.expressions;
    assert!(expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert_eq!(
        expressions.iter().collect::<Vec<_>>(),
        baseline.entry_points[0]
            .function
            .expressions
            .iter()
            .collect::<Vec<_>>(),
    );
    assert!(module.types.iter().all(|(_, ty)| !matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 2, .. })
    )));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_static_casts_reject_invalid_targets_sources_and_syntax() {
    for operand in [
        "static_cast<void>(value)",
        "static_cast<int*>(pointer)",
        "static_cast<int&>(value)",
        "static_cast<Record>(value)",
        "static_cast<float2>(value)",
        "static_cast<int>(pointer)",
        "static_cast<unsigned>(nullptr)",
        "static_cast<bool>(record)",
        "static_cast<bool>(vector)",
        "static_cast<int>()",
        "static_cast<int>(value,)",
        "static_cast<int(value)",
        "static_cast<int>value",
        "static_cast<int>(helper())",
        "flag ? pointer : static_cast<int>(0)",
    ] {
        for prefix in ["", "true || "] {
            rejected(&format!(
                "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
                __device__ int helper() {{ return 0; }}
                __global__ void kernel(unsigned long *output) {{
                    int value; bool flag; int *pointer; Record record; float2 vector;
                    output[0] = __builtin_offsetof(Offsets, bytes[{prefix}sizeof({operand})]);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_cstyle_casts_preserve_unary_binding_and_alias_lookup() {
    for (operand, size) in [
        ("(short)value", 2),
        ("(unsigned long long)value", 8),
        ("(const volatile Number)value", 4),
        ("(short)-value", 2),
        ("(short)(value + 1)", 2),
        ("(short)value + 1", 4),
        ("(short)(value, value)", 2),
        ("(bool)pointer", 1),
        ("(bool)grid", 1),
        ("(Truth)nullptr", 1),
        ("(short)(unsigned)value", 2),
        ("(short)static_cast<unsigned>(value)", 2),
        ("static_cast<short>((unsigned)value)", 2),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer; int grid[2][3];
                using Number = unsigned; using Truth = bool;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[size * 4],
        );
    }
    assert_query_results(
        "struct Offsets { int bytes[64]; }; using Alias = short;
        __global__ void kernel(unsigned long *output) {
            int Alias; int value;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof((Alias) + value)]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(short) + 1]);
        }",
        &[16, 12],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_cstyle_casts_have_identical_ir_to_explicit_type_queries() {
    let source = |query: &str| {
        format!(
            "struct Offsets {{ int bytes[64]; }};
        __global__ void kernel(unsigned long *output, volatile int *input) {{
            output[0] = __builtin_offsetof(Offsets, bytes[{query}]);
        }}"
        )
    };
    let cast = roundtrip(&source("sizeof((short)*input)"));
    let control = roundtrip(&source("sizeof(short)"));
    let expressions = &cast.entry_points[0].function.expressions;
    assert_eq!(
        expressions.iter().collect::<Vec<_>>(),
        control.entry_points[0]
            .function
            .expressions
            .iter()
            .collect::<Vec<_>>(),
    );
    assert!(expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(cast.types.iter().all(|(_, ty)| !matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 2, .. })
    )));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_cstyle_casts_reject_invalid_forms() {
    for query in [
        "sizeof((void)value)",
        "sizeof((int*)pointer)",
        "sizeof((int&)value)",
        "sizeof((Record)value)",
        "sizeof((float2)value)",
        "sizeof((int)pointer)",
        "sizeof((bool)record)",
        "sizeof((bool)vector)",
        "sizeof((int))",
        "sizeof((int)helper())",
        "sizeof (short)value",
        "sizeof(flag ? pointer : (int)0)",
    ] {
        for prefix in ["", "true || "] {
            rejected(&format!(
                "struct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
                __device__ int helper() {{ return 0; }}
                __global__ void kernel(unsigned long *output) {{
                    int value; bool flag; int *pointer; Record record; float2 vector;
                    output[0] = __builtin_offsetof(Offsets, bytes[{prefix}{query}]);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_record_offsetof_nested_sizeof_functional_casts_match_single_argument_type_rules() {
    for (operand, size) in [
        ("short(value)", 2),
        ("unsigned(value)", 4),
        ("long(value)", 8),
        ("Wide(value)", 8),
        ("float(value)", 4),
        ("Number(value)", 4),
        ("bool(pointer)", 1),
        ("Truth(grid)", 1),
        ("bool(nullptr)", 1),
        ("short(value ? value : 1 / 0)", 2),
        ("short((value, value))", 2),
        ("short(unsigned(value))", 2),
        ("short(value) + 1", 4),
        ("value ? short(value) : short(1)", 2),
    ] {
        assert_query_results(
            &format!(
                "struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer; int grid[2][3];
                using Wide = unsigned long long; using Number = const unsigned; using Truth = bool;
                output[0] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[size * 4],
        );
    }
    assert_query_results(
        "struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            int value;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof short(value) + 1]);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof(short(value) + 1)]);
        }",
        &[12, 16],
    );
}

#[test]
fn cuda_record_offsetof_nested_sizeof_functional_casts_do_not_emit_narrow_values_or_reads() {
    let source = |query: &str| {
        format!(
            "struct Offsets {{ int bytes[64]; }};
        __global__ void kernel(unsigned long *output, volatile int *input) {{
            output[0] = __builtin_offsetof(Offsets, bytes[{query}]);
        }}"
        )
    };
    let cast = roundtrip(&source("sizeof(short(*input))"));
    let control = roundtrip(&source("sizeof(short)"));
    let expressions = &cast.entry_points[0].function.expressions;
    assert_eq!(
        expressions.iter().collect::<Vec<_>>(),
        control.entry_points[0]
            .function
            .expressions
            .iter()
            .collect::<Vec<_>>(),
    );
    assert!(expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(cast.types.iter().all(|(_, ty)| !matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 2, .. })
    )));
}

#[test]
fn cuda_record_offsetof_nested_sizeof_functional_casts_reject_broader_syntax_and_shadowed_types() {
    for operand in [
        "int()",
        "(int())",
        "int(value, value)",
        "int(value,)",
        "int{value}",
        "unsigned int(value)",
        "const int(value)",
        "long long(value)",
        "decltype(value)(value)",
        "Record(value)",
        "float2(value)",
        "int(pointer)",
        "bool(record)",
        "bool(vector)",
        "int(helper())",
        "flag ? pointer : int(0)",
    ] {
        for prefix in ["", "true || "] {
            rejected(&format!(
                "#include <cstddef>\nstruct Offsets {{ int bytes[64]; }}; struct Record {{ int field; }};
                __device__ int helper() {{ return 0; }}
                __global__ void kernel(unsigned long *output) {{
                    int value; bool flag; int *pointer; Record record; float2 vector;
                    output[0] = __builtin_offsetof(Offsets, bytes[{prefix}sizeof({operand})]);
                }}"));
        }
    }
    rejected(
        "struct Offsets { int bytes[64]; }; using Alias = unsigned;
        __global__ void kernel(unsigned long *output) {
            int Alias; int value;
            output[0] = __builtin_offsetof(Offsets, bytes[sizeof(Alias(value))]);
        }",
    );
}

#[test]
fn cuda_sizeof_qualified_functional_casts_share_standalone_and_nested_syntax() {
    for operand in [
        "std::size_t(value)",
        "::size_t(value)",
        "Std::size_t(value ? 1 : 2)",
    ] {
        assert_query_results(
            &format!(
                "#include <cstddef>\nnamespace Std = std;
            struct Offsets {{ int bytes[64]; }};
            __global__ void kernel(unsigned long *output) {{
                int value;
                output[0] = sizeof({operand});
                output[1] = __builtin_offsetof(Offsets, bytes[sizeof({operand})]);
            }}"
            ),
            &[8, 32],
        );
    }
    assert_query_results(
        "#include <cstddef>\nusing Index = unsigned; struct Offsets { int bytes[64]; };
        __global__ void kernel(unsigned long *output) {
            int Index; int value; int *pointer;
            output[0] = sizeof ::Index(value);
            output[1] = __builtin_offsetof(Offsets, bytes[sizeof ::Index(value)]);
            output[2] = sizeof(std::size_t);
            output[3] = __builtin_offsetof(Offsets, bytes[sizeof(std::size_t)]);
            output[4] = sizeof(std::size_t(0)[pointer]);
        }",
        &[4, 16, 8, 32, 4],
    );
}

#[test]
fn cuda_sizeof_qualified_functional_casts_do_not_read_volatile_operands() {
    for nested in [false, true] {
        let source = |operand: &str| {
            let query = if nested {
                format!("__builtin_offsetof(Offsets, bytes[sizeof({operand})])")
            } else {
                format!("sizeof({operand})")
            };
            format!("#include <cstddef>\nstruct Offsets {{ int bytes[64]; }};
                __global__ void kernel(unsigned long *output, volatile int *input) {{ output[0] = {query}; }}")
        };
        let cast = roundtrip(&source("std::size_t(*input)"));
        let control = roundtrip(&source("std::size_t"));
        assert_eq!(
            cast.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>(),
            control.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>()
        );
        assert!(cast.entry_points[0]
            .function
            .expressions
            .iter()
            .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    }
}

#[test]
fn cuda_sizeof_qualified_functional_casts_reject_empty_multiarg_and_invalid_names() {
    for operand in [
        "std::size_t()",
        "std::size_t(value, value)",
        "std::size_t(value,)",
        "missing::size_t(value)",
        "std::missing(value)",
        "std::nullptr_t(value)",
        "::Record(value)",
        "::Constant(value)",
    ] {
        for nested in [false, true] {
            let query = if nested {
                format!("__builtin_offsetof(Offsets, bytes[sizeof({operand})])")
            } else {
                format!("sizeof({operand})")
            };
            rejected(&format!("#include <cstddef>\nstruct Offsets {{ int bytes[64]; }};
                struct Record {{ int field; }}; constexpr int Constant = 1;
                __global__ void kernel(unsigned long *output) {{ int value; output[0] = {query}; }}"));
        }
    }
}
