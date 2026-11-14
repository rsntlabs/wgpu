use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate_with_capabilities(source: &str, capabilities: Capabilities) -> naga::Module {
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    module
}

fn validate(source: &str) -> naga::Module {
    validate_with_capabilities(source, Capabilities::empty())
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
fn cuda_void_casts_accept_nested_values_void_calls_references_and_void_returns() {
    let module = validate(
        "__device__ void increment(int &value) { return (void)value++; }
        __device__ int take(int &value) { return value++; }
        __global__ void kernel(int *output) {
            int value = 1;
            (void)take(value);
            static_cast<void>(increment(value));
            (void)((void)(value++));
            static_cast<void>(static_cast<void>(value));
            output[0] = value;
        }",
    );
    assert!(module.entry_points[0].function.result.is_none());
}

fn global_loads(module: &naga::Module, name: &str) -> usize {
    let input = module
        .global_variables
        .iter()
        .find_map(|(handle, global)| (global.name.as_deref() == Some(name)).then_some(handle))
        .unwrap();
    let function = &module.entry_points[0].function;
    function
        .expressions
        .iter()
        .filter(|(_, expression)| match **expression {
            naga::Expression::Load { pointer } => {
                let root = super::helpers::root_expression(function, pointer);
                function.expressions[root] == naga::Expression::GlobalVariable(input)
            }
            _ => false,
        })
        .count()
}

#[test]
fn cuda_void_casts_discard_nonvolatile_glvalues_without_loading_storage() {
    let module = validate(
        "__global__ void kernel(const int *input, int *output) {
            int index = 0;
            (void)input[index++];
            static_cast<void>(input[index++]);
            output[0] = index;
        }",
    );
    assert_eq!(global_loads(&module, "input"), 0);
}

#[test]
fn cuda_void_casts_preserve_exactly_one_volatile_read_and_skip_address_or_assignment_reads() {
    for statement in ["(void)input[0];", "static_cast<void>(input[0]);"] {
        let module = validate_with_capabilities(
            &format!("__global__ void kernel(volatile int *input, int *output) {{ {statement} output[0] = 7; }}"),
            Capabilities::MEMORY_DECORATION_VOLATILE,
        );
        assert_eq!(global_loads(&module, "input"), 1, "{statement}");
        let (_, input) = module
            .global_variables
            .iter()
            .find(|(_, global)| global.name.as_deref() == Some("input"))
            .unwrap();
        assert!(input
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
    }
    let module = validate_with_capabilities(
        "__global__ void kernel(volatile int *input) {
            (void)&input[0];
            static_cast<void>(&input[1]);
            (void)(input[0] = 3);
            static_cast<void>(input[1] = 4);
        }",
        Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    assert_eq!(global_loads(&module, "input"), 0);
}

#[test]
fn cuda_void_casts_preserve_constant_discardability_through_nested_commas_and_selected_arms() {
    let module = validate(
        "__device__ int helper() { return 2; }
        __global__ void kernel(int runtime, int *output) {
            int local = runtime;
            constexpr int Simple = ((void)0, 3);
            constexpr int Local = (static_cast<void>(local), 4);
            constexpr int Nested = ((void)0, static_cast<void>(local), 5);
            constexpr int Selected = (true ? (void)1 : static_cast<void>(helper()), 6);
            constexpr int Other = (false ? static_cast<void>(helper()) : (void)1, 7);
            static_assert(((void)nullptr, true));
            static_assert((static_cast<void>((void)0), true));
            int array[Simple + Local + Nested + Selected + Other]{};
            output[0] = array[24];
        }",
    );
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        assert!(!matches!(
            statement,
            naga::Statement::Call { .. } | naga::Statement::If { .. }
        ));
        false
    });
}

#[test]
fn cuda_void_casts_do_not_erase_nonconstant_effects_in_required_constants() {
    for condition in [
        "((void)helper(), (void)0, 3)",
        "((void)(local++), (void)0, 3)",
        "(static_cast<void>(helper()), static_cast<void>(local), 3)",
        "(choose ? (void)0 : static_cast<void>(0), 3)",
        "((void)input[0], 3)",
    ] {
        let source = format!(
            "__device__ int helper() {{ return 2; }}
            __global__ void kernel(unsigned choose, const int *input) {{
                int local = 0; constexpr int Count = {condition};
            }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("constant"), "{source}: {error}");
    }
    for cast in ["(void)input[0]", "static_cast<void>(input[0])"] {
        let error = rejected(&format!(
            "__global__ void kernel(volatile int *input) {{ constexpr int Count = ({cast}, 3); }}"
        ));
        assert!(error.message.contains("constant"), "{error}");
    }
}

#[test]
fn cuda_void_casts_preserve_lazy_conditional_arms_loops_and_comma_order() {
    validate(
        "__device__ void sink(int &value) { ++value; }
        __global__ void kernel(unsigned choose, int *output) {
            int value = 0;
            choose ? (void)value++ : static_cast<void>(sink(value));
            (void)(value++, static_cast<void>(value++));
            for ((void)0; value < 5; static_cast<void>(++value)) {}
            output[0] = value;
            return static_cast<void>(sink(value));
        }",
    );
}

#[test]
fn cuda_void_casts_reject_value_contexts_mixed_arms_bad_syntax_and_wrong_precedence() {
    for body in [
        "int value = (void)1;",
        "int value = static_cast<void>(1);",
        "take((void)1);",
        "if (static_cast<void>(1)) {}",
        "(void)local + 1;",
        "1 + static_cast<void>(local);",
        "(void)local = 1;",
        "++((void)local);",
        "choose ? (void)1 : 2;",
        "choose ? 1 : static_cast<void>(2);",
        "static_assert((void)0);",
        "sizeof((void)1);",
        "(void);",
        "static_cast<void>();",
        "static_cast<void>(1,);",
        "static_cast<void>(1;",
        "(void, 1);",
        "(void*)1;",
        "static_cast<void*>(1);",
    ] {
        rejected(&format!(
            "__device__ int take(int value) {{ return value; }}
            __global__ void kernel(unsigned choose) {{ int local = 0; {body} }}"
        ));
    }
    rejected("__device__ int wrong() { return (void)1; } __global__ void kernel() { wrong(); }");
}

#[test]
fn cuda_void_casts_bound_nested_expression_depth() {
    let source = format!("__global__ void kernel() {{ {}0; }}", "(void)".repeat(70));
    let error = rejected(&source);
    assert!(error.message.contains("nesting limit"), "{error}");
}
