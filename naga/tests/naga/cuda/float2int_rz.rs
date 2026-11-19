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
fn cuda_float2int_rz_accepts_canonical_alias_prototypes_and_returns_signed_int() {
    let (module, _) = validate("using Sample = const float; __device__ int __float2int_rz(Sample);
        __device__ int kind(int value) { return 1; } __device__ int kind(unsigned value) { return 2; }
        __global__ void kernel(int *out, float value) { out[0] = kind(__float2int_rz(value)); }");
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            assert_eq!(
                module.types[module.functions[function].arguments[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::I32)
            );
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_float2int_rz_converts_integral_actual_to_float_before_integer_destination() {
    let (module, info) =
        validate("__global__ void kernel(int *out, int value) { out[0] = __float2int_rz(value); }");
    assert!(module.functions.is_empty());
    let function = &module.entry_points[0].function;
    assert!(function.expressions.iter().any(|(_, expression)| matches!(expression, naga::Expression::As { expr, target: naga::Scalar::F32 } if info.get_entry_point(0)[*expr].ty.inner_with(&module.types) == &naga::TypeInner::Scalar(naga::Scalar::I32))));
    assert!(function.expressions.iter().any(|(_, expression)| matches!(expression, naga::Expression::As { expr, target: naga::Scalar::I32 } if info.get_entry_point(0)[*expr].ty.inner_with(&module.types) == &naga::TypeInner::Scalar(naga::Scalar::F32))));
    for declaration in [
        "bool value = true;",
        "unsigned value = 7u;",
        "short value = -3;",
        "long long value = 9LL;",
    ] {
        validate_with_options_and_capabilities(&format!("__global__ void kernel(int *out) {{ {declaration} out[0] = __float2int_rz(value); }}"), &Options::default(), Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64);
    }
}

#[test]
fn cuda_float2int_rz_preserves_user_overloads_and_captured_or_template_lookup_paths() {
    validate("__device__ unsigned __float2int_rz(int value) { return unsigned(value); } __global__ void kernel(unsigned *out) { out[0] = __float2int_rz(3); out[1] = unsigned(__float2int_rz(3.5f)); }");
    validate("__device__ int __float2int_rz(const int &value, int unused) { return value + unused; } __global__ void kernel(int *out) { out[0] = __float2int_rz(3.5f); }");
    validate("template<class T> __device__ int __float2int_rz(T *value) { return 55; } __global__ void kernel(int *out) { out[0] = __float2int_rz(3.5f); }");
    let (module, _) = validate("template<class T> __device__ int __float2int_rz(T value) { return 55; } __global__ void kernel(int *out) { out[0] = __float2int_rz(3); }");
    assert_eq!(module.functions.len(), 1);
}

#[test]
fn cuda_float2int_rz_evaluates_reference_helpers_volatile_and_selected_arguments_once() {
    let (module, _) = validate_with_options_and_capabilities(
        "__device__ float next(float &value) { return value++; }
        __global__ void kernel(int *out, const volatile float *input, bool choose) {
            float value = 1.5f; out[0] = __float2int_rz(input[0]);
            out[1] = choose ? __float2int_rz(next(value)) : __float2int_rz(next(value));
            bool skipped = false && __float2int_rz(next(value)); out[2] = int(value) + int(skipped);
        }",
        &Options::default(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
    );
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
    validate("__device__ int pair(int first, int second) { return first + second; } __global__ void kernel(int *out) { float value = 1.5f; out[0] = pair(__float2int_rz(value++), int(value++)); }");
}

#[test]
fn cuda_float2int_rz_rejects_invalid_signatures_arguments_and_constant_uses() {
    for source in [
        "__device__ int __float2int_rz(float value) { return 1; } __global__ void kernel() {}",
        "__device__ unsigned __float2int_rz(float value); __global__ void kernel() {}",
        "__global__ void kernel() { __float2int_rz(); }",
        "__global__ void kernel() { __float2int_rz(1.0f, 2.0f); }",
        "__global__ void kernel() { __float2int_rz(float2(1.0f)); }",
        "__global__ void kernel(float *input) { __float2int_rz(input); }",
        "__global__ void kernel() { int __float2int_rz = 1; __float2int_rz(1.0f); }",
        "__global__ void kernel() { constexpr int value = __float2int_rz(3.5f); }",
        "__global__ void kernel() { static_assert(__float2int_rz(3.5f) == 3); }",
        "__global__ void kernel() { const int count = __float2int_rz(3.5f); int values[count]; }",
        "__global__ void kernel() { return; __float2int_rz(missing); }",
    ] {
        reject(source);
    }
    let source = "// π UTF-8 span\n__device__ void empty() {} __global__ void kernel() { __float2int_rz(empty()); }";
    assert_eq!(&source[reject(source).span.to_range().unwrap()], "empty()");
    validate("__global__ void kernel(int *out) { constexpr int value = true ? 3 : __float2int_rz(3.5f); out[0] = value; }");
}
