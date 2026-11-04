use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate};

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

#[test]
fn cuda_direct_scalar_initializers_keep_declared_types_and_numeric_conversions() {
    for (declaration, scalar) in [
        ("int value(3.75f);", naga::Scalar::I32),
        ("unsigned value(3);", naga::Scalar::U32),
        ("float value(7);", naga::Scalar::F32),
        ("bool value(2);", naga::Scalar::BOOL),
    ] {
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{ {declaration} output[0] = unsigned(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let value = source_binding_initializer(function, "value");
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar),
        );
    }
}

#[test]
fn cuda_direct_scalar_initializers_support_aliases_and_constant_declarations() {
    roundtrip(
        "using Count = const unsigned;
        constexpr int GlobalCount(3.75f);
        constexpr float GlobalScale(2);
        constexpr bool GlobalEnabled(2);
        __global__ void kernel(unsigned *output) {
            Count count(4);
            const int truncated(1.75f);
            constexpr int local(GlobalCount + 2);
            constexpr unsigned extent(3);
            int values[extent]{7, 11, 13};
            output[0] = unsigned(GlobalCount);
            output[1] = unsigned(GlobalScale);
            output[2] = unsigned(GlobalEnabled);
            output[3] = count + unsigned(truncated + local + values[2]);
        }",
    );
}

#[test]
fn cuda_direct_scalar_initializers_preserve_mixed_declaration_and_inner_comma_order() {
    roundtrip(
        "__device__ int next(int &counter) { ++counter; return counter * 3; }
        __global__ void kernel(int *output) {
            int counter(0);
            int first(next(counter)), second((counter += 2, next(counter))), third = next(counter);
            float previous(counter), current((counter = 9, counter));
            output[0] = first;
            output[1] = second;
            output[2] = third;
            output[3] = int(previous);
            output[4] = int(current);
            output[5] = counter;
        }",
    );
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_direct_scalar_initializers_use_ordinary_conversion_while_braces_reject_narrowing() {
    for (parenthesized, braced) in [
        ("int value(-3.75f);", "int value{-3.75f};"),
        ("unsigned value(3.75f);", "unsigned value{3.75f};"),
        ("unsigned value(-1);", "unsigned value{-1};"),
        ("bool value(2);", "bool value{2};"),
        ("float value(16777217);", "float value{16777217};"),
    ] {
        roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{ {parenthesized} output[0] = unsigned(value); }}"
        ));
        rejected(&format!("__global__ void kernel() {{ {braced} }}"));
    }
    roundtrip(
        "__global__ void kernel(int *output, unsigned count, float fraction) {
            int truncated(fraction);
            float rounded(count);
            output[0] = truncated;
            output[1] = int(rounded);
        }",
    );
    rejected("__global__ void kernel(unsigned count) { float rounded{count}; }");
    rejected("__global__ void kernel(float fraction) { int truncated{fraction}; }");
}

#[test]
fn cuda_direct_scalar_initializers_keep_nullptr_boolean_conversion_contexts_separate() {
    roundtrip(
        "using Flag = bool;
        using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            auto empty = nullptr;
            Flag literal(nullptr);
            Flag named(empty);
            Flag constructed(Null(0));
            unsigned storage[1]{7u};
            unsigned *pointer = storage;
            unsigned *missing = nullptr;
            Flag present(pointer);
            Flag absent(missing);
            output[0] = unsigned(literal || named || constructed);
            output[1] = unsigned(present && !absent);
        }",
    );
    for source in [
        "__global__ void kernel() { bool value = nullptr; }",
        "__global__ void kernel() { bool value = {nullptr}; }",
        "__device__ void consume(bool value) {} __global__ void kernel() { consume(nullptr); }",
        "__device__ bool returned() { return nullptr; } __global__ void kernel() { returned(); }",
        "__global__ void kernel() { int value(nullptr); }",
        "__global__ void kernel() { unsigned value(nullptr); }",
        "__global__ void kernel() { float value(nullptr); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_direct_scalar_initializers_reject_multiple_arguments_at_the_outer_comma() {
    for scalar in ["bool", "int", "unsigned", "float"] {
        for arguments in ["1, 2", "1,"] {
            let source = format!(
                "/* café 漢 */ __global__ void kernel() {{ {scalar} value({arguments}); }}"
            );
            let comma = source.find(',').unwrap();
            let error = rejected(&source);
            assert_eq!(
                error.span.to_range(),
                Some(comma..comma + 1),
                "{source}: {error}"
            );
        }
    }
}

