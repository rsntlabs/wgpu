use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{root_expression, validate_with_options_and_capabilities};

fn validate(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    )
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
fn cuda_inferred_selection_conditions_support_equal_braces_trailing_comma_and_optional_init() {
    validate("__global__ void kernel(unsigned *out, unsigned input) {
        if (auto value = input) out[0] = value; else out[0] = value + 1u;
        if (auto value{input}) out[1] = value;
        if (auto value{input,}) out[2] = value;
        if (auto value = (input, 3u)) out[3] = value;
        if (; auto value = input) out[4] = value;
        if (unsigned seed = input; auto ready = seed != 0u) out[5] = unsigned(ready);
        if (auto fraction = 0.5f) out[6] = unsigned(fraction);
        switch (unsigned seed = input; auto key = seed & 3u) { case 0u: out[7] = key; break; default: out[7] = seed; }
        switch (constexpr auto key{1,}) { case key: out[8] = unsigned(key); break; default: out[8] = 0u; }
    }");
}

#[test]
fn cuda_inferred_selection_conditions_drop_initializer_cv_but_preserve_explicit_const() {
    validate(
        "__global__ void kernel(unsigned *out) {
        const unsigned source = 1u;
        if (auto value = source) { value = 2u; out[0] = value; }
        switch (auto key = source) { default: key = 3u; out[1] = key; }
        if (const auto value = source) out[2] = value;
        switch (const auto key = 1u) { case key: out[3] = key; break; default: break; }
    }",
    );
    reject("__global__ void kernel() { if (const auto value = 1u) value = 2u; }");
    reject("__global__ void kernel() { switch (const auto key = 1u) { default: key = 2u; } }");
}

#[test]
fn cuda_inferred_selection_conditions_preserve_narrow_type_before_switch_promotion() {
    let (module, info) = validate("__global__ void kernel(int *out) { short source = 3; switch (auto key{source,}) { case 0: out[0] = key; break; default: static_assert(sizeof(key) == 2); out[0] = key; } }");
    let mut selectors = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Switch { selector, .. } = statement {
            assert_eq!(
                info.get_entry_point(0)[*selector]
                    .ty
                    .inner_with(&module.types),
                &naga::TypeInner::Scalar(naga::Scalar::I32)
            );
            selectors += 1;
        }
        false
    });
    assert_eq!(selectors, 1);
}

#[test]
fn cuda_inferred_selection_conditions_preserve_source_long_identity_and_scope() {
    let (module, _) = validate("__device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        __global__ void kernel(int *out, unsigned input) {
            int value = 7;
            if (auto value = 1L) { out[0] = kind(value); { auto value = 3u; out[2] = int(value); } }
            else if (auto value = 2u) out[2] = int(value);
            if (auto value = 2LL) out[1] = kind(value);
            out[3] = value;
            for (unsigned index = 0u; index < 4u; ++index) { if (auto skip = index == 1u) continue; switch (auto key = index) { case 0u: break; default: out[4] = int(key); } if (auto stop = index == 3u) break; }
        }");
    let mut tags = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let callee = &module.functions[function];
            naga::proc::any_statement(&callee.body, &mut |statement| {
                if let naga::Statement::Return { value: Some(value) } = statement {
                    if let naga::Expression::Literal(naga::Literal::I32(tag)) =
                        callee.expressions[*value]
                    {
                        tags.push(tag);
                    }
                }
                false
            });
        }
        false
    });
    assert_eq!(tags, [1, 2]);
}

#[test]
fn cuda_inferred_selection_conditions_evaluate_volatile_initializers_once() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out, const volatile unsigned *input) { if (auto value = input[0]) out[0] = value; else out[0] = value + 1u; switch (auto key = input[1]) { case 0u: out[1] = key; break; default: out[1] = key + 1u; } }",
        &Options::default(), Capabilities::MEMORY_DECORATION_VOLATILE,
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
    assert_eq!(reads, 2);
    validate("__device__ unsigned next(unsigned &cursor) { return cursor++; } __global__ void kernel(unsigned *out) { unsigned cursor = 0u; if (auto value = next(cursor)) out[0] = value; else out[0] = value; switch (auto key = next(cursor)) { default: out[1] = key; } out[2] = cursor; }");
}

#[test]
fn cuda_inferred_selection_conditions_reject_pending_auto_lists_and_nonscalar_bindings() {
    for condition in [
        "auto value",
        "auto value{}",
        "auto value{1, 2}",
        "auto value = {1}",
        "auto value(1)",
        "auto first = 1, second = 2",
        "auto value = value",
        "auto value{value}",
        "auto *value = &input",
        "auto &value = input",
        "auto &&value = input",
        "auto value = &input",
        "auto value = nullptr",
        "auto value = vector",
        "auto value = record",
        "auto value = array",
        "auto value = group",
        "volatile auto value = 1",
        "constexpr auto value = input",
    ] {
        for selection in [
            format!("if ({condition}) {{}}"),
            format!("switch ({condition}) {{ default: break; }}"),
        ] {
            reject(&format!("// π UTF-8 span\nstruct Record {{ int member; }}; __global__ void kernel(int input) {{ int value = 1; int2 vector; Record record; int array[2]; auto group = cooperative_groups::this_thread_block(); {selection} }}"));
        }
    }
    for body in [
        "if (unsigned value = 1u; auto value = 2u) {}",
        "if (auto value = 1u) { auto value = 2u; }",
        "if (auto value = 1u) {} else { int value = 2; }",
        "switch (auto key = 1u) { default: auto key = 2u; }",
        "if (auto value = 1u) {} value = 2u;",
        "switch (auto key = 1u) { default: break; } key = 2u;",
        "if constexpr (auto value = 1u) {}",
        "switch (auto key = 1L) { default: break; }",
        "switch (auto key = 1.0f) { default: break; }",
    ] {
        reject(&format!("__global__ void kernel(int input) {{ {body} }}"));
    }
}

#[test]
fn cuda_inferred_selection_conditions_preserve_explicit_and_cast_comma_conditions() {
    validate("using Number = int; __global__ void kernel(unsigned *out, unsigned input) { if (int(input), input) out[0] = input; if (int explicit_value = int(input)) out[1] = unsigned(explicit_value); switch (Number(input), input) { default: out[2] = input; } switch ((int(input)); auto key = input) { default: out[3] = key; } }");
}
