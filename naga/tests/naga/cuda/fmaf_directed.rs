use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};
use naga::front::cuda::{parse_str, Options};

const MODES: [(&str, &str); 2] = [
    ("__fmaf_rd", "_naga_fmaf_rd"),
    ("__fmaf_ru", "_naga_fmaf_ru"),
];

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    error
}

#[test]
fn cuda_directed_fmaf_accepts_fixed_signatures_conversions_and_user_overloads() {
    for (builtin, _) in MODES {
        let source = "using F=float; __host__ __device__ F OP(F,const F,F);
            __device__ unsigned kind(float x) { return 1u; } __device__ unsigned kind(int x) { return 2u; }
            __device__ float converted(int a,unsigned b,bool c) { return OP(a,b,c); }
            __device__ int OP(bool a,bool b,bool c) { return 7; }
            __global__ void kernel(unsigned *out,float x,float y,float z) {
                out[0]=kind(OP(x,y,z)); out[1]=kind(converted(2,3u,true)); out[2]=kind(OP(true,false,true));
            }".replace("OP",builtin);
        let (module, info) = validate(&source);
        let entry = &module.entry_points[0].function;
        let mut kinds = Vec::new();
        naga::proc::any_statement(&entry.body, &mut |statement| {
            if let naga::Statement::Call {
                function,
                arguments,
                ..
            } = statement
            {
                if module.functions[*function].name.as_deref() == Some("kind") {
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
}

#[test]
fn cuda_directed_fmaf_rejects_bad_signatures_arguments_shadowing_and_constants() {
    for (builtin, _) in MODES {
        for source in [
            "__device__ int OP(float,float,float); __global__ void kernel() {}",
            "__device__ float OP(float x,float y,float z) { return x; } __global__ void kernel() {}",
            "__global__ void kernel() { OP(1.0f,2.0f); }",
            "__global__ void kernel() { OP(1.0f,2.0f,3.0f,4.0f); }",
            "__global__ void kernel() { constexpr float value=OP(1.0f,2.0f,3.0f); }",
            "__global__ void kernel() { int OP; OP(1.0f,2.0f,3.0f); }",
        ] { reject(&source.replace("OP",builtin)); }
        for args in [
            "p,1.0f,2.0f",
            "1.0f,p,2.0f",
            "1.0f,2.0f,p",
            "v,1.0f,2.0f",
            "1.0f,v,2.0f",
            "1.0f,2.0f,v",
        ] {
            reject(&format!(
                "__global__ void kernel(float *p) {{ float2 v{{1,2}}; {builtin}({args}); }}"
            ));
        }
    }
}

#[test]
fn cuda_directed_fmaf_reads_each_argument_once_and_preserves_reference_helpers() {
    for (builtin, _) in MODES {
        let source = "__device__ float next(float x) { return x; }
            __device__ float read(const float &x) { return x; }
            __global__ void kernel(float *out) { float v = 1.0f;
                out[0] = OP(next(v++), next(v++), next(v++));
                out[1] = OP(read(v), v++, v++);
                out[2] = v;
            }"
        .replace("OP", builtin);
        let (module, _) = validate(&source);
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                if module.functions[*function].name.as_deref() == Some("next") {
                    calls += 1;
                }
            }
            false
        });
        assert_eq!(calls, 3);
        let source="__global__ void kernel(float *out,const volatile float *input) { out[0]=OP(input[0],input[1],input[2]); }".replace("OP",builtin);
        let (module, _) = validate_with_options_and_capabilities(
            &source,
            &Options::default(),
            naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
        );
        let entry = &module.entry_points[0].function;
        let loads = entry
            .expressions
            .iter()
            .filter(|(_, expression)| {
                let naga::Expression::Load { pointer } = **expression else {
                    return false;
                };
                let naga::Expression::GlobalVariable(global) =
                    entry.expressions[root_expression(entry, pointer)]
                else {
                    return false;
                };
                module.global_variables[global].binding
                    == Some(naga::ResourceBinding {
                        group: 0,
                        binding: 1,
                    })
            })
            .count();
        assert_eq!(loads, 3);
    }
}

#[test]
fn cuda_directed_fmaf_uses_distinct_integer_caches_after_forward_remapping() {
    let (module,_)=validate("__device__ float forward(float x,float y,float z) { return __fmaf_ru(x,y,z); }
        __global__ void first(float *out,float x,float y,float z) { out[0]=__fmaf_rd(x,y,z); out[1]=forward(x,y,z); }
        __global__ void second(float *out,float x,float y,float z) { out[0]=__fmaf_rd(x,y,z); out[1]=__fmaf_ru(x,y,z); }");
    for (_, name) in MODES {
        let helpers: Vec<_> = module
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some(name))
            .collect();
        assert_eq!(helpers.len(), 1);
        let helper = helpers[0].1;
        assert_eq!(helper.arguments.len(), 3);
        assert!(helper
            .arguments
            .iter()
            .all(|a| module.types[a.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)));
        assert_eq!(
            module.types[helper.result.as_ref().unwrap().ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
}

#[test]
fn cuda_directed_fmaf_uniformity_checks_all_three_arguments_and_exact_cache_identity() {
    for (builtin, name) in MODES {
        validate(&"__device__ float copied(const float &x,float y,float z) { return OP(x,y,z); }
            __global__ void kernel(float value) { if(copied(value,value,value)>0.0f) __syncthreads(); }".replace("OP",builtin));
        for args in [
            "float(threadIdx.x),value,value",
            "value,float(threadIdx.x),value",
            "value,value,float(threadIdx.x)",
        ] {
            let error=reject(&format!("__global__ void kernel(float value) {{ if({builtin}({args})>0.0f) __syncthreads(); }}"));
            assert!(error.message.contains("barrier"), "{error}");
        }
        let error=reject(&format!("__device__ unsigned {name}(unsigned x,unsigned y,unsigned z) {{ return x+y+z; }}
            __global__ void kernel(float value,float *out) {{ out[0]={builtin}(value,value,value); if({name}(1u,2u,3u)>0u) __syncthreads(); }}"));
        assert!(error.message.contains("barrier"), "{error}");
    }
}
