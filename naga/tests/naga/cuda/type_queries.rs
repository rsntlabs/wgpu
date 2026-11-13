use naga::front::cuda::Options;
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

#[test]
fn cuda_type_queries_return_size_and_alignment_in_bytes() {
    let source = "__global__ void kernel(unsigned long *output) {
        output[0] = sizeof(int);
        output[1] = alignof(int);
    }";
    let (module, _) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
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
        [
            naga::Expression::Literal(naga::Literal::U64(4)),
            naga::Expression::Literal(naga::Literal::U64(4)),
        ]
    );
}

fn roundtrip(source: &str) -> naga::Module {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    module
}

fn assert_query_results(source: &str, expected: &[u64]) {
    let module = roundtrip(source);
    let function = &module.entry_points[0].function;
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            let root = super::helpers::root_expression(function, pointer);
            if matches!(
                function.expressions[root],
                naga::Expression::GlobalVariable(_)
            ) {
                values.push(function.expressions[value].clone());
            }
        }
        false
    });
    let expected: Vec<_> = expected
        .iter()
        .map(|&value| naga::Expression::Literal(naga::Literal::U64(value)))
        .collect();
    assert_eq!(values, expected, "{source}");
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_type_queries_cover_scalar_spellings_qualifiers_and_aliases() {
    for (spelling, size) in [
        ("bool", 1),
        ("short", 2),
        ("unsigned short int", 2),
        ("int", 4),
        ("signed int", 4),
        ("unsigned int", 4),
        ("float", 4),
        ("long", 8),
        ("long unsigned int", 8),
        ("long long", 8),
        ("unsigned long long", 8),
        ("size_t", 8),
        ("std::size_t", 8),
        ("::size_t", 8),
    ] {
        assert_query_results(
            &format!(
                "#include <cstddef>\n
                using Element = {spelling};
                typedef const volatile Element Frozen;
                __global__ void kernel(unsigned long *output) {{
                    output[0] = sizeof({spelling});
                    output[1] = alignof({spelling});
                    output[2] = sizeof(Frozen);
                    output[3] = alignof(Frozen);
                }}"
            ),
            &[size, size, size, size],
        );
    }
}

#[test]
fn cuda_type_queries_use_cuda_vector_and_dimension_layouts() {
    for (prefix, scalar_size) in [
        ("float", 4),
        ("int", 4),
        ("uint", 4),
        ("short", 2),
        ("ushort", 2),
    ] {
        for (width, alignment_factor) in [(1, 1), (2, 2), (3, 1), (4, 4)] {
            let name = format!("{prefix}{width}");
            assert_query_results(
                &format!(
                    "__global__ void kernel(unsigned long *output) {{
                        output[0] = sizeof({name});
                        output[1] = alignof({name});
                        output[2] = sizeof({name}[3]);
                        output[3] = alignof({name}[3]);
                    }}"
                ),
                &[
                    scalar_size * width,
                    scalar_size * alignment_factor,
                    scalar_size * width * 3,
                    scalar_size * alignment_factor,
                ],
            );
        }
    }
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            output[0] = sizeof(dim3);
            output[1] = alignof(dim3);
        }",
        &[12, 4],
    );
}

#[test]
fn cuda_type_queries_preserve_record_padding_and_multidimensional_arrays() {
    assert_query_results(
        "struct Record { short head; long payload; float3 vector; unsigned tail; };
        using Row = float3[2];
        using Grid = Row[3];
        __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Record);
            output[1] = alignof(Record);
            output[2] = sizeof(Record[3]);
            output[3] = alignof(Record[3]);
            output[4] = sizeof(Grid);
            output[5] = alignof(Grid);
            output[6] = sizeof(short3[5]);
            output[7] = alignof(short3[5]);
            output[8] = sizeof(int[2][3]);
            output[9] = sizeof(int[alignof(float4)]);
        }",
        &[32, 8, 96, 8, 72, 4, 30, 2, 24, 64],
    );
}

