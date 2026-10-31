#![cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]

use naga::back::wgsl::WriterFlags;
use naga::valid::{Capabilities, ValidationFlags, Validator};

fn atomic_count(function: &naga::Function) -> usize {
    let mut count = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        count += usize::from(matches!(*statement, naga::Statement::Atomic { .. }));
        false
    });
    count
}

fn assert_named_atomic_result(
    function: &naga::Function,
    name: &str,
    comparison: bool,
    output: &str,
) {
    assert!(
        function.named_expressions.iter().any(|(&handle, actual)| {
            actual == name
                && matches!(function.expressions[handle], naga::Expression::AtomicResult {
                comparison: actual_comparison, ..
            } if actual_comparison == comparison)
        }),
        "named atomic result {name} missing\n{output}"
    );
}

#[test]
fn wgsl_writer_preserves_signed_and_unsigned_named_atomic_results() {
    let source = "@group(0) @binding(0) var<storage, read_write> signed_counter: atomic<i32>;
        @group(0) @binding(1) var<storage, read_write> unsigned_counter: atomic<u32>;
        @group(0) @binding(2) var<storage, read_write> output: array<u32>;
        @compute @workgroup_size(1) fn main() {
            let signed_add = atomicAdd(&signed_counter, 1i);
            let unsigned_add = atomicAdd(&unsigned_counter, 1u);
            let signed_exchange = atomicExchange(&signed_counter, 3i);
            let unsigned_exchange = atomicExchange(&unsigned_counter, 3u);
            let signed_compare = atomicCompareExchangeWeak(&signed_counter, 3i, 5i);
            let unsigned_compare = atomicCompareExchangeWeak(&unsigned_counter, 3u, 5u);
            output[0] = u32(signed_add);
            output[1] = unsigned_add;
            output[2] = u32(signed_exchange);
            output[3] = unsigned_exchange;
            output[4] = u32(signed_compare.old_value);
            output[5] = unsigned_compare.old_value;
            output[6] = select(0u, 1u, signed_compare.exchanged);
            output[7] = select(0u, 1u, unsigned_compare.exchanged);
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = Validator::new(ValidationFlags::all(), Capabilities::empty())
        .validate(&module)
        .unwrap();
    let names = [
        ("signed_add", false),
        ("unsigned_add", false),
        ("signed_exchange", false),
        ("unsigned_exchange", false),
        ("signed_compare", true),
        ("unsigned_compare", true),
    ];
    assert_eq!(atomic_count(&module.entry_points[0].function), 6);
    for &(name, comparison) in &names {
        assert_named_atomic_result(&module.entry_points[0].function, name, comparison, source);
    }
    for flags in [WriterFlags::empty(), WriterFlags::EXPLICIT_TYPES] {
        let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output)
            .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
        Validator::new(ValidationFlags::all(), Capabilities::empty())
            .validate(&reparsed)
            .unwrap();
        let function = &reparsed.entry_points[0].function;
        assert_eq!(atomic_count(function), 6, "{output}");
        for &(name, comparison) in &names {
            assert_named_atomic_result(function, name, comparison, &output);
        }
    }
}

#[test]
fn wgsl_writer_sanitizes_named_atomic_results_and_avoids_existing_local_names() {
    let source = "@group(0) @binding(0) var<storage, read_write> counter: atomic<u32>;
        @group(0) @binding(1) var<storage, read_write> output: array<u32>;
        @compute @workgroup_size(1) fn main() {
            var occupied = 2u;
            let readable_result = atomicExchange(&counter, occupied);
            output[0] = readable_result;
            output[1] = occupied;
        }";
    for requested in ["occupied", "var"] {
        let mut module = naga::front::wgsl::parse_str(source).unwrap();
        let function = &mut module.entry_points[0].function;
        let result = function
            .expressions
            .iter()
            .find_map(|(handle, expression)| {
                matches!(*expression, naga::Expression::AtomicResult { .. }).then_some(handle)
            })
            .unwrap();
        function.named_expressions.insert(result, requested.into());
        let info = Validator::new(ValidationFlags::all(), Capabilities::empty())
            .validate(&module)
            .unwrap();
        for flags in [WriterFlags::empty(), WriterFlags::EXPLICIT_TYPES] {
            let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
            let reparsed = naga::front::wgsl::parse_str(&output)
                .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
            Validator::new(ValidationFlags::all(), Capabilities::empty())
                .validate(&reparsed)
                .unwrap();
            let function = &reparsed.entry_points[0].function;
            assert_eq!(atomic_count(function), 1, "{output}");
            let name = function
                .named_expressions
                .iter()
                .find_map(|(&handle, name)| {
                    matches!(
                        function.expressions[handle],
                        naga::Expression::AtomicResult { .. }
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
                    .all(|(_, local)| { local.name.as_deref() != Some(name.as_str()) }),
                "{output}"
            );
        }
    }
}
