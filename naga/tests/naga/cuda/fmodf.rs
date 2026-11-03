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

fn remainder_helpers(module: &naga::Module) -> Vec<naga::Handle<naga::Function>> {
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
fn cuda_fmodf_runtime_operands_roundtrip_through_shared_validation() {
    let (module, info) = validate(
        "__global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = fmodf(numerator, denominator);
        }",
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_fmodf_uses_one_integer_helper_without_floating_remainder_or_division() {
    let (module, info) = roundtrip(
        "__global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = fmodf(numerator, denominator);
        }",
    );
    let helpers = remainder_helpers(&module);
    assert_eq!(helpers.len(), 1);
    assert_eq!(module.functions.len(), 1);
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
            | naga::TypeInner::Vector {
                scalar: naga::Scalar { width: 8, .. },
                ..
            }
    )));
    for (handle, function) in module.functions.iter() {
        for (expression, _) in function.expressions.iter() {
            assert!(!matches!(
                info[handle][expression].ty.inner_with(&module.types),
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
        }
    }
    let function = &module.entry_points[0].function;
    for (handle, expression) in function.expressions.iter() {
        if matches!(
            expression,
            naga::Expression::Binary {
                op: naga::BinaryOperator::Divide | naga::BinaryOperator::Modulo,
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
fn cuda_fmodf_converts_each_supported_scalar_argument_and_returns_float() {
    for numerator in ["true", "-5", "7u", "5.5f"] {
        for denominator in ["false", "-3", "2u", "2.0f"] {
            let (module, info) = roundtrip(&format!(
                "__global__ void kernel(float *output) {{ output[0] = fmodf({numerator}, {denominator}); }}"
            ));
            assert_eq!(remainder_helpers(&module).len(), 1);
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
    roundtrip(
        "using Sample = const float;
        __device__ float remainder_value(Sample first, Sample second) { return fmodf(first, second); }
        __global__ void kernel(float *output) { output[0] = remainder_value(5.5f, 2.0f); }",
    );
}

#[test]
fn cuda_fmodf_reuses_its_helper_across_callers_templates_and_entry_points() {
    let (module, _) = roundtrip(
        "__device__ float remainder_value(float first, float second) { return fmodf(first, second); }
        template<int Bias> __device__ float shifted(float first, float second) {
            return fmodf(first, second) + float(Bias);
        }
        __global__ void first(float *output, float numerator, float denominator) {
            output[0] = fmodf(numerator, denominator);
            output[1] = remainder_value(numerator, denominator);
            output[2] = shifted<1>(numerator, denominator);
        }
        __global__ void second(float *output, float numerator, float denominator) {
            output[0] = shifted<2>(numerator, denominator);
            output[1] = fmodf(numerator, denominator);
        }",
    );
    let helpers = remainder_helpers(&module);
    assert_eq!(helpers.len(), 1);
    assert_eq!(module.entry_points.len(), 2);
    let mut calls = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if matches!(*statement, naga::Statement::Call { function, .. } if function == helpers[0])
            {
                calls += 1;
            }
            false
        });
    }
    assert_eq!(calls, 5);
    roundtrip(
        "__device__ int _naga_fmodf(int value) { return value + 10; }
        __global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = fmodf(numerator, denominator); output[1] = _naga_fmodf(2);
        }",
    );
}

#[test]
fn cuda_fmodf_preserves_alias_prototypes_and_rejects_incompatible_results() {
    roundtrip(
        "using Sample = const volatile float;
        __device__ float fmodf(Sample, Sample);
        __device__ float fmodf(float numerator, float denominator);
        __global__ void kernel(float *output, float numerator, float denominator) {
            output[0] = fmodf(numerator, denominator);
        }",
    );
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        let source = format!(
            "/* λ */ __device__ {result} fmodf(float first, float second) {{ {body} }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "fmodf");
    }
    rejected("__device__ int fmodf(float, float); __global__ void kernel() {}");
    for qualifier in ["const", "volatile", "const volatile"] {
        for result in [format!("{qualifier} float"), String::from("Sample")] {
            let source = format!(
                "using Sample = {qualifier} float; __device__ {result} fmodf(float, float);
                __global__ void kernel() {{}}"
            );
            let error = rejected(&source);
            assert!(
                error.message.contains("incompatible builtin result type"),
                "{error}"
            );
            assert_eq!(&source[error.span.to_range().unwrap()], "fmodf");
        }
    }
}

#[test]
fn cuda_fmodf_keeps_source_overloads_ambiguity_and_name_hiding() {
    roundtrip(
        "__device__ float fmodf(int first, int second) { return fmodf(float(first), float(second)); }
        __device__ int fmodf(bool first, bool second) { return first ? 7 : int(second); }
        __device__ float2 fmodf(float2 first, float2 second) {
            return make_float2(fmodf(first.x, second.x), fmodf(first.y, second.y));
        }
        __global__ void kernel(float *output) {
            output[0] = fmodf(5.5f, 2.0f); output[1] = fmodf(7, 3);
            output[2] = fmodf(true, false);
            output[3] = fmodf(make_float2(5.5f, -5.5f), make_float2(2.0f, 2.0f)).y;
            { using fmodf = int; output[4] = fmodf(2.75f); }
            output[5] = fmodf(5.5f, 2.0f);
        }",
    );
    let source = "__device__ int fmodf(int first, int second) { return first; }
        __global__ void kernel() { fmodf(1u, 2u); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "fmodf");
    for source in [
        "using fmodf = int; __global__ void kernel() {}",
        "__global__ void fmodf() {}",
        "__global__ void kernel() { int fmodf = 1; fmodf(1.0f, 2.0f); }",
        "__device__ float helper(int fmodf) { return fmodf(1.0f, 2.0f); } __global__ void kernel() {}",
        "__device__ float fmodf(int first, int second) { return fmodf(first, second); } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_fmodf_evaluates_operands_once_and_preserves_selected_control_flow() {
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __global__ void kernel(float *output) {
            float numerator = 5.5f, denominator = 2.0f;
            output[0] = fmodf(next(numerator++), next(denominator++));
            output[1] = numerator; output[2] = denominator;
        }",
    );
    let mut next_calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function].name.as_deref() == Some("next") {
                next_calls += 1;
            }
        }
        false
    });
    assert_eq!(next_calls, 2);
    roundtrip(
        "__device__ float next(float &value) { return value++; }
        template<int Count> __device__ float selected(float &value) {
            return fmodf(next(value), float(Count));
        }
        __global__ void kernel(float *output, int choose) {
            float value = 5.5f;
            output[0] = choose ? fmodf(next(value), 2.0f) : fmodf(next(value), 3.0f);
            bool skipped = false && fmodf(next(value), 2.0f);
            bool ready = true || fmodf(next(value), 2.0f);
            output[1] = value; output[2] = int(skipped) + int(ready);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[3] = selected<2>(value);
            }
        }",
    );
}

