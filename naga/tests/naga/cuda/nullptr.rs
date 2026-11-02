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

#[test]
fn cuda_nullptr_literals_convert_to_pointers_and_support_null_tests() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            unsigned *pointer = nullptr;
            output[0] = unsigned(pointer == nullptr);
            output[1] = unsigned(nullptr == pointer);
            output[2] = unsigned(nullptr == nullptr);
            output[3] = unsigned(nullptr == 0);
            if (nullptr) output[4] = 99u;
            else output[4] = 5u;
            output[5] = unsigned(!nullptr);
            output[6] = unsigned(nullptr || true);
        }",
    );
}

#[test]
fn cuda_nullptr_named_and_constant_auto_values_keep_the_source_type() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            auto empty = nullptr;
            const auto fixed = empty;
            constexpr auto known = nullptr;
            empty = 0;
            unsigned *first = empty;
            const unsigned *second = fixed;
            unsigned *third = known;
            output[0] = unsigned(first == nullptr);
            output[1] = unsigned(second == nullptr);
            output[2] = unsigned(third == nullptr);
        }",
    );
}

#[test]
fn cuda_nullptr_aliases_and_references_preserve_source_categories() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ unsigned mutable_value(Null &value) { value = nullptr; return 7u; }
        __device__ unsigned fixed_value(const Null &value) { return value == nullptr ? 11u : 13u; }
        __global__ void kernel(unsigned *output) {
            Null value;
            Null &alias = value;
            const Null &temporary = nullptr;
            alias = 0;
            unsigned *pointer = value;
            output[0] = mutable_value(alias);
            output[1] = fixed_value(temporary);
            output[2] = unsigned(pointer == nullptr);
        }",
    );
}

#[test]
fn cuda_nullptr_returning_helpers_preserve_call_effects() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ Null count_call(unsigned &counter) { ++counter; return nullptr; }
        __device__ Null forward(unsigned &counter) { return count_call(counter); }
        __device__ Null ordinary() { return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            unsigned *first = forward(counter);
            auto second = count_call(counter);
            unsigned *third = ordinary();
            output[0] = counter;
            output[1] = unsigned(first == second);
            output[2] = unsigned(third == nullptr);
        }",
    );
}

#[test]
fn cuda_nullptr_template_deduction_and_returns_stay_distinct_from_integers() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ unsigned classify(Null value) { return 7u; }
        __device__ unsigned classify(unsigned *value) { return 11u; }
        __device__ unsigned classify(int value) { return 13u; }
        template<class Value> __device__ Value identity(Value value) { return value; }
        template<class Value> __device__ unsigned selected(Value value) { return classify(value); }
        __global__ void kernel(unsigned *output) {
            output[0] = selected(nullptr);
            output[1] = selected(0);
            unsigned *pointer = identity(nullptr);
            auto copy = identity(nullptr);
            output[2] = unsigned(pointer == nullptr);
            output[3] = classify(copy);
        }",
    );
}

#[test]
fn cuda_nullptr_constructors_and_direct_boolean_conversions_are_source_only() {
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            Null first{};
            Null second = Null(0);
            Null third = static_cast<Null>(0);
            bool direct{nullptr};
            output[0] = unsigned(first == nullptr);
            output[1] = unsigned(second == nullptr);
            output[2] = unsigned(third == nullptr);
            output[3] = unsigned(direct);
            output[4] = unsigned(bool(nullptr));
            output[5] = unsigned(static_cast<bool>(nullptr));
        }",
    );
}

#[test]
fn cuda_nullptr_standard_name_resolves_to_the_same_source_type() {
    roundtrip(
        "#include <cstddef>
        __device__ std::nullptr_t produced() { return nullptr; }
        __global__ void kernel(unsigned *output) {
            std::nullptr_t value{};
            const std::nullptr_t copied = produced();
            unsigned *pointer = value;
            output[0] = unsigned(pointer == copied);
        }",
    );
}

