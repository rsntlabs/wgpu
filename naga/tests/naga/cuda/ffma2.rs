use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_ffma2_uses_fixed_vector_signature_and_shared_scalar_rounding_helper_per_lane() {
    for mode in ["rn", "rz", "rd", "ru"] {
        let name = format!("__ffma2_{mode}");
        let source=format!("__host__ __device__ float2 {name}(float2,const float2,float2);
            __device__ unsigned kind(float2 x) {{ return 2u; }} __device__ unsigned kind(float x) {{ return 1u; }}
            __device__ int {name}(int a,int b,int c) {{ return a+b+c; }}
            __global__ void kernel(unsigned *out,float2 a,float2 b,float2 c) {{
                float2 value={name}(a,b,c); out[0]=kind(value);
                out[1]=__float_as_uint(value.x); out[2]=__float_as_uint(value.y);
                out[3]=__float_as_uint(__fmaf_{mode}(a.x,b.x,c.x));
                out[4]=unsigned({name}(1,2,3));
            }}");
        let (module, info) = validate(&source);
        let helper_name = format!("_naga_fmaf_{mode}");
        let helpers: Vec<_> = module
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some(helper_name.as_str()))
            .collect();
        assert_eq!(helpers.len(), 1);
        let helper = helpers[0].0;
        let entry = &module.entry_points[0].function;
        let mut calls = 0;
        naga::proc::any_statement(&entry.body, &mut |statement| {
            if let naga::Statement::Call {
                function,
                arguments,
                ..
            } = statement
            {
                if *function == helper {
                    calls += 1;
                }
                if module.functions[*function].name.as_deref() == Some("kind") {
                    assert_eq!(
                        info.get_entry_point(0)[arguments[0]]
                            .ty
                            .inner_with(&module.types),
                        &naga::TypeInner::Vector {
                            size: naga::VectorSize::Bi,
                            scalar: naga::Scalar::F32
                        }
                    );
                }
            }
            false
        });
        assert_eq!(calls, 3);
    }
}

#[test]
fn cuda_ffma2_rejects_scalar_splats_wrong_shapes_and_invalid_declarations() {
    for mode in ["rn", "rz", "rd", "ru"] {
        let name = format!("__ffma2_{mode}");
        for args in [
            "1.0f,b,c", "a,1.0f,c", "a,b,1.0f", "v,b,c", "a,i,c", "a,p,c", "a,b", "a,b,c,a",
        ] {
            let source=format!("__global__ void kernel(float2 a,float2 b,float2 c,float *p) {{ float4 v{{1,2,3,4}}; int2 i{{1,2}}; {name}({args}); }}");
            assert!(parse_str(&source, &Options::default()).is_err(), "{source}");
        }
        for source in [
            "__device__ float OP(float2,float2,float2); __global__ void kernel() {}",
            "__device__ float2 OP(float2 a,float2 b,float2 c) { return a; } __global__ void kernel() {}",
            "__global__ void kernel() { constexpr float2 a{1,2}; constexpr float2 value=OP(a,a,a); }",
        ] { assert!(parse_str(&source.replace("OP",&name),&Options::default()).is_err()); }
    }
}

#[test]
fn cuda_ffma2_barrier_controls_require_uniform_operands() {
    for mode in ["rn", "rz", "rd", "ru"] {
        let name = format!("__ffma2_{mode}");
        let source = |args: [&str; 3]| {
            let args = args.join(",");
            format!(
                "__global__ void kernel(float value) {{
                    if ({name}({args}).y > 0.0f) __syncthreads();
                }}"
            )
        };
        let uniform = "make_float2(value, value)";
        validate(&source([uniform; 3]));
        for index in 0..3 {
            let mut args = [uniform; 3];
            args[index] = "make_float2(value, float(threadIdx.x))";
            let error = parse_str(&source(args), &Options::default()).unwrap_err();
            assert!(error.message.contains("barrier"), "{error}");
        }
    }
}