#[test]
fn cuda_type_queries_use_lp64_pointer_and_referent_layouts() {
    for (spelling, size, alignment) in [
        ("int *", 8, 8),
        ("const volatile long *const", 8, 8),
        ("void *", 8, 8),
        ("const void *", 8, 8),
        ("int **const *", 8, 8),
        ("int &", 4, 4),
        ("const bool &", 1, 1),
        ("long *&", 8, 8),
        ("decltype(nullptr)", 8, 8),
    ] {
        assert_query_results(
            &format!(
                "__global__ void kernel(unsigned long *output) {{
                    output[0] = sizeof({spelling});
                    output[1] = alignof({spelling});
                }}"
            ),
            &[size, alignment],
        );
    }
    assert_query_results(
        "using Row = int[3];
        using Pointer = const long *;
        using Null = decltype(nullptr);
        __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Row &);
            output[1] = alignof(Row &);
            output[2] = sizeof(Row *);
            output[3] = alignof(Row *);
            output[4] = sizeof(Pointer);
            output[5] = alignof(Pointer);
            output[6] = sizeof(Null);
            output[7] = alignof(Null);
        }",
        &[12, 4, 8, 8, 8, 8, 8, 8],
    );
}

#[test]
fn cuda_type_queries_align_unknown_bound_arrays_without_completing_them() {
    assert_query_results(
        "using Unknown = int[];
        using Rows = short3[][2];
        __global__ void kernel(unsigned long *output) {
            output[0] = alignof(Unknown);
            output[1] = alignof(int[]);
            output[2] = alignof(Rows);
            output[3] = sizeof(Unknown *);
            output[4] = alignof(Unknown *);
        }",
        &[4, 4, 2, 8, 8],
    );
    for spelling in ["Unknown", "int[]", "Rows"] {
        rejected(&format!(
            "using Unknown = int[]; using Rows = short3[][2];
            __global__ void kernel(unsigned long *output) {{ output[0] = sizeof({spelling}); }}"
        ));
    }
}

#[test]
fn cuda_type_queries_keep_builtin_size_t_identity_when_aliases_are_shadowed() {
    let module = roundtrip(
        "__device__ unsigned kind(unsigned value) { return 1u; }
        __device__ unsigned kind(unsigned long value) { return 2u; }
        __device__ unsigned kind(unsigned long long value) { return 3u; }
        __global__ void kernel(unsigned *output) {
            using size_t = unsigned;
            output[0] = kind(sizeof(int));
            output[1] = kind(alignof(float3));
            { using size_t = unsigned long long; output[2] = kind(sizeof(bool)); }
        }",
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 3);
    assert!(targets.iter().all(|&target| target == targets[0]));
    let function = &module.functions[targets[0]];
    let mut returned = None;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Return { value: Some(value) } = *statement {
            returned = Some(value);
        }
        false
    });
    assert_eq!(
        function.expressions[returned.unwrap()],
        naga::Expression::Literal(naga::Literal::U32(2))
    );
}

#[test]
fn cuda_type_queries_supply_global_local_array_and_launch_bound_constants() {
    let source = "constexpr size_t Bytes = sizeof(float3[2]);
        constexpr size_t Alignment = alignof(float3);
        using Row = unsigned[sizeof(float)];
        __global__ __launch_bounds__(sizeof(float) * alignof(float))
        void kernel(unsigned *output) {
            const size_t local_count = sizeof(short[3]);
            unsigned local[local_count] = {1};
            Row row = {1, 2, 3, 4};
            __shared__ unsigned tile[Bytes / Alignment];
            output[0] = local[0] + row[3];
        }";
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options {
            workgroup_size: [8, 1, 1],
            ..Default::default()
        },
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
    for (name, count) in [("local", 6), ("row", 4)] {
        let local = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find(|(_, variable)| variable.name.as_deref() == Some(name))
            .unwrap()
            .1;
        assert!(
            matches!(module.types[local.ty].inner,
                naga::TypeInner::Array { size: naga::ArraySize::Constant(actual), stride: 4, .. }
                    if actual.get() == count),
            "{name}"
        );
    }
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, variable)| variable.space == naga::AddressSpace::WorkGroup)
        .collect();
    assert_eq!(shared.len(), 1);
    assert!(matches!(module.types[shared[0].1.ty].inner,
        naga::TypeInner::Array { size: naga::ArraySize::Constant(count), stride: 4, .. }
            if count.get() == 6));
    assert_eq!(module.entry_points[0].workgroup_size, [8, 1, 1]);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
    let _ = info;
}

