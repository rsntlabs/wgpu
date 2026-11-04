mod common;

use common::TestFiles;

#[test]
fn cuda_long_types_cli_preserves_lp64_storage_and_size_t_parameters() {
    let files = TestFiles::new(
        "cu",
        "#include <cstddef>
        __global__ void copy(const long *input, unsigned long *output, std::size_t count) {
            unsigned index=blockIdx.x*blockDim.x+threadIdx.x;
            if(index<count) output[index]=static_cast<::size_t>(input[index]+1L);
        }",
    );
    let result = files.translate(&["--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
    assert_eq!(module.entry_points.len(), 1);
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
        let naga::TypeInner::Array { base, stride, .. } = module.types[globals[index].ty].inner
        else {
            panic!("expected a scalar buffer");
        };
        assert_eq!(stride, 8);
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
    }
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[2].ty].inner else {
        panic!("expected the size_t parameter wrapper");
    };
    assert_eq!((members.len(), span), (1, 8));
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U64)
    );
}

#[test]
fn cuda_long_types_cli_selects_distinct_canonical_long_template_entries() {
    let source = "#include <cstddef>
        template<class Value> __global__ void copy(Value *output, const Value *input) { output[0]=input[0]; }
        template __global__ void copy<long>(long *, const long *);
        template __global__ void copy<size_t>(size_t *, const size_t *);
        template __global__ void copy<long long>(long long *, const long long *);
        template __global__ void copy<unsigned long long>(unsigned long long *, const unsigned long long *);";
    for (entry, scalar) in [
        ("copy<long>", naga::Scalar::I64),
        ("copy<unsigned long>", naga::Scalar::U64),
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
                    panic!("expected a typed scalar buffer");
                };
                assert_eq!(stride, 8);
                assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            }
        }
    }
}

#[test]
fn cuda_long_types_cli_compacts_unused_nominal_wide_types_from_small_output() {
    let files = TestFiles::new(
        "cu",
        "__global__ void wide(long *output) { output[0]=1L; }
        __global__ void small(unsigned *output) { output[0]=min(7u,9u); }",
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
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}
