use naga::front::cuda::{parse_str, Options};
use naga::{Expression, Scalar, TypeInner};

use super::helpers::validate;

#[test]
fn cuda_uint2float_ru_converts_to_unsigned_before_encoding_the_float_result() {
    let (module, info) = validate(
        "using Word = const unsigned; __device__ float __uint2float_ru(Word);
        __global__ void kernel(float *out, int value) { out[0] = __uint2float_ru(value); }",
    );
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
}

#[test]
fn cuda_uint2float_ru_preserves_exact_user_overload_and_builtin_selection() {
    let (module, _) = validate(
        "__device__ int __uint2float_ru(int value) { return value + 1; }
        __global__ void kernel(float *out, int signed_value, unsigned word) {
            out[0] = float(__uint2float_ru(signed_value));
            out[1] = __uint2float_ru(word);
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
                TypeInner::Scalar(Scalar::I32)
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
fn cuda_uint2float_ru_rejects_non_scalar_arguments_and_source_constants() {
    for source in [
        "__global__ void kernel() { __uint2float_ru(uint2(1u)); }",
        "__global__ void kernel(unsigned *input) { __uint2float_ru(input); }",
        "__global__ void kernel() { int __uint2float_ru = 1; __uint2float_ru(3u); }",
        "__global__ void kernel() { constexpr float value = __uint2float_ru(3u); }",
        "__global__ void kernel() { static_assert(__uint2float_ru(3u) == 3.0f); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(
            !range.is_empty() && source.get(range).is_some(),
            "{source}: {error}"
        );
    }
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : __uint2float_ru(3u); out[0] = value; }");
}
