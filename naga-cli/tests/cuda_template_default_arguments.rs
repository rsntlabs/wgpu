mod common;

use common::TestFiles;

#[test]
fn cuda_template_default_arguments_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"template<class T> __device__ unsigned adjust(T value, unsigned bias = 3u);
        template<class T> __device__ unsigned adjust(T renamed, unsigned delta) { return unsigned(renamed) + delta; }
        __global__ void kernel(unsigned *output, unsigned value) {
            output[threadIdx.x] = adjust(value) + adjust(value, 11u) + adjust<float>(1.0f);
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
        let function = &module.entry_points[0].function;
        let mut right_defaults = Vec::new();

        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call {
                function: callee,
                arguments,
                ..
            } = statement
            {
                if module.functions[*callee]
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("adjust"))
                {
                    assert_eq!(arguments.len(), 2);
                    let naga::Expression::Literal(naga::Literal::U32(right)) =
                        function.expressions[arguments[1]]
                    else {
                        panic!("expected constant right argument");
                    };
                    right_defaults.push(right);
                }
            }
            false
        });
        assert_eq!(right_defaults, [3, 11, 3]);
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
fn cuda_template_default_arguments_cli_supports_overloads_and_supplied_pointer_reference_prefixes()
{
    let source = r#"template<class T> __device__ unsigned choose(T value, int bias = 3) { return unsigned(value) + unsigned(bias); }
        __device__ unsigned choose(unsigned value) { return value + 7u; }
        template<class T> __device__ void write(unsigned *output, const T &input, unsigned offset = 1u, bool increment = true) {
            output[offset] = choose(input, increment ? 1 : 0);
        }
        __global__ void kernel(unsigned *output, const unsigned *input) {
            unsigned index = 0u;
            write(output, input[index++]);
            write(output, input[index++], 2u, false);
            output[3] = choose(input[2]);
            output[4] = choose<unsigned>(input[2]);
            output[5] = index;
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
            2
        );
    }
}

#[test]
fn cuda_template_default_arguments_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "template<class T> __device__ T helper(T value = 1) { return value; } __global__ void kernel() {}",
        "template<class T> __device__ int helper(T value, int bias = sizeof(T)) { return bias; } __global__ void kernel() {}",
        "template<int Bias> __device__ int helper(int value, int bias = Bias) { return bias; } __global__ void kernel() {}",
        "template<class T> __global__ void kernel(T value, int bias = 3) {} template __global__ void kernel<unsigned>(unsigned, int);",
        "template<class T> __device__ int helper(T value, int bias); template<class T> __device__ int helper(T value, int bias = 3) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int helper(T value, int bias = 3); template<class T> __device__ int helper(T value, int bias = 3) { return bias; } __global__ void kernel() {}",
        "template<class T> __device__ int helper(int value = 3) { return value; } __global__ void kernel() { helper<>(); }",
        "template<class T> __device__ int helper(T value, int2 bias = int2(1)) { return bias.x; } __global__ void kernel() {}",
        "template<class T> __device__ int helper(T value, int bias = 3) { return bias; } template<class T> __device__ int helper(T value, float bias = 4.0f) { return int(bias); } __global__ void kernel() { helper(1); }",
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
