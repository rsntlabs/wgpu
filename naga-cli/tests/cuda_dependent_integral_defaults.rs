mod common;
use common::TestFiles;

#[test]
fn cuda_dependent_integral_defaults_cli_completes_mixed_kernel_defaults_and_freezes_names() {
    let source = r#"constexpr int Initial = 6;
        template<int N = Initial, unsigned M = N, int Last = M> __device__ unsigned chain() { return unsigned(Last); }
        template<int N, int M> __device__ int renamed() { return M; }
        template<int First, int Copy = First> __device__ int renamed();
        template<int N, bool B = N> __device__ unsigned flag() { return unsigned(B); }
        template<int N, unsigned M = N> __device__ unsigned override_value() { return M; }
        template<unsigned long long N = 65535ULL, unsigned M = N> __device__ unsigned wide() { return M; }
        template<class T = unsigned, int N = 4, int M = N> __global__ void kernel(T *output, T value) {
            constexpr int Initial = 99;
            output[threadIdx.x] = value + chain<>() + chain<6,6u,6>() + unsigned(renamed<8>()) + flag<1>() + override_value<-1,7u>() + wide() + unsigned(M);
        }
        template __global__ void kernel<>(unsigned *, unsigned);"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
        let mut arguments = vec![
            "--entry-point",
            "kernel<unsigned,4,4>",
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
                .filter(|(_, f)| f
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("chain")))
                .count(),
            1
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
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    }
                );
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected output array");
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
                    panic!("expected scalar uniform block");
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
fn cuda_dependent_integral_defaults_cli_rejects_unavailable_and_invalid_conversions() {
    for source in [
        "template<int N, unsigned M = N> __device__ unsigned f() { return M; } __global__ void kernel(unsigned *out) { out[0] = f<-1>(); }",
        "template<int N, bool B = N> __device__ unsigned f() { return unsigned(B); } __global__ void kernel(unsigned *out) { out[0] = f<2>(); }",
        "template<unsigned N, unsigned short M = N> __device__ unsigned f() { return unsigned(M); } __global__ void kernel(unsigned *out) { out[0] = f<65536u>(); }",
        "template<int N, int M = N> __device__ int f() { return M; } __global__ void kernel(int *out) { out[0] = f(); }",
        "template<int N, int M> __device__ int f() { return M; } template<int K> __device__ int early() { return f<7>(); } template<int A, int B = A> __device__ int f(); __global__ void kernel(int *out) { out[0] = early<1>(); }",
        "template<int N, int M = (N + 1)> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<int N, int M = N> __global__ void kernel(int *out) { out[0] = M; } template __global__ void kernel<4>(int *); template __global__ void kernel<4,4>(int *);",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpected acceptance: {source}");
    }
}
