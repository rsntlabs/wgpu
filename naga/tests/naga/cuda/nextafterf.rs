use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_nextafterf_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample nextafterf(Sample from, const Sample toward);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(int x, unsigned y) { return nextafterf(x, y); }
        __device__ int nextafterf(bool x, bool y) { return 7; }
        __global__ void kernel(unsigned *output, float x, float y) {
            output[0] = kind(nextafterf(x, y));
            output[1] = kind(converted(3, 4u));
            output[2] = kind(nextafterf(true, false));
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
fn cuda_nextafterf_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int nextafterf(float x, float y); __global__ void kernel() {}",
        "__device__ float nextafterf(float x, float y) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { nextafterf(1.0f); }",
        "__global__ void kernel() { nextafterf(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { nextafterf(input, 1.0f); }",
        "__global__ void kernel() { float2 v{1,2}; nextafterf(v, 1.0f); }",
        "__global__ void kernel() { constexpr float value = nextafterf(1.0f, 2.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
