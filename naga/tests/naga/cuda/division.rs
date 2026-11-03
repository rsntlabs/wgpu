use super::helpers::validate;

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Default::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn division_helpers(module: &naga::Module) -> Vec<naga::Handle<naga::Function>> {
    module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (function.arguments.len() == 2
                && function.arguments.iter().all(|argument| {
                    module.types[argument.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)
                })
                && function.result.as_ref().is_some_and(|result| {
                    module.types[result.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)
                }))
            .then_some(handle)
        })
        .collect()
}

#[test]
fn cuda_float_division_uses_one_cached_integer_helper() {
    let (module, info) = roundtrip(
        "__global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = numerator / denominator;
        }",
    );
    assert_eq!(module.functions.len(), 1);
    let (_, helper) = module.functions.iter().next().unwrap();
    assert_eq!(helper.arguments.len(), 2);
    for argument in &helper.arguments {
        assert_eq!(
            module.types[argument.ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
            | naga::TypeInner::Vector {
                scalar: naga::Scalar { width: 8, .. },
                ..
            }
    )));
    for (handle, function) in module.functions.iter() {
        for (expression_handle, expression) in function.expressions.iter() {
            assert!(!matches!(
                info[handle][expression_handle].ty.inner_with(&module.types),
                naga::TypeInner::Scalar(naga::Scalar {
                    kind: naga::ScalarKind::Float,
                    ..
                }) | naga::TypeInner::Vector {
                    scalar: naga::Scalar {
                        kind: naga::ScalarKind::Float,
                        ..
                    },
                    ..
                }
            ));
            if matches!(
                expression,
                naga::Expression::Binary {
                    op: naga::BinaryOperator::Divide,
                    ..
                }
            ) {
                assert_ne!(
                    info[handle][expression_handle].ty.inner_with(&module.types),
                    &naga::TypeInner::Scalar(naga::Scalar::F32)
                );
            }
        }
    }
    let function = &module.entry_points[0].function;
    for (handle, expression) in function.expressions.iter() {
        if matches!(
            expression,
            naga::Expression::Binary {
                op: naga::BinaryOperator::Divide,
                ..
            }
        ) {
            assert_ne!(
                info.get_entry_point(0)[handle].ty.inner_with(&module.types),
                &naga::TypeInner::Scalar(naga::Scalar::F32)
            );
        }
    }
}

#[test]
fn cuda_float_division_finite_constants_do_not_create_runtime_helpers() {
    let (module, _) = roundtrip(
        "constexpr float Quotient = 6.0f / 3.0f;
        __global__ void kernel(float *output) {
            constexpr float Scaled = Quotient / 0.5f;
            output[0] = Scaled;
            output[1] = -9.0f / 2.0f;
            output[2] = 0.0f / -1.0f;
        }",
    );
    assert!(module.functions.is_empty());
    assert!(!module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(_, expression)| matches!(
            expression,
            naga::Expression::Binary {
                op: naga::BinaryOperator::Divide,
                ..
            }
        )));
}

#[test]
fn cuda_float_division_converts_mixed_scalar_operands_before_bit_classification() {
    for (left, right) in [
        ("float", "float"),
        ("float", "int"),
        ("float", "unsigned"),
        ("float", "bool"),
        ("int", "float"),
        ("unsigned", "float"),
        ("bool", "float"),
    ] {
        let left_parameter = if left == "bool" { "int" } else { left };
        let right_parameter = if right == "bool" { "int" } else { right };
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(float *output, {left_parameter} input_numerator, {right_parameter} input_denominator) {{
                {left} numerator = {left}(input_numerator);
                {right} denominator = {right}(input_denominator);
                output[0] = numerator / denominator;
            }}"
        ));
        assert_eq!(division_helpers(&module).len(), 1);
        let function = &module.entry_points[0].function;
        let result = function
            .body
            .iter()
            .find_map(|statement| {
                let naga::Statement::Store { pointer, value } = *statement else {
                    return None;
                };
                matches!(
                    function.expressions[super::helpers::root_expression(function, pointer)],
                    naga::Expression::GlobalVariable(_)
                )
                .then_some(value)
            })
            .unwrap();
        assert_eq!(
            info.get_entry_point(0)[result].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
}

#[test]
fn cuda_float_division_compound_assignments_preserve_conversion_and_lvalue_results() {
    roundtrip(
        "__global__ void kernel(float *output, float denominator) {
            float value = 9.0f;
            float &reference = (value /= denominator);
            reference = 7.0f;
            int integer = 9; integer /= denominator;
            unsigned count = 9u; count /= denominator;
            bool enabled = true; enabled /= denominator;
            value /= 2; value /= 2u; value /= true;
            output[0] = value; output[1] = integer;
            output[2] = count; output[3] = enabled;
        }",
    );
    for left in ["fixed", "float(3)"] {
        rejected(&format!(
            "__global__ void kernel(float denominator) {{
                const float fixed = 3.0f; {left} /= denominator;
            }}"
        ));
    }
    rejected("__constant__ float fixed; __global__ void kernel(float denominator) { fixed /= denominator; }");
}

