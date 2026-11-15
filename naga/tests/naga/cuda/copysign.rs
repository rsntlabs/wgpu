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
fn cuda_copysign_accepts_float_alias_prototypes_and_returns_float_bits() {
    let (module, info) = validate(
        "using Sample = float; __host__ __device__ Sample copysignf(const Sample magnitude, Sample sign);
        __device__ int kind(float value) { return 1; } __device__ int kind(int value) { return 2; }
        __global__ void kernel(int *out, Sample x, Sample y) { out[0] = kind(copysignf(x, y)); }",
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
fn cuda_copysign_converts_fixed_scalar_parameters_before_bitcopy() {
    for declaration in [
        "bool value = true;",
        "int value = -7;",
        "unsigned value = 9u;",
        "short value = -3;",
        "long long value = -11LL;",
    ] {
        let (module, info) = validate_with_options_and_capabilities(
            &format!("__global__ void kernel(float *out) {{ {declaration} out[0] = copysignf(value, value); }}"),
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
        assert_eq!(bitcopies, 2, "{declaration}");
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar() != Some(naga::Scalar::F64)));
    }
}

#[test]
fn cuda_copysign_coexists_with_exact_integer_user_overloads() {
    let (module, _) = validate(
        "__device__ int copysignf(int x, int y) { return x + y; }
        __global__ void kernel(float *out) { out[0] = float(copysignf(1, 2)); out[1] = copysignf(1.0f, -2.0f); }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            assert_eq!(
                module.types[module.functions[function].arguments[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::I32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_copysign_rejects_invalid_signatures_arguments_and_hidden_names() {
    for source in [
        "__device__ float copysignf(float x, float y) { return x; } __global__ void kernel() {}",
        "__device__ int copysignf(float x, float y); __global__ void kernel() {}",
        "__global__ void kernel() { copysignf(); }",
        "__global__ void kernel() { copysignf(1.0f); }",
        "__global__ void kernel() { copysignf(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel() { copysignf(float2(1.0f), 2.0f); }",
        "__global__ void kernel(float *input) { copysignf(1.0f, input); }",
        "__global__ void kernel() { unsigned copysignf = 1u; copysignf(1.0f, 2.0f); }",
        "__global__ void kernel() { return; copysignf(missing, 1.0f); }",
    ] {
        reject(source);
    }
    for arguments in ["empty(), 1.0f", "1.0f, empty()"] {
        let source = format!("// π UTF-8 span\n__device__ void empty() {{}} __global__ void kernel() {{ copysignf({arguments}); }}");
        assert_eq!(&source[reject(&source).span.to_range().unwrap()], "empty()");
    }
}

#[test]
fn cuda_copysign_evaluates_helper_and_reference_arguments_once() {
    let (module, _) = validate(
        "__device__ float next(float value) { return value; }
        __device__ float read(const float &value) { return value; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = copysignf(next(value++), next(value++)); out[1] = copysignf(read(value), value++); out[2] = value; }",
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
    assert_eq!(next_calls, 2);
}

#[test]
fn cuda_copysign_reads_each_volatile_argument_once_and_keeps_control_flow() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(float *out, const volatile float *input) { out[0] = copysignf(input[0], input[1]); }",
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
    assert_eq!(loads, 2);
    validate("__global__ void kernel(float *out, float value, bool choose) { out[0] = choose ? copysignf(value++, value++) : copysignf(value++, value++); }");
}

#[test]
fn cuda_copysign_remains_nonconstant_and_bounds_source_depth() {
    for body in [
        "constexpr float value = copysignf(1.0f, -2.0f);",
        "static_assert(copysignf(1.0f, 2.0f) == 1.0f);",
        "const int count = int(copysignf(2.0f, 1.0f)); int values[count];",
        "constexpr int count = (copysignf(1.0f, 2.0f), 3);",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : copysignf(1.0f, 2.0f); out[0] = value; }");
    let mut expression = String::from("value");
    for _ in 0..80 {
        expression = format!("copysignf({expression}, value)");
    }
    let error = reject(&format!(
        "__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}

#[test]
fn cuda_copysign_captures_result_before_evaluating_later_call_arguments() {
    let (module, _) = validate(
        "__device__ float pair(float first, float second) { return first + second; }
        __global__ void kernel(float *out) { float value = 1.0f; out[0] = pair(copysignf(value, value), value++); }",
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
