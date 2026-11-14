use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_dp2a_accepts_signed_unsigned_low_and_high_packed_scalar_overloads() {
    validate(
        "__global__ void kernel(unsigned *out, int a, int b, int accumulator) {
        out[0] = unsigned(__dp2a_lo(a, b, accumulator));
        out[1] = unsigned(__dp2a_hi(a, b, accumulator));
        out[2] = __dp2a_lo(unsigned(a), unsigned(b), unsigned(accumulator));
        out[3] = __dp2a_hi(unsigned(a), unsigned(b), unsigned(accumulator));
    }",
    );
}

const NAMES: [&str; 2] = ["__dp2a_lo", "__dp2a_hi"];

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_dp2a_preserves_canonical_prototypes_and_exact_result_types() {
    for name in NAMES {
        for (ty, literal, scalar) in [
            ("int", "1", naga::Scalar::I32),
            ("unsigned", "1u", naga::Scalar::U32),
        ] {
            let module = validate(&format!("__device__ int {name}(int, int, int);
                __device__ unsigned {name}(unsigned, unsigned, unsigned);
                __device__ int consume(int x) {{ return 1; }}
                __device__ int consume(unsigned x) {{ return 2; }}
                __global__ void kernel(int *out) {{ {ty} value = {literal}; out[0] = consume({name}(value, value, value)); }}"));
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
        }
    }
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_dp2a_literal_extreme_lanes_and_wrapping_accumulators_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __dp2a_lo(0xffffffffu, 0xffffffffu, 0xffffffffu);
        out[1] = __dp2a_hi(0xffffffffu, 0xffffffffu, 0xffffffffu);
        out[2] = unsigned(__dp2a_lo(int(0x80008000u), int(0x80808080u), 2147483647));
        out[3] = unsigned(__dp2a_hi(int(0x80008000u), int(0x7f7f7f7fu), -2147483647 - 1));
        out[4] = unsigned(__dp2a_lo(int(0x7fff7fffu), int(0x7f7f7f7fu), 2147483647));
        out[5] = unsigned(__dp2a_hi(int(0x7fff8000u), int(0x807f01ffu), -1));
        out[6] = __dp2a_lo(0x00010001u, 0x01010101u, 0xffffu);
        out[7] = __dp2a_hi(0x00010001u, 0x01010101u, 0xffffu);
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
fn cuda_dp2a_converts_values_before_unpacking_and_accumulating() {
    for name in NAMES {
        validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(unsigned *out) {{
            out[0] = unsigned({name}(1, 2, true)); out[1] = {name}(1u, 2u, unsigned(true));
            out[2] = unsigned({name}((short)-1, (unsigned short)65535, 0));
            out[3] = {name}(1u, 2u, 0x100000001ULL);
            out[4] = unsigned({name}(1, 2, -1LL));
            out[5] = {name}(1u, 2u, 0x100000001UL);
            out[6] = unsigned({name}(1, 2, 3.75f)); out[7] = {name}(1u, 2u, 3.75f);
            out[8] = unsigned({name}(0x100000001ULL, 1, 2));
            out[9] = {name}(-1L, 1u, 2u);
        }}"
            ),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_dp2a_reads_each_volatile_argument_once() {
    for name in NAMES {
        for ty in ["int", "unsigned"] {
            let source = format!("__global__ void kernel(volatile {ty} *input, {ty} *out) {{ out[0] = {name}(input[0], input[1], input[2]); }}");
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
}

#[test]
fn cuda_dp2a_handles_user_overloads_nested_captured_lazy_and_discarded_calls() {
    for name in NAMES {
        validate(&format!(
            "__device__ unsigned {name}(bool a, bool b, bool c) {{ return 7u; }}
            __device__ float {name}(float a, float b, float c) {{ return a + b + c; }}
            __device__ unsigned next(unsigned &value) {{ return value++; }}
            __global__ void kernel(unsigned choose, unsigned *out) {{
                unsigned value = 1;
                out[0] = {name}(next(value), next(value), next(value));
                out[1] = unsigned({name}(int(next(value)), int(next(value)), int(next(value))));
                out[2] = {name}({name}(1u, 2u, value), {name}(2u, 1u, value), value);
                out[3] = {name}(true, true, true); out[4] = unsigned({name}(1.0f, 2.0f, 3.0f));
                choose ? {name}(value++, value++, value++) : 0u;
                false && {name}(value++, value++, value++);
                true || {name}(value++, value++, value++);
                {name}(value++, value++, value++); out[5] = value;
            }}"
        ));
    }
}

#[test]
fn cuda_dp2a_rejects_ambiguity_invalid_calls_definitions_and_constant_contexts() {
    for name in NAMES {
        for arguments in [
            "",
            "1",
            "1, 2",
            "1, 2, 3, 4",
            "out, 1, 2",
            "1, 2, out",
            "make_short2(1, 2), 1, 2",
            "1, 2, 3u",
            "1u, 2u, 3",
            "1u, 2u, true",
        ] {
            reject(&format!(
                "__global__ void kernel(unsigned *out) {{ {name}({arguments}); }}"
            ));
        }
        for (ty, wrong) in [("int", "unsigned"), ("unsigned", "int")] {
            reject(&format!(
                "__device__ {wrong} {name}({ty}, {ty}, {ty}); __global__ void kernel() {{}}"
            ));
            reject(&format!("__device__ {ty} {name}({ty} a, {ty} b, {ty} c) {{ return a; }} __global__ void kernel() {{}}"));
        }
        reject(&format!(
            "__global__ void kernel() {{ constexpr int value = {name}(1, 2, 3); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ unsigned {name} = 0; {name}(1u, 2u, 3u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ {}1u{}; }}",
            format!("{name}(1u, 2u, ").repeat(70),
            ")".repeat(70)
        ));
    }
}

#[test]
fn cuda_dp2a_extracts_typed_halfwords_and_selected_bytes() {
    for (name, byte_offset) in [("__dp2a_lo", 0), ("__dp2a_hi", 16)] {
        for (ty, scalar) in [("int", naga::Scalar::I32), ("unsigned", naga::Scalar::U32)] {
            let source = format!("__global__ void kernel({ty} *out, {ty} a, {ty} b, {ty} c) {{ out[0] = {name}(a, b, c); }}");
            let (module, info) = validate_with_options_and_capabilities(
                &source,
                &Options::default(),
                Capabilities::empty(),
            );
            let function = &module.entry_points[0].function;
            let mut extracts = Vec::new();
            for (handle, expression) in function.expressions.iter() {
                if let naga::Expression::Math {
                    fun: naga::MathFunction::ExtractBits,
                    arg,
                    arg1: Some(offset),
                    arg2: Some(count),
                    ..
                } = *expression
                {
                    assert_eq!(
                        info.get_entry_point(0)[arg].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(scalar)
                    );
                    assert_eq!(
                        info.get_entry_point(0)[handle].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(scalar)
                    );
                    let naga::Expression::Literal(naga::Literal::U32(offset)) =
                        function.expressions[offset]
                    else {
                        panic!("nonliteral offset");
                    };
                    let naga::Expression::Literal(naga::Literal::U32(count)) =
                        function.expressions[count]
                    else {
                        panic!("nonliteral count");
                    };
                    extracts.push((offset, count));
                }
            }
            extracts.sort_unstable();
            let mut expected = [(0, 16), (16, 16), (byte_offset, 8), (byte_offset + 8, 8)];
            expected.sort_unstable();
            assert_eq!(extracts, expected);
        }
    }
}
