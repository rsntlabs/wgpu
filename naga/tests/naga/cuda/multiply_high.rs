use super::helpers::validate_with_options_and_capabilities;
use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_multiply_high_accepts_signed_and_unsigned_arguments() {
    validate(
        "__global__ void kernel(int *signed_output, unsigned *unsigned_output, int a, int b) {
        signed_output[0] = __mulhi(a, b);
        unsigned_output[0] = __umulhi(unsigned(a), unsigned(b));
    }",
    );
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_multiply_high_preserves_exact_result_types_and_canonical_prototypes() {
    let module = validate(
        "__device__ int __mulhi(int, int);
        __device__ unsigned __umulhi(unsigned, unsigned);
        __device__ int signed_result(int value) { return value; }
        __device__ int signed_result(unsigned value) { return 99; }
        __device__ unsigned unsigned_result(unsigned value) { return value; }
        __device__ unsigned unsigned_result(int value) { return 99u; }
        __global__ void kernel(unsigned *out) {
            out[0] = unsigned(signed_result(__mulhi(-1, 1)));
            out[1] = unsigned_result(__umulhi(0xffffffffu, 0xffffffffu));
        }",
    );
    let mut actual = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            actual.push(
                module.types[module.functions[*function].arguments[0].ty]
                    .inner
                    .clone(),
            );
        }
        false
    });
    assert_eq!(
        actual,
        [
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::U32)
        ]
    );
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_multiply_high_literal_overflow_boundaries_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = unsigned(__mulhi(-1, 1));
        out[1] = unsigned(__mulhi(-2147483647 - 1, -2147483647 - 1));
        out[2] = __umulhi(0xffffffffu, 0xffffffffu);
        out[3] = unsigned(__mulhi(-2147483647 - 1, 2147483647));
        out[4] = unsigned(__mulhi(-1, -1));
        out[5] = unsigned(__mulhi(-1, 2147418113));
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
fn cuda_multiply_high_converts_source_scalars_before_multiplication() {
    validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = unsigned(__mulhi(true, (short)-1));
        out[1] = __umulhi((unsigned short)65535, -1);
        out[2] = unsigned(__mulhi(0x100000001ULL, -1LL));
        out[3] = __umulhi(0x1ffffffffUL, 0x100000001ULL);
        out[4] = unsigned(__mulhi(3.75f, -2.5f));
        out[5] = __umulhi(3.75f, 2.5f);
    }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_multiply_high_reads_two_volatile_arguments_once() {
    for (name, ty) in [("__mulhi", "int"), ("__umulhi", "unsigned")] {
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
fn cuda_multiply_high_handles_captured_overloads_lazy_and_discarded_effects() {
    validate(
        "__device__ int __mulhi(bool a, bool b) { return 7; }
        __device__ unsigned __umulhi(bool a, bool b) { return 7u; }
        __device__ unsigned next(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *out) {
            unsigned value = 1;
            out[0] = __umulhi(next(value), next(value));
            out[1] = unsigned(__mulhi(int(next(value)), int(next(value))));
            choose ? __umulhi(value++, value++) : 0u;
            false && __mulhi(int(value++), int(value++));
            true || __umulhi(value++, value++);
            __mulhi(int(value++), int(value++));
            out[2] = value;
        }",
    );
}

#[test]
fn cuda_multiply_high_rejects_invalid_calls_definitions_and_constant_contexts() {
    for (name, ty, wrong) in [
        ("__mulhi", "int", "unsigned"),
        ("__umulhi", "unsigned", "int"),
    ] {
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

#[test]
fn cuda_multiply_high_nested_calls_preserve_supported_depth() {
    validate("__global__ void kernel(int *signed_out, unsigned *unsigned_out, int a, int b) {
        signed_out[0] = __mulhi(__mulhi(a, b), __mulhi(b, a));
        unsigned_out[0] = __umulhi(__umulhi(__umulhi(unsigned(a), unsigned(b)), 0xffffffffu), 0x80000000u);
    }");
}
