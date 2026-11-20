use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_libdevice_trigonometry_matches_cuda_spellings() {
    let source = "
        __host__ __device__ float __nv_sinf(float);
        __device__ float __nv_cosf(float);
        __device__ void __nv_sincosf(float,float*,float*);
        __global__ void kernel(float *out, float value) {
            float sine;
            __nv_sincosf(value++, &sine, out);
            out[1] = sine;
            out[2] = __nv_sinf(value);
            out[3] = __nv_cosf(3);
            __nv_sincosf(value, out + 4, out + 4);
        }";
    let cuda_source = source.replace("__nv_", "");
    let (libdevice, libdevice_info) = validate(source);
    let (cuda, cuda_info) = validate(&cuda_source);
    assert_eq!(
        libdevice
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some("_naga_trigonometry"))
            .count(),
        1
    );
    let expressions = |module: &naga::Module| {
        module.entry_points[0]
            .function
            .expressions
            .iter()
            .map(|(_, expression)| expression.clone())
            .collect::<Vec<_>>()
    };
    assert_eq!(expressions(&libdevice), expressions(&cuda));

    #[cfg(feature = "wgsl-out")]
    {
        use naga::back::wgsl::{write_string, WriterFlags};
        let flags = WriterFlags::EXPLICIT_TYPES;
        assert_eq!(
            write_string(&libdevice, &libdevice_info, flags).unwrap(),
            write_string(&cuda, &cuda_info, flags).unwrap(),
        );
    }
    let _ = (libdevice_info, cuda_info);
}

#[test]
fn cuda_libdevice_trigonometry_rejects_reserved_signatures_and_invalid_calls() {
    for (name, result, parameters, return_body, invalid_calls) in [
        (
            "__nv_sinf",
            "float",
            "float x",
            "return x;",
            ["()", "(p)", "(1, 2)"],
        ),
        (
            "__nv_cosf",
            "float",
            "float x",
            "return x;",
            ["()", "(p)", "(1, 2)"],
        ),
        (
            "__nv_sincosf",
            "void",
            "float x, float *s, float *c",
            "",
            ["(1, p)", "(1, p, q)", "(1, p, nullptr)"],
        ),
    ] {
        for source in [
            format!("__device__ int {name}({parameters}); __global__ void kernel() {{}}"),
            format!("__device__ {result} {name}({parameters}) {{ {return_body} }} __global__ void kernel() {{}}"),
            format!("using {name} = float; __global__ void kernel() {{}}"),
        ]
        .into_iter()
        .chain(invalid_calls.map(|args| {
            format!("__global__ void kernel(float *p, const float *q) {{ {name}{args}; }}")
        }))
        {
            assert!(parse_str(&source, &Options::default()).is_err(), "{source}");
        }
    }
}