#[test]
fn cuda_float_division_preserves_source_defined_operator_dispatch() {
    let (module, _) = roundtrip(
        "struct Ratio { float value; };
        __device__ Ratio operator/(Ratio left, Ratio right) { return Ratio{left.value + right.value}; }
        __device__ float operator/(float left, Ratio right) { return left + right.value; }
        __device__ void operator/=(Ratio &left, float right) { left.value = right; }
        __device__ float operator/=(float left, Ratio right) { return left + right.value; }
        __global__ void kernel(float *output) {
            Ratio first{6.0f}, second{2.0f};
            Ratio quotient = first / second;
            first /= 3.0f;
            float scalar = 5.0f;
            output[0] = quotient.value; output[1] = first.value;
            output[2] = scalar / second;
            output[3] = (scalar /= second); output[4] = scalar;
        }",
    );
    assert!(division_helpers(&module).is_empty());
}

#[test]
fn cuda_float_division_reuses_its_helper_across_callers_templates_and_entry_points() {
    let (module, _) = roundtrip(
        "__device__ float divide(float numerator, float denominator) { return numerator / denominator; }
        template<class Value> __device__ float fraction(Value numerator, Value denominator) {
            return float(numerator) / float(denominator);
        }
        __global__ void first(float *output, float numerator, float denominator, int count) {
            output[0] = numerator / denominator;
            output[1] = divide(numerator, denominator);
            output[2] = fraction(count, 3);
        }
        __global__ void second(float *output, float numerator, float denominator) {
            output[0] = fraction(numerator, denominator);
            output[1] = numerator / denominator;
            output[2] /= denominator;
        }",
    );
    let helpers = division_helpers(&module);
    assert_eq!(helpers.len(), 1);
    assert_eq!(module.entry_points.len(), 2);
    let mut count = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if matches!(*statement, naga::Statement::Call { function, .. } if function == helpers[0])
            {
                count += 1;
            }
            false
        });
    }
    assert_eq!(count, 6);
}

#[test]
fn cuda_float_division_keeps_literal_exceptions_runtime_and_wgsl_valid() {
    let (module, _) = roundtrip(
        "__global__ void kernel(unsigned *output) {
            output[0] = __float_as_uint(0.0f / 0.0f);
            output[1] = __float_as_uint(1.0f / 0.0f);
            output[2] = __float_as_uint(-1.0f / 0.0f);
            output[3] = __float_as_uint(1.0f / -0.0f);
        }",
    );
    assert_eq!(division_helpers(&module).len(), 1);
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        assert!(!function.expressions.iter().any(|(_, expression)| matches!(
            expression,
            naga::Expression::Literal(naga::Literal::F32(value)) if !value.is_finite()
        )));
    }
}

#[test]
fn cuda_float_division_retains_local_global_template_and_array_constant_expressions() {
    let (module, _) = roundtrip(
        "constexpr float Ratio = 9.0f / 3.0f;
        template<int Count> __device__ unsigned selected() { return unsigned(Count); }
        template<int Count> __device__ float half() {
            constexpr float Value = float(Count) / 2.0f; return Value;
        }
        __device__ void consume(float values[int(6.0f / 2.0f)]) {}
        __global__ void kernel(float *output) {
            constexpr float Quotient = Ratio / 1.0f;
            const int Count = int(Quotient);
            float values[Count]{}; consume(values);
            output[0] = selected<int(8.0f / 2.0f)>();
            output[1] = half<6>(); output[2] = values[2];
        }",
    );
    assert!(division_helpers(&module).is_empty());
    assert!(module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Array { size: naga::ArraySize::Constant(count), .. } if count.get() == 3
    )));
    for expression in ["1.0f / 0.0f", "0.0f / 0.0f", "3.402823466e38f / 0.5f"] {
        rejected(&format!(
            "constexpr float Quotient = {expression}; __global__ void kernel() {{}}"
        ));
        rejected(&format!(
            "__global__ void kernel() {{ constexpr float Quotient = {expression}; }}"
        ));
    }
}

#[test]
fn cuda_float_division_preserves_lazy_and_discarded_constant_eligibility() {
    roundtrip(
        "constexpr float Selected = true ? 6.0f / 3.0f : 1.0f / 0.0f;
        __global__ void kernel(float *output) {
            constexpr float Chosen = false ? 0.0f / 0.0f : 8.0f / 2.0f;
            constexpr bool Disabled = false && (1.0f / 0.0f);
            constexpr bool Enabled = true || (0.0f / 0.0f);
            constexpr int Count = (6.0f / 3.0f, 2);
            float values[Count]{};
            output[0] = Selected + Chosen + float(Disabled) + float(Enabled) + values[1];
        }",
    );
    rejected("__global__ void kernel() { constexpr int Count = (1.0f / 0.0f, 2); }");
}