#[test]
fn cuda_nullptr_erased_parameters_and_results_keep_ordinary_calls() {
    let (module, info) = validate(
        "using Null = decltype(nullptr);
        __device__ Null synchronize(Null value) { __syncthreads(); return value; }
        __global__ void kernel(unsigned *output) {
            auto value = synchronize(nullptr);
            output[0] = unsigned(value == nullptr);
        }",
    );
    let (handle, function) = module
        .functions
        .iter()
        .find(|&(_, function)| function.name.as_deref() == Some("synchronize"))
        .unwrap();
    assert!(function.arguments.is_empty());
    assert!(function.result.is_none());
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| matches!(*statement, naga::Statement::Call { function, result: None, .. } if function == handle),
    ));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
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
fn cuda_nullptr_named_reads_are_constant_after_default_or_effectful_initialization() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ Null produce(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            Null uninitialized;
            auto mutable_value = nullptr;
            const auto fixed = nullptr;
            unsigned counter = 0u;
            auto produced = produce(counter);
            constexpr auto first = uninitialized;
            constexpr auto second = mutable_value;
            constexpr auto third = fixed;
            constexpr auto fourth = produced;
            constexpr bool same = mutable_value == nullptr;
            output[0] = counter;
            output[1] = unsigned(first == nullptr && second == nullptr);
            output[2] = unsigned(third == nullptr && fourth == nullptr && same);
        }",
    );
}

#[test]
fn cuda_nullptr_unique_result_does_not_make_evaluated_effects_constant() {
    for source in [
        "using Null = decltype(nullptr); __device__ Null produce() { return nullptr; } __global__ void kernel() { constexpr auto value = produce(); }",
        "__device__ void touch() {} __global__ void kernel() { constexpr auto value = (touch(), nullptr); }",
        "__global__ void kernel(unsigned *input) { bool condition = input[0] != 0u; constexpr auto value = condition ? nullptr : nullptr; }",
        "__global__ void kernel() { auto value = nullptr; constexpr auto copied = (value = nullptr); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nullptr_rejects_implicit_boolean_and_numeric_conversions() {
    for source in [
        "__global__ void kernel() { bool value = nullptr; }",
        "__global__ void kernel() { bool value = {nullptr}; }",
        "__device__ void consume(bool value) {} __global__ void kernel() { consume(nullptr); }",
        "__device__ void consume(const bool &value) {} __global__ void kernel() { consume(nullptr); }",
        "__device__ bool returned() { return nullptr; } __global__ void kernel() { returned(); }",
        "__global__ void kernel() { int value = nullptr; }",
        "__global__ void kernel() { auto value = unsigned(nullptr); }",
        "__global__ void kernel() { auto value = +nullptr; }",
        "__global__ void kernel() { auto value = nullptr + 0; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nullptr_constructor_assignment_and_comparison_keep_literal_zero_rules() {
    for statement in [
        "Null value = int(0);",
        "Null value = Null(int(0));",
        "Null value = nullptr; value = int(0);",
        "int zero = 0; Null value = zero;",
        "constexpr int zero = 0; Null value = zero;",
        "unsigned *pointer = 0; Null value = pointer;",
        "auto value = nullptr == int(0);",
        "auto value = int(0) == nullptr;",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {statement} }}"
        ));
    }
}

#[test]
fn cuda_nullptr_references_and_assignments_enforce_source_cv_and_category() {
    for statement in [
        "const auto value = nullptr; value = nullptr;",
        "const auto value = nullptr; Null &alias = value;",
        "Null &alias = nullptr;",
        "Null &alias = 0;",
        "Null value = nullptr; value += 0;",
        "Null value = nullptr; ++value;",
        "Null first = nullptr; Null second = nullptr; (true ? first : nullptr) = second;",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {statement} }}"
        ));
    }
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ unsigned inspect(const Null &value) { return unsigned(value == nullptr); }
        __global__ void kernel(unsigned *output) {
            Null first = nullptr;
            Null second = nullptr;
            (true ? first : second) = nullptr;
            const Null &literal_zero = 0;
            output[0] = inspect(literal_zero);
            output[1] = inspect(first);
        }",
    );
}

