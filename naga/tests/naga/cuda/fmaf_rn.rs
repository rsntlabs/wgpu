use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_fmaf_rn_accepts_float_alias_prototypes_and_returns_float_bits() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ Sample __fmaf_rn(const Sample magnitude, Sample sign, Sample addend);
        __device__ int kind(float value) { return 1; } __device__ int kind(int value) { return 2; }
        __global__ void kernel(int *out, Sample x, Sample y) { out[0] = kind(__fmaf_rn(x, y, x)); }",
    );
    let function = &module.entry_points[0].function;
    let mut calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: callee,
            arguments,
            ..
        } = statement
        {
            if !module.functions[*callee]
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("kind"))
            {
                return false;
            }
            assert_eq!(
                module.types[module.functions[*callee].arguments[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::F32)
            );
            assert_eq!(
                info.get_entry_point(0)[arguments[0]]
                    .ty
                    .inner_with(&module.types),
                &naga::TypeInner::Scalar(naga::Scalar::F32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    for (_, expression) in function.expressions.iter() {
        assert!(!matches!(expression, naga::Expression::Math { .. }));
        if let naga::Expression::Binary {
            op:
                naga::BinaryOperator::Equal
                | naga::BinaryOperator::NotEqual
                | naga::BinaryOperator::Less
                | naga::BinaryOperator::LessEqual
                | naga::BinaryOperator::Greater
                | naga::BinaryOperator::GreaterEqual,
            left,
            right,
        } = *expression
        {
            for operand in [left, right] {
                assert_ne!(
                    info.get_entry_point(0)[operand]
                        .ty
                        .inner_with(&module.types)
                        .scalar()
                        .map(|scalar| scalar.kind),
                    Some(naga::ScalarKind::Float)
                );
            }
        }
    }
}

#[test]
fn cuda_fmaf_rn_converts_fixed_scalar_parameters_before_bitcopy() {
    for declaration in [
        "bool value = true;",
        "int value = -7;",
        "unsigned value = 9u;",
        "short value = -3;",
        "long long value = -11LL;",
    ] {
        let (module, info) = validate_with_options_and_capabilities(
            &format!("__global__ void kernel(float *out) {{ {declaration} out[0] = __fmaf_rn(value, value, value); }}"),
            &Options::default(), naga::valid::Capabilities::SHADER_INT16 | naga::valid::Capabilities::SHADER_INT64,
        );
        let function = &module.entry_points[0].function;
        let mut bitcopies = 0;
        for (_, expression) in function.expressions.iter() {
            if let naga::Expression::Bitcast { expr, ty } = *expression {
                if module.types[ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32) {
                    assert_eq!(
                        info.get_entry_point(0)[expr].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(naga::Scalar::F32)
                    );
                    bitcopies += 1;
                }
            }
        }
        assert_eq!(bitcopies, 3, "{declaration}");
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar() != Some(naga::Scalar::F64)));
    }
}

