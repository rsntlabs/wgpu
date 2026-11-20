mod common;

use common::TestFiles;

#[test]
fn cuda_record_offsetof_cli_emits_32_bit_output_for_all_backends() {
    emits_record_offsetof_all_backends(
        include_str!("../../naga/tests/in/cuda/builtin-offsetof.cu"),
        "record_offsets",
    );
}

#[test]
fn cuda_record_offsetof_cli_emits_nested_offsets_for_all_backends() {
    emits_record_offsetof_all_backends(
        include_str!("../../naga/tests/in/cuda/offsetof-member-paths.cu"),
        "nested_offsets",
    );
}

fn emits_record_offsetof_all_backends(source: &str, entry: &str) {
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .map(|extension| files.output.with_extension(extension));
        let paths = outputs.each_ref().map(|path| path.as_path());
        let mut arguments = vec!["--entry-point", entry, "--cuda-workgroup-size", "4,1,1"];
        if compact {
            arguments.push("--compact");
        }
        let result = files.translate_outputs(&arguments, &paths);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        assert!(outputs
            .iter()
            .all(|output| std::fs::metadata(output).unwrap().len() > 0));
        let module = files.read_module();
        assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
        assert_eq!(module.global_variables.len(), 1);
        let (_, output) = module.global_variables.iter().next().unwrap();
        assert_eq!(
            output.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: 0
            })
        );
        assert_eq!(
            output.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
            }
        );
        let naga::TypeInner::Array {
            base,
            size: naga::ArraySize::Dynamic,
            stride: 4,
        } = module.types[output.ty].inner
        else {
            panic!("expected packed unsigned output");
        };
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
}

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

#[test]
fn cuda_sizeof_named_objects_cli_compacts_unevaluated_array_queries() {
    let files = TestFiles::new(
        "cu",
        "__global__ void kernel(unsigned *output, volatile unsigned *input) {
            int values[2][3];
            volatile unsigned &reference = input[0];
            output[0] = unsigned(sizeof(values));
            output[1] = unsigned(sizeof reference);
        }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    let function = &module.entry_points[0].function;
    assert!(function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}

#[test]
fn cuda_sizeof_members_cli_preserves_unevaluated_volatile_views_after_compaction() {
    let files = TestFiles::new(
        "cu",
        "struct Record { float3 vector; int matrix[2][3]; };
        __global__ void kernel(unsigned *output, volatile Record *input) {
            output[0] = unsigned(sizeof(input->vector));
            output[1] = unsigned(sizeof input->matrix);
            output[2] = unsigned(sizeof(input->vector.z));
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
    assert_eq!(
        module.global_variables.iter().next().unwrap().1.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}

#[test]
fn cuda_sizeof_dereference_cli_compacts_unevaluated_operands() {
    let files = TestFiles::new(
        "cu",
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned *output, volatile int *input) {
            int matrix[2][3];
            output[0] = unsigned(sizeof(*input));
            output[1] = unsigned(sizeof *values);
            output[2] = unsigned(sizeof(*matrix));
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
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_grouping_cli_preserves_precedence_without_loads() {
    let files = TestFiles::new(
        "cu",
        "struct Record { float3 vector; int matrix[2][3]; };
        extern __shared__ Record dynamic[];
        __global__ void kernel(unsigned *output, volatile Record *input) {
            output[0] = unsigned(sizeof((*input).matrix));
            output[1] = unsigned(sizeof (*(dynamic)).vector);
            output[2] = unsigned(sizeof *((*input).matrix));
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
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_literals_cli_discards_unevaluated_wide_types_after_compaction() {
    let files = TestFiles::new(
        "cu",
        "__global__ void kernel(unsigned *output) {
            output[0] = unsigned(sizeof(1LL));
            output[1] = unsigned(sizeof true);
            output[2] = unsigned(sizeof((nullptr)));
            output[3] = unsigned(sizeof(0x1.8p+2f));
        }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    let function = &module.entry_points[0].function;
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { value, .. } = *statement {
            values.push(function.expressions[value].clone());
        }
        false
    });
    assert_eq!(
        values,
        [8, 1, 8, 4].map(|value| naga::Expression::Literal(naga::Literal::U32(value)))
    );
}

#[test]
fn cuda_sizeof_unary_cli_compacts_types_without_evaluating_operands() {
    let files = TestFiles::new(
        "cu",
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned *output, volatile short *input) {
            output[0] = unsigned(sizeof(-*input));
            output[1] = unsigned(sizeof(+values));
            output[2] = unsigned(sizeof(*+values));
            output[3] = unsigned(sizeof(!input));
            output[4] = unsigned(sizeof(~true));
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
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Load { .. } | naga::Expression::Unary { .. }
        )));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_subscripts_cli_discards_unevaluated_indices_and_resources() {
    let files = TestFiles::new(
        "cu",
        "struct Record { float3 vector; int matrix[2][3]; };
        extern __shared__ Record values[];
        __global__ void kernel(unsigned *output, volatile int *indices) {
            volatile int &index = indices[0];
            output[0] = unsigned(sizeof values[index].matrix);
            output[1] = unsigned(sizeof(index[values].vector));
            output[2] = unsigned(sizeof indices[index]);
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
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}
