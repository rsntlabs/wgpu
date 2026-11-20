use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_fdividef_accepts_canonical_float_signature_conversions_and_user_overloads() {
    let (module, info) = validate(
        "using Sample = float;
        __host__ __device__ Sample __fdividef(Sample from, const Sample toward);
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __device__ float converted(int x, unsigned y) { return __fdividef(x, y); }
        __device__ int __fdividef(bool x, bool y) { return 7; }
        __global__ void kernel(unsigned *output, float x, float y) {
            output[0] = kind(__fdividef(x, y));
            output[1] = kind(converted(3, 4u));
            output[2] = kind(__fdividef(true, false));
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
fn cuda_fdividef_rejects_wrong_signatures_calls_and_constant_contexts() {
    for source in [
        "__device__ int __fdividef(float x, float y); __global__ void kernel() {}",
        "__device__ float __fdividef(float x, float y) { return x; } __global__ void kernel() {}",
        "__global__ void kernel() { __fdividef(1.0f); }",
        "__global__ void kernel() { __fdividef(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { __fdividef(input, 1.0f); }",
        "__global__ void kernel() { float2 v{1,2}; __fdividef(v, 1.0f); }",
        "__global__ void kernel() { constexpr float value = __fdividef(1.0f, 2.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}

#[test]
fn cuda_fdividef_shares_exact_rn_division_cache_after_remapping() {
    let (module, info) = validate("__device__ float forward(float x,float y) { return __fdividef(x,y); }
        __global__ void first(unsigned *out,float x,float y) {
            out[0]=__float_as_uint(__fdiv_rn(x,y)); out[1]=__float_as_uint(forward(x,y));
        }
        __global__ void second(unsigned *out,float x,float y) { out[0]=__float_as_uint(__fdividef(x,y)); }");
    assert_eq!(
        module
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some("_naga_divide_f32"))
            .count(),
        1
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}
