mod common;

use common::TestFiles;

#[test]
fn cuda_packed_less_equal_cli_translates_boundaries_and_runtime_values_to_all_backends() {
    let source = r#"__device__ unsigned __vcmples2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vcmples4(unsigned left, unsigned right);
        __device__ unsigned __vcmpleu2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vcmpleu4(unsigned left, unsigned right);
        __device__ unsigned __vsetles2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vsetles4(unsigned left, unsigned right);
        __device__ unsigned __vsetleu2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vsetleu4(unsigned left, unsigned right);
        __device__ unsigned kind(unsigned value) { return value; }
        __device__ int kind(int value) { return value; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = kind(__vcmples2(input[0], value));
            output[1] = kind(__vcmples4(input[1], value));
            output[2] = kind(__vcmpleu2(input[2], value));
            output[3] = kind(__vcmpleu4(input[3], value));
            output[4] = kind(__vsetles2(input[0], value));
            output[5] = kind(__vsetles4(input[1], value));
            output[6] = kind(__vsetleu2(input[2], value));
            output[7] = kind(__vsetleu4(input[3], value));
            output[8] = __vcmples2(0x80008000u, 0x7fff7fffu);
            output[9] = __vcmpleu2(0x80008000u, 0x7fff7fffu);
            output[10] = __vsetles4(0x80808080u, 0x7f7f7f7fu);
            output[11] = __vsetleu4(0x80808080u, 0x7f7f7f7fu);
            output[12] = __vcmples4(0xffffffffu, 0u);
            output[13] = __vcmpleu4(0xffffffffu, 0u);
            output[14] = __vsetles2(0xffffffffu, 0u);
            output[15] = __vsetleu2(0xffffffffu, 0u);
            output[16] = __vcmples2(0x80007fffu, 0x80007fffu);
            output[17] = __vsetleu4(0x80ff007fu, 0x80ff007fu);
            output[18] = __vsetles2(0x80007fffu, 0x7fff8000u);
            output[19] = __vsetleu2(0x80007fffu, 0x7fff8000u);
            output[20] = __vcmples4(0x80ff007fu, 0x7f000180u);
            output[21] = __vcmpleu4(0x80ff007fu, 0x7f000180u);
            output[22] = __vsetles4(0x7f000180u, 0x80ff007fu);
            output[23] = __vsetleu4(0x7f000180u, 0x80ff007fu);
            output[24] = __vcmples4(0x00ff017fu, 0x00ff017fu);
            output[25] = __vsetles4(0x00ff017fu, 0x00ff017fu);
            output[26] = __vcmpleu2(0u, 0u);
            output[27] = __vsetleu2(0u, 0u);
            output[28] = __vcmples4(0x80020304u, 0x80030203u);
            output[29] = __vsetles4(0x80020304u, 0x80030203u);
            output[30] = __vcmpleu4(0x80020304u, 0x80030203u);
            output[31] = __vsetleu4(0x80020304u, 0x80030203u);
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
fn cuda_packed_less_equal_cli_preserves_user_overloads_and_captured_argument_effects() {
    let source = r#"__device__ bool __vcmples2(bool left, bool right) { return left || right; }
        __device__ int __vcmpleu4(int left, int right) { return left + right; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) {
            output[0] = flag ? __vcmples2(input, 1u) : __vcmpleu4(input, 1u);
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            write(output, input[index++], __vcmples2(flag, false));
            output[1] = index;
            output[2] = __vcmples4(int(input[1]), -1);
            output[3] = __vcmpleu2(int(input[2]), -1);
            output[4] = unsigned(__vcmpleu4(int(input[2]), -1));
            output[5] = __vcmpleu4(input[2], 1u);
            output[6] = __vsetles2(int(input[1]), -1);
            output[7] = __vsetles4(input[1], 1u);
            output[8] = __vsetleu2(input[2], 1u);
            output[9] = __vsetleu4(input[2], 1u);
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
fn cuda_packed_less_equal_cli_rejects_invalid_calls_and_reserved_declarations() {
    for source in [
        "__device__ unsigned __vcmples2(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__device__ int __vcmples4(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ int __vcmpleu2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vcmpleu4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { __vcmples2(1u); }",
        "__global__ void kernel() { __vcmpleu4(1u, 2u, 3u); }",
        "__global__ void kernel(unsigned *pointer) { __vcmples4(pointer, 1u); }",
        "__global__ void kernel() { __vcmpleu2(uint2(1u), 2u); }",
        "__global__ void kernel() { unsigned __vcmples2 = 1u; __vcmples2(1u, 2u); }",
        "__global__ void kernel() { static_assert(__vcmples2(0xffffffffu, 0u) == 0xffffffffu); }",
        "__global__ void kernel() { static_assert(__vcmpleu4(0xffffffffu, 0xffffffffu) == 0xffffffffu); }",
        "__device__ int __vsetles2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vsetleu4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { static_assert(__vsetles4(0xffffffffu, 0xffffffffu) == 0x01010101u); }",
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
