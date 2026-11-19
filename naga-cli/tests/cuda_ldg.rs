mod common;

use common::TestFiles;
use naga::{AddressSpace, ResourceBinding, Scalar, StorageAccess, TypeInner};

#[test]
fn cuda_ldg_cli_emits_read_only_loads_for_all_backends() {
    let source = include_str!("../../naga/tests/in/cuda/ldg.cu");
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
        let mut args = vec!["--entry-point", "load_values"];
        if compact {
            args.push("--compact");
        }
        let result = files.translate_outputs(&args, &paths);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        assert!(outputs
            .iter()
            .all(|output| std::fs::metadata(output).unwrap().len() > 0));
        let module = files.read_module();
        assert_eq!(module.global_variables.len(), 2);
        for (_, global) in module.global_variables.iter() {
            let Some(ResourceBinding { group: 0, binding }) = global.binding else {
                panic!("expected CUDA buffer binding");
            };
            let access = match binding {
                0 => StorageAccess::LOAD,
                1 => StorageAccess::LOAD | StorageAccess::STORE,
                _ => panic!("unexpected CUDA buffer binding {binding}"),
            };
            assert_eq!(global.space, AddressSpace::Storage { access });
            let TypeInner::Array {
                base,
                size: naga::ArraySize::Dynamic,
                stride: 4,
            } = module.types[global.ty].inner
            else {
                panic!("expected packed CUDA unsigned buffer");
            };
            assert_eq!(module.types[base].inner, TypeInner::Scalar(Scalar::U32));
        }
    }
}

#[test]
fn cuda_ldg_cli_rejects_a_const_alias_of_writable_storage() {
    let files = TestFiles::new(
        "cu",
        "__global__ void kernel(unsigned *out) {
            const unsigned *alias = out;
            out[0] = __ldg(alias);
        }",
    );
    let result = files.translate(&[]);
    assert!(!result.status.success());
    let error = String::from_utf8_lossy(&result.stderr);
    assert!(error.contains("read-only storage"), "{error}");
    assert!(!files.output.exists());
}
