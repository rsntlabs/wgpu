use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_sad_accepts_signed_and_unsigned_difference_with_unsigned_accumulator() {
    validate(
        "__global__ void kernel(unsigned *out, int a, int b, unsigned accumulator) {
        out[0] = __sad(a, b, accumulator);
        out[1] = __usad(unsigned(a), unsigned(b), accumulator);
    }",
    );
}

const BUILTINS: [(&str, &str); 2] = [("__sad", "int"), ("__usad", "unsigned")];

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_sad_matches_mixed_canonical_prototypes_and_returns_unsigned() {
    for (name, ty) in BUILTINS {
        let module = validate(&format!(
            "__device__ unsigned {name}({ty}, {ty}, unsigned);
            __device__ int consume(int value) {{ return 1; }}
            __device__ int consume(unsigned value) {{ return 2; }}
            __global__ void kernel(int *out) {{ out[0] = consume({name}(1, 2, 3u)); }}"
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
    }
    let module = validate(
        "__device__ unsigned __sad(int a, int b, int accumulator) { return 7u; }
        __global__ void kernel(unsigned *out) {
            out[0] = __sad(1, 2, 3); out[1] = __sad(1, 2, 3u);
        }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            assert_eq!(
                module.types[module.functions[*function].arguments[2].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::I32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_sad_literal_difference_and_accumulator_boundaries_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __sad(-2147483647 - 1, 2147483647, 1u);
        out[1] = __sad(-1, 0, 0xffffffffu);
        out[2] = __usad(0u, 0xffffffffu, 0xffffffffu);
        out[3] = __usad(0xffffu, 0u, 1u);
        out[4] = __sad(2147483647, -2147483647 - 1, 0u);
        out[5] = __usad(0u, 0u, 0xffffffffu);
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
fn cuda_sad_converts_all_three_source_scalars_before_computing() {
    for (name, _) in BUILTINS {
        validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(unsigned *out) {{
            out[0] = {name}(true, (short)-1, (unsigned short)65535);
            out[1] = {name}(-1, 0xffffffffu, -1);
            out[2] = {name}(0x100000001ULL, -1LL, 0x100000000ULL);
            out[3] = {name}(0x1ffffffffUL, 0x100000001ULL, 0x100000001UL);
            out[4] = {name}(3.75f, 2.5f, 1.75f);
        }}"
            ),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_sad_reads_each_volatile_operand_once() {
    for (name, ty) in BUILTINS {
        let source = format!("__global__ void kernel(volatile {ty} *input, volatile unsigned *accumulator, unsigned *out) {{ out[0] = {name}(input[0], input[1], accumulator[0]); }}");
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
fn cuda_sad_handles_nested_captured_lazy_and_discarded_calls() {
    for (name, ty) in BUILTINS {
        validate(&format!(
            "__device__ unsigned {name}(bool a, bool b, bool c) {{ return 7u; }}
            __device__ unsigned next(unsigned &value) {{ return value++; }}
            __global__ void kernel(unsigned choose, unsigned *out) {{
                unsigned value = 1;
                out[0] = {name}({ty}(next(value)), {ty}(next(value)), next(value));
                out[1] = {name}({ty}({name}(1, 2, value)), {ty}({name}(2, 1, value)), value);
                choose ? {name}({ty}(value++), {ty}(value++), value++) : 0u;
                false && {name}({ty}(value++), {ty}(value++), value++);
                true || {name}({ty}(value++), {ty}(value++), value++);
                {name}({ty}(value++), {ty}(value++), value++); out[2] = value;
            }}"
        ));
    }
}

#[test]
fn cuda_sad_rejects_invalid_calls_definitions_and_constant_contexts() {
    for (name, ty) in BUILTINS {
        for arguments in [
            "",
            "1",
            "1, 2",
            "1, 2, 3, 4",
            "out, 1, 2",
            "1, 2, out",
            "make_uint2(1u, 2u), 1, 2",
        ] {
            reject(&format!(
                "__global__ void kernel(unsigned *out) {{ {name}({arguments}); }}"
            ));
        }
        reject(&format!(
            "__device__ int {name}({ty}, {ty}, unsigned); __global__ void kernel() {{}}"
        ));
        reject(&format!("__device__ unsigned {name}({ty} a, {ty} b, unsigned c) {{ return c; }} __global__ void kernel() {{}}"));
        reject(&format!(
            "__global__ void kernel() {{ constexpr unsigned value = {name}(1, 2, 3u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ unsigned {name} = 0; {name}(1, 2, 3u); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ {}1u{}; }}",
            format!("{name}(1, 2, ").repeat(70),
            ")".repeat(70)
        ));
    }
}
