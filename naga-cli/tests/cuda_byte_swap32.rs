mod common;

use common::TestFiles;

#[test]
fn cuda_byte_swap32_cli_preserves_result_signedness_and_typed_bindings() {
    let source = r#"__host__ __device__ unsigned __nv_bswap32(unsigned value);
        __device__ int kind(int value) { return value; }
        __device__ unsigned kind(unsigned value) { return value; }
        template<class Value> __global__ void swap(unsigned *output, const Value *input) {
            unsigned index = threadIdx.x;
            output[index] = kind(__nv_bswap32(input[index]));
        }
        template __global__ void swap<int>(unsigned *, const int *);
        template __global__ void swap<unsigned>(unsigned *, const unsigned *);"#;
    for (entry, input_scalar) in [
        ("swap<int>", naga::Scalar::I32),
        ("swap<unsigned>", naga::Scalar::U32),
    ] {
        for compact in [false, true] {
            let files = TestFiles::new("cu", source);
            let mut arguments = vec!["--entry-point", entry, "--cuda-workgroup-size", "4,1,1"];
            if compact {
                arguments.push("--compact");
            }
            let result = files.translate(&arguments);
            assert!(
                result.status.success(),
                "{}",
                String::from_utf8_lossy(&result.stderr)
            );
            let module = files.read_module();
            assert_eq!(module.entry_points.len(), 1);
            assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
            let mut resources: Vec<_> = module
                .global_variables
                .iter()
                .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
                .collect();
            resources.sort_by_key(|(binding, _)| binding.binding);
            assert_eq!(resources.len(), 2);
            for (index, (binding, global)) in resources.into_iter().enumerate() {
                assert_eq!(
                    binding,
                    naga::ResourceBinding {
                        group: 0,
                        binding: index as u32
                    }
                );
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected storage array");
                };
                assert_eq!(stride, 4);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar([naga::Scalar::U32, input_scalar][index])
                );
                if index == 1 {
                    assert_eq!(
                        global.space,
                        naga::AddressSpace::Storage {
                            access: naga::StorageAccess::LOAD
                        }
                    );
                }
            }
            assert!(module
                .types
                .iter()
                .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
            let mut signed_calls = 0;
            let mut unsigned_calls = 0;
            for function in module
                .functions
                .iter()
                .map(|(_, function)| function)
                .chain(module.entry_points.iter().map(|entry| &entry.function))
            {
                naga::proc::any_statement(&function.body, &mut |statement| {
                    if let naga::Statement::Call { function, .. } = *statement {
                        let callee = &module.functions[function];
                        if callee
                            .name
                            .as_deref()
                            .is_some_and(|name| name.starts_with("kind"))
                        {
                            match module.types[callee.arguments[0].ty].inner {
                                naga::TypeInner::Scalar(naga::Scalar::I32) => signed_calls += 1,
                                naga::TypeInner::Scalar(naga::Scalar::U32) => unsigned_calls += 1,
                                ref ty => panic!("unexpected result type {ty:?}"),
                            }
                        }
                    }
                    false
                });
            }
            assert_eq!((signed_calls, unsigned_calls), (0, 1));
        }
    }
}

#[test]
fn cuda_byte_swap32_cli_resolves_scalar_user_overloads() {
    let files = TestFiles::new(
        "cu",
        r#"__device__ float __nv_bswap32(float value) { return value + 1.0f; }
        __device__ int __nv_bswap32(int value) { return value + 7; }
        __global__ void kernel(float *output, const float *input) {
            output[0] = __nv_bswap32(input[0]);
            output[1] = float(__nv_bswap32(3));
        }"#,
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    files.read_module();
}

#[test]
fn cuda_byte_swap32_cli_rejects_invalid_calls_and_reserved_signatures() {
    for source in [
        "__device__ unsigned __nv_bswap32(unsigned value) { return value; } __global__ void kernel() {}",
        "__device__ int __nv_bswap32(unsigned value); __global__ void kernel() {}",
        "__global__ void kernel() { __nv_bswap32(); }",
        "__global__ void kernel() { __nv_bswap32(1u, 2u); }",
        "__global__ void kernel(unsigned *pointer) { __nv_bswap32(pointer); }",
        "__global__ void kernel() { __nv_bswap32(uint2(1u)); }",
        "__global__ void kernel() { static_assert(__nv_bswap32(1u) == 0x01000000u); }",
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
