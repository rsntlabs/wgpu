mod common;

use common::TestFiles;

#[test]
fn cuda_template_type_defaults_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"using T = unsigned;
        using Word = unsigned;
        template<class T = T> __device__ T seeded(T value);
        template<class Renamed> __device__ Renamed seeded(Renamed value) { return value; }
        template<class Value = Word> __device__ Value constant() { return Value(7); }
        template<class Result = unsigned, class Input> __device__ Result convert(Input value) { return Result(value); }
        template<class Value = unsigned> __global__ void kernel(Value *output, Value value) {
            using Word = float;
            output[threadIdx.x] = seeded<>(value) + constant<>() + constant<unsigned>() + convert<>(value);
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
            "kernel<unsigned>",
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
fn cuda_template_type_defaults_cli_supports_overloads_and_supplied_pointer_reference_prefixes() {
    let source = r#"struct Record { unsigned value; };
        __device__ unsigned pick(unsigned value) { return 1u; }
        __device__ unsigned pick(float value) { return 2u; }
        template<class T = float> __device__ unsigned classify(T value) { return pick(value); }
        template<class T = Record> __device__ unsigned record_value() { T value; value.value = 3u; return value.value; }
        template<class T = uint1> __device__ unsigned vector_value() { T value = T(4u); return value.x; }
        template<class T = dim3> __device__ unsigned dimensions() { T value = T(1u, 2u, 3u); return value.z; }
        template<class T = const unsigned*> __device__ unsigned read(T input) { return input[0]; }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            output[0] = classify(value);
            output[1] = classify<>(1.0f);
            output[2] = record_value<>() + vector_value<>() + dimensions<>();
            output[3] = read<>(input);
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
fn cuda_template_type_defaults_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "template<class T = 3> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "using T = unsigned; template<class T, class U = T*> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T = void> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T = unsigned&> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "using Array = unsigned[2]; template<class T = Array> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T = float> __device__ unsigned helper(); template<class T = unsigned> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T = unsigned> __device__ unsigned helper(); template<class T = unsigned> __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "template<class T = unsigned> __device__ unsigned helper(int value) { return 1u; } template<class T = float> __device__ unsigned helper(float value) { return 2u; } __global__ void kernel() { helper<>(); }",
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
