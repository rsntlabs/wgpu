mod common;

use common::TestFiles;

#[test]
fn cuda_float2uint_rz_cli_emits_all_backends_with_unsigned_result() {
    let source = "using Real = float; __device__ unsigned __float2uint_rz(const Real);
        __global__ void kernel(unsigned *out, const float *input, int integral) {
            out[0] = __float2uint_rz(input[0]);
            out[1] = __float2uint_rz(integral);
        }";
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|output| output.as_path()).collect();
        let mut arguments = vec!["--entry-point", "kernel"];
        if compact {
            arguments.push("--compact");
        }
        let result = files.translate_outputs(&arguments, &paths);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        for output in outputs {
            assert!(std::fs::metadata(output).unwrap().len() > 0);
        }
        let module = files.read_module();
        let expressions = &module.entry_points[0].function.expressions;
        assert_eq!(
            expressions
                .iter()
                .filter(|(_, expression)| matches!(
                    **expression,
                    naga::Expression::As {
                        target: naga::Scalar::U32,
                        ..
                    }
                ))
                .count(),
            2,
        );
        assert!(expressions.iter().any(|(_, expression)| matches!(
            *expression, naga::Expression::As { expr, target: naga::Scalar::U32 }
            if matches!(expressions[expr], naga::Expression::As { target: naga::Scalar::F32, .. })
        )));
    }
}

#[test]
fn cuda_float2uint_rz_cli_rejects_invalid_calls_without_output() {
    for source in [
        "__device__ int __float2uint_rz(float); __global__ void kernel() {}",
        "__device__ unsigned __float2uint_rz(const float value) { return 1u; } __global__ void kernel() {}",
        "__global__ void kernel(unsigned *out) { out[0] = __float2uint_rz(); }",
        "__global__ void kernel(unsigned *out) { out[0] = __float2uint_rz(1.0f, 2.0f); }",
        "__global__ void kernel(unsigned *out, const float *input) { out[0] = __float2uint_rz(input); }",
        "__global__ void kernel(unsigned *out) { constexpr unsigned value = __float2uint_rz(1.0f); out[0] = value; }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
