use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_ldexpf_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample ldexpf(Sample from, const int power);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(int x, unsigned y) { return ldexpf(x, y); }
        __device__ int ldexpf(bool x, bool y) { return 7; }
        __global__ void kernel(unsigned *output, float x, int y) {
            output[0] = kind(ldexpf(x, y));
            output[1] = kind(converted(3, 4u));
            output[2] = kind(ldexpf(true, false));
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
fn cuda_ldexpf_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int ldexpf(float x, int y); __global__ void kernel() {}",
        "__device__ float ldexpf(float x, int y) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { ldexpf(1.0f); }",
        "__global__ void kernel() { ldexpf(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { ldexpf(input, 1.0f); }",
        "__global__ void kernel() { float2 v{1,2}; ldexpf(v, 1.0f); }",
        "__global__ void kernel() { constexpr float value = ldexpf(1.0f, 2); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
