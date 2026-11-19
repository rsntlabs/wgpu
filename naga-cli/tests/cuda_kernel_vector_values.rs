mod common;

use common::TestFiles;

#[test]
fn cuda_kernel_vector_values_cli_preserves_bindings_across_writers() {
    let source = "using Pair = float2;
        __global__ void kernel(const Pair input, unsigned *out, uint4 value, bool flag,
                               const float1 single, int3 triple) {
            value.x += value.w;
            out[0] = __float_as_uint(input.y);
            out[1] = flag ? value.x : value.z;
            triple.z += triple.y;
            out[2] = __float_as_uint(single.x);
            out[3] = unsigned(triple.z);
        }";
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .into_iter()
            .map(|extension| files.output.with_extension(extension))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|path| path.as_path()).collect();
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
        let expected = [
            naga::TypeInner::Vector {
                size: naga::VectorSize::Bi,
                scalar: naga::Scalar::F32,
            },
            naga::TypeInner::Scalar(naga::Scalar::U32),
            naga::TypeInner::Vector {
                size: naga::VectorSize::Quad,
                scalar: naga::Scalar::U32,
            },
            naga::TypeInner::Scalar(naga::Scalar::U32),
        ];
        assert_eq!(resources.len(), expected.len() + 2);
        for (index, (binding, global)) in resources.into_iter().enumerate() {
            assert_eq!(
                binding,
                naga::ResourceBinding {
                    group: 0,
                    binding: index as u32,
                }
            );
            let payload = if index == 1 {
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
                    }
                );
                let naga::TypeInner::Array {
                    base,
                    stride: 4,
                    size: naga::ArraySize::Dynamic,
                } = module.types[global.ty].inner
                else {
                    panic!("expected a storage array");
                };
                base
            } else {
                assert_eq!(global.space, naga::AddressSpace::Uniform);
                let naga::TypeInner::Struct { ref members, .. } = module.types[global.ty].inner
                else {
                    panic!("expected a uniform wrapper");
                };
                assert_eq!(members.len(), 1);
                assert_eq!(members[0].offset, 0);
                members[0].ty
            };
            if let Some(expected) = expected.get(index) {
                assert_eq!(&module.types[payload].inner, expected);
            } else {
                let naga::TypeInner::Struct { ref members, .. } = module.types[payload].inner
                else {
                    panic!("expected a named CUDA vector");
                };
                let (count, scalar) = if index == 4 {
                    (1, naga::Scalar::F32)
                } else {
                    (3, naga::Scalar::I32)
                };
                assert_eq!(members.len(), count);
                for (field, (member, name)) in members.iter().zip(["x", "y", "z"]).enumerate() {
                    assert_eq!(member.name.as_deref(), Some(name));
                    assert_eq!(member.offset, field as u32 * 4);
                    assert_eq!(
                        module.types[member.ty].inner,
                        naga::TypeInner::Scalar(scalar)
                    );
                }
            }
        }
    }
}

#[test]
fn cuda_kernel_vector_values_cli_rejects_unsupported_values_and_const_writes() {
    for source in [
        "__global__ void kernel(short3 value) {}",
        "__global__ void kernel(short2 value) {}",
        "__global__ void kernel(const uint4 value) { value.w = 7u; }",
        "__global__ void kernel(float2 &value) {}",
        "__global__ void kernel(float2 value);",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