#[cfg(feature = "wgsl-in")]
#[test]
fn cuda_fmodf_reads_each_volatile_operand_once() {
    let source = "__global__ void kernel(const volatile float *values, float *output) {
        output[0] = fmodf(values[0], values[1]);
    }";
    let capabilities = naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE;
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        source,
        &Default::default(),
        capabilities,
    );
    let (handle, _) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some("values"))
        .unwrap();
    let accesses: Vec<_> = crate::volatile_loads::global_accesses(&module, handle)
        .into_iter()
        .map(|access| access.write)
        .collect();
    assert_eq!(accesses, [false, false]);
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
fn cuda_fmodf_remains_runtime_in_constant_expression_contexts() {
    for source in [
        "constexpr float Value = fmodf(5.5f, 2.0f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float Value = fmodf(5.5f, 2.0f); }",
        "__global__ void kernel() { const int count = int(fmodf(5.5f, 2.0f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (fmodf(5.5f, 2.0f), 3); }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<int(fmodf(5.5f, 2.0f))>(); }",
        "constexpr float Positive = 1.0f / 0.0f; __global__ void kernel() { constexpr float Value = fmodf(Positive, 2.0f); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Value = true ? 4.0f : fmodf(1.0f, 0.0f);
        __global__ void kernel(int *output) {
            constexpr int Count = false && fmodf(1.0f, 0.0f) ? 2 : 3;
            int values[Count]{}; output[0] = int(Value) + values[2];
        }",
    );
}

