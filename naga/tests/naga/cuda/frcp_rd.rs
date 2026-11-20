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
fn cuda_frcp_rd_accepts_float_alias_prototypes_and_returns_float_bits() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ Sample __frcp_rd(const Sample magnitude);
        __device__ int kind(float value) { return 1; } __device__ int kind(int value) { return 2; }
        __global__ void kernel(int *out, Sample x, Sample y) { out[0] = kind(__frcp_rd(x)); }",
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
fn cuda_frcp_rd_converts_fixed_scalar_parameters_before_bitcopy() {
    for declaration in [
        "bool value = true;",
        "int value = -7;",
        "unsigned value = 9u;",
        "short value = -3;",
        "long long value = -11LL;",
    ] {
        let (module, info) = validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(float *out) {{ {declaration} out[0] = __frcp_rd(value); }}"
            ),
            &Options::default(),
            naga::valid::Capabilities::SHADER_INT16 | naga::valid::Capabilities::SHADER_INT64,
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
        assert!(bitcopies >= 1, "{declaration}");
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar() != Some(naga::Scalar::F64)));
    }
}

#[test]
fn cuda_frcp_rd_coexists_with_exact_integer_user_overloads() {
    let (module, _) = validate(
        "__device__ int __frcp_rd(int x) { return x + 1; }
        __global__ void kernel(float *out) { out[0] = float(__frcp_rd(1)); out[1] = __frcp_rd(1.0f); }",
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
fn cuda_frcp_rd_rejects_invalid_signatures_arguments_and_hidden_names() {
    for source in [
        "__device__ float __frcp_rd(float x) { return x; } __global__ void kernel() {}",
        "__device__ int __frcp_rd(float x); __global__ void kernel() {}",
        "__global__ void kernel() { __frcp_rd(); }",
        "__global__ void kernel() { __frcp_rd(1.0f, 2.0f); }",
        "__global__ void kernel() { __frcp_rd(float2(1.0f)); }",
        "__global__ void kernel(float *input) { __frcp_rd(input); }",
        "__global__ void kernel() { unsigned __frcp_rd = 1u; __frcp_rd(1.0f); }",
        "__global__ void kernel() { return; __frcp_rd(missing); }",
    ] {
        reject(source);
    }
    let source = "// π UTF-8 span\n__device__ void empty() {} __global__ void kernel() { __frcp_rd(empty()); }";
    assert_eq!(&source[reject(source).span.to_range().unwrap()], "empty()");
}

#[test]
fn cuda_frcp_rd_evaluates_helper_and_reference_arguments_once() {
    let (module, _) = validate(
        "__device__ float next(float value) { return value; }
        __device__ float read(const float &value) { return value; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = __frcp_rd(next(value++)); out[1] = __frcp_rd(read(value)); out[2] = value; }",
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
    assert_eq!(next_calls, 1);
}

#[test]
fn cuda_frcp_rd_reads_each_volatile_argument_once_and_keeps_control_flow() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(float *out, const volatile float *input) { out[0] = __frcp_rd(input[0]); }",
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
    assert_eq!(loads, 1);
    validate("__global__ void kernel(float *out, float value, bool choose) { out[0] = choose ? __frcp_rd(value++) : __frcp_rd(value++); }");
}

#[test]
fn cuda_frcp_rd_remains_nonconstant_and_bounds_source_depth() {
    for body in [
        "constexpr float value = __frcp_rd(1.0f);",
        "static_assert(__frcp_rd(2.0f) == 0.5f);",
        "const int count = int(__frcp_rd(0.25f)); int values[count];",
        "constexpr int count = (__frcp_rd(2.0f), 3);",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : __frcp_rd(2.0f); out[0] = value; }");
    let mut expression = String::from("value");
    for _ in 0..80 {
        expression = format!("__frcp_rd({expression})");
    }
    let error = reject(&format!(
        "__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}

#[test]
fn cuda_frcp_rd_captures_result_before_evaluating_later_call_arguments() {
    let (module, _) = validate(
        "__device__ float pair(float first, float second) { return first + second; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = pair(__frcp_rd(value), value++); }",
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
fn cuda_frcp_rd_reuses_one_portable_integer_helper_across_calls_and_entry_points() {
    let (module, info) = validate(
        "__global__ void first(float *out, float x, float y) { out[0] = __fdiv_rd(x, y); out[1] = __fdiv_rd(y, x); out[2] = __frcp_rd(x); }
        __global__ void second(float *out, float x, float y) { out[0] = __frcp_rd(x); }",
    );
    assert_eq!(module.functions.len(), 1);
    let (helper, function) = module.functions.iter().next().unwrap();
    assert_eq!(function.arguments.len(), 2);
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
                op: naga::BinaryOperator::Divide,
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
    assert_eq!(calls, 4);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_frcp_rd_uniform_arguments_allow_barriers_after_captured_helper_remapping() {
    validate(
        "__device__ void increment(unsigned &counter) { ++counter; }
        __device__ void synchronize(float first, float second);
        __global__ void first(float x, float y, unsigned *out) {
            unsigned counter = 0u; increment(counter); out[0] = counter;
            synchronize(x, y);
            float saved = __frcp_rd(x);
            if (saved > 0.0f) __syncthreads();
        }
        __device__ void synchronize(float renamed, float other) { if (__frcp_rd(renamed) > 0.0f) __syncthreads(); }
        __global__ void second(float x, float y) { synchronize(x, y); }",
    );
}

#[test]
fn cuda_frcp_rd_barrier_controls_reject_varying_operand() {
    for source in [
        "__global__ void kernel() { if (__frcp_rd(float(threadIdx.x)) > 0.0f) __syncthreads(); }",
        "__device__ void synchronize(float value) { if (__frcp_rd(value) > 0.0f) __syncthreads(); } __global__ void kernel() { synchronize(float(threadIdx.x)); }",
    ] {
        let error = reject(source);
        assert!(error.message.contains("barrier"), "{source}: {error}");
    }
}

#[test]
fn cuda_frcp_rd_pure_cache_recognition_requires_the_actual_generated_function() {
    for name in ["_naga_divide_f32_rd", "opaque"] {
        let source = format!(
            "__device__ unsigned {name}(unsigned x, unsigned y) {{ return x + y; }}
            __global__ void kernel(float value, float *out) {{
                out[0] = __frcp_rd(value);
                if ({name}(1u, 2u) > 0u) __syncthreads();
            }}"
        );
        let error = reject(&source);
        assert!(error.message.contains("barrier"), "{source}: {error}");
    }
}

#[test]
fn cuda_frcp_rd_shares_only_the_rd_division_cache_through_forward_helper_remapping() {
    let (module, info) = validate(
        "__device__ void increment(unsigned &counter) { ++counter; }
        __device__ float reciprocal(float value);
        __global__ void first(float *out, float x, float y) {
            unsigned count = 0u; increment(count);
            out[0] = x / y; out[1] = __fdiv_rn(x, y); out[2] = __frcp_rn(x);
            out[3] = __fdiv_rd(x, y); out[4] = __frcp_rd(x); out[5] = reciprocal(y); out[6] = float(count);
        }
        __device__ float reciprocal(float renamed) { return __frcp_rd(renamed); }
        __global__ void second(float *out, float x) { out[0] = __frcp_rd(x); out[1] = __frcp_rn(x); }",
    );
    let rn = module
        .functions
        .iter()
        .find_map(|(handle, function)| {
            (function.name.as_deref() == Some("_naga_divide_f32")).then_some(handle)
        })
        .unwrap();
    let rz = module
        .functions
        .iter()
        .find_map(|(handle, function)| {
            (function.name.as_deref() == Some("_naga_divide_f32_rd")).then_some(handle)
        })
        .unwrap();
    assert_ne!(rn, rz);
    let mut rn_calls = 0;
    let mut rz_calls = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                rn_calls += usize::from(function == rn);
                rz_calls += usize::from(function == rz);
            }
            false
        });
    }
    assert_eq!((rn_calls, rz_calls), (4, 4));
    let reciprocal = module
        .functions
        .iter()
        .find_map(|(_, function)| {
            function
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("reciprocal"))
                .then_some(function)
        })
        .unwrap();
    assert!(naga::proc::any_statement(
        &reciprocal.body,
        &mut |statement| matches!(statement, naga::Statement::Call { function, .. } if *function == rz)
    ));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}
