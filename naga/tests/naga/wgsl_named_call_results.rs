#![cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]

use naga::valid::{Capabilities, ValidationFlags, Validator};

fn assert_named_call_result(function: &naga::Function, output: &str) {
    assert!(
        function.named_expressions.iter().any(|(&handle, name)| {
            name == "readable_result"
                && matches!(
                    function.expressions[handle],
                    naga::Expression::CallResult(_)
                )
        }),
        "named call result missing\n{output}"
    );
}

#[test]
fn wgsl_writer_preserves_named_function_call_results() {
    let source = "fn increment(value: u32) -> u32 { return value + 1u; }
        @compute @workgroup_size(1) fn main() {
            let readable_result = increment(2u);
            if (readable_result == 0u) { return; }
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = Validator::new(ValidationFlags::all(), Capabilities::empty())
        .validate(&module)
        .unwrap();
    assert_named_call_result(&module.entry_points[0].function, source);
    for flags in [
        naga::back::wgsl::WriterFlags::empty(),
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    ] {
        let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output)
            .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
        Validator::new(ValidationFlags::all(), Capabilities::empty())
            .validate(&reparsed)
            .unwrap();
        assert_named_call_result(&reparsed.entry_points[0].function, &output);
    }
}

#[test]
fn wgsl_writer_sanitizes_named_call_results_and_avoids_existing_local_names() {
    let source = "fn increment(value: u32) -> u32 { return value + 1u; }
        @compute @workgroup_size(1) fn main() {
            var occupied = 2u;
            let readable_result = increment(occupied);
            if (readable_result == 0u) { return; }
        }";
    for requested in ["occupied", "var"] {
        let mut module = naga::front::wgsl::parse_str(source).unwrap();
        let function = &mut module.entry_points[0].function;
        let result = function
            .expressions
            .iter()
            .find_map(|(handle, expression)| {
                matches!(*expression, naga::Expression::CallResult(_)).then_some(handle)
            })
            .unwrap();
        function.named_expressions.insert(result, requested.into());
        let info = Validator::new(ValidationFlags::all(), Capabilities::empty())
            .validate(&module)
            .unwrap();
        let output = naga::back::wgsl::write_string(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        )
        .unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output)
            .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
        Validator::new(ValidationFlags::all(), Capabilities::empty())
            .validate(&reparsed)
            .unwrap();
        let function = &reparsed.entry_points[0].function;
        let name = function
            .named_expressions
            .iter()
            .find_map(|(&handle, name)| {
                matches!(
                    function.expressions[handle],
                    naga::Expression::CallResult(_)
                )
                .then_some(name)
            })
            .unwrap();
        assert_ne!(name, requested, "{output}");
        assert!(name.starts_with(&format!("{requested}_")), "{output}");
        assert!(
            function
                .local_variables
                .iter()
                .all(|(_, variable)| { variable.name.as_deref() != Some(name.as_str()) }),
            "{output}"
        );
    }
}
