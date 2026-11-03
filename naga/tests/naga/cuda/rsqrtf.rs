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

fn integer_helpers(module: &naga::Module) -> Vec<naga::Handle<naga::Function>> {
    module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (matches!(function.arguments.len(), 1 | 2)
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
fn cuda_rsqrtf_reuses_integer_square_root_and_division_helpers() {
    let (module, info) = roundtrip(
        "__global__ void kernel(float *output, float value) {
            output[0] = rsqrtf(value);
        }",
    );
    assert_eq!(module.functions.len(), 2);
    let mut argument_counts = Vec::new();
    for (_, function) in module.functions.iter() {
        argument_counts.push(function.arguments.len());
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
    }
    argument_counts.sort_unstable();
    assert_eq!(argument_counts, [1, 2]);
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
            | naga::TypeInner::Vector {
                scalar: naga::Scalar { width: 8, .. },
                ..
            }
    )));
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        assert!(!function.expressions.iter().any(|(_, expression)| matches!(
            expression,
            naga::Expression::Math {
                fun: naga::MathFunction::Sqrt | naga::MathFunction::InverseSqrt,
                ..
            }
        )));
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
fn cuda_rsqrtf_converts_scalar_arguments_and_returns_float_values() {
    for declaration in [
        "bool value = true",
        "int value = 9",
        "unsigned value = 16u",
        "float value = 6.25f",
        "using Sample = const float; Sample value = 2.0f",
    ] {
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(float *output) {{ {declaration}; output[0] = rsqrtf(value); }}"
        ));
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
    roundtrip(
        "__device__ float observe(const float &value) { return value; }
        __global__ void kernel(float *output, float value) {
            const float &reference = rsqrtf(value);
            output[0] = observe(rsqrtf(value)); output[1] = reference;
        }",
    );
}

#[test]
fn cuda_rsqrtf_shares_both_helpers_with_square_root_division_and_template_instances() {
    let (module, info) = roundtrip(
        "__device__ float inverse(float value) { return rsqrtf(value); }
        template<int Bias> __device__ float shifted(float value) { return rsqrtf(value) + float(Bias); }
        __global__ void first(float *output, float value) {
            output[0] = rsqrtf(value); output[1] = inverse(value);
            output[2] = shifted<1>(value); output[3] = sqrtf(value); output[4] = 1.0f / value;
        }
        __global__ void second(float *output, float value) {
            output[0] = shifted<2>(value); output[1] = rsqrtf(value);
        }",
    );
    let helpers = integer_helpers(&module);
    assert_eq!(helpers.len(), 2);
    assert_eq!(module.entry_points.len(), 2);
    for helper in helpers {
        let mut calls = 0;
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            naga::proc::any_statement(&function.body, &mut |statement| {
                if matches!(*statement, naga::Statement::Call { function, .. } if function == helper)
                {
                    calls += 1;
                }
                false
            });
        }
        assert_eq!(calls, 6);
        for (expression, _) in module.functions[helper].expressions.iter() {
            assert!(!matches!(
                info[helper][expression].ty.inner_with(&module.types),
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
    assert!(roundtrip("__global__ void kernel() {}")
        .0
        .functions
        .is_empty());
}

#[test]
fn cuda_rsqrtf_preserves_source_overloads_and_local_name_hiding() {
    roundtrip(
        "__device__ float rsqrtf(int value) { return rsqrtf(float(value)); }
        __device__ int rsqrtf(bool value) { return value ? 7 : 9; }
        __device__ int rsqrtf(int first, int second) { return first + second; }
        __device__ float2 rsqrtf(float2 value) {
            return make_float2(rsqrtf(value.x), rsqrtf(value.y));
        }
        __global__ void kernel(float *output) {
            output[0] = rsqrtf(4.0f); output[1] = rsqrtf(9); output[2] = rsqrtf(true);
            { using rsqrtf = int; output[3] = rsqrtf(2.75f); }
            output[4] = rsqrtf(16.0f); output[5] = rsqrtf(3, 4);
            output[6] = rsqrtf(make_float2(4.0f, 16.0f)).x;
        }",
    );
    let source = "__device__ int rsqrtf(int value) { return value; }
        __global__ void kernel() { rsqrtf(1u); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "rsqrtf");
    for source in [
        "using rsqrtf = int; __global__ void kernel() {}",
        "__global__ void rsqrtf() {}",
        "__global__ void kernel() { int rsqrtf = 1; rsqrtf(1.0f); }",
        "__device__ float helper(int rsqrtf) { return rsqrtf(1.0f); } __global__ void kernel() {}",
        "__device__ float rsqrtf(int value) { return rsqrtf(value); } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_rsqrtf_checks_builtin_prototypes_and_result_qualification() {
    roundtrip(
        "using Sample = const volatile float;
        __device__ float rsqrtf(Sample);
        __device__ float rsqrtf(float value);
        __global__ void kernel(float *output, float value) { output[0] = rsqrtf(value); }",
    );
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        let source = format!(
            "/* λ */ using Sample = const float;
            __device__ {result} rsqrtf(Sample value) {{ {body} }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "rsqrtf");
    }
    rejected("__device__ int rsqrtf(float); __global__ void kernel() {}");
    for qualifier in ["const", "volatile", "const volatile"] {
        for result in [format!("{qualifier} float"), String::from("Sample")] {
            let source = format!(
                "using Sample = {qualifier} float; __device__ {result} rsqrtf(float);
                __global__ void kernel() {{}}"
            );
            let error = rejected(&source);
            assert!(
                error.message.contains("incompatible builtin result type"),
                "{error}"
            );
            assert_eq!(&source[error.span.to_range().unwrap()], "rsqrtf");
        }
    }
}

#[test]
fn cuda_rsqrtf_keeps_generated_helper_names_independent_of_source_names() {
    roundtrip(
        "__device__ int _naga_sqrtf(int value) { return value + 10; }
        __device__ int _naga_divide_f32(int value) { return value + 20; }
        __device__ int rsqrtf_bits(int value) { return value + 30; }
        __global__ void kernel(float *output, float value) {
            output[0] = rsqrtf(value);
            output[1] = _naga_sqrtf(2) + _naga_divide_f32(3) + rsqrtf_bits(4);
        }",
    );
}

#[test]
fn cuda_rsqrtf_evaluates_arguments_once_and_keeps_selected_control_flow() {
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void kernel(float *output) {
            float value = 4.0f;
            output[0] = pair(rsqrtf(next(value++)), value++); output[1] = value;
        }",
    );
    let mut next_calls = 0;
    let mut pair_calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            match module.functions[function].name.as_deref() {
                Some("next") => next_calls += 1,
                Some("pair") => pair_calls += 1,
                _ => {}
            }
        }
        false
    });
    assert_eq!(next_calls, 1);
    assert_eq!(pair_calls, 1);
    roundtrip(
        "__device__ float next(float &value) { return value++; }
        __global__ void kernel(float *output, int choose) {
            float value = 4.0f;
            output[0] = choose ? rsqrtf(next(value)) : rsqrtf(next(value));
            bool skipped = false && rsqrtf(next(value));
            bool ready = true || rsqrtf(next(value));
            output[1] = value; output[2] = int(skipped) + int(ready);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[3] = rsqrtf(next(value));
            }
        }",
    );
}

