mod common;
use common::TestFiles;

#[test]
fn cuda_multidimensional_parameters_cli_emits_row_storage_and_compatible_prototypes() {
    let source = r#"__device__ int read(const int[][3]);
        __device__ int read(const int values[4294967295u][3]) { return values[0][0]+values[1][2]; }
        __device__ void change(int values[][3],int amount) { values[1][2]+=amount; }
        __global__ void kernel(const int input[][3],unsigned output[4][2]) {
            unsigned lane=threadIdx.x;
            int values[2][3]={{input[lane][0],2,3},{4,5,6}};
            change(values,input[lane][1]);
            output[lane][0]=unsigned(read(values)); output[lane][1]=unsigned(input[lane][2]);
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
            let naga::TypeInner::Array {
                base: row,
                stride,
                size,
            } = module.types[global.ty].inner
            else {
                panic!("runtime row array");
            };
            let naga::TypeInner::Array {
                base: element,
                stride: element_stride,
                size: row_size,
            } = module.types[row].inner
            else {
                panic!("complete row type");
            };
            assert_eq!(size, naga::ArraySize::Dynamic);
            assert_eq!(element_stride, 4);
            if binding.binding == 0 {
                assert_eq!(stride, 12);
                assert_eq!(
                    row_size,
                    naga::ArraySize::Constant(core::num::NonZeroU32::new(3).unwrap())
                );
                assert_eq!(
                    module.types[element].inner,
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
                assert_eq!(stride, 8);
                assert_eq!(
                    row_size,
                    naga::ArraySize::Constant(core::num::NonZeroU32::new(2).unwrap())
                );
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    }
                );
                assert_eq!(
                    module.types[element].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
    }
}

#[test]
fn cuda_multidimensional_parameters_cli_rejects_invalid_rows_and_unsupported_templates() {
    for source in [
        "__global__ void kernel(const int input[][3]) {input[0][0]=1;}",
        "__device__ void f(int values[2][]){ } __global__ void kernel(){}",
        "__device__ void f(int values[][0]){ } __global__ void kernel(){}",
        "__device__ void f(int values[][-1]){ } __global__ void kernel(){}",
        "__device__ void f(int *values[2][3]){ } __global__ void kernel(){}",
        "__device__ void f(int &values[2][3]){ } __global__ void kernel(){}",
        "template<class T> __device__ int f(T values[][3]){return 1;} __global__ void kernel(){}",
        "template<int N> __global__ void kernel(int values[][3]){}",
        "struct R{int x[2];}; __global__ void kernel(R value){}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
