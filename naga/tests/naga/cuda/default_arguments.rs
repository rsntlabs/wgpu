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
fn cuda_default_arguments_accept_scalar_defaults_on_device_definitions() {
    validate(
        "__device__ int add(int value, int step = 3) { return value + step; }
        __global__ void kernel(int *out) { out[0] = add(4); out[1] = add(4, 9); }",
    );
}

#[test]
fn cuda_default_arguments_merge_trailing_defaults_across_prototypes_and_definition() {
    validate(
        "__device__ int combine(int, int = 1);
        __device__ int combine(int = 2, int);
        __device__ int combine(int first, int second) { return first * 10 + second; }
        __device__ int tail(int first, int second = 3);
        __device__ int tail(int first, int second) { return first + second; }
        __global__ void kernel(int *out) {
            out[0] = combine(); out[1] = combine(4); out[2] = combine(4, 5);
            out[3] = tail(7); out[4] = tail(7, 9);
        }",
    );
}

#[test]
fn cuda_default_arguments_freeze_declaration_bindings_and_convert_scalar_types() {
    validate_with_options_and_capabilities("constexpr int Default = 3;
        __device__ int category(long value) { return 1; }
        __device__ int category(long long value) { return 2; }
        __device__ int signed_narrow(short value = 65535) { return int(value); }
        __device__ unsigned unsigned_narrow(unsigned short value = 65537u) { return unsigned(value); }
        __device__ int source_long(long value = 1LL) { return category(value); }
        __device__ int source_ll(long long value = 1L) { return category(value); }
        __device__ int take(int value = Default) { return value; }
        __device__ int converted(int value = 3.75f, bool enabled = 2, float scale = 2) { return value + int(enabled) + int(scale); }
        __device__ unsigned wrapped(unsigned value = -1) { return value; }
        __global__ void kernel(unsigned *out) {
            int Default = 99;
            out[0] = unsigned(take()); out[1] = unsigned(converted()); out[2] = wrapped();
            out[3] = unsigned(signed_narrow()); out[4] = unsigned_narrow();
            out[5] = unsigned(source_long()); out[6] = unsigned(source_ll());
        }", &Options::default(), Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64);
}

#[test]
fn cuda_default_arguments_use_only_defaults_visible_at_original_call_position() {
    validate(
        "__device__ int add(int, int);
        __device__ int earlier() { return add(1, 9); }
        __device__ int add(int, int = 3);
        __device__ int add(int first, int second) { return first + second; }
        __global__ void kernel(int *out) { out[0] = earlier(); out[1] = add(2); }",
    );
    rejected(
        "__device__ int add(int, int);
        __device__ int earlier() { return add(1); }
        __device__ int add(int first, int second = 3) { return first + second; }
        __global__ void kernel(int *out) { out[0] = earlier(); }",
    );
    rejected(
        "__device__ int add(int, int);
        template<typename T> __device__ int delayed(T value) { return add(int(value)); }
        __device__ int add(int first, int second = 3) { return first + second; }
        __global__ void kernel(int *out) { out[0] = delayed<int>(2); }",
    );
    validate(
        "__device__ int add(int, int = 3);
        template<typename T> __device__ int delayed(T value) { return add(int(value)); }
        __device__ int add(int first, int second) { return first + second; }
        __global__ void kernel(int *out) { out[0] = delayed<int>(2); }",
    );
}

#[test]
fn cuda_default_arguments_rank_only_supplied_arguments_and_preserve_ambiguity() {
    validate("__device__ int choose(int value, int extra = 1) { return value + extra; }
        __device__ int choose(unsigned value, float extra = 2.0f) { return int(value) + int(extra); }
        __global__ void kernel(int *out) { out[0] = choose(1); out[1] = choose(1u); }");
    for source in [
        "__device__ int pick(int value) { return value; } __device__ int pick(int value, int extra = 1) { return value + extra; } __global__ void kernel() { pick(1); }",
        "__device__ int pick(int value = 1) { return value; } __device__ int pick(float value = 1.0f) { return int(value); } __global__ void kernel() { pick(); }",
    ] {
        let error = rejected(source);
        assert!(error.message.contains("ambiguous"), "{error}");
    }
}

#[test]
fn cuda_default_arguments_support_captured_bool_overloads_and_supplied_indirect_or_erased_prefixes()
{
    validate("using Null = decltype(nullptr);
        namespace cg = cooperative_groups;
        __device__ int consume(bool value, int extra = 3) { return int(value) + extra; }
        __device__ int consume(int value, int extra = 4) { return value + extra; }
        __device__ int bump(int &value, int step = 2) { int old = value; value += step; return old; }
        __device__ int load(const int *input, int index = 1) { return input[index]; }
        __device__ int erased(Null value, int result = 7) { return result; }
        __device__ int block(cg::thread_block group, int result = 9) { return result; }
        __global__ void kernel(int *out, const int *input) {
            int value = 1;
            out[0] = consume(true); out[1] = consume(1); out[2] = bump(value);
            out[3] = load(input); out[4] = erased(nullptr); out[5] = block(cg::this_thread_block());
            false && bump(value); true || bump(value); bump(value); out[6] = value;
        }");
}

#[test]
fn cuda_default_arguments_reject_redefaults_missing_trailing_defaults_and_nonconstants() {
    for source in [
        "__device__ int f(int = 1); __device__ int f(int = 1); __global__ void kernel() {}",
        "__device__ int f(int = 1); __device__ int f(int value = 2) { return value; } __global__ void kernel() {}",
        "__device__ int f(int first = 1, int second) { return first + second; } __global__ void kernel() {}",
        "__device__ int f(int first, int second = first) { return second; } __global__ void kernel() {}",
        "__device__ int produce() { return 1; } __device__ int f(int value = produce()) { return value; } __global__ void kernel() {}",
        "__device__ int f(int value = int(threadIdx.x)) { return value; } __global__ void kernel() {}",
        "constexpr int value = 7; __device__ int f(int value = value) { return value; } __global__ void kernel() {}",
    ] { rejected(source); }
}

#[test]
fn cuda_default_arguments_reject_unsupported_default_contexts_and_bad_arity() {
    for source in [
        "__global__ void kernel(int value = 1) {}",
        "template<int N> __global__ void k(int value) {} template __global__ void k<1>(int = 3);",
        "__device__ int __popc(unsigned value = 1u); __global__ void kernel() {}",
        "template<typename T> __device__ T f(T value = 1) { return value; } __global__ void kernel() {}",
        "__device__ int f(int *value = nullptr) { return 1; } __global__ void kernel() {}",
        "__device__ int f(const int &value = 1) { return value; } __global__ void kernel() {}",
        "__device__ int f(float2 value = make_float2(1.0f, 2.0f)) { return 1; } __global__ void kernel() {}",
        "struct S { int value; }; __device__ int f(S value = S{1}) { return value.value; } __global__ void kernel() {}",
        "__device__ int f(int first, int second = 1) { return first + second; } __global__ void kernel() { f(); }",
        "__device__ int f(int first, int second = 1) { return first + second; } __global__ void kernel() { f(1, 2, 3); }",
    ] { rejected(source); }
}

#[test]
fn cuda_default_arguments_preserve_prepared_macro_order_inside_delayed_templates() {
    rejected("__device__ int f(int);
        #define DECLARE_ALL template<typename T> __device__ int delayed(T unused) { return f(); } __device__ int f(int value = 1) { return value; }
        DECLARE_ALL
        __global__ void kernel(int *out) { out[0] = delayed<int>(0); }");
    validate("__device__ int f(int);
        #define DECLARE_ALL __device__ int f(int value = 1) { return value; } template<typename T> __device__ int delayed(T unused) { return f(); }
        DECLARE_ALL
        __global__ void kernel(int *out) { out[0] = delayed<int>(0); }");
}

#[test]
fn cuda_default_arguments_allow_unevaluated_parameter_size_queries() {
    validate_with_options_and_capabilities(
        "__device__ int own_size(int value = sizeof(value)) { return value; }
        __device__ int earlier_size(int first, int second = sizeof(first)) { return second; }
        __global__ void kernel(int *out) { out[0] = own_size(); out[1] = earlier_size(7); }
        ",
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_default_arguments_compete_with_same_name_templates_and_library_candidates() {
    validate(
        "__device__ int ranked(int value, int extra = 2) { return value + extra; }
        template<typename T> __device__ int ranked(T value) { return int(value); }
        __global__ void kernel(int *out) { out[0] = ranked(1); out[1] = ranked(1u); }",
    );
    validate(
        "__device__ int fabs(int value, int extra = 2) { return value + extra; }
        __device__ int sqrt(int value, int extra = 3) { return value + extra; }
        __global__ void kernel(int *out) { out[0] = fabs(1); out[1] = sqrt(1); }",
    );
}

#[test]
fn cuda_default_arguments_reject_operators_and_preserve_recursion_diagnostics() {
    rejected(
        "struct S { int value; };
        __device__ int operator+(S left, int right = 1) { return left.value + right; }
        __global__ void kernel() {}",
    );
    let error = rejected(
        "__device__ int recurse(int value = 0) { return recurse(); } __global__ void kernel() {}",
    );
    assert!(error.message.contains("recursive"), "{error}");
}

#[test]
fn cuda_default_arguments_reject_potentially_evaluated_parameter_uses_even_if_folded_or_discarded()
{
    for declaration in [
        "__device__ int f(int x, int y = ((void)x, 3)) { return y; }",
        "__device__ int f(int x, int y = (x, 3)) { return y; }",
        "__device__ int f(int x, int y = false ? x : 3) { return y; }",
        "__device__ bool f(int x, bool y = true || x) { return y; }",
        "using Null = decltype(nullptr); __device__ int f(Null x, int y = ((void)x, 3)) { return y; }",
        "namespace cg = cooperative_groups; __device__ int f(cg::thread_block x, int y = ((void)x, 3)) { return y; }",
    ] {
        rejected(&format!("{declaration} __global__ void kernel() {{}}"));
    }
}
