use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_dp4a_accepts_signed_and_unsigned_packed_scalar_overloads() {
    validate(
        "__global__ void kernel(unsigned *out, int a, int b, int accumulator) {
        out[0] = unsigned(__dp4a(a, b, accumulator));
        out[1] = __dp4a(unsigned(a), unsigned(b), unsigned(accumulator));
    }",
    );
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_dp4a_preserves_canonical_prototypes_result_types_and_packed_ir() {
    for (ty, literal, scalar, operation) in [
        (
            "int",
            "1",
            naga::Scalar::I32,
            naga::MathFunction::Dot4I8Packed,
        ),
        (
            "unsigned",
            "1u",
            naga::Scalar::U32,
            naga::MathFunction::Dot4U8Packed,
        ),
    ] {
        let module = validate(&format!("__device__ int __dp4a(int, int, int);
            __device__ unsigned __dp4a(unsigned, unsigned, unsigned);
            __device__ int consume(int x) {{ return 1; }}
            __device__ int consume(unsigned x) {{ return 2; }}
            __global__ void kernel(int *out) {{ {ty} value = {literal}; out[0] = consume(__dp4a(value, value, value)); }}"));
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                assert_eq!(
                    module.types[module.functions[*function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(scalar)
                );
                calls += 1;
            }
            false
        });
        assert_eq!(calls, 1);
        assert_eq!(module.entry_points[0].function.expressions.iter().filter(|(_, expr)| matches!(expr, naga::Expression::Math { fun, .. } if *fun == operation)).count(), 1);
    }
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_dp4a_literal_maximum_dots_and_wrapping_accumulators_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __dp4a(0xffffffffu, 0xffffffffu, 0xffffffffu);
        out[1] = unsigned(__dp4a(int(0x80808080u), int(0x80808080u), 2147483647));
        out[2] = unsigned(__dp4a(int(0x80808080u), int(0x7f7f7f7fu), -2147483647 - 1));
        out[3] = __dp4a(0x01010101u, 0x01010101u, 0xffffu);
        out[4] = unsigned(__dp4a(-1, -1, -1));
        out[5] = __dp4a(0u, 0u, 0xffffffffu);
    }",
        &Options::default(),
        Capabilities::empty(),
    );
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
    )));
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_dp4a_converts_source_values_before_unpacking_and_accumulating() {
    validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = unsigned(__dp4a(1, 2, true)); out[1] = __dp4a(1u, 2u, unsigned(true));
        out[2] = unsigned(__dp4a((short)-1, (unsigned short)65535, 0));
        out[3] = __dp4a(1u, 2u, 0x100000001ULL);
        out[4] = unsigned(__dp4a(1, 2, -1LL));
        out[5] = __dp4a(1u, 2u, 0x100000001UL);
        out[6] = unsigned(__dp4a(1, 2, 3.75f)); out[7] = __dp4a(1u, 2u, 3.75f);
        out[8] = unsigned(__dp4a(0x100000001ULL, 1, 2));
        out[9] = __dp4a(-1L, 1u, 2u);
    }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_dp4a_reads_each_volatile_argument_once() {
    for ty in ["int", "unsigned"] {
        let source = format!("__global__ void kernel(volatile {ty} *input, {ty} *out) {{ out[0] = __dp4a(input[0], input[1], input[2]); }}");
        let module = validate_with_options_and_capabilities(
            &source,
            &Options::default(),
            Capabilities::MEMORY_DECORATION_VOLATILE,
        )
        .0;
        assert_eq!(
            module.entry_points[0]
                .function
                .expressions
                .iter()
                .filter(|(_, expr)| matches!(expr, naga::Expression::Load { .. }))
                .count(),
            3
        );
    }
}

#[test]
fn cuda_dp4a_handles_user_overloads_nested_captured_lazy_and_discarded_calls() {
    validate(
        "__device__ unsigned __dp4a(bool a, bool b, bool c) { return 7u; }
        __device__ float __dp4a(float a, float b, float c) { return a + b + c; }
        __device__ unsigned next(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *out) {
            unsigned value = 1;
            out[0] = __dp4a(next(value), next(value), next(value));
            out[1] = unsigned(__dp4a(int(next(value)), int(next(value)), int(next(value))));
            out[2] = __dp4a(__dp4a(1u, 2u, value), __dp4a(2u, 1u, value), value);
            out[3] = __dp4a(true, true, true);
            out[4] = unsigned(__dp4a(1.0f, 2.0f, 3.0f));
            choose ? __dp4a(value++, value++, value++) : 0u;
            false && __dp4a(value++, value++, value++);
            true || __dp4a(value++, value++, value++);
            __dp4a(value++, value++, value++); out[5] = value;
        }",
    );
}

#[test]
fn cuda_dp4a_rejects_ambiguity_invalid_calls_definitions_and_constant_contexts() {
    for arguments in [
        "",
        "1",
        "1, 2",
        "1, 2, 3, 4",
        "out, 1, 2",
        "1, 2, out",
        "make_uint4(1u, 2u, 3u, 4u), 1u, 2u",
        "1, 2, 3u",
        "1u, 2u, 3",
        "1u, 2u, true",
    ] {
        reject(&format!(
            "__global__ void kernel(unsigned *out) {{ __dp4a({arguments}); }}"
        ));
    }
    for (ty, wrong) in [("int", "unsigned"), ("unsigned", "int")] {
        reject(&format!(
            "__device__ {wrong} __dp4a({ty}, {ty}, {ty}); __global__ void kernel() {{}}"
        ));
        reject(&format!("__device__ {ty} __dp4a({ty} a, {ty} b, {ty} c) {{ return a; }} __global__ void kernel() {{}}"));
    }
    reject("__global__ void kernel() { constexpr int value = __dp4a(1, 2, 3); }");
    reject("__global__ void kernel() { unsigned __dp4a = 0; __dp4a(1u, 2u, 3u); }");
    reject(&format!(
        "__global__ void kernel() {{ {}1u{}; }}",
        "__dp4a(1u, 2u, ".repeat(70),
        ")".repeat(70)
    ));
}
