use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

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
fn cuda_integral_template_defaults_accept_fixed_values_and_reuse_instances() {
    let module = validate("template<int N = 7> __device__ int value() { return N; }
        __global__ void kernel(int *out) { out[0] = value(); out[1] = value<>(); out[2] = value<7>(); }");
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    assert_eq!(calls.len(), 3);
    assert_eq!(calls[0], calls[1]);
    assert_eq!(calls[1], calls[2]);
}

#[test]
fn cuda_integral_template_defaults_freeze_bindings_and_merge_renamed_definitions() {
    validate("constexpr int N = 4;
        #define DEFAULT_VALUE (2 + 3)
        template<int N = N> __device__ int self_named() { return N; }
        template<int Count = DEFAULT_VALUE> __device__ int inherited();
        template<int Renamed> __device__ int inherited() { return Renamed; }
        template<int Value = (true ? 1, 2 : 3)> __device__ int comma_value() { return Value; }
        template<int Value = (8 >> 1)> __device__ int shifted() { return Value; }
        __global__ void kernel(int *out) { constexpr int N = 99; out[0] = self_named(); out[1] = inherited(); out[2] = comma_value(); out[3] = shifted(); }");
}

#[test]
fn cuda_integral_template_defaults_mix_types_nontrailing_values_and_conversions() {
    validate("template<int N = 3, class T> __device__ T add(T value) { return value + T(N); }
        template<class T = unsigned, int N = 5> __device__ T mixed() { return T(N); }
        template<bool B = bool(2), unsigned N = unsigned(4)> __device__ unsigned flags() { return unsigned(B) + N; }
        template<int N = static_cast<int>(3.75f)> __device__ int cast_value() { return N; }
        __global__ void kernel(unsigned *out) { out[0] = unsigned(add(2)); out[1] = unsigned(add<7>(3u)); out[2] = mixed(); out[3] = mixed<int, 8>(); out[4] = flags(); out[5] = unsigned(cast_value()); }");
    validate_with_options_and_capabilities(
        "using Small = unsigned short; using Word = long;
        template<Small N = 65535> __device__ unsigned small() { return unsigned(N); }
        template<Word N = 7> __device__ long word() { return N; }
        __global__ void kernel(long *out) { out[0] = word(); out[1] = long(small()); }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_integral_template_defaults_support_kernel_defaults_and_normalization() {
    let module = validate(
        "template<int N = 7> __global__ void filled(int *output);
        template<int Renamed> __global__ void filled(int *output) { output[0] = Renamed; }
        template __global__ void filled<>(int *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "filled<7>");
    reject("template<int N = 7> __global__ void filled(int *output) { output[0] = N; } template __global__ void filled<>(int *); template __global__ void filled<7>(int *);");
}

#[test]
fn cuda_integral_template_defaults_skip_runtime_work_without_leaking_builtins() {
    let module = validate(
        "__device__ int opaque() { return 3; }
        template<bool B = (true || threadIdx.x)> __device__ int first() { return int(B); }
        template<bool B = (false && gridDim.x)> __device__ int second() { return int(B); }
        template<bool B = (true || opaque())> __device__ int third() { return int(B); }
        __global__ void kernel(int *output) { output[0] = first() + second() + third(); }",
    );
    assert_eq!(
        module.global_variables.len(),
        1,
        "only output storage should exist"
    );
    let (_, output) = module.global_variables.iter().next().unwrap();
    assert_eq!(
        output.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    assert_eq!(
        output.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    assert!(output.init.is_none());
    assert_eq!(module.entry_points[0].function.arguments.len(), 0);
    for source in [
        "template<bool B = bool(threadIdx.x)> __device__ int f() { return int(B); } __global__ void kernel() {}",
        "template<int N> __device__ int g() { return int(gridDim.x); } template<bool B = (true || g<0>())> __device__ int f() { return int(B); } __global__ void kernel() {}",
        "__device__ int opaque() { return 1; } template<int N = opaque()> __device__ int f() { return N; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_integral_template_defaults_preserve_overload_ranking_and_reference_effects() {
    validate("__device__ int choose(int value) { return value + 10; }
        template<int N = 20, class T> __device__ int choose(T value) { return int(value) + N; }
        template<int Amount = 2> __device__ int bump(int &value) { int old = value; value += Amount; return old; }
        __global__ void kernel(int *out) { int value = 1; out[0] = choose(1); out[1] = choose(1u); out[2] = choose<>(1); out[3] = bump(value); false && bump(value); bump<3>(value); out[4] = value; }");
    reject("template<int N = 1> __device__ int f() { return N; } template<int N = 1, int M = 2> __device__ int f() { return N + M; } __global__ void kernel(int *out) { out[0] = f<>(); }");
}

#[test]
fn cuda_integral_template_defaults_reject_dependent_invalid_and_redeclared_defaults() {
    for source in [
        "template<int N = 1> __device__ int f(); template<int M = 1> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M> __device__ int f(); template<int N, int M = (N)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M = (N)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M = sizeof(N)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M = (false ? N : 3)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M = ((void)N, 3)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<class T, int M = sizeof(T)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N = 1.0f> __device__ int f() { return N; } __global__ void kernel() {}",
        "template<bool B = 2> __device__ int f() { return int(B); } __global__ void kernel() {}",
        "template<bool B = -1> __device__ int f() { return int(B); } __global__ void kernel() {}",
        "template<unsigned short N = 65536> __device__ int f() { return int(N); } __global__ void kernel() {}",
        "template<int N = unknown> __device__ int f() { return N; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_integral_template_defaults_bound_scanning_ranges_and_member_names() {
    validate("template<int A = (2 > 1), int B = (8 >> 1), int C = 3> __device__ int bounded() { return A + B + C; }
        struct R { int N; }; __constant__ R object;
        template<int N, int M = sizeof(object.N)> __device__ int member_size() { return M; }
        __global__ void kernel(int *out) { out[0] = bounded(); out[1] = member_size<7>(); }");
    validate_with_options_and_capabilities(
        "template<unsigned long long N = 18446744073709551615ULL> __device__ unsigned long long largest() { return N; }
        __global__ void kernel(unsigned long long *out) { out[0] = largest(); out[1] = largest<18446744073709551615ULL>(); }",
        &Options::default(), Capabilities::SHADER_INT64,
    );
    for source in [
        "template<unsigned N = -1> __device__ unsigned f() { return N; } __global__ void kernel() {}",
        "template<long long N = 18446744073709551615ULL> __device__ long long f() { return N; } __global__ void kernel() {}",
        "template<int N = (2 > 1> __device__ int f() { return N; } __global__ void kernel() {}",
        "template<int N = (8 >> 1], int M = 2> __device__ int f() { return N; } __global__ void kernel() {}",
        "template<int N = , int M = 2> __device__ int f() { return N; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_integral_template_defaults_preserve_namespace_qualifier_lookup() {
    let module = validate(
        "namespace N = cooperative_groups;
        template<int N, bool B = (true || N::this_thread_block().thread_rank())>
        __device__ int f() { return int(B); }
        __global__ void kernel(int *output) { output[0] = f<7>(); }",
    );
    assert_eq!(module.global_variables.len(), 1);
    let (_, output) = module.global_variables.iter().next().unwrap();
    assert_eq!(
        output.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    assert_eq!(
        output.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    assert!(output.init.is_none());
    assert!(module.entry_points[0].function.arguments.is_empty());
    reject("template<class T, bool B = (true || T::this_thread_block().thread_rank())> __device__ int f() { return int(B); } __global__ void kernel() {}");
}