#[test]
fn cuda_type_queries_support_dependent_types_and_template_deduction() {
    let module = roundtrip(
        "template<class Value> __device__ Value keep(Value value) { return value; }
        template<class Value> __device__ size_t footprint() { return sizeof(Value) + alignof(Value); }
        template<size_t Bytes> __device__ unsigned extent() { return unsigned(Bytes); }
        template<class Value> __device__ unsigned width() { return extent<sizeof(Value)>(); }
        __global__ void kernel(unsigned long *output) {
            output[0] = keep(sizeof(int));
            output[1] = keep(4UL);
            output[2] = keep(4ULL);
            output[3] = footprint<float3>();
            output[4] = width<short>();
        }",
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 5);
    assert_eq!(targets[0], targets[1]);
    assert_ne!(targets[0], targets[2]);
    rejected(
        "template<class Value> __device__ size_t footprint() { return sizeof(Value); }
        using Unknown = int[];
        __global__ void kernel(unsigned long *output) { output[0] = footprint<Unknown>(); }",
    );
}

#[test]
fn cuda_type_queries_support_byte_counted_grid_stride_copy() {
    let module = roundtrip(
        "__global__ void copy(int *output, const int *input, size_t bytes) {
            unsigned stride = gridDim.x * blockDim.x;
            unsigned index = blockDim.x * blockIdx.x + threadIdx.x;
            for (size_t position = index; position < bytes / sizeof(int); position += stride) {
                output[position] = input[position];
            }
        }",
    );
    assert_eq!(module.global_variables.len(), 3);
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| matches!(statement, naga::Statement::Loop { .. })
    ));
}

#[test]
fn cuda_type_queries_preserve_macro_expansion_and_alias_scope() {
    assert_query_results(
        "#define WORD_BYTES sizeof(float)\n
        using Triple = float3;
        __global__ void kernel(unsigned long *output) {
            output[0] = WORD_BYTES;
            output[1] = sizeof(Triple);
            { using Triple = short3; output[2] = sizeof(Triple); }
            output[3] = sizeof(Triple);
        }",
        &[4, 12, 6, 12],
    );
    for condition in ["sizeof(int)", "alignof(int)"] {
        rejected(&format!(
            "#if {condition}\n#error invalid preprocessing expression\n#endif\n__global__ void kernel() {{}}"
        ));
    }
}

#[test]
fn cuda_type_queries_reject_invalid_types_syntax_and_expression_operands() {
    for query in [
        "sizeof(void)",
        "alignof(void)",
        "sizeof(double)",
        "alignof(half)",
        "sizeof(Unknown)",
        "sizeof(int())",
        "alignof(int())",
        "sizeof(int[0])",
        "sizeof(int[-1])",
        "sizeof(int[18446744073709551615ULL])",
        "sizeof(int[2][])",
        "sizeof(int*[2])",
        "sizeof(int&[3])",
        "sizeof(int(*)[3])",
        "sizeof(int int)",
        "alignof(const const int)",
        "sizeof()",
        "alignof()",
        "sizeof(int, float)",
        "alignof(int, float)",
        "sizeof int",
        "alignof int",
        "alignof(1)",
        "sizeof(++value)",
        "sizeof(sizeof(int))",
        "sizeof(cooperative_groups::thread_block)",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                unsigned value = 0u; unsigned values[2] = {{0u, 1u}};
                output[0] = {query};
            }}"
        ));
    }
    for declaration in [
        "int sizeof = 0;",
        "using alignof = int;",
        "typedef int sizeof;",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_type_queries_bound_nested_queries_and_pointer_depth() {
    let mut query = String::from("sizeof(int)");
    for _ in 0..70 {
        query = format!("sizeof(int[{query}])");
    }
    rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ output[0] = {query}; }}"
    ));
    let pointers = "*".repeat(70);
    rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ output[0] = sizeof(int{pointers}); }}"
    ));
}

