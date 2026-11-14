use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_byte_swap32_accepts_unsigned_scalar() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned value) { out[0] = __nv_bswap32(value); }",
    );
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_byte_swap32_accepts_host_device_prototype_and_returns_unsigned() {
    let module = validate(
        "__host__ __device__ unsigned __nv_bswap32(unsigned);
        __device__ int consume(int value) { return 1; }
        __device__ int consume(unsigned value) { return 2; }
        __global__ void kernel(int *out) { out[0] = consume(__nv_bswap32(1u)); }",
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

#[test]
fn cuda_byte_swap32_coexists_with_signed_parameter_user_overload() {
    let module = validate(
        "__device__ unsigned __nv_bswap32(int value) { return 7u; }
        __global__ void kernel(unsigned *out) {
            out[0] = __nv_bswap32(-1); out[1] = __nv_bswap32(0xffffffffu);
        }",
    );
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

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_byte_swap32_literal_boundaries_and_double_reversal_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __nv_bswap32(0xffffffffu); out[1] = __nv_bswap32(0x80ff017fu);
        out[2] = __nv_bswap32(0x80000000u); out[3] = __nv_bswap32(0u);
        out[4] = __nv_bswap32(__nv_bswap32(0x12345678u));
        out[5] = __nv_bswap32(__nv_bswap32(__nv_bswap32(0x807fff01u)));
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
fn cuda_byte_swap32_converts_source_scalars_before_reversing_bytes() {
    validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __nv_bswap32(true); out[1] = __nv_bswap32((short)-1);
        out[2] = __nv_bswap32((unsigned short)0x1234); out[3] = __nv_bswap32(-1);
        out[4] = __nv_bswap32(0x100000001ULL); out[5] = __nv_bswap32(-1LL);
        out[6] = __nv_bswap32(0x1ffffffffUL); out[7] = __nv_bswap32(-1L);
        out[8] = __nv_bswap32(3.75f);
    }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_byte_swap32_reads_volatile_operand_once() {
    let module = validate_with_options_and_capabilities(
        "__global__ void kernel(volatile unsigned *input, unsigned *out) {
        out[0] = __nv_bswap32(input[0]);
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
        1
    );
}

#[test]
fn cuda_byte_swap32_handles_captured_lazy_discarded_and_nested_effects() {
    validate(
        "__device__ unsigned __nv_bswap32(bool value) { return 7u; }
        __device__ unsigned next(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *out) {
            unsigned value = 1;
            out[0] = __nv_bswap32(next(value));
            out[1] = __nv_bswap32(__nv_bswap32(value++));
            choose ? __nv_bswap32(value++) : 0u;
            false && __nv_bswap32(value++); true || __nv_bswap32(value++);
            __nv_bswap32(value++); out[2] = value;
        }",
    );
}

#[test]
fn cuda_byte_swap32_rejects_invalid_calls_definitions_and_constant_contexts() {
    for arguments in ["", "1u, 2u", "out", "make_uint2(1u, 2u)"] {
        reject(&format!(
            "__global__ void kernel(unsigned *out) {{ __nv_bswap32({arguments}); }}"
        ));
    }
    reject("__device__ int __nv_bswap32(unsigned); __global__ void kernel() {}");
    reject("__device__ unsigned __nv_bswap32(unsigned value) { return value; } __global__ void kernel() {}");
    reject("__global__ void kernel() { constexpr unsigned value = __nv_bswap32(1u); }");
    reject("__global__ void kernel() { unsigned __nv_bswap32 = 0; __nv_bswap32(1u); }");
    reject(&format!(
        "__global__ void kernel() {{ {}1u{}; }}",
        "__nv_bswap32(".repeat(70),
        ")".repeat(70)
    ));
}
