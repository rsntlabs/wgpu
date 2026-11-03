use super::helpers::{root_expression, validate};

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

#[test]
fn cuda_roundf_converts_scalar_arguments_and_returns_float() {
    for declaration in [
        "bool value = true",
        "int value = -3",
        "unsigned value = 5u",
        "float value = -1.5f",
        "using Sample = const float; Sample value = 2.5f",
    ] {
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(float *output) {{ {declaration}; output[0] = roundf(value); }}"
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
                    function.expressions[root_expression(function, pointer)],
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
fn cuda_roundf_uses_a_runtime_integer_helper_without_native_rounding_or_double_types() {
    let (module, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = roundf(value); }",
    );
    assert_eq!(module.functions.len(), 1);
    let (_, helper) = module.functions.iter().next().unwrap();
    assert_eq!(helper.arguments.len(), 1);
    assert_eq!(
        module.types[helper.arguments[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        assert!(!function.expressions.iter().any(|(_, expression)| matches!(
            expression,
            naga::Expression::Math {
                fun: naga::MathFunction::Round
                    | naga::MathFunction::Floor
                    | naga::MathFunction::Ceil
                    | naga::MathFunction::Trunc
                    | naga::MathFunction::Abs,
                ..
            }
        )));
    }
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar {
            kind: naga::ScalarKind::Float,
            width: 8
        }) | naga::TypeInner::Vector {
            scalar: naga::Scalar {
                kind: naga::ScalarKind::Float,
                width: 8
            },
            ..
        }
    )));
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(_, expression)| matches!(
            expression,
            naga::Expression::As {
                kind: naga::ScalarKind::Uint,
                convert: None,
                ..
            }
        )));
}

#[test]
fn cuda_roundf_preserves_aliases_prototypes_overloads_and_name_hiding() {
    roundtrip(
        "using Sample = const float;
        __device__ float roundf(Sample);
        __device__ float roundf(int value) { return roundf(float(value)); }
        __device__ int roundf(bool value) { return value ? 7 : 9; }
        __device__ int roundf(int first, int second) { return first + second; }
        __device__ float2 roundf(float2 value) {
            return make_float2(roundf(value.x), roundf(value.y));
        }
        __global__ void kernel(float *output) {
            output[0] = roundf(2.5f); output[1] = roundf(3); output[2] = roundf(true);
            { using roundf = int; output[3] = roundf(2.75f); }
            output[4] = roundf(-1.5f); output[5] = roundf(3, 4);
            output[6] = roundf(make_float2(1.5f, -2.5f)).x;
        }",
    );
    let source = "__device__ int roundf(int value) { return value; }
        __global__ void kernel() { roundf(1u); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "roundf");
    for source in [
        "using roundf = int; __global__ void kernel() {}",
        "__global__ void roundf() {}",
        "__global__ void kernel() { int roundf = 1; roundf(1.0f); }",
        "__device__ float helper(int roundf) { return roundf(1.0f); } __global__ void kernel() {}",
        "__device__ float roundf(int value) { return roundf(value); } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_roundf_rejects_canonical_builtin_redefinitions_and_incompatible_prototypes() {
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        let source = format!(
            "/* λ */ using Sample = const float;
            __device__ {result} roundf(Sample value) {{ {body} }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "roundf");
    }
    rejected("__device__ int roundf(float); __global__ void kernel() {}");
    for qualifier in ["const", "volatile", "const volatile"] {
        for result in [format!("{qualifier} float"), String::from("Sample")] {
            let source = format!(
                "using Sample = {qualifier} float; __device__ {result} roundf(float);
                __global__ void kernel() {{}}"
            );
            let error = rejected(&source);
            assert!(
                error.message.contains("incompatible builtin result type"),
                "{error}"
            );
            assert_eq!(&source[error.span.to_range().unwrap()], "roundf");
        }
    }
}

#[test]
fn cuda_roundf_reuses_one_cached_helper_across_callers_instances_and_entry_points() {
    let (module, _) = roundtrip(
        "__device__ float rounded(float value) { return roundf(value); }
        template<int Bias> __device__ float shifted(float value) { return roundf(value) + float(Bias); }
        __global__ void first(float *output, float value) {
            output[0] = roundf(value); output[1] = rounded(value); output[2] = shifted<1>(value);
        }
        __global__ void second(float *output, float value) {
            output[0] = shifted<2>(value); output[1] = roundf(value);
        }",
    );
    let helpers: Vec<_> = module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (function.arguments.len() == 1
                && module.types[function.arguments[0].ty].inner
                    == naga::TypeInner::Scalar(naga::Scalar::U32)
                && function.result.as_ref().is_some_and(|result| {
                    module.types[result.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)
                }))
            .then_some(handle)
        })
        .collect();
    assert_eq!(helpers.len(), 1);
    assert_eq!(module.entry_points.len(), 2);
    let mut helper_calls = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if matches!(*statement, naga::Statement::Call { function, .. } if function == helpers[0])
            {
                helper_calls += 1;
            }
            false
        });
    }
    assert_eq!(helper_calls, 5);
}

