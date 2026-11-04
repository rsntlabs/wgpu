use super::helpers::validate;

#[test]
fn cuda_incomplete_array_aliases_complete_local_objects_from_initializers() {
    let (module, info) = validate(
        "using Values = int[];
        __global__ void kernel() { Values values{1, 2, 3}; }",
    );
    let variable = module.entry_points[0]
        .function
        .local_variables
        .iter()
        .find(|(_, variable)| variable.name.as_deref() == Some("values"))
        .unwrap()
        .1;
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[variable.ty].inner
    else {
        panic!("expected the local object to have a complete fixed array type");
    };
    assert_eq!(count.get(), 3);
    assert_eq!(stride, 4);
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
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
    let mut shape = Vec::new();
    while let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[ty].inner
    {
        shape.push((count.get(), stride));
        ty = base;
    }
    (shape, ty)
}

#[test]
fn cuda_incomplete_array_aliases_remain_unknown_after_each_object_is_completed() {
    let module = roundtrip(
        "typedef int Values[]; using Again = Values; using Values = int[];
        __global__ void kernel(int *output) {
            Values first{1}, second{2, 3};
            Again third(4, 5, 6);
            Values last{7};
            output[0] = first[0] + second[1] + third[2] + last[0];
        }",
        naga::valid::Capabilities::empty(),
    );
    for (name, count) in [("first", 1), ("second", 2), ("third", 3), ("last", 1)] {
        let (shape, leaf) = array_shape(&module, local_type(&module, name));
        assert_eq!(shape, [(count, 4)]);
        assert_eq!(
            module.types[leaf].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
    }
    assert_eq!(local_type(&module, "first"), local_type(&module, "last"));
    let unused = roundtrip(
        "using Values = int[]; typedef Values Again; __global__ void kernel() {}",
        naga::valid::Capabilities::empty(),
    );
    assert!(unused.global_variables.is_empty());
    assert!(unused.entry_points[0].function.local_variables.is_empty());
    for declaration in [
        "typedef int Values[]; using Values = int[3];",
        "using Values = int[]; using Values = unsigned[];",
        "using Values = int[]; using Values = const int[];",
    ] {
        rejected(&format!("{declaration} __global__ void kernel() {{}}"));
    }
}

#[test]
fn cuda_incomplete_array_aliases_preserve_all_scalar_and_vector_element_layouts() {
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
            format!("typedef {name} Values[];"),
            format!("using Values = {name}[];"),
        ] {
            let module = roundtrip(
                &format!(
                    "{declaration} __global__ void kernel() {{ Values values{{{{}}, {{}}}}; }}"
                ),
                capabilities,
            );
            let (shape, leaf) = array_shape(&module, local_type(&module, "values"));
            assert_eq!(shape, [(2, u32::from(scalar.width))]);
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
                    "using Values = {name}[];
                    __global__ void kernel() {{
                        {name} source{{}}; source.x = 7;
                        Values first{{source, source}}; Values second{{source}};
                        source.x = 9;
                    }}"
                ),
                capabilities,
            );
            let stride = width * u32::from(scalar.width);
            let (first, leaf) = array_shape(&module, local_type(&module, "first"));
            let (second, other_leaf) = array_shape(&module, local_type(&module, "second"));
            assert_eq!(first, [(2, stride)]);
            assert_eq!(second, [(1, stride)]);
            assert_eq!(leaf, other_leaf);
        }
    }
}

