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
fn cuda_truncf_converts_scalar_arguments_and_returns_float() {
    for declaration in [
        "bool value = true",
        "int value = -3",
        "unsigned value = 5u",
        "float value = -1.5f",
        "using Sample = const float; Sample value = 2.5f",
    ] {
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(float *output) {{ {declaration}; output[0] = truncf(value); }}"
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
fn cuda_truncf_uses_a_runtime_integer_helper_without_native_rounding_or_double_types() {
    let (module, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = truncf(value); }",
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
        .any(|(_, expression)| super::helpers::is_bitcast_to(
            &module,
            expression,
            naga::Scalar::U32
        )));
}

#[test]
fn cuda_truncf_preserves_aliases_prototypes_overloads_and_name_hiding() {
    roundtrip(
        "using Sample = const float;
        __host__ __device__ float truncf(Sample);
        __device__ float truncf(int value) { return truncf(float(value)); }
        __device__ int truncf(bool value) { return value ? 7 : 9; }
        __device__ int truncf(int first, int second) { return first + second; }
        __device__ float2 truncf(float2 value) {
            return make_float2(truncf(value.x), truncf(value.y));
        }
        __global__ void kernel(float *output) {
            output[0] = truncf(2.5f); output[1] = truncf(3); output[2] = truncf(true);
            { using truncf = int; output[3] = truncf(2.75f); }
            output[4] = truncf(-1.5f); output[5] = truncf(3, 4);
            output[6] = truncf(make_float2(1.5f, -2.5f)).x;
        }",
    );
    let source = "__device__ int truncf(int value) { return value; }
        __global__ void kernel() { truncf(1u); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "truncf");
    for source in [
        "using truncf = int; __global__ void kernel() {}",
        "__global__ void truncf() {}",
        "__global__ void kernel() { int truncf = 1; truncf(1.0f); }",
        "__device__ float helper(int truncf) { return truncf(1.0f); } __global__ void kernel() {}",
        "__device__ float truncf(int value) { return truncf(value); } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_truncf_rejects_canonical_builtin_redefinitions_and_incompatible_prototypes() {
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        let source = format!(
            "/* λ */ using Sample = const float;
            __device__ {result} truncf(Sample value) {{ {body} }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "truncf");
    }
    rejected("__device__ int truncf(float); __global__ void kernel() {}");
    for qualifier in ["const", "volatile", "const volatile"] {
        for result in [format!("{qualifier} float"), String::from("Sample")] {
            let source = format!(
                "using Sample = {qualifier} float; __device__ {result} truncf(float);
                __global__ void kernel() {{}}"
            );
            let error = rejected(&source);
            assert!(
                error.message.contains("incompatible builtin result type"),
                "{error}"
            );
            assert_eq!(&source[error.span.to_range().unwrap()], "truncf");
        }
    }
}

#[test]
fn cuda_truncf_reuses_one_cached_helper_across_callers_instances_and_entry_points() {
    let (module, _) = roundtrip(
        "__device__ float rounded(float value) { return truncf(value); }
        template<int Bias> __device__ float shifted(float value) { return truncf(value) + float(Bias); }
        __global__ void first(float *output, float value) {
            output[0] = truncf(value); output[1] = rounded(value); output[2] = shifted<1>(value);
        }
        __global__ void second(float *output, float value) {
            output[0] = shifted<2>(value); output[1] = truncf(value);
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
fn cuda_truncf_cached_helper_stays_distinct_from_floor_ceiling_and_absolute_value() {
    let (module, _) = roundtrip(
        "__device__ float lower(float value) { return floorf(value); }
        __device__ float upper(float value) { return ceilf(value); }
        __device__ float magnitude(float value) { return fabsf(value); }
        __device__ float nearest(float value) { return roundf(value); }
        __device__ float truncated(float value) { return truncf(value); }
        __global__ void kernel(float *output, float value) {
            output[0] = lower(value); output[1] = upper(value);
            output[2] = magnitude(value); output[3] = nearest(value); output[4] = truncated(value);
        }",
    );
    let mut helpers = Vec::new();
    for caller in ["lower", "upper", "magnitude", "nearest", "truncated"] {
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
    assert_eq!(helpers.len(), 5);
}

#[test]
fn cuda_truncf_keeps_generated_helper_names_independent_of_source_names() {
    roundtrip(
        "__device__ unsigned _naga_truncf(unsigned value) { return value + 40u; }
        __device__ int truncf_bits(int value) { return value + 50; }
        __global__ void kernel(float *output, float value) {
            output[0] = truncf(value);
            output[1] = _naga_truncf(2u) + truncf_bits(3);
        }",
    );
}

#[test]
fn cuda_truncf_snapshots_helper_arguments_once_and_preserves_selected_control_flow() {
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void kernel(float *output) {
            float value = -1.5f;
            output[0] = pair(truncf(next(value++)), value++); output[1] = value;
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
            output[0] = choose ? truncf(next(value)) : truncf(next(value));
            bool skipped = false && truncf(next(value));
            bool ready = true || truncf(next(value));
            output[1] = value; output[2] = int(skipped) + int(ready);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[3] = truncf(next(value));
            }
        }",
    );
}

#[test]
fn cuda_truncf_is_not_a_source_constant_expression() {
    for source in [
        "constexpr float Rounded = truncf(2.5f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float rounded = truncf(2.5f); }",
        "__global__ void kernel() { const int count = int(truncf(2.5f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (truncf(2.5f), 3); }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<int(truncf(2.5f))>(); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Rounded = true ? 9.0f : truncf(-1.5f);
        __global__ void kernel(int *output) {
            constexpr int Count = false && truncf(-1.5f) ? 2 : 3;
            int values[Count]{}; output[0] = int(Rounded) + values[0];
        }",
    );
}

#[test]
fn cuda_truncf_rejects_invalid_arguments_mutation_and_invalid_dead_source() {
    roundtrip("__global__ void kernel() { return; truncf(-1.5f); }");
    for statement in [
        "truncf();",
        "truncf(1.0f, 2.0f);",
        "truncf(make_float2(1.0f, 2.0f));",
        "float values[2]{}; truncf(values);",
        "truncf(output);",
        "truncf(4.0);",
        "trunc(4.0f);",
        "__truncf(4.0f);",
        "truncf(1.0f) = 3.0f;",
        "++truncf(1.0f);",
        "truncf(1.0f)++;",
        "return; truncf(missing);",
        "return; truncf(1.0f, 2.0f);",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
    let source = "__device__ void empty() {} __global__ void kernel() { truncf(empty()); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "empty()"
    );
}

#[test]
fn cuda_truncf_keeps_half_neighbors_subnormals_and_exceptional_bit_patterns_runtime() {
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
            "output[{index}] = __float_as_uint(truncf(__uint_as_float({bits}u)));"
        ));
    }
    source.push('}');
    roundtrip(&source);
}

#[test]
fn cuda_truncf_bounds_nesting_and_keeps_flat_cached_calls_linear() {
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("truncf({expression})");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("truncf({expression})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "__global__ void kernel(float *output, float value) { output[0] = truncf(value); }",
    );
    let statements = "output[0] = truncf(value);".repeat(128);
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

#[test]
fn cuda_truncf_accepts_narrow_and_wide_fixed_scalar_conversions() {
    for declaration in [
        "short value = -3;",
        "unsigned short value = 5;",
        "long value = -7L;",
        "long long value = -9LL;",
    ] {
        let (module, info) = super::helpers::validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(float *out) {{ {declaration} out[0] = truncf(value); }}"
            ),
            &Default::default(),
            naga::valid::Capabilities::SHADER_INT16 | naga::valid::Capabilities::SHADER_INT64,
        );
        let function = &module.entry_points[0].function;
        for (_, expression) in function.expressions.iter() {
            if let naga::Expression::Bitcast { expr, ty } = *expression {
                if module.types[ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32) {
                    assert_eq!(
                        info.get_entry_point(0)[expr].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(naga::Scalar::F32)
                    );
                }
            }
        }
    }
}