#[test]
fn cuda_float_division_evaluates_operands_once_and_keeps_selected_control_flow() {
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __global__ void kernel(float *output) {
            float numerator = 7.0f, denominator = 3.0f;
            output[0] = next(numerator++) / next(denominator++);
            output[1] = numerator; output[2] = denominator;
        }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function].name.as_deref() == Some("next") {
                calls += 1;
            }
        }
        false
    });
    assert_eq!(calls, 2);
    roundtrip(
        "__global__ void kernel(float *output, float divisor, unsigned selection) {
            bool choose = selection != 0u;
            float values[2]{10.0f, 20.0f}; unsigned index = 0u;
            values[index++] /= (index = 1u, divisor);
            output[0] = values[0]; output[1] = values[1]; output[2] = index;
            float numerator = 7.0f;
            output[3] = choose ? numerator++ / divisor : numerator++ / divisor;
            bool skipped = false && (numerator++ / divisor);
            bool ready = true || (numerator++ / divisor);
            for (int iteration = 0; iteration < 2; ++iteration) {
                if (iteration == 0) continue;
                output[4] = numerator++ / divisor;
            }
            output[5] = numerator + float(skipped) + float(ready);
        }",
    );
}

#[cfg(feature = "wgsl-in")]
#[test]
fn cuda_float_division_preserves_volatile_compound_assignment_access_order() {
    let source = "__global__ void kernel(volatile float *values, float *output) {
        values[0] /= (values[1] = 2.0f);
        output[0] = values[0];
    }";
    let capabilities = naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE;
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        source,
        &Default::default(),
        capabilities,
    );
    let (handle, global) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some("values"))
        .unwrap();
    assert!(global
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
    let accesses: Vec<_> = crate::volatile_loads::global_accesses(&module, handle)
        .into_iter()
        .map(|access| access.write)
        .collect();
    assert_eq!(accesses, [true, false, false, true, false]);
    #[cfg(feature = "wgsl-out")]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
}

#[test]
fn cuda_float_division_leaves_signed_unsigned_and_boolean_integer_division_native() {
    for scalar in ["int", "unsigned", "bool"] {
        let parameter = if scalar == "bool" { "int" } else { scalar };
        let (module, _) = roundtrip(&format!(
            "__global__ void kernel(int *output, {parameter} input_numerator, {parameter} input_denominator) {{
                {scalar} numerator = {scalar}(input_numerator);
                {scalar} denominator = {scalar}(input_denominator);
                output[0] = numerator / denominator;
            }}"
        ));
        assert!(module.functions.is_empty());
        assert!(module.entry_points[0].function.expressions.iter().any(
            |(_, expression)| matches!(
                expression,
                naga::Expression::Binary {
                    op: naga::BinaryOperator::Divide,
                    ..
                }
            )
        ));
    }
}

#[test]
fn cuda_float_division_keeps_prvalue_results_and_existing_invalid_operand_diagnostics() {
    roundtrip(
        "__global__ void kernel(float *output, float numerator, float denominator) {
            const float &quotient = numerator / denominator; output[0] = quotient;
            return; numerator / denominator;
        }",
    );
    for statement in [
        "(numerator / denominator) = 3.0f;",
        "++(numerator / denominator);",
        "(numerator / denominator)++;",
        "float &quotient = numerator / denominator;",
        "numerator / output;",
        "output / denominator;",
        "numerator / 2.0;",
        "return; numerator / missing;",
        "return; numerator / output;",
    ] {
        rejected(&format!(
            "/* λ */ __global__ void kernel(float *output, float numerator, float denominator) {{ {statement} }}"
        ));
    }
}

#[test]
fn cuda_float_division_keeps_source_names_independent_and_bounds_expression_growth() {
    roundtrip(
        "__device__ unsigned _naga_divide_f32(unsigned numerator, unsigned denominator) {
            return numerator + denominator;
        }
        __device__ unsigned divide_f32_bits(unsigned numerator, unsigned denominator) {
            return numerator + denominator;
        }
        __global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = numerator / denominator;
            output[1] = _naga_divide_f32(2u, 3u) + divide_f32_bits(5u, 7u);
        }",
    );
    let mut expression = String::from("numerator");
    for _ in 0..8 {
        expression = format!("({expression} / denominator)");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float numerator, float denominator) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("({expression} / denominator)");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float numerator, float denominator) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "__global__ void kernel(float *output, float numerator, float denominator) { output[0] = numerator / denominator; }",
    );
    let statements = "output[0] = numerator / denominator;".repeat(128);
    let (many, _) = roundtrip(&format!(
        "__global__ void kernel(float *output, float numerator, float denominator) {{ {statements} }}"
    ));
    assert_eq!(division_helpers(&single).len(), 1);
    assert_eq!(division_helpers(&many).len(), 1);
    assert_eq!(single.functions.len(), many.functions.len());
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
}
