use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
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
fn cuda_class_values_copy_and_value_initialize_supported_vectors() {
    for scalar in ["int", "uint", "float"] {
        for width in 2..=4 {
            let vector = format!("{scalar}{width}");
            roundtrip(&format!(
                "using Vector = {vector};
                __global__ void kernel(unsigned *output) {{
                    const Vector source{{3, 5}};
                    auto functional = Vector(source);
                    auto named = static_cast<Vector>(source);
                    auto c_style = (Vector)source;
                    auto zero = Vector();
                    functional.x = 7; named.y = 11; c_style.x = 13;
                    output[0] = unsigned(source.x + source.y);
                    output[1] = unsigned(functional.x + named.y + c_style.x);
                    output[2] = unsigned(zero.x + zero.y);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_class_values_copy_nested_records_and_preserve_constructor_defaults() {
    roundtrip(
        "struct Leaf { unsigned values[2]; dim3 shape; };
        struct Record { Leaf leaves[2]; float3 point; };
        using Alias = Record;
        __device__ Record produce(unsigned &counter) {
            ++counter;
            return Record{{{{counter, counter + 1u}, dim3(counter, 3u, 5u)}, {}}, {7, 11, 13}};
        }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            const Record source = produce(counter);
            auto functional = Alias(source);
            auto named = static_cast<Alias>(source);
            auto c_style = (Alias)source;
            auto zero = Alias();
            functional.leaves[0].values[0] = 17u;
            named.leaves[0].shape.y = 19u;
            c_style.point.z = 23;
            auto called = Record(produce(counter));
            auto comma = static_cast<Record>(++counter, produce(counter));
            output[0] = source.leaves[0].values[0];
            output[1] = functional.leaves[0].values[0];
            output[2] = named.leaves[0].shape.y;
            output[3] = unsigned(c_style.point.z);
            output[4] = zero.leaves[0].values[0] + unsigned(zero.point.x);
            output[5] = zero.leaves[0].shape.x + zero.leaves[1].shape.z;
            output[6] = counter + called.leaves[0].values[0] + comma.leaves[0].values[0];
        }",
    );
}

#[test]
fn cuda_class_values_retain_target_constness_for_reference_deduction() {
    roundtrip(
        "struct Record { unsigned value; };
        using Frozen = const Record;
        using FrozenVector = const int2;
        template<typename Value> __device__ unsigned inspect_record(Value &value) {
            return value.value;
        }
        template<typename Value> __device__ unsigned inspect_vector(Value &value) {
            return unsigned(value.x);
        }
        __global__ void kernel(unsigned *output) {
            const Record source{3u};
            const int2 vector{5, 7};
            output[0] = inspect_record(Frozen(source));
            output[1] = inspect_record(static_cast<Frozen>(source));
            output[2] = inspect_record((Frozen)source);
            output[3] = inspect_vector(FrozenVector(vector));
            output[4] = inspect_vector(static_cast<FrozenVector>(vector));
            output[5] = inspect_vector((FrozenVector)vector);
            auto copied = Record(source);
            auto copied_vector = int2(vector);
            copied.value = 11u; copied_vector.x = 13;
            output[6] = copied.value + unsigned(copied_vector.x);
        }",
    );
}

#[test]
fn cuda_class_values_do_not_inherit_constness_from_copied_sources() {
    for (definition, member) in [
        ("struct Value { unsigned value; };", "value"),
        ("using Value = int2;", "x"),
        ("using Value = dim3;", "x"),
    ] {
        for expression in [
            "Value(source)",
            "static_cast<Value>(source)",
            "(Value)source",
        ] {
            rejected(&format!(
                "{definition}
                template<class Input> __device__ unsigned selected(Input &input) {{
                    return unsigned(input.{member});
                }}
                __global__ void kernel(unsigned *output) {{
                    const Value source{{}};
                    output[0] = selected({expression});
                }}"
            ));
        }
    }
    for expression in ["Frozen(0u)", "static_cast<Frozen>(0u)", "(Frozen)0u"] {
        rejected(&format!(
            "using Frozen = const unsigned;
            template<class Input> __device__ unsigned selected(Input &input) {{ return input; }}
            __global__ void kernel(unsigned *output) {{ output[0] = selected({expression}); }}"
        ));
    }
}

#[test]
fn cuda_class_values_preserve_comma_calls_and_selected_source_views() {
    roundtrip(
        "struct Record { unsigned value; unsigned values[2]; };
        __device__ Record produce(unsigned &counter) {
            ++counter; return Record{counter, {counter + 1u, counter + 2u}};
        }
        __global__ void kernel(unsigned *output, unsigned condition) {
            unsigned counter = 0u;
            Record first = Record(produce(counter));
            Record second = static_cast<Record>(++counter, produce(counter));
            Record third = (Record)(++counter, produce(counter));
            Record fourth = Record((++counter, produce(counter)));
            const Record &view = static_cast<Record>(condition ? first : third);
            Record selected = Record(condition ? second : fourth);
            selected.values[0] = 29u;
            output[0] = counter;
            output[1] = first.value; output[2] = second.value;
            output[3] = third.value; output[4] = fourth.value;
            output[5] = view.value; output[6] = selected.values[0];
        }",
    );
    for expression in [
        "Record(++counter, source)",
        "static_cast<Record>(source, source)",
        "int2(++counter, vector)",
    ] {
        let source = format!(
            "struct Record {{ unsigned value; }};
            __global__ void kernel() {{
                unsigned counter = 0u; Record source{{3u}}; int2 vector{{5, 7}};
                auto copied = {expression};
            }}"
        );
        if expression.starts_with("static_cast") {
            roundtrip(&source);
        } else {
            rejected(&source);
        }
    }
}

#[test]
fn cuda_class_values_keep_declaration_ambiguity_and_original_spans() {
    for declaration in [
        "Record copied(Record(source));",
        "Alias copied(Alias(source));",
        "auto copied(Record(source));",
        "int2 copied(int2(vector));",
        "uint3 copied(uint3());",
    ] {
        let source = format!(
            "/* café 漢 */ struct Record {{ unsigned value; }}; using Alias = Record;
            __global__ void kernel() {{
                Record source{{3u}}; int2 vector{{5, 7}}; {declaration}
            }}"
        );
        let opening = source.find("copied(").unwrap() + "copied".len();
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
        assert_eq!(
            error.span.to_range(),
            Some(opening..opening + 1),
            "{source}: {error}"
        );
    }
    for declaration in ["Record(source);", "int2(vector);"] {
        rejected(&format!(
            "struct Record {{ unsigned value; }};
            __global__ void kernel() {{ Record source{{3u}}; int2 vector{{5, 7}}; {declaration} }}"
        ));
    }
    roundtrip(
        "struct Record { unsigned value; };
        __global__ void kernel(unsigned *output) {
            Record source{3u};
            Record copied((Record(source)));
            auto inferred = static_cast<Record>(source);
            const Record &view = (Record)source;
            output[0] = copied.value + inferred.value + view.value;
        }",
    );
}

#[test]
fn cuda_class_values_reject_unrelated_and_volatile_class_sources() {
    for target in ["int2", "Record"] {
        for expression in [
            format!("{target}(source)"),
            format!("static_cast<{target}>(source)"),
            format!("({target})source"),
        ] {
            roundtrip(&format!(
                "struct Record {{ unsigned value; }}; struct First {{ unsigned value; }};
                __global__ void kernel() {{ unsigned source = 3u; auto copied = {expression}; }}"
            ));
        }
    }
    for (declaration, target) in [
        ("uint2 source{3u, 5u};", "int2"),
        ("int3 source{3, 5, 7};", "int2"),
        ("First source{3u};", "Record"),
        ("Record *source = nullptr;", "Record"),
        ("Record source[1]{};", "Record"),
    ] {
        for expression in [
            format!("{target}(source)"),
            format!("static_cast<{target}>(source)"),
            format!("({target})source"),
        ] {
            rejected(&format!(
                "struct Record {{ unsigned value; }}; struct First {{ unsigned value; }};
                __global__ void kernel() {{ {declaration} auto copied = {expression}; }}"
            ));
        }
    }
    for expression in ["Record(3u, 5u)", "int2(3, 5)"] {
        roundtrip(&format!(
            "struct Record {{ unsigned first; unsigned second; }};
            __global__ void kernel() {{ auto copied = {expression}; }}"
        ));
    }
    for expression in ["Record(nullptr)", "int2(nullptr)"] {
        rejected(&format!(
            "struct Record {{ unsigned first; unsigned second; }};
            __global__ void kernel() {{ auto copied = {expression}; }}"
        ));
    }
    for expression in [
        "static_cast<volatile Record>(source)",
        "(volatile Record)source",
        "Frozen(source)",
    ] {
        rejected(&format!(
            "struct Record {{ unsigned value; }}; using Frozen = volatile Record;
            __global__ void kernel() {{ Record source{{3u}}; auto copied = {expression}; }}"
        ));
    }
    for (source_type, target) in [
        ("Record", "Record"),
        ("int2", "int2"),
        ("uint3", "dim3"),
        ("dim3", "uint3"),
    ] {
        for expression in [
            format!("{target}(source[0])"),
            format!("static_cast<{target}>(source[0])"),
            format!("({target})source[0]"),
        ] {
            rejected(&format!(
                "struct Record {{ unsigned value; }};
                __global__ void kernel(volatile {source_type} *source) {{ auto copied = {expression}; }}"
            ));
        }
    }
    let source = "__global__ void kernel(unsigned *output, volatile unsigned *input) {
        dim3 first = dim3(input[0]);
        dim3 second = static_cast<dim3>(input[0]);
        dim3 third = (dim3)input[0];
        output[0] = first.x + second.x + third.x;
        output[1] = unsigned(static_cast<int>(input[0]));
    }";
    let capabilities = naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE;
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        source,
        &Options::default(),
        capabilities,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = (module, info);
}

#[test]
fn cuda_class_values_separate_value_initialization_from_constant_eligibility() {
    roundtrip(
        "struct Trivial { unsigned values[2]; };
        struct OnlyShape { dim3 shape; };
        struct Mixed { unsigned values[2]; dim3 shape; };
        __global__ void kernel(unsigned *output) {
            constexpr unsigned first = (Trivial(), 3u);
            constexpr unsigned second = (OnlyShape(), 5u);
            Mixed runtime = Mixed();
            output[0] = first + second;
            output[1] = runtime.values[0] + runtime.values[1] + runtime.shape.x;
            output[2] = unsigned(bool(nullptr));
        }",
    );
    rejected(
        "struct Mixed { unsigned values[2]; dim3 shape; };
        __global__ void kernel() { constexpr unsigned count = (Mixed(), 7u); }",
    );
    for expression in [
        "int(0)",
        "static_cast<int>(0)",
        "(int)0",
        "int(static_cast<int2>(int2()).x)",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{ int *pointer = {expression}; }}"
        ));
    }
}

#[test]
fn cuda_class_values_bound_nested_copy_and_cast_expressions() {
    for mode in ["functional", "static", "c_style"] {
        let source = |depth: usize| {
            let mut expression = String::from("Alias()");
            for _ in 0..depth {
                expression = match mode {
                    "functional" => format!("Alias({expression})"),
                    "static" => format!("static_cast<Alias>({expression})"),
                    _ => format!("(Alias)({expression})"),
                };
            }
            format!(
                "struct Record {{ unsigned value; }}; using Alias = Record;
                __global__ void kernel(unsigned *output) {{
                    Alias copied = {expression}; output[0] = copied.value;
                }}"
            )
        };
        roundtrip(&source(8));
        let error = rejected(&source(512));
        assert!(
            error.message.contains("depth") || error.message.contains("nesting"),
            "{mode}: {error}"
        );
    }
}
