mod common;

use common::TestFiles;

#[test]
fn cuda_kernel_record_values_cli_emits_all_writers_with_source_binding_order() {
    let source = "struct Config {
            int bias; unsigned offset; float factor; unsigned flags;
            int delta; float scale; unsigned limit; float last;
        };
        using Options = Config;
        __global__ void kernel(unsigned *out, unsigned index, const Options input) {
            Options copy = input;
            copy.bias += int(index);
            out[0] = unsigned(copy.bias) + input.offset;
            out[1] = __float_as_uint(copy.factor);
            out[2] = copy.flags + unsigned(copy.delta) + copy.limit;
            out[3] = __float_as_uint(copy.scale + copy.last);
        }";
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|extension| files.output.with_extension(extension))
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
        for output in outputs {
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
        let naga::TypeInner::Struct { ref members, .. } = module.types[resources[2].1.ty].inner
        else {
            panic!("expected uniform wrapper");
        };
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        let naga::TypeInner::Struct {
            ref members,
            span: 32,
        } = module.types[members[0].ty].inner
        else {
            panic!("expected a thirty-two-byte configuration record");
        };
        assert_eq!(members.len(), 8);
        for (index, (member, (name, scalar))) in members
            .iter()
            .zip([
                ("bias", naga::Scalar::I32),
                ("offset", naga::Scalar::U32),
                ("factor", naga::Scalar::F32),
                ("flags", naga::Scalar::U32),
                ("delta", naga::Scalar::I32),
                ("scale", naga::Scalar::F32),
                ("limit", naga::Scalar::U32),
                ("last", naga::Scalar::F32),
            ])
            .enumerate()
        {
            assert_eq!(member.name.as_deref(), Some(name));
            assert_eq!(member.offset, index as u32 * 4);
            assert_eq!(
                module.types[member.ty].inner,
                naga::TypeInner::Scalar(scalar)
            );
        }
    }
}

#[test]
fn cuda_kernel_record_values_cli_rejects_invalid_parameters_without_output() {
    for source in [
        "struct Config { dim3 shape; }; __global__ void kernel(Config value) {}",
        "struct Config { int a, b, c, d, e, f, g, h, i; }; __global__ void kernel(Config value) {}",
        "struct Config { float coefficients[2]; }; __global__ void kernel(Config value) {}",
        "struct Config { int count; }; __global__ void kernel(const Config value) { ++value.count; }",
        "struct Config { int count; }; __global__ void kernel(Config &value) {}",
        "struct Config { int count; }; __global__ void kernel(Config value);",
        "struct Config { int count; }; __global__ void kernel(Config value = Config{1}) {}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
