use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

const NAMES: [&str; 8] = [
    "__vcmpges2",
    "__vcmpges4",
    "__vcmpgeu2",
    "__vcmpgeu4",
    "__vsetges2",
    "__vsetges4",
    "__vsetgeu2",
    "__vsetgeu4",
];

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_packed_greater_equal_accepts_signed_unsigned_inclusive_lane_greater_equal() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned a, unsigned b) {
        out[0] = __vcmpges2(a, b); out[1] = __vcmpges4(a, b);
        out[2] = __vcmpgeu2(a, b); out[3] = __vcmpgeu4(a, b);
        out[4] = __vsetges2(a, b); out[5] = __vsetges4(a, b);
        out[6] = __vsetgeu2(a, b); out[7] = __vsetgeu4(a, b);
    }",
    );
}

#[test]
fn cuda_packed_greater_equal_matches_canonical_prototypes_and_returns_unsigned() {
    for name in NAMES {
        let module = validate(&format!(
            "__device__ unsigned {name}(unsigned, unsigned);
            __device__ int consume(int value) {{ return 1; }}
            __device__ int consume(unsigned value) {{ return 2; }}
            __global__ void kernel(int *out) {{ out[0] = consume({name}(1u, 2u)); }}"
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
        let module = validate(&format!("__device__ unsigned {name}(int a, int b) {{ return 7u; }}
            __global__ void kernel(unsigned *out) {{ out[0] = {name}(1, 2); out[1] = {name}(1u, 2u); }}"));
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
fn cuda_packed_greater_equal_inclusive_signed_unsigned_boundary_literals_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __vcmpges2(0x80008000u, 0x7fff7fffu);
        out[1] = __vcmpges4(0x80808080u, 0x7f7f7f7fu);
        out[2] = __vcmpgeu2(0x80008000u, 0x7fff7fffu);
        out[3] = __vcmpgeu4(0x80808080u, 0x7f7f7f7fu);
        out[4] = __vsetges2(0x80008000u, 0x7fff7fffu);
        out[5] = __vsetges4(0x80808080u, 0x7f7f7f7fu);
        out[6] = __vsetgeu2(0x7fff7fffu, 0x80008000u);
        out[7] = __vsetgeu4(0x7f7f7f7fu, 0x80808080u);
        out[8] = __vcmpges2(0xffffffffu, 0u);
        out[9] = __vsetgeu4(0xffffffffu, 0u);
        out[10] = __vcmpgeu2(0x12345678u, 0x1234abcdu);
        out[11] = __vsetges4(0x807f3302u, 0x7f803301u);
        out[12] = __vcmpges2(0x80ff017fu, 0x80ff017fu);
        out[13] = __vsetgeu4(0x80ff017fu, 0x80ff017fu);
        out[14] = __vcmpges4(0xffffffffu, 0xffffffffu);
        out[15] = __vcmpgeu2(0x7fff7fffu, 0x7fff7fffu);
        out[16] = __vsetges2(0x80008000u, 0x80008000u);
        out[17] = __vsetges4(0u, 0u);
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
fn cuda_packed_greater_equal_converts_source_scalars_before_unpacking() {
    for name in NAMES {
        validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(unsigned *out) {{
            out[0] = {name}(true, (short)-1); out[1] = {name}((unsigned short)65535, -1);
            out[2] = {name}(0x100000001ULL, -1LL); out[3] = {name}(0x1ffffffffUL, -1L);
            out[4] = {name}(3.75f, 2.5f);
        }}"
            ),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_packed_greater_equal_reads_each_volatile_operand_once() {
    for name in NAMES {
        let source = format!("__global__ void kernel(volatile unsigned *input, unsigned *out) {{ out[0] = {name}(input[0], input[1]); }}");
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
            2
        );
    }
}

#[test]
fn cuda_packed_greater_equal_preserves_nested_captured_lazy_and_discarded_effects() {
    for name in NAMES {
        validate(&format!(
            "__device__ unsigned {name}(bool a, bool b) {{ return 7u; }}
            __device__ unsigned next(unsigned &value) {{ return value++; }}
            __global__ void kernel(unsigned choose, unsigned *out) {{
                unsigned value = 1;
                out[0] = {name}(next(value), next(value));
                out[1] = {name}({name}(1u, value), {name}(value, 2u));
                choose ? {name}(value++, value++) : 0u;
                false && {name}(value++, value++); true || {name}(value++, value++);
                {name}(value++, value++); out[2] = value;
            }}"
        ));
    }
}

#[test]
fn cuda_packed_greater_equal_rejects_invalid_calls_definitions_and_constant_contexts() {
    for name in NAMES {
        for arguments in ["", "1u", "1u, 2u, 3u", "out, 1u", "make_uint2(1u, 2u), 1u"] {
            reject(&format!(
                "__global__ void kernel(unsigned *out) {{ {name}({arguments}); }}"
            ));
        }
        reject(&format!(
            "__device__ int {name}(unsigned, unsigned); __global__ void kernel() {{}}"
        ));
        reject(&format!("__device__ unsigned {name}(unsigned a, unsigned b) {{ return a; }} __global__ void kernel() {{}}"));
        reject(&format!(
            "__global__ void kernel() {{ constexpr unsigned value = {name}(1u, 2u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ unsigned {name} = 0; {name}(1u, 2u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ {}1u{}; }}",
            format!("{name}(1u, ").repeat(70),
            ")".repeat(70)
        ));
    }
}
