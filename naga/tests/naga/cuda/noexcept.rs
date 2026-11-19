use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty());
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_noexcept_accepts_bare_and_constant_boolean_device_specifications() {
    for specification in [
        "noexcept",
        "noexcept(true)",
        "noexcept(false)",
        "noexcept(0)",
        "noexcept(1)",
        "noexcept(static_cast<bool>(2))",
        "noexcept(bool(-1))",
        "noexcept(bool(1.0f))",
        "noexcept(!false)",
    ] {
        validate(&format!("__device__ int helper(int value) {specification} {{ return value + 1; }} __global__ void kernel(int *out) {{ out[0] = helper(3); }}"));
    }
    validate("constexpr bool Safe = true; __device__ int helper() noexcept(Safe) { return 7; } __global__ void kernel(int *out) { out[0] = helper(); }");
}

#[test]
fn cuda_noexcept_matches_redeclarations_by_value_and_preserves_ordinary_overloads() {
    validate("__device__ int safe(int) noexcept;
        __device__ int safe(int value) noexcept(1) { return value + 1; }
        __device__ int ordinary(int);
        __device__ int ordinary(int value) noexcept(false) { return value + 2; }
        __device__ int reverse(int) noexcept(0);
        __device__ int reverse(int value) { return value + 3; }
        __device__ int choose(int value) noexcept { return 10 + value; }
        __device__ int choose(unsigned value) noexcept(false) { return 20 + int(value); }
        __global__ void kernel(int *out) { out[0] = safe(1); out[1] = ordinary(1); out[2] = reverse(1); out[3] = choose(1); out[4] = choose(1u); }");
    for source in [
        "__device__ int f(int) noexcept; __device__ int f(int value) { return value; } __global__ void kernel() {}",
        "__device__ int f(int); __device__ int f(int value) noexcept { return value; } __global__ void kernel() {}",
        "__device__ int f(int) noexcept(false); __device__ int f(int) noexcept(true); __global__ void kernel() {}",
        "__device__ int f(int value) noexcept { return value; } __device__ int f(int value) noexcept(false) { return value; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_noexcept_supports_parameter_size_queries_with_indirect_and_erased_prefixes() {
    validate("using Null = decltype(nullptr); namespace cg = cooperative_groups;
        __device__ int value_size(int value) noexcept(sizeof(value) == 4) { return value; }
        __device__ int ref_size(const int &value) noexcept(sizeof(value) == 4) { return value; }
        __device__ int null_prefix(Null erased, const int &value) noexcept(sizeof(value) == 4) { return value; }
        __device__ int block_prefix(cg::thread_block erased, const int &value) noexcept(sizeof(value) == 4) { return value; }
        __global__ void kernel(int *out) { int local = 7; out[0] = value_size(local); out[1] = ref_size(local); out[2] = null_prefix(nullptr, local); out[3] = block_prefix(cg::this_thread_block(), local); }");
}

#[test]
fn cuda_noexcept_preserves_defaults_reference_expansion_forward_calls_and_builtin_capture() {
    validate("__device__ unsigned __vadd2(bool a, bool b) { return 7u; }
        __device__ int bump(int &value, int step = 2) noexcept;
        __device__ unsigned combined(unsigned a, unsigned b) noexcept(true) { return __vadd2(a, b); }
        __global__ void kernel(int *out) { int value = 1; out[0] = bump(value); out[1] = bump(value, 5); out[2] = int(combined(1u, 2u)); false && bump(value); true || bump(value); bump(value); out[3] = value; }
        __device__ int bump(int &renamed, int amount) noexcept(sizeof(renamed) == 4) { int old = renamed; renamed += amount; return old; }");
}

#[test]
fn cuda_noexcept_allows_short_circuited_nonconstant_calls_without_executing_them() {
    validate(
        "__device__ int opaque() { return 3; }
        __device__ int skipped() noexcept(false && opaque()) { return 7; }
        __device__ int selected() noexcept(true ? true : bool(opaque())) { return 9; }
        __global__ void kernel(int *out) { out[0] = skipped(); out[1] = selected(); }",
    );
}

#[test]
fn cuda_noexcept_rejects_nonnarrowing_boolean_failures_and_runtime_specifications() {
    for expression in [
        "2",
        "-1",
        "2u",
        "1.0f",
        "0.0f",
        "opaque()",
        "((opaque(), true))",
    ] {
        reject(&format!("__device__ int opaque() {{ return 1; }} __device__ int f() noexcept({expression}) {{ return 1; }} __global__ void kernel() {{}}"));
    }
    for expression in [
        "value",
        "((void)value, true)",
        "false ? value : 1",
        "true || value",
        "false && value",
        "((value++, true))",
    ] {
        reject(&format!("__device__ int f(int value) noexcept({expression}) {{ return value; }} __global__ void kernel() {{}}"));
    }
    reject("constexpr int value = 1; __device__ int f(int value) noexcept(value) { return value; } __global__ void kernel() {}");
    reject("using Null = decltype(nullptr); __device__ int f(Null erased, int &value) noexcept(((void)erased, true)) { return value; } __global__ void kernel() {}");
    reject("namespace cg = cooperative_groups; __device__ int f(cg::thread_block erased, int &value) noexcept(((void)erased, true)) { return value; } __global__ void kernel() {}");
}

#[test]
fn cuda_noexcept_rejects_kernel_template_intrinsic_specs_and_noexcept_operator() {
    for specification in ["noexcept", "noexcept(false)"] {
        reject(&format!("__global__ void kernel() {specification} {{}}"));
        reject(&format!(
            "template<int N> __global__ void kernel() {specification} {{}}"
        ));
        reject(&format!(
            "__device__ int __popc(unsigned value) {specification}; __global__ void kernel() {{}}"
        ));
    }
    reject("__device__ int helper() noexcept { return 1; } __global__ void kernel() { bool flag = noexcept(helper()); }");
    for suffix in [
        "noexcept()",
        "noexcept(true,)",
        "noexcept(true) noexcept",
        "noexcept(",
        "noexcept(true",
    ] {
        reject(&format!(
            "__device__ int f() {suffix} {{ return 1; }} __global__ void kernel() {{}}"
        ));
    }
}

#[test]
fn cuda_noexcept_specifications_add_no_runtime_loads_or_calls() {
    let source = "__device__ int opaque() { return 3; }
        __device__ int sized(const int &value) noexcept(sizeof(value) == 4) { return value; }
        __device__ int skipped() noexcept(false && opaque()) { return 7; }
        __global__ void kernel(int *out) { int value = 1; out[0] = sized(value); out[1] = skipped(); }";
    let control = source
        .replace("noexcept(sizeof(value) == 4)", "")
        .replace("noexcept(false && opaque())", "");
    let (annotated, _) =
        validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty());
    let (plain, _) = validate_with_options_and_capabilities(
        &control,
        &Options::default(),
        Capabilities::empty(),
    );
    let counts = |module: &naga::Module| {
        let mut loads = 0;
        let mut calls = 0;
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            loads += function
                .expressions
                .iter()
                .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
                .count();
            naga::proc::any_statement(&function.body, &mut |statement| {
                if matches!(statement, naga::Statement::Call { .. }) {
                    calls += 1;
                }
                false
            });
        }
        (loads, calls)
    };
    assert_eq!(counts(&annotated), counts(&plain));
    let skipped = annotated
        .functions
        .iter()
        .find_map(|(_, function)| (function.name.as_deref() == Some("skipped")).then_some(function))
        .unwrap();
    naga::proc::any_statement(&skipped.body, &mut |statement| {
        assert!(!matches!(statement, naga::Statement::Call { .. }));
        false
    });
}

#[test]
fn cuda_noexcept_skipped_compute_builtins_do_not_add_globals_inputs_or_initialization() {
    for expression in [
        "true || threadIdx.x",
        "false && gridDim.x",
        "true || blockIdx.x",
        "false && blockDim.x",
        "true || cooperative_groups::this_thread_block().thread_rank()",
        "false && cooperative_groups::this_thread_block().group_index().x",
        "true || cooperative_groups::this_thread_block().thread_index().y",
    ] {
        let source = format!(
            "__device__ unsigned helper() noexcept({expression}) {{ return 7u; }}
            __global__ void kernel(unsigned *out) {{ out[0] = helper(); }}"
        );
        let control = source.replace(&format!("noexcept({expression})"), "");
        let (annotated, _) = validate_with_options_and_capabilities(
            &source,
            &Options::default(),
            Capabilities::empty(),
        );
        let (plain, _) = validate_with_options_and_capabilities(
            &control,
            &Options::default(),
            Capabilities::empty(),
        );
        let globals = |module: &naga::Module| {
            module
                .global_variables
                .iter()
                .map(|(_, global)| (global.space, global.binding, global.init.is_some()))
                .collect::<Vec<_>>()
        };
        assert_eq!(globals(&annotated), globals(&plain), "{expression}");
        assert_eq!(
            annotated.global_variables.len(),
            1,
            "only output storage should exist: {expression}"
        );
        let arguments = |module: &naga::Module| {
            module.entry_points[0]
                .function
                .arguments
                .iter()
                .map(|argument| argument.binding.clone())
                .collect::<Vec<_>>()
        };
        assert_eq!(arguments(&annotated), arguments(&plain), "{expression}");
        let stores = |module: &naga::Module| {
            let mut count = 0;
            naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
                if matches!(statement, naga::Statement::Store { .. }) {
                    count += 1;
                }
                false
            });
            count
        };
        assert_eq!(stores(&annotated), stores(&plain), "{expression}");
    }
}