#[test]
fn cuda_sizeof_named_objects_preserves_arrays_references_and_pointer_sizes() {
    assert_query_results(
        "struct Record { float3 vector; long tag; };
        __global__ void kernel(unsigned long *output, unsigned parameter) {
            short scalar;
            float3 vector;
            Record record;
            int matrix[2][3];
            Record &reference = record;
            int *pointer;
            auto null_value = nullptr;
            output[0] = sizeof(scalar);
            output[1] = sizeof(vector);
            output[2] = sizeof(record);
            output[3] = sizeof(matrix);
            output[4] = sizeof(reference);
            output[5] = sizeof(pointer);
            output[6] = sizeof(output);
            output[7] = sizeof(null_value);
            output[8] = sizeof(parameter);
        }",
        &[2, 12, 24, 24, 24, 8, 8, 8, 4],
    );
}

#[test]
fn cuda_sizeof_named_objects_is_unevaluated_and_accepts_unparenthesized_names() {
    let module = roundtrip(
        "__global__ void kernel(unsigned long *output, volatile unsigned *input) {
            volatile unsigned &reference = input[0];
            unsigned uninitialized;
            output[0] = sizeof reference;
            output[1] = sizeof(uninitialized);
            output[2] = sizeof input + 1UL;
        }",
    );
    let function = &module.entry_points[0].function;
    assert!(function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            int values[3];
            output[0] = sizeof values;
            constexpr size_t Doubled = sizeof values * 2UL;
            output[1] = sizeof(int[Doubled]);
        }",
        &[12, 96],
    );
}

#[test]
fn cuda_sizeof_named_objects_respects_shadowing_and_supplies_template_constants() {
    assert_query_results(
        "constexpr unsigned Global = 3u;
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Bytes = sizeof(value);
            int array[sizeof(value)];
            output[0] = sizeof(Global);
            output[1] = sizeof(Bytes);
            output[2] = sizeof(array);
            using Name = int;
            { short Name; output[3] = sizeof(Name); }
            output[4] = sizeof(Name);
        }
        template __global__ void kernel<short>(unsigned long *);",
        &[4, 8, 8, 2, 4],
    );
    let module = roundtrip(
        "template<size_t Count> __device__ size_t bytes() { return sizeof(Count); }
        __global__ void kernel(unsigned long *output) {
            int array[3];
            output[0] = bytes<sizeof(array)>();
        }",
    );
    assert_eq!(module.functions.len(), 1);
    let (_, function) = module.functions.iter().next().unwrap();
    assert!(function
        .expressions
        .iter()
        .any(|(_, expression)| *expression == naga::Expression::Literal(naga::Literal::U64(8))));
}

#[test]
fn cuda_sizeof_named_shared_and_constant_memory_keeps_source_layouts() {
    assert_query_results(
        "__constant__ float3 coefficients[2];
        constexpr size_t Bytes = sizeof(coefficients);
        __global__ void kernel(unsigned long *output) {
            __shared__ short shared_values[3];
            output[0] = sizeof(coefficients);
            output[1] = sizeof(shared_values);
            output[2] = sizeof(int[Bytes]);
        }",
        &[24, 6, 96],
    );
    for bytes in [0, 16, 128] {
        let error = naga::front::cuda::parse_str(
            "extern __shared__ unsigned dynamic[];
            __global__ void kernel(unsigned long *output) { output[0] = sizeof(dynamic); }",
            &Options {
                dynamic_shared_memory_size: bytes,
                ..Options::default()
            },
        )
        .unwrap_err();
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_named_objects_rejects_nonobjects_and_unsupported_operands() {
    for operand in [
        "missing",
        "helper",
        "group",
        "value++",
        "value + 1",
        "value, value",
    ] {
        rejected(&format!(
            "__device__ int helper() {{ return 1; }}
            __global__ void kernel(unsigned long *output) {{
                unsigned value = 0; int *pointer;
                auto group = cooperative_groups::this_thread_block();
                output[0] = sizeof({operand});
            }}"
        ));
    }
    for expression in ["alignof(value)", "sizeof value++", "sizeof(value)++"] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                unsigned value = 0; int *pointer;
                output[0] = {expression};
            }}"
        ));
    }
    rejected("__global__ void kernel() { auto value = sizeof(value); }");
}

