mod common;
use common::TestFiles;

#[test]
fn cuda_switch_initializers_cli_emits_all_backends_and_preserves_storage_abi() {
    let source = r#"__device__ void bump(int &value){++value;}
        __global__ void kernel(const int *input,unsigned *output) {
            int value=0;
            switch(bump(value);input[0]) {case 0:value+=2;break;default:value+=3;}
            switch(int key=input[0], bias=4;key) {case 0:output[0]=unsigned(bias);break;default:output[0]=unsigned(key+bias);}
            switch(;value) {case 3:output[1]=3u;break;default:output[1]=unsigned(value);}
            switch(int &ref=value;ref) {default:++ref;}
            output[2]=unsigned(value);
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
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    }
                );
            }
        }
    }
}

#[test]
fn cuda_switch_initializers_cli_rejects_scope_errors_and_invalid_headers() {
    for source in [
        "__global__ void kernel(){switch(int key=1;key){default:break;}int escaped=key;}",
        "__global__ void kernel(){switch(int key=1;key){default:int key=2;}}",
        "__global__ void kernel(){switch(int key=1;key){case 0:int value=2;case 1:break;}}",
        "__global__ void kernel(){switch(int key=1;){default:break;}}",
        "__global__ void kernel(){switch(int key=1;key;key){default:break;}}",
        "__global__ void kernel(){switch(using Value=int;1){default:break;}}",
        "__global__ void kernel(){switch(int key=1;1LL){default:break;}}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