#[test]
fn cuda_fmaf_rn_coexists_with_exact_integer_user_overloads() {
    let (module, _) = validate(
        "__device__ int __fmaf_rn(int x, int y, int z) { return x + y + z; }
        __global__ void kernel(float *out) { out[0] = float(__fmaf_rn(1, 2, 3)); out[1] = __fmaf_rn(1.0f, -2.0f, 3.0f); }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.types[module.functions[function].arguments[0].ty].inner
                == naga::TypeInner::Scalar(naga::Scalar::I32)
            {
                calls += 1;
            }
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_fmaf_rn_rejects_invalid_signatures_arguments_and_hidden_names() {
    for source in [
        "__device__ float __fmaf_rn(float x, float y, float z) { return x; } __global__ void kernel() {}",
        "__device__ int __fmaf_rn(float x, float y, float z); __global__ void kernel() {}",
        "__global__ void kernel() { __fmaf_rn(); }",
        "__global__ void kernel() { __fmaf_rn(1.0f); }",
        "__global__ void kernel() { __fmaf_rn(1.0f, 2.0f); }",
        "__global__ void kernel() { __fmaf_rn(1.0f, 2.0f, 3.0f, 4.0f); }",
        "__global__ void kernel() { __fmaf_rn(float2(1.0f), 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { __fmaf_rn(1.0f, input, 3.0f); }",
        "__global__ void kernel() { unsigned __fmaf_rn = 1u; __fmaf_rn(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel() { return; __fmaf_rn(1.0f, 2.0f, missing); }",
    ] { reject(source); }
    for arguments in [
        "empty(), 1.0f, 2.0f",
        "1.0f, empty(), 2.0f",
        "1.0f, 2.0f, empty()",
    ] {
        let source = format!("// π UTF-8 span\n__device__ void empty() {{}} __global__ void kernel() {{ __fmaf_rn({arguments}); }}");
        assert_eq!(&source[reject(&source).span.to_range().unwrap()], "empty()");
    }
}

#[test]
fn cuda_fmaf_rn_evaluates_helper_and_reference_arguments_once() {
    let (module, _) = validate(
        "__device__ float next(float value) { return value; }
        __device__ float read(const float &value) { return value; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = __fmaf_rn(next(value++), next(value++), next(value++)); out[1] = __fmaf_rn(read(value), value++, value++); out[2] = value; }",
    );
    let mut next_calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function]
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("next"))
            {
                next_calls += 1;
            }
        }
        false
    });
    assert_eq!(next_calls, 3);
}

