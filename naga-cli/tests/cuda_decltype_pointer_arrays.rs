mod common;
use common::TestFiles;

#[test]
fn cuda_decltype_pointer_arrays_cli_emits_all_backends_with_unchanged_storage_abi() {
    let source = r#"using Row=int[3];
        __device__ unsigned shape(Row grid[2]) { using P=decltype(grid); P copy=grid; constexpr unsigned Shape=unsigned(sizeof(P)+sizeof(*copy)); return Shape; }
        __global__ void kernel(const int *input,unsigned *output) {
            int value=input[0]; int *pointer=&value; decltype(pointer) copy=pointer; *copy+=2;
            int *const fixed=&value; decltype(fixed) fixed_copy=&value; *fixed_copy+=3;
            Row rows[2]{}; decltype(rows) fresh{}; fresh[1][2]=value;
            decltype(input) readonly=input; readonly=input+1;
            constexpr unsigned Bytes=unsigned(sizeof(fresh));
            output[0]=unsigned(fresh[1][2]+*readonly); output[1]=Bytes; output[2]=shape(rows);
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|p| p.as_path()).collect();
        let mut args = vec!["--entry-point", "kernel", "--cuda-workgroup-size", "4,1,1"];
        if compact {
            args.push("--compact");
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
fn cuda_decltype_pointer_arrays_cli_rejects_const_mutation_references_and_nondirect_queries() {
    for source in [
        "__global__ void kernel(){int a=1,b=2;int *const p=&a;decltype(p) q=&a;q=&b;}",
        "__global__ void kernel(){int a=1;const int *p=&a;decltype(p) q=p;*q=2;}",
        "__device__ void helper(int &ref){decltype(ref) value{};} __global__ void kernel(){}",
        "__global__ void kernel(){int a[2]{};using T=decltype((a));}",
        "__global__ void kernel(){int a=1;int *p=&a;using T=decltype(*p);}",
        "__global__ void kernel(){int a=1;int *p=&a;using T=decltype(p++);}",
        "__global__ void kernel(){int a[2]{};using T=decltype(a[0]);}",
        "__global__ void kernel(){auto p=decltype(p){};}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