#[test]
fn cuda_nullptr_template_pointer_parameters_require_explicit_pointee_types() {
    roundtrip(
        "template<class Value> __device__ unsigned inspect(Value *pointer) { return unsigned(pointer == nullptr); }
        __global__ void kernel(unsigned *output) {
            output[0] = inspect<unsigned>(nullptr);
            const auto value = nullptr;
            output[1] = inspect<const unsigned>(value);
        }",
    );
    for operand in ["nullptr", "value"] {
        rejected(&format!(
            "template<class Value> __device__ unsigned inspect(Value *pointer) {{ return 1u; }}
            __global__ void kernel() {{ auto value = nullptr; inspect({operand}); }}"
        ));
    }
    rejected(
        "template<class Value> __device__ void modify(Value &value) { value = nullptr; }
        __global__ void kernel() { modify(nullptr); }",
    );
}

#[test]
fn cuda_nullptr_overload_resolution_keeps_pointer_ambiguity_and_literal_zero_ties() {
    for operand in ["nullptr", "value"] {
        let source = format!(
            "__device__ unsigned selected(unsigned *value) {{ return 1u; }}
            __device__ unsigned selected(float *value) {{ return 2u; }}
            __global__ void kernel() {{ auto value = nullptr; selected({operand}); }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("ambiguous"), "{source}: {error}");
    }
    let source = "using Null = decltype(nullptr);
        __device__ unsigned selected(Null value) { return 1u; }
        __device__ unsigned selected(unsigned *value) { return 2u; }
        __global__ void kernel() { selected(0); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{source}: {error}");
}

#[test]
fn cuda_nullptr_return_signatures_remain_distinct_from_ir_void() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ Null produced();
        __device__ Null produced() { return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned *pointer = produced();
            output[0] = unsigned(pointer == nullptr);
        }",
    );
    for source in [
        "using Null = decltype(nullptr); __device__ Null produced(); __device__ void produced() {} __global__ void kernel() {}",
        "using Null = decltype(nullptr); __device__ void produced(); __device__ Null produced() { return nullptr; } __global__ void kernel() {}",
        "using Null = decltype(nullptr); __device__ Null produced() { return int(0); } __global__ void kernel() { produced(); }",
        "using Null = decltype(nullptr); __device__ Null produced() { return; } __global__ void kernel() { produced(); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_nullptr_physical_layout_requests_remain_explicitly_unsupported() {
    for source in [
        "using Null = decltype(nullptr); __global__ void kernel(Null value) {}",
        "using Null = decltype(nullptr); __global__ void kernel() { Null values[2]; }",
        "using Null = decltype(nullptr); __global__ void kernel() { Null value; Null *address = &value; }",
        "using Null = decltype(nullptr); __global__ void kernel() { __shared__ Null value; }",
        "using Null = decltype(nullptr); __global__ void kernel() { volatile Null value; }",
    ] {
        rejected(source);
    }
}
#[test]
fn cuda_nullptr_rejects_unsupported_block_scope_function_declarations() {
    rejected(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            Null value();
            output[0] = unsigned(value == nullptr);
        }",
    );
}
#[test]
fn cuda_nullptr_rejects_volatile_reference_storage_paths() {
    for source in [
        "using Null = decltype(nullptr); __global__ void kernel() { Null value; volatile Null &alias = value; alias = nullptr; }",
        "using Null = decltype(nullptr); __device__ void modify(volatile Null &value) { value = nullptr; } __global__ void kernel() { Null value; modify(value); }",
        "using Null = decltype(nullptr); __device__ void modify(volatile Null value) { value = nullptr; } __global__ void kernel() { modify(nullptr); }",
    ] {
        rejected(source);
    }
}

