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

fn for_loop(function: &naga::Function) -> (&naga::Block, &naga::Block) {
    function
        .body
        .iter()
        .filter_map(|statement| match statement {
            naga::Statement::Block(scope) => Some(scope.iter()),
            _ => None,
        })
        .flatten()
        .find_map(|statement| match statement {
            naga::Statement::Loop {
                body, continuing, ..
            } => Some((body, continuing)),
            _ => None,
        })
        .expect("for loop inside its header scope")
}

#[test]
fn cuda_for_declaration_conditions_accept_scalar_forms_and_continuing_visibility() {
    validate("using Word = unsigned;
        __global__ void kernel(unsigned *out, unsigned input) {
            for (unsigned seed = input; Word value = seed; seed = value - 1u) { out[0] = value; break; }
            for (; auto value{input,}; value = 0u) { out[1] = value; break; }
            for (; const auto value = input; out[2] = value) { break; }
            for (; constexpr auto value = 1u; out[3] = value) { break; }
            for (; short value = 3; out[4] = unsigned(value)) { static_assert(sizeof(value) == 2); break; }
            for (; float value{0.5f}; out[5] = unsigned(value)) { break; }
            for (; decltype(input) value = input; value = 0u) { break; }
        }");
}

#[test]
fn cuda_for_declaration_conditions_initialize_in_body_and_reload_mutated_value_in_continuing() {
    let (module, info) = validate("__device__ int sample(int value) { return value; }
        __global__ void kernel(int *out, const int *input) { unsigned cursor = 0u; for (; int value = sample(input[cursor++]); out[0] = value) { value = 99; continue; } out[1] = int(cursor); }");
    let function = &module.entry_points[0].function;
    let (body, continuing) = for_loop(function);
    let mut call_count = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        call_count += usize::from(matches!(statement, naga::Statement::Call { .. }));
        false
    });
    assert_eq!(call_count, 1);
    let calls: Vec<_> = body
        .iter()
        .enumerate()
        .filter_map(|(index, statement)| {
            matches!(statement, naga::Statement::Call { .. }).then_some(index)
        })
        .collect();
    assert_eq!(calls.len(), 1);
    let guard = body
        .iter()
        .position(|statement| matches!(statement, naga::Statement::If { .. }))
        .unwrap();
    assert!(calls[0] < guard);
    let value = function
        .local_variables
        .iter()
        .find_map(|(handle, local)| (local.name.as_deref() == Some("value")).then_some(handle))
        .unwrap();
    let mut continuing_reads = 0;
    naga::proc::any_statement(continuing, &mut |statement| {
        if let naga::Statement::Emit(range) = statement {
            for expression in range.clone() {
                if let naga::Expression::Load { pointer } = function.expressions[expression] {
                    if matches!(function.expressions[root_expression(function, pointer)], naga::Expression::LocalVariable(local) if local == value)
                    {
                        continuing_reads += 1;
                    }
                }
            }
        }
        false
    });
    assert_eq!(
        continuing_reads, 1,
        "continuing must read the live condition variable, not body-only SSA"
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_for_declaration_conditions_preserve_scopes_control_flow_and_case_checkpoints() {
    validate("__global__ void kernel(unsigned *out, unsigned input) {
        unsigned value = 7u;
        for (unsigned cursor = 0u; auto value = input; ++cursor) { { unsigned value = 2u; out[0] = value; } value = 9u; if (cursor == 0u) continue; break; }
        out[1] = value;
        if (unsigned value = input) for (; auto value = input; value = 0u) { out[2] = value; break; }
        switch (input) { case 0u: for (; unsigned value = input; value = 0u) { break; } case 1u: out[3] = input; break; default: break; }
        for (unsigned cursor = 0u; auto value = input; ++cursor) { switch (value) { case 1u: continue; default: break; } break; }
        for (;;) { break; }
        using Number = int; for (; Number(input), input;) { break; }
    }");
}

#[test]
fn cuda_for_declaration_conditions_evaluate_volatile_initializer_once_in_loop_prefix() {
    let (module, _) = validate_with_options_and_capabilities("__global__ void kernel(unsigned *out, const volatile unsigned *input) { unsigned cursor = 0u; for (; auto value = input[cursor++]; out[0] = value) { if (value == 1u) break; } out[1] = cursor; }", &Options::default(), Capabilities::MEMORY_DECORATION_VOLATILE);
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
    let (body, _) = for_loop(function);
    assert!(naga::proc::any_statement(
        body,
        &mut |statement| matches!(statement, naga::Statement::Emit(range) if range.clone().any(|handle| handle == reads[0]))
    ));
}

#[test]
fn cuda_for_declaration_conditions_reject_invalid_forms_and_scope_violations() {
    for body in [
        "for (unsigned value = 1u; auto value = 2u;) {}",
        "for (; auto value = 1u;) { int value = 2; }",
        "for (; int value = 0;) {} value = 1;",
        "for (int seed = value; auto value = 1;) {}",
        "int value = 1; for (; auto value = value;) {}",
        "for (; const auto value = 1; ++value) {}",
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
        "auto value = &input",
        "int &value = input",
        "auto value = nullptr",
        "auto value = vector",
        "auto value = record",
        "volatile int value = 1",
        "constexpr auto value = input",
    ] {
        reject(&format!("// π UTF-8 span\nstruct Record {{ int member; }}; __global__ void kernel(int input) {{ int2 vector; Record record; for (; {condition};) {{}} }}"));
    }
}

#[test]
fn cuda_for_declaration_conditions_fixture_roundtrips_without_wide_shader_types() {
    let (module, info) = validate_with_options_and_capabilities(
        include_str!("../../in/cuda/for-declaration-conditions.cu"),
        &Options {
            workgroup_size: [4, 1, 1],
            ..Options::default()
        },
        Capabilities::empty(),
    );
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}