#[test]
fn cuda_fmaf_rn_reads_each_volatile_argument_once_and_keeps_control_flow() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(float *out, const volatile float *input) { out[0] = __fmaf_rn(input[0], input[1], input[2]); }",
        &Options::default(), naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let function = &module.entry_points[0].function;
    let loads = function
        .expressions
        .iter()
        .filter(|(_, expression)| {
            let naga::Expression::Load { pointer } = **expression else {
                return false;
            };
            let naga::Expression::GlobalVariable(global) =
                function.expressions[root_expression(function, pointer)]
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
    validate("__global__ void kernel(float *out, float value, bool choose) { out[0] = choose ? __fmaf_rn(value++, value++, value++) : __fmaf_rn(value++, value++, value++); }");
}

#[test]
fn cuda_fmaf_rn_remains_nonconstant_and_bounds_source_depth() {
    for body in [
        "constexpr float value = __fmaf_rn(1.0f, -2.0f, 3.0f);",
        "static_assert(__fmaf_rn(1.0f, 2.0f, 3.0f) == 5.0f);",
        "const int count = int(__fmaf_rn(2.0f, 1.0f, 3.0f)); int values[count];",
        "constexpr int count = (__fmaf_rn(1.0f, 2.0f, 3.0f), 3);",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : __fmaf_rn(1.0f, 2.0f, 3.0f); out[0] = value; }");
    let mut expression = String::from("value");
    for _ in 0..80 {
        expression = format!("__fmaf_rn({expression}, value, value)");
    }
    let error = reject(&format!(
        "__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}

#[test]
fn cuda_fmaf_rn_captures_result_before_evaluating_later_call_arguments() {
    let (module, _) = validate(
        "__device__ float pair(float first, float second) { return first + second; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = pair(__fmaf_rn(value, value, value), value++); }",
    );
    let function = &module.entry_points[0].function;
    let first_argument = function
        .body
        .iter()
        .find_map(|statement| match statement {
            naga::Statement::Call {
                function: callee,
                arguments,
                ..
            } if module.functions[*callee]
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("pair")) =>
            {
                Some(arguments[0])
            }
            _ => None,
        })
        .unwrap();
    let first_emit = function.body.iter().position(|statement| matches!(statement, naga::Statement::Emit(range) if range.clone().any(|handle| handle == first_argument))).unwrap();
    let call_position = function.body.iter().position(|statement| matches!(statement, naga::Statement::Call { function: callee, .. } if module.functions[*callee].name.as_deref().is_some_and(|name| name.starts_with("pair")))).unwrap();
    assert!(function
        .body
        .iter()
        .take(call_position)
        .skip(first_emit + 1)
        .any(|statement| matches!(statement, naga::Statement::Store { .. })));
}

#[test]
fn cuda_fmaf_rn_reuses_one_portable_integer_helper_across_calls_and_entry_points() {
    let (module, info) = validate(
        "__global__ void first(float *out, float x, float y) { out[0] = __fmaf_rn(x, y, x); out[1] = __fmaf_rn(y, x, y); }
        __global__ void second(float *out, float x, float y) { out[0] = __fmaf_rn(x, y, x); }",
    );
    assert_eq!(module.functions.len(), 1);
    let (helper, function) = module.functions.iter().next().unwrap();
    assert_eq!(function.name.as_deref(), Some("_naga_fmaf_rn"));
    assert_eq!(function.arguments.len(), 3);
    for argument in &function.arguments {
        assert_eq!(
            module.types[argument.ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    assert_eq!(
        module.types[function.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    for (expression, value) in function.expressions.iter() {
        let scalar = info[helper][expression]
            .ty
            .inner_with(&module.types)
            .scalar();
        assert!(!scalar
            .is_some_and(|scalar| scalar.width == 8 || scalar.kind == naga::ScalarKind::Float));
        assert!(!matches!(
            value,
            naga::Expression::Math {
                fun: naga::MathFunction::Fma,
                ..
            }
        ));
    }
    assert!(!naga::proc::any_statement(
        &function.body,
        &mut |statement| matches!(statement, naga::Statement::Call { .. })
    ));
    let mut calls = 0;
    for (entry_index, entry) in module.entry_points.iter().enumerate() {
        naga::proc::any_statement(&entry.function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                assert_eq!(function, helper);
                calls += 1;
            }
            false
        });
        for (expression, value) in entry.function.expressions.iter() {
            if let naga::Expression::Binary {
                op: naga::BinaryOperator::Add | naga::BinaryOperator::Multiply,
                ..
            } = value
            {
                assert_ne!(
                    info.get_entry_point(entry_index)[expression]
                        .ty
                        .inner_with(&module.types)
                        .scalar()
                        .map(|scalar| scalar.kind),
                    Some(naga::ScalarKind::Float)
                );
            }
        }
    }
    assert_eq!(calls, 3);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_fmaf_rn_uniform_arguments_allow_barriers_after_captured_helper_remapping() {
    validate(
        "__device__ void increment(unsigned &counter) { ++counter; }
        __device__ void synchronize(float first, float second, float third);
        __global__ void first(float x, float y, unsigned *out) {
            unsigned counter = 0u; increment(counter); out[0] = counter;
            synchronize(x, y, x);
            float saved = __fmaf_rn(x, y, x);
            if (saved > 0.0f) __syncthreads();
        }
        __device__ void synchronize(float renamed, float other, float last) { if (__fmaf_rn(renamed, other, last) > 0.0f) __syncthreads(); }
        __global__ void second(float x, float y) { synchronize(x, y, x); }",
    );
}

#[test]
fn cuda_fmaf_rn_barrier_controls_reject_each_varying_operand() {
    for arguments in [
        "float(threadIdx.x), value, value",
        "value, float(threadIdx.x), value",
        "value, value, float(threadIdx.x)",
    ] {
        for source in [
            format!("__global__ void kernel(float value) {{ if (__fmaf_rn({arguments}) > 0.0f) __syncthreads(); }}"),
            format!("__device__ void synchronize(float x, float y, float z) {{ if (__fmaf_rn(x, y, z) > 0.0f) __syncthreads(); }} __global__ void kernel(float value) {{ synchronize({arguments}); }}"),
        ] {
            let error = reject(&source);
            assert!(error.message.contains("barrier"), "{source}: {error}");
        }
    }
}

#[test]
fn cuda_fmaf_rn_pure_cache_recognition_requires_the_actual_generated_function() {
    for name in ["_naga_fmaf_rn", "__fmaf_rn", "opaque"] {
        let source = format!(
            "__device__ unsigned {name}(unsigned x, unsigned y, unsigned z) {{ return x + y + z; }}
            __global__ void kernel(float value, float *out) {{
                out[0] = __fmaf_rn(value, value, value);
                if ({name}(1u, 2u, 3u) > 0u) __syncthreads();
            }}"
        );
        let error = reject(&source);
        assert!(error.message.contains("barrier"), "{source}: {error}");
    }
}
