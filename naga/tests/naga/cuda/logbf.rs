use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_logbf_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample logbf(const Sample value);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(unsigned x) { return logbf(x); }
        __device__ int logbf(bool x) { return 7; }
        __global__ void kernel(unsigned *output, float x) {
            output[0] = kind(logbf(x));
            output[1] = kind(converted(3u));
            output[2] = kind(logbf(true));
        }",
    );
    let function = &module.entry_points[0].function;
    let mut kinds = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: callee,
            arguments,
            ..
        } = statement
        {
            if module.functions[*callee].name.as_deref() == Some("kind") {
                kinds.push(
                    info.get_entry_point(0)[arguments[0]]
                        .ty
                        .inner_with(&module.types)
                        .clone(),
                );
            }
        }
        false
    });
    assert_eq!(
        kinds,
        [
            naga::TypeInner::Scalar(naga::Scalar::F32),
            naga::TypeInner::Scalar(naga::Scalar::F32),
            naga::TypeInner::Scalar(naga::Scalar::I32)
        ]
    );
}

#[test]
fn cuda_logbf_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int logbf(float x); __global__ void kernel() {}",
        "__device__ float logbf(float x) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { logbf(); }",
        "__global__ void kernel() { logbf(1.0f, 2.0f); }",
        "__global__ void kernel(float *input) { logbf(input); }",
        "__global__ void kernel() { float2 v{1,2}; logbf(v); }",
        "__global__ void kernel() { constexpr float value = logbf(1.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}

#[test]
fn cuda_logbf_literal_zero_runtime_results_roundtrip_wgsl() {
    let (module, info) = validate(
        "__global__ void kernel(unsigned *output) {
        output[0] = __float_as_uint(logbf(0.0f));
        output[1] = __float_as_uint(logbf(-0.0f));
        output[2] = __float_as_uint(logbf(0));
        output[3] = __float_as_uint(logbf(0u));
    }",
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}
