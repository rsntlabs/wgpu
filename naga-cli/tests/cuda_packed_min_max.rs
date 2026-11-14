mod common;

use common::TestFiles;

#[test]
fn cuda_packed_min_max_cli_translates_boundaries_and_runtime_values_to_all_backends() {
    let source = r#"__device__ unsigned __vmins2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vmins4(unsigned left, unsigned right);
        __device__ unsigned __vminu2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vminu4(unsigned left, unsigned right);
        __device__ unsigned __vmaxs2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vmaxs4(unsigned left, unsigned right);
        __device__ unsigned __vmaxu2(unsigned left, unsigned right);
        __host__ __device__ unsigned __vmaxu4(unsigned left, unsigned right);
        __device__ unsigned kind(unsigned value) { return value; }
        __device__ int kind(int value) { return value; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = kind(__vmins2(input[0], value));
            output[1] = kind(__vmins4(input[1], value));
            output[2] = kind(__vminu2(input[2], value));
            output[3] = kind(__vminu4(input[3], value));
            output[4] = kind(__vmaxs2(input[0], value));
            output[5] = kind(__vmaxs4(input[1], value));
            output[6] = kind(__vmaxu2(input[2], value));
            output[7] = kind(__vmaxu4(input[3], value));
            output[8] = __vmins2(0x80008000u, 0x7fff7fffu);
            output[9] = __vmaxs2(0x80008000u, 0x7fff7fffu);
            output[10] = __vminu2(0x80008000u, 0x7fff7fffu);
            output[11] = __vmaxu2(0x80008000u, 0x7fff7fffu);
            output[12] = __vmins4(0xffffffffu, 0u);
            output[13] = __vmaxs4(0xffffffffu, 0x01010101u);
            output[14] = __vminu4(0xffffffffu, 0u);
            output[15] = __vmaxu4(0xffffffffu, 0x01010101u);
            output[16] = __vmins2(0x7fff7fffu, 0x80008000u);
            output[17] = __vmaxs4(0x807fff01u, 0x807fff01u);
            output[18] = __vminu4(0xff000180u, 0x0080ff01u);
            output[19] = __vmaxu4(0xff000180u, 0x0080ff01u);
            output[20] = __vmins4(0x7f8001ffu, 0x807fff01u);
            output[21] = __vmaxs4(0x7f8001ffu, 0x807fff01u);
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
fn cuda_packed_min_max_cli_preserves_user_overloads_and_captured_argument_effects() {
    let source = r#"__device__ bool __vmins2(bool left, bool right) { return left || right; }
        __device__ int __vminu4(int left, int right) { return left + right; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) {
            output[0] = flag ? __vmins2(input, 1u) : __vminu4(input, 1u);
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            write(output, input[index++], __vmins2(flag, false));
            output[1] = index;
            output[2] = __vmins4(int(input[1]), -1);
            output[3] = __vminu2(int(input[2]), -1);
            output[4] = unsigned(__vminu4(int(input[2]), -1));
            output[5] = __vminu4(input[2], 1u);
            output[6] = __vmaxs2(int(input[1]), -1);
            output[7] = __vmaxs4(input[1], 1u);
            output[8] = __vmaxu2(input[2], 1u);
            output[9] = __vmaxu4(input[2], 1u);
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
fn cuda_packed_min_max_cli_rejects_invalid_calls_and_reserved_declarations() {
    for source in [
        "__device__ unsigned __vmins2(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__device__ int __vmins4(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ int __vminu2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vminu4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { __vmins2(1u); }",
        "__global__ void kernel() { __vminu4(1u, 2u, 3u); }",
        "__global__ void kernel(unsigned *pointer) { __vmins4(pointer, 1u); }",
        "__global__ void kernel() { __vminu2(uint2(1u), 2u); }",
        "__global__ void kernel() { unsigned __vmins2 = 1u; __vmins2(1u, 2u); }",
        "__global__ void kernel() { static_assert(__vmins2(0xffffffffu, 0u) == 0xffffffffu); }",
        "__global__ void kernel() { static_assert(__vminu4(0xffffffffu, 0xffffffffu) == 0xffffffffu); }",
        "__device__ int __vmaxs2(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ unsigned __vmaxu4(unsigned a, unsigned b) { return a; } __global__ void kernel() {}",
        "__global__ void kernel() { static_assert(__vmaxs4(0xffffffffu, 0u) == 0u); }",
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
