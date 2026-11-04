use super::helpers::validate;

#[test]
fn cuda_fixed_array_aliases_preserve_nested_array_layouts_and_initialization() {
    let (module, info) = validate(
        "typedef int Row[3];
        using Matrix = Row[2];
        __global__ void kernel(int *output) {
            Row row{7, 8};
            Matrix matrix{{1}, {2, 3}};
            row[2] = 9;
            output[0] = row[0] + row[2] + matrix[1][1];
        }",
    );
    let locals = &module.entry_points[0].function.local_variables;
    let row = locals
        .iter()
        .find(|(_, variable)| variable.name.as_deref() == Some("row"))
        .unwrap()
        .1
        .ty;
    let matrix = locals
        .iter()
        .find(|(_, variable)| variable.name.as_deref() == Some("matrix"))
        .unwrap()
        .1
        .ty;
    let naga::TypeInner::Array {
        base: element,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[row].inner
    else {
        panic!("expected the row alias to retain its array type");
    };
    assert_eq!(count.get(), 3);
    assert_eq!(stride, 4);
    assert_eq!(
        module.types[element].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[matrix].inner
    else {
        panic!("expected the matrix alias to retain its nested array type");
    };
    assert_eq!(base, row);
    assert_eq!(count.get(), 2);
    assert_eq!(stride, 12);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

fn options() -> naga::front::cuda::Options {
    naga::front::cuda::Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 48,
    }
}

fn roundtrip(source: &str, capabilities: naga::valid::Capabilities) -> naga::Module {
    let (module, info) =
        super::helpers::validate_with_options_and_capabilities(source, &options(), capabilities);
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

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &options()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn local_type(module: &naga::Module, name: &str) -> naga::Handle<naga::Type> {
    module.entry_points[0]
        .function
        .local_variables
        .iter()
        .find(|(_, variable)| variable.name.as_deref() == Some(name))
        .unwrap()
        .1
        .ty
}

fn array_shape(
    module: &naga::Module,
    mut ty: naga::Handle<naga::Type>,
) -> (Vec<(u32, u32)>, naga::Handle<naga::Type>) {
    let mut dimensions = Vec::new();
    while let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[ty].inner
    {
        dimensions.push((count.get(), stride));
        ty = base;
    }
    (dimensions, ty)
}

#[test]
fn cuda_fixed_array_aliases_preserve_each_scalar_and_vector_element_type() {
    for (name, scalar) in [
        ("bool", naga::Scalar::BOOL),
        ("short", naga::Scalar::I16),
        ("unsigned short", naga::Scalar::U16),
        ("int", naga::Scalar::I32),
        ("unsigned", naga::Scalar::U32),
        ("float", naga::Scalar::F32),
    ] {
        let capabilities = if scalar.width == 2 {
            naga::valid::Capabilities::SHADER_INT16
        } else {
            naga::valid::Capabilities::empty()
        };
        for declaration in [
            format!("typedef {name} Row[3];"),
            format!("using Row = {name}[3];"),
        ] {
            let module = roundtrip(
                &format!(
                    "{declaration} using Matrix = Row[2];
                    __global__ void kernel() {{
                        {name} direct[3]{{}}; Row row{{}}; Matrix matrix{{}};
                    }}"
                ),
                capabilities,
            );
            let row = local_type(&module, "row");
            assert_eq!(row, local_type(&module, "direct"));
            let (shape, leaf) = array_shape(&module, local_type(&module, "matrix"));
            let stride = u32::from(scalar.width);
            assert_eq!(shape, [(2, 3 * stride), (3, stride)]);
            assert_eq!(module.types[leaf].inner, naga::TypeInner::Scalar(scalar));
        }
    }
    for (prefix, scalar) in [
        ("short", naga::Scalar::I16),
        ("ushort", naga::Scalar::U16),
        ("int", naga::Scalar::I32),
        ("uint", naga::Scalar::U32),
        ("float", naga::Scalar::F32),
    ] {
        for width in 1..=4 {
            let name = format!("{prefix}{width}");
            let capabilities = if scalar.width == 2 {
                naga::valid::Capabilities::SHADER_INT16
            } else {
                naga::valid::Capabilities::empty()
            };
            let module = roundtrip(
                &format!(
                    "typedef {name} Row[2]; using Matrix = Row[3];
                    __global__ void kernel() {{
                        {name} direct[2]{{}}; Row row{{}}; Matrix matrix{{}};
                        row[1].x = 7; matrix[2][1] = row[1];
                    }}"
                ),
                capabilities,
            );
            assert_eq!(local_type(&module, "row"), local_type(&module, "direct"));
            let stride = width * u32::from(scalar.width);
            assert_eq!(
                array_shape(&module, local_type(&module, "matrix")).0,
                [(3, 2 * stride), (2, stride)]
            );
        }
    }
}

#[test]
fn cuda_fixed_array_aliases_reset_each_typedef_declarator_and_preserve_binding_loci() {
    let module = roundtrip(
        "constexpr int Width = 3;
        typedef int *Pointer, Row[3], Scalar, Matrix[2][3];
        using Again = int[3]; using Row = Again;
        __global__ void kernel(int *output) {
            typedef int Width[Width];
            Width local{1, 2}; Row row{3}; Matrix matrix{{4}, {5}};
            Scalar value = 6; Pointer pointer = output;
            typedef int Element, Other[Element(3)];
            Other other{7};
            pointer[0] = local[0] + row[0] + matrix[1][0] + value + other[0];
        }",
        naga::valid::Capabilities::empty(),
    );
    assert_eq!(local_type(&module, "local"), local_type(&module, "row"));
    assert_eq!(local_type(&module, "other"), local_type(&module, "row"));
    roundtrip(
        "constexpr int Width = 3;
        __global__ void kernel(int *output) {
            using Width = int[Width]; Width values{7}; output[0] = values[0];
        }",
        naga::valid::Capabilities::empty(),
    );
    for declarations in [
        "typedef int Row[3]; using Row = int[4];",
        "using Row = int[3]; typedef unsigned Row[3];",
        "using Row = int[3]; using Row = const int[3];",
        "typedef int Row[3], Row[4];",
    ] {
        rejected(&format!("{declarations} __global__ void kernel() {{}}"));
    }
}

#[test]
fn cuda_fixed_array_aliases_keep_block_loop_and_cached_declarator_scopes() {
    let module = roundtrip(
        "using Row = float[2];
        __global__ void kernel(int *output) {
            { using Row = int[3]; { Row Row{1, 2}, next{Row[1]}; output[0] = next[0]; } }
            Row after{1.5f};
            int iteration = 0;
            for (typedef int Local[3]; iteration < 2; ++iteration) {
                Local local{iteration}; output[iteration] = local[0];
            }
            output[2] = int(after[0]);
        }",
        naga::valid::Capabilities::empty(),
    );
    assert_eq!(array_shape(&module, local_type(&module, "Row")).0, [(3, 4)]);
    let (shape, leaf) = array_shape(&module, local_type(&module, "after"));
    assert_eq!(shape, [(2, 4)]);
    assert_eq!(
        module.types[leaf].inner,
        naga::TypeInner::Scalar(naga::Scalar::F32)
    );
    for source in [
        "__global__ void kernel() { { using Row = int[3]; } Row values{}; }",
        "using Row = int[3]; __global__ void kernel() { int Row = 2; Row values{}; }",
        "__global__ void kernel() { int Row = 1; using Row = int[3]; }",
        "__global__ void kernel() { using Row = int[3]; int Row = 1; }",
        "__global__ void kernel() { int iteration = 0; for (typedef int Local[3]; iteration < 1; ++iteration) {} Local values{}; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_fixed_array_aliases_reuse_braced_parenthesized_and_inferred_outer_initializers() {
    for (declaration, expected_shape) in [
        ("Row values;", &[(3, 4)][..]),
        ("Row values{};", &[(3, 4)][..]),
        ("Row values = {1, 2};", &[(3, 4)][..]),
        ("Row values(1, values[0] + 1);", &[(3, 4)][..]),
        ("Row values[2]{{1}, {2, 3}};", &[(2, 12), (3, 4)][..]),
        ("Row values[2](1, 2, 3, 4);", &[(2, 12), (3, 4)][..]),
        ("Row values[]{{1}, {2, 3}};", &[(2, 12), (3, 4)][..]),
        ("Row values[](1, 2, 3, 4);", &[(2, 12), (3, 4)][..]),
    ] {
        let module = roundtrip(
            &format!("using Row = int[3]; __global__ void kernel() {{ {declaration} }}"),
            naga::valid::Capabilities::empty(),
        );
        let shape = array_shape(&module, local_type(&module, "values")).0;
        assert_eq!(shape, expected_shape);
    }
    let (module, _) = validate("using Row = int[3]; __global__ void kernel() { Row values; }");
    assert!(!naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| matches!(statement, naga::Statement::Store { .. })
    ));
    roundtrip(
        "using Row = int[3];
        __device__ int advance(int &value) { return value++; }
        __global__ void kernel(int *output) {
            int counter = 3; Row ordered(advance(counter), advance(counter), counter);
            for (int iteration = 0; iteration < 2; ++iteration) {
                Row reset(ordered[iteration]); output[iteration] = reset[1]; reset[1] = 9;
            }
            Row changed(3, ++changed[0], changed[0]);
            output[2] = changed[0] + changed[1] + changed[2];
        }",
        naga::valid::Capabilities::empty(),
    );
    for declaration in [
        "Row values(1, 2, 3, 4);",
        "Row values{}; Row copied = values;",
        "Row values{}; Row copied(values);",
        "Row values{}; Row other{}; values = other;",
        "Row values{}; ++values;",
        "Row values();",
    ] {
        rejected(&format!(
            "using Row = int[3]; __global__ void kernel() {{ {declaration} }}"
        ));
    }
}

#[test]
fn cuda_fixed_array_aliases_preserve_record_identity_and_dim3_defaults() {
    let module = roundtrip(
        "using Row = int[3];
        struct Item { int value; };
        using Items = Item[2];
        struct Packet { Items items; Row row; dim3 shape; };
        using Shapes = dim3[2]; using Packets = Packet[2];
        __global__ void kernel(unsigned *output) {
            Shapes shapes; Packets packets;
            Packet source{{{1}, {2}}, {3, 4}, dim3(5)};
            Packet copied = source; copied.row[1] = 7;
            output[0] = shapes[0].x + packets[1].shape.z;
            output[1] = unsigned(copied.items[1].value + copied.row[1]);
        }",
        naga::valid::Capabilities::empty(),
    );
    let (_, packet) = array_shape(&module, local_type(&module, "packets"));
    let naga::TypeInner::Struct { ref members, span } = module.types[packet].inner else {
        panic!("expected packet record");
    };
    assert_eq!(span, 32);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 8, 20]
    );
    assert_eq!(array_shape(&module, members[1].ty).0, [(3, 4)]);
    rejected(
        "struct First { int value; }; struct Second { int value; };
        using FirstRow = First[2]; using SecondRow = Second[2];
        __device__ void read(First *values) {}
        __global__ void kernel() { SecondRow values{}; read(values); }",
    );
}

#[test]
fn cuda_fixed_array_aliases_preserve_element_constness_and_volatile_access() {
    roundtrip(
        "typedef int Row[3]; using Frozen = const Row; using Frozen = const int[3];
        __device__ int read(const int *values) { return values[1]; }
        __global__ void kernel(int *output) {
            Frozen first{1, 2}; Row const second(3, 4);
            const int *view = first; output[0] = read(view) + second[1];
        }",
        naga::valid::Capabilities::empty(),
    );
    for body in [
        "const Row values;",
        "const Row values{}; values[0] = 2;",
        "const Row values{}; ++values[0];",
        "const Row values{}; values[0] += 1;",
        "const Row values{}; int *pointer = values;",
        "volatile Row values{};",
        "constexpr Row values{};",
    ] {
        rejected(&format!(
            "using Row = int[3]; __global__ void kernel() {{ {body} }}"
        ));
    }
    let module = roundtrip(
        "using Observed = volatile unsigned[3];
        __global__ void kernel(Observed input, unsigned *output) {
            __shared__ Observed shared;
            unsigned lane = threadIdx.x;
            if (lane < 3u) shared[lane] = input[lane];
            __syncthreads(); output[lane] = shared[lane % 3u];
        }",
        naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE
            | naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP,
    );
    let observed: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| {
            global.name.as_deref() == Some("input") || global.space == naga::AddressSpace::WorkGroup
        })
        .collect();
    assert_eq!(observed.len(), 2);
    assert!(observed.iter().all(|(_, global)| global
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE)));
}

