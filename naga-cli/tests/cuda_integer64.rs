mod common;

use common::TestFiles;

#[test]
fn cuda_integer64_cli_preserves_eight_byte_storage_and_uniform_values() {
    let files = TestFiles::new(
        "cu",
        "using Signed = long long; using Unsigned = unsigned long long;
        __global__ void copy(const Signed *input, Unsigned *output, Signed bias) {
            output[0] = Unsigned(input[0] + bias + 0xffffffffu);
        }",
    );
    let result = files.translate(&["--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 3);
    for (index, scalar) in [(0, naga::Scalar::I64), (1, naga::Scalar::U64)] {
        assert_eq!(
            globals[index].binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
        let naga::TypeInner::Array {
            base,
            size: naga::ArraySize::Dynamic,
            stride,
        } = module.types[globals[index].ty].inner
        else {
            panic!("scalar buffer");
        };
        assert_eq!(stride, 8);
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
    }
    assert_eq!(
        globals[0].space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    assert_eq!(
        globals[1].space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[2].ty].inner else {
        panic!("scalar parameter wrapper");
    };
    assert_eq!((members.len(), span), (1, 8));
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I64)
    );
}

#[test]
fn cuda_integer64_cli_selects_canonical_long_long_template_names() {
    let source = "using Signed = long long; using Unsigned = unsigned long long;
        template<class Value> __global__ void copy(Value *output, const Value *input) {
            output[0] = input[0];
        }
        template __global__ void copy<Signed>(Signed *, const Signed *);
        template __global__ void copy<Unsigned>(Unsigned *, const Unsigned *);";
    for (entry, scalar) in [
        ("copy<long long>", naga::Scalar::I64),
        ("copy<unsigned long long>", naga::Scalar::U64),
    ] {
        for compact in [false, true] {
            let files = TestFiles::new("cu", source);
            let mut arguments = vec!["--entry-point", entry];
            if compact {
                arguments.push("--compact");
            }
            let result = files.translate(&arguments);
            assert!(
                result.status.success(),
                "{}",
                String::from_utf8_lossy(&result.stderr)
            );
            let module =
                files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
            assert_eq!(module.entry_points.len(), 1);
            assert_eq!(module.global_variables.len(), 2);
            for (_, global) in module.global_variables.iter() {
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("typed scalar buffer");
                };
                assert_eq!(stride, 8);
                assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            }
        }
    }
}

#[test]
fn cuda_integer64_cli_compacts_unused_wide_kernels_for_32_bit_output() {
    let files = TestFiles::new(
        "cu",
        "__global__ void wide(long long *output) { output[0] = 1LL; }
        __global__ void small(unsigned *output) { output[0] = 7u; }",
    );
    let result = files.translate(&["--entry-point", "small", "--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "small");
    assert_eq!(module.global_variables.len(), 1);
    let (_, global) = module.global_variables.iter().next().unwrap();
    assert_eq!(
        global.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
        panic!("32-bit output buffer");
    };
    assert_eq!(stride, 4);
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
}
