use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/pointer-updates.cu");

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() || range.start == source.len(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    assert!(!error.message.is_empty(), "{source}");
    error
}

#[test]
fn cuda_pointer_updates_validate_runtime_state_fixture() {
    validate(FIXTURE);
}

#[test]
fn cuda_pointer_updates_validate_nested_conditional_object_updates() {
    validate(
        r#"__device__ int probe(int *pointer, int count) {
    int *saved = pointer;
    int sum = 0;
    for (int iteration = 0; iteration < count; ++iteration) {
        sum += *pointer;
        ++pointer;
    }
    *pointer += 1;
    return sum + 10 * saved[0] + 100 * pointer[0];
}
__device__ int fixed(int *const pointer) {
    *pointer += 3;
    return *pointer;
}
__device__ int forwarded(int *pointer) {
    ++pointer;
    int result = probe(pointer, 1);
    return result + *pointer * 1000;
}
__global__ void kernel(int *out, const int *input) {
    int values[8]{2, 3, 5, 7, 11, 13, 17, 19};
    int *pointer = values;
    out[0] = probe(pointer, 2);
    out[1] = *pointer;
    int total = 0;
    for (int iteration = 0; iteration < 2; ++iteration) {
        total += probe(pointer + iteration, 1);
    }
    out[2] = total;
    out[3] = values[1];
    out[4] = values[2];
    const int *kernel_copy = input;
    out[5] = *input++;
    out[6] = *input;
    out[7] = *kernel_copy;
    input += 2;
    out[8] = *input;
    --input;
    out[9] = *input;
    input -= 1;
    out[10] = *input;
    out[11] = fixed(values + 3);
    int *original = out;
    out += 12;
    *out = 61;
    ++out;
    *out = 67;
    out -= 1;
    *out += 2;
    original[14] = *out++;
    original[15] = *out;
    original[16] = forwarded(pointer);
    original[17] = *pointer;
    original[18] = values[2];
    int first_values[3]{101, 103, 107};
    int second_values[3]{109, 113, 127};
    int third_values[3]{131, 137, 139};
    int *first = first_values, *second = second_values, *third = third_values;
    int selections = 0;
    for (int route = 0; route < 4; ++route) {
        bool outer = route < 2;
        bool inner = route % 2 == 0;
        (outer ? (inner ? (++selections, first) : (++selections, second)) : (++selections, third))++;
    }
    original[19] = *first;
    original[20] = *second;
    original[21] = *third;
    original[22] = selections;
}
"#,
    );
}

#[test]
fn cuda_pointer_updates_accept_supported_pointees_and_integral_offsets() {
    for source in [
        r#"__global__ void kernel() { bool values[3]{false, true, false}; const bool *view=values; ++view; view += true; view -= 1u; --view; bool *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__global__ void kernel() { int values[3]{2, 3, 5}; const int *view=values; ++view; view += true; view -= 1u; --view; int *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__global__ void kernel() { unsigned values[3]{2u, 3u, 5u}; const unsigned *view=values; ++view; view += true; view -= 1u; --view; unsigned *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__global__ void kernel() { float values[3]{2.0f, 3.0f, 5.0f}; const float *view=values; ++view; view += true; view -= 1u; --view; float *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__global__ void kernel() { int2 values[3]{{2,3}, {5,7}, {11,13}}; const int2 *view=values; ++view; view += true; view -= 1u; --view; int2 *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__global__ void kernel() { float3 values[3]{{2,3,5}, {7,11,13}, {17,19,23}}; const float3 *view=values; ++view; view += true; view -= 1u; --view; float3 *pointer=values; (pointer += 1) -= 1; }"#,
        r#"__device__ int read(int *const); __device__ int read(int *pointer) { ++pointer; return *pointer; } __global__ void kernel(int *out) { int values[2]{2,3}; out[0]=read(values); }"#,
        r#"__device__ int read(int *); __device__ int read(int *const pointer) { *pointer += 1; return *pointer; } __global__ void kernel(int *out) { int values[2]{2,3}; out[0]=read(values); }"#,
        r#"__device__ void advance(int *pointer) { ++pointer; --pointer; pointer += true; pointer -= 1u; } __global__ void kernel() {}"#,
    ] {
        validate(source);
    }
}

