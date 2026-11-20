use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_fast_trigonometry_uses_fixed_float_signatures_and_shared_trig_cache() {
    for (fast, ordinary) in [("__sinf", "sinf"), ("__cosf", "cosf")] {
        let source=format!("__host__ __device__ float {fast}(float);
            __device__ unsigned kind(float x) {{ return 1u; }} __device__ unsigned kind(int x) {{ return 2u; }}
            __device__ float converted(int x) {{ return {fast}(x); }}
            __device__ int {fast}(int x) {{ return 7; }}
            __global__ void kernel(unsigned *out,float x) {{
                out[0]=kind({fast}(x)); out[1]=__float_as_uint(converted(3));
                out[2]=unsigned({fast}(3)); out[3]=__float_as_uint({ordinary}(x));
            }}");
        let (module, info) = validate(&source);
        assert_eq!(
            module
                .functions
                .iter()
                .filter(|(_, f)| f.name.as_deref() == Some("_naga_trigonometry"))
                .count(),
            1
        );
        let entry = &module.entry_points[0].function;
        naga::proc::any_statement(&entry.body, &mut |statement| {
            if let naga::Statement::Call {
                function,
                arguments,
                ..
            } = statement
            {
                if module.functions[*function].name.as_deref() == Some("kind") {
                    assert_eq!(
                        info.get_entry_point(0)[arguments[0]]
                            .ty
                            .inner_with(&module.types),
                        &naga::TypeInner::Scalar(naga::Scalar::F32)
                    );
                }
            }
            false
        });
    }
}

#[test]
fn cuda_fast_trigonometry_rejects_invalid_declarations_arguments_and_constant_contexts() {
    for builtin in ["__sinf", "__cosf"] {
        for source in [
            "__device__ int OP(float); __global__ void kernel() {}",
            "__device__ float OP(float x) { return x; } __global__ void kernel() {}",
            "__global__ void kernel() { OP(); }",
            "__global__ void kernel() { OP(1.0f,2.0f); }",
            "__global__ void kernel(float *p) { OP(p); }",
            "__global__ void kernel() { float2 v{1,2}; OP(v); }",
            "__global__ void kernel() { constexpr float value=OP(1.0f); }",
        ] {
            let source = source.replace("OP", builtin);
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
    }
}

#[test]
fn cuda_fast_trigonometry_preserves_cached_helper_uniformity() {
    for builtin in ["__sinf", "__cosf"] {
        validate(&format!(
            "__global__ void kernel(float value) {{ if({builtin}(value)>0.0f) __syncthreads(); }}"
        ));
        let error=parse_str(&format!("__global__ void kernel() {{ if({builtin}(float(threadIdx.x))>0.0f) __syncthreads(); }}"),&Options::default()).unwrap_err();
        assert!(error.message.contains("barrier"), "{error}");
    }
}
