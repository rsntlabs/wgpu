mod common;

use common::TestFiles;

#[test]
fn cuda_float2int_rz_cli_emits_all_backends_and_preserves_result_type() {
    let source = "using Real = float; __device__ int __float2int_rz(const Real);
        __global__ void kernel(int *out, const float *input, unsigned integral) {
            out[0] = __float2int_rz(input[0]);
            out[1] = __float2int_rz(integral);
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
        let mut converts_to_int = 0;
        let mut converts_to_float = 0;
        for (_, expression) in module.entry_points[0].function.expressions.iter() {
            if let naga::Expression::As { target, .. } = *expression {
                converts_to_int += usize::from(target == naga::Scalar::I32);
                converts_to_float += usize::from(target == naga::Scalar::F32);
            }
        }
        assert_eq!(converts_to_int, 2);
        assert_eq!(converts_to_float, 1);
    }
}

#[test]
fn cuda_float2int_rz_cli_rejects_invalid_calls_without_output() {
    for source in [
        "__device__ unsigned __float2int_rz(float); __global__ void kernel() {}",
        "__device__ int __float2int_rz(const float value) { return 1; } __global__ void kernel() {}",
        "__global__ void kernel(int *out) { out[0] = __float2int_rz(); }",
        "__global__ void kernel(int *out) { out[0] = __float2int_rz(1.0f, 2.0f); }",
        "__global__ void kernel(int *out, const float *input) { out[0] = __float2int_rz(input); }",
        "__global__ void kernel(int *out) { constexpr int value = __float2int_rz(1.0f); out[0] = value; }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
