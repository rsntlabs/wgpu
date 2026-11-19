mod common;

use common::TestFiles;

#[test]
fn cuda_template_noexcept_cli_translates_all_backends_with_stable_interfaces() {
    let source = "template<class T = unsigned> __host__ __device__ unsigned add(T value, unsigned bias = 3u) noexcept;
        template<class U> __host__ __device__ unsigned add(U renamed, unsigned bias) noexcept(true) { return unsigned(renamed) + bias; }
        template<class T> __device__ void write(unsigned *out, const T &value) noexcept(false) { out[0] = unsigned(value); }
        __global__ void kernel(unsigned *out, const unsigned *input, unsigned value) { unsigned index = 0u; write(out, input[index++]); out[1] = add(value); out[2] = add<unsigned>(value); out[3] = index; }";
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
        for path in outputs {
            assert!(std::fs::metadata(path).unwrap().len() > 0);
        }
        let module = files.read_module();
        assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
        let mut resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
            .collect();
        resources.sort_by_key(|(binding, _)| binding.binding);
        assert_eq!(resources.len(), 3);
        for (index, (binding, global)) in resources.into_iter().enumerate() {
            assert_eq!(
                binding,
                naga::ResourceBinding {
                    group: 0,
                    binding: index as u32
                }
            );
            if index < 2 {
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected storage array");
                };
                assert_eq!(stride, 4);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            } else {
                assert_eq!(global.space, naga::AddressSpace::Uniform);
            }
        }
    }
}

#[test]
fn cuda_template_noexcept_cli_rejects_conflicting_or_unsupported_specs_without_output() {
    for source in [
        "template<class T> __device__ T helper(T value) noexcept; template<class U> __device__ U helper(U value) noexcept(false) { return value; } __global__ void kernel() {}",
        "template<class T> __device__ T helper(T value) noexcept(value) { return value; } __global__ void kernel() {}",
        "template<class T> __global__ void kernel(T value) noexcept(false) {}",
        "template<class T> __global__ void kernel(T value) {} template __global__ void kernel<unsigned>(unsigned) noexcept(false);",
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
