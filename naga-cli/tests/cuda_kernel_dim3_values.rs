mod common;

use common::TestFiles;

#[test]
fn cuda_kernel_dim3_values_cli_emits_all_writers_with_source_binding_order() {
    let source = "using Shape = dim3;
        __global__ void kernel(unsigned *out, const Shape input, unsigned scale) {
            Shape value = input;
            value.y += scale;
            dim3 defaults;
            out[0] = input.x;
            out[1] = value.y;
            out[2] = value.z + defaults.z;
        }";
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|output| output.as_path()).collect();
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
        for output in &outputs {
            assert!(std::fs::metadata(output).unwrap().len() > 0);
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
        for (index, (binding, _)) in resources.iter().enumerate() {
            assert_eq!(binding.group, 0);
            assert_eq!(binding.binding, index as u32);
        }
        assert_eq!(
            resources[0].1.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
            }
        );
        assert_eq!(resources[1].1.space, naga::AddressSpace::Uniform);
        assert_eq!(resources[2].1.space, naga::AddressSpace::Uniform);
        let naga::TypeInner::Struct { ref members, .. } = module.types[resources[1].1.ty].inner
        else {
            panic!("expected uniform wrapper");
        };
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        let naga::TypeInner::Struct {
            ref members,
            span: 12,
        } = module.types[members[0].ty].inner
        else {
            panic!("expected nominal dim3 payload");
        };
        assert_eq!(members.len(), 3);
        for (index, (member, name)) in members.iter().zip(["x", "y", "z"]).enumerate() {
            assert_eq!(member.name.as_deref(), Some(name));
            assert_eq!(member.offset, index as u32 * 4);
            assert_eq!(
                module.types[member.ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
        }
    }
}

#[test]
fn cuda_kernel_dim3_values_cli_rejects_invalid_parameters_without_output() {
    for source in [
        "__global__ void kernel(const dim3 value) { ++value.x; }",
        "__global__ void kernel(volatile dim3 value) {}",
        "__global__ void kernel(dim3 &value) {}",
        "__global__ void kernel(dim3 value);",
        "__global__ void kernel(dim3 value = dim3()) {}",
        "struct Record { dim3 value; }; __global__ void kernel(Record value) {}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
