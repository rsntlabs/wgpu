use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_remainderf_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample remainderf(Sample dividend, const Sample divisor);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(int x, unsigned y) { return remainderf(x, y); }
        __device__ int remainderf(bool x, bool y) { return 7; }
        __global__ void kernel(unsigned *output, float x, float y) {
            output[0] = kind(remainderf(x, y));
            output[1] = kind(converted(3, 4u));
            output[2] = kind(remainderf(true, false));
            output[3] = __float_as_uint(fmodf(x, y));
        }",
    );
    for name in ["_naga_fmodf", "_naga_remainderf"] {
        assert_eq!(
            module
                .functions
                .iter()
                .filter(|&(_, candidate)| candidate.name.as_deref() == Some(name))
                .count(),
            1
        );
    }
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
fn cuda_remainderf_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int remainderf(float x, float y); __global__ void kernel() {}",
        "__device__ float remainderf(float x, float y) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { remainderf(1.0f); }",
        "__global__ void kernel() { remainderf(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { remainderf(input, 1.0f); }",
        "__global__ void kernel() { float2 v{1,2}; remainderf(v, 1.0f); }",
        "__global__ void kernel() { constexpr float value = remainderf(1.0f, 2.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
