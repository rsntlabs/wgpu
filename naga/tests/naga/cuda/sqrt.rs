use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate};

const FIXTURE: &str = include_str!("../../in/cuda/sqrt.cu");

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
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

#[test]
fn cuda_sqrt_float_overload_preserves_alias_types_and_shares_sqrtf_lowering() {
    let source = "using Sample = const float;
        __global__ void kernel(float *output, Sample value) {
            float root = sqrt(value); float other = sqrtf(value);
            output[0] = root; output[1] = other;
        }";
    let (module, info) = validate(source);
    let function = &module.entry_points[0].function;
    for name in ["root", "other"] {
        let value = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
    let calls: Vec<_> = function
        .body
        .iter()
        .filter_map(|statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                Some(function)
            } else {
                None
            }
        })
        .collect();
    assert_eq!(calls.len(), 2);
    assert_eq!(
        calls[0], calls[1],
        "sqrt and sqrtf should reuse one root helper"
    );
    assert_eq!(module.functions.len(), 1);
    roundtrip(source);
    roundtrip(FIXTURE);
}

#[test]
fn cuda_sqrt_integral_templates_require_double_unless_an_exact_ordinary_overload_wins() {
    for (definitions, arguments) in [
        ("", &["true", "-3", "1u"][..]),
        (
            "__device__ int sqrt(int value) { return value; }",
            &["true", "1u"][..],
        ),
        (
            "__device__ int sqrt(bool value) { return value; }",
            &["-3", "1u"][..],
        ),
    ] {
        for argument in arguments {
            let source =
                format!("{definitions} /* π */ __global__ void kernel() {{ sqrt({argument}); }}");
            let error = rejected(&source);
            assert!(error.message.contains("double"), "{}", error.message);
            assert_eq!(&source[error.span.to_range().unwrap()], "sqrt");
        }
    }
    roundtrip(
        "using Flag = const bool; using Count = const unsigned;
        __device__ int sqrt(Flag value) { return value ? 7 : 9; }
        __device__ int sqrt(const int value) { return value + 40; }
        __device__ unsigned sqrt(Count value) { return value + 50u; }
        __device__ int sqrt(int first, int second) { return first + second; }
        __global__ void kernel(float *output) {
            output[0] = sqrt(true); output[1] = sqrt(-3); output[2] = sqrt(3u);
            output[3] = sqrt(4.0f); output[4] = sqrt(3, 4);
        }",
    );
    roundtrip(
        "__device__ float sqrt(int value) { return sqrt(float(value)); }
        __global__ void kernel(float *output) { output[0] = sqrt(9); }",
    );
    let source =
        "__device__ float sqrt(int value) { return sqrt(value); } __global__ void kernel() {}";
    assert!(rejected(source).message.contains("recurs"));
}

#[test]
fn cuda_sqrt_prototypes_collisions_and_hiding_follow_existing_overload_rules() {
    roundtrip(
        "using Sample = const float; __device__ float sqrt(Sample);
        __device__ float sqrt(float); __device__ float sqrtf(Sample);
        __global__ void kernel(float *output) {
            { using sqrt = int; output[0] = sqrt(2.5f); }
            output[1] = sqrt(4.0f);
        }",
    );
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        rejected(&format!(
            "using Sample = const float;
            __device__ {result} sqrt(Sample value) {{ {body} }} __global__ void kernel() {{}}"
        ));
    }
    for source in [
        "__device__ int sqrt(float); __global__ void kernel() {}",
        "using sqrt = int; __global__ void kernel() {}",
        "__global__ void sqrt() {}",
        "__global__ void kernel() { int sqrt = 1; sqrt(4.0f); }",
        "__device__ float helper(int sqrt) { return sqrt(4.0f); } __global__ void kernel() {}",
    ] {
        let error = rejected(source);
        assert_eq!(&source[error.span.to_range().unwrap()], "sqrt");
    }
}

#[test]
fn cuda_sqrt_calls_capture_arguments_once_and_stay_in_selected_control_flow() {
    roundtrip(
        "__device__ float next(float &value) { return value++; }
        __device__ float pair(float first, float second) { return first * 10.0f + second; }
        __global__ void kernel(float *output, unsigned choose) {
            float value = 9.0f;
            output[0] = pair(sqrt(next(value)), value++);
            output[1] = choose ? sqrt(next(value)) : sqrtf(next(value));
            bool skipped = false && sqrt(next(value));
            bool also_skipped = true || sqrt(next(value));
            output[2] = value + skipped + also_skipped;
        }",
    );
}

#[test]
fn cuda_sqrt_requires_one_float_compatible_argument_and_a_prvalue_result() {
    for statement in [
        "sqrt();",
        "sqrt(1.0f, 2.0f);",
        "sqrt(output);",
        "float values[2]{}; sqrt(values);",
        "sqrt(make_float2(1.0f, 4.0f));",
        "sqrt(4.0);",
        "sqrt(4.0f) = 3.0f;",
        "++sqrt(4.0f);",
        "return; sqrt(missing);",
        "return; sqrt(1.0f, 2.0f);",
    ] {
        rejected(&format!(
            "__global__ void kernel(float *output) {{ {statement} }}"
        ));
    }
    roundtrip("__global__ void kernel() { return; sqrt(-1.0f); }");
}

#[test]
fn cuda_sqrt_stays_runtime_preserves_exceptional_values_and_bounds_nested_source() {
    for source in [
        "constexpr float Root = sqrt(4.0f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float root = sqrt(4.0f); }",
        "__global__ void kernel() { const int Count = int(sqrt(4.0f)); int values[Count]; }",
        "__global__ void kernel() { constexpr int Count = (sqrt(4.0f), 3); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "constexpr float Root = true ? 9.0f : sqrt(-1.0f);
        __global__ void kernel(unsigned *output) {
            output[0] = __float_as_uint(sqrt(-1.0f));
            output[1] = __float_as_uint(sqrt(-0.0f));
            output[2] = __float_as_uint(sqrt(__uint_as_float(0x7f800000u)));
            output[3] = __float_as_uint(sqrt(__uint_as_float(0x7f800001u)));
            output[4] = unsigned(Root);
        }",
    );
    let mut expression = String::from("value");
    for _ in 0..8 {
        expression = format!("sqrt({expression})");
    }
    roundtrip(&format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    ));
    for _ in 0..80 {
        expression = format!("sqrt({expression})");
    }
    let source = format!(
        "__global__ void kernel(float *output, float value) {{ output[0] = {expression}; }}"
    );
    let error = rejected(&source);
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}