#[test]
fn cuda_sizeof_named_objects_rejects_incomplete_inferred_array_during_initialization() {
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            int fixed[2] = { int(sizeof(fixed)), 0 };
            int scalar = int(sizeof scalar);
            output[0] = sizeof(fixed);
            output[1] = sizeof(scalar);
        }",
        &[8, 4],
    );
    for declaration in [
        "int values[] = { int(sizeof(values)) };",
        "using Incomplete = int[]; Incomplete values = { int(sizeof values) };",
    ] {
        let error = rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_named_objects_uses_adjusted_array_parameter_type() {
    let module = roundtrip(
        "__device__ size_t bytes(int values[3]) { return sizeof(values); }
        __global__ void kernel(unsigned long *output) {
            int array[3];
            output[0] = bytes(array);
        }",
    );
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
    assert_eq!(values, [8]);
}

#[test]
fn cuda_sizeof_members_preserves_nested_fields_arrays_and_source_pointer_types() {
    assert_query_results(
        "struct Inner { float3 vector; int matrix[2][3]; };
        struct Record { Inner nested; long tag; };
        __global__ void kernel(unsigned long *output, const Record *records) {
            Record record;
            Record &reference = record;
            Record *null_record = nullptr;
            Record *uninitialized;
            dim3 dimensions;
            float4 vector;
            output[0] = sizeof(record.nested.vector);
            output[1] = sizeof reference.nested.matrix;
            output[2] = sizeof(records->tag);
            output[3] = sizeof null_record->nested.vector.z;
            output[4] = sizeof(uninitialized->nested.matrix);
            output[5] = sizeof(dimensions.x);
            output[6] = sizeof vector.w;
        }",
        &[12, 24, 8, 4, 24, 4, 4],
    );
}

#[test]
fn cuda_sizeof_members_is_unevaluated_for_volatile_views_and_array_decay() {
    let module = roundtrip(
        "struct Record { float3 vector; int values[3]; };
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            volatile Record &reference = input[0];
            Record records[2];
            output[0] = sizeof(input->vector);
            output[1] = sizeof reference.values;
            output[2] = sizeof(records->values);
        }",
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
    assert_query_results(
        "struct Record { float3 vector; int values[3]; };
        __global__ void kernel(unsigned long *output) {
            Record records[2];
            output[0] = sizeof(records->vector);
            output[1] = sizeof(records->values);
        }",
        &[12, 12],
    );
}

#[test]
fn cuda_sizeof_members_supports_incomplete_array_arrow_without_launch_storage() {
    for bytes in [0, 16, 128] {
        let (module, _) = validate_with_options_and_capabilities(
            "struct Record { float3 vector; int values[3]; };
            extern __shared__ Record records[];
            __global__ void kernel(unsigned long *output) {
                output[0] = sizeof(records->vector);
                output[1] = sizeof records->values;
            }",
            &Options {
                dynamic_shared_memory_size: bytes,
                ..Options::default()
            },
            Capabilities::SHADER_INT64,
        );
        assert_eq!(module.global_variables.len(), 1);
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
            [
                naga::Expression::Literal(naga::Literal::U64(12)),
                naga::Expression::Literal(naga::Literal::U64(12))
            ]
        );
    }
    roundtrip(
        "struct Record { int value; };
        __global__ void kernel(unsigned long *output) {
            Record records[] = {{int(sizeof(records->value))}};
            output[0] = sizeof(records);
        }",
    );
}

#[test]
fn cuda_sizeof_members_remains_constant_through_templates_and_constant_memory() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __constant__ Record constant_record;
        constexpr size_t Count = sizeof(constant_record.vector);
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Bytes = sizeof(value.matrix);
            output[0] = sizeof(int[Count]);
            output[1] = sizeof(int[Bytes]);
            output[2] = sizeof(constant_record.matrix);
        }
        template __global__ void kernel<Record>(unsigned long *);",
        &[48, 96, 24],
    );
    roundtrip(
        "struct Record { float3 vector; };
        template<class Value> __device__ size_t bytes(const Value *value) { return sizeof(value->vector); }
        __global__ void kernel(unsigned long *output, const Record *records) {
            output[0] = bytes(records);
        }",
    );
}

