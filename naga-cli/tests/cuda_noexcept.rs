mod common;

use common::TestFiles;

#[test]
fn cuda_noexcept_cli_preserves_ordinary_helpers_across_all_backends() {
    let source = r#"__device__ unsigned bare(unsigned value) noexcept;
        __device__ unsigned bare(unsigned renamed) noexcept(true) { return renamed + 1u; }
        __device__ unsigned quiet(unsigned value);
        __device__ unsigned quiet(unsigned value) noexcept(0) { return value + 2u; }
        __device__ unsigned measured(unsigned value) noexcept(sizeof(value) == 4) { return value + 3u; }
        __device__ unsigned explicit_bool(unsigned value) noexcept(bool(2)) { return value + 4u; }
        __device__ unsigned one(unsigned value) noexcept(1) { return value + 5u; }
        __device__ unsigned skipped_local(unsigned value) noexcept(true || threadIdx.x) { return value + 6u; }
        __device__ unsigned skipped_grid(unsigned value) noexcept(false && gridDim.x) { return value + 7u; }
        __global__ void kernel(unsigned *output, unsigned value) {
            output[threadIdx.x] = bare(value) + quiet(value) + measured(value) + explicit_bool(value) + one(value) + skipped_local(value) + skipped_grid(value);
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
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
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
    }
}

#[test]
fn cuda_noexcept_cli_preserves_reference_capture_and_argument_effects() {
    let source = r#"__device__ bool choose(bool value) noexcept(false) { return value; }
        __device__ unsigned next(unsigned &counter) noexcept { return counter++; }
        __device__ void write(unsigned *output, const unsigned &input, bool flag) noexcept(sizeof(input) == 4) {
            output[0] = flag ? input + 1u : input;
        }
        __global__ void kernel(unsigned *output, const unsigned *input, bool flag) {
            unsigned counter = 0u;
            write(output, input[next(counter)], choose(flag));
            output[1] = counter;
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
fn cuda_noexcept_cli_rejects_invalid_specs_and_incompatible_redeclarations() {
    for source in [
        "__device__ unsigned helper() noexcept; __device__ unsigned helper() { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper(); __device__ unsigned helper() noexcept(true) { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept(false); __device__ unsigned helper() noexcept { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept(2) { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept(-1) { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept(1.0f) { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper(unsigned value) noexcept(value) { return value; } __global__ void kernel() {}",
        "__device__ unsigned helper(unsigned value) noexcept(false ? value : 1) { return value; } __global__ void kernel() {}",
        "__device__ unsigned helper(unsigned value) noexcept(((void)value, true)) { return value; } __global__ void kernel() {}",
        "constexpr bool Ready = true; __device__ unsigned helper(unsigned Ready) noexcept(Ready) { return Ready; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept() { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept(true { return 1u; } __global__ void kernel() {}",
        "__device__ unsigned helper() noexcept noexcept { return 1u; } __global__ void kernel() {}",
        "__global__ void kernel() noexcept(false) {}",
        "__device__ unsigned __vabs2(unsigned value) noexcept(false); __global__ void kernel() {}",
        "__global__ void kernel() { bool value = noexcept(1u); }",
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
