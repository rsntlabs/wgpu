use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_funnel_shifts_roundtrip_wrapping_literal_words() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *output) {
            output[0] = __funnelshift_l(0xffffffffu, 0xffffffffu, 31u);
            output[1] = __funnelshift_r(0xffffffffu, 0xffffffffu, 31u);
            output[2] = __funnelshift_l(0x12345678u, 0x87654321u, 32u);
            output[3] = __funnelshift_r(0x12345678u, 0x87654321u, 32u);
        }",
        &Options::default(),
        Capabilities::empty(),
    );
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_funnel_shifts_accept_unsigned_signatures_and_return_unsigned() {
    let module = validate(
        "__device__ int select_result(unsigned x) { return 1; }
        __device__ int select_result(int x) { return 2; }
        __global__ void kernel(unsigned *output, unsigned lo, unsigned hi, unsigned shift) {
            output[0] = __funnelshift_l(lo, hi, shift);
            output[1] = __funnelshift_r(lo, hi, shift);
            output[2] = select_result(__funnelshift_l(1u, 2u, 3u));
            output[3] = select_result(__funnelshift_r(1u, 2u, 3u));
        }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            let argument = &module.functions[*function].arguments[0];
            assert_eq!(
                module.types[argument.ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 2);
}

#[test]
fn cuda_funnel_shifts_mask_every_emitted_shift_and_need_no_int64() {
    let module = validate(
        "__global__ void kernel(unsigned *out, unsigned lo, unsigned hi, unsigned shift) {
        out[0] = __funnelshift_l(lo, hi, shift); out[1] = __funnelshift_r(lo, hi, shift);
    }",
    );
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
    )));
    let function = &module.entry_points[0].function;
    let mut shifts = 0;
    for (_, expression) in function.expressions.iter() {
        if let naga::Expression::Binary {
            op: naga::BinaryOperator::ShiftLeft | naga::BinaryOperator::ShiftRight,
            right,
            ..
        } = *expression
        {
            let naga::Expression::Binary {
                op: naga::BinaryOperator::And,
                right: mask,
                ..
            } = function.expressions[right]
            else {
                panic!("unmasked shift: {expression:?}");
            };
            assert_eq!(
                function.expressions[mask],
                naga::Expression::Literal(naga::Literal::U32(31))
            );
            shifts += 1;
        }
    }
    assert_eq!(shifts, 4);
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_funnel_shifts_accept_canonical_prototypes_and_scalar_conversions() {
    validate_with_options_and_capabilities(
        "__device__ unsigned __funnelshift_l(unsigned, unsigned, unsigned);
        __device__ unsigned __funnelshift_r(unsigned, unsigned, unsigned);
        __global__ void kernel(unsigned *output) {
            output[0] = __funnelshift_l(-1, true, (unsigned short)33);
            output[1] = __funnelshift_r((short)-2, false, 0xffffffffu);
            output[2] = __funnelshift_l(0x100000001ULL, -1LL, 0x100000020ULL);
            output[3] = __funnelshift_r(0x100000001UL, -1L, 0x100000020UL);
            output[4] = __funnelshift_l(3.75f, 2u, 1u);
        }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_funnel_shifts_read_each_volatile_argument_once() {
    for name in ["__funnelshift_l", "__funnelshift_r"] {
        let source = format!("__global__ void kernel(volatile unsigned *input, unsigned *output) {{ output[0] = {name}(input[0], input[1], input[2]); }}");
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
fn cuda_funnel_shifts_support_captured_overloads_lazy_and_discarded_calls() {
    validate(
        "__device__ unsigned __funnelshift_l(bool a, bool b, bool c) { return 99u; }
        __device__ unsigned __funnelshift_r(bool a, bool b, bool c) { return 99u; }
        __device__ unsigned advance(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *output) {
            unsigned value = 1;
            output[0] = __funnelshift_l(advance(value), advance(value), advance(value));
            output[1] = __funnelshift_r(advance(value), advance(value), advance(value));
            choose ? __funnelshift_l(value++, value++, value++) : 0u;
            false && __funnelshift_r(value++, value++, value++);
            true || __funnelshift_l(value++, value++, value++);
            __funnelshift_r(value++, value++, value++);
            output[2] = value;
        }",
    );
}

#[test]
fn cuda_funnel_shifts_reject_invalid_signatures_arguments_and_constant_contexts() {
    for name in ["__funnelshift_l", "__funnelshift_r"] {
        for arguments in [
            "",
            "1u",
            "1u, 2u",
            "1u, 2u, 3u, 4u",
            "output, 1u, 2u",
            "make_uint2(1u, 2u), 1u, 2u",
        ] {
            reject(&format!(
                "__global__ void kernel(unsigned *output) {{ {name}({arguments}); }}"
            ));
        }
        reject(&format!("__device__ int {name}(unsigned a, unsigned b, unsigned c); __global__ void kernel() {{}}"));
        reject(&format!("__device__ unsigned {name}(unsigned a, unsigned b, unsigned c) {{ return a; }} __global__ void kernel() {{}}"));
        reject(&format!(
            "__global__ void kernel() {{ constexpr unsigned Count = {name}(1u, 2u, 3u); }}"
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
    for name in ["__funnelshift_lc", "__funnelshift_rc"] {
        reject(&format!(
            "__global__ void kernel() {{ {name}(1u, 2u, 3u); }}"
        ));
    }
}
