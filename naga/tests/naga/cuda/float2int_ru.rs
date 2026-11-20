use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_float2int_ru_accepts_float_prototypes_conversions_and_returns_int() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ int __float2int_ru(const Sample value);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ int converted(unsigned value) { return __float2int_ru(value); }
        __device__ float __float2int_ru(bool value) { return 3.0f; }
        __global__ void kernel(unsigned *output, float value) {
            output[0] = kind(__float2int_ru(value));
            output[1] = kind(converted(3u));
            output[2] = kind(__float2int_ru(true));
            output[3] = __float_as_uint(ceilf(value));
        }",
    );
    let function = &module.entry_points[0].function;
    let mut kinds = Vec::new();
    let mut ceilings = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: callee,
            arguments,
            ..
        } = statement
        {
            let name = module.functions[*callee].name.as_deref();
            if name == Some("_naga_ceilf") {
                ceilings.push(*callee);
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
    assert_eq!(ceilings.len(), 2);
    assert_eq!(ceilings[0], ceilings[1]);
    assert_eq!(
        kinds,
        [
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::F32)
        ]
    );
}

#[test]
fn cuda_float2int_ru_rejects_wrong_declarations_arguments_and_constant_contexts() {
    for source in [
        "__device__ float __float2int_ru(float x); __global__ void kernel() {}",
        "__device__ int __float2int_ru(float x) { return 1; } __global__ void kernel() {}",
        "__global__ void kernel() { __float2int_ru(); }",
        "__global__ void kernel() { __float2int_ru(1.0f, 2.0f); }",
        "__global__ void kernel(float *input) { __float2int_ru(input); }",
        "__global__ void kernel() { float2 value{1,2}; __float2int_ru(value); }",
        "__global__ void kernel() { constexpr int value = __float2int_ru(1.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