#[test]
fn cuda_fixed_array_alias_parameters_adjust_one_dimension_and_preserve_prototypes() {
    roundtrip(
        "typedef int Row[3]; using Matrix = Row[2]; using Longer = int[7];
        __device__ int read(const Row);
        __device__ int read(const int *values) { return values[1]; }
        __device__ void write(Row, int);
        __device__ void write(int *values, int value) { values[1] = value; }
        __device__ int matrix(Matrix);
        __device__ int matrix(Row *values) { return values[1][2]; }
        __device__ int fixed_rows(Row values[2]);
        __device__ int fixed_rows(Row *values) { return values[0][1]; }
        __device__ int open_rows(Row values[]);
        __device__ int open_rows(Row *values) { return values[1][0]; }
        __global__ void kernel(int *output) {
            Row local{1, 2}; Longer longer{3, 4}; Matrix rows{{5, 6, 7}, {8, 9, 10}};
            write(local, 11); output[0] = read(local) + read(longer);
            output[1] = matrix(rows) + fixed_rows(rows) + open_rows(rows);
        }",
        naga::valid::Capabilities::empty(),
    );
    rejected(
        "using Row = int[3];
        __device__ int read(Row values) { values[0] = 1; return values[0]; }
        __global__ void kernel() { const Row values{}; read(values); }",
    );
}

