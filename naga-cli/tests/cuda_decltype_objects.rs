mod common;

use common::TestFiles;

#[test]
fn cuda_decltype_objects_cli_translates_declared_value_types_to_all_backends() {
    let source = r#"constexpr unsigned Seed = 7u;
        struct Record { float3 position; unsigned tag; };
        __device__ decltype(Seed) initial() { return Seed; }
        __device__ unsigned helper(unsigned value, decltype(value) other) { return value + other; }
        __global__ void kernel(unsigned *output, unsigned value) {
            using Count = decltype(value);
            Count scalar = decltype(value)(value);
            uint1 single = uint1(2u);
            decltype(single) one = decltype(single)(3u);
            float3 vector = float3(1.0f, 2.0f, 3.0f);
            decltype(vector) three = decltype(vector)(4.0f, 5.0f, 6.0f);
            Record record;
            record.position = three;
            record.tag = initial();
            decltype(record) copied = record;
            dim3 dimensions = dim3(2u, 3u, 4u);
            decltype(dimensions) launch = dimensions;
            decltype(nullptr) absent = nullptr;
            output[threadIdx.x] = scalar + one.x + unsigned(copied.position.z) + copied.tag + launch.z + helper(value, 1u);
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
        let mut resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
            .collect();
        resources.sort_by_key(|(binding, _)| binding.binding);
        assert_eq!(resources.len(), 2);
        assert_eq!(
            resources[0].0,
            naga::ResourceBinding {
                group: 0,
                binding: 0
            }
        );
        let naga::TypeInner::Array { base, stride, .. } = module.types[resources[0].1.ty].inner
        else {
            panic!("expected storage array");
        };
        assert_eq!(stride, 4);
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        assert_eq!(
            resources[1].0,
            naga::ResourceBinding {
                group: 0,
                binding: 1
            }
        );
        assert_eq!(resources[1].1.space, naga::AddressSpace::Uniform);
        let naga::TypeInner::Struct { ref members, .. } = module.types[resources[1].1.ty].inner
        else {
            panic!("expected uniform block");
        };
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        assert_eq!(
            module.types[members[0].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    }
}

#[test]
fn cuda_decltype_objects_cli_preserves_const_and_new_reference_bindings_without_repeating_effects()
{
    let source = r#"__device__ unsigned kind(unsigned &value) { return 1u; }
        __device__ unsigned kind(const unsigned &value) { return 2u; }
        __device__ unsigned next(unsigned &counter) { counter++; return counter; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            unsigned value = next(counter);
            const unsigned fixed = 7u;
            decltype(fixed) preserved = 3u;
            decltype(value) &reference = value;
            using Value = decltype(value);
            Value copy = value;
            output[0] = kind(preserved);
            output[1] = kind(reference);
            output[2] = counter;
            output[3] = copy;
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
        files.read_module();
    }
}

#[test]
fn cuda_decltype_objects_cli_rejects_unsupported_operands_without_output() {
    for source in [
        "__device__ void helper(unsigned &value) { using Type = decltype(value); } __global__ void kernel() {}",
        "__global__ void kernel(unsigned *pointer) { using Type = decltype(pointer); }",
        "__global__ void kernel() { unsigned array[2]; using Type = decltype(array); }",
        "__global__ void kernel() { decltype(nullptr) value = nullptr; using Type = decltype(value); }",
        "__global__ void kernel() { auto block = cooperative_groups::this_thread_block(); using Type = decltype(block); }",
        "template<class T> __device__ void helper(T value, decltype(value) other) {} __global__ void kernel() {}",
        "__device__ unsigned helper(unsigned &value, decltype(value) other) { return other; } __global__ void kernel() {}",
        "__global__ void kernel() { unsigned value = 1u; using Type = decltype((value)); }",
        "__device__ unsigned helper() { return 1u; } __global__ void kernel() { using Type = decltype(helper()); }",
        "__global__ void kernel() { unsigned value = 1u; using Type = decltype(value++); }",
        "struct Record { unsigned member; }; __global__ void kernel() { Record value; using Type = decltype(value.member); }",
        "__global__ void kernel() { using Type = decltype(missing); }",
        "__device__ unsigned earlier(unsigned value) { return value; } __device__ decltype(value) invalid() { return 1u; } __global__ void kernel() {}",
        "using Value = unsigned; __global__ void kernel() { using Type = decltype(Value); }",
        "__global__ void kernel() { auto value = decltype(value)(1u); }",
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
