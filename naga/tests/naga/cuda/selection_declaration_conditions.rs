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

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_selection_declaration_conditions_accept_explicit_scalar_forms_and_optional_initializers() {
    validate("using Word = unsigned;
        __global__ void kernel(unsigned *out, unsigned input) {
            if (int value = int(input)) out[0] = unsigned(value); else out[0] = unsigned(value + 1);
            if (bool ready{true}) out[1] = unsigned(ready);
            if (float value{0.5f}) out[8] = unsigned(value);
            if (; short value = 3) out[2] = unsigned(value);
            if (input++; Word value{input}) out[3] = value;
            if (Word seed = input; decltype(seed) value = seed) out[4] = value;
            switch (const unsigned mode{input}) { case 0u: out[5] = mode; break; default: out[5] = mode + 1u; }
            switch (unsigned seed = input; bool ready = seed != 0u) { case false: out[6] = unsigned(ready); break; default: out[6] = seed; }
            switch (; constexpr int key = 1) { case key: out[7] = unsigned(key); break; default: break; }
        }");
}

#[test]
fn cuda_selection_declaration_conditions_promote_the_bound_switch_variable() {
    for (declaration, scalar) in [
        ("short mode = -1", naga::Scalar::I32),
        ("bool mode = true", naga::Scalar::I32),
        ("unsigned mode = 1u", naga::Scalar::U32),
    ] {
        let (module, info) = validate(&format!("__global__ void kernel(int *out) {{ switch ({declaration}) {{ default: out[0] = int(mode); }} }}"));
        let mut selectors = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Switch { selector, .. } = statement {
                assert_eq!(
                    info.get_entry_point(0)[*selector]
                        .ty
                        .inner_with(&module.types),
                    &naga::TypeInner::Scalar(scalar)
                );
                selectors += 1;
            }
            false
        });
        assert_eq!(selectors, 1);
    }
}

#[test]
fn cuda_selection_declaration_conditions_preserve_header_scope_shadowing_and_termination() {
    validate("__device__ unsigned route(unsigned input) {
            if (unsigned value = input) return value; else return value + 1u;
        }
        __global__ void kernel(unsigned *out, unsigned input) {
            unsigned value = 7u;
            if (unsigned value = input) { out[0] = value; { unsigned value = 2u; out[1] = value; } }
            else if (unsigned value = input + 1u) out[0] = value; else out[0] = value;
            out[2] = value;
            for (unsigned index = 0u; index < 4u; ++index) {
                if (unsigned seed = index; bool skip = seed == 1u) continue;
                switch (unsigned key = index) { case 0u: out[3] = key; case 1u: break; default: { unsigned key = 9u; out[3] = key; } }
                if (bool stop = index == 3u) break;
            }
            out[4] = route(input);
        }");
}

#[test]
fn cuda_selection_declaration_conditions_initialize_once_before_truthiness_and_dispatch() {
    let source = "__global__ void kernel(unsigned *out, const volatile unsigned *input) {
        if (unsigned value = input[0]) out[0] = value; else out[0] = value + 1u;
        switch (unsigned key = input[1]) { case 0u: out[1] = key; break; default: out[1] = key + 1u; }
    }";
    let (module, _) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
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
    let value = function
        .named_expressions
        .iter()
        .find_map(|(&handle, name)| (name == "value").then_some(handle))
        .unwrap();
    let key = function
        .named_expressions
        .iter()
        .find_map(|(&handle, name)| (name == "key").then_some(handle))
        .unwrap();
    for handle in [value, key] {
        assert!(matches!(
            function.expressions[handle],
            naga::Expression::Load { .. }
        ));
    }
    let mut events = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        match statement {
            naga::Statement::Emit(range) => {
                for handle in range.clone() {
                    if handle == value {
                        events.push("value");
                    }
                    if handle == key {
                        events.push("key");
                    }
                }
            }
            naga::Statement::If { condition, .. } => {
                assert!(
                    matches!(function.expressions[*condition], naga::Expression::Binary { op: naga::BinaryOperator::NotEqual, left, right } if left == value || right == value)
                );
                events.push("if");
            }
            naga::Statement::Switch { selector, .. } => {
                assert_eq!(*selector, key);
                events.push("switch");
            }
            _ => {}
        }
        false
    });
    assert_eq!(events, ["value", "if", "key", "switch"]);
    validate("__device__ unsigned next(unsigned &cursor) { return cursor++; } __global__ void kernel(unsigned *out) { unsigned cursor = 0u; if (unsigned value = next(cursor)) out[0] = value; else out[0] = value; switch (unsigned key = next(cursor)) { default: out[1] = key; } out[2] = cursor; }");
}