#[test]
fn cuda_truncf_reads_a_volatile_argument_once() {
    let (module, _) = super::helpers::validate_with_options_and_capabilities(
        "__global__ void kernel(float *out, const volatile float *input) { out[0] = truncf(input[0]); }",
        &Default::default(), naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let function = &module.entry_points[0].function;
    let reads = function
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
    assert_eq!(reads, 1);
}

#[test]
fn cuda_truncf_uniform_control_survives_forward_and_reference_helper_remapping() {
    roundtrip("__device__ void increment(unsigned &counter) { ++counter; }
        __device__ void synchronize(float value);
        __global__ void first(float value, unsigned *out) { unsigned counter = 0u; increment(counter); out[0] = counter; synchronize(value); if (truncf(value) > 0.0f) __syncthreads(); }
        __device__ void synchronize(float renamed) { if (truncf(renamed) > 0.0f) __syncthreads(); }
        __global__ void second(float value) { synchronize(value); }");
    for source in [
        "__global__ void kernel() { if (truncf(float(threadIdx.x)) > 0.0f) __syncthreads(); }",
        "__device__ float truncf(int value) { return float(value); } __global__ void kernel(float value, float *out) { out[0] = truncf(value); if (truncf(1) > 0.0f) __syncthreads(); }",
        "__device__ unsigned _naga_truncf(unsigned value) { return value; } __global__ void kernel(float value, float *out) { out[0] = truncf(value); if (_naga_truncf(1u)) __syncthreads(); }",
    ] {
        let error = rejected(source);
        assert!(error.message.contains("barrier"), "{source}: {error}");
    }
}
