use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

const ALIASES: [(&str, &str); 4] = [
    ("__nv_finitef", "isfinite"),
    ("__nv_isinff", "isinf"),
    ("__nv_isnanf", "isnan"),
    ("__nv_signbitf", "signbit"),
];

#[test]
fn cuda_libdevice_classification_aliases_match_int_results_and_existing_emission() {
    for (alias, original) in ALIASES {
        for actual in ["true", "1", "1u"] {
            validate(&format!(
                "__global__ void kernel(int *out) {{ out[0]={alias}({actual}); }}"
            ));
            assert!(parse_str(
                &format!("__global__ void kernel(int *out) {{ out[0]={original}({actual}); }}"),
                &Options::default()
            )
            .is_err());
        }
        validate(&format!(
            "__device__ int converted(int x) {{ return {alias}(x); }}
            __device__ int {alias}(int x) {{ return 55; }}
            __global__ void kernel(int *out,float value) {{
                out[0]=converted(3); out[1]={alias}(3); out[2]={alias}(value);
            }}"
        ));
        let source = |name: &str| {
            format!("__global__ void kernel(int *out,float value) {{ out[0]={name}(value); }}")
        };
        let (aliased, _) = validate(&source(alias));
        let (control, _) = validate(&source(original));
        assert_eq!(
            aliased.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>(),
            control.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>()
        );
        validate(&format!("__host__ __device__ int {alias}(float);
            __device__ unsigned kind(int x) {{ return 1u; }} __device__ unsigned kind(bool x) {{ return 2u; }}
            __global__ void kernel(unsigned *out,float value) {{ out[0]=kind({alias}(value)); }}"));
    }
}

#[test]
fn cuda_libdevice_classification_aliases_reject_invalid_actuals_and_invalid_declarations() {
    for (alias, _) in ALIASES {
        for actual in ["pointer", "vector"] {
            let source=format!("__global__ void kernel(float *pointer) {{ float2 vector{{1,2}}; {alias}({actual}); }}");
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
        for source in [
            "__device__ bool OP(float); __global__ void kernel() {}",
            "__device__ int OP(float x) { return 1; } __global__ void kernel() {}",
            "__global__ void kernel() { OP(); }",
            "__global__ void kernel() { OP(1.0f,2.0f); }",
            "__global__ void kernel() { constexpr int x=OP(1.0f); }",
        ] {
            assert!(parse_str(&source.replace("OP", alias), &Options::default()).is_err());
        }
    }
}
