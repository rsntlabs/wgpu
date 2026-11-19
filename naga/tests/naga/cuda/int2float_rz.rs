use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_int2float_rz_accepts_canonical_prototype_and_returns_float() {
    let (module, _) = validate(
        "using Word = const int; __device__ float __int2float_rz(Word);
        __device__ int kind(float value) { return 1; } __device__ int kind(int value) { return 2; }
        __global__ void kernel(int *out, int value) { out[0] = kind(__int2float_rz(value)); }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            assert_eq!(
                module.types[module.functions[function].arguments[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::F32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_int2float_rz_uses_integer_encoding_without_native_float_casts_or_helpers() {
    let (module, info) = validate(
        "__global__ void kernel(float *out, int value) { out[0] = __int2float_rz(value); }",
    );
    assert!(module.functions.is_empty());
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    let function = &module.entry_points[0].function;
    assert!(!function.expressions.iter().any(|(_, expression)| matches!(
        expression,
        naga::Expression::As {
            target: naga::Scalar::F32,
            ..
        }
    )));
    assert!(function.expressions.iter().any(|(_, expression)| matches!(expression, naga::Expression::Bitcast { ty, .. } if module.types[*ty].inner == naga::TypeInner::Scalar(naga::Scalar::F32))));
    let clz: Vec<_> = function
        .expressions
        .iter()
        .filter_map(|(handle, expression)| {
            if let naga::Expression::Math {
                fun: naga::MathFunction::CountLeadingZeros,
                arg,
                ..
            } = *expression
            {
                Some((handle, arg))
            } else {
                None
            }
        })
        .collect();
    assert_eq!(clz.len(), 1);
    for handle in [clz[0].0, clz[0].1] {
        assert_eq!(
            info.get_entry_point(0)[handle].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_int2float_rz_converts_actuals_to_signed_word_before_encoding() {
    let (module, info) = validate(
        "__global__ void kernel(float *out, unsigned value) { out[0] = __int2float_rz(value); }",
    );
    assert!(module.entry_points[0].function.expressions.iter().any(|(_, expression)| matches!(expression, naga::Expression::As { expr, target: naga::Scalar::I32 } if info.get_entry_point(0)[*expr].ty.inner_with(&module.types) == &naga::TypeInner::Scalar(naga::Scalar::U32))));
    for declaration in [
        "bool value = true;",
        "short value = -3;",
        "long long value = 9LL;",
        "float value = -3.5f;",
    ] {
        validate_with_options_and_capabilities(&format!("__global__ void kernel(float *out) {{ {declaration} out[0] = __int2float_rz(value); }}"), &Options::default(), Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64);
    }
    validate("__global__ void kernel(unsigned *out) { out[0] = __float_as_uint(__int2float_rz(0xffffffffu)); }");
}

#[test]
fn cuda_int2float_rz_keeps_overloads_capture_templates_and_volatile_once() {
    validate("__device__ int __int2float_rz(bool value) { return value ? 7 : 9; } __global__ void kernel(float *out) { out[0] = float(__int2float_rz(true)); out[1] = __int2float_rz(3); }");
    validate("__device__ int __int2float_rz(const int &value, int extra) { return value + extra; } __global__ void kernel(float *out) { out[0] = __int2float_rz(3); }");
    validate("template<class T> __device__ int __int2float_rz(T *value) { return 55; } __global__ void kernel(float *out) { out[0] = __int2float_rz(3); }");
    let (module, _) = validate_with_options_and_capabilities("__device__ int next(int &value) { return value++; }
        __global__ void kernel(float *out, const volatile int *input, bool choose) { int value = 3; out[0] = __int2float_rz(input[0]); out[1] = choose ? __int2float_rz(next(value)) : __int2float_rz(next(value)); bool skipped = false && __int2float_rz(next(value)); out[2] = float(value) + float(skipped); }", &Options::default(), Capabilities::MEMORY_DECORATION_VOLATILE);
    let function = &module.entry_points[0].function;
    let reads = function
        .expressions
        .iter()
        .filter(|(_, expression)| {
            let naga::Expression::Load { pointer } = **expression else {
                return false;
            };
            let naga::Expression::GlobalVariable(global) =
                function.expressions[root_expression(function, pointer)]
            else {
                return false;
            };
            module.global_variables[global].binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 1,
                })
        })
        .count();
    assert_eq!(reads, 1);
}

#[test]
fn cuda_int2float_rz_rejects_invalid_declarations_calls_and_source_constants() {
    for source in [
        "__device__ float __int2float_rz(int value) { return float(value); } __global__ void kernel() {}",
        "__device__ int __int2float_rz(int value); __global__ void kernel() {}",
        "__global__ void kernel() { __int2float_rz(); }",
        "__global__ void kernel() { __int2float_rz(1, 2); }",
        "__global__ void kernel() { __int2float_rz(int2(1)); }",
        "__global__ void kernel(int *input) { __int2float_rz(input); }",
        "__global__ void kernel() { int __int2float_rz = 1; __int2float_rz(3); }",
        "__global__ void kernel() { constexpr float value = __int2float_rz(3); }",
        "__global__ void kernel() { static_assert(__int2float_rz(3) == 3.0f); }",
        "template<int N = int(__int2float_rz(3))> __device__ int value() { return N; } __global__ void kernel() {}",
        "__global__ void kernel() { return; __int2float_rz(missing); }",
    ] { reject(source); }
    let source = "// π UTF-8 span\n__device__ void empty() {} __global__ void kernel() { __int2float_rz(empty()); }";
    assert_eq!(&source[reject(source).span.to_range().unwrap()], "empty()");
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : __int2float_rz(3); out[0] = value; }");
}
