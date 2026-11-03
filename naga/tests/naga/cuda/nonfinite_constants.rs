use super::helpers::validate;

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate(source);
    for (_, expression) in module
        .global_expressions
        .iter()
        .chain(
            module
                .functions
                .iter()
                .flat_map(|(_, function)| function.expressions.iter()),
        )
        .chain(
            module
                .entry_points
                .iter()
                .flat_map(|entry| entry.function.expressions.iter()),
        )
    {
        assert!(!matches!(
            expression,
            naga::Expression::Literal(naga::Literal::F32(value)) if !value.is_finite()
        ));
    }
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
fn cuda_nonfinite_constants_roundtrip_without_nonfinite_ir_literals() {
    let (module, info) = validate(
        "constexpr float Positive = 1.0f / 0.0f;
        __global__ void kernel(unsigned *output) {
            constexpr float NotANumber = 0.0f / 0.0f;
            output[0] = __float_as_uint(Positive);
            output[1] = __float_as_uint(NotANumber);
            output[2] = unsigned(NotANumber != NotANumber);
        }",
    );
    for (_, expression) in module
        .global_expressions
        .iter()
        .chain(
            module
                .functions
                .iter()
                .flat_map(|(_, function)| function.expressions.iter()),
        )
        .chain(
            module
                .entry_points
                .iter()
                .flat_map(|entry| entry.function.expressions.iter()),
        )
    {
        assert!(!matches!(
            expression,
            naga::Expression::Literal(naga::Literal::F32(value)) if !value.is_finite()
        ));
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_nonfinite_constants_preserve_scalar_aliases_auto_and_global_source_types() {
    let (module, info) = roundtrip(
        "using Sample = const float;
        constexpr Sample Positive = 1.0f / 0.0f;
        constexpr auto Negative = -Positive;
        constexpr float NotANumber = 0.0f / 0.0f;
        constexpr float Finite = 2.0f;
        __global__ void kernel(unsigned *output) {
            constexpr auto local = Positive;
            auto copied = Negative;
            const Sample frozen = NotANumber;
            output[0] = __float_as_uint(local); output[1] = __float_as_uint(copied);
            output[2] = __float_as_uint(frozen); output[3] = __float_as_uint(Finite);
        }",
    );
    for name in ["Positive", "Negative", "NotANumber"] {
        let physical_name = format!("{name}_bits");
        let constant = module
            .constants
            .iter()
            .find_map(|(_, constant)| {
                (constant.name.as_deref() == Some(physical_name.as_str())).then_some(constant)
            })
            .unwrap();
        assert_eq!(
            module.types[constant.ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    let finite = module
        .constants
        .iter()
        .find_map(|(_, constant)| (constant.name.as_deref() == Some("Finite")).then_some(constant))
        .unwrap();
    assert_eq!(
        module.types[finite.ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::F32)
    );
    let function = &module.entry_points[0].function;
    for name in ["local", "copied", "frozen"] {
        let value = super::helpers::source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
}

#[test]
fn cuda_nonfinite_constants_fold_unary_comparison_and_boolean_operations() {
    roundtrip(
        "constexpr float Positive = 1.0f / 0.0f;
        constexpr float Negative = -Positive;
        constexpr float NotANumber = 0.0f / 0.0f;
        constexpr bool InfiniteIsTrue = bool(Positive);
        constexpr bool NegativeIsTrue = bool(Negative);
        constexpr bool NaNIsTrue = bool(NotANumber);
        constexpr bool NaNIsUnordered = NotANumber != NotANumber;
        constexpr bool NaNIsNotEqual = !(NotANumber == NotANumber);
        constexpr bool InfiniteIsOrdered = Positive > Negative;
        __global__ void kernel(unsigned *output) {
            constexpr bool Less = NotANumber < Positive;
            constexpr bool AtMost = NotANumber <= Positive;
            constexpr bool Greater = NotANumber > Negative;
            constexpr bool AtLeast = NotANumber >= Negative;
            constexpr bool SignedZerosAreEqual = (1.0f / Positive) == (1.0f / Negative);
            output[0] = unsigned(InfiniteIsTrue) + unsigned(NegativeIsTrue) + unsigned(NaNIsTrue);
            output[1] = unsigned(NaNIsUnordered) + unsigned(NaNIsNotEqual) + unsigned(InfiniteIsOrdered);
            output[2] = unsigned(Less) + unsigned(AtMost) + unsigned(Greater) + unsigned(AtLeast);
            output[3] = unsigned(SignedZerosAreEqual);
            output[4] = __float_as_uint(-NotANumber);
        }",
    );
}

#[test]
fn cuda_nonfinite_constants_recover_finite_values_and_integral_bounds() {
    let (module, _) = roundtrip(
        "constexpr float Positive = 1.0f / 0.0f;
        constexpr float NotANumber = 0.0f / 0.0f;
        constexpr float Recovered = 1.0f / Positive;
        constexpr float Selected = NotANumber ? 4.0f : 5.0f;
        template<int Count> __device__ int selected() { return Count; }
        __global__ void kernel(unsigned *output) {
            constexpr int Count = int(Recovered) + 2;
            constexpr int UnorderedCount = int(NotANumber != NotANumber) + 2;
            int values[Count]{}; int unordered[UnorderedCount]{};
            output[0] = __float_as_uint(Recovered); output[1] = __float_as_uint(1.0f / -Positive);
            output[2] = __float_as_uint(Selected); output[3] = selected<(Positive > 0.0f ? 4 : 2)>();
            output[4] = values[1] + unordered[2];
        }",
    );
    let function = &module.entry_points[0].function;
    for (name, expected) in [("values", 2), ("unordered", 3)] {
        let local = function
            .local_variables
            .iter()
            .find_map(|(_, variable)| (variable.name.as_deref() == Some(name)).then_some(variable))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            ..
        } = module.types[local.ty].inner
        else {
            panic!("expected fixed source array {name}");
        };
        assert_eq!(count.get(), expected);
    }
    for expression in [
        "(1.0f / 0.0f) - (1.0f / 0.0f)",
        "(1.0f / 0.0f) + (-1.0f / 0.0f)",
        "(1.0f / 0.0f) * 0.0f",
        "(1.0f / 0.0f) / (1.0f / 0.0f)",
        "(0.0f / 0.0f) + 1.0f",
        "(0.0f / 0.0f) * 0.0f",
        "0x1.fffffep127f * 2.0f",
    ] {
        roundtrip(&format!(
            "constexpr float Value = {expression};
            __global__ void kernel(unsigned *output) {{ output[0] = __float_as_uint(Value); }}"
        ));
    }
}

#[test]
fn cuda_nonfinite_constants_keep_float_overload_resolution_and_helper_parameters() {
    let (module, _) = roundtrip(
        "constexpr float Positive = 1.0f / 0.0f;
        __device__ int choose(float);
        __device__ int choose(unsigned);
        __device__ float observe(const float &value) { return value; }
        __global__ void kernel(int *output) {
            auto copied = Positive;
            output[0] = choose(Positive); output[1] = choose(copied);
            output[2] = choose(observe(copied));
        }
        __device__ int choose(float value) { return 1; }
        __device__ int choose(unsigned value) { return 2; }",
    );
    let float_overloads: Vec<_> = module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (function.arguments.len() == 1
                && module.types[function.arguments[0].ty].inner
                    == naga::TypeInner::Scalar(naga::Scalar::F32)
                && function.result.as_ref().is_some_and(|result| {
                    module.types[result.ty].inner == naga::TypeInner::Scalar(naga::Scalar::I32)
                }))
            .then_some(handle)
        })
        .collect();
    assert_eq!(float_overloads.len(), 1);
    let mut chosen_calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if matches!(*statement, naga::Statement::Call { function, .. } if function == float_overloads[0])
        {
            chosen_calls += 1;
        }
        false
    });
    assert_eq!(chosen_calls, 3);
}

#[test]
fn cuda_nonfinite_constants_preserve_lazy_selection_comma_and_runtime_effects() {
    roundtrip(
        "constexpr int Discarded = (1.0f / 0.0f, 0.0f / 0.0f, 3);
        constexpr float Selected = true ? 4.0f : 0.0f / 0.0f;
        __global__ void kernel(unsigned *output, int runtime) {
            constexpr bool Skipped = false && (0.0f / 0.0f);
            constexpr bool Ready = true || (0.0f / 0.0f);
            constexpr int Count = true ? Discarded : runtime;
            int values[Count]{};
            output[0] = unsigned(Skipped) + unsigned(Ready) + values[2];
            output[1] = __float_as_uint(Selected);
        }",
    );
    let (module, _) = roundtrip(
        "__device__ float next(float value) { return value; }
        __global__ void kernel(unsigned *output) {
            float value = 1.0f;
            output[0] = __float_as_uint((next(value++), 1.0f / 0.0f));
            output[1] = __float_as_uint(value);
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
    assert_eq!(next_calls, 1);
    for source in [
        "__device__ void touch() {} __global__ void kernel() { constexpr float Value = (touch(), 1.0f / 0.0f); }",
        "__global__ void kernel() { int runtime = 0; constexpr float Value = (runtime++, 1.0f / 0.0f); }",
        "__global__ void kernel() { constexpr float Value = true ? 1.0f / 0.0f : missing; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nonfinite_constants_initialize_existing_float_aggregate_forms() {
    roundtrip(
        "constexpr float Positive = 1.0f / 0.0f;
        constexpr float NotANumber = 0.0f / 0.0f;
        struct Samples { float first; float second; };
        __global__ void kernel(unsigned *output) {
            const float values[]{Positive, -Positive, NotANumber};
            Samples samples{Positive, NotANumber};
            float2 pair = make_float2(Positive, -Positive);
            output[0] = __float_as_uint(values[0]); output[1] = __float_as_uint(values[1]);
            output[2] = __float_as_uint(values[2]); output[3] = __float_as_uint(samples.first);
            output[4] = __float_as_uint(samples.second); output[5] = __float_as_uint(pair.y);
        }",
    );
}

#[test]
fn cuda_nonfinite_constants_reject_invalid_integer_casts_and_narrowing() {
    for scalar in ["int", "unsigned"] {
        for expression in [
            "1.0f / 0.0f",
            "-1.0f / 0.0f",
            "0.0f / 0.0f",
            "0x1.fffffep127f * 2.0f",
        ] {
            for declaration in [
                format!("constexpr {scalar} Invalid = {scalar}({expression});"),
                format!("constexpr auto Invalid = {scalar}({expression});"),
            ] {
                rejected(&format!(
                    "{declaration} __global__ void kernel(unsigned *output) {{ output[0] = unsigned(Invalid); }}"
                ));
                rejected(&format!(
                    "__global__ void kernel(unsigned *output) {{ {declaration} output[0] = unsigned(Invalid); }}"
                ));
            }
        }
    }
    for scalar in ["int", "unsigned", "bool"] {
        for expression in ["1.0f / 0.0f", "0.0f / 0.0f"] {
            rejected(&format!(
                "constexpr {scalar} Invalid{{{expression}}}; __global__ void kernel() {{}}"
            ));
            rejected(&format!(
                "__global__ void kernel() {{ {scalar} values[]{{{expression}}}; }}"
            ));
        }
    }
}

#[test]
fn cuda_nonfinite_constants_keep_integral_positive_array_and_template_bounds() {
    for source in [
        "constexpr float Positive = 1.0f / 0.0f; __global__ void kernel() { int values[Positive]; }",
        "__global__ void kernel() { int values[int(1.0f / 0.0f)]; }",
        "__global__ void kernel() { int values[(1.0f / 0.0f) > 0.0f ? 0 : 1]; }",
        "__global__ void kernel() { int values[(0.0f / 0.0f) == 0.0f ? 1 : -1]; }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<int(0.0f / 0.0f)>(); }",
        "template<int Count> __device__ int selected() { return Count; } __global__ void kernel() { selected<1.0f / 0.0f>(); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nonfinite_constants_preserve_source_qualification_and_constant_eligibility() {
    for source in [
        "__global__ void kernel() { float value = 1.0f / 0.0f; constexpr float Invalid = value; }",
        "__global__ void kernel() { const float value = 1.0f / 0.0f; constexpr float Invalid = value; }",
        "__global__ void kernel() { constexpr volatile float Invalid = 1.0f / 0.0f; }",
        "__device__ float known() { return 1.0f / 0.0f; } __global__ void kernel() { constexpr float Invalid = known(); }",
        "constexpr float Global = 1.0f / 0.0f; __device__ float observe(const float &value) { return value; } __global__ void kernel() { observe(Global); }",
        "__global__ void kernel() { constexpr float Value = 1.0f / 0.0f; Value = 2.0f; }",
        "__global__ void kernel() { return; constexpr float Invalid = missing; }",
        "__global__ void kernel() { constexpr int Invalid = (1 / 0, 2); }",
        "__global__ void kernel() { constexpr int Invalid = 2147483647 + 1; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nonfinite_constants_materialize_float_values_through_integer_local_loads() {
    let (module, _) = roundtrip(
        "constexpr unsigned Positive_bits = 7u;
        constexpr float Positive = 1.0f / 0.0f;
        __global__ void kernel(unsigned *output) {
            unsigned nonfinite_bits = 3u;
            output[0] = __float_as_uint(Positive);
            { constexpr float Positive = -1.0f / 0.0f; output[1] = __float_as_uint(Positive); }
            output[2] = nonfinite_bits;
            output[3] = Positive_bits;
        }",
    );
    assert!(module.functions.is_empty());
    let function = &module.entry_points[0].function;
    assert!(function.expressions.iter().any(|(_, expression)| {
        let naga::Expression::As {
            expr,
            kind: naga::ScalarKind::Float,
            convert: None,
        } = *expression
        else {
            return false;
        };
        let naga::Expression::Load { pointer } = function.expressions[expr] else {
            return false;
        };
        let naga::Expression::LocalVariable(local) = function.expressions[pointer] else {
            return false;
        };
        module.types[function.local_variables[local].ty].inner
            == naga::TypeInner::Scalar(naga::Scalar::U32)
    }));
}

#[test]
fn cuda_nonfinite_constants_bound_nested_source_and_flat_materialization_growth() {
    let mut expression = String::from("1.0f / 0.0f");
    for _ in 0..8 {
        expression = format!("({expression} + 1.0f)");
    }
    roundtrip(&format!(
        "__global__ void kernel(unsigned *output) {{ constexpr float Value = {expression}; output[0] = __float_as_uint(Value); }}"
    ));
    for _ in 0..80 {
        expression = format!("({expression} + 1.0f)");
    }
    let error = rejected(&format!(
        "__global__ void kernel() {{ constexpr float Value = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = roundtrip(
        "constexpr float Positive = 1.0f / 0.0f; __global__ void kernel(unsigned *output) { output[0] = __float_as_uint(Positive); }",
    );
    let statements = "output[0] = __float_as_uint(Positive);".repeat(128);
    let (many, _) = roundtrip(&format!(
        "constexpr float Positive = 1.0f / 0.0f; __global__ void kernel(unsigned *output) {{ {statements} }}"
    ));
    assert!(single.functions.is_empty() && many.functions.is_empty());
    assert_eq!(single.types.len(), many.types.len());
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
}

#[test]
fn cuda_nonfinite_constants_preserve_float_reads_after_runtime_comma_effects() {
    let (module, info) = roundtrip(
        "constexpr float Positive = 1.0f / 0.0f;
        constexpr float NotANumber = 0.0f / 0.0f;
        __device__ int next(int value) { return value; }
        __global__ void kernel(unsigned *output, int runtime) {
            int counter = 0;
            float first = (counter++, Positive);
            auto second = (counter++, NotANumber);
            float selected = runtime ? (next(counter++), Positive) : (next(counter++), NotANumber);
            output[0] = __float_as_uint(first); output[1] = __float_as_uint(second);
            output[2] = __float_as_uint(selected); output[3] = unsigned(counter);
        }",
    );
    let function = &module.entry_points[0].function;
    for name in ["first", "second", "selected"] {
        let value = super::helpers::source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
    let mut next_calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function].name.as_deref() == Some("next") {
                next_calls += 1;
            }
        }
        false
    });
    assert_eq!(next_calls, 2);
    for source in [
        "constexpr float Positive = 1.0f / 0.0f; __global__ void kernel(int runtime) { constexpr float Invalid = (runtime++, Positive); }",
        "constexpr float NotANumber = 0.0f / 0.0f; __global__ void kernel(int runtime) { constexpr auto Invalid = (runtime++, NotANumber); }",
    ] {
        rejected(source);
    }
}