#[test]
fn cuda_pointer_updates_reject_const_pointer_objects() {
    for source in [
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; ++pointer; }"#,
        r#"__device__ void change(int *const pointer) { ++pointer; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { ++pointer; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; pointer++; }"#,
        r#"__device__ void change(int *const pointer) { pointer++; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { pointer++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; --pointer; }"#,
        r#"__device__ void change(int *const pointer) { --pointer; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { --pointer; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; pointer--; }"#,
        r#"__device__ void change(int *const pointer) { pointer--; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { pointer--; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; pointer += 1; }"#,
        r#"__device__ void change(int *const pointer) { pointer += 1; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { pointer += 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values + 1; pointer -= 1; }"#,
        r#"__device__ void change(int *const pointer) { pointer -= 1; } __global__ void kernel() {}"#,
        r#"__global__ void kernel(int *const pointer) { pointer -= 1; }"#,
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_pointer_updates_require_modifiable_pointer_lvalues() {
    for source in [
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (++values); }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; values++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (++(pointer + 1)); }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (pointer + 1)++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (+pointer)++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (pointer++)++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; ++(pointer++); }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (true ? pointer : pointer + 0)++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; (pointer + 0) += 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; const int *other = values; (true ? pointer : other)++; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; int *const other = values; (true ? pointer : other)++; }"#,
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_pointer_updates_reject_nonintegral_offsets_and_other_compounds() {
    for source in [
        r#"__device__ void nothing() {} __global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer += 1.5f; }"#,
        r#"__device__ void nothing() {} __global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer += int2{1, 2}; }"#,
        r#"__device__ void nothing() {} __global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer += pointer; }"#,
        r#"__device__ void nothing() {} __global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer += nothing(); }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer *= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer /= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer %= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer &= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer |= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer ^= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer <<= 1; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; pointer >>= 1; }"#,
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_pointer_updates_preserve_pointee_constness() {
    rejected(
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; const int *pointer = values; ++pointer; *pointer += 1; }"#,
    );
}

#[test]
fn cuda_pointer_updates_check_unused_helpers_and_unreachable_sources() {
    for source in [
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *const pointer = values; return; ++pointer; }"#,
        r#"__device__ void unused(int *const pointer) { pointer += 1; } __global__ void kernel() {}"#,
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_pointer_updates_preserve_constant_expression_side_effects() {
    for source in [
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; constexpr int Count = (++pointer, 4); int array[Count]{}; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; constexpr int Count = (pointer++, 4); int array[Count]{}; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; constexpr int Count = (pointer += 1, 4); int array[Count]{}; }"#,
        r#"__global__ void kernel(int *out) { int values[4]{2,3,5,7}; int *pointer = values; constexpr int Count = (pointer -= 1, 4); int array[Count]{}; }"#,
    ] {
        let error = rejected(source);
        assert!(error.message.contains("constant"), "{error}");
    }
}

#[test]
fn cuda_pointer_updates_preserve_original_diagnostic_spans() {
    let source = r#"#define UPDATE ++
/* λ 漢 */ __global__ void kernel() { int values[2]{2,3}; int *const pointer = values; UPDATE pointer; }"#;
    let error = rejected(source);
    let start = source.rfind("pointer").unwrap();
    assert_eq!(error.span, naga::Span::from(start..start + "pointer".len()));
}

#[test]
fn cuda_pointer_updates_preserve_flat_pointer_copy_chains() {
    for displaced in [false, true] {
        let mut source = String::from(
            "__global__ void kernel(int *out) { int values[3]{2, 3, 5}; int *pointer0 = values + 1;",
        );
        for index in 1..=128 {
            let offset = if displaced {
                if index % 2 == 1 {
                    " + 1"
                } else {
                    " - 1u"
                }
            } else {
                ""
            };
            source.push_str(&format!(
                "int *pointer{index} = pointer{}{offset};",
                index - 1
            ));
        }
        source.push_str("out[0] = *pointer128; out[1] = pointer128[-1]; out[2] = pointer128[1]; }");
        let (module, info) = validate(&source);
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = (module, info);
    }
}

#[test]
fn cuda_pointer_updates_keep_sequential_updates_flat() {
    let mut source = String::from(
        "__global__ void kernel(int *out) { int values[2]{2, 3}; int *pointer = values;",
    );
    source.push_str(&"++pointer; --pointer;".repeat(512));
    source.push_str("out[0] = *pointer; }");
    validate(&source);
}

#[test]
fn cuda_pointer_updates_forward_linear_helper_chains() {
    let mut source = String::from("__device__ void step0(int *pointer) { ++pointer; --pointer; }");
    for level in 1..48 {
        source.push_str(&format!(
            "__device__ void step{level}(int *pointer) {{ step{}(pointer); }}",
            level - 1
        ));
    }
    source.push_str(
        "__global__ void kernel(int *out) { int values[3]{2, 3, 5}; step47(values + 1); out[0] = values[1]; }",
    );
    let (module, info) = validate(&source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_pointer_updates_bound_cumulative_helper_expansion() {
    let mut source = String::from(
        "__device__ void step0(int *pointer) { int *first = pointer; int *second = first; ++first; --second; }",
    );
    for level in 1..24 {
        source.push_str(&format!(
            "__device__ void step{level}(int *pointer) {{ step{}(pointer); step{}(pointer); }}",
            level - 1,
            level - 1
        ));
    }
    source.push_str("__global__ void kernel() { int values[3]{2, 3, 5}; step23(values + 1); }");
    let error = rejected(&source);
    assert!(error.message.contains("limit") || error.message.contains("depth"));
}

#[test]
fn cuda_pointer_updates_bound_prefix_nesting() {
    let expression = format!("{}pointer", "++".repeat(128));
    let source = format!(
        "__global__ void kernel() {{ int values[3]{{2, 3, 5}}; int *pointer = values + 1; {expression}; }}"
    );
    let error = rejected(&source);
    assert!(error.message.contains("limit") || error.message.contains("depth"));
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_pointer_updates_roundtrip_through_shared_wgsl_validation() {
    let (module, info) = validate(FIXTURE);
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}
