use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};
use naga::front::cuda::{parse_str, Options};

const BUILTINS: [&str; 4] = ["__fadd_rd", "__fadd_ru", "__fsub_rd", "__fsub_ru"];

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    error
}

#[test]
fn cuda_directed_add_sub_accept_prototypes_conversions_and_result_overloads() {
    for builtin in BUILTINS {
        let source = "using F = float; __host__ __device__ F OP(const F, F);
            __device__ unsigned kind(float value) { return 1u; }
            __device__ unsigned kind(int value) { return 2u; }
            __device__ float converted(int a, unsigned b) { return OP(a,b); }
            __device__ int OP(bool a, bool b) { return 7; }
            __global__ void kernel(unsigned *out,float a,float b) {
                out[0]=kind(OP(a,b)); out[1]=kind(converted(3,4u)); out[2]=kind(OP(true,false));
            }"
        .replace("OP", builtin);
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
fn cuda_directed_add_sub_reject_invalid_signatures_arguments_and_hidden_names() {
    for builtin in BUILTINS {
        for source in [
            "__device__ int OP(float,float); __global__ void kernel() {}",
            "__device__ float OP(float a,float b) { return a; } __global__ void kernel() {}",
            "__global__ void kernel() { OP(); }",
            "__global__ void kernel() { OP(1.0f,2.0f,3.0f); }",
            "__global__ void kernel(float *p) { OP(p,1.0f); }",
            "__global__ void kernel() { float2 v{1,2}; OP(1.0f,v); }",
            "__global__ void kernel() { int OP=1; OP(1.0f,2.0f); }",
            "__global__ void kernel() { constexpr float x=OP(1.0f,2.0f); }",
        ] {
            reject(&source.replace("OP", builtin));
        }
    }
}

#[test]
fn cuda_directed_add_sub_evaluate_helper_arguments_and_volatile_reads_once() {
    for builtin in BUILTINS {
        let source = "__device__ float next(float x) { return x; }
            __device__ float read(const float &x) { return x; }
            __global__ void kernel(float *out) { float v=1.0f;
                out[0]=OP(next(v++),next(v++)); out[1]=OP(read(v),v++); out[2]=v; }"
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
        assert_eq!(calls, 2);
        let source = "__global__ void kernel(float *out,const volatile float *input) { out[0]=OP(input[0],input[1]); }".replace("OP",builtin);
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
        assert_eq!(loads, 2);
    }
}

#[test]
fn cuda_directed_add_sub_capture_results_before_later_mutation() {
    for builtin in BUILTINS {
        let source = "__device__ float pair(float a,float b) { return a+b; }
            __global__ void kernel(float *out) { float v=1.0f; out[0]=pair(OP(v,v),v++); }"
            .replace("OP", builtin);
        let (module, _) = validate(&source);
        let entry = &module.entry_points[0].function;
        let (position, argument) = entry
            .body
            .iter()
            .enumerate()
            .find_map(|(position, statement)| match statement {
                naga::Statement::Call {
                    function,
                    arguments,
                    ..
                } if module.functions[*function].name.as_deref() == Some("pair") => {
                    Some((position, arguments[0]))
                }
                _ => None,
            })
            .unwrap();
        let emitted=entry.body.iter().position(|statement| matches!(statement,naga::Statement::Emit(range) if range.clone().any(|handle| handle==argument))).unwrap();
        assert!(entry
            .body
            .iter()
            .take(position)
            .skip(emitted + 1)
            .any(|statement| matches!(statement, naga::Statement::Store { .. })));
    }
}

#[test]
fn cuda_directed_add_sub_share_per_mode_helpers_and_flip_only_subtraction_rhs() {
    for (add, sub, name) in [
        ("__fadd_rd", "__fsub_rd", "_naga_fadd_rd"),
        ("__fadd_ru", "__fsub_ru", "_naga_fadd_ru"),
    ] {
        let source=format!("__global__ void kernel(float *out,float x,float y) {{ out[0]={add}(x,y); out[1]={sub}(x,y); }}");
        let (module, _) = validate(&source);
        assert_eq!(module.functions.len(), 1);
        let (helper, function) = module.functions.iter().next().unwrap();
        assert_eq!(function.name.as_deref(), Some(name));
        assert!(function
            .arguments
            .iter()
            .all(|arg| module.types[arg.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)));
        let entry = &module.entry_points[0].function;
        let mut flips = 0;
        let mut calls = 0;
        naga::proc::any_statement(&entry.body, &mut |statement| {
            if let naga::Statement::Call {
                function,
                arguments,
                ..
            } = statement
            {
                assert_eq!(*function, helper);
                calls += 1;
                if let naga::Expression::Binary {
                    op: naga::BinaryOperator::ExclusiveOr,
                    right,
                    ..
                } = entry.expressions[arguments[1]]
                {
                    assert!(matches!(
                        entry.expressions[right],
                        naga::Expression::Literal(naga::Literal::U32(0x8000_0000))
                    ));
                    flips += 1;
                }
                assert!(!matches!(
                    entry.expressions[arguments[0]],
                    naga::Expression::Binary {
                        op: naga::BinaryOperator::ExclusiveOr,
                        ..
                    }
                ));
            }
            false
        });
        assert_eq!((calls, flips), (2, 1));
    }
}

#[test]
fn cuda_directed_add_sub_remap_distinct_modes_across_forward_helpers_and_entries() {
    let (module,_)=validate("__device__ float forward(float x,float y) { return __fsub_ru(x,y); }
        __global__ void first(float *out,float x,float y) { out[0]=__fadd_rd(x,y); out[1]=forward(x,y); }
        __global__ void second(float *out,float x,float y) { out[0]=__fsub_rd(x,y); out[1]=__fadd_ru(x,y); }");
    for name in ["_naga_fadd_rd", "_naga_fadd_ru"] {
        assert_eq!(
            module
                .functions
                .iter()
                .filter(|(_, function)| function.name.as_deref() == Some(name))
                .count(),
            1
        );
    }
}

#[test]
fn cuda_directed_add_sub_uniformity_requires_both_arguments_and_actual_cached_identity() {
    for builtin in BUILTINS {
        validate(
            &"__device__ float copied(const float &x,float y) { return OP(x,y); }
            __global__ void kernel(float value) { if(copied(value,value)>0.0f) __syncthreads(); }"
                .replace("OP", builtin),
        );
        for args in ["float(threadIdx.x),value", "value,float(threadIdx.x)"] {
            let error=reject(&format!("__global__ void kernel(float value) {{ if({builtin}({args})>0.0f) __syncthreads(); }}"));
            assert!(error.message.contains("barrier"), "{error}");
        }
    }
    for (builtin, name) in [
        ("__fadd_rd", "_naga_fadd_rd"),
        ("__fsub_ru", "_naga_fadd_ru"),
    ] {
        let error = reject(&format!(
            "__device__ unsigned {name}(unsigned a,unsigned b) {{ return a+b; }}
            __global__ void kernel(float value,float *out) {{ out[0]={builtin}(value,value);
                if({name}(1u,2u)>0u) __syncthreads(); }}"
        ));
        assert!(error.message.contains("barrier"), "{error}");
    }
}
