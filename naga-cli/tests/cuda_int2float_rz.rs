mod common;

use common::TestFiles;

#[test]
fn cuda_int2float_rz_cli_emits_all_backends_with_bit_exact_float_result() {
    let source = "using Word = int; __device__ float __int2float_rz(const Word);
        __global__ void kernel(float *out, const int *input, unsigned integral) {
            out[0] = __int2float_rz(input[0]);
            out[1] = __int2float_rz(integral);
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
        assert!(!expressions.iter().any(|(_, expression)| matches!(
            *expression,
            naga::Expression::As {
                target: naga::Scalar::F32,
                ..
            }
        )));
        assert_eq!(
            expressions
                .iter()
                .filter(|(_, expression)| matches!(
                    **expression, naga::Expression::Bitcast { ty, .. }
                    if module.types[ty].inner == naga::TypeInner::Scalar(naga::Scalar::F32)
                ))
                .count(),
            2,
        );
    }
}

#[test]
fn cuda_int2float_rz_cli_rejects_invalid_calls_without_output() {
    for source in [
        "__device__ int __int2float_rz(int); __global__ void kernel() {}",
        "__device__ float __int2float_rz(const int value) { return 1.0f; } __global__ void kernel() {}",
        "__global__ void kernel(float *out) { out[0] = __int2float_rz(); }",
        "__global__ void kernel(float *out) { out[0] = __int2float_rz(1, 2); }",
        "__global__ void kernel(float *out, const int *input) { out[0] = __int2float_rz(input); }",
        "__global__ void kernel(float *out) { constexpr float value = __int2float_rz(1); out[0] = value; }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
