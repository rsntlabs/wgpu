use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    module
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_static_assertions_accept_global_and_local_scalar_constants_without_runtime_code() {
    let module = validate(
        "static_assert(true);
        static_assert(3LL, \"wide value\");
        static_assert(0.25f);
        static_assert(-0.5f);
        static_assert(sizeof(float3) == 12, \"packed vector\");
        __global__ void kernel(unsigned *output) {
            static_assert(1u, \"local\");
            static_assert(alignof(int) == 4);
            static_assert((true, true), \"adjacent \" \"message\");
            output[0] = 7u;
        }",
    );
    assert!(module.functions.is_empty());
    let mut stores = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        assert!(!matches!(
            statement,
            naga::Statement::Call { .. } | naga::Statement::If { .. }
        ));
        stores += usize::from(matches!(statement, naga::Statement::Store { .. }));
        false
    });
    assert_eq!(stores, 1);
}

#[test]
fn cuda_static_assertions_use_scoped_aliases_constants_and_requested_template_instances() {
    validate(
        "constexpr unsigned Count = 3u;
        using Element = int;
        static_assert(sizeof(Element) == 4);
        template<class Value, unsigned Width>
        __device__ unsigned checked(Value value) {
            static_assert(sizeof(Value) == 4, \"element width\");
            static_assert(Width == Count, \"template width\");
            return unsigned(value);
        }
        template<class Unused> __device__ void deferred() { static_assert(false); }
        __global__ void kernel(unsigned *output) {
            constexpr unsigned Local = Count + 1u;
            static_assert(Local == 4u);
            { using Element = long; static_assert(sizeof(Element) == 8); }
            static_assert(sizeof(Element) == 4);
            output[0] = checked<unsigned, Count>(7u);
        }",
    );
    let error = rejected(
        "template<class Value> __global__ void kernel(unsigned *output) {
            static_assert(sizeof(Value) == 4, \"element width\"); output[0] = 7u;
        }
        template __global__ void kernel<float3>(unsigned *);",
    );
    assert!(error.message.contains("element width"), "{error}");
}

#[test]
fn cuda_static_assertions_report_false_conditions_even_in_unreachable_source() {
    for condition in ["false", "0", "0ULL", "0.0f", "-0.0f", "sizeof(int) == 8"] {
        let error = rejected(&format!(
            "static_assert({condition}, \"layout \" \"mismatch\"); __global__ void kernel() {{}}"
        ));
        assert!(error.message.contains("static assertion failed"), "{error}");
        assert!(error.message.contains("layout mismatch"), "{error}");
    }
    for body in [
        "return; static_assert(false);",
        "if (false) { static_assert(false); }",
    ] {
        let error = rejected(&format!("__global__ void kernel() {{ {body} }}"));
        assert!(error.message.contains("static assertion failed"), "{error}");
    }
}

#[test]
fn cuda_static_assertions_reject_nonconstant_conditions_and_invalid_messages() {
    for body in [
        "unsigned value = 1u; static_assert(value);",
        "static_assert(output[0]);",
        "static_assert(helper());",
        "unsigned value = 0u; static_assert((value++, true));",
        "static_assert(true, 7);",
        "static_assert(true, helper());",
        "static_assert(true,);",
        "static_assert();",
        "static_assert(true)",
    ] {
        rejected(&format!(
            "__device__ unsigned helper() {{ return 1u; }}
            __global__ void kernel(unsigned *output) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_static_assertions_respect_constant_short_circuit_evaluation() {
    let module = validate(
        "__device__ unsigned helper() { return 1u; }
        static_assert(true || helper());
        static_assert(true ? 1u : helper());
        __global__ void kernel(unsigned *output) {
            static_assert(true || output[0]);
            output[0] = 7u;
        }",
    );
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        assert!(!matches!(
            statement,
            naga::Statement::Call { .. } | naga::Statement::If { .. }
        ));
        false
    });
}
