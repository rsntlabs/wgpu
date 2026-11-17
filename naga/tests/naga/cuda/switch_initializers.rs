use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

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
fn cuda_switch_initializers_accept_empty_expression_and_simple_declarations() {
    validate("__device__ void increment(unsigned &value) { ++value; }
        __global__ void kernel(unsigned *out, unsigned selector) {
            unsigned count = 0u;
            switch (; selector) { default: break; }
            switch (increment(count); selector) { default: out[0] = count; break; }
            switch (count++, count++; selector) { default: out[1] = count; }
            switch (unsigned first = selector, second = first + 1u; second) { case 0u: out[2] = first; break; default: out[2] = second; }
            switch (auto value = selector; value) { default: out[3] = value; }
            switch (unsigned &alias = count; selector) { default: ++alias; }
            switch (typedef unsigned Word; selector) { default: { Word value = 7u; out[4] = value; } }
        }");
}

#[test]
fn cuda_switch_initializers_execute_before_every_case_and_preserve_bypass_rejection() {
    validate("__global__ void kernel(unsigned *out, unsigned selector) {
        switch (unsigned value = selector; value) {
            case 0u: out[0] = value; break;
            case 1u: out[0] = value + 1u; break;
            default: out[0] = value + 2u;
        }
        switch (constexpr unsigned Key = 3u; selector) { case Key: out[1] = Key; break; default: out[1] = 0u; }
    }");
    reject("__global__ void kernel(unsigned selector) { switch (unsigned header = selector; header) { case 0u: unsigned bypassed = 1u; case 1u: break; default: break; } }");
    validate("__global__ void kernel(unsigned selector) { switch (unsigned header = selector; header) { case 0u: { unsigned local = 1u; } case 1u: break; default: break; } }");
}

#[test]
fn cuda_switch_initializers_scope_headers_and_allow_only_nested_block_shadowing() {
    validate("__global__ void kernel(unsigned *out, unsigned selector) {
        unsigned value = 7u;
        switch (unsigned value = selector; value) { case 0u: out[0] = value; break; default: { unsigned value = 2u; out[0] = value; } }
        out[1] = value;
        if (unsigned outer = selector; outer) switch (unsigned outer = selector + 1u; outer) { default: out[2] = outer; }
    }");
    for source in [
        "__global__ void kernel(unsigned selector) { switch (unsigned value = selector; value) { default: unsigned value = 2u; break; } }",
        "__global__ void kernel(unsigned selector) { switch (typedef unsigned Word; selector) { default: typedef int Word; break; } }",
        "__global__ void kernel(unsigned selector) { switch (struct Record { unsigned value; }; selector) { default: struct Record { unsigned other; }; break; } }",
        "__global__ void kernel(unsigned *out) { switch (unsigned value = 1u; value) { default: break; } out[0] = value; }",
        "__global__ void kernel() { switch (typedef unsigned Word; 0u) { default: break; } Word value = 1u; }",
    ] { reject(source); }
}

#[test]
fn cuda_switch_initializers_keep_ordinary_cast_comma_selectors() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned value, unsigned selector) {
        using Number = int;
        switch (int(value), selector) { default: out[0] = 1u; }
        switch (Number(value), selector) { default: out[1] = 2u; }
        switch ((Number(value), selector)) { default: out[2] = 3u; }
        switch ((int(value)); selector) { default: out[3] = 4u; }
    }",
    );
    reject("__global__ void kernel(unsigned value, unsigned selector) { switch (int(value); selector) { default: break; } }");
}

#[test]
fn cuda_switch_initializers_run_void_effect_once_before_default_only_dispatch() {
    let (module, _) = validate("__device__ void touch(unsigned *out) { out[1] = 9u; }
        __global__ void kernel(unsigned *out) { switch (touch(out); 0u) { default: out[0] = 3u; } }");
    let function = &module.entry_points[0].function;
    let mut events = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        match statement {
            naga::Statement::Store { value, .. }
                if matches!(
                    function.expressions[*value],
                    naga::Expression::Literal(naga::Literal::U32(9))
                ) =>
            {
                events.push("initializer")
            }
            naga::Statement::Switch { .. } => events.push("switch"),
            _ => {}
        }
        false
    });
    assert_eq!(events, ["initializer", "switch"]);
}

#[test]
fn cuda_switch_initializers_read_volatile_dispatch_value_once() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out, const volatile unsigned *input) { switch (unsigned value = input[0]; value) { case 0u: out[0] = value; break; default: out[0] = value + 1u; } }",
        &Options::default(), naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
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
    assert_eq!(reads, 1);
}

#[test]
fn cuda_switch_initializers_preserve_labels_fallthrough_and_termination() {
    validate("__device__ unsigned route(unsigned selector) {
        switch (unsigned key = selector; key) { case 0u: return key; default: return key + 1u; }
        }
        __global__ void kernel(unsigned *out, unsigned selector) {
            for (unsigned index = 0u; index < 4u; ++index) {
                switch (unsigned value = index; value) {
                    case 0u: continue;
                    case 1u: out[index] = route(value);
                    case 2u: switch (unsigned value = selector; value) { default: break; } break;
                    default: break;
                }
                out[index] = index;
            }
            if (selector) switch (unsigned key = selector; key) { default: if (key) out[0] = key; else out[0] = 0u; }
            else out[0] = 7u;
        }");
}

#[test]
fn cuda_switch_initializers_reject_malformed_and_unsupported_headers() {
    for header in [
        "unsigned value = 1u;",
        ";",
        ";; 1u",
        "using Word = unsigned; 1u",
        "static_assert(true); 1u",
        "namespace Name = cooperative_groups; 1u",
        "long value = 1L; value",
    ] {
        reject(&format!("// π UTF-8 span\n__global__ void kernel() {{ switch ({header}) {{ default: break; }} }}"));
    }
    let source = format!(
        "__global__ void kernel(unsigned selector) {{ {} {{}} }}",
        "switch (unsigned value = selector; value) default: ".repeat(100)
    );
    let error = reject(&source);
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}
