use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

const SPELLINGS: [(&str, &str, &str, &str, &str); 4] = [
    ("__nv_ilogbf", "ilogbf", "int", "float", "x++"),
    ("__nv_logbf", "logbf", "float", "float", "x++"),
    (
        "__nv_ldexpf",
        "ldexpf",
        "float",
        "float, int",
        "x++, scale++",
    ),
    (
        "__nv_scalbnf",
        "scalbnf",
        "float",
        "float, int",
        "x++, scale++",
    ),
];

#[test]
fn cuda_libdevice_exponents_match_cuda_spellings() {
    for (alias, original, result, parameters, arguments) in SPELLINGS {
        let source = format!(
            "__host__ __device__ {result} {alias}({parameters});
            __global__ void kernel({result} *out, float x, unsigned scale) {{
                out[0] = {alias}({arguments});
                out[1] = {result}(x);
                out[2] = {result}(scale);
            }}"
        );
        let (libdevice, libdevice_info) = validate(&source);
        let (cuda, cuda_info) = validate(&source.replace(alias, original));
        assert_eq!(libdevice.functions.len(), cuda.functions.len());
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
                "{alias}",
            );
        }
        let _ = (libdevice_info, cuda_info);
    }
}

#[test]
fn cuda_libdevice_exponents_reject_invalid_signatures_and_calls() {
    for (name, _, result, parameters, _) in SPELLINGS {
        let wrong_result = if result == "int" { "float" } else { "int" };
        let (pointers, constants) = if parameters.contains(',') {
            ("p, 2", "1, 2")
        } else {
            ("p", "1")
        };
        for source in [
            format!(
                "__device__ {wrong_result} {name}({parameters}); __global__ void kernel() {{}}"
            ),
            format!("using {name} = float; __global__ void kernel() {{}}"),
            format!("__global__ void kernel() {{ {name}(); }}"),
            format!("__global__ void kernel(float *p) {{ {name}({pointers}); }}"),
            format!("__global__ void kernel() {{ constexpr {result} x = {name}({constants}); }}"),
        ] {
            let error = parse_str(&source, &Options::default()).unwrap_err();
            let range = error.span.to_range().unwrap();
            assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
        }
    }
}
