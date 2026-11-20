use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

const ROUNDING: [&str; 6] = ["floorf", "ceilf", "roundf", "truncf", "rintf", "nearbyintf"];

#[test]
fn cuda_libdevice_rounding_matches_cuda_spellings() {
    for original in ROUNDING {
        let alias = format!("__nv_{original}");
        let source = format!(
            "using Sample = float;
            __host__ __device__ Sample {alias}(const Sample);
            __global__ void kernel(float *out, float value, unsigned count) {{
                out[0] = {alias}(value++);
                out[1] = {alias}(count++);
                out[2] = value;
                out[3] = float(count);
            }}"
        );
        let (libdevice, libdevice_info) = validate(&source);
        let (cuda, cuda_info) = validate(&source.replace(&alias, original));
        assert_eq!(libdevice.functions.len(), cuda.functions.len(), "{alias}");
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
            "{alias}",
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
    }
}

#[test]
fn cuda_libdevice_rounding_rejects_invalid_signatures_and_calls() {
    for original in ROUNDING {
        let name = format!("__nv_{original}");
        for source in [
            format!("__device__ int {name}(float); __global__ void kernel() {{}}"),
            format!(
                "__device__ float {name}(float x) {{ return x; }} __global__ void kernel() {{}}"
            ),
            format!("using {name} = float; __global__ void kernel() {{}}"),
            format!("__global__ void kernel() {{ {name}(); }}"),
            format!("__global__ void kernel(float *p) {{ {name}(p); }}"),
            format!("__global__ void kernel() {{ constexpr float x = {name}(1); }}"),
        ] {
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
    }
}