#[test]
fn cuda_sizeof_members_rejects_invalid_access_and_unsupported_expressions() {
    for operand in [
        "pointer.vector",
        "record->vector",
        "record.missing",
        "record.vector.w",
        "scalar.x",
        "scalar->x",
        "null_value->vector",
        "records.vector",
        "record.matrix.x",
        "record.matrix->x",
        "record.vector.x.y",
        "record.vector.x++",
        "pointer->vector.x + 1",
        "pointer->vector()",
        "record.vector.x, scalar",
    ] {
        rejected(&format!(
            "struct Record {{ float3 vector; int matrix[2][3]; }};
            __global__ void kernel(unsigned long *output) {{
                Record record; Record *pointer; Record records[2];
                int scalar; auto null_value = nullptr;
                output[0] = sizeof({operand});
            }}"
        ));
    }
    rejected("struct Record { int value; }; __global__ void kernel() { Record record; alignof(record.value); }");
}

#[test]
fn cuda_sizeof_dereference_preserves_pointee_and_array_layouts() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        using Row = int[3];
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            int *uninitialized;
            float3 *null_pointer = nullptr;
            Row *rows;
            int matrix[2][3];
            output[0] = sizeof *uninitialized;
            output[1] = sizeof(*null_pointer);
            output[2] = sizeof(*rows);
            output[3] = sizeof(*input);
            output[4] = sizeof(*matrix);
            output[5] = sizeof(**matrix);
            output[6] = sizeof(*input->matrix);
        }",
        &[4, 12, 12, 36, 12, 4, 12],
    );
}

#[test]
fn cuda_sizeof_dereference_does_not_read_or_allocate_storage() {
    let module = roundtrip(
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned long *output, volatile int *input) {
            constexpr size_t Bytes = sizeof(*values);
            output[0] = sizeof(int[Bytes]);
            output[1] = sizeof(*input);
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
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
fn cuda_sizeof_dereference_rejects_invalid_operands() {
    for operand in [
        "*value",
        "**pointer",
        "*null_value",
        "*pointer++",
        "*pointer + 1",
        "*pointer, value",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{
                int value; int *pointer; auto null_value = nullptr;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_dereference_checks_incomplete_pointees_and_nesting_limit() {
    assert_query_results(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            output[0] = sizeof(**view);
        }",
        &[4],
    );
    assert_query_results(
        "using Grid = int[2][3];
        __global__ void kernel(unsigned long *output, Grid *view) {
            output[0] = sizeof(*view);
            output[1] = sizeof(**view);
            output[2] = sizeof(***view);
        }",
        &[24, 12, 4],
    );
    let error = rejected(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            output[0] = sizeof(*view);
        }",
    );
    assert!(error.message.contains("complete"), "{error}");
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output, int *input) {{
            output[0] = sizeof({}input);
        }}",
        "*".repeat(65)
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}

#[test]
fn cuda_sizeof_grouping_preserves_operand_precedence_and_array_extents() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __global__ void kernel(unsigned long *output) {
            Record record;
            Record *pointer = nullptr;
            int array[2][3];
            output[0] = sizeof((array));
            output[1] = sizeof *(pointer);
            output[2] = sizeof((*pointer).matrix);
            output[3] = sizeof *((*pointer).matrix);
            output[4] = sizeof (record).vector.x;
            output[5] = sizeof (*pointer).matrix;
            output[6] = sizeof (((record).matrix));
            output[7] = sizeof **((record).matrix);
        }",
        &[24, 36, 24, 12, 4, 24, 24, 4],
    );
}

#[test]
fn cuda_sizeof_grouping_keeps_volatile_and_dynamic_shared_operands_unevaluated() {
    let module = roundtrip(
        "struct Record { int matrix[2][3]; };
        extern __shared__ Record values[];
        __global__ void kernel(unsigned long *output, volatile Record *input) {
            output[0] = sizeof(((*input).matrix));
            output[1] = sizeof (*(values)).matrix;
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
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
fn cuda_sizeof_grouping_rejects_invalid_syntax_and_bounds_nesting() {
    for operand in [
        "()",
        "(int)",
        "(missing)",
        "(value + 1)",
        "(value++)",
        "(helper())",
        "(value",
        "((value)",
    ] {
        rejected(&format!(
            "__device__ int helper() {{ return 1; }}
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer;
                output[0] = sizeof({operand});
            }}"
        ));
    }
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{
            int value; output[0] = sizeof({}value{});
        }}",
        "(".repeat(65),
        ")".repeat(65)
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}

