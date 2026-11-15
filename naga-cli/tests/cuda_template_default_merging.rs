mod common;

use common::TestFiles;

#[test]
fn cuda_template_default_merging_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"using Word = unsigned;
        constexpr int Bias = 3;
        template<class T, int N> __device__ unsigned constant();
        template<class T = Word, int N> __device__ unsigned constant();
        template<class Renamed, int Amount> __device__ unsigned constant() { return unsigned(Amount); }
        template<class T, int N = Bias> __device__ unsigned constant();
        template<class Value, int Amount> __global__ void kernel(Value *output, Value value) {
            using Word = float;
            constexpr int Bias = 9;
            output[threadIdx.x] = value + constant<>() + constant<unsigned, 3>();
        }
        template<class Value = Word, int Amount> __global__ void kernel(Value *, Value);
        template<class Value, int Amount = Bias> __global__ void kernel(Value *, Value);
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
            "kernel<unsigned,3>",
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
fn cuda_template_default_merging_cli_supports_overloads_and_supplied_pointer_reference_prefixes() {
    let source = r#"template<class T, unsigned Amount> __device__ void write(unsigned *output, const T &input) { output[0] = unsigned(input) + Amount; }
        template<class T = unsigned, unsigned Amount> __device__ void write(unsigned *, const T &);
        constexpr unsigned Offset = 3u;
        template<class T, unsigned Amount = Offset> __device__ void write(unsigned *, const T &);
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            unsigned index = 0u;
            write<>(output, input[index++]);
            output[1] = index;
            output[2] = value;
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
fn cuda_template_default_merging_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "template<class T> __device__ unsigned helper() { return 1u; } __device__ unsigned before() { return helper<>(); } template<class T = unsigned> __device__ unsigned helper(); __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper() { return 1u; } template<class U> __device__ unsigned before(U value) { return helper<>(); } template<class T = unsigned> __device__ unsigned helper(); __global__ void kernel(unsigned *output) { output[0] = before(1u); }",
        "template<class T = unsigned, int N> __device__ unsigned helper() { return N; } __device__ unsigned before() { return helper<>(); } template<class T, int N = 3> __device__ unsigned helper(); __global__ void kernel() {}",
        "template<class T = unsigned> __device__ unsigned helper(); template<class T = unsigned> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = 2> __device__ unsigned helper(); template<int N = 3> __device__ unsigned helper() { return N; } __global__ void kernel() {}",
        "template<class T = unsigned> __device__ unsigned helper(T value) { return 1u; } template<class T> __device__ unsigned helper(unsigned value, int bias) { return 2u; } __global__ void kernel() { helper<>(1u, 2); }",
        "template<class T, int N> __global__ void kernel(unsigned *output) { output[0] = N; } template __global__ void kernel<>(unsigned *); template<class T = unsigned, int N = 3> __global__ void kernel(unsigned *);",
        "template<class T, int N> __global__ void kernel(unsigned *output) { output[0] = N; } template<class T = unsigned, int N = 3> __global__ void kernel(unsigned *); template __global__ void kernel<>(unsigned *); template __global__ void kernel<unsigned, 3>(unsigned *);",
        "template<class T> __device__ unsigned helper(T value, unsigned bias); template<class T> __device__ unsigned helper(T value, unsigned bias = 3u) { return bias; } __global__ void kernel() {}",
        "template<class T = unsigned> __device__ unsigned helper(float value) { return 1u; } template<class T = float> __device__ unsigned helper(unsigned value) { return 2u; } __global__ void kernel() { helper<>(1); }",
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