#[test]
fn cuda_fmodf_rejects_invalid_arguments_mutation_and_invalid_dead_source() {
    roundtrip("__global__ void kernel() { return; fmodf(1.0f, 0.0f); }");
    for statement in [
        "fmodf();",
        "fmodf(1.0f);",
        "fmodf(1.0f, 2.0f, 3.0f);",
        "fmodf(make_float2(1.0f, 2.0f), 2.0f);",
        "fmodf(1.0f, make_float2(1.0f, 2.0f));",
        "float values[2]{}; fmodf(values, 2.0f);",
        "fmodf(1.0f, output);",
        "fmodf(4.0, 2.0f);",
        "fmod(4.0f, 2.0f);",
        "fmodf(1.0f, 2.0f) = 3.0f;",
        "++fmodf(1.0f, 2.0f);",
        "fmodf(1.0f, 2.0f)++;",
        "float &reference = fmodf(5.5f, 2.0f);",
        "return; fmodf(missing, 2.0f);",
        "return; fmodf(1.0f);",
        "output[0] = 5.5f % 2.0f;",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
    let source = "__device__ void empty() {} __global__ void kernel() { fmodf(empty(), 2.0f); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "empty()"
    );
    roundtrip(
        "__device__ float observe(const float &value) { return value; }
        __global__ void kernel(float *output) {
            const float &reference = fmodf(5.5f, 2.0f); output[0] = observe(reference);
        }",
    );
}

#[test]
fn cuda_fmodf_keeps_extreme_exponents_signed_zeros_and_exceptional_values_runtime() {
    let mut source = String::from("__global__ void kernel(unsigned *output) {");
    for (index, (numerator, denominator)) in [
        (0x0000_0000u32, 0x4000_0000u32),
        (0x8000_0000, 0x4000_0000),
        (0x3f80_0000, 0x0000_0000),
        (0x3f80_0000, 0x8000_0000),
        (0x7f80_0000, 0x3f80_0000),
        (0xff80_0000, 0x3f80_0000),
        (0x3f80_0000, 0x7f80_0000),
        (0xbf80_0000, 0xff80_0000),
        (0x7f80_0001, 0x3f80_0000),
        (0x3f80_0000, 0xffc1_2345),
        (0x7f7f_ffff, 0x0000_0001),
        (0xff7f_ffff, 0x0000_0003),
        (0x7f7f_ffff, 0x0080_0001),
        (0x0080_0000, 0x007f_ffff),
        (0x0080_0001, 0x0080_0000),
        (0x0000_0003, 0x0000_0002),
        (0x8000_0003, 0x0000_0002),
        (0x3f80_0001, 0x3f80_0000),
        (0x3f7f_ffff, 0x3f80_0000),
        (0xbf80_0001, 0x3f80_0000),
    ]
    .into_iter()
    .enumerate()
    {
        source.push_str(&format!(
            "output[{index}] = __float_as_uint(fmodf(__uint_as_float({numerator}u), __uint_as_float({denominator}u)));"
        ));
    }
    source.push('}');
    let (module, _) = roundtrip(&source);
    assert_eq!(remainder_helpers(&module).len(), 1);
    assert!(!module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(_, expression)| matches!(
            expression,
            naga::Expression::Literal(naga::Literal::F32(value)) if !value.is_finite()
        )));
}

#[test]
fn cuda_fmodf_bounds_nested_source_and_keeps_flat_cached_calls_linear() {
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("fmodf({expression}, 2.0f)");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("fmodf({expression}, 2.0f)");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = fmodf(value, 2.0f); }",
    );
    let statements = "output[0] = fmodf(value, 2.0f);".repeat(128);
    let (many, _) = roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ {statements} }}"
    ));
    assert_eq!(remainder_helpers(&single).len(), 1);
    assert_eq!(remainder_helpers(&many).len(), 1);
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
}
