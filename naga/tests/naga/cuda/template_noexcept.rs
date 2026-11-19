use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_template_noexcept_accepts_fixed_specs_redeclarations_and_explicit_calls() {
    let (module, _) = validate("template<class T = unsigned> __host__ __device__ unsigned value(T input, unsigned bias = 3u) noexcept;
        template<class Renamed> __host__ __device__ unsigned value(Renamed renamed, unsigned extra) noexcept(true) { return unsigned(renamed) + extra; }
        template<class T> __device__ T bounded(T value) __launch_bounds__(4) noexcept(true);
        template<class U> __device__ U bounded(U value) __launch_bounds__(4) noexcept { return value; }
        template<class T> __device__ T quiet(T value);
        template<class Renamed> __device__ Renamed quiet(Renamed input) noexcept(false) { return input; }
        template<class Scalar> __global__ void kernel(unsigned *out, Scalar input) { out[0] = value(input); out[1] = value<unsigned>(input); out[2] = value<float>(1.0f); out[3] = quiet<int>(3); out[4] = bounded<unsigned>(input); }
        template __global__ void kernel<unsigned>(unsigned *, unsigned);");
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function]
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("value"))
            {
                calls.push(function);
            }
        }
        false
    });
    assert_eq!(calls.len(), 3);
    assert_eq!(calls[0], calls[1]);
    assert_ne!(calls[0], calls[2]);
}

#[test]
fn cuda_template_noexcept_survives_reference_capture_erased_prefix_and_forward_replay() {
    validate("using Null = decltype(nullptr);
        template<class T> __device__ void write(Null erased, unsigned *out, const T &input, bool increment) noexcept(true);
        __global__ void first(unsigned *out, const unsigned *input) { unsigned cursor = 0u; write(nullptr, out, input[cursor++], true); out[1] = cursor; }
        template<class Renamed> __device__ void write(Null erased, unsigned *out, const Renamed &renamed, bool increment) noexcept { out[0] = unsigned(renamed) + unsigned(increment); }
        __global__ void second(unsigned *out, const unsigned *input) { write<unsigned>(nullptr, out, input[0], false); }");
}

#[test]
fn cuda_template_noexcept_fixed_specs_add_no_shader_inputs_or_runtime_expressions() {
    let source = "template<class T> __device__ T helper(T value) SPEC { return value; } __global__ void kernel(unsigned *out, unsigned input) { out[0] = helper(input); }";
    let (ordinary, _) = validate(&source.replace("SPEC", ""));
    for spec in ["noexcept", "noexcept(true)", "noexcept(false)"] {
        let (annotated, _) = validate(&source.replace("SPEC", spec));
        assert_eq!(ordinary.types.len(), annotated.types.len());
        assert_eq!(
            ordinary.global_variables.len(),
            annotated.global_variables.len()
        );
        assert_eq!(ordinary.functions.len(), annotated.functions.len());
        assert_eq!(
            ordinary.entry_points[0].function.expressions.len(),
            annotated.entry_points[0].function.expressions.len()
        );
        for ((_, ordinary), (_, annotated)) in
            ordinary.functions.iter().zip(annotated.functions.iter())
        {
            assert_eq!(ordinary.expressions.len(), annotated.expressions.len());
            assert_eq!(
                ordinary.local_variables.len(),
                annotated.local_variables.len()
            );
        }
    }
}

#[test]
fn cuda_template_noexcept_rejects_conflicts_and_out_of_scope_specs() {
    for source in [
        "template<class T> __device__ T helper(T value) noexcept; template<class T> __device__ T helper(T value) noexcept(false) { return value; } __global__ void kernel() {}",
        "template<class T> __device__ T helper(T value); template<class T> __device__ T helper(T value) noexcept { return value; } __global__ void kernel() {}",
        "template<class T> __device__ T helper(T value) noexcept { return value; } template<class T> __device__ T helper(T value) noexcept(false) { return value; } __global__ void kernel() {}",
        "template<class T> __global__ void kernel(T value) noexcept(false) {}",
        "template<class T> __device__ T helper(T value) noexcept { return value; } template __device__ int helper<int>(int); __global__ void kernel() {}",
        "template<class T> __device__ T helper(T value) noexcept { return value; } template __device__ int helper<int>(int) noexcept(false); __global__ void kernel() {}",
        "template<class T> __global__ void kernel(T value) {} template __global__ void kernel<int>(int) noexcept(false);",
    ] { reject(source); }
    for spec in [
        "noexcept()",
        "noexcept noexcept",
        "noexcept(true) noexcept",
        "noexcept(value)",
        "noexcept(sizeof(T) == 4)",
        "noexcept(!false)",
        "noexcept(Ready)",
        "noexcept(true || threadIdx.x)",
        "noexcept(noexcept(value))",
        "noexcept(opaque())",
    ] {
        reject(&format!("constexpr bool Ready = true; __device__ bool opaque() {{ return true; }} template<class T> __device__ T helper(T value) {spec} {{ return value; }} __global__ void kernel() {{}}"));
    }
}
