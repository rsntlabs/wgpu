mod common;

use common::TestFiles;

#[test]
fn cuda_default_arguments_cli_merges_declarations_and_preserves_backend_interfaces() {
    let source = r#"__device__ unsigned merged(unsigned left, unsigned right = 5u);
        __device__ unsigned merged(unsigned left = 3u, unsigned right);
        __device__ unsigned merged(unsigned left, unsigned right) { return left + right; }
        __global__ void kernel(unsigned *output, unsigned value) {
            output[threadIdx.x] = merged() + merged(value) + merged(value, 11u);
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
        let mut all_default_calls = 0;
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
                    .is_some_and(|name| name.starts_with("merged"))
                {
                    assert_eq!(arguments.len(), 2);
                    let naga::Expression::Literal(naga::Literal::U32(right)) =
                        function.expressions[arguments[1]]
                    else {
                        panic!("expected constant right argument");
                    };
                    right_defaults.push(right);
                    if matches!(
                        function.expressions[arguments[0]],
                        naga::Expression::Literal(naga::Literal::U32(3))
                    ) {
                        all_default_calls += 1;
                    }
                }
            }
            false
        });
        assert_eq!(right_defaults, [5, 5, 11]);
        assert_eq!(all_default_calls, 1);
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
fn cuda_default_arguments_cli_supports_overloads_and_supplied_pointer_reference_prefixes() {
    let source = r#"__device__ unsigned choose(unsigned value, bool increment = true) { return increment ? value + 1u : value; }
        __device__ float choose(float value, bool increment = false) { return increment ? value + 1.0f : value; }
        __device__ void write(unsigned *output, const unsigned &input, unsigned offset = 1u, bool increment = true) {
            output[offset] = choose(input, increment);
        }
        __global__ void kernel(unsigned *output, const unsigned *input) {
            write(output, input[0]);
            write(output, input[1], 2u, false);
            output[3] = choose(input[2]);
            output[4] = unsigned(choose(7.0f));
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
fn cuda_default_arguments_cli_rejects_invalid_defaults_without_output() {
    for source in [
        "__device__ int helper(int value = 1); __device__ int helper(int value = 2) { return value; } __global__ void kernel() {}",
        "__device__ int helper(int left = 1, int right) { return left + right; } __global__ void kernel() {}",
        "__device__ int helper(int left, int right = left) { return right; } __global__ void kernel() {}",
        "__global__ void kernel(unsigned value = 1u) {}",
        "__device__ unsigned __byte_perm(unsigned a, unsigned b, unsigned c = 0u); __global__ void kernel() {}",
        "template<class Value> __device__ Value helper(Value value = Value(1)) { return value; } __global__ void kernel() {}",
        "__device__ int helper(int *pointer = 0) { return 0; } __global__ void kernel() {}",
        "__device__ int helper(int2 value = int2(1)) { return value.x; } __global__ void kernel() {}",
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
