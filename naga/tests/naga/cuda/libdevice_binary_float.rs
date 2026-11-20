use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

const SPELLINGS: [(&str, &str); 2] = [("__nv_copysignf", "copysignf"), ("__nv_fdimf", "fdimf")];

#[test]
fn cuda_libdevice_binary_float_matches_cuda_spellings() {
    for (alias, original) in SPELLINGS {
        let source = format!(
            "using Sample = float;
            __host__ __device__ Sample {alias}(Sample, const Sample);
            __global__ void kernel(float *out, float x, unsigned y) {{
                out[0] = {alias}(x++, y++);
                out[1] = x;
                out[2] = float(y);
            }}"
        );
        let source_cuda = source.replace(alias, original);
        let (libdevice, libdevice_info) = validate(&source);
        let (cuda, cuda_info) = validate(&source_cuda);
        assert_eq!(libdevice.functions.len(), cuda.functions.len());
        assert_eq!(
            libdevice.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>(),
            cuda.entry_points[0]
                .function
                .expressions
                .iter()
                .collect::<Vec<_>>(),
        );
        #[cfg(feature = "wgsl-out")]
        {
            use naga::back::wgsl::{write_string, WriterFlags};
            let flags = WriterFlags::EXPLICIT_TYPES;
            assert_eq!(
                write_string(&libdevice, &libdevice_info, flags).unwrap(),
                write_string(&cuda, &cuda_info, flags).unwrap(),
                "{alias}",
            );
        }
        let _ = (libdevice_info, cuda_info);
        let (overloaded, _) = validate(&format!(
            "__device__ int {alias}(bool left, bool right) {{ return left && right; }}
            __global__ void kernel(int *out) {{ out[0] = {alias}(true, false); }}"
        ));
        assert!(overloaded
            .functions
            .iter()
            .any(|(_, function)| function.name.as_deref() == Some(alias)));
    }
}

#[test]
fn cuda_libdevice_binary_float_rejects_invalid_signatures_and_calls() {
    for (name, _) in SPELLINGS {
        for source in [
            format!("__device__ int {name}(float, float); __global__ void kernel() {{}}"),
            format!("__device__ float {name}(float x, float y) {{ return x; }} __global__ void kernel() {{}}"),
            format!("using {name} = float; __global__ void kernel() {{}}"),
            format!("__global__ void kernel() {{ {name}(1); }}"),
            format!("__global__ void kernel(float *p) {{ {name}(p, 2); }}"),
            format!("__global__ void kernel() {{ constexpr float x = {name}(1, 2); }}"),
        ] {
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
    }
}
