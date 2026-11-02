use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

#[test]
fn cuda_null_pointers_fixture_roundtrips_through_the_shared_wgsl_helper() {
    roundtrip(include_str!("../../in/cuda/null-pointers.cu"));
}

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_null_pointers_initialize_assign_and_forward_to_guarded_helpers() {
    roundtrip(
        "__device__ unsigned read_or_default(const unsigned *input) {
            return input ? input[0] : 7u;
        }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{19u, 23u};
            unsigned *pointer = 0;
            output[0] = read_or_default(pointer);
            pointer = values;
            output[1] = read_or_default(pointer);
            pointer = 0;
            output[2] = read_or_default(pointer);
            output[3] = read_or_default(0);
        }",
    );
}

#[test]
fn cuda_null_pointers_support_null_only_boolean_and_equality_queries() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            unsigned *pointer = 0;
            output[0] = unsigned(bool(pointer));
            output[1] = unsigned(!pointer);
            output[2] = unsigned(pointer == 0);
            output[3] = unsigned(0u != pointer);
        }",
    );
}

#[test]
fn cuda_null_pointers_value_initialize_empty_pointer_braces() {
    roundtrip(
        "using Pointer = const unsigned *;
        __global__ void kernel(unsigned *output) {
            unsigned *first{};
            const unsigned *const second = {};
            Pointer third{};
            output[0] = unsigned(!first);
            output[1] = unsigned(second == 0);
            output[2] = unsigned(!third);
        }",
    );
}

#[test]
fn cuda_null_pointers_preserve_parenthesized_and_macro_zero_literals() {
    for (prefix, value) in [
        ("", "0"),
        ("", "((0u))"),
        ("", "0x0u"),
        ("", "0b0"),
        ("", "0'0"),
        ("#define ZERO 0\n", "ZERO"),
        ("#define IDENTITY(value) value\n", "IDENTITY((0u))"),
    ] {
        roundtrip(&format!(
            "{prefix} __global__ void kernel(unsigned *output) {{
                int *first = {value}; int *second{{{value}}};
                int *third = {{{value}}};
                output[0] = unsigned(!first) + unsigned(!second) + unsigned(!third);
            }}"
        ));
    }
}

#[test]
fn cuda_null_pointers_select_pointer_and_null_conditional_arms() {
    roundtrip(
        "__global__ void kernel(unsigned *output, unsigned choose) {
            unsigned value = 11u;
            unsigned *first = choose ? &value : 0;
            const unsigned *second = choose ? 0 : &value;
            if (first) output[0] = *first;
            if (second != 0) output[1] = *second;
            output[2] = unsigned(first == 0);
            output[3] = unsigned(0 != second);
        }",
    );
}

#[test]
fn cuda_null_pointers_convert_to_boolean_values_and_const_references() {
    roundtrip(
        "__device__ unsigned flag(bool value) { return value ? 3u : 5u; }
        __device__ unsigned view(const bool &value) { return value ? 7u : 11u; }
        __global__ void kernel(unsigned *output) {
            unsigned value = 13u;
            unsigned *pointer = 0;
            output[0] = flag(pointer);
            output[1] = view(pointer);
            output[2] = unsigned(static_cast<bool>(pointer));
            pointer = &value;
            output[3] = flag(pointer);
            output[4] = view(pointer);
            output[5] = unsigned(bool(pointer));
        }",
    );
}

#[test]
fn cuda_null_pointers_convert_explicit_template_pointer_arguments() {
    roundtrip(
        "template<class Value> __device__ unsigned present(const Value *pointer) {
            return pointer ? 17u : 19u;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = present<unsigned>(0);
            unsigned value = 23u;
            unsigned *pointer = &value;
            output[1] = present(pointer);
        }",
    );
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_null_pointers_keep_actual_pointees_cv_and_aliases() {
    for pointee in ["int", "unsigned", "float", "float2", "Record"] {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }};
            using Element = {pointee};
            using Pointer = Element *;
            using ReadOnly = const Element *;
            __global__ void kernel(unsigned *output) {{
                Pointer first = 0; Pointer second{{}}; Pointer third = {{}};
                const Pointer fixed{{}}; ReadOnly view = first;
                first = 0u; second = first; third = second;
                output[0] = unsigned(bool(first)) + unsigned(bool(second))
                    + unsigned(bool(third)) + unsigned(bool(fixed)) + unsigned(bool(view));
            }}"
        ));
    }
}

#[test]
fn cuda_null_pointers_materialize_only_the_selected_pointer_overload() {
    roundtrip(
        "__device__ unsigned selected(unsigned *value) { return value ? 1u : 3u; }
        __device__ unsigned selected(unsigned value) { return 2u; }
        __device__ unsigned boolean_or_pointer(unsigned *value) { return 4u; }
        __device__ unsigned boolean_or_pointer(bool value) { return 5u; }
        template<class Value> __device__ bool empty(Value *value) { return !value; }
        __global__ void kernel(unsigned *output) {
            unsigned *pointer = 0;
            output[0] = selected(0u);
            output[1] = selected(pointer);
            output[2] = boolean_or_pointer(pointer);
            output[3] = unsigned(empty<unsigned>(0));
            output[4] = unsigned(empty<const unsigned>(0));
            output[5] = unsigned(empty(pointer));
        }",
    );
    let error = rejected(
        "__device__ unsigned selected(unsigned *value) { return 1u; }
        __device__ unsigned selected(bool value) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected(0); }",
    );
    assert!(error.message.contains("ambiguous"), "{error}");
    rejected(
        "template<class Value> __device__ bool empty(Value *value) { return !value; }
        __global__ void kernel(unsigned *output) { output[0] = unsigned(empty(0)); }",
    );
}

