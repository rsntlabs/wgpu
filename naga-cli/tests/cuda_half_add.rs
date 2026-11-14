mod common;

use common::TestFiles;

#[test]
fn cuda_half_add_cli_preserves_result_signedness_and_typed_bindings() {
    let source = r#"__device__ int __hadd(int left, int right);
        __device__ unsigned __uhadd(unsigned left, unsigned right);
        __device__ int __rhadd(int left, int right);
        __device__ unsigned __urhadd(unsigned left, unsigned right);
        __device__ int kind(int value) { return value; }
        __device__ unsigned kind(unsigned value) { return value; }
        template<class Value> __global__ void half(int *signed_output, unsigned *unsigned_output, const Value *input) {
            unsigned index = threadIdx.x;
            signed_output[index] = kind(__hadd(input[index * 2u], input[index * 2u + 1u]));
            unsigned_output[index] = kind(__uhadd(input[index * 2u], input[index * 2u + 1u]));
            signed_output[index + 4u] = kind(__rhadd(input[index * 2u], input[index * 2u + 1u]));
            unsigned_output[index + 4u] = kind(__urhadd(input[index * 2u], input[index * 2u + 1u]));
        }
        template __global__ void half<int>(int *, unsigned *, const int *);
        template __global__ void half<unsigned>(int *, unsigned *, const unsigned *);"#;
    for (entry, input_scalar) in [
        ("half<int>", naga::Scalar::I32),
        ("half<unsigned>", naga::Scalar::U32),
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
            assert_eq!(resources.len(), 3);
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
                    naga::TypeInner::Scalar(
                        [naga::Scalar::I32, naga::Scalar::U32, input_scalar][index]
                    )
                );
                if index == 2 {
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
            assert_eq!((signed_calls, unsigned_calls), (2, 2));
        }
    }
}

#[test]
fn cuda_half_add_cli_resolves_scalar_user_overloads() {
    let files = TestFiles::new(
        "cu",
        r#"__device__ float __hadd(float left, float right) { return left + right; }
        __device__ float __uhadd(float left, float right) { return left - right; }
        __device__ float __rhadd(float left, float right) { return left + right; }
        __device__ float __urhadd(float left, float right) { return left - right; }
        __global__ void kernel(float *output, const float *input) {
            output[0] = __hadd(input[0], input[1]);
            output[1] = __uhadd(input[0], input[1]);
            output[2] = __rhadd(input[0], input[1]);
            output[3] = __urhadd(input[0], input[1]);
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
fn cuda_half_add_cli_rejects_invalid_calls_and_reserved_signatures() {
    for source in [
        "__device__ int __hadd(int a, int b) { return a; } __global__ void kernel() {}",
        "__device__ int __uhadd(unsigned a, unsigned b); __global__ void kernel() {}",
        "__device__ int __rhadd(int a, int b) { return a; } __global__ void kernel() {}",
        "__device__ int __urhadd(unsigned a, unsigned b); __global__ void kernel() {}",
        "__global__ void kernel() { __hadd(1); }",
        "__global__ void kernel() { __rhadd(1); }",
        "__global__ void kernel() { __uhadd(1u, 2u, 3u); }",
        "__global__ void kernel() { __urhadd(1u, 2u, 3u); }",
        "__global__ void kernel(unsigned *pointer) { __uhadd(pointer, 2u); }",
        "__global__ void kernel() { __hadd(int2(1), 2); }",
        "__global__ void kernel() { static_assert(__hadd(1, 2) == 1); }",
        "__global__ void kernel() { static_assert(__rhadd(1, 2) == 2); }",
        "__global__ void kernel() { static_assert(__uhadd(1u, 2u) == 1u); }",
        "__global__ void kernel() { static_assert(__urhadd(1u, 2u) == 2u); }",
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
