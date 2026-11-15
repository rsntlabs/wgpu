mod common;
use common::TestFiles;

#[test]
fn cuda_if_initializers_cli_emits_all_backends_and_preserves_resources() {
    let source = r#"__device__ void bump(int &value) { ++value; }
        __global__ void kernel(const int *input, unsigned *output) {
            int value = 0;
            if (; input[0] > 0) ++value;
            if (bump(value); false) value += 99;
            if (int first = input[0], second = input[1]; first < second) { output[0] = unsigned(first); } else { output[0] = unsigned(second); }
            if (auto copy = input[0]; copy) { { int copy = 7; value += copy; } }
            if (int &alias = value; alias > 0) ++alias;
            output[1] = unsigned(value);
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|p| p.as_path()).collect();
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
        let resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, g)| g.binding.map(|b| (b, g)))
            .collect();
        assert_eq!(resources.len(), 2);
        for (binding, global) in resources {
            assert_eq!(binding.group, 0);
            let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
                panic!("storage array");
            };
            assert_eq!(stride, 4);
            if binding.binding == 0 {
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD
                    }
                );
            } else {
                assert_eq!(binding.binding, 1);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
    }
}

#[test]
fn cuda_if_initializers_cli_rejects_scope_escapes_redeclarations_and_invalid_headers() {
    for source in [
        "__global__ void kernel() { if(int header=1;header) {} int escaped=header; }",
        "__global__ void kernel() { if(int header=1;header) { int header=2; } }",
        "__global__ void kernel() { if(int header=1;header) {} else { int header=2; } }",
        "__global__ void kernel() { if(int header=1;header) int header=2; }",
        "__global__ void kernel() { if(int header=1;) {} }",
        "__global__ void kernel() { if(int header=1;header;header) {} }",
        "__global__ void kernel() { if(int header=1;true) { int branch=2; } else { int escaped=branch; } }",
        "__global__ void kernel() { if(using Value=int;true) {} }",
    ] {
        let files=TestFiles::new("cu",source);
        let result=files.translate(&[]);
        assert!(!result.status.success(),"unexpectedacceptance:{source}");
    }
}
