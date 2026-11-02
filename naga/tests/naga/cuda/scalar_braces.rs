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
fn cuda_scalar_braces_keep_exact_types_and_literal_values() {
    for (name, scalar, zero, expression, literal) in [
        (
            "bool",
            naga::Scalar::BOOL,
            naga::Literal::Bool(false),
            "true",
            naga::Literal::Bool(true),
        ),
        (
            "int",
            naga::Scalar::I32,
            naga::Literal::I32(0),
            "3",
            naga::Literal::I32(3),
        ),
        (
            "unsigned",
            naga::Scalar::U32,
            naga::Literal::U32(0),
            "7u",
            naga::Literal::U32(7),
        ),
        (
            "float",
            naga::Scalar::F32,
            naga::Literal::F32(0.0),
            "1.5f",
            naga::Literal::F32(1.5),
        ),
    ] {
        for (initializer, expected) in [
            (format!("{name}{{}}"), zero),
            (format!("{name}{{{expression}}}"), literal),
            (format!("{name}{{{expression},}}"), literal),
        ] {
            let (module, info) = roundtrip(&format!(
                "__global__ void kernel(unsigned *output) {{
                    auto value = {initializer}; output[0] = unsigned(value);
                }}"
            ));
            let function = &module.entry_points[0].function;
            let value = source_binding_initializer(function, "value");
            assert_eq!(
                function.expressions[value],
                naga::Expression::Literal(expected)
            );
            assert_eq!(
                info.get_entry_point(0)[value].ty.inner_with(&module.types),
                &naga::TypeInner::Scalar(scalar),
            );
        }
    }
}

#[test]
fn cuda_scalar_braces_construct_aliases_and_function_template_values() {
    roundtrip(
        "using Frozen = const unsigned;
        using Observed = volatile float;
        template<class Value> __device__ Value zero() { return Value{}; }
        template<class Value> __device__ Value copy(Value value) { return Value{value,}; }
        __global__ void kernel(unsigned *output) {
            auto count = Frozen{3u};
            auto fraction = Observed{5.0f};
            count += 7u; fraction += 11.0f;
            output[0] = count + unsigned(fraction);
            output[1] = unsigned(copy(true)) + unsigned(copy(13));
            output[2] = copy(17u) + unsigned(copy(19.0f));
            output[3] = unsigned(zero<bool>()) + unsigned(zero<int>());
            output[4] = zero<unsigned>() + unsigned(zero<float>());
            int2 pair = zero<int2>(); dim3 shape = zero<dim3>();
            output[5] = unsigned(pair.x) + shape.x + shape.y + shape.z;
        }",
    );
}

#[test]
fn cuda_scalar_braces_preserve_constant_evaluation_and_direct_bool_initialization() {
    roundtrip(
        "constexpr unsigned Extent = unsigned{3};
        constexpr bool Disabled = bool{};
        __device__ unsigned identity(unsigned value) { return value; }
        __global__ void kernel(unsigned *output) {
            constexpr int Offset = int{};
            constexpr float Fraction = float{0};
            unsigned values[Extent + unsigned{Disabled}]{5u, 7u, 11u};
            const int &reference = int{13};
            auto absent = nullptr;
            bool first = bool{nullptr}; bool second = bool{absent,};
            unsigned total = unsigned{};
            for (unsigned index = unsigned{}; index < Extent; ++index) total += values[index];
            output[0] = identity(unsigned{total}) + values[Offset];
            output[1] = unsigned(reference) + unsigned(Fraction);
            output[2] = unsigned{first} + unsigned{second};
        }",
    );
}

#[test]
fn cuda_scalar_brace_expressions_keep_constant_narrowing_exceptions() {
    roundtrip(
        "__global__ void kernel(float *output) {
            const int exact = 16777218;
            bool flag = bool{1u,};
            int signed_value = int{2147483647u};
            unsigned count = unsigned{2147483647};
            float first = float{exact};
            float second = float{0xffffff00u};
            float third = float{bool{true}};
            output[0] = first; output[1] = second; output[2] = third;
            output[3] = float(flag) + float(signed_value) + float(count);
        }",
    );
    for expression in [
        "bool{2}",
        "bool{-1}",
        "bool{0.0f}",
        "int{1.0f}",
        "unsigned{-1}",
        "int{2147483648u}",
        "float{16777217}",
        "float{0xffffffffu}",
        "float{signed_value}",
        "int{count}",
        "unsigned{signed_value}",
        "bool{signed_value}",
        "float{flag}",
    ] {
        let error = rejected(&format!(
            "__global__ void kernel(int signed_value, unsigned count) {{
                bool flag = count != 0u; auto value = {expression};
            }}"
        ));
        assert!(error.message.contains("narrowing"), "{expression}: {error}");
    }
}