#[test]
fn cuda_fixed_array_alias_kernel_parameters_preserve_storage_strides_and_bindings() {
    let module = roundtrip(
        "using Row = int[3]; using Matrix = Row[2];
        __global__ void kernel(const Row input, Row output, Row *rows,
                              const Matrix table, unsigned count) {
            unsigned index = threadIdx.x;
            if (index < count) {
                output[index] = input[index]; rows[index][1] = table[index][2];
            }
        }",
        naga::valid::Capabilities::empty(),
    );
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 5);
    for (index, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
        if index == 4 {
            assert_eq!(global.space, naga::AddressSpace::Uniform);
            let naga::TypeInner::Struct { ref members, span } = module.types[global.ty].inner
            else {
                panic!("expected count uniform");
            };
            assert_eq!(span, 16);
            assert_eq!(members[0].offset, 0);
            assert_eq!(
                module.types[members[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
        } else {
            assert_eq!(
                global.space,
                naga::AddressSpace::Storage {
                    access: if index == 0 || index == 3 {
                        naga::StorageAccess::LOAD
                    } else {
                        naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    },
                }
            );
            let naga::TypeInner::Array {
                base,
                size: naga::ArraySize::Dynamic,
                stride,
            } = module.types[global.ty].inner
            else {
                panic!("expected storage array");
            };
            if index < 2 {
                assert_eq!(stride, 4);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
            } else {
                assert_eq!(stride, 12);
                assert_eq!(array_shape(&module, base).0, [(3, 4)]);
            }
        }
    }
    rejected("using Row = int[3]; __global__ void kernel(Row) {}");
}

#[test]
fn cuda_fixed_array_alias_row_pointers_keep_shape_constness_and_address_arithmetic() {
    roundtrip(
        "typedef int Row[3];
        __device__ int previous(const Row *cursor) { return cursor[-1][2] + (*cursor)[1]; }
        __global__ void kernel(int *output) {
            Row rows[2]{{1, 2, 3}, {4, 5, 6}};
            Row *cursor = rows; cursor += 2; --cursor;
            Row *const fixed = &rows[0]; fixed[1][0] = 7;
            const Row *view = cursor;
            output[0] = previous(view); output[1] = (*fixed)[0];
        }",
        naga::valid::Capabilities::empty(),
    );
    for body in [
        "Row rows[2]{}; int *flattened = rows;",
        "const Row rows[2]{}; Row *writable = rows;",
        "Row rows[2]{}; Row *const fixed = rows; ++fixed;",
        "Row rows[2]{}; const Row *view = rows; view[0][1] = 1;",
        "Row *pointer = short(0);",
    ] {
        rejected(&format!(
            "using Row = int[3]; __global__ void kernel() {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_fixed_array_aliases_reuse_shared_constant_and_dynamic_storage_policies() {
    let module = roundtrip(
        "using Row = unsigned[3];
        __constant__ Row coefficients;
        __device__ unsigned read(const unsigned *values) { return values[1]; }
        __global__ void kernel(unsigned *output) {
            __shared__ Row fixed;
            extern __shared__ Row dynamic[];
            unsigned lane = threadIdx.x;
            if (lane < 3u) fixed[lane] = coefficients[lane];
            dynamic[lane][0] = lane; dynamic[lane][1] = lane + 1u; __syncthreads();
            output[lane] = fixed[lane % 3u] + read(dynamic[lane]);
        }",
        naga::valid::Capabilities::empty(),
    );
    let coefficients = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some("coefficients"))
        .unwrap()
        .1;
    assert_eq!(
        coefficients.binding,
        Some(naga::ResourceBinding {
            group: 1,
            binding: 0
        })
    );
    assert_eq!(
        coefficients.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    assert_eq!(array_shape(&module, coefficients.ty).0, [(3, 4)]);
    for source in [
        "using Flags = bool[3]; __global__ void kernel(Flags input) {}",
        "using Flags = bool[3]; __global__ void kernel(Flags *input) {}",
        "using Flags = bool[3]; __global__ void kernel() { __shared__ Flags values; }",
        "using Flags = bool[3]; struct Record { Flags values; }; __global__ void kernel() {}",
        "using Flags = bool[3]; __constant__ Flags values; __global__ void kernel() {}",
        "using Flags = bool[3]; __global__ void kernel() { extern __shared__ Flags values[]; }",
        "using Frozen = const int[3]; __global__ void kernel() { __shared__ Frozen values; }",
        "using Shapes = dim3[2]; __global__ void kernel() { __shared__ Shapes values; }",
        "using Shapes = dim3[2]; __constant__ Shapes values; __global__ void kernel() {}",
        "using Pointer = int *; using Pointers = Pointer[2]; __global__ void kernel() { Pointers values; }",
        "using Row = unsigned[3]; __constant__ Row values; __global__ void kernel() { values[0] = 1u; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_fixed_array_aliases_work_inside_existing_template_bodies_and_keep_array_boundaries() {
    roundtrip(
        "template<class Value, unsigned Count> __device__ int sum(Value seed) {
            typedef Value Row[Count]; Row values(seed, Value(2));
            return int(values[0] + values[1] + values[Count - 1u]);
        }
        template<class Value> __device__ Value first(Value *values) { return values[0]; }
        __global__ void kernel(int *output) {
            using Row = int[3]; Row values{7};
            output[0] = sum<int, 3u>(5); output[1] = first(values);
        }",
        naga::valid::Capabilities::empty(),
    );
    for (source, diagnostic) in [
        ("using Row = int[3]; __global__ void kernel() { Row values{}; Row &view = values; }", "array"),
        ("using Row = int[3]; __global__ void kernel() { Row values{}; const Row &view = values; }", "array"),
        ("using Row = int[3]; __global__ void kernel() { Row{1, 2}; }", "array"),
        ("using Row = int[3]; __global__ void kernel() { Row(1, 2); }", "array"),
        ("using Row = int[3]; __device__ Row result() {} __global__ void kernel() {}", "array"),
        ("using Row = int[3]; template<class Value> __device__ int first(Value values) { return values[0]; } __global__ void kernel(int *output) { Row values{}; output[0] = first<Row>(values); }", "unsupported template type argument"),
    ] {
        let error = rejected(source);
        assert!(error.message.contains(diagnostic), "{source}: {error}");
    }
}

#[test]
fn cuda_fixed_array_aliases_check_complete_constant_extents_rank_size_and_capabilities() {
    roundtrip(
        "constexpr unsigned Width = 3u;
        using First = int[Width]; typedef int Second[short(3)];
        using Third = int[true];
        __global__ void kernel() {
            const int Count = 3; using Local = int[Count];
            First first{}; Second second{}; Third third{}; Local local{};
        }",
        naga::valid::Capabilities::SHADER_INT16,
    );
    for bound in ["0", "-1", "1.5f", "missing", "floorf(3.0f)"] {
        rejected(&format!(
            "using Row = int[{bound}]; __global__ void kernel() {{}}"
        ));
    }
    for source in [
        "__global__ void kernel(int count) { using Row = int[count]; }",
        "__global__ void kernel() { int counter = 0; using Row = int[(counter++, 3)]; }",
        "using Row = int[2][]; __global__ void kernel() {}",
        "__device__ void unused() { using Row = int[0]; } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    roundtrip(
        "using Incomplete = int[]; __global__ void kernel() {}",
        naga::valid::Capabilities::empty(),
    );
    let too_large = naga::valid::MAX_TYPE_SIZE / 4 + 1;
    let error = rejected(&format!(
        "using Row = int[{too_large}u]; __global__ void kernel() {{}}"
    ));
    assert!(error.message.contains("size"), "{error}");
    let aliases = |rank: u32| {
        let mut source = String::from("using Level0 = int;");
        for level in 1..=rank {
            source.push_str(&format!("using Level{level} = Level{}[1];", level - 1));
        }
        source
    };
    let source = format!(
        "{} __global__ void kernel() {{ Level64 value; }}",
        aliases(64)
    );
    let (module, _) = validate(&source);
    assert_eq!(
        array_shape(&module, local_type(&module, "value")).0.len(),
        64
    );
    for source in [
        format!("{} __global__ void kernel() {{}}", aliases(65)),
        format!(
            "{} __global__ void kernel() {{ Level64 value[1]; }}",
            aliases(64)
        ),
        format!(
            "{} using More = Level64[1]; __global__ void kernel() {{}}",
            aliases(64)
        ),
    ] {
        let error = rejected(&source);
        assert!(
            error.message.contains("rank")
                || error.message.contains("nesting")
                || error.message.contains("depth"),
            "{error}"
        );
    }
    let module = naga::front::cuda::parse_str(
        "using Values = short[3]; __global__ void kernel() { Values values{}; }",
        &options(),
    )
    .unwrap();
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .is_err());
}
