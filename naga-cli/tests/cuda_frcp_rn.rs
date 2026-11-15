mod common;
use common::TestFiles;

#[test]
fn cuda_frcp_rn_cli_emits_all_backends_with_scalar_float_abi() {
    let source = r#"__host__ __device__ float __frcp_rn(float value);
        __device__ float copied(float value) { return __frcp_rn(value); }
        __device__ int __frcp_rn(bool value) { return 7; }
        __device__ unsigned kind(float value) { return 1u; }
        __device__ unsigned kind(int value) { return 2u; }
        __global__ void kernel(unsigned *output, float value) {
            output[0] = __float_as_uint(__frcp_rn(value));
            output[1] = __float_as_uint(copied(value));
            output[2] = kind(copied(-3));
            output[3] = unsigned(__frcp_rn(true));
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
                assert_eq!(members.len(), 1);
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
fn cuda_frcp_rn_cli_rejects_invalid_calls_and_canonical_declarations() {
    for source in [
        "__device__ int __frcp_rn(float value); __global__ void kernel() {}",
        "__device__ float __frcp_rn(float value) { return value; } __global__ void kernel() {}",
        "__global__ void kernel() { __frcp_rn(); }",
        "__global__ void kernel() { __frcp_rn(1.0f, 2.0f, 3.0f); }",
        "__global__ void kernel(float *input) { __frcp_rn(input); }",
        "__global__ void kernel() { float2 v{1,2}; __frcp_rn(v); }",
        "__global__ void kernel() { constexpr float result = __frcp_rn(1.0f); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpected acceptance: {source}");
    }
}