#[test]
fn cuda_sizeof_grouping_remains_constant_and_stops_before_binary_operators() {
    assert_query_results(
        "struct Record { int matrix[2][3]; };
        __constant__ Record constant_record;
        constexpr size_t Bytes = sizeof (constant_record).matrix + 1;
        template<class Value> __global__ void kernel(unsigned long *output) {
            Value value;
            constexpr size_t Count = sizeof ((value).matrix) + 1;
            output[0] = sizeof(int[Bytes]);
            output[1] = sizeof(int[Count]);
        }
        template __global__ void kernel<Record>(unsigned long *);",
        &[100, 100],
    );
}

#[test]
fn cuda_sizeof_literals_uses_existing_source_scalar_types() {
    for (literal, size) in [
        ("0", 4),
        ("1u", 4),
        ("2147483648", 8),
        ("0xffffffff", 4),
        ("1L", 8),
        ("1ul", 8),
        ("1LL", 8),
        ("0xffffffffffffffffULL", 8),
        ("1.0f", 4),
        ("0x1.8p+2f", 4),
        ("1'000", 4),
        ("true", 1),
        ("false", 1),
        ("nullptr", 8),
    ] {
        assert_query_results(
            &format!(
                "__global__ void kernel(unsigned long *output) {{
                output[0] = sizeof({literal});
                output[1] = sizeof {literal};
                output[2] = sizeof((({literal})));
            }}"
            ),
            &[size, size, size],
        );
    }
}

#[test]
fn cuda_sizeof_literals_supply_constants_without_evaluating_values() {
    assert_query_results(
        "constexpr size_t Count = sizeof(true) + sizeof(nullptr);
        template<class Value> __global__ void kernel(unsigned long *output) {
            output[0] = sizeof(Value[sizeof(1LL)]);
            output[1] = sizeof(int[Count]);
        }
        template __global__ void kernel<short>(unsigned long *);",
        &[16, 36],
    );
}

#[test]
fn cuda_sizeof_literals_rejects_unsupported_literal_forms_and_invalid_uses() {
    for operand in [
        "1.0",
        "1.0L",
        "1e100f",
        "18446744073709551616u",
        "true.x",
        "nullptr->x",
        "*nullptr",
        "*1",
        "1 + 1",
    ] {
        rejected(&format!(
            "__global__ void kernel(unsigned long *output) {{ output[0] = sizeof({operand}); }}"
        ));
    }
}

#[test]
fn cuda_sizeof_unary_uses_builtin_scalar_promotions_and_pointer_decay() {
    assert_query_results(
        "__global__ void kernel(unsigned long *output) {
            short small; unsigned short narrow; bool flag; float value;
            int *pointer; int matrix[2][3];
            output[0] = sizeof(+small);
            output[1] = sizeof(-narrow);
            output[2] = sizeof(~flag);
            output[3] = sizeof(+true);
            output[4] = sizeof(-false);
            output[5] = sizeof(!small);
            output[6] = sizeof(-value);
            output[7] = sizeof(-1L);
            output[8] = sizeof(~0xffffffffffffffffULL);
            output[9] = sizeof(!nullptr);
            output[10] = sizeof(+pointer);
            output[11] = sizeof(*+pointer);
            output[12] = sizeof(+matrix);
            output[13] = sizeof(*+matrix);
            output[14] = sizeof(**+matrix);
            output[15] = sizeof(!matrix);
            output[16] = sizeof(-2147483648);
        }",
        &[4, 4, 4, 4, 4, 1, 4, 8, 8, 1, 8, 4, 8, 12, 4, 1, 8],
    );
}

