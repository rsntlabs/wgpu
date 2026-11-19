use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;
use naga::{Expression, Scalar, TypeInner};

use super::helpers::{validate, validate_with_options_and_capabilities};

#[test]
fn cuda_uint2float_rz_converts_actuals_before_encoding_the_float_result() {
    check_unsigned_conversion("__uint2float_rz");
}

#[test]
fn cuda_uint2float_rd_converts_actuals_before_encoding_the_float_result() {
    check_unsigned_conversion("__uint2float_rd");
}

fn check_unsigned_conversion(intrinsic: &str) {
    let (module, info) = validate(&format!(
        "using Word = const unsigned; __device__ float {intrinsic}(Word);
        __global__ void kernel(float *out, int value) {{ out[0] = {intrinsic}(value); }}"
    ));
    assert!(module.functions.is_empty());
    let expressions = &module.entry_points[0].function.expressions;
    let types = info.get_entry_point(0);
    assert!(expressions.iter().any(|(_, expression)| matches!(
        *expression, Expression::As { expr, target: Scalar::U32 }
        if types[expr].ty.inner_with(&module.types) == &TypeInner::Scalar(Scalar::I32)
    )));
    assert!(!expressions.iter().any(|(_, expression)| matches!(
        expression,
        Expression::As {
            target: Scalar::F32,
            ..
        }
    )));
    assert!(expressions.iter().any(|(_, expression)| matches!(
        *expression, Expression::Bitcast { expr, ty }
        if module.types[ty].inner == TypeInner::Scalar(Scalar::F32)
            && types[expr].ty.inner_with(&module.types) == &TypeInner::Scalar(Scalar::U32)
    )));
    for declaration in [
        "bool value = true;",
        "short value = -3;",
        "unsigned long long value = 4294967300ULL;",
        "float value = 3.5f;",
    ] {
        validate_with_options_and_capabilities(
            &format!("__global__ void kernel(float *out) {{ {declaration} out[0] = {intrinsic}(value); }}"),
            &Options::default(),
            Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
    }
}

#[test]
fn cuda_uint2float_rz_preserves_user_overloads_and_template_selection() {
    check_unsigned_overloads("__uint2float_rz");
}

#[test]
fn cuda_uint2float_rd_preserves_user_overloads_and_template_selection() {
    check_unsigned_overloads("__uint2float_rd");
}

fn check_unsigned_overloads(intrinsic: &str) {
    let (module, _) = validate(
        &"__device__ int __uint2float_rz(int value) { return value + 1; }
        template<class T> __device__ T __uint2float_rz(T *value) { return value[0]; }
        __device__ float use_template() { float value = 1.0f; return __uint2float_rz(&value); }
        __global__ void kernel(float *out, int signed_value, unsigned word) {
            out[0] = float(__uint2float_rz(signed_value));
            out[1] = __uint2float_rz(word);
            out[2] = use_template();
        }"
        .replace("__uint2float_rz", intrinsic),
    );
    let function = &module.entry_points[0].function;
    let mut signed_calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let arguments = &module.functions[function].arguments;
            if arguments.len() == 1
                && module.types[arguments[0].ty].inner == TypeInner::Scalar(Scalar::I32)
            {
                signed_calls += 1;
            }
        }
        false
    });
    assert_eq!(signed_calls, 1);
    assert!(function.expressions.iter().any(|(_, expression)| matches!(
        *expression, Expression::Bitcast { ty, .. }
        if module.types[ty].inner == TypeInner::Scalar(Scalar::F32)
    )));
}

#[test]
fn cuda_uint2float_rz_rejects_invalid_declarations_calls_and_source_constants() {
    check_invalid_unsigned_calls("__uint2float_rz");
}

#[test]
fn cuda_uint2float_rd_rejects_invalid_declarations_calls_and_source_constants() {
    check_invalid_unsigned_calls("__uint2float_rd");
}

fn check_invalid_unsigned_calls(intrinsic: &str) {
    for source in [
        "__device__ float __uint2float_rz(unsigned value) { return float(value); } __global__ void kernel() {}",
        "__device__ unsigned __uint2float_rz(unsigned); __global__ void kernel() {}",
        "__global__ void kernel() { __uint2float_rz(); }",
        "__global__ void kernel() { __uint2float_rz(1u, 2u); }",
        "__global__ void kernel() { __uint2float_rz(uint2(1u)); }",
        "__global__ void kernel(unsigned *input) { __uint2float_rz(input); }",
        "__global__ void kernel() { int __uint2float_rz = 1; __uint2float_rz(3u); }",
        "__global__ void kernel() { constexpr float value = __uint2float_rz(3u); }",
        "__global__ void kernel() { static_assert(__uint2float_rz(3u) == 3.0f); }",
    ] {
        let source = source.replace("__uint2float_rz", intrinsic);
        let error = parse_str(&source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{source}: {error}");
    }
    validate(&format!("__global__ void kernel(float *out) {{ constexpr float value = true ? 3.0f : {intrinsic}(3u); out[0] = value; }}"));
}
