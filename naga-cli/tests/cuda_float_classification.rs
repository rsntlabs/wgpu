mod common;
use common::TestFiles;

#[test]
fn cuda_float_classification_cli_lowers_f32_predicates_to_all_backends() {
    let source = r#"__host__ __device__ int isfinite(float value);
        __host__ __device__ int isinf(float value);
        __host__ __device__ int isnan(float value);
        __host__ __device__ int signbit(float value);
        __device__ unsigned kind(int value) { return 10u + unsigned(value); }
        __device__ unsigned kind(bool value) { return 20u + unsigned(value); }
        __device__ int signbit(bool value) { return value ? 7 : 9; }
        __global__ void kernel(unsigned *output, float value) {
            output[0] = kind(isfinite(value)); output[1] = kind(isinf(value));
            output[2] = kind(isnan(value)); output[3] = kind(signbit(value));
            output[4] = unsigned(isfinite(float(3))); output[5] = unsigned(signbit(true));
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
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
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|s| s.width <= 4)));
        let resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
            .collect();
        assert_eq!(resources.len(), 2);
        for (binding, global) in resources {
            assert_eq!(binding.group, 0);
            if binding.binding == 0 {
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("output array");
                };
                assert_eq!(stride, 4);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            } else {
                assert_eq!(binding.binding, 1);
                assert_eq!(global.space, naga::AddressSpace::Uniform);
                let naga::TypeInner::Struct { ref members, .. } = module.types[global.ty].inner
                else {
                    panic!("uniform block");
                };
                assert_eq!(members[0].offset, 0);
                assert_eq!(
                    module.types[members[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::F32)
                );
            }
        }
    }
}

#[test]
fn cuda_float_classification_cli_rejects_bad_calls_and_canonical_declarations() {
    for source in [
        "__global__ void kernel() { isfinite(1); }",
        "__global__ void kernel() { isinf(1u); }",
        "__global__ void kernel() { isnan(true); }",
        "__global__ void kernel() { signbit(1LL); }",
        "__device__ int isfinite(bool value) { return 7; } template<class T> __device__ int classify(T value) { return isfinite(value); } __global__ void kernel(int *out) { out[0] = classify(1); }",
        "__device__ bool isfinite(float value); __global__ void kernel() {}",
        "__device__ unsigned isinf(float value); __global__ void kernel() {}",
        "__device__ float isnan(float value); __global__ void kernel() {}",
        "__device__ int signbit(float value) { return 1; } __global__ void kernel() {}",
        "__global__ void kernel() { isfinite(); }",
        "__global__ void kernel() { isinf(1.0f, 2.0f); }",
        "__global__ void kernel(float *input) { isnan(input); }",
        "__global__ void kernel() { float2 value{1,2}; signbit(value); }",
        "__global__ void kernel() { constexpr int value = isnan(1.0f); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpected acceptance: {source}");
    }
}

#[test]
fn cuda_float_classification_cli_preserves_template_and_captured_float_routes() {
    let source = "__device__ int isfinite(bool value) { return 7; }
        template<class T> __device__ int isnan(T value) { return 9; }
        template<class T> __device__ int classify(T value) { return isfinite(value); }
        __global__ void kernel(unsigned *out, float value) { out[0] = unsigned(classify(value)); out[1] = unsigned(isnan(value)); out[2] = unsigned(isnan(1)); out[3] = unsigned(isfinite(true)); }";
    let files = TestFiles::new("cu", source);
    let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
        .iter()
        .map(|ext| files.output.with_extension(ext))
        .collect();
    let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
    let result = files.translate_outputs(&["--entry-point", "kernel"], &paths);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
}
