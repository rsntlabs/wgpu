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
        "sizeof(1)",
        "alignof(1)",
        "sizeof(value)",
        "sizeof(++value)",
        "sizeof(values[0])",
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
