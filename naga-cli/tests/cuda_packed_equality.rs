mod common;

use common::TestFiles;

#[test]
fn cuda_packed_equality_cli_translates_boundaries_and_runtime_values_to_all_backends() {
    let source = r#"__device__ unsigned __vcmpeq2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vcmpeq4(unsigned left, unsigned right);
        __device__ unsigned __vcmpne2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vcmpne4(unsigned left, unsigned right);
        __device__ unsigned __vseteq2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vseteq4(unsigned left, unsigned right);
        __device__ unsigned __vsetne2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vsetne4(unsigned left, unsigned right);
        __device__ unsigned kind(unsigned value) { return value; }
        __device__ int kind(int value) { return value; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = kind(__vcmpeq2(input[0], value));
            output[1] = kind(__vcmpeq4(input[1], value));
            output[2] = kind(__vcmpne2(input[2], value));
            output[3] = kind(__vcmpne4(input[3], value));
            output[4] = kind(__vseteq2(input[0], value));
            output[5] = kind(__vseteq4(input[1], value));
            output[6] = kind(__vsetne2(input[2], value));
            output[7] = kind(__vsetne4(input[3], value));
            output[8] = __vcmpeq4(0x12345678u, 0x12345678u);
            output[9] = __vseteq4(0x12345678u, 0x12345678u);
            output[10] = __vcmpne4(0x12345678u, 0x87654321u);
            output[11] = __vsetne4(0x12345678u, 0x87654321u);
            output[12] = __vseteq2(0x12345678u, 0x1234abcdu);
            output[13] = __vsetne2(0x12345678u, 0x1234abcdu);
            output[14] = __vcmpeq2(0x12345678u, 0xabcd5678u);
            output[15] = __vcmpne2(0x12345678u, 0xabcd5678u);
            output[16] = __vseteq4(0x80ff007fu, 0x8000017fu);
            output[17] = __vsetne4(0x80ff007fu, 0x8000017fu);
            output[18] = __vcmpeq4(0x8000017fu, 0x80ff007fu);
            output[19] = __vcmpne4(0x8000017fu, 0x80ff007fu);
            output[20] = __vseteq2(0u, 0xffffffffu);
            output[21] = __vsetne2(0xffffffffu, 0xffffffffu);
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
        let mut unsigned_results = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                let callee = &module.functions[function];
                if callee
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("kind"))
                {
                    assert_eq!(
                        module.types[callee.arguments[0].ty].inner,
                        naga::TypeInner::Scalar(naga::Scalar::U32)
                    );
                    unsigned_results += 1;
                }
            }
            false
        });
        assert_eq!(unsigned_results, 8);
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
fn cuda_packed_equality_cli_preserves_user_overloads_and_captured_argument_effects() {
    let source = r#"__device__ bool __vcmpeq2(bool left, bool right) { return left || right; }
        __device__ int __vcmpne4(int left, int right) { return left + right; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) {
            output[0] = flag ? __vcmpeq2(input, 1u) : __vcmpne4(input, 1u);
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            write(output, input[index++], __vcmpeq2(flag, false));
            output[1] = index;
            output[2] = __vcmpeq4(int(input[1]), -1);
            output[3] = __vcmpne2(int(input[2]), -1);
            output[4] = unsigned(__vcmpne4(int(input[2]), -1));
            output[5] = __vcmpne4(input[2], 1u);
            output[6] = __vseteq2(int(input[1]), -1);
            output[7] = __vseteq4(input[1], 1u);
            output[8] = __vsetne2(input[2], 1u);
            output[9] = __vsetne4(input[2], 1u);
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
fn cuda_packed_equality_cli_rejects_invalid_calls_and_reserved_declarations() {
    for source in [
        "__device__ unsigned __vcmpeq2(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__device__ int __vcmpeq4(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ int __vcmpne2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vcmpne4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { __vcmpeq2(1u); }",
        "__global__ void kernel() { __vcmpne4(1u, 2u, 3u); }",
        "__global__ void kernel(unsigned *pointer) { __vcmpeq4(pointer, 1u); }",
        "__global__ void kernel() { __vcmpne2(uint2(1u), 2u); }",
        "__global__ void kernel() { unsigned __vcmpeq2 = 1u; __vcmpeq2(1u, 2u); }",
        "__global__ void kernel() { static_assert(__vcmpeq2(0xffffffffu, 0u) == 0u); }",
        "__global__ void kernel() { static_assert(__vcmpne4(0xffffffffu, 0xffffffffu) == 0u); }",
        "__device__ int __vseteq2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vsetne4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { static_assert(__vseteq4(0xffffffffu, 0xffffffffu) == 0x01010101u); }",
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