#[test]
fn cuda_roundf_cached_helper_stays_distinct_from_floor_ceiling_and_absolute_value() {
    let (module, _) = roundtrip(
        "__device__ float lower(float value) { return floorf(value); }
        __device__ float upper(float value) { return ceilf(value); }
        __device__ float magnitude(float value) { return fabsf(value); }
        __device__ float nearest(float value) { return roundf(value); }
        __global__ void kernel(float *output, float value) {
            output[0] = lower(value); output[1] = upper(value);
            output[2] = magnitude(value); output[3] = nearest(value);
        }",
    );
    let mut helpers = Vec::new();
    for caller in ["lower", "upper", "magnitude", "nearest"] {
        let (_, function) = module
            .functions
            .iter()
            .find(|(_, function)| function.name.as_deref() == Some(caller))
            .unwrap();
        let mut calls = Vec::new();
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                calls.push(function);
            }
            false
        });
        assert_eq!(calls.len(), 1);
        let helper = &module.functions[calls[0]];
        assert_eq!(helper.arguments.len(), 1);
        assert_eq!(
            module.types[helper.arguments[0].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        assert_eq!(
            module.types[helper.result.as_ref().unwrap().ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        assert!(!helpers.contains(&calls[0]));
        helpers.push(calls[0]);
    }
    assert_eq!(helpers.len(), 4);
}

#[test]
fn cuda_roundf_keeps_generated_helper_names_independent_of_source_names() {
    roundtrip(
        "__device__ unsigned _naga_roundf(unsigned value) { return value + 40u; }
        __device__ int roundf_bits(int value) { return value + 50; }
        __global__ void kernel(float *output, float value) {
            output[0] = roundf(value);
            output[1] = _naga_roundf(2u) + roundf_bits(3);
        }",
    );
}

#[test]
fn cuda_roundf_snapshots_helper_arguments_once_and_preserves_selected_control_flow() {
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void kernel(float *output) {
            float value = -1.5f;
            output[0] = pair(roundf(next(value++)), value++); output[1] = value;
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
            float value = -1.5f;
            output[0] = choose ? roundf(next(value)) : roundf(next(value));
            bool skipped = false && roundf(next(value));
            bool ready = true || roundf(next(value));
            output[1] = value; output[2] = int(skipped) + int(ready);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[3] = roundf(next(value));
            }
        }",
    );
}

#[test]
fn cuda_roundf_is_not_a_source_constant_expression() {
    for source in [
        "constexpr float Rounded = roundf(2.5f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float rounded = roundf(2.5f); }",
        "__global__ void kernel() { const int count = int(roundf(2.5f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (roundf(2.5f), 3); }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<int(roundf(2.5f))>(); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Rounded = true ? 9.0f : roundf(-1.5f);
        __global__ void kernel(int *output) {
            constexpr int Count = false && roundf(-1.5f) ? 2 : 3;
            int values[Count]{}; output[0] = int(Rounded) + values[0];
        }",
    );
}

#[test]
fn cuda_roundf_rejects_invalid_arguments_mutation_and_invalid_dead_source() {
    roundtrip("__global__ void kernel() { return; roundf(-1.5f); }");
    for statement in [
        "roundf();",
        "roundf(1.0f, 2.0f);",
        "roundf(make_float2(1.0f, 2.0f));",
        "float values[2]{}; roundf(values);",
        "roundf(output);",
        "roundf(4.0);",
        "round(4.0f);",
        "__roundf(4.0f);",
        "roundf(1.0f) = 3.0f;",
        "++roundf(1.0f);",
        "roundf(1.0f)++;",
        "return; roundf(missing);",
        "return; roundf(1.0f, 2.0f);",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
    let source = "__device__ void empty() {} __global__ void kernel() { roundf(empty()); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "empty()"
    );
}

#[test]
fn cuda_roundf_keeps_half_neighbors_subnormals_and_exceptional_bit_patterns_runtime() {
    let mut source = String::from("__global__ void kernel(unsigned *output) {");
    for (index, bits) in [
        0x0000_0000u32,
        0x8000_0000,
        0x0000_0001,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x3eff_ffff,
        0x3f00_0000,
        0x3f00_0001,
        0xbeff_ffff,
        0xbf00_0000,
        0xbf00_0001,
        0x3fbf_ffff,
        0x3fc0_0000,
        0x3fc0_0001,
        0xbfbf_ffff,
        0xbfc0_0000,
        0xbfc0_0001,
        0x4020_0000,
        0xc020_0000,
        0x4aff_ffff,
        0xcaff_ffff,
        0x4b00_0000,
        0xcb00_0000,
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
            "output[{index}] = __float_as_uint(roundf(__uint_as_float({bits}u)));"
        ));
    }
    source.push('}');
    roundtrip(&source);
}

#[test]
fn cuda_roundf_bounds_nesting_and_keeps_flat_cached_calls_linear() {
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("roundf({expression})");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("roundf({expression})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = roundf(value); }",
    );
    let statements = "output[0] = roundf(value);".repeat(128);
    let (many, _) = roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ {statements} }}"
    ));
    assert_eq!(single.functions.len(), 1);
    assert_eq!(many.functions.len(), 1);
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
}
