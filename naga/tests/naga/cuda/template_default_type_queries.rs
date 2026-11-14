use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty());
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_template_default_type_queries_accept_own_and_earlier_fixed_scalar_parameter_sizes() {
    validate("template<int N> __device__ int own(int value = sizeof(value)) { return value + N; }
        template<class T> __device__ int earlier(T unused, int value, int count = sizeof((value))) { return count; }
        __global__ void kernel(int *out) { out[0] = own<0>(); out[1] = earlier(1u, 7); }");
}

#[test]
fn cuda_template_default_type_queries_accept_reference_pointer_and_adjusted_array_types() {
    validate("using Pointer = const int *;
        template<class T> __device__ int reference(T unused, const int &value, int count = sizeof(value)) { return count; }
        template<class T> __device__ int pointer(T unused, Pointer value, int count = sizeof(value), int element = sizeof(*value)) { return count + element; }
        template<class T> __device__ int array(T unused, const int value[3], int count = sizeof(value), int element = sizeof(value[0])) { return count + element; }
        __global__ void kernel(int *out, const int *input) {
            int local = 7; out[0] = reference(1, local); out[1] = pointer(1, input); out[2] = array(1, input);
        }");
}

#[test]
fn cuda_template_default_type_queries_accept_record_vector_members_and_source_only_nullptr() {
    validate("struct Record { int value; int pair[2]; };
        using Null = decltype(nullptr);
        template<class T> __device__ int record(T unused, const Record &item, int count = sizeof(item), int pair = sizeof(item.pair), int element = sizeof(item.pair[0])) { return count + pair + element; }
        template<class T> __device__ int vector(T unused, float2 item, int count = sizeof(item), int element = sizeof(item.x)) { return count + element; }
        template<class T> __device__ int pointer_member(T unused, const Record *item, int count = sizeof(item->pair)) { return count; }
        template<class T> __device__ int null_size(T unused, Null item, int count = sizeof(item)) { return count; }
        __global__ void kernel(int *out) {
            Record item{1, {2, 3}};
            out[0] = record(1, item); out[1] = vector(1, make_float2(1.0f, 2.0f));
            out[2] = pointer_member(1, &item); out[3] = null_size(1, nullptr);
        }");
}

#[test]
fn cuda_template_default_type_queries_preserve_alias_long_and_parameter_name_classification() {
    validate_with_options_and_capabilities("using Word = long; using Alias = float2;
        constexpr int Item = 7;
        template<class T> __device__ int long_size(T unused, Word item, int count = sizeof(item)) { return count; }
        template<class T> __device__ int shadows_value(T unused, float2 Item, int count = sizeof(Item)) { return count; }
        template<class T> __device__ int shadows_type(T unused, int Alias, int count = sizeof(Alias)) { return count; }
        __global__ void kernel(int *out) {
            out[0] = long_size(1, 1L); out[1] = shadows_value(1, make_float2(1.0f, 2.0f)); out[2] = shadows_type(1, 9);
        }", &Options::default(), Capabilities::SHADER_INT64);
    reject("using Alias = int; template<class T> __device__ int f(T unused, int Alias, int count = sizeof(Alias *)) { return count; } __global__ void kernel() {}");
    reject("template<class T> __device__ int f(T unused, int value, int count = static_cast<value>(1)) { return count; } __global__ void kernel() {}");
}

#[test]
fn cuda_template_default_type_queries_freeze_initial_declaration_names_across_definition_renames() {
    validate("template<class T> __device__ int size(T unused, float2 original, int count = sizeof(original));
        template<class U> __device__ int size(U renamed, float2 other, int width) { return width; }
        __global__ void kernel(int *out) {
            int original = 99;
            out[0] = size(1, make_float2(1.0f, 2.0f)); out[1] = size(1, make_float2(1.0f, 2.0f), 17);
        }");
}

#[test]
fn cuda_template_default_type_queries_preserve_macro_bounds_and_explicit_argument_replay() {
    validate("#define DECLARE_QUERY template<class T> __device__ int query(T unused, const int *item, int bytes = sizeof(*item), int width = static_cast<int>(sizeof(item))) { return bytes + width; }
        DECLARE_QUERY
        __global__ void kernel(int *out, const int *input) { out[0] = query(1, input); out[1] = query(1, input, 9, 10); }");
}

#[test]
fn cuda_template_default_type_queries_reject_dependent_and_thread_block_operands() {
    for declaration in [
        "template<class T> __device__ int f(T value, int size = sizeof(value)) { return size; }",
        "template<class T> __device__ int f(T *value, int size = sizeof(value)) { return size; }",
        "template<class T> __device__ int f(T *value, int size = sizeof(*value)) { return size; }",
        "template<class T> __device__ int f(T value, int size = sizeof(T)) { return size; }",
        "namespace cg = cooperative_groups; template<class T> __device__ int f(T unused, cg::thread_block group, int size = sizeof(group)) { return size; }",
    ] { reject(&format!("{declaration} __global__ void kernel() {{}}")); }
}

#[test]
fn cuda_template_default_type_queries_do_not_make_parameter_values_calls_or_types_available() {
    for expression in [
        "value",
        "(value, 3)",
        "((void)value, 3)",
        "false ? value : 3",
        "value(3)",
        "true || value",
    ] {
        reject(&format!("template<class T> __device__ int f(T unused, int value, int count = {expression}) {{ return count; }} __global__ void kernel() {{}}"));
    }
    reject("template<class T> __device__ int f(T unused, const int *value, int count = ((void)value, 3)) { return count; } __global__ void kernel() {}");
    reject("using Null = decltype(nullptr); template<class T> __device__ int f(T unused, Null value, int count = ((void)value, 3)) { return count; } __global__ void kernel() {}");
}

#[test]
fn cuda_template_default_type_queries_adjust_array_alias_parameters_exactly_once() {
    validate("using Row = int[3]; using Grid = int[2][3];
        template<int N> __device__ int row_size(Row value, int bytes = sizeof(value), int element = sizeof(*value)) { return bytes + element + N; }
        template<int N> __device__ int grid_size(Grid value, int bytes = sizeof(value), int row = sizeof(*value)) { return bytes + row + N; }
        template<int N> __device__ int pointer_size(Row *value, int bytes = sizeof(value), int row = sizeof(*value)) { return bytes + row + N; }
        __global__ void kernel(int *out) {
            Row row{1, 2, 3}; Grid grid{{4, 5, 6}, {7, 8, 9}};
            out[0] = row_size<0>(row); out[1] = grid_size<0>(grid); out[2] = pointer_size<0>(&row);
        }");
}

#[test]
fn cuda_template_default_type_queries_allow_pointer_to_incomplete_array_but_reject_incomplete_object_size(
) {
    validate(
        "using Unbounded = int[];
        template<int N> __device__ int pointer_size(Unbounded *value, int bytes = sizeof(value));
        __global__ void kernel() {}",
    );
    reject(
        "using Unbounded = int[];
        template<int N> __device__ int object_size(Unbounded *value, int bytes = sizeof(*value));
        __global__ void kernel() {}",
    );
}