fn erased_nullptr_call_targets(source: &str) -> Vec<naga::Handle<naga::Function>> {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call {
            function,
            ref arguments,
            result,
        } = *statement
        {
            assert!(arguments.is_empty(), "{source}");
            assert!(result.is_none(), "{source}");
            assert!(module.functions[function].arguments.is_empty(), "{source}");
            assert!(module.functions[function].result.is_none(), "{source}");
            targets.push(function);
        }
        false
    });
    let _ = info;
    targets
}

fn rejected_nullptr_depth(source: &str) {
    let error = rejected(source);
    assert!(
        error.message.contains("limit") || error.message.contains("nesting"),
        "{error}"
    );
}

#[test]
fn cuda_nullptr_bounds_nested_erased_ordinary_helper_calls() {
    let source = |depth| {
        format!(
            "using Null = decltype(nullptr);
            __device__ Null identity(Null value) {{ return value; }}
            __global__ void kernel(unsigned *output) {{
                auto value = {}nullptr{};
                output[0] = unsigned(value == nullptr);
            }}",
            "identity(".repeat(depth),
            ")".repeat(depth),
        )
    };
    let targets = erased_nullptr_call_targets(&source(8));
    assert_eq!(targets.len(), 8);
    assert!(targets.iter().all(|&target| target == targets[0]));
    rejected_nullptr_depth(&source(512));
}

#[test]
fn cuda_nullptr_bounds_nested_erased_deduced_template_calls() {
    let source = |depth| {
        format!(
            "template<class Value> __device__ Value identity(Value value) {{ return value; }}
            __global__ void kernel(unsigned *output) {{
                auto value = {}nullptr{};
                output[0] = unsigned(value == nullptr);
            }}",
            "identity(".repeat(depth),
            ")".repeat(depth),
        )
    };
    let targets = erased_nullptr_call_targets(&source(8));
    assert_eq!(targets.len(), 8);
    assert!(targets.iter().all(|&target| target == targets[0]));
    rejected_nullptr_depth(&source(512));
}

#[test]
fn cuda_nullptr_bounds_nested_erased_reference_parameter_calls() {
    for declaration in [
        "using Null = decltype(nullptr); __device__ Null identity(const Null &value) { return value; }",
        "template<class Value> __device__ Value identity(const Value &value) { return value; }",
    ] {
        let source = |depth| {
            format!(
                "{declaration}
                __global__ void kernel(unsigned *output) {{
                    auto value = {}nullptr{};
                    output[0] = unsigned(value == nullptr);
                }}",
                "identity(".repeat(depth),
                ")".repeat(depth),
            )
        };
        let targets = erased_nullptr_call_targets(&source(8));
        assert_eq!(targets.len(), 8);
        assert!(targets.iter().all(|&target| target == targets[0]));
        rejected_nullptr_depth(&source(512));
    }
}

#[test]
fn cuda_nullptr_bounds_nested_source_only_conditional_references() {
    let source = |depth| {
        let mut selection = String::from("second");
        for _ in 0..depth {
            selection = format!("condition ? first : ({selection})");
        }
        format!(
            "using Null = decltype(nullptr);
            __device__ void assign(Null &value) {{ value = nullptr; }}
            __global__ void kernel(unsigned *output) {{
                Null first = nullptr;
                Null second = nullptr;
                bool condition = output[1] != 0u;
                Null &selected = {selection};
                assign(selected);
                output[0] = unsigned(selected == nullptr);
            }}"
        )
    };
    roundtrip(&source(8));
    rejected_nullptr_depth(&source(128));
}

#[test]
fn cuda_nullptr_builtin_header_keeps_other_include_forms_unsupported() {
    for directive in [
        "#include \"cstddef\"",
        "#include <cstddef> extra",
        "#define HEADER <cstddef>\n#include HEADER",
    ] {
        let source = format!("{directive}\n__global__ void kernel() {{}}");
        let error = rejected(&source);
        assert!(error.message.contains("unsupported"), "{error}");
    }
    roundtrip(
        "# include<cstddef> /* builtin header */
        #include <cstddef>
        __global__ void kernel(unsigned *output) {
            std::nullptr_t value{};
            output[0] = unsigned(value == nullptr);
        }",
    );
}

