mod common;

use common::TestFiles;

#[test]
fn cuda_dependent_type_defaults_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"namespace N = cooperative_groups;
        template<int N = 1, class U = N::thread_block> __device__ unsigned namespace_value() { return unsigned(N); }
        template<class T = unsigned, class U, class V> __device__ unsigned constant();
        template<class T, class U = const T, class V> __device__ unsigned constant();
        template<class First, class Second, class Third> __device__ unsigned constant() { Third value = Third(7); return unsigned(value); }
        template<class T, class U, class V = U> __device__ unsigned constant();
        template<class T = float, class U = T> __device__ unsigned deduced(T value) { U copy = value; return unsigned(copy); }
        template<class KernelType = unsigned, class KernelCopy = KernelType> __global__ void kernel(KernelCopy *output, KernelType value) {
            output[threadIdx.x] = constant<>() + constant<unsigned, const unsigned, const unsigned>() + deduced(value) + namespace_value<>();
        }
        template __global__ void kernel<unsigned>(unsigned *, unsigned);"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
        let mut arguments = vec![
            "--entry-point",
            "kernel<unsigned,unsigned>",
            "--cuda-workgroup-size",
            "4,1,1",
        ];
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
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
        assert_eq!(
            module
                .functions
                .iter()
                .filter(|(_, function)| function
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("constant")))
                .count(),
            1,
            "default and explicit type arguments must share an instance"
        );
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
                    panic!("expected output storage array");
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
    }
}

#[test]
fn cuda_dependent_type_defaults_cli_supports_overloads_and_supplied_pointer_reference_prefixes() {
    let source = r#"struct Record { unsigned value; };
        template<class T, class U = T> __device__ unsigned read(const T &input) { U copy = input; return copy.value; }
        template<class T, class U = const T> __device__ unsigned pointer(T input) { U copy = input; return copy[0]; }
        template<class T, class U = const T> __device__ void mutable_pointer(T input) { U copy = input; copy[5] = 9u; }
        template<class T, class U = T> __device__ unsigned null_value(T input) { U copy = input; return copy == nullptr ? 1u : 0u; }
        template<class T, class U = T> __device__ unsigned lane(T input) { U copy = input; return unsigned(copy.x); }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            Record records[2];
            records[0].value = value;
            unsigned index = 0u;
            output[0] = read(records[index++]);
            output[1] = index;
            output[2] = pointer(input);
            output[3] = lane(uint1(3u)) + lane(float3(4.0f, 5.0f, 6.0f)) + lane(dim3(2u, 3u, 4u));
            output[4] = null_value(nullptr);
            mutable_pointer(output);
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
fn cuda_dependent_type_defaults_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "template<class T, class U = T*> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T, class U = T&> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T, class U = T[2]> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T, class U = T::member> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "namespace T = cooperative_groups; template<class T, class U = T::thread_block> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T, int N = sizeof(T)> __device__ unsigned helper() { return N; } __global__ void kernel() {}",
        "template<class T, class U = T> __device__ unsigned helper(U value) { return 1u; } __global__ void kernel() { helper(1u); }",
        "template<class T, class U> __device__ unsigned helper() { return 1u; } __device__ unsigned before() { return helper<unsigned>(); } template<class T, class U = T> __device__ unsigned helper(); __global__ void kernel() {}",
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
