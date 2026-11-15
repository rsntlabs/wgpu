use super::helpers::validate_with_options_and_capabilities;
use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
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
fn cuda_template_default_merging_combines_slots_and_normalizes_instances() {
    let module = validate("template<class T = unsigned, int N> __device__ T value();
        template<class Renamed, int Count = 7> __device__ Renamed value();
        template<class Result, int Amount> __device__ Result value() { return Result(Amount); }
        __global__ void kernel(unsigned *out) { out[0] = value(); out[1] = value<>(); out[2] = value<unsigned>(); out[3] = value<unsigned, 7>(); }");
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    assert_eq!(calls.len(), 4);
    assert!(calls.iter().all(|function| *function == calls[0]));
}

#[test]
fn cuda_template_default_merging_adds_after_definition_and_freezes_each_environment() {
    validate("using Frozen = unsigned; constexpr int Count = 5;
        template<class T, int N> __device__ T value() { return T(N); }
        template<class T = Frozen, int N> __device__ T value();
        template<class Renamed, int Count = Count> __device__ Renamed value();
        using Self = unsigned;
        template<class T> __device__ T self_named() { return T(9); }
        template<class Self = Self> __device__ Self self_named();
        __global__ void kernel(unsigned *out) { using Frozen = int; constexpr int Count = 99; out[0] = value(); out[1] = self_named(); }");
}

#[test]
fn cuda_template_default_merging_preserves_call_site_visibility_in_replayed_templates() {
    validate(
        "template<class T = unsigned, class U> __device__ T value(U input) { return T(input); }
        template<int K> __device__ unsigned caller() { return value(1); }
        template<class T, class U = int> __device__ T value(U input);
        __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }",
    );
    validate(
        "template<class T> __device__ T value() { return T(7); }
        template<class T = unsigned> __device__ T value();
        template<int N> __device__ unsigned caller() { return value(); }
        __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }",
    );
    for source in [
        "template<class T> __device__ T value() { return T(7); } __global__ void kernel(unsigned *out) { out[0] = value(); } template<class T = unsigned> __device__ T value();",
        "template<class T> __device__ T value() { return T(7); } template<int N> __device__ unsigned caller() { return value(); } template<class T = unsigned> __device__ T value(); __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }",
        "template<class T = unsigned, int N> __device__ T value() { return T(N); } template<int K> __device__ unsigned caller() { return value<unsigned>(); } template<class T, int N = 7> __device__ T value(); __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }",
        "template<class T> __device__ T value() { return T(7); }\n#define EARLY template<int N> __device__ unsigned caller() { return value(); } template<class T = unsigned> __device__ T value();\n EARLY __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }",
    ] { reject(source); }
}

#[test]
fn cuda_template_default_merging_supports_kernel_defaults_added_after_definition() {
    let module = validate(
        "template<class T, int N> __global__ void filled(T *out) { out[0] = T(N); }
        template<class T = unsigned, int N> __global__ void filled(T *out);
        template<class U, int Count = 7> __global__ void filled(U *out);
        template __global__ void filled<>(unsigned *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "filled<unsigned,7>");
    reject("template<int N> __global__ void filled(int *out) { out[0] = N; } template __global__ void filled<>(int *); template<int N = 7> __global__ void filled(int *out);");
    reject("template<int N> __global__ void filled(int *out) { out[0] = N; } template<int N = 7> __global__ void filled(int *out); template __global__ void filled<>(int *); template __global__ void filled<7>(int *);");
}

#[test]
fn cuda_template_default_merging_keeps_defaults_isolated_by_signature() {
    validate(
        "template<int N> __device__ int choose(int value) { return N + value; }
        template<int N> __device__ int choose(unsigned value) { return 20 + N + int(value); }
        template<int N = 3> __device__ int choose(int value);
        template<int N = 5> __device__ int choose(unsigned value);
        __global__ void kernel(int *out) { out[0] = choose(1); out[1] = choose(1u); }",
    );
    reject("template<class T> __device__ int f() { return 1; } template<class T, int N> __device__ int f() { return 2; } template<class T = int> __device__ int f(); template<class T = int, int N = 2> __device__ int f(); __global__ void kernel(int *out) { out[0] = f<>(); }");
}

#[test]
fn cuda_template_default_merging_rejects_redefaults_and_preserves_function_default_scope() {
    for source in [
        "template<class T = int> __device__ T f(); template<class U = int> __device__ U f() { return U(1); } __global__ void kernel() {}",
        "template<int N = 1> __device__ int f(); template<int M = 2> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N = 1> __device__ int f(); template<int M = 1> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<class T, class U> __device__ int f() { return 1; } template<class T, class U = T> __device__ int f(); __global__ void kernel() {}",
        "template<class T> __device__ int f(T value, int bias) { return bias; } template<class T> __device__ int f(T value, int bias = 3); __global__ void kernel() {}",
    ] { reject(source); }
}
