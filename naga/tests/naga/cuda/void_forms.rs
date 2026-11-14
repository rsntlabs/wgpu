use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_void_forms_accept_cv_targets_and_functional_conversions() {
    validate(
        "__device__ void sink(int &value) { return void(value++); }
        __global__ void kernel(int *output) {
            int value = 0;
            (const void)value;
            (void volatile const)value;
            static_cast<const volatile void>(value);
            static_cast<void const>(value);
            void(); void{}; void(1); void(value++);
            void((value++, value++));
            (void(sink(value)));
            output[0] = value;
        }",
    );
}

fn rejected(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_void_forms_preserve_constant_provenance_and_selected_arms() {
    validate(
        "__device__ int call() { return 2; }
        __global__ void kernel(int runtime, int *output) {
            constexpr int A = (void(), 1);
            constexpr int B = (void{}, 2);
            constexpr int C = (void(runtime), 3);
            constexpr int D = ((const volatile void)runtime, 4);
            constexpr int E = (static_cast<volatile void>(runtime), 5);
            constexpr int F = (true ? void{} : void(call()), 6);
            constexpr int G = (false ? void(call()) : void(), 7);
            constexpr int H = (void((void(), runtime)), 8);
            static_assert(A+B+C+D+E+F+G+H == 36);
            output[0] = H;
        }",
    );
    for expression in [
        "(void(call()), void(), 3)",
        "(void((call(), void{})), 3)",
        "(void(runtime++), void{}, 3)",
        "(runtime ? void() : void{}, 3)",
        "(static_cast<const void>(call()), void{}, 3)",
    ] {
        rejected(&format!("__device__ int call() {{ return 2; }} __global__ void kernel(int runtime) {{ constexpr int Count = {expression}; }}"));
    }
}

fn loads(module: &naga::Module) -> usize {
    module.entry_points[0]
        .function
        .expressions
        .iter()
        .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
        .count()
}

#[test]
fn cuda_void_forms_target_qualifiers_do_not_change_operand_volatile_reads() {
    for expression in [
        "(const volatile void)input[0]",
        "static_cast<volatile void>(input[0])",
        "(void(input[0]))",
    ] {
        let nonvolatile = validate(&format!(
            "__global__ void kernel(const int *input) {{ {expression}; }}"
        ));
        assert_eq!(loads(&nonvolatile), 0, "{expression}");
        let source = format!("__global__ void kernel(volatile int *input) {{ {expression}; }}");
        let volatile = validate_with_options_and_capabilities(
            &source,
            &Options::default(),
            Capabilities::MEMORY_DECORATION_VOLATILE,
        )
        .0;
        assert_eq!(loads(&volatile), 1, "{expression}");
        rejected(&format!("__global__ void kernel(volatile int *input) {{ constexpr int Count = ({expression}, 3); }}"));
    }
}

#[test]
fn cuda_void_forms_reject_malformed_targets_value_contexts_and_nonempty_lists() {
    for body in [
        "void(1, 2);",
        "void{1};",
        "void{void()};",
        "void{1, 2};",
        "(const const void)1;",
        "(volatile void volatile)1;",
        "static_cast<const void const>(1);",
        "static_cast<volatile volatile void>(1);",
        "int value = void();",
        "int value = void{};",
        "if (void(1)) {}",
        "take(void(1));",
        "runtime ? void() : 1;",
        "void(1) + 2;",
        "static_assert(void());",
        "sizeof(void{});",
        "void(1;",
        "void{;",
        "(const void*)1;",
        "static_cast<void volatile *>(1);",
    ] {
        rejected(&format!("__device__ int take(int x) {{ return x; }} __global__ void kernel(int runtime) {{ {body} }}"));
    }
}

#[test]
fn cuda_void_forms_preserve_statement_declaration_ambiguity() {
    for body in [
        "void(value);",
        "void((value));",
        "void(call());",
        "void(sink());",
        "void(*pointer);",
        "void(pointer[0]);",
    ] {
        rejected(&format!("__device__ int call() {{ return 1; }} __device__ void sink() {{}} __global__ void kernel(int *pointer) {{ int value = 0; {body} }}"));
    }
    validate("__device__ int call() { return 1; } __device__ void sink() {} __global__ void kernel(int *pointer) { (void(call())); (void(sink())); (void(*pointer)); }");
}

#[test]
fn cuda_void_forms_bound_functional_nesting() {
    rejected(&format!(
        "__global__ void kernel() {{ {}0{}; }}",
        "void(".repeat(70),
        ")".repeat(70)
    ));
}
