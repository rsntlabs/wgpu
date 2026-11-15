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
fn cuda_if_initializers_accept_existing_simple_declaration_and_expression_forms() {
    validate(
        "__device__ void increment(unsigned &value) { ++value; }
        __global__ void kernel(unsigned *out) {
            unsigned count = 0u;
            if (; true) out[0] = 1u;
            if (increment(count); false) out[0] = 2u; else out[0] = count;
            if (count++, count++; count > 0u) out[1] = count;
            if (unsigned first = 2u, second = 3u; first < second) out[2] = first + second;
            if (auto value = 4u; value) out[3] = value;
            if (unsigned &alias = count; alias) ++alias;
            if (typedef unsigned Word; true) { Word value = 5u; out[4] = value; }
            if (struct Record { unsigned value; }; true) { Record value; value.value = 6u; out[5] = value.value; }
        }",
    );
}

#[test]
fn cuda_if_initializers_scope_both_branches_and_restore_shadowed_names() {
    validate(
        "__global__ void kernel(unsigned *out) {
            unsigned value = 7u;
            if (unsigned value = 1u; value) {
                out[0] = value;
                { unsigned value = 2u; out[1] = value; }
            } else if (unsigned value = 3u; value) out[2] = value;
            else out[3] = value;
            out[4] = value;
            if (unsigned item = 1u; item) { unsigned local = item; out[5] = local; }
            else { unsigned local = item + 1u; out[5] = local; }
        }",
    );
}

#[test]
fn cuda_if_initializers_reject_outermost_branch_redeclarations_on_all_declaration_paths() {
    for branch in [
        "unsigned value = 2u;",
        "{ unsigned value = 2u; }",
        "{ unsigned value(2u); }",
        "{ unsigned value{2u}; }",
        "{ auto value = 2u; }",
    ] {
        for controlled in [String::from(branch), format!("{{}} else {branch}")] {
            reject(&format!(
                "__global__ void kernel() {{ if (unsigned value = 1u; value) {controlled} }}"
            ));
        }
    }
    for source in [
        "__global__ void kernel() { if (typedef unsigned Name; true) { typedef int Name; } }",
        "__global__ void kernel() { if (typedef unsigned Name; true) {} else { unsigned Name = 1u; } }",
        "__global__ void kernel() { if (struct Name { unsigned value; }; true) { struct Name { unsigned other; }; } }",
    ] { reject(source); }
}

#[test]
fn cuda_if_initializers_do_not_leak_header_or_branch_names() {
    for body in [
        "if (unsigned value = 1u; value) {} out[0] = value;",
        "if (typedef unsigned Word; true) {} Word value = 1u;",
        "if (struct Record { unsigned value; }; true) {} Record value;",
        "if (unsigned value = 1u; value) { unsigned local = value; } else out[0] = local;",
        "if (unsigned value = 1u; value) {} else { unsigned local = value; } out[0] = local;",
    ] {
        reject(&format!(
            "__global__ void kernel(unsigned *out) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_if_initializers_run_void_initializer_once_before_false_or_lazy_condition() {
    let (module, _) = validate(
        "__device__ void touch(unsigned *out) { out[1] = 9u; }
        __global__ void kernel(unsigned *out) {
            unsigned count = 0u;
            if (touch(out); false && count++) out[0] = 1u; else out[0] = count;
        }",
    );
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
            naga::Statement::If { .. } => events.push("condition"),
            _ => {}
        }
        false
    });
    assert_eq!(
        events
            .iter()
            .filter(|event| **event == "initializer")
            .count(),
        1
    );
    assert_eq!(events.first(), Some(&"initializer"));
    assert!(events.contains(&"condition"));
}

#[test]
fn cuda_if_initializers_read_volatile_initializer_once() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out, const volatile unsigned *input) { if (unsigned value = input[0]; value) out[0] = value; else out[0] = 0u; }",
        &Options::default(), naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let function = &module.entry_points[0].function;
    let loads = function
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
    assert_eq!(loads, 1);
}

#[test]
fn cuda_if_initializers_preserve_dangling_else_and_loop_switch_termination() {
    validate(
        "__device__ unsigned choose(unsigned input) {
            if (unsigned outer = input; outer) if (unsigned inner = outer; inner > 1u) return inner; else return outer;
            return 0u;
        }
        __global__ void kernel(unsigned *out) {
            for (unsigned index = 0u; index < 4u; ++index) {
                if (unsigned value = index; value == 1u) continue;
                if (unsigned value = index; value == 3u) break;
                switch (index) { case 0u: if (unsigned value = choose(index); value) out[index] = value; else break; break; default: out[index] = index; }
            }
        }",
    );
    reject("__global__ void kernel(unsigned *out, unsigned input) { switch(input) { case 0u: if (unsigned value = input; value) { case 1u: out[0] = value; } } }");
}

#[test]
fn cuda_if_initializers_reject_malformed_or_out_of_scope_header_forms() {
    for body in [
        "if (unsigned value = 1u; ) {}",
        "if (unsigned value = 1u) {}",
        "if (1u 2u) {}",
        "if (using Word = unsigned; true) {}",
        "if (static_assert(true); true) {}",
        "if (namespace Name = cooperative_groups; true) {}",
        "if constexpr (unsigned value = 1u; true) {}",
        "if (unsigned value = 1u; unsigned other = value) {}",
    ] {
        reject(&format!(
            "// π UTF-8 prefix\n__global__ void kernel() {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_if_initializers_obey_statement_nesting_limits() {
    let source = format!(
        "__global__ void kernel() {{ {} {{}} }}",
        "if (unsigned value = 1u; value) ".repeat(100)
    );
    let error = reject(&source);
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}

#[test]
fn cuda_if_initializers_preserve_ordinary_cast_comma_conditions() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned value, bool flag) {
            using Number = int;
            if (int(value), flag) out[0] = 1u;
            if (Number(value), flag) out[1] = 2u;
            if ((int(value)), flag) out[2] = 3u;
            if ((Number(value), flag)) out[3] = 4u;
            if ((int(value)); flag) out[4] = 5u;
            if ((Number(value)); flag) out[5] = 6u;
        }",
    );
    reject("__global__ void kernel(unsigned value, bool flag) { if (int(value); flag) {} }");
    reject("__global__ void kernel(unsigned value, bool flag) { using Number = int; if (Number(value); flag) {} }");
}
