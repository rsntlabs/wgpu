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
fn cuda_empty_scalar_constructors_keep_exact_zero_types_and_values() {
    for (name, scalar, literal) in [
        ("bool", naga::Scalar::BOOL, naga::Literal::Bool(false)),
        ("int", naga::Scalar::I32, naga::Literal::I32(0)),
        ("unsigned", naga::Scalar::U32, naga::Literal::U32(0)),
        ("float", naga::Scalar::F32, naga::Literal::F32(0.0)),
    ] {
        let (module, info) = roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{
                auto value = {name}(); output[0] = unsigned(value);
            }}"
        ));
        let function = &module.entry_points[0].function;
        let value = source_binding_initializer(function, "value");
        assert_eq!(
            function.expressions[value],
            naga::Expression::Literal(literal)
        );
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar),
        );
    }
}

#[test]
fn cuda_empty_scalar_constructors_support_qualified_aliases_and_template_values() {
    roundtrip(
        "using Frozen = const unsigned;
        using Observed = volatile float;
        template<class Value> __device__ Value zero() { return Value(); }
        __global__ void kernel(unsigned *output) {
            auto count = Frozen();
            auto fraction = Observed();
            count += 3u; fraction += 5.0f;
            output[0] = count + unsigned(fraction);
            output[1] = unsigned(zero<bool>());
            output[2] = unsigned(zero<int>());
            output[3] = zero<unsigned>();
            output[4] = unsigned(zero<float>());
            int2 pair = zero<int2>();
            dim3 shape = zero<dim3>();
            output[5] = unsigned(pair.x) + shape.x + shape.y + shape.z;
        }",
    );
}

#[test]
fn cuda_empty_scalar_constructors_preserve_constant_initializers_and_array_extents() {
    roundtrip(
        "constexpr unsigned Extra = unsigned() + 3u;
        constexpr bool Disabled = bool();
        __global__ void kernel(unsigned *output) {
            constexpr int Offset = int();
            constexpr float Fraction = float();
            unsigned values[Extra + unsigned(Disabled)]{5u, 7u, 11u};
            unsigned total = unsigned();
            for (unsigned index = unsigned(); index < Extra; ++index) total += values[index];
            const int &reference = int();
            output[0] = total + values[Offset];
            output[1] = unsigned(reference) + unsigned(Fraction);
        }",
    );
}

#[test]
fn cuda_empty_scalar_constructors_keep_constructed_zero_out_of_pointer_conversions() {
    roundtrip(
        "__device__ unsigned choose(unsigned *pointer) { return 1u; }
        __device__ unsigned choose(dim3 value) { return value.x + 2u; }
        __global__ void kernel(unsigned *output) {
            output[0] = choose(0);
            output[1] = choose(int());
            output[2] = choose(unsigned());
            output[3] = choose(bool());
            output[4] = choose(float());
        }",
    );
    for expression in ["int()", "unsigned()", "bool()", "float()", "Zero()", "ZERO"] {
        for statement in [
            format!("unsigned *pointer = {expression};"),
            format!("consume({expression});"),
            format!("consume_typed<unsigned>({expression});"),
            format!("using Null = decltype(nullptr); Null value = {expression};"),
            format!("unsigned *pointer = nullptr; bool value = pointer == {expression};"),
        ] {
            rejected(&format!(
                "#define ZERO unsigned()
                using Zero = const unsigned;
                __device__ void consume(unsigned *pointer) {{}}
                template<class Value> __device__ void consume_typed(Value *pointer) {{}}
                __global__ void kernel() {{ {statement} }}"
            ));
        }
    }
}

#[test]
fn cuda_empty_scalar_constructors_keep_prvalue_binding_and_brace_rules() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            const int &signed_zero = int();
            const unsigned &unsigned_zero = unsigned();
            const bool &false_value = bool();
            const float &float_zero = float();
            int first{}; unsigned second = {}; bool third{}; float fourth = {};
            unsigned converted{int()};
            float exact{unsigned()};
            output[0] = unsigned(signed_zero) + unsigned_zero + unsigned(false_value);
            output[1] = unsigned(float_zero + fourth + exact);
            output[2] = unsigned(first) + second + unsigned(third) + converted;
        }",
    );
    for scalar in ["bool", "int", "unsigned", "float"] {
        rejected(&format!(
            "__global__ void kernel() {{ {scalar} &value = {scalar}(); }}"
        ));
        rejected(&format!(
            "using Frozen = const {scalar}; using Observed = volatile {scalar};
            template<class Value> __device__ unsigned inspect(Value &value) {{ return unsigned(value); }}
            __global__ void kernel(unsigned *output) {{ output[0] = inspect(Frozen()); }}"
        ));
        rejected(&format!(
            "using Observed = volatile {scalar};
            template<class Value> __device__ unsigned inspect(Value &value) {{ return unsigned(value); }}
            __global__ void kernel(unsigned *output) {{ output[0] = inspect(Observed()); }}"
        ));
    }
    for declaration in [
        "int value{float()};",
        "bool value{float()};",
        "unsigned values[int()];",
        "unsigned values[bool()];",
        "unsigned values[float()];",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_empty_scalar_constructors_keep_declarations_and_source_spans_distinct() {
    for declaration in [
        "int value();",
        "bool value(bool());",
        "unsigned value(unsigned());",
        "float value(float());",
        "Integer value(Integer());",
        "auto value(Integer());",
    ] {
        let source = format!(
            "/* café 漢 */ using Integer = int;
            __global__ void kernel() {{ {declaration} }}"
        );
        let opening = source.find("value(").unwrap() + "value".len();
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
    roundtrip(
        "#define INTEGER int
        using Frozen = const unsigned;
        __global__ void kernel(unsigned *output) {
            INTEGER signed_zero((INTEGER()));
            unsigned count((Frozen()));
            auto copied = Frozen();
            bool flag((bool()));
            float sample((float()));
            output[0] = unsigned(signed_zero) + count + copied + unsigned(flag) + unsigned(sample);
        }",
    );
    for expression in [
        "static_cast<int>()",
        "(int)()",
        "int(,)",
        "int(0,)",
        "int(1, 2)",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{ auto value = {expression}; }}"
        ));
    }
}

#[test]
fn cuda_empty_scalar_constructors_bound_alias_construction_and_template_calls() {
    for mode in ["constructors", "templates"] {
        let source = |depth: usize| {
            let mut expression = if mode == "templates" {
                String::from("zero<int>()")
            } else {
                String::from("Integer()")
            };
            for _ in 0..depth {
                expression = if mode == "templates" {
                    format!("identity({expression})")
                } else {
                    format!("Integer({expression})")
                };
            }
            format!(
                "using Integer = const int;
                template<class Value> __device__ Value zero() {{ return Value(); }}
                template<class Value> __device__ Value identity(Value value) {{ return value; }}
                __global__ void kernel(int *output) {{ output[0] = {expression}; }}"
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
