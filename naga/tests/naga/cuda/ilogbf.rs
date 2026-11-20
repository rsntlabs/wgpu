use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_ilogbf_accepts_float_prototypes_conversions_and_returns_int() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ int ilogbf(const Sample value);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ int converted(unsigned value) { return ilogbf(value); }
        __device__ float ilogbf(bool value) { return 3.0f; }
        __global__ void kernel(unsigned *output, float value) {
            output[0] = kind(ilogbf(value));
            output[1] = kind(converted(3u));
            output[2] = kind(ilogbf(true));
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
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::F32)
        ]
    );
}

#[test]
fn cuda_ilogbf_rejects_wrong_declarations_arguments_and_constant_contexts() {
    for source in [
        "__device__ float ilogbf(float x); __global__ void kernel() {}",
        "__device__ int ilogbf(float x) { return 1; } __global__ void kernel() {}",
        "__global__ void kernel() { ilogbf(); }",
        "__global__ void kernel() { ilogbf(1.0f, 2.0f); }",
        "__global__ void kernel(float *input) { ilogbf(input); }",
        "__global__ void kernel() { float2 value{1,2}; ilogbf(value); }",
        "__global__ void kernel() { constexpr int value = ilogbf(1.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}
