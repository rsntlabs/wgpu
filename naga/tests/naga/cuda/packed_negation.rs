use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

const NAMES: [&str; 4] = ["__vneg2", "__vneg4", "__vnegss2", "__vnegss4"];

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
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
fn cuda_packed_negation_accepts_unsigned_arguments_and_results() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned value) {
        out[0] = __vneg2(value); out[1] = __vneg4(value);
        out[2] = __vnegss2(value); out[3] = __vnegss4(value);
    }",
    );
}

#[test]
fn cuda_packed_negation_matches_canonical_prototypes_and_unsigned_result_overloads() {
    for name in NAMES {
        let module = validate(&format!(
            "__device__ unsigned {name}(unsigned);
            __device__ int consume(int value) {{ return 1; }}
            __device__ int consume(unsigned value) {{ return 2; }}
            __global__ void kernel(int *out) {{ out[0] = consume({name}(1u)); }}"
        ));
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                assert_eq!(
                    module.types[module.functions[*function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
                calls += 1;
            }
            false
        });
        assert_eq!(calls, 1);
        let module = validate(&format!("__device__ unsigned {name}(int value) {{ return 7u; }}
            __global__ void kernel(unsigned *out) {{ out[0] = {name}(-1); out[1] = {name}(0xffffffffu); }}"));
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                assert_eq!(
                    module.types[module.functions[*function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                calls += 1;
            }
            false
        });
        assert_eq!(calls, 1);
    }
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_packed_negation_literal_minima_and_extrema_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __vneg2(0x80008000u); out[1] = __vnegss2(0x80008000u);
        out[2] = __vneg4(0x80808080u); out[3] = __vnegss4(0x80808080u);
        out[4] = __vneg2(0x7fff8001u); out[5] = __vnegss2(0x7fff8001u);
        out[6] = __vneg4(0x7f80ff01u); out[7] = __vnegss4(0x7f80ff01u);
        out[8] = __vneg2(0u); out[9] = __vneg4(0xffffffffu);
        out[10] = __vneg2(__vneg2(0x80008000u));
        out[11] = __vneg4(__vneg4(0x80808080u));
        out[12] = __vnegss2(__vnegss2(0x80008000u));
        out[13] = __vnegss4(__vnegss4(0x80808080u));
        out[14] = __vneg2(0x0001ffffu); out[15] = __vnegss4(0x00017fffu);
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
fn cuda_packed_negation_converts_source_scalars_before_decoding_lanes() {
    for name in NAMES {
        validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(unsigned *out) {{
            out[0] = {name}(true); out[1] = {name}((short)-1);
            out[2] = {name}((unsigned short)65535); out[3] = {name}(-1);
            out[4] = {name}(0x100000001ULL); out[5] = {name}(-1LL);
            out[6] = {name}(0x1ffffffffUL); out[7] = {name}(-1L); out[8] = {name}(3.75f);
        }}"
            ),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_packed_negation_reads_each_volatile_argument_once() {
    for name in NAMES {
        let source = format!("__global__ void kernel(volatile unsigned *input, unsigned *out) {{ out[0] = {name}(input[0]); }}");
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
                .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
                .count(),
            1
        );
    }
}

#[test]
fn cuda_packed_negation_preserves_nested_captured_lazy_and_discarded_effects() {
    for name in NAMES {
        validate(&format!(
            "__device__ unsigned {name}(bool value) {{ return 7u; }}
            __device__ unsigned next(unsigned &value) {{ return value++; }}
            __global__ void kernel(unsigned choose, unsigned *out) {{
                unsigned value = 1;
                out[0] = {name}(next(value)); out[1] = {name}({name}({name}(value++)));
                choose ? {name}(value++) : 0u;
                false && {name}(value++); true || {name}(value++);
                {name}(value++); out[2] = value;
            }}"
        ));
    }
}

#[test]
fn cuda_packed_negation_rejects_invalid_calls_definitions_and_constant_contexts() {
    for name in NAMES {
        for arguments in ["", "1u, 2u", "out", "make_uint2(1u, 2u)"] {
            reject(&format!(
                "__global__ void kernel(unsigned *out) {{ {name}({arguments}); }}"
            ));
        }
        reject(&format!(
            "__device__ int {name}(unsigned); __global__ void kernel() {{}}"
        ));
        reject(&format!("__device__ unsigned {name}(unsigned value) {{ return value; }} __global__ void kernel() {{}}"));
        reject(&format!(
            "__global__ void kernel() {{ constexpr unsigned value = {name}(1u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ unsigned {name} = 0; {name}(1u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ {}1u{}; }}",
            format!("{name}(").repeat(70),
            ")".repeat(70)
        ));
    }
}
