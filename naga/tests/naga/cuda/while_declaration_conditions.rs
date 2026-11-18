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
fn cuda_while_declaration_conditions_accept_explicit_and_inferred_scalar_forms() {
    validate("using Word = unsigned;
        __global__ void kernel(unsigned *out, unsigned input) {
            while (unsigned value = input) { out[0] = value; break; }
            while (Word value{input}) { out[1] = value; break; }
            while (auto value = input) { out[2] = value; break; }
            while (const auto value{input,}) { out[3] = value; break; }
            while (constexpr auto value = 1u) { out[4] = value; break; }
            while (short value = 3) { static_assert(sizeof(value) == 2); out[5] = unsigned(value); break; }
            while (float value{0.5f}) { out[6] = unsigned(value); break; }
            while (decltype(input) value = input) { out[7] = value; break; }
            while (bool value = false) { out[8] = unsigned(value); }
        }");
}

#[test]
fn cuda_while_declaration_conditions_keep_initialization_inside_each_condition_evaluation() {
    let (module, _) = validate("__device__ int sample(int value) { return value; }
        __global__ void kernel(int *out, const int *input) { unsigned cursor = 0u; while (int value = sample(input[cursor++])) { out[0] = value; value = 99; continue; } out[1] = int(cursor); }");
    let function = &module.entry_points[0].function;
    let (loop_position, body) = function
        .body
        .iter()
        .enumerate()
        .find_map(|(index, statement)| {
            if let naga::Statement::Loop {
                body, continuing, ..
            } = statement
            {
                assert!(continuing.is_empty());
                Some((index, body))
            } else {
                None
            }
        })
        .unwrap();
    assert!(!function
        .body
        .iter()
        .take(loop_position)
        .any(|statement| matches!(statement, naga::Statement::Call { .. })));
    let calls: Vec<_> = body
        .iter()
        .enumerate()
        .filter_map(|(index, statement)| {
            if let naga::Statement::Call {
                function: callee, ..
            } = statement
            {
                assert!(module.functions[*callee]
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("sample")));
                Some(index)
            } else {
                None
            }
        })
        .collect();
    assert_eq!(calls.len(), 1);
    let guard = body
        .iter()
        .position(|statement| {
            if let naga::Statement::If { accept, reject, .. } = statement {
                naga::proc::any_statement(accept, &mut |statement| {
                    matches!(statement, naga::Statement::Break)
                }) || naga::proc::any_statement(reject, &mut |statement| {
                    matches!(statement, naga::Statement::Break)
                })
            } else {
                false
            }
        })
        .unwrap();
    assert!(
        calls[0] < guard,
        "initializer must run before the terminating condition test"
    );
}

#[test]
fn cuda_while_declaration_conditions_evaluate_volatile_initializer_once_at_loop_prefix() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out, const volatile unsigned *input) { unsigned cursor = 0u; while (auto value = input[cursor++]) { out[0] = value; if (value == 1u) break; } out[1] = cursor; }",
        &Options::default(), Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let function = &module.entry_points[0].function;
    let reads: Vec<_> = function
        .expressions
        .iter()
        .filter_map(|(handle, expression)| {
            let naga::Expression::Load { pointer } = *expression else {
                return None;
            };
            let naga::Expression::GlobalVariable(global) =
                function.expressions[root_expression(function, pointer)]
            else {
                return None;
            };
            (module.global_variables[global].binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 1,
                }))
            .then_some(handle)
        })
        .collect();
    assert_eq!(reads.len(), 1);
    let mut emitted_in_loop = false;
    for statement in function.body.iter() {
        match statement {
            naga::Statement::Emit(range) => {
                assert!(!range.clone().any(|handle| handle == reads[0]))
            }
            naga::Statement::Loop { body, .. } => {
                naga::proc::any_statement(body, &mut |statement| {
                    if let naga::Statement::Emit(range) = statement {
                        emitted_in_loop |= range.clone().any(|handle| handle == reads[0]);
                    }
                    false
                });
            }
            _ => {}
        }
    }
    assert!(emitted_in_loop);
}

#[test]
fn cuda_while_declaration_conditions_preserve_scope_nested_control_and_case_checkpoints() {
    validate("__device__ unsigned next(unsigned &cursor) { return cursor++; }
        __global__ void kernel(unsigned *out, unsigned input) {
            unsigned value = 7u;
            while (auto value = input) {
                { unsigned value = 2u; out[0] = value; }
                if (unsigned value = input) { out[1] = value; }
                while (unsigned value = 1u) { out[2] = value; break; }
                for (unsigned value = 0u; value < 1u; ++value) out[3] = value;
                break;
            }
            out[4] = value;
            if (unsigned value = input) while (auto value = input) { out[5] = value; break; }
            unsigned cursor = 0u;
            while (unsigned item = next(cursor)) { switch (item) { case 1u: continue; default: break; } break; }
            switch (input) { case 0u: while (unsigned header = input) { break; } case 1u: out[6] = input; break; default: break; }
        }");
}

#[test]
fn cuda_while_declaration_conditions_preserve_source_identity_and_explicit_cv() {
    let (module, _) = validate("__device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        __global__ void kernel(int *out) { const int source = 1; while (auto value = source) { value = 2; out[0] = value; break; } while (long value = 1L) { out[1] = kind(value); break; } while (auto value = 2LL) { out[2] = kind(value); break; } }");
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
    reject("__global__ void kernel() { while (const auto value = 1) { value = 2; } }");
}

#[test]
fn cuda_while_declaration_conditions_reject_redeclarations_escapes_and_unsupported_forms() {
    for body in [
        "while (int value = 1) { int value = 2; }",
        "while (auto value = 1) { auto value{2}; }",
        "while (int value = 0) {} value = 1;",
        "int value = 1; while (auto value = value) {}",
        "while (int seed = 1; seed) {}",
        "do {} while (int value = 0);",
        "for (; int value = 1;) {}",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    for condition in [
        "int value",
        "int value(1)",
        "int first = 1, second = 2",
        "auto value{}",
        "auto value = {1}",
        "auto value{1,2}",
        "int *value = &input",
        "auto value = &input",
        "int &value = input",
        "auto &value = input",
        "auto value = nullptr",
        "auto value = vector",
        "auto value = record",
        "auto value = group",
        "volatile int value = 1",
        "constexpr auto value = input",
    ] {
        reject(&format!("// π UTF-8 span\nstruct Record {{ int member; }}; __global__ void kernel(int input) {{ int2 vector; Record record; auto group = cooperative_groups::this_thread_block(); while ({condition}) {{}} }}"));
    }
}

#[test]
fn cuda_while_declaration_conditions_preserve_ordinary_cast_comma_and_template_body_parsing() {
    validate("template<class T> __device__ T consume(T input) { while (auto value = input) { return value; } return T(0); }
        __global__ void kernel(unsigned *out, unsigned input) { using Number = int; while (int(input), input) { out[0] = input; break; } while (Number(input), input) { out[1] = input; break; } out[2] = consume(input); }");
}
