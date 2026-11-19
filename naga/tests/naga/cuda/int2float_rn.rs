use naga::front::cuda::{parse_str, Options};
use naga::{Expression, Scalar, TypeInner};

use super::helpers::validate;

#[test]
fn cuda_int2float_rn_converts_to_signed_before_encoding_the_float_result() {
    let (module, info) = validate(
        "using Word = const int; __device__ float __int2float_rn(Word);
        __global__ void kernel(float *out, unsigned value) { out[0] = __int2float_rn(value); }",
    );
    assert!(module.functions.is_empty());
    let expressions = &module.entry_points[0].function.expressions;
    let types = info.get_entry_point(0);
    assert!(expressions.iter().any(|(_, expression)| matches!(
        *expression, Expression::As { expr, target: Scalar::I32 }
        if types[expr].ty.inner_with(&module.types) == &TypeInner::Scalar(Scalar::U32)
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
}

#[test]
fn cuda_int2float_rn_preserves_exact_user_overload_and_builtin_selection() {
    let (module, _) = validate(
        "__device__ int __int2float_rn(unsigned value) { return int(value) + 1; }
        __global__ void kernel(float *out, int signed_value, unsigned word) {
            out[0] = float(__int2float_rn(word));
            out[1] = __int2float_rn(signed_value);
        }",
    );
    let function = &module.entry_points[0].function;
    let mut calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let arguments = &module.functions[function].arguments;
            assert_eq!(arguments.len(), 1);
            assert_eq!(
                module.types[arguments[0].ty].inner,
                TypeInner::Scalar(Scalar::U32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
    assert!(function.expressions.iter().any(|(_, expression)| matches!(
        *expression, Expression::Bitcast { ty, .. }
        if module.types[ty].inner == TypeInner::Scalar(Scalar::F32)
    )));
}

#[test]
fn cuda_int2float_rn_rejects_invalid_declarations_calls_and_source_constants() {
    for source in [
        "__device__ float __int2float_rn(int value) { return float(value); } __global__ void kernel() {}",
        "__device__ int __int2float_rn(int); __global__ void kernel() {}",
        "__global__ void kernel() { __int2float_rn(); }",
        "__global__ void kernel() { __int2float_rn(1, 2); }",
        "__global__ void kernel() { __int2float_rn(int2(1)); }",
        "__global__ void kernel(int *input) { __int2float_rn(input); }",
        "__global__ void kernel() { int __int2float_rn = 1; __int2float_rn(3); }",
        "__global__ void kernel() { constexpr float value = __int2float_rn(3); }",
        "__global__ void kernel() { static_assert(__int2float_rn(3) == 3.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{source}: {error}");
    }
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : __int2float_rn(3); out[0] = value; }");
}
