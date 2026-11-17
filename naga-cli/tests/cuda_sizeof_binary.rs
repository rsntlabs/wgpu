mod common;
use common::TestFiles;

#[test]
fn cuda_sizeof_binary_cli_emits_all_backends_without_evaluating_operands() {
    let source = r#"__global__ void kernel(const int *input,unsigned *output) {
        int first=input[0]; unsigned second=3u; float real=2.0f; int grid[2][3]{};
        constexpr unsigned Sum=unsigned(sizeof(first+second));
        constexpr unsigned Product=unsigned(sizeof(real*first));
        constexpr unsigned Comparison=unsigned(sizeof(first<second));
        constexpr unsigned Undefined=unsigned(sizeof(1/0));
        constexpr unsigned Row=unsigned(sizeof(grid[first+second]));
        output[0]=Sum+Product+Comparison+Undefined+Row;
        output[1]=unsigned(first);
    }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|p| p.as_path()).collect();
        let mut args = vec!["--entry-point", "kernel", "--compact"];
        if !compact {
            args.pop();
        }
        let result = files.translate_outputs(&args, &paths);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        for output in outputs {
            assert!(std::fs::metadata(output).unwrap().len() > 0);
        }
        let module = files.read_module();
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|s| s.width <= 4)));
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
            assert_eq!(size, naga::ArraySize::Dynamic);
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
fn cuda_sizeof_binary_cli_rejects_invalid_types_and_out_of_scope_expressions() {
    for body in [
        "int value=1;unsigned n=sizeof(value+sizeof(int));",
        "int *p=nullptr; unsigned n=sizeof(p+1);",
        "float2 value{}; unsigned n=sizeof(value+value);",
        "int value=1; unsigned n=sizeof((value,2));",
        "int value=1; unsigned n=sizeof(value=2);",
        "int value=1; unsigned n=sizeof(value?1:2);",
        "int value=1; unsigned n=sizeof(value++);",
        "float value=1; unsigned n=sizeof(value%2);",
        "float value=1; unsigned n=sizeof(value<<2);",
    ] {
        let source = format!("__global__ void kernel(){{{body}}}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
