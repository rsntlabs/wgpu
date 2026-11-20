use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty());
}

#[test]
fn cuda_uniform_math_barriers_accept_floor_result_as_uniform_control() {
    validate(
        "__global__ void kernel(float value, unsigned *output) {
        __shared__ unsigned shared_values[4];
        shared_values[threadIdx.x] = threadIdx.x + 1u;
        if (floorf(value) > 0.0f) __syncthreads();
        output[threadIdx.x] = shared_values[(threadIdx.x + 1u) & 3u];
    }",
    );
}

const EXPRESSIONS: [&str; 15] = [
    "floorf(value)",
    "__float2int_rd(value)",
    "__float2int_ru(value)",
    "ceilf(value)",
    "roundf(value)",
    "fabsf(value)",
    "sqrtf(value)",
    "rsqrtf(value)",
    "fmodf(value, 2.0f)",
    "nextafterf(value, 2.0f)",
    "fdimf(value, 2.0f)",
    "logbf(value)",
    "value / 2.0f",
    "sinf(value)",
    "cosf(value)",
];

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(error.message.contains("barrier"), "{source}: {error}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_uniform_math_barriers_accept_all_pure_cached_math_controls_and_saved_results() {
    for expression in EXPRESSIONS {
        validate(&format!(
            "__global__ void kernel(float value) {{
            if (({expression}) > 0.0f) __syncthreads();
            float saved = {expression}; if (saved > 0.0f) __syncthreads();
        }}"
        ));
    }
}

#[test]
fn cuda_uniform_math_barriers_accept_synchronizing_device_helpers_and_forward_remapping() {
    for expression in EXPRESSIONS {
        validate(&format!("__device__ void synchronize(float value) {{ if (({expression}) > 0.0f) __syncthreads(); }}
            __global__ void kernel(float value) {{ synchronize(value); }}"));
        validate(&format!(
            "__device__ void synchronize() {{ __syncthreads(); }}
            __global__ void kernel(float value) {{ if (({expression}) > 0.0f) synchronize(); }}"
        ));
        validate(&format!("__device__ void increment(unsigned &counter) {{ ++counter; }}
            __device__ void synchronize(float value);
            __global__ void first(float value, unsigned *out) {{
                unsigned counter = 0; increment(counter); out[0] = counter;
                synchronize(value); if (({expression}) > 0.0f) __syncthreads();
            }}
            __device__ void synchronize(float value) {{ if (({expression}) > 0.0f) __syncthreads(); }}
            __global__ void second(float value) {{ synchronize(value); }}"));
    }
}

#[test]
fn cuda_uniform_math_barriers_reject_each_varying_input_and_synchronizing_argument() {
    for expression in EXPRESSIONS {
        let varying = expression.replace("value", "float(threadIdx.x)");
        reject(&format!(
            "__global__ void kernel() {{ if (({varying}) > 0.0f) __syncthreads(); }}"
        ));
        reject(&format!("__device__ void synchronize(float value) {{ if (({expression}) > 0.0f) __syncthreads(); }}
            __global__ void kernel() {{ synchronize(float(threadIdx.x)); }}"));
    }
    for expression in [
        "fmodf(value, float(threadIdx.x + 1u))",
        "nextafterf(value, float(threadIdx.x + 1u))",
        "fdimf(value, float(threadIdx.x + 1u))",
        "value / float(threadIdx.x + 1u)",
    ] {
        reject(&format!(
            "__global__ void kernel(float value) {{ if (({expression}) > 0.0f) __syncthreads(); }}"
        ));
    }
}

#[test]
fn cuda_uniform_math_barriers_reject_source_overloads_after_native_cache_creation() {
    for (name, parameters, arguments, native) in [
        ("floorf", "int x", "1", "floorf(value)"),
        ("ceilf", "int x", "1", "ceilf(value)"),
        ("roundf", "int x", "1", "roundf(value)"),
        ("fabsf", "int x", "1", "fabsf(value)"),
        ("sqrtf", "int x", "1", "sqrtf(value)"),
        ("rsqrtf", "int x", "1", "rsqrtf(value)"),
        ("fmodf", "int x, int y", "1, 2", "fmodf(value, 2.0f)"),
        ("sinf", "int x", "1", "sinf(value)"),
        ("cosf", "int x", "1", "cosf(value)"),
    ] {
        reject(&format!(
            "__device__ float {name}({parameters}) {{ return float(threadIdx.x); }}
            __global__ void kernel(float value, float *out) {{
                out[0] = {native}; if ({name}({arguments}) > 0.0f) __syncthreads();
            }}"
        ));
    }
}

#[test]
fn cuda_uniform_math_barriers_preserve_varying_alias_storage_and_opaque_call_restrictions() {
    for expression in EXPRESSIONS {
        reject(&format!(
            "__global__ void kernel(float value) {{
            float local = value; float &alias = local; alias = float(threadIdx.x);
            value = local; if (({expression}) > 0.0f) __syncthreads();
        }}"
        ));
        reject(&format!(
            "__global__ void kernel(const float *input) {{
            float value = input[threadIdx.x]; if (({expression}) > 0.0f) __syncthreads();
        }}"
        ));
        reject(&format!(
            "__device__ float opaque(float value) {{ return {expression}; }}
            __global__ void kernel(float value, float *out) {{
                out[0] = {expression}; if (opaque(value) > 0.0f) __syncthreads();
            }}"
        ));
    }
}