#[test]
fn cuda_sizeof_unary_does_not_read_volatile_operands_or_allocate_shared_storage() {
    let module = roundtrip(
        "extern __shared__ float3 values[];
        __global__ void kernel(unsigned long *output, volatile short *input) {
            output[0] = sizeof(-*input);
            output[1] = sizeof(+values);
            output[2] = sizeof(*+values);
            output[3] = sizeof(!values);
            output[4] = sizeof(!input);
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
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
fn cuda_sizeof_unary_rejects_invalid_builtin_operand_types() {
    for operand in [
        "~1.0f", "+nullptr", "-nullptr", "~nullptr", "-pointer", "~pointer", "-matrix", "~matrix",
        "+record", "-record", "!record", "~record", "+vector", "!vector", "++value", "value++",
    ] {
        rejected(&format!(
            "struct Record {{ int member; }};
            __global__ void kernel(unsigned long *output) {{
                int value; int *pointer; int matrix[2][3]; Record record; float3 vector;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_subscripts_preserves_element_layout_and_builtin_precedence() {
    assert_query_results(
        "struct Record { float3 vector; int matrix[2][3]; };
        __global__ void kernel(unsigned long *output) {
            int matrix[2][3]; Record records[2];
            float3 *pointer = nullptr; short *short_pointer; long index;
            output[0] = sizeof(matrix[0]);
            output[1] = sizeof(matrix[0][1]);
            output[2] = sizeof pointer[index];
            output[3] = sizeof records[999].matrix;
            output[4] = sizeof(0[matrix]);
            output[5] = sizeof(1[2[matrix]]);
            output[6] = sizeof records[index].vector.z;
            output[7] = sizeof matrix[true];
            output[8] = sizeof matrix[0xffffffffffffffffULL];
            output[9] = sizeof -1[short_pointer];
            output[10] = sizeof (-1)[short_pointer];
            output[11] = sizeof matrix[-1];
            output[12] = sizeof(*(matrix[0]));
            output[13] = sizeof +matrix[0];
            output[14] = sizeof *+matrix[0];
        }",
        &[12, 4, 12, 24, 12, 4, 4, 12, 12, 4, 2, 12, 4, 8, 4],
    );
}

#[test]
fn cuda_sizeof_subscripts_does_not_read_indices_or_allocate_dynamic_shared_storage() {
    let module = roundtrip(
        "struct Record { float3 vector; int matrix[2][3]; };
        extern __shared__ Record values[];
        __global__ void kernel(unsigned long *output, volatile int *input) {
            volatile int &index = input[0];
            output[0] = sizeof input[index];
            output[1] = sizeof values[index].matrix;
            output[2] = sizeof index[values].vector;
        }",
    );
    assert_eq!(module.global_variables.len(), 2);
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
fn cuda_sizeof_subscripts_requires_complete_element_types_before_pointer_arithmetic() {
    assert_query_results(
        "using Values = int[];
        __global__ void kernel(unsigned long *output, Values *view) {
            int inferred[] = {int(sizeof(inferred[0]))};
            output[0] = sizeof((*view)[0]);
            output[1] = sizeof(0[*view]);
            output[2] = sizeof(inferred);
        }",
        &[4, 4, 4],
    );
    for operand in ["view[0]", "view[0][0]", "0[view][0]"] {
        let error = rejected(&format!(
            "using Values = int[];
            __global__ void kernel(unsigned long *output, Values *view) {{
                output[0] = sizeof({operand});
            }}"
        ));
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_subscripts_rejects_invalid_types_and_unsupported_index_expressions() {
    for operand in [
        "pointer[1.0f]",
        "pointer[nullptr]",
        "pointer[pointer]",
        "index[index]",
        "pointer[record]",
        "record[index]",
        "vector[index]",
        "pointer[missing]",
        "pointer[index++]",
        "pointer[index + 1]",
        "pointer[helper()]",
        "pointer[]",
    ] {
        rejected(&format!(
            "struct Record {{ int member; }};
            __device__ int helper() {{ return 0; }}
            __global__ void kernel(unsigned long *output) {{
                int *pointer; int index; Record record; float3 vector;
                output[0] = sizeof({operand});
            }}"
        ));
    }
}

#[test]
fn cuda_sizeof_subscripts_bounds_nested_index_expressions() {
    let operand = format!("{}array{}", "0[".repeat(65), "]".repeat(65));
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long *output) {{ int array[2]; output[0] = sizeof({operand}); }}"
    ));
    assert!(error.message.contains("nesting limit"), "{error}");
}