#[test]
fn cuda_incomplete_array_aliases_preserve_fixed_inner_dimensions_and_infer_outer_rows() {
    for declaration in [
        "using Values = int[][3];",
        "typedef int Row[3]; using Values = Row[];",
        "using Row = int[3]; typedef Row Values[];",
    ] {
        for initializer in ["{{1}, {2, 3}}", "(1, 2, 3, 4)"] {
            let module = roundtrip(
                &format!(
                    "{declaration} __global__ void kernel() {{ Values values{initializer}; }}"
                ),
                naga::valid::Capabilities::empty(),
            );
            assert_eq!(
                array_shape(&module, local_type(&module, "values")).0,
                [(2, 12), (3, 4)]
            );
        }
    }
    let module = roundtrip(
        "constexpr int Width = 3;
        __global__ void kernel() {
            typedef int Width[][Width]; Width values{{1}, {2}};
        }",
        naga::valid::Capabilities::empty(),
    );
    assert_eq!(
        array_shape(&module, local_type(&module, "values")).0,
        [(2, 12), (3, 4)]
    );
    for source in [
        "using Values = int[]; using Invalid = Values[2]; __global__ void kernel() {}",
        "using Values = int[]; using Invalid = Values[]; __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { Values values[2]{{1}, {2}}; }",
        "using Values = int[]; __global__ void kernel() { Values values[]{{1}, {2}}; }",
        "using Values = int[2][]; __global__ void kernel() {}",
        "using Values = int[][]; __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_incomplete_array_aliases_keep_qualification_scopes_and_typedef_base_types() {
    let module = roundtrip(
        "typedef int Values[], Scalar; using Frozen = const Values;
        __global__ void kernel(int *output) {
            Values Values{1}, next{Values[0], 2}; Scalar scalar = 3;
            Frozen frozen{4, 5};
            { using Values = unsigned[]; Values inner{6u, 7u, 8u}; output[0] = int(inner[2]); }
            output[1] = next[1] + scalar + frozen[0];
        }",
        naga::valid::Capabilities::empty(),
    );
    assert_eq!(
        array_shape(&module, local_type(&module, "Values")).0,
        [(1, 4)]
    );
    assert_eq!(
        array_shape(&module, local_type(&module, "next")).0,
        [(2, 4)]
    );
    let (_, leaf) = array_shape(&module, local_type(&module, "inner"));
    assert_eq!(
        module.types[leaf].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    roundtrip(
        "__global__ void kernel(int *output) {
            int iteration = 0;
            for (typedef int Values[]; iteration < 2; ++iteration) {
                Values values{iteration}; output[iteration] = values[0];
            }
        }",
        naga::valid::Capabilities::empty(),
    );
    for source in [
        "using Values = int[]; __global__ void kernel() { const Values values{1}; values[0] = 2; }",
        "using Values = int[]; __global__ void kernel() { const Values values{1}; int *pointer = values; }",
        "using Values = int[]; __global__ void kernel() { volatile Values values{1}; }",
        "__global__ void kernel() { { using Values = int[]; } Values values{1}; }",
        "using Values = int[]; __global__ void kernel() { int Values = 1; Values values{2}; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_incomplete_array_aliases_preserve_ordered_self_reads_and_calls() {
    roundtrip(
        "using Values = int[]; using Points = int3[];
        __device__ int next(int &counter) { return counter++; }
        __global__ void kernel(int *output) {
            Values values{1, values[0] + 1, values[1] + 1};
            Values changed(3, ++changed[0], changed[0]);
            int counter = 5; Values ordered(next(counter), next(counter), counter);
            Points points{{1, points[0].x + 1, points[0].y + 1}, {points[0]}};
            output[0] = values[2] + changed[0] + changed[2];
            output[1] = ordered[0] + ordered[1] + ordered[2] + points[1].z;
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_aliases_reuse_pending_and_completed_constant_address_rules() {
    for expression in [
        "(values[0], 2)",
        "true ? (values[0], 2) : (values[100], 3)",
        "false ? (values[100], 3) : 2",
    ] {
        roundtrip(
            &format!("using Values = float[]; __global__ void kernel() {{ Values values{{1.0f, {expression}}}; }}"),
            naga::valid::Capabilities::empty(),
        );
    }
    for index in ["-1", "1", "100"] {
        rejected(&format!("using Values = float[]; __global__ void kernel() {{ Values values{{1.0f, (values[{index}], 2)}}; }}"));
    }
    roundtrip(
        "using Values = int[];
        __global__ void kernel() {
            Values values{1, 2}; constexpr int Count = (values[1], 3); int scratch[Count]{};
        }",
        naga::valid::Capabilities::empty(),
    );
    rejected("using Values = int[]; __global__ void kernel() { Values values{1, 2}; constexpr int Count = (values[2], 3); }");
}

#[test]
fn cuda_incomplete_array_alias_parameters_adjust_one_outer_dimension_and_preserve_bindings() {
    let module = roundtrip(
        "using Values = int[]; using Rows = int[][3];
        __device__ int read(const Values);
        __device__ int read(const int *values) { return values[1]; }
        __device__ void change(Values values) { values[0] += 4; }
        __device__ int row_sum(const Rows rows) { return rows[0][0] + rows[1][2]; }
        __global__ void kernel(const Values input, Values output, const Rows rows, unsigned count) {
            Values local{1, 2}; change(local);
            if (threadIdx.x < count) output[threadIdx.x] = input[threadIdx.x];
            if (threadIdx.x == 0u) output[0] = read(local) + row_sum(rows);
        }",
        naga::valid::Capabilities::empty(),
    );
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for (binding, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: binding as u32
            })
        );
        if binding == 3 {
            assert_eq!(global.space, naga::AddressSpace::Uniform);
            let naga::TypeInner::Struct { span, .. } = module.types[global.ty].inner else {
                panic!("expected count uniform");
            };
            assert_eq!(span, 16);
        } else {
            assert_eq!(
                global.space,
                naga::AddressSpace::Storage {
                    access: if binding == 1 {
                        naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    } else {
                        naga::StorageAccess::LOAD
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
            if binding < 2 {
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
    rejected("using Values = int[]; __device__ void change(Values values) { values[0] = 1; } __global__ void kernel() { const Values values{1}; change(values); }");
}

#[test]
fn cuda_incomplete_array_aliases_reuse_bare_extern_shared_declarations() {
    for (declarations, write, read, expected_shape) in [
        ("using Values = unsigned[]; extern __shared__ Values values; extern __shared__ unsigned values[];",
         "values[lane] = lane + 7u;", "values[neighbor]", &[(12, 4)][..]),
        ("using Row = unsigned[3]; using Values = Row[]; extern __shared__ Values values; extern __shared__ Row values[];",
         "values[lane][0] = lane; values[lane][1] = lane + 1u; values[lane][2] = lane + 2u;",
         "values[neighbor][2]", &[(4, 12), (3, 4)][..]),
    ] {
        let module = roundtrip(
            &format!("{declarations}
                __global__ void kernel(unsigned *output) {{
                    unsigned lane = threadIdx.x; unsigned neighbor = (lane + 1u) % 4u;
                    {write} __syncthreads(); output[lane] = {read};
                }}"),
            naga::valid::Capabilities::empty(),
        );
        let shared: Vec<_> = module.global_variables.iter().filter(|(_, global)| global.space == naga::AddressSpace::WorkGroup).collect();
        assert_eq!(shared.len(), 1);
        assert_eq!(array_shape(&module, shared[0].1.ty).0, expected_shape);
    }
}

#[test]
fn cuda_incomplete_array_aliases_complete_record_and_dim3_arrays_without_unsized_locals() {
    let module = roundtrip(
        "struct Record { int value; dim3 shape; };
        using Records = Record[]; using Shapes = dim3[];
        __global__ void kernel(unsigned *output) {
            Records records{{7, {}}}; Shapes shapes{dim3(3), dim3()};
            output[0] = unsigned(records[0].value) + records[0].shape.z + shapes[1].y;
        }",
        naga::valid::Capabilities::empty(),
    );
    assert_eq!(
        array_shape(&module, local_type(&module, "records")).0,
        [(1, 16)]
    );
    assert_eq!(
        array_shape(&module, local_type(&module, "shapes")).0,
        [(2, 12)]
    );
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(core::iter::once(&module.entry_points[0].function))
    {
        assert!(function.local_variables.iter().all(|(_, local)| !matches!(
            module.types[local.ty].inner,
            naga::TypeInner::Array {
                size: naga::ArraySize::Dynamic | naga::ArraySize::Pending(_),
                ..
            }
        )));
    }
    for source in [
        "using Values = int[]; struct Record { Values values; }; __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { __shared__ Values values; }",
        "using Values = int[]; __constant__ Values values; __global__ void kernel() {}",
        "using Values = int[]; extern __constant__ Values values; __global__ void kernel() {}",
        "using Values = bool[]; __global__ void kernel(Values input) {}",
        "using Values = bool[]; extern __shared__ Values values; __global__ void kernel() {}",
        "using Values = const int[]; extern __shared__ Values values; __global__ void kernel() {}",
        "using Values = dim3[]; extern __shared__ Values values; __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_incomplete_array_aliases_work_inside_existing_scalar_template_bodies() {
    roundtrip(
        "using Values = int[];
        template<class Value> __device__ Value sum(Value seed) {
            using Local = Value[]; Local first{seed}; Local second{seed, Value(2)};
            return first[0] + second[1];
        }
        template<class Value> __device__ Value first(Value *values) { return values[0]; }
        __global__ void kernel(int *output) {
            Values values{3, 4}; output[0] = sum<int>(5) + first(values);
        }",
        naga::valid::Capabilities::empty(),
    );
    rejected("using Values = int[]; template<class Value> __device__ int first(Value values) { return values[0]; } __global__ void kernel(int *output) { Values values{1}; output[0] = first<Values>(values); }");
}

#[test]
fn cuda_incomplete_array_aliases_keep_unknown_bound_pointer_and_array_value_boundaries() {
    for source in [
        "using Values = int[]; using Pointer = Values *; __global__ void kernel() {}",
        "using Values = int[]; typedef Values *Pointer; __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { Values *pointer; }",
        "using Values = int[]; __global__ void kernel(Values *input) {}",
        "using Values = int[]; __device__ void helper(Values *input) {} __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { auto pointer = static_cast<Values *>(nullptr); }",
    ] {
        roundtrip(source, naga::valid::Capabilities::empty());
    }
    for source in [
        "using Values = int[]; __global__ void kernel(int *input) { auto pointer = (Values *)input; }",
        "using Values = int[]; __global__ void kernel() { Values values{1}; Values &view = values; }",
        "using Values = int[]; __global__ void kernel() { Values{1, 2}; }",
        "using Values = int[]; __device__ Values result() {} __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    for initializer in [";", "{};", "= {};", "();", "= 1;"] {
        rejected(&format!(
            "using Values = int[]; __global__ void kernel() {{ Values values{initializer} }}"
        ));
    }
    for source in [
        "using Values = int *[]; __global__ void kernel() {}",
        "using Values = decltype(nullptr)[]; __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { constexpr Values values{1}; }",
        "using Values = int[]; __global__ void kernel() { Values values{1}; Values copied = values; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_incomplete_array_aliases_preserve_list_conversions_and_combined_rank_limits() {
    roundtrip(
        "using Values = int[]; using Samples = float[];
        __global__ void kernel(int *output) {
            Values converted(1.5f, 2.5f); Samples samples{16777218};
            output[0] = converted[0] + converted[1] + int(samples[0]);
        }",
        naga::valid::Capabilities::empty(),
    );
    for source in [
        "using Values = int[]; __global__ void kernel() { Values values{1.5f}; }",
        "using Values = unsigned[]; __global__ void kernel() { Values values{-1}; }",
        "using Values = bool[]; __global__ void kernel() { Values values{2}; }",
        "using Values = float[]; __global__ void kernel() { Values values{16777217}; }",
    ] {
        rejected(source);
    }
    let aliases = |rank: u32| {
        let mut source = String::from("using Level0 = int;");
        for level in 1..=rank {
            source.push_str(&format!("using Level{level} = Level{}[1];", level - 1));
        }
        source
    };
    validate(&format!(
        "{} using Values = Level63[]; __global__ void kernel() {{}}",
        aliases(63)
    ));
    let error = rejected(&format!(
        "{} using Values = Level64[]; __global__ void kernel() {{}}",
        aliases(64)
    ));
    assert!(
        error.message.contains("rank")
            || error.message.contains("depth")
            || error.message.contains("nesting"),
        "{error}"
    );
    let module = naga::front::cuda::parse_str(
        "using Values = short[]; __global__ void kernel() { Values values{1}; }",
        &options(),
    )
    .unwrap();
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty()
    )
    .validate(&module)
    .is_err());
}