#[test]
fn cuda_direct_scalar_initializers_preserve_constness_and_constant_expression_provenance() {
    for source in [
        "__global__ void kernel() { const int value(2); value = 3; }",
        "__global__ void kernel(int input) { constexpr int value(input); }",
        "__global__ void kernel(int input) { const int ordinary(input); constexpr int value(ordinary); }",
        "__global__ void kernel() { const float ordinary(1.0f); constexpr float value(ordinary); }",
        "__device__ int runtime() { return 3; } constexpr int value(runtime()); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr int value(2147483648.0f); }",
        "__global__ void kernel() { constexpr unsigned value(-1.0f); }",
    ] {
        rejected(source);
    }
    for declaration in [
        "int zero(0);",
        "const int zero(0);",
        "constexpr int zero(0);",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{ {declaration} int *pointer = zero; }}"
        ));
    }
    roundtrip(
        "__global__ void kernel(int *output) {
            const int extent(3.75f);
            constexpr int selected(true ? 4 : (1 / 0));
            int values[extent]{7, 11, 13};
            output[0] = values[2] + selected;
        }",
    );
}

#[test]
fn cuda_direct_scalar_initializers_reject_function_parameter_declaration_interpretations() {
    for declaration in [
        "int value();",
        "int value(int(seed));",
        "unsigned value(unsigned(seed));",
        "float value(float(seed));",
        "bool value(bool(seed));",
        "int value(int());",
        "int value(int(factory()));",
        "int value(int(*pointer));",
        "int value(int(array[2]));",
        "int value(int(*pointer)[2]);",
        "Integer value(Integer(seed));",
        "int value(const Integer(seed));",
    ] {
        let source = format!(
            "using Integer = int;
            __global__ void kernel() {{ int seed = 3; int array[2]{{5, 7}}; int *pointer = array; {declaration} }}"
        );
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
    }
    for declaration in ["int value(int(*)());", "int value(int[2]);"] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_direct_scalar_initializers_keep_forced_expressions_and_nested_calls() {
    roundtrip(
        "using Integer = int;
        __device__ int observe(int &counter) { ++counter; return counter; }
        __global__ void kernel(int *output) {
            int seed(3);
            int counter(0);
            int direct(observe(counter));
            int nested(int(observe(counter)));
            int forced((int(seed)));
            Integer alias((Integer(seed)));
            float fraction(float(3.75f));
            bool enabled(bool(2));
            output[0] = counter;
            output[1] = direct + nested + forced + alias;
            output[2] = int(fraction) + int(enabled);
        }",
    );
}

#[test]
fn cuda_direct_scalar_initializers_mix_pointer_reference_and_loop_declarators() {
    roundtrip(
        "__global__ void kernel(int *output) {
            int first(1), second = 2, third{3}, *pointer = &first, &alias = second;
            int total(0);
            for (int index(0), limit(3); index < limit; ++index) total += index;
            output[0] = *pointer + alias + third + total;
        }",
    );
    rejected(
        "__global__ void kernel() {
            for (int index(0), limit(3); index < limit; ++index) {}
            int outside(index);
        }",
    );
}

#[test]
fn cuda_direct_scalar_initializers_keep_expression_and_declaration_lookahead_depth_bounded() {
    for scalar in ["bool", "int", "unsigned", "float"] {
        let source = |depth: usize| {
            format!(
                "__global__ void kernel(unsigned *output) {{
                {scalar} value({}1{}); output[0] = unsigned(value);
            }}",
                format!("{scalar}(").repeat(depth),
                ")".repeat(depth),
            )
        };
        roundtrip(&source(8));
        let error = rejected(&source(512));
        assert!(
            error.message.contains("limit") || error.message.contains("nesting"),
            "{error}"
        );
    }
    for depth in [8, 512] {
        let mut parameter = String::from("int()");
        for _ in 0..depth {
            parameter = format!("int({parameter})");
        }
        let source = format!("__global__ void kernel() {{ int value({parameter}); }}");
        let error = rejected(&source);
        if depth == 8 {
            assert!(error.message.contains("function declaration"), "{error}");
        } else {
            assert!(
                error.message.contains("limit") || error.message.contains("nesting"),
                "{error}"
            );
        }
    }
}

#[test]
fn cuda_direct_scalar_initializers_keep_other_declarators_and_storage_rejections() {
    roundtrip("__global__ void kernel() { float2 value(1.0f, 2.0f); }");
    roundtrip("__global__ void kernel() { int values[2](1); }");
    for statement in [
        "int(value);",
        "int((value));",
        "int first = 1, (second);",
        "int first(1),;",
        "int first(1), second; trailing;",
        "int value({1});",
        "int value((1);",
        "int value(1));",
        "volatile int value(2);",
    ] {
        rejected(&format!("__global__ void kernel() {{ {statement} }}"));
    }
    for source in [
        "__global__ void kernel() { auto first(1), second(2u); }",
        "__global__ void kernel() { auto value(1, 2); }",
    ] {
        rejected(source);
    }
}
