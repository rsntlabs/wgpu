mod common;

use common::TestFiles;

#[test]
fn cuda_template_default_type_queries_cli_freezes_parameter_types_across_renaming() {
    let source = r#"struct Record { unsigned member; };
        template<class T> __device__ unsigned measure(T value, int fixed, const int &reference, const unsigned *pointer, unsigned array[3], Record record,
            unsigned width = unsigned(sizeof(fixed) + sizeof(reference) + sizeof(pointer) + sizeof(array) + sizeof(record.member)));
        template<class T> __device__ unsigned measure(T renamed, int integer, const int &ref, const unsigned *ptr, unsigned adjusted[3], Record item, unsigned bytes) {
            return unsigned(renamed) + bytes;
        }
        __global__ void kernel(unsigned *output, const unsigned *input, unsigned value) {
            int fixed = 1;
            Record record;
            record.member = 7u;
            output[threadIdx.x] = measure(value, fixed, fixed, input, output, record) + input[0];
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
        let defaults = module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
            .flat_map(|function| function.expressions.iter())
            .filter(|(_, expression)| {
                matches!(
                    expression,
                    naga::Expression::Literal(naga::Literal::U32(28))
                )
            })
            .count();
        assert!(
            defaults > 0,
            "queried default must fold to a U32 value of 28"
        );
        let mut bindings: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| global.binding.map(|binding| binding.binding))
            .collect();
        bindings.sort();
        assert_eq!(bindings, [0, 1, 2]);
    }
}

#[test]
fn cuda_template_default_type_queries_cli_keeps_bool_reference_capture_and_argument_effects() {
    let source = r#"template<class T> __device__ unsigned score(T value, const unsigned &input, bool flag,
            unsigned bytes = unsigned(sizeof(input) + sizeof(flag))) {
            return flag ? unsigned(value) + input + bytes : bytes;
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned index = 0u;
            output[0] = score(2u, input[index++], flag);
            output[1] = index;
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
fn cuda_template_default_type_queries_cli_rejects_value_uses_and_dependent_queries() {
    for source in [
        "template<class T> __device__ unsigned helper(T value, int fixed, unsigned width = unsigned(sizeof(fixed)) + unsigned(fixed)) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T value, int fixed, unsigned width = ((void)fixed, 4u)) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T value, int fixed, unsigned width = true ? 4u : unsigned(fixed)) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T value, unsigned width = unsigned(sizeof(value))) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T *value, unsigned width = unsigned(sizeof(value))) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T value, unsigned width = unsigned(sizeof(T*))) { return width; } __global__ void kernel() {}",
        "using Name = unsigned; template<class T> __device__ unsigned helper(T value, int Name, unsigned width = unsigned(sizeof(Name*))) { return width; } __global__ void kernel() {}",
        "const unsigned Name = 4u; template<class T> __device__ unsigned helper(T value, int Name, unsigned width = Name) { return width; } __global__ void kernel() {}",
        "template<class T> __device__ unsigned helper(T value, int fixed, unsigned width = unsigned(fixed(1))) { return width; } __global__ void kernel() {}",
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