#[test]
fn cuda_rsqrtf_remains_runtime_in_source_constant_expression_contexts() {
    for source in [
        "constexpr float Inverse = rsqrtf(4.0f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float inverse = rsqrtf(4.0f); }",
        "__global__ void kernel() { const int count = int(rsqrtf(4.0f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (rsqrtf(4.0f), 3); }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<int(rsqrtf(4.0f))>(); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Inverse = true ? 9.0f : rsqrtf(-1.0f);
        __global__ void kernel(int *output) {
            constexpr int Count = false && rsqrtf(-1.0f) ? 2 : 3;
            int values[Count]{}; output[0] = int(Inverse) + values[0];
        }",
    );
}

#[test]
fn cuda_rsqrtf_rejects_invalid_operands_mutation_and_invalid_dead_source() {
    roundtrip("__global__ void kernel() { return; rsqrtf(-1.0f); }");
    for statement in [
        "rsqrtf();",
        "rsqrtf(1.0f, 2.0f);",
        "rsqrtf(make_float2(1.0f, 2.0f));",
        "float values[2]{}; rsqrtf(values);",
        "rsqrtf(output);",
        "rsqrtf(4.0);",
        "rsqrt(4.0f);",
        "__frsqrt_rn(4.0f);",
        "rsqrtf(1.0f) = 3.0f;",
        "++rsqrtf(1.0f);",
        "rsqrtf(1.0f)++;",
        "float &reference = rsqrtf(4.0f);",
        "return; rsqrtf(missing);",
        "return; rsqrtf(1.0f, 2.0f);",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
    let source = "__device__ void empty() {} __global__ void kernel() { rsqrtf(empty()); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "empty()"
    );
}

#[test]
fn cuda_rsqrtf_keeps_extreme_and_exceptional_literal_results_runtime() {
    let mut source = String::from("__global__ void kernel(unsigned *output) {");
    for (index, bits) in [
        0x0000_0000u32,
        0x8000_0000,
        0x0000_0001,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x0080_0001,
        0x3f7f_ffff,
        0x3f80_0000,
        0x3f80_0001,
        0x4080_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
        0xff81_2345,
        0x7fc1_2345,
        0xffc1_2345,
    ]
    .into_iter()
    .enumerate()
    {
        source.push_str(&format!(
            "output[{index}] = __float_as_uint(rsqrtf(__uint_as_float({bits}u)));"
        ));
    }
    source.push('}');
    let (module, _) = roundtrip(&source);
    assert_eq!(integer_helpers(&module).len(), 2);
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
fn cuda_rsqrtf_bounds_nesting_and_keeps_flat_cached_calls_linear() {
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("rsqrtf({expression})");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("rsqrtf({expression})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = rsqrtf(value); }",
    );
    let statements = "output[0] = rsqrtf(value);".repeat(128);
    let (many, _) = roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ {statements} }}"
    ));
    assert_eq!(integer_helpers(&single).len(), 2);
    assert_eq!(integer_helpers(&many).len(), 2);
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
}

#[cfg(feature = "wgsl-in")]
#[test]
fn cuda_rsqrtf_reads_volatile_arguments_once_for_both_integer_stages() {
    let source = "__global__ void kernel(const volatile float *values, float *output) {
        output[0] = rsqrtf(values[0]);
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
    assert_eq!(accesses, [false]);
    #[cfg(feature = "wgsl-out")]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
}
