use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_half_add_accepts_signed_and_unsigned_intrinsics() {
    validate(
        "__global__ void kernel(int *signed_out, unsigned *unsigned_out, int a, int b) {
        signed_out[0] = __hadd(a, b); signed_out[1] = __rhadd(a, b);
        unsigned_out[0] = __uhadd(unsigned(a), unsigned(b));
        unsigned_out[1] = __urhadd(unsigned(a), unsigned(b));
    }",
    );
}

const BUILTINS: [(&str, &str, naga::Scalar); 4] = [
    ("__hadd", "int", naga::Scalar::I32),
    ("__rhadd", "int", naga::Scalar::I32),
    ("__uhadd", "unsigned", naga::Scalar::U32),
    ("__urhadd", "unsigned", naga::Scalar::U32),
];

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_half_add_preserves_canonical_prototypes_and_exact_result_types() {
    for (name, ty, scalar) in BUILTINS {
        let module = validate(&format!(
            "__device__ {ty} {name}({ty}, {ty});
            __device__ int consume(int x) {{ return 1; }}
            __device__ int consume(unsigned x) {{ return 2; }}
            __global__ void kernel(int *out) {{ out[0] = consume({name}(1, 2)); }}"
        ));
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

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_half_add_literal_boundaries_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = unsigned(__hadd(-2147483647 - 1, -2147483647 - 1));
        out[1] = unsigned(__rhadd(2147483647, 2147483647));
        out[2] = __uhadd(0xffffffffu, 0xffffffffu);
        out[3] = __urhadd(0xffffffffu, 0xffffffffu);
        out[4] = unsigned(__hadd(-1, 0)); out[5] = unsigned(__rhadd(-1, 0));
        out[6] = unsigned(__hadd(-2147483647 - 1, 2147483647));
        out[7] = unsigned(__rhadd(-2147483647 - 1, 2147483647));
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
fn cuda_half_add_converts_source_scalars_before_averaging() {
    for (name, _, _) in BUILTINS {
        validate_with_options_and_capabilities(
            &format!(
                "__global__ void kernel(unsigned *out) {{
            out[0] = unsigned({name}(true, (short)-1));
            out[1] = unsigned({name}((unsigned short)65535, -1));
            out[2] = unsigned({name}(0x100000001ULL, -1LL));
            out[3] = unsigned({name}(0x1ffffffffUL, 0x100000001ULL));
            out[4] = unsigned({name}(3.75f, 2.5f));
        }}"
            ),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_half_add_reads_each_volatile_operand_once() {
    for (name, ty, _) in BUILTINS {
        let source = format!("__global__ void kernel(volatile {ty} *input, {ty} *out) {{ out[0] = {name}(input[0], input[1]); }}");
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
            2
        );
    }
}

#[test]
fn cuda_half_add_handles_nested_captured_lazy_and_discarded_calls() {
    for (name, ty, _) in BUILTINS {
        validate(&format!(
            "__device__ {ty} {name}(bool a, bool b) {{ return 7; }}
            __device__ {ty} next({ty} &value) {{ return value++; }}
            __global__ void kernel(unsigned choose, {ty} *out) {{
                {ty} value = 1;
                out[0] = {name}(next(value), next(value));
                out[1] = {name}({name}(value, 1), {name}(2, value));
                choose ? {name}(value++, value++) : 0;
                false && {name}(value++, value++);
                true || {name}(value++, value++);
                {name}(value++, value++); out[2] = value;
            }}"
        ));
    }
}

#[test]
fn cuda_half_add_rejects_invalid_calls_definitions_and_constant_contexts() {
    for (name, ty, scalar) in BUILTINS {
        let wrong = if scalar == naga::Scalar::I32 {
            "unsigned"
        } else {
            "int"
        };
        for arguments in ["", "1", "1, 2, 3", "out, 1", "make_uint2(1u, 2u), 1"] {
            reject(&format!(
                "__global__ void kernel(unsigned *out) {{ {name}({arguments}); }}"
            ));
        }
        reject(&format!(
            "__device__ {wrong} {name}({ty}, {ty}); __global__ void kernel() {{}}"
        ));
        reject(&format!(
            "__device__ {ty} {name}({ty} a, {ty} b) {{ return a; }} __global__ void kernel() {{}}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ constexpr {ty} value = {name}(1, 2); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ unsigned {name} = 0; {name}(1, 2); }}"
        ));
        reject(&format!(
            "__global__ void kernel() {{ {}1{}; }}",
            format!("{name}(1, ").repeat(70),
            ")".repeat(70)
        ));
    }
}