#[test]
fn cuda_noexcept_rejects_selected_template_calls_even_in_skipped_condition_arms() {
    for source in [
        "template<int N> __device__ unsigned g() { return gridDim.x + unsigned(N); } __device__ int f() noexcept(true || g<0>()) { return 1; } __global__ void kernel() {}",
        "template<int N> __device__ unsigned g() { return gridDim.x + unsigned(N); } __device__ int f() noexcept(false && g<0>()) { return 1; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned g(T value) { return gridDim.x + unsigned(value); } __device__ int f() noexcept(true || g(0)) { return 1; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned g(T value) { return gridDim.x + unsigned(value); } __device__ int f() noexcept(g(0)) { return 1; } __global__ void kernel() {}",
        "template<int N> __device__ unsigned g() { return gridDim.x + unsigned(N); } __device__ int f() noexcept(true || g<0>()) { return 1; } __global__ void kernel(unsigned *out) { out[0] = g<0>(); out[1] = unsigned(f()); }",
    ] { reject(source); }
    validate(
        "__device__ int g(int value) { return value; }
        template<class T> __device__ unsigned g(T value) { return gridDim.x + unsigned(value); }
        __device__ int f() noexcept(true || g(0)) { return 7; }
        __global__ void kernel(int *out) { out[0] = f(); }",
    );
}

#[test]
fn cuda_noexcept_compute_placeholders_remain_nonconstant_and_validate_components() {
    for expression in [
        "threadIdx.x != 0u",
        "gridDim.x == 1u",
        "blockIdx.x == 0u",
        "blockDim.x > 0u",
        "cooperative_groups::this_thread_block().thread_rank() == 0u",
        "cooperative_groups::this_thread_block().group_index().x == 0u",
        "cooperative_groups::this_thread_block().thread_index().y == 0u",
        "true || threadIdx.w",
        "false && gridDim.w",
        "true || cooperative_groups::this_thread_block().thread_index().w",
    ] {
        reject(&format!("__device__ int f() noexcept({expression}) {{ return 7; }} __global__ void kernel() {{}}"));
    }
}
