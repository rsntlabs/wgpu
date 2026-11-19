mod common;
use common::TestFiles;

#[test]
fn cuda_for_declaration_conditions_cli_emits_all_backends_and_preserves_resources() {
    let source = r#"__global__ void kernel(const int *input, unsigned *output) {
            int cursor = 0, total = 0;
            for (int step = 0; auto item{input[cursor++]}; ++step, total += item) {
                item = 10 + step;
                if (step == 0) continue;
                if (step == 3) break;
            }
            for (; const int item = input[0];) { total += item; break; }
            output[0] = unsigned(total + cursor);
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
            let naga::TypeInner::Array { base, stride, size } = module.types[global.ty].inner
            else {
                panic!("storage array");
            };
            assert_eq!(stride, 4);
            assert_eq!(size, naga::ArraySize::Dynamic);
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
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    }
                );
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
    }
}

#[test]
fn cuda_for_declaration_conditions_cli_rejects_invalid_headers_and_scope() {
    for body in [
        "for (int item=0; int item=1;) {}",
        "for (; auto item=1;) { int item=2; }",
        "for (; int item=0;) {} item=2;",
        "for (; int item;) {}",
        "for (; auto item={1};) {}",
        "for (; const auto item=1; ++item) {}",
    ] {
        let source = format!("__global__ void kernel() {{ {body} }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "accepted invalid CUDA: {source}");
    }
}
