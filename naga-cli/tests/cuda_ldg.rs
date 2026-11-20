mod common;

use common::TestFiles;
use naga::{AddressSpace, ResourceBinding, Scalar, StorageAccess, TypeInner, VectorSize};

#[test]
fn cuda_ldg_cli_emits_read_only_loads_for_all_backends() {
    emits_all_backends(
        include_str!("../../naga/tests/in/cuda/ldg.cu"),
        "load_values",
        &[(TypeInner::Scalar(Scalar::U32), 4)],
    );
}

#[test]
fn cuda_ldg_cli_emits_signed_and_float_loads_for_all_backends() {
    emits_all_backends(
        include_str!("../../naga/tests/in/cuda/ldg-signed-float.cu"),
        "load_values",
        &[
            (TypeInner::Scalar(Scalar::I32), 4),
            (TypeInner::Scalar(Scalar::F32), 4),
        ],
    );
}

#[test]
fn cuda_ldg_cli_emits_float2_loads_for_all_backends() {
    emits_all_backends(
        include_str!("../../naga/tests/in/cuda/ldg-float2.cu"),
        "load_pairs",
        &[(
            TypeInner::Vector {
                size: VectorSize::Bi,
                scalar: Scalar::F32,
            },
            8,
        )],
    );
}

#[test]
fn cuda_ldg_cli_emits_native_vector_loads_for_all_backends() {
    let input_types = [
        (VectorSize::Bi, Scalar::I32, 8),
        (VectorSize::Bi, Scalar::U32, 8),
        (VectorSize::Quad, Scalar::I32, 16),
        (VectorSize::Quad, Scalar::U32, 16),
        (VectorSize::Quad, Scalar::F32, 16),
    ]
    .map(|(size, scalar, stride)| (TypeInner::Vector { size, scalar }, stride));
    emits_all_backends(
        include_str!("../../naga/tests/in/cuda/ldg-native-vectors.cu"),
        "load_vectors",
        &input_types,
    );
}

fn emits_all_backends(source: &str, entry: &str, input_types: &[(TypeInner, u32)]) {
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
        let mut args = vec!["--entry-point", entry];
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
        assert_eq!(module.global_variables.len(), input_types.len() + 1);
        let mut seen_bindings = vec![false; input_types.len() + 1];
        for (_, global) in module.global_variables.iter() {
            let Some(ResourceBinding { group: 0, binding }) = global.binding else {
                panic!("expected CUDA buffer binding");
            };
            let binding = binding as usize;
            assert!(!seen_bindings[binding], "duplicate CUDA buffer binding");
            seen_bindings[binding] = true;
            let ((element_type, expected_stride), access) = if binding == input_types.len() {
                (
                    &(TypeInner::Scalar(Scalar::U32), 4),
                    StorageAccess::LOAD | StorageAccess::STORE,
                )
            } else {
                (&input_types[binding], StorageAccess::LOAD)
            };
            assert_eq!(global.space, AddressSpace::Storage { access });
            let TypeInner::Array {
                base,
                size: naga::ArraySize::Dynamic,
                stride,
            } = module.types[global.ty].inner
            else {
                panic!("expected packed CUDA storage buffer");
            };
            assert_eq!(stride, *expected_stride);
            assert_eq!(&module.types[base].inner, element_type);
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