#[test]
fn cuda_nullptr_explicit_global_self_initialization_uses_the_unique_source_value() {
    roundtrip(
        "using Null = decltype(nullptr);
        constexpr Null global_value = global_value;
        __global__ void kernel(unsigned *output) {
            output[0] = unsigned(global_value == nullptr);
        }",
    );
}

#[test]
fn cuda_nullptr_explicit_local_self_initialization_keeps_auto_deduction_checks() {
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            Null mutable_value = mutable_value;
            constexpr Null constant_value = constant_value;
            output[0] = unsigned(mutable_value == nullptr);
            output[1] = unsigned(constant_value == nullptr);
        }",
    );
    rejected("__global__ void kernel() { auto value = value; }");
}

#[test]
fn cuda_nullptr_parenthesized_boolean_initializers_keep_direct_conversion_and_call_effects() {
    roundtrip(
        "using Null = decltype(nullptr);
        using Flag = bool;
        __device__ Null produce(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            bool literal(nullptr);
            auto empty = nullptr;
            Flag named(empty);
            const bool returned(produce(counter));
            output[0] = unsigned(literal);
            output[1] = unsigned(named);
            output[2] = unsigned(returned);
            output[3] = counter;
        }",
    );
}

#[test]
fn cuda_nullptr_rejects_function_parameters_disguised_as_object_initializers() {
    for statement in [
        "bool seed = true; bool value(bool(seed));",
        "Null seed = nullptr; Null value(Null(seed));",
        "Null value(Null());",
        "Null value(Null(produce()));",
        "Null seed = nullptr; bool value(Null(seed));",
        "bool value(Null());",
        "Null seed = nullptr; Null value(decltype(nullptr)(seed));",
        "Null value(decltype(nullptr)());",
        "Null seed = nullptr; Null value(std::nullptr_t(seed));",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {statement} }}"
        ));
    }
}

#[test]
fn cuda_nullptr_object_initializers_remain_distinct_from_parameter_declarations() {
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            Null seed = nullptr;
            Null first((Null(seed)));
            Null second(Null(0));
            Null third(Null{seed});
            bool fourth((Null(seed)));
            bool fifth(Null(0));
            bool sixth(Null{seed});
            output[0] = unsigned(first == second && second == third);
            output[1] = unsigned(fourth || fifth || sixth);
        }",
    );
}

#[test]
fn cuda_nullptr_inferred_initializers_reject_deduced_return_function_declarations() {
    for statement in [
        "auto value(Null());",
        "Null seed = nullptr; auto value(Null(seed));",
        "bool seed = true; auto value(bool(seed));",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {statement} }}"
        ));
    }
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            Null seed = nullptr;
            auto first((Null(seed)));
            auto second(Null(0));
            auto third = Null();
            output[0] = unsigned(first == second && second == third);
        }",
    );
}

#[test]
fn cuda_nullptr_initializer_lookahead_preserves_genuine_nested_call_effects() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ Null observe(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            Null first(observe(counter));
            Null second(Null(observe(counter)));
            bool third(bool(observe(counter)));
            output[0] = counter;
            output[1] = unsigned(first == second && !third);
        }",
    );
}

#[test]
fn cuda_nullptr_function_declaration_lookahead_keeps_nesting_bounded() {
    for target in ["Null", "bool", "auto"] {
        for depth in [8, 512] {
            let mut parameter = String::from("Null()");
            for _ in 0..depth {
                parameter = format!("Null({parameter})");
            }
            let source = format!(
                "using Null = decltype(nullptr);
                __global__ void kernel() {{ {target} value({parameter}); }}"
            );
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
}
