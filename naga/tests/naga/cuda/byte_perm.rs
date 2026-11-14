use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_byte_perm_accepts_three_unsigned_arguments() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned x, unsigned y, unsigned selector) {
        out[0] = __byte_perm(x, y, selector);
    }",
    );
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_byte_perm_preserves_canonical_prototype_and_unsigned_result() {
    let module = validate(
        "__device__ unsigned __byte_perm(unsigned, unsigned, unsigned);
        __device__ int consume(int x) { return 1; }
        __device__ int consume(unsigned x) { return 2; }
        __global__ void kernel(int *out) { out[0] = consume(__byte_perm(1u, 2u, 3u)); }",
    );
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

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_byte_perm_literal_bytes_and_ignored_bits_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __byte_perm(0x80ff017fu, 0xfe028100u, 0x3210u);
        out[1] = __byte_perm(0x80ff017fu, 0xfe028100u, 0xba98u);
        out[2] = __byte_perm(0x80ff017fu, 0xfe028100u, 0x7654u);
        out[3] = __byte_perm(0x80ff017fu, 0xfe028100u, 0xfffffedcu);
        out[4] = __byte_perm(0x80ff017fu, 0xfe028100u, 0x8888u);
        out[5] = __byte_perm(0xffffffffu, 0u, 0xffffu);
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
fn cuda_byte_perm_converts_all_three_source_scalars_before_selecting_bytes() {
    validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __byte_perm(true, (short)-1, (unsigned short)0x3210);
        out[1] = __byte_perm(-1, 0xffffffffu, -1);
        out[2] = __byte_perm(0x100000001ULL, -1LL, 0x100003210ULL);
        out[3] = __byte_perm(0x1ffffffffUL, 0x100000001ULL, 0x100000000UL);
        out[4] = __byte_perm(3.75f, 2.5f, 1.75f);
    }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_byte_perm_reads_each_volatile_operand_once() {
    let module = validate_with_options_and_capabilities(
        "__global__ void kernel(volatile unsigned *input, unsigned *out) {
        out[0] = __byte_perm(input[0], input[1], input[2]);
    }",
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

#[test]
fn cuda_byte_perm_handles_nested_captured_lazy_and_discarded_calls() {
    validate(
        "__device__ unsigned __byte_perm(bool x, bool y, bool selector) { return 7u; }
        __device__ unsigned next(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *out) {
            unsigned value = 1;
            out[0] = __byte_perm(next(value), next(value), next(value));
            out[1] = __byte_perm(__byte_perm(1u, 2u, value), __byte_perm(2u, 1u, value), value);
            choose ? __byte_perm(value++, value++, value++) : 0u;
            false && __byte_perm(value++, value++, value++);
            true || __byte_perm(value++, value++, value++);
            __byte_perm(value++, value++, value++); out[2] = value;
        }",
    );
}

#[test]
fn cuda_byte_perm_rejects_invalid_calls_definitions_and_constant_contexts() {
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
            "__global__ void kernel(unsigned *out) {{ __byte_perm({arguments}); }}"
        ));
    }
    reject("__device__ int __byte_perm(unsigned, unsigned, unsigned); __global__ void kernel() {}");
    reject("__device__ unsigned __byte_perm(unsigned x, unsigned y, unsigned s) { return x; } __global__ void kernel() {}");
    reject("__global__ void kernel() { constexpr unsigned value = __byte_perm(1u, 2u, 3u); }");
    reject("__global__ void kernel() { unsigned __byte_perm = 0; __byte_perm(1u, 2u, 3u); }");
    reject(&format!(
        "__global__ void kernel() {{ {}1u{}; }}",
        "__byte_perm(1u, 2u, ".repeat(70),
        ")".repeat(70)
    ));
}
