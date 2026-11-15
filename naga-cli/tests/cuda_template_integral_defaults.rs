mod common;

use common::TestFiles;

#[test]
fn cuda_template_integral_defaults_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"#define DefaultBias 3
        constexpr int N = 4;
        template<int N = N> __device__ unsigned constant();
        template<int Renamed> __device__ unsigned constant() { return unsigned(Renamed); }
        template<class Result = unsigned, int Bias = DefaultBias> __device__ Result adjust(Result value) { return value + Result(Bias); }
        __device__ int runtime() { return 2; }
        template<bool Enabled = (true || threadIdx.x), bool Disabled = (false && gridDim.x), int Count = (true ? 1 : runtime())> __device__ unsigned skipped() { return Enabled && !Disabled ? unsigned(Count) : 0u; }
        template<class Value = unsigned, int Bias = (1 << 2)> __global__ void kernel(Value *output, Value value) {
            output[threadIdx.x] = constant<>() + constant<4>() + adjust(value) + skipped<>() + unsigned(Bias);
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
            "kernel<unsigned,4>",
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
fn cuda_template_integral_defaults_cli_supports_overloads_and_supplied_pointer_reference_prefixes()
{
    let source = r#"constexpr unsigned Bias = 3u;
        template<unsigned Amount = Bias> __device__ void write(unsigned *output, const unsigned &input) { output[0] = input + Amount; }
        template<int Amount = int(2.0f), bool Enabled = bool(2)> __device__ unsigned converted(unsigned value) { return Enabled ? value + unsigned(Amount) : value; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            constexpr unsigned Bias = 9u;
            unsigned index = 0u;
            write<>(output, input[index++]);
            output[1] = index;
            output[2] = converted<>(value);
            output[3] = converted<2, true>(value);
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
fn cuda_template_integral_defaults_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "template<bool Enabled = 2> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = 1.0f> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<unsigned N = -1> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<short N = 32768> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int Earlier, int N = (false ? Earlier : 3)> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class Earlier, int N = sizeof(Earlier)> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = 2> __device__ unsigned helper(); template<int N = 3> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = 3> __device__ unsigned helper(); template<int N = 3> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = threadIdx.x> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T> __device__ int runtime() { return 1; } template<int N = (true ? 3 : runtime<int>())> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<int N = 3> __global__ void kernel(unsigned *output) { output[0] = N; } template __global__ void kernel<>(unsigned *); template __global__ void kernel<3>(unsigned *);",
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
