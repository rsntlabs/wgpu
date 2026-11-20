use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_float2uint_rn_accepts_float_prototypes_conversions_and_returns_unsigned() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ unsigned __float2uint_rn(const Sample value);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(unsigned value) { return 2u; }
        __device__ unsigned converted(unsigned value) { return __float2uint_rn(value); }
        __device__ float __float2uint_rn(bool value) { return 3.0f; }
        __global__ void kernel(unsigned *output, float value) {
            output[0] = kind(__float2uint_rn(value));
            output[1] = kind(converted(3u));
            output[2] = kind(__float2uint_rn(true));
            output[3] = __float_as_uint(rintf(value));
        }",
    );
    let function = &module.entry_points[0].function;
    let mut kinds = Vec::new();
    let mut floors = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: callee,
            arguments,
            ..
        } = statement
        {
            let name = module.functions[*callee].name.as_deref();
            if name == Some("_naga_rintf") {
                floors.push(*callee);
            }
            if name == Some("kind") {
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
    assert_eq!(floors.len(), 2);
    assert_eq!(floors[0], floors[1]);
    assert_eq!(
        kinds,
        [
            naga::TypeInner::Scalar(naga::Scalar::U32),
            naga::TypeInner::Scalar(naga::Scalar::U32),
            naga::TypeInner::Scalar(naga::Scalar::F32)
        ]
    );
}

#[test]
fn cuda_float2uint_rn_rejects_wrong_declarations_arguments_and_constant_contexts() {
    for source in [
        "__device__ float __float2uint_rn(float x); __global__ void kernel() {}",
        "__device__ unsigned __float2uint_rn(float x) { return 1; } __global__ void kernel() {}",
        "__global__ void kernel() { __float2uint_rn(); }",
        "__global__ void kernel() { __float2uint_rn(1.0f, 2.0f); }",
        "__global__ void kernel(float *input) { __float2uint_rn(input); }",
        "__global__ void kernel() { float2 value{1,2}; __float2uint_rn(value); }",
        "__global__ void kernel() { constexpr unsigned value = __float2uint_rn(1.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
