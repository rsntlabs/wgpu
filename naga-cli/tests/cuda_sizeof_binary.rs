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
    emits_all_backends(source);
}

#[test]
fn cuda_sizeof_conditional_cli_emits_all_backends_without_evaluating_operands() {
    emits_all_backends(
        r#"__global__ void kernel(const int *input,unsigned *output) {
        bool flag; int grid[2][3];
        constexpr unsigned Boolean=unsigned(sizeof(input[0] ? flag : false));
        constexpr unsigned Row=unsigned(sizeof(grid[input[1] ? 0u : 1]));
        constexpr unsigned Undefined=unsigned(sizeof(input[2] ? 1/0 : 1<<99));
        output[0]=Boolean+Row+Undefined;
        output[1]=unsigned(input[0]);
    }"#,
    );
}

#[test]
fn cuda_sizeof_pointer_conditions_cli_emits_all_backends_without_reading_conditions() {
    emits_all_backends(
        r#"__global__ void kernel(const int *input,unsigned *output) {
        int grid[2][3];
        constexpr unsigned Element=unsigned(sizeof(input ? input[99] : 1u));
        constexpr unsigned Row=unsigned(sizeof(grid[nullptr ? 0 : 1]));
        constexpr unsigned Boolean=unsigned(sizeof(grid ? true : false));
        output[0]=Element+Row+Boolean;
        output[1]=unsigned(input[0]);
    }"#,
    );
}

#[test]
fn cuda_sizeof_pointer_arms_cli_emit_all_backends() {
    emits_all_backends(
        r#"__global__ void kernel(const int *input, unsigned *output) {
        bool flag;
        constexpr unsigned Pointer=unsigned(sizeof(flag ? input : nullptr));
        constexpr unsigned Element=unsigned(sizeof((flag ? nullptr : input)[99]));
        constexpr unsigned Null=unsigned(sizeof(flag ? nullptr : nullptr));
        output[0]=Pointer+Element+Null;
        output[1]=unsigned(input[0]);
    }"#,
    );
}

fn emits_all_backends(source: &str) {
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

#[test]
fn cuda_sizeof_conditional_cli_rejects_invalid_arms() {
    for operands in [
        "true?1:p",
        "p?1:nullptr",
        "true?p:0",
        "true?p:p",
        "true?1,2:3",
        "true?1:",
        "true?1:1.0f%2",
    ] {
        let source = format!("__global__ void kernel() {{ int *p=nullptr; constexpr unsigned size=unsigned(sizeof({operands})); }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
