use naga::front::cuda::{parse_str, Options};

use super::helpers::{validate, validate_with_options_and_capabilities};

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

fn calls(module: &naga::Module) -> Vec<naga::Handle<naga::Function>> {
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    calls
}

#[test]
fn cuda_dependent_integral_defaults_complete_interleaved_chains_and_share_instances() {
    let (module, _) = validate(
        "template<int N = 4, class T = unsigned, int M = N, unsigned K = M> __device__ unsigned value() { return K; }
        __global__ void kernel(unsigned *out) {
            out[0] = value<>(); out[1] = value<4>(); out[2] = value<4, unsigned, 4, 4u>(); out[3] = value<4, unsigned, 9>();
        }",
    );
    let calls = calls(&module);
    assert_eq!(calls.len(), 4);
    assert_eq!(calls[0], calls[1]);
    assert_eq!(calls[0], calls[2]);
    assert_ne!(calls[0], calls[3]);
}

#[test]
fn cuda_dependent_integral_defaults_merge_by_index_across_renamed_declarations() {
    validate(
        "template<int N, int M> __device__ int value() { return M; }
        template<int First, int Second = First> __device__ int value();
        __global__ void kernel(int *out) { out[0] = value<7>(); }",
    );
    validate(
        "constexpr int N = 4;
        template<int N = N, int M = N> __device__ int value() { return M; }
        __global__ void kernel(int *out) { out[0] = value<>(); out[1] = value<9>(); }",
    );
}

#[test]
fn cuda_dependent_integral_defaults_use_checked_target_conversions() {
    validate_with_options_and_capabilities(
        "template<int N, bool B = N> __device__ unsigned boolean() { return unsigned(B); }
        template<unsigned N, short M = N> __device__ int narrowed() { return M; }
        template<bool B, unsigned N = B> __device__ unsigned widened() { return N; }
        __global__ void kernel(unsigned *out) { out[0] = boolean<0>(); out[1] = boolean<1>(); out[2] = unsigned(narrowed<32767u>()); out[3] = widened<true>(); }",
        &Options::default(),
        naga::valid::Capabilities::SHADER_INT16,
    );
    for declaration in [
        "template<int N, bool B = N> __device__ unsigned value() { return unsigned(B); }",
        "template<int N, unsigned M = N> __device__ unsigned value() { return M; }",
    ] {
        for argument in ["-1", "2"] {
            if argument == "2" && declaration.contains("unsigned M") {
                continue;
            }
            reject(&format!("{declaration} __global__ void kernel(unsigned *out) {{ out[0] = value<{argument}>(); }}"));
        }
    }
    reject("template<unsigned N, short M = N> __device__ int value() { return M; } __global__ void kernel(int *out) { out[0] = value<32768u>(); }");
}

#[test]
fn cuda_dependent_integral_defaults_remove_invalid_candidates_before_overload_ranking() {
    let (module, _) = validate(
        "template<int N = -1, unsigned M = N> __device__ unsigned choose(int input) { return M; }
        __device__ unsigned choose(float input) { return 77u; }
        __global__ void kernel(unsigned *out) { out[0] = choose(1); }",
    );
    let calls = calls(&module);
    assert_eq!(calls.len(), 1);
    let function = &module.functions[calls[0]];
    assert!(function.body.iter().any(|statement| matches!(statement, naga::Statement::Return { value: Some(value) } if matches!(function.expressions[*value], naga::Expression::Literal(naga::Literal::U32(77))))));
}

#[test]
fn cuda_dependent_integral_defaults_preserve_source_order_and_no_backward_inference() {
    for source in [
        "template<int N, int M> __device__ int value() { return M; } __device__ int before() { return value<3>(); } template<int N, int M = N> __device__ int value(); __global__ void kernel() {}",
        "template<int N, int M> __device__ int value() { return M; } template<class T> __device__ int before(T input) { return value<3>(); } template<int N, int M = N> __device__ int value(); __global__ void kernel(int *out) { out[0] = before(1); }",
        "#define Invoke value<3>()\n#define Default N\ntemplate<int N, int M> __device__ int value() { return M; } template<class T> __device__ int before(T input) { return Invoke; } template<int N, int M = Default> __device__ int value(); __global__ void kernel(int *out) { out[0] = before(1); }",
        "template<int N, int M = N> __device__ int value(int input) { return M; } __global__ void kernel(int *out) { out[0] = value(3); }",
    ] { reject(source); }
}

#[test]
fn cuda_dependent_integral_defaults_reject_nondirect_forms_and_redefaults() {
    for default in ["(N)", "N + 0", "int(N)", "sizeof(N)", "false ? N : 3"] {
        reject(&format!("template<int N, int M = {default}> __device__ int value() {{ return M; }} __global__ void kernel() {{}}"));
    }
    reject("template<int N, int M = N> __device__ int value(); template<int A, int B = A> __device__ int value() { return B; } __global__ void kernel() {}");
    reject("template<class T, int N = T> __device__ int value() { return N; } __global__ void kernel() {}");
}

#[test]
fn cuda_dependent_integral_defaults_normalize_kernel_chains_and_reject_duplicates() {
    let (module, _) = validate(
        "template<int N = 3, int M = N, unsigned K = M> __global__ void filled(unsigned *out) { out[0] = K; }
        template __global__ void filled<>(unsigned *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "filled<3,3,3u>");
    reject("template<int N = 3, int M = N> __global__ void filled(unsigned *out) { out[0] = unsigned(M); } template __global__ void filled<>(unsigned *); template __global__ void filled<3,3>(unsigned *);");
}

#[test]
fn cuda_dependent_integral_defaults_check_wide_boundaries_and_explicit_overrides() {
    let (module, _) = validate_with_options_and_capabilities(
        "template<unsigned long long N, long long M = N> __device__ unsigned signed_target() { return 1u; }
        template<long long N, unsigned long long M = N> __device__ unsigned unsigned_target() { return 2u; }
        template<long N, long long M = N> __device__ unsigned identity() { return 3u; }
        template<int N, unsigned M = N> __device__ unsigned overridden() { return M; }
        __global__ void kernel(unsigned *out) {
            out[0] = signed_target<9223372036854775807ULL>();
            out[1] = unsigned_target<0LL>();
            out[2] = identity<7L>(); out[3] = identity<7L, 7LL>();
            out[4] = overridden<-1, 9u>();
        }",
        &Options::default(),
        naga::valid::Capabilities::SHADER_INT64,
    );
    let calls = calls(&module);
    assert_eq!(calls.len(), 5);
    assert_eq!(
        calls[2], calls[3],
        "conversion must normalize to the target's long-long identity"
    );
    for (_, function) in module.functions.iter() {
        assert!(
            function.arguments.is_empty(),
            "wide values remain template arguments"
        );
        assert!(function.expressions.iter().all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Literal(naga::Literal::I64(_) | naga::Literal::U64(_))
        )));
    }
    reject("template<unsigned long long N, long long M = N> __device__ unsigned value() { return 1u; } __global__ void kernel(unsigned *out) { out[0] = value<9223372036854775808ULL>(); }");
    reject("template<long long N, unsigned long long M = N> __device__ unsigned value() { return 1u; } __global__ void kernel(unsigned *out) { out[0] = value<-1LL>(); }");
}