#[test]
fn cuda_null_pointers_reject_nonliteral_zero_in_every_pointer_context() {
    for expression in [
        "zero",
        "int(0)",
        "static_cast<int>(0)",
        "(int)0",
        "unsigned(0u)",
        "(1 - 1)",
        "+0",
        "false",
        "0.0f",
        "(1, 0)",
        "(true ? 0 : 0)",
        "produced_zero()",
    ] {
        for statement in [
            format!("int *pointer = {expression};"),
            format!("int *pointer = 0; pointer = {expression};"),
            format!("output[0] = read({expression});"),
            format!("int *pointer = 0; output[0] = int(pointer == {expression});"),
            format!("int *pointer = 0; output[0] = int({expression} != pointer);"),
        ] {
            rejected(&format!(
                "__device__ int produced_zero() {{ return 0; }}
                __device__ int read(const int *pointer) {{ return pointer ? *pointer : 17; }}
                __global__ void kernel(int *output) {{ constexpr int zero = 0; {statement} }}"
            ));
        }
    }
}

#[test]
fn cuda_null_pointers_keep_type_and_const_safety_rejections() {
    for statement in [
        "const int *read = 0; int *write = read;",
        "using ReadOnly = const int *; ReadOnly read{}; int *write = read;",
        "int *const fixed{}; fixed = 0;",
        "float *input = 0; int *output = input;",
        "int *pointer = 0; int value = pointer;",
        "int *pointer = 0; int value = int(pointer);",
        "int *pointer = (int *)1;",
        "int *pointer = static_cast<int *>(1);",
    ] {
        rejected(&format!("__global__ void kernel() {{ {statement} }}"));
    }
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            int *first = (int *)0;
            int *second = static_cast<int *>(0);
            output[0] = unsigned(!first) + unsigned(!second);
        }",
    );
}

#[test]
fn cuda_null_pointers_stay_distinct_from_uninitialized_pointer_objects() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            int *empty{}; int *assigned; assigned = 0;
            output[0] = unsigned(!empty); output[1] = unsigned(!assigned);
        }",
    );
    for statement in [
        "output[0] = unsigned(bool(pointer));",
        "output[0] = unsigned(pointer == 0);",
        "int *copy = pointer;",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned *output) {{ int *pointer; {statement} }}"
        ));
    }
}

#[test]
fn cuda_null_pointers_keep_general_pointer_equality_unsupported() {
    for statement in [
        "int *first = 0; int *second = 0; bool same = first == second;",
        "int first = 1, second = 2; bool different = &first != &second;",
        "int values[2]{}; bool same = values + 1 == &values[1];",
    ] {
        rejected(&format!("__global__ void kernel() {{ {statement} }}"));
    }
}

#[test]
fn cuda_null_pointers_keep_conditional_expression_nesting_bounded() {
    let source = |depth| {
        let mut value = "values".to_owned();
        for _ in 0..depth {
            value = format!("condition ? 0 : ({value})");
        }
        format!(
            "__global__ void kernel(unsigned *output, unsigned condition) {{
                int values[2]{{3, 5}}; int *selected = {value};
                output[0] = unsigned(bool(selected));
            }}"
        )
    };
    roundtrip(&source(8));
    let error = rejected(&source(128));
    assert!(
        error.message.contains("nesting") && error.message.contains("limit"),
        "{error}"
    );
}

#[test]
fn cuda_null_pointers_keep_boolean_argument_capture_nesting_bounded() {
    let source = |depth| {
        format!(
            "__device__ bool identity(bool value) {{ return value; }}
            __global__ void kernel(unsigned *output) {{
                unsigned *pointer = 0;
                output[0] = unsigned({}pointer{});
            }}",
            "identity(".repeat(depth),
            ")".repeat(depth),
        )
    };
    roundtrip(&source(8));
    let error = rejected(&source(512));
    assert!(
        error.message.contains("limit") || error.message.contains("nesting"),
        "{error}"
    );
}
#[test]
fn cuda_null_pointers_decay_arrays_for_boolean_contexts_and_parameters() {
    roundtrip(
        "__device__ unsigned flag(bool value) { return value ? 3u : 5u; }
        __device__ unsigned view(const bool &value) { return value ? 7u : 11u; }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{3u, 5u};
            const unsigned frozen[2]{7u, 11u};
            unsigned count = 0u;
            if (values) ++count;
            if (frozen) ++count;
            bool copied = values;
            output[0] = flag(values);
            output[1] = view(values);
            output[2] = unsigned(bool(values));
            output[3] = unsigned(static_cast<bool>(frozen));
            output[4] = flag(frozen);
            output[5] = view(frozen);
            output[6] = count + unsigned(copied);
        }",
    );
}

#[test]
fn cuda_null_pointers_keep_null_values_after_zero_offsets_and_unary_plus() {
    roundtrip(
        "__device__ unsigned present(const unsigned *value) { return value ? 1u : 0u; }
        __global__ void kernel(unsigned *output) {
            unsigned *pointer = 0;
            unsigned *added = pointer + 0;
            unsigned *reversed = 0 + pointer;
            unsigned *subtracted = pointer - 0;
            unsigned *positive = +pointer;
            pointer += 0; pointer -= 0;
            unsigned amount = 0u;
            pointer += amount; pointer -= amount;
            output[0] = unsigned(added == 0);
            output[1] = unsigned(reversed == 0);
            output[2] = unsigned(subtracted == 0);
            output[3] = unsigned(positive == 0);
            output[4] = unsigned(pointer == 0);
            output[5] = present(pointer + (1u - 1u));
        }",
    );
}
