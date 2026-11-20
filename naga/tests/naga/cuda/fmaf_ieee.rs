use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_ieee_fmaf_aliases_preserve_fixed_signature_and_share_each_rounding_cache() {
    for mode in ["rn", "rz", "rd", "ru"] {
        let alias = format!("__fmaf_ieee_{mode}");
        let source = format!(
            "__host__ __device__ float {alias}(float,float,float);
            __device__ unsigned kind(float value) {{ return 1u; }}
            __device__ unsigned kind(int value) {{ return 2u; }}
            __global__ void kernel(unsigned *out,float x,float y,float z) {{
                out[0]=kind({alias}(x,y,z));
                out[1]=__float_as_uint({alias}(2,3u,true));
                out[2]=__float_as_uint(__fmaf_{mode}(x,y,z));
            }}"
        );
        let (module, info) = validate(&source);
        let name = format!("_naga_fmaf_{mode}");
        assert_eq!(
            module
                .functions
                .iter()
                .filter(|(_, function)| function.name.as_deref() == Some(name.as_str()))
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
fn cuda_ieee_fmaf_aliases_reject_bad_signatures_arity_types_and_constant_contexts() {
    for mode in ["rn", "rz", "rd", "ru"] {
        let alias = format!("__fmaf_ieee_{mode}");
        for source in [
            "__device__ int OP(float,float,float); __global__ void kernel() {}",
            "__device__ float OP(float x,float y,float z) { return x; } __global__ void kernel() {}",
            "__global__ void kernel() { OP(1.0f,2.0f); }",
            "__global__ void kernel(float *p) { OP(1.0f,p,2.0f); }",
            "__global__ void kernel() { constexpr float x=OP(1.0f,2.0f,3.0f); }",
        ] {
            let source=source.replace("OP",&alias);
            let error=parse_str(&source,&Options::default()).unwrap_err();
            let range=error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(),"{error}");
        }
    }
}
