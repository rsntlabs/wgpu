use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
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
fn cuda_template_default_arguments_accept_fixed_scalar_constant_defaults() {
    validate("template<class T> __device__ int add(T value, int bias = 3) { return int(value) + bias; }
        __global__ void kernel(int *out) { out[0] = add(4); out[1] = add(4, 9); out[2] = add<unsigned>(4u); }");
}

#[test]
fn cuda_template_default_arguments_replay_macro_headers_from_deferred_calls() {
    validate(
        "#define HEADER template<class T> __device__ int macro_default(T value, int bias = true ? 1, 2 : 3)
        HEADER { return int(value) + bias; }
        template<class U> __device__ int delayed(U value) { return macro_default(value); }
        __global__ void kernel(int *out) { out[0] = delayed(1); }
        ",
    );
}

#[test]
fn cuda_template_default_arguments_inherit_first_declaration_defaults_and_reuse_body_instances() {
    let module = validate(
        "constexpr int Frozen = 3;
        template<class T> __device__ int add(T original, int bias = Frozen);
        template<class U> __device__ int add(U renamed, int other) { return int(renamed) + other; }
        __global__ void kernel(int *out) {
            int Frozen = 99;
            out[0] = add(1); out[1] = add(1, 9); out[2] = add<int>(2);
            out[3] = add(1u); out[4] = add(1u, 9);
        }",
    );
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    assert_eq!(calls.len(), 5);
    assert_eq!(calls[0], calls[1]);
    assert_eq!(calls[1], calls[2]);
    assert_eq!(calls[3], calls[4]);
    assert_ne!(calls[0], calls[3]);
}

#[test]
fn cuda_template_default_arguments_freeze_scalar_conversions_and_source_types() {
    validate_with_options_and_capabilities("__device__ int category(long value) { return 1; }
        __device__ int category(long long value) { return 2; }
        template<class T> __device__ int narrow(T unused, short value = 65535, unsigned short other = 65537u) { return int(value) + int(other); }
        template<class T> __device__ int source_long(T unused, long value = 1LL) { return category(value); }
        template<class T> __device__ int source_ll(T unused, long long value = 1L) { return category(value); }
        template<class T> __device__ int converted(T value, int bias = 3.75f, bool enabled = 2, float scale = 2) { return int(value) + bias + int(enabled) + int(scale); }
        template<class T> __device__ unsigned wrapped(unsigned value = -1) { return value; }
        template<class T> __device__ int size(int value = sizeof(int)) { return value; }
        __global__ void kernel(unsigned *out) {
            out[0] = unsigned(narrow(1)); out[1] = unsigned(source_long(1)); out[2] = unsigned(source_ll(1));
            out[3] = unsigned(converted(true)); out[4] = wrapped<int>(); out[5] = unsigned(size<int>());
        }", &Options::default(), Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64);
}

#[test]
fn cuda_template_default_arguments_deduce_only_from_supplied_arguments() {
    validate("template<class T> __device__ int explicit_only(int value = 3) { return value; }
        template<class T, class U> __device__ int missing(T value, int bias = 3) { return int(value) + bias; }
        __device__ int inner(int value, int extra = 2) { return value + extra; }
        template<int N> __device__ int explicit_value(int bias = 7) { return inner(bias) + N; }
        __global__ void kernel(int *out) { out[0] = explicit_only<unsigned>(); out[1] = missing<int, unsigned>(1); out[2] = explicit_value<3>(); }");
    for source in [
        "template<class T> __device__ int f(int value = 3) { return value; } __global__ void kernel() { f(); }",
        "template<class T, class U> __device__ int f(T value, int bias = 3) { return int(value) + bias; } __global__ void kernel() { f(1); }",
    ] { rejected(source); }
}

#[test]
fn cuda_template_default_arguments_order_only_supplied_parameter_patterns() {
    validate("template<class T> __device__ int left(T value, int bias = 3) { return bias; }
        template<class T> __device__ int left(T *value) { return int(*value); }
        template<class T> __device__ int right(T value) { return 1; }
        template<class T> __device__ int right(T *value, int bias = 4) { return int(*value) + bias; }
        __device__ int tied(int value, int bias = 2) { return value + bias; }
        template<class T> __device__ int tied(T value, int bias = 3) { return int(value) + bias; }
        __global__ void kernel(int *out, const int *input) { out[0] = left(input); out[1] = right(input); out[2] = tied(1); out[3] = tied(1u); }");
    let error = rejected(
        "template<class T> __device__ int f(T value, int bias = 3) { return bias; }
        template<class T> __device__ int f(T value, float scale = 2.0f) { return int(scale); }
        __global__ void kernel() { f(1); }",
    );
    assert!(error.message.contains("ambiguous"), "{error}");
}

#[test]
fn cuda_template_default_arguments_support_indirect_erased_bool_and_lazy_prefixes() {
    validate("using Null = decltype(nullptr); namespace cg = cooperative_groups;
        template<class T> __device__ int bump(T &value, int step = 2) { int old = int(value); value += T(step); return old; }
        template<class T> __device__ int load(const T *input, int index = 1) { return int(input[index]); }
        template<int N> __device__ int erased(Null value, int result = 7) { return result + N; }
        template<int N> __device__ int block(cg::thread_block group, int result = 9) { return result + N; }
        template<class T> __device__ int choose(T value, int extra = 3) { return int(value) + extra; }
        __device__ int choose(bool value, int extra = 4) { return int(value) + extra; }
        __global__ void kernel(int *out, const int *input) {
            int value = 1; int index = 0;
            out[0] = bump(value); out[1] = load(input + index++); out[2] = erased<5>(nullptr);
            out[3] = block<3>(cg::this_thread_block()); out[4] = choose(true); out[5] = choose<bool>(true);
            false && bump(value); true || bump(value); bump(value); out[6] = value + index;
        }");
}

#[test]
fn cuda_template_default_arguments_reject_redefaults_later_additions_and_nontrailing_defaults() {
    for source in [
        "template<class T> __device__ int f(T value, int bias = 3); template<class U> __device__ int f(U value, int bias = 3); __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias = 3); template<class U> __device__ int f(U value, int bias = 4) { return int(value) + bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias); template<class U> __device__ int f(U value, int bias = 3) { return int(value) + bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int first, int second = 3); template<class U> __device__ int f(U value, int first = 2, int second) { return first + second; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int first = 2, int second) { return first + second; } __global__ void kernel() {}",
    ] { rejected(source); }
}

#[test]
fn cuda_template_default_arguments_reject_dependent_or_nonscalar_default_contexts() {
    for source in [
        "template<class T> __device__ T f(T value, T bias = 1) { return value + bias; } __global__ void kernel() { f<int>(1, 2); }",
        "template<int N> __device__ int f(int value, int bias = N) { return value + bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias = sizeof(T)) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias = T(1)) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias = sizeof(value)) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int fixed, int bias = sizeof(fixed)) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias = ((void)value, 3)) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int fixed, int bias = false ? fixed : 3) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, const int &bias = 3) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int *pointer = nullptr) { return 1; } __global__ void kernel() {}",
        "template<class T> __global__ void kernel(T value, int bias = 3) {}",
    ] { rejected(source); }
}

#[test]
fn cuda_template_default_arguments_preserve_conditional_middle_commas_and_nested_casts_on_replay() {
    validate("template<class T> __device__ int conditional(T value, int count = true ? 1, 2 : 3) { return int(value) + count; }
        template<class T> __device__ int casted(T value, int count = static_cast<int>(static_cast<float>(3))) { return int(value) + count; }
        __global__ void kernel(int *out) { out[0] = conditional(1); out[1] = conditional(1, 9); out[2] = casted(1); }");
}
