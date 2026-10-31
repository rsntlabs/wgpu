use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/saturate.cu");

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

fn named_call_count(module: &naga::Module, function: &naga::Function, name: &str) -> usize {
    let mut count = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            count += usize::from(module.functions[*function].name.as_deref() == Some(name));
        }
        false
    });
    count
}

#[test]
fn cuda_saturate_converts_scalar_arguments_and_returns_float() {
    for declaration in [
        "bool value = true",
        "int value = -9",
        "unsigned value = 0xffffffffu",
        "float value = 0.25f",
        "using Sample = const float; Sample value = 0.75f",
    ] {
        let (module, info) = validate(&format!(
            "__global__ void kernel(float *out) {{ {declaration}; out[0] = __saturatef(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let result = function
            .body
            .iter()
            .rev()
            .find_map(|statement| match *statement {
                naga::Statement::Store { value, .. } => Some(value),
                _ => None,
            })
            .unwrap();
        assert_eq!(
            info.get_entry_point(0)[result].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
}

#[test]
fn cuda_saturate_accepts_canonical_prototypes_and_aliases() {
    let (module, _) = validate(
        "using Sample = const float;
        __device__ float __saturatef(float);
        __device__ Sample __saturatef(Sample value);
        __global__ void kernel(float *out) { out[0] = __saturatef(0.5f); }",
    );
    assert!(module.functions.is_empty());
}

#[test]
fn cuda_saturate_rejects_canonical_redefinitions_and_conflicting_results() {
    for result in ["float", "int", "void"] {
        let body = if result == "void" { "" } else { "return 0;" };
        let source = format!(
            "using Sample = const float;
            __device__ {result} __saturatef(Sample value) {{ {body} }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "__saturatef");
    }
    for result in ["int", "void"] {
        let source =
            format!("__device__ {result} __saturatef(float); __global__ void kernel() {{}}");
        assert_eq!(
            &source[rejected(&source).span.to_range().unwrap()],
            "__saturatef"
        );
    }
}

#[test]
fn cuda_saturate_merges_user_overloads_and_preserves_builtin_matches() {
    let (module, _) = validate(
        "__device__ int __saturatef(bool value) { return value ? 7 : 9; }
        __device__ int __saturatef(int value) { return value + 10; }
        __device__ float __saturatef(float first, float second) { return first + second; }
        __global__ void kernel(float *out) {
            out[0] = __saturatef(true);
            out[1] = __saturatef(3);
            out[2] = __saturatef(0.25f);
            out[3] = __saturatef(0.25f, 1.0f);
        }",
    );
    assert_eq!(
        named_call_count(&module, &module.entry_points[0].function, "__saturatef"),
        3
    );
    validate(
        "__device__ float2 __saturatef(float2 value) {
            return make_float2(__saturatef(value.x), __saturatef(value.y));
        }
        __global__ void kernel(float *out) {
            out[0] = __saturatef(make_float2(-0.5f, 0.5f)).y;
        }",
    );
    let source = "__device__ int __saturatef(int value) { return value; }
        __global__ void kernel() { __saturatef(1u); }";
    let error = rejected(source);
    assert!(error.message.contains("ambiguous"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "__saturatef");
}

#[test]
fn cuda_saturate_checks_current_overload_recursion() {
    validate(
        "__device__ float __saturatef(int value) { return __saturatef(float(value)); }
        __global__ void kernel(float *out) { out[0] = __saturatef(1); }",
    );
    let source = "__device__ float __saturatef(int value) { return __saturatef(value); }
        __global__ void kernel() {}";
    let error = rejected(source);
    assert!(error.message.contains("recurs"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "__saturatef");
}

#[test]
fn cuda_saturate_respects_local_value_parameter_and_type_hiding() {
    for source in [
        "__global__ void kernel() { int __saturatef = 1; __saturatef(0.5f); }",
        "__device__ float helper(int __saturatef) { return __saturatef(0.5f); }
        __global__ void kernel() {}",
        "using __saturatef = int; __global__ void kernel() {}",
        "__global__ void __saturatef() {}",
    ] {
        assert_eq!(
            &source[rejected(source).span.to_range().unwrap()],
            "__saturatef"
        );
    }
    validate(
        "__global__ void kernel(float *out) {
            { using __saturatef = int; out[0] = __saturatef(2.5f); }
            out[1] = __saturatef(0.5f);
        }",
    );
}

#[test]
fn cuda_saturate_requires_one_scalar_argument_and_reports_inner_errors() {
    for arguments in ["", "0.25f, 0.75f", "make_float2(0.25f, 0.75f)"] {
        let source = format!("__global__ void kernel() {{ __saturatef({arguments}); }}");
        let error = rejected(&source);
        assert!(error.message.contains("no matching"), "{error}");
        assert_eq!(&source[error.span.to_range().unwrap()], "__saturatef");
    }
    for source in [
        "__global__ void kernel(float *out) { __saturatef(out); }",
        "__global__ void kernel() { float values[2]{}; __saturatef(values); }",
        "struct Record { float value; }; __global__ void kernel() { Record record{}; __saturatef(record); }",
        "__global__ void kernel() { __saturatef(1.0); }",
        "__global__ void kernel() { __saturatef(1,); }",
    ] {
        rejected(source);
    }
    let source = "__device__ void empty() {} __global__ void kernel() { __saturatef(empty()); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "empty()"
    );
}

#[test]
fn cuda_saturate_results_are_prvalues_and_dead_source_is_checked() {
    validate("__global__ void kernel() { return; __saturatef(-1.0f); }");
    validate(
        "__device__ float unused(float value) { return __saturatef(value); }
        __global__ void kernel() {}",
    );
    for statement in [
        "__saturatef(0.5f) = 3.0f;",
        "++__saturatef(0.5f);",
        "__saturatef(0.5f)++;",
        "return; __saturatef(missing);",
        "return; __saturatef(0.25f, 0.75f);",
    ] {
        rejected(&format!(
            "/* π */ __global__ void kernel() {{ {statement} }}"
        ));
    }
    rejected(
        "__device__ float unused(float value) { return __saturatef(value, value); }
        __global__ void kernel() {}",
    );
}

#[test]
fn cuda_saturate_is_not_a_source_constant_expression() {
    for source in [
        "constexpr float Bounded = __saturatef(0.5f); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr float bounded = __saturatef(0.5f); }",
        "__global__ void kernel() { const int count = int(__saturatef(1.0f)); int values[count]; }",
        "__global__ void kernel() { constexpr int count = (__saturatef(0.5f), 3); }",
        "__device__ void unused() { constexpr float bounded = __saturatef(0.5f); }
        __global__ void kernel() {}",
        "__global__ void kernel() { return; constexpr float bounded = __saturatef(0.5f); }",
    ] {
        rejected(source);
    }
    validate(
        "constexpr float Bounded = true ? 0.25f : __saturatef(-1.0f);
        __global__ void kernel(int *out) {
            constexpr int Count = false && __saturatef(-1.0f) ? 2 : 3;
            int values[Count]{}; out[0] = int(Bounded) + values[0];
        }",
    );
}

#[test]
fn cuda_saturate_works_in_reference_expansion_and_vector_fields() {
    validate(FIXTURE);
}

#[test]
fn cuda_saturate_preserves_argument_calls_and_resource_bindings() {
    let (module, _) = validate(
        "__device__ float next(float value) { return value; }
        __device__ float pair(float first, float second) { return first * 4.0f + second; }
        __global__ void kernel(const float *input, float scale, unsigned *out) {
            float value = input[0];
            out[0] = __float_as_uint(pair(__saturatef(next(value++)), value++));
            out[1] = __float_as_uint(__saturatef(scale));
        }",
    );
    let function = &module.entry_points[0].function;
    assert_eq!(named_call_count(&module, function, "next"), 1);
    assert_eq!(named_call_count(&module, function, "pair"), 1);
    assert_eq!(module.global_variables.len(), 3);
    for (index, (_, global)) in module.global_variables.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32,
            })
        );
    }
}

#[test]
fn cuda_saturate_keeps_existing_depth_limits_and_flat_calls_bounded() {
    validate(
        "__global__ void kernel(float *out, float value) {
            out[0] = __saturatef(__saturatef(__saturatef(value)));
        }",
    );
    let mut expression = String::from("value");
    for _ in 0..96 {
        expression = format!("__saturatef({expression})");
    }
    let source =
        format!("__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}");
    let error = rejected(&source);
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let statements = "out[0] = __saturatef(value);".repeat(128);
    validate(&format!(
        "__global__ void kernel(float *out, float value) {{ {statements} }}"
    ));
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_saturate_fixture_roundtrips_through_the_shared_wgsl_helper() {
    let (module, info) = validate(FIXTURE);
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}
