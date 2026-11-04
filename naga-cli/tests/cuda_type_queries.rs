mod common;

use common::TestFiles;

#[test]
fn cuda_type_queries_cli_preserves_byte_counted_copy_bindings_and_launch_shape() {
    let files = TestFiles::new(
        "cu",
        "__global__ void copy(int *output, const int *input, size_t bytes) {
            unsigned stride = gridDim.x * blockDim.x;
            unsigned index = blockDim.x * blockIdx.x + threadIdx.x;
            for (size_t position = index; position < bytes / sizeof(int); position += stride) {
                output[position] = input[position];
            }
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
    for (index, access) in [
        naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
        naga::StorageAccess::LOAD,
    ]
    .into_iter()
    .enumerate()
    {
        assert_eq!(
            globals[index].binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
        assert_eq!(globals[index].space, naga::AddressSpace::Storage { access });
        let naga::TypeInner::Array { base, stride, .. } = module.types[globals[index].ty].inner
        else {
            panic!("expected an integer storage buffer");
        };
        assert_eq!(stride, 4);
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
    }
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, .. } = module.types[globals[2].ty].inner else {
        panic!("expected the byte count parameter wrapper");
    };
    assert_eq!(members.len(), 1);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U64)
    );
}

#[test]
fn cuda_type_queries_cli_compacts_constants_without_retaining_wide_shader_types() {
    let files = TestFiles::new(
        "cu",
        "struct Record { float3 vector; int tail; };
        constexpr unsigned RecordBytes = unsigned(sizeof(Record));
        constexpr unsigned RecordAlignment = unsigned(alignof(Record));
        __global__ void kernel(unsigned *output) {
            output[0] = RecordBytes;
            output[1] = RecordAlignment;
        }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.global_variables.len(), 1);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    let mut values = Vec::new();
    for (_, constant) in module.constants.iter() {
        if let naga::Expression::Literal(naga::Literal::U32(value)) =
            module.global_expressions[constant.init]
        {
            values.push(value);
        }
    }
    values.sort_unstable();
    assert_eq!(values, [4, 16]);
}

#[test]
fn cuda_type_queries_cli_selects_dependent_type_entries() {
    let source = "template<class Value> __global__ void layout(unsigned long *output) {
            output[0] = sizeof(Value);
            output[1] = alignof(Value);
        }
        template __global__ void layout<int>(unsigned long *);
        template __global__ void layout<float3>(unsigned long *);";
    for (entry, expected) in [("layout<int>", [4, 4]), ("layout<float3>", [12, 4])] {
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
            assert_eq!(module.global_variables.len(), 1);
            let function = &module.entry_points[0].function;
            let mut values = Vec::new();
            naga::proc::any_statement(&function.body, &mut |statement| {
                if let naga::Statement::Store { value, .. } = *statement {
                    if let naga::Expression::Literal(naga::Literal::U64(value)) =
                        function.expressions[value]
                    {
                        values.push(value);
                    }
                }
                false
            });
            assert_eq!(values, expected, "{entry}");
        }
    }
}

#[test]
fn cuda_type_queries_cli_reports_invalid_queries_without_creating_output() {
    for query in [
        "sizeof(void)",
        "sizeof(int[])",
        "alignof(1)",
        "sizeof(value++)",
    ] {
        let files = TestFiles::new(
            "cu",
            &format!(
                "__global__ void kernel(unsigned long *output) {{
                    unsigned value = 0u;
                    output[0] = {query};
                }}"
            ),
        );
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{query}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(diagnostic.contains("input.cu"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists(), "{query}");
    }
}