#[test]
fn cuda_selection_declaration_conditions_keep_case_initializer_bypass_and_redeclaration_rules() {
    validate("__global__ void kernel(unsigned *out, unsigned input) { switch (const unsigned key = 1u) { case key: out[0] = key; break; default: out[0] = 0u; } }");
    for source in [
        "__global__ void kernel(unsigned input) { if (unsigned value = input; unsigned value = 1u) {} }",
        "__global__ void kernel(unsigned input) { if (unsigned value = input) { unsigned value = 2u; } }",
        "__global__ void kernel(unsigned input) { if (unsigned value = input) {} else { unsigned value{2u}; } }",
        "__global__ void kernel(unsigned input) { switch (unsigned key = input) { default: unsigned key = 2u; break; } }",
        "__global__ void kernel(unsigned input) { switch (unsigned key = input) { case 0u: unsigned skipped = 1u; case 1u: break; } }",
        "__global__ void kernel(unsigned *out) { if (unsigned value = 1u) {} out[0] = value; }",
        "__global__ void kernel(unsigned *out) { switch (unsigned value = 1u) { default: break; } out[0] = value; }",
    ] { reject(source); }
}

#[test]
fn cuda_selection_declaration_conditions_preserve_cast_comma_expression_conditions() {
    validate(
        "using Number = int; __global__ void kernel(unsigned *out, unsigned value, unsigned key) {
        if (int(value), key) out[0] = 1u;
        if (Number(value), key) out[1] = 2u;
        if ((int(value)); Number(key), value) out[2] = 3u;
        switch (Number(value), key) { default: out[3] = 4u; }
        switch ((Number(value)); int(key), value) { default: out[4] = 5u; }
    }",
    );
}

#[test]
fn cuda_selection_declaration_conditions_reject_narrowing_and_unsupported_declaration_forms() {
    for condition in [
        "int value",
        "int value(1)",
        "int first = 1, second = 2",
        "auto value = {1}",
        "int *value = nullptr",
        "int &value = input",
        "int value[2]{}",
        "float3 value = float3(1.0f)",
        "Record value{}",
        "volatile int value = 1",
        "typedef int Value",
        "using Value = int",
        "static int value = 1",
        "bool value{2}",
        "short value{32768}",
        "int value{1.5f}",
        "constexpr int value = input",
    ] {
        for selection in [
            format!("if ({condition}) {{}}"),
            format!("switch ({condition}) {{ default: break; }}"),
        ] {
            reject(&format!("// π UTF-8 span\nstruct Record {{ int value; }}; __global__ void kernel(int input) {{ {selection} }}"));
        }
    }
    for body in [
        "while (int value = input) {}",
        "for (; int value = input;) {}",
        "if constexpr (int value = 1) {}",
        "switch (long value = 1L) { default: break; }",
    ] {
        reject(&format!("__global__ void kernel(int input) {{ {body} }}"));
    }
}

#[test]
fn cuda_selection_declaration_conditions_preserve_long_and_long_long_source_identity() {
    let (module, _) = validate("__device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        __global__ void kernel(int *out) { if (long value = 1L) out[0] = kind(value); if (long long value = 2LL) out[1] = kind(value); }");
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
