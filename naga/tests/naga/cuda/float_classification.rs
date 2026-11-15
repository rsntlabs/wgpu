use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

const NAMES: [&str; 4] = ["isfinite", "isinf", "isnan", "signbit"];

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
fn cuda_float_classification_accepts_float_alias_prototypes_and_returns_int() {
    for name in NAMES {
        let (module, info) = validate(&format!(
            "using Sample = float; __host__ __device__ int {name}(const Sample value);
            __device__ int kind(int value) {{ return 1; }} __device__ int kind(bool value) {{ return 2; }}
            __global__ void kernel(int *out, Sample value) {{ out[0] = kind({name}(value)); }}"
        ));
        let function = &module.entry_points[0].function;
        let mut calls = 0;
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call {
                function: callee,
                arguments,
                ..
            } = statement
            {
                assert!(module.functions[*callee]
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("kind")));
                assert_eq!(
                    module.types[module.functions[*callee].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                assert_eq!(
                    info.get_entry_point(0)[arguments[0]]
                        .ty
                        .inner_with(&module.types),
                    &naga::TypeInner::Scalar(naga::Scalar::I32)
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
            match *expression {
                naga::Expression::Math { arg, .. } => assert_ne!(
                    info.get_entry_point(0)[arg]
                        .ty
                        .inner_with(&module.types)
                        .scalar()
                        .map(|scalar| scalar.kind),
                    Some(naga::ScalarKind::Float)
                ),
                naga::Expression::Binary {
                    op:
                        naga::BinaryOperator::Equal
                        | naga::BinaryOperator::NotEqual
                        | naga::BinaryOperator::Less
                        | naga::BinaryOperator::LessEqual
                        | naga::BinaryOperator::Greater
                        | naga::BinaryOperator::GreaterEqual,
                    left,
                    right,
                } => {
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
                _ => {}
            }
        }
    }
}

#[test]
fn cuda_float_classification_coexists_with_exact_integer_user_overloads() {
    for name in NAMES {
        let (module, _) = validate(&format!(
            "__device__ unsigned {name}(int value) {{ return 7u; }}
            __global__ void kernel(unsigned *out, float value) {{ out[0] = {name}(1); out[1] = unsigned({name}(value)); }}"
        ));
        let mut user_calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                assert_eq!(
                    module.types[module.functions[*function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                user_calls += 1;
            }
            false
        });
        assert_eq!(user_calls, 1);
    }
}

#[test]
fn cuda_float_classification_rejects_reserved_signatures_and_invalid_arguments() {
    for name in NAMES {
        for source in [
            format!(
                "__device__ int {name}(float value) {{ return 1; }} __global__ void kernel() {{}}"
            ),
            format!("__device__ bool {name}(float value); __global__ void kernel() {{}}"),
            format!("__global__ void kernel() {{ {name}(); }}"),
            format!("__global__ void kernel() {{ {name}(1.0f, 2.0f); }}"),
            format!("__global__ void kernel() {{ {name}(float2(1.0f)); }}"),
            format!("__global__ void kernel(float *input) {{ {name}(input); }}"),
            format!("__global__ void kernel() {{ float input[2]; {name}(input); }}"),
            format!("__global__ void kernel() {{ unsigned {name} = 1u; {name}(1.0f); }}"),
        ] {
            reject(&source);
        }
        let source = format!("// π UTF-8 span prefix\n__device__ void empty() {{}} __global__ void kernel() {{ {name}(empty()); }}");
        let error = reject(&source);
        assert_eq!(&source[error.span.to_range().unwrap()], "empty()");
    }
}

#[test]
fn cuda_float_classification_evaluates_helper_and_volatile_arguments_once() {
    for name in NAMES {
        let (module, _) = validate(&format!(
            "__device__ float next(float value) {{ return value; }} __global__ void kernel(int *out, float value) {{ out[0] = {name}(next(value)); }}"
        ));
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if matches!(statement, naga::Statement::Call { .. }) {
                calls += 1;
            }
            false
        });
        assert_eq!(calls, 1);
        let (module, _) = validate_with_options_and_capabilities(
            &format!("__global__ void kernel(int *out, const volatile float *input) {{ out[0] = {name}(input[0]); }}"),
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
    }
}

#[test]
fn cuda_float_classification_keeps_side_effects_in_selected_control_flow() {
    for name in NAMES {
        validate(&format!("__global__ void kernel(int *out, float value, bool choose) {{ out[0] = choose ? {name}(value++) : {name}(value++); out[1] = choose && {name}(value++); }}"));
    }
}

#[test]
fn cuda_float_classification_is_not_a_source_constant_expression() {
    for name in NAMES {
        for body in [
            format!("constexpr int result = {name}(1.0f);"),
            format!("const int count = {name}(1.0f); int values[count];"),
            format!("static_assert({name}(1.0f) >= 0);"),
            format!("constexpr int result = ({name}(1.0f), 3);"),
        ] {
            reject(&format!("__global__ void kernel() {{ {body} }}"));
        }
        validate(&format!("__global__ void kernel(int *out) {{ constexpr int count = true ? 2 : {name}(1.0f); int values[count]{{}}; out[0] = values[0]; }}"));
    }
}

#[test]
fn cuda_float_classification_bounds_nested_source_depth() {
    let mut expression = String::from("value");
    for _ in 0..80 {
        expression = format!("float(isfinite({expression}))");
    }
    let source =
        format!("__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}");
    let error = reject(&source);
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}

#[test]
fn cuda_float_classification_requires_original_float_arguments_for_builtins() {
    for name in NAMES {
        for declaration in [
            "bool value = true;",
            "int value = 1;",
            "unsigned value = 1u;",
            "short value = 1;",
            "long long value = 1LL;",
        ] {
            let source = format!(
                "__global__ void kernel(int *out) {{ {declaration} out[0] = {name}(value); }}"
            );
            let error = reject(&source);
            assert!(
                error.message.to_lowercase().contains("float"),
                "{source}: {error}"
            );
        }
        validate(&format!(
            "__global__ void kernel(int *out, int value) {{ out[0] = {name}(float(value)); }}"
        ));
    }
}

#[test]
fn cuda_float_classification_checks_float_policy_after_captured_candidate_selection() {
    for name in NAMES {
        reject(&format!("__device__ int {name}(const int &value, int extra) {{ return extra; }} __global__ void kernel(int *out) {{ out[0] = {name}(1); }}"));
        reject(&format!("template<class T> __device__ int {name}(T *value) {{ return 55; }} __global__ void kernel(int *out) {{ out[0] = {name}(1); }}"));
        validate(&format!("__device__ int {name}(const int &value, int extra) {{ return extra; }} __global__ void kernel(int *out) {{ out[0] = {name}(float(1)); }}"));
        validate(&format!("template<class T> __device__ int {name}(T *value) {{ return 55; }} __global__ void kernel(int *out) {{ out[0] = {name}(float(1)); }}"));
    }
}

#[test]
fn cuda_float_classification_allows_winning_generic_integer_user_templates() {
    for name in NAMES {
        let (module, _) = validate(&format!("template<class T> __device__ int {name}(T value) {{ return 55; }} __global__ void kernel(int *out) {{ out[0] = {name}(1); }}"));
        let mut user_calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                let callee = &module.functions[function];
                assert!(callee.body.iter().any(|statement| matches!(statement, naga::Statement::Return { value: Some(value) } if matches!(callee.expressions[*value], naga::Expression::Literal(naga::Literal::I32(55))))));
                user_calls += 1;
            }
            false
        });
        assert_eq!(user_calls, 1);
    }
}

#[test]
fn cuda_float_classification_preserves_winning_integer_promotions_to_user_overloads() {
    for name in NAMES {
        let (module, _) = validate_with_options_and_capabilities(
            &format!("__device__ int {name}(int value) {{ return 55; }} __global__ void kernel(int *out) {{ short value = 1; out[0] = {name}(value); }}"),
            &Options::default(),
            naga::valid::Capabilities::SHADER_INT16,
        );
        let mut user_calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                assert_eq!(
                    module.types[module.functions[function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                user_calls += 1;
            }
            false
        });
        assert_eq!(user_calls, 1);
    }
}
