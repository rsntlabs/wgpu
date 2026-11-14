mod common;

use common::TestFiles;

#[test]
fn cuda_dp2a_cli_preserves_result_signedness_and_typed_bindings() {
    let source = r#"__device__ int __dp2a_lo(int left, int right, int accumulator);
        __device__ unsigned __dp2a_lo(unsigned left, unsigned right, unsigned accumulator);
        __device__ int __dp2a_hi(int left, int right, int accumulator);
        __device__ unsigned __dp2a_hi(unsigned left, unsigned right, unsigned accumulator);
        __device__ int kind(int value) { return value; }
        __device__ unsigned kind(unsigned value) { return value; }
        template<class Value> __global__ void dot(Value *output, const Value *input) {
            unsigned index = threadIdx.x;
            output[index * 2u] = kind(__dp2a_lo(input[index * 3u], input[index * 3u + 1u], input[index * 3u + 2u]));
            output[index * 2u + 1u] = kind(__dp2a_hi(input[index * 3u], input[index * 3u + 1u], input[index * 3u + 2u]));
        }
        template __global__ void dot<int>(int *, const int *);
        template __global__ void dot<unsigned>(unsigned *, const unsigned *);"#;
    for (entry, input_scalar) in [
        ("dot<int>", naga::Scalar::I32),
        ("dot<unsigned>", naga::Scalar::U32),
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
                    naga::TypeInner::Scalar([input_scalar, input_scalar][index])
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
            assert_eq!(
                (signed_calls, unsigned_calls),
                if input_scalar == naga::Scalar::I32 {
                    (2, 0)
                } else {
                    (0, 2)
                }
            );
        }
    }
}

#[test]
fn cuda_dp2a_cli_resolves_scalar_user_overloads() {
    let files = TestFiles::new(
        "cu",
        r#"__device__ float __dp2a_lo(float left, float right, float selector) { return left + right + selector; }
        __device__ float __dp2a_hi(float left, float right, float selector) { return left - right + selector; }
        __global__ void kernel(float *output, const float *input) {
            output[0] = __dp2a_lo(input[0], input[1], input[2]);
            output[1] = __dp2a_hi(input[0], input[1], input[2]);
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
fn cuda_dp2a_cli_rejects_invalid_calls_and_reserved_signatures() {
    for source in [
        "__device__ int __dp2a_lo(int a, int b, int c) { return c; } __global__ void kernel() {}",
        "__device__ unsigned __dp2a_lo(unsigned a, unsigned b, unsigned c) { return c; } __global__ void kernel() {}",
        "__device__ unsigned __dp2a_lo(int a, int b, int c); __global__ void kernel() {}",
        "__device__ int __dp2a_lo(unsigned a, unsigned b, unsigned c); __global__ void kernel() {}",
        "__device__ int __dp2a_hi(int a, int b, int c) { return c; } __global__ void kernel() {}",
        "__device__ int __dp2a_hi(unsigned a, unsigned b, unsigned c); __global__ void kernel() {}",
        "__global__ void kernel() { __dp2a_lo(1, 2); }",
        "__global__ void kernel() { __dp2a_hi(1, 2); }",
        "__global__ void kernel() { __dp2a_lo(1u, 2u, 3u, 4u); }",
        "__global__ void kernel(unsigned *pointer) { __dp2a_lo(pointer, 2u, 3u); }",
        "__global__ void kernel() { __dp2a_lo(int4(1), int4(2), 3); }",
        "__global__ void kernel() { __dp2a_lo(1, 2, 3u); }",
        "__global__ void kernel() { __dp2a_hi(1, 2, 3u); }",
        "__global__ void kernel() { __dp2a_lo(1u, 2u, true); }",
        "__global__ void kernel() { __dp2a_hi(1u, 2u, true); }",
        "__global__ void kernel() { static_assert(__dp2a_lo(1, 2, 3) == 5); }",
        "__global__ void kernel() { static_assert(__dp2a_lo(1u, 2u, 3u) == 5u); }",
        "__global__ void kernel() { static_assert(__dp2a_hi(1, 2, 3) == 3); }",
        "__global__ void kernel() { static_assert(__dp2a_hi(1u, 2u, 3u) == 3u); }",
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
