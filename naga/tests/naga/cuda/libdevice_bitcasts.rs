use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

const ALIASES: [(&str, &str, &str, &str); 4] = [
    ("__nv_float_as_int", "__float_as_int", "float", "int"),
    ("__nv_float_as_uint", "__float_as_uint", "float", "unsigned"),
    ("__nv_int_as_float", "__int_as_float", "int", "float"),
    ("__nv_uint_as_float", "__uint_as_float", "unsigned", "float"),
];

#[test]
fn cuda_libdevice_bitcast_aliases_share_exact_emission_and_fixed_scalar_conversions() {
    for (alias, original, input, output) in ALIASES {
        let source = |name: &str| {
            format!(
                "__global__ void kernel({output} *out,{input} value) {{ out[0]={name}(value); }}"
            )
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
        for actual in ["true", "3", "5u", "2.75f"] {
            validate(&format!(
                "__host__ __device__ {output} {alias}({input});
                __global__ void kernel({output} *out) {{ out[0]={alias}({actual}); }}"
            ));
        }
    }
}

#[test]
fn cuda_libdevice_bitcast_aliases_reject_wrong_signatures_arguments_and_constants() {
    for (alias, _, input, output) in ALIASES {
        let wrong = if output == "int" { "unsigned" } else { "int" };
        let sources=[
            format!("__device__ {wrong} {alias}({input}); __global__ void kernel() {{}}"),
            format!("__device__ {output} {alias}({input} x) {{ return {output}(x); }} __global__ void kernel() {{}}"),
            format!("__global__ void kernel() {{ {alias}(); }}"),
            format!("__global__ void kernel() {{ {alias}(1,2); }}"),
            format!("__global__ void kernel(float *p) {{ {alias}(p); }}"),
            format!("__global__ void kernel() {{ float2 v{{1,2}}; {alias}(v); }}"),
            format!("__global__ void kernel() {{ constexpr {output} x={alias}(1); }}"),
        ];
        for source in sources {
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
    }
}
