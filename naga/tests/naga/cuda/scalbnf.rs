use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_scalbnf_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample scalbnf(Sample from, const int power);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(int x, unsigned y) { return scalbnf(x, y); }
        __device__ int scalbnf(bool x, bool y) { return 7; }
        __global__ void kernel(unsigned *output, float x, int y) {
            output[0] = kind(scalbnf(x, y));
            output[1] = kind(converted(3, 4u));
            output[2] = kind(scalbnf(true, false));
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
fn cuda_scalbnf_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int scalbnf(float x, int y); __global__ void kernel() {}",
        "__device__ float scalbnf(float x, int y) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { scalbnf(1.0f); }",
        "__global__ void kernel() { scalbnf(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { scalbnf(input, 1.0f); }",
        "__global__ void kernel() { float2 v{1,2}; scalbnf(v, 1.0f); }",
        "__global__ void kernel() { constexpr float value = scalbnf(1.0f, 2); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}

#[test]
fn cuda_scalbnf_and_ldexpf_share_one_remapped_integer_helper() {
    let (module, _) = validate(
        "__device__ float forwarded(float x, int e) { return scalbnf(x, e); }
        __global__ void first(unsigned *output, float x, int e) {
            output[0] = __float_as_uint(ldexpf(x, e));
            output[1] = __float_as_uint(forwarded(x, e));
        }
        __global__ void second(unsigned *output, float x, int e) {
            output[0] = __float_as_uint(scalbnf(x, e));
        }",
    );
    let helpers: Vec<_> = module
        .functions
        .iter()
        .filter(|(_, f)| f.name.as_deref() == Some("_naga_ldexpf"))
        .collect();
    assert_eq!(helpers.len(), 1);
    let (_, helper) = helpers[0];
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
}
