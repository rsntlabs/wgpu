mod common;

use common::TestFiles;

#[test]
fn cuda_packed_unsigned_saturating_cli_translates_boundaries_and_runtime_values_to_all_backends() {
    let source = r#"__device__ unsigned __vaddus2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vaddus4(unsigned left, unsigned right);
        __device__ unsigned __vsubus2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vsubus4(unsigned left, unsigned right);
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = __vaddus2(input[0], value);
            output[1] = __vaddus4(input[1], value);
            output[2] = __vsubus2(input[2], value);
            output[3] = __vsubus4(input[3], value);
            output[4] = __vaddus2(0xffffffffu, 0x00010001u);
            output[5] = __vaddus4(0xffffffffu, 0x01010101u);
            output[6] = __vsubus2(0u, 0x00010001u);
            output[7] = __vsubus4(0u, 0x01010101u);
            output[8] = __vaddus2(0xffff0001u, 0x00010002u);
            output[9] = __vsubus2(0x00010005u, 0x00020003u);
            output[10] = __vaddus4(0xff0102feu, 0x01020302u);
            output[11] = __vsubus4(0x01030507u, 0x02010308u);
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
        let mut arguments = vec!["--entry-point", "kernel", "--cuda-workgroup-size", "4,1,1"];
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
        assert_eq!(module.entry_points.len(), 1);
        assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
        let mut resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
            .collect();
        resources.sort_by_key(|(binding, _)| binding.binding);
        assert_eq!(resources.len(), 3);
        for (index, (binding, global)) in resources.into_iter().enumerate() {
            assert_eq!(
                binding,
                naga::ResourceBinding {
                    group: 0,
                    binding: index as u32
                }
            );
            if index < 2 {
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected storage array");
                };
                assert_eq!(stride, 4);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: if index == 0 {
                            naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                        } else {
                            naga::StorageAccess::LOAD
                        }
                    }
                );
            } else {
                assert_eq!(global.space, naga::AddressSpace::Uniform);
                let naga::TypeInner::Struct { ref members, .. } = module.types[global.ty].inner
                else {
                    panic!("expected uniform scalar block");
                };
                assert_eq!(members.len(), 1);
                assert_eq!(members[0].offset, 0);
                assert_eq!(
                    module.types[members[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    }
}

#[test]
fn cuda_packed_unsigned_saturating_cli_preserves_user_overloads_and_captured_argument_effects() {
    let source = r#"__device__ bool __vaddus2(bool left, bool right) { return left || right; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) {
            output[0] = flag ? __vaddus2(input, 1u) : __vsubus4(input, 1u);
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            write(output, input[index++], __vaddus2(flag, false));
            output[1] = index;
            output[2] = __vaddus4(int(input[1]), -1);
            output[3] = __vsubus2(int(input[2]), -1);
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let arguments: &[&str] = if compact { &["--compact"] } else { &[] };
        let result = files.translate(arguments);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        let module = files.read_module();
        assert_eq!(module.entry_points.len(), 1);
        assert_eq!(
            module
                .global_variables
                .iter()
                .filter(|(_, global)| global.binding.is_some())
                .count(),
            3
        );
    }
}

#[test]
fn cuda_packed_unsigned_saturating_cli_rejects_invalid_calls_and_reserved_declarations() {
    for source in [
        "__device__ unsigned __vaddus2(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__device__ int __vaddus4(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ int __vsubus2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vsubus4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { __vaddus2(1u); }",
        "__global__ void kernel() { __vsubus4(1u, 2u, 3u); }",
        "__global__ void kernel(unsigned *pointer) { __vaddus4(pointer, 1u); }",
        "__global__ void kernel() { __vsubus2(uint2(1u), 2u); }",
        "__global__ void kernel() { unsigned __vaddus2 = 1u; __vaddus2(1u, 2u); }",
        "__global__ void kernel() { static_assert(__vaddus2(1u, 2u) == 3u); }",
        "__global__ void kernel() { static_assert(__vsubus4(0u, 0x01010101u) == 0u); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}