#[test]
fn cuda_scalar_brace_expressions_keep_reference_categories_and_null_origin() {
    roundtrip(
        "using Frozen = const unsigned; using Observed = volatile float;
        template<class Value> __device__ Value identity(Value value) { return Value{value}; }
        __device__ unsigned consume(const bool &value) { return unsigned(value); }
        __global__ void kernel(unsigned *output) {
            const unsigned &count = Frozen{3u};
            const float &sample = Observed{1.5f};
            const bool &false_value = bool{nullptr};
            output[0] = count + unsigned(sample) + unsigned(false_value);
            output[1] = consume(bool{nullptr}) + identity(unsigned{5u});
        }",
    );
    for expression in ["Frozen{}", "Frozen{3u}", "Observed{}", "Observed{1.5f}"] {
        rejected(&format!(
            "using Frozen = const unsigned; using Observed = volatile float;
            template<class Value> __device__ unsigned inspect(Value &value) {{ return unsigned(value); }}
            __global__ void kernel(unsigned *output) {{ output[0] = inspect({expression}); }}"
        ));
    }
    for expression in [
        "int{}",
        "int{0}",
        "unsigned{}",
        "bool{}",
        "float{}",
        "Zero{0u}",
    ] {
        for statement in [
            format!("unsigned *pointer = {expression};"),
            format!("consume({expression});"),
            format!("using Null = decltype(nullptr); Null value = {expression};"),
            format!("unsigned *pointer = nullptr; bool same = pointer == {expression};"),
        ] {
            rejected(&format!(
                "using Zero = const unsigned;
                __device__ void consume(unsigned *pointer) {{}}
                __global__ void kernel() {{ {statement} }}"
            ));
        }
    }
    rejected("__global__ void kernel(unsigned *input) { bool value = bool{input}; }");
}

#[test]
fn cuda_scalar_brace_expressions_keep_statements_declarations_and_spans() {
    roundtrip(
        "using Integer = int;
        __global__ void kernel(int *output) {
            int counter = 0;
            int value(int{3});
            auto inferred(Integer{5});
            int{}; Integer{value}; bool{nullptr};
            int first = int{(++counter, counter),};
            int second = (Integer{++counter});
            output[0] = (Integer{3} + Integer{4}) * 2;
            output[1] = (Integer{++counter}, Integer{counter});
            output[2] = value + inferred + first + second;
            output[3] = counter;
        }",
    );
    let source = "/* café 漢 */ using Integer = int;
        __global__ void kernel() { int &value = Integer{3}; }";
    let error = rejected(source);
    let start = source.find("Integer{3}").unwrap();
    assert_eq!(
        error.span.to_range(),
        Some(start..start + "Integer{3}".len()),
        "{error}"
    );
    for expression in [
        "int{3} = 4",
        "++int{3}",
        "int{3}++",
        "&int{3}",
        "int{3}.x",
        "int{3}[0]",
        "int{1, 2}",
        "int{,}",
        "int{{3}}",
        "int{{}}",
        "bool{{nullptr}}",
        "float{{1.0f}}",
    ] {
        rejected(&format!("__global__ void kernel() {{ {expression}; }}"));
    }
    for declaration in [
        "int value();",
        "int value(int());",
        "auto value(Integer());",
    ] {
        let error = rejected(&format!(
            "using Integer = int; __global__ void kernel() {{ {declaration} }}"
        ));
        assert!(
            error.message.contains("function declaration"),
            "{declaration}: {error}"
        );
    }
}

#[test]
fn cuda_scalar_brace_expressions_bound_typed_nesting_and_template_calls() {
    for mode in ["typed", "templates"] {
        let source = |depth: usize| {
            let mut expression = if mode == "typed" {
                String::from("Integer{3,}")
            } else {
                String::from("zero<int>()")
            };
            for _ in 0..depth {
                expression = if mode == "typed" {
                    format!("Integer{{{expression},}}")
                } else {
                    format!("identity({expression})")
                };
            }
            format!(
                "using Integer = const int;
                template<class Value> __device__ Value zero() {{ return Value{{}}; }}
                template<class Value> __device__ Value identity(Value value) {{ return Value{{value}}; }}
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
