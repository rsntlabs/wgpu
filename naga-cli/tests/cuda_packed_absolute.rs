mod common;

use common::TestFiles;

#[test]
fn cuda_packed_absolute_cli_translates_boundaries_and_runtime_values_to_all_backends() {
    let source = r#"__device__ unsigned __vabs2(unsigned value);
        __host__ __device__ unsigned __vabs4(unsigned value);
        __device__ unsigned __vabsss2(unsigned value);
        __host__ __device__ unsigned __vabsss4(unsigned value);
        __device__ unsigned kind(unsigned value) { return value; }
        __device__ int kind(int value) { return value; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = kind(__vabs2(input[0] + value));
            output[1] = kind(__vabs4(input[1] + value));
            output[2] = kind(__vabsss2(input[2] + value));
            output[3] = kind(__vabsss4(input[3] + value));
            output[4] = __vabs2(0x80008000u);
            output[5] = __vabs4(0x80808080u);
            output[6] = __vabsss2(0x80008000u);
            output[7] = __vabsss4(0x80808080u);
            output[8] = __vabs2(0x7fffffffu);
            output[9] = __vabs4(0x7ffffd00u);
            output[10] = __vabsss2(0x80007fffu);
            output[11] = __vabsss4(0x807ffd00u);
            output[12] = __vabs2(0u);
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
        assert_eq!(unsigned_results, 4);
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
fn cuda_packed_absolute_cli_preserves_user_overloads_and_captured_argument_effects() {
    let source = r#"__device__ bool __vabs2(bool value) { return !value; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) {
            output[0] = flag ? __vabs2(input) : __vabsss4(input);
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            write(output, input[index++], __vabs2(flag));
            output[1] = index;
            output[2] = __vabs4(int(input[1]));
            output[3] = __vabsss2(int(input[2]));
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
fn cuda_packed_absolute_cli_rejects_invalid_calls_and_reserved_declarations() {
    for source in [
        "__device__ unsigned __vabs2(unsigned value) { return value; } __global__ void kernel() {}",
        "__device__ int __vabs4(unsigned value); __global__ void kernel() {}",
        "__device__ int __vabsss2(unsigned value); __global__ void kernel() {}",
        "__device__ unsigned __vabsss4(unsigned value) { return value; } __global__ void kernel() {}",
        "__global__ void kernel() { __vabs2(); }",
        "__global__ void kernel() { __vabsss4(1u, 2u); }",
        "__global__ void kernel(unsigned *pointer) { __vabs4(pointer); }",
        "__global__ void kernel() { __vabsss2(uint2(1u)); }",
        "__global__ void kernel() { unsigned __vabs2 = 1u; __vabs2(1u); }",
        "__global__ void kernel() { static_assert(__vabs2(0x80008000u) == 0x80008000u); }",
        "__global__ void kernel() { static_assert(__vabsss4(0x80808080u) == 0x7f7f7f7fu); }",
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
