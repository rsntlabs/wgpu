use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate};

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

#[test]
fn cuda_ceilf_converts_scalar_arguments_and_returns_float() {
    for declaration in [
        "bool value = true",
        "int value = -3",
        "unsigned value = 5u",
        "float value = -1.25f",
        "using Sample = const float; Sample value = 2.25f",
    ] {
        let (module, info) = validate(&format!(
            "__global__ void kernel(float *output) {{ {declaration}; output[0] = ceilf(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let result = function
            .body
            .iter()
            .find_map(|statement| {
                let naga::Statement::Store { pointer, value } = *statement else {
                    return None;
                };
                matches!(
                    function.expressions[root_expression(function, pointer)],
                    naga::Expression::GlobalVariable(_)
                )
                .then_some(value)
            })
            .unwrap();
        assert_eq!(
            info.get_entry_point(0)[result].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
    roundtrip(include_str!("../../in/cuda/ceilf.cu"));
}

#[test]
fn cuda_ceilf_preserves_aliases_prototypes_overloads_and_name_hiding() {
    roundtrip(
        "using Sample = const float;
        __device__ float ceilf(Sample);
        __device__ float ceilf(int value) { return ceilf(float(value)); }
        __device__ int ceilf(bool value) { return value ? 7 : 9; }
        __global__ void kernel(float *output) {
            output[0] = ceilf(2.25f); output[1] = ceilf(3); output[2] = ceilf(true);
            { using ceilf = int; output[3] = ceilf(2.75f); }
            output[4] = ceilf(-1.75f);
        }",
    );
    for source in [
        "__device__ int ceilf(float); __global__ void kernel() {}",
        "__device__ float ceilf(const float value) { return value; } __global__ void kernel() {}",
        "using ceilf = int; __global__ void kernel() {}",
        "__global__ void ceilf() {}",
        "__global__ void kernel() { int ceilf = 1; ceilf(1.0f); }",
        "__device__ float helper(int ceilf) { return ceilf(1.0f); } __global__ void kernel() {}",
        "__device__ float ceilf(int value) { return ceilf(value); } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    let source =
        "__device__ int ceilf(int value) { return value; } __global__ void kernel() { ceilf(1u); }";
    assert!(rejected(source).message.contains("ambiguous"));
}

#[test]
fn cuda_ceilf_preserves_reference_helper_argument_snapshots_and_lazy_calls() {
    roundtrip(
        "__device__ float next(float &value) { return value++; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void kernel(float *output, int choose) {
            float value = -1.25f;
            output[0] = pair(ceilf(next(value)), value++);
            output[1] = choose ? ceilf(value++) : ceilf(value++);
            bool skipped = false && ceilf(value++);
            bool ready = true || ceilf(value++);
            output[2] = value;
            output[3] = int(skipped) + int(ready);
            for (int index = 0; index < 2; ++index) {
                if (index == 0) continue;
                output[4] = ceilf(value++);
            }
        }",
    );
}

#[test]
fn cuda_ceilf_is_not_a_source_constant_expression() {
    for source in [
        "constexpr float Rounded = ceilf(2.25f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float rounded = ceilf(2.25f); }",
        "__global__ void kernel() { const int count = int(ceilf(2.25f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (ceilf(2.25f), 3); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Rounded = true ? 9.0f : ceilf(-1.25f);
        __global__ void kernel(int *output) {
            constexpr int Count = false && ceilf(-1.25f) ? 2 : 3;
            int values[Count]{}; output[0] = int(Rounded) + values[0];
        }",
    );
}

#[test]
fn cuda_ceilf_rejects_invalid_arguments_mutation_and_invalid_dead_source() {
    roundtrip("__global__ void kernel() { return; ceilf(-1.25f); }");
    for statement in [
        "ceilf();",
        "ceilf(1.0f, 2.0f);",
        "ceilf(make_float2(1.0f, 2.0f));",
        "float values[2]{}; ceilf(values);",
        "ceilf(output);",
        "ceilf(4.0);",
        "ceil(4.0f);",
        "__ceilf(4.0f);",
        "ceilf(1.0f) = 3.0f;",
        "++ceilf(1.0f);",
        "return; ceilf(missing);",
        "return; ceilf(1.0f, 2.0f);",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
}

#[test]
fn cuda_ceilf_bounds_nesting_and_keeps_exceptional_results_runtime_in_wgsl() {
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("ceilf({expression})");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("ceilf({expression})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let (single, _) = validate(
        "__global__ void kernel(float *output, float value) { output[0] = ceilf(value); }",
    );
    let statements = "output[0] = ceilf(value);".repeat(128);
    let (many, _) = validate(&format!(
        "__global__ void kernel(float *output, float value) {{ {statements} }}"
    ));
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            output[0] = __float_as_uint(ceilf(-0.25f));
            output[1] = __float_as_uint(ceilf(-0.0f));
            output[2] = __float_as_uint(ceilf(__uint_as_float(0x7f800000u)));
            output[3] = __float_as_uint(ceilf(__uint_as_float(0xff800000u)));
            output[4] = __float_as_uint(ceilf(__uint_as_float(0x7f800001u)));
            output[5] = __float_as_uint(ceilf(__uint_as_float(0xffc12345u)));
            output[6] = __float_as_uint(ceilf(3.402823466e38f));
            output[7] = __float_as_uint(ceilf(-3.402823466e38f));
        }",
    );
}
