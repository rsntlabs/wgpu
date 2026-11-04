use super::helpers::validate;

#[test]
fn cuda_incomplete_array_pointers_borrow_complete_local_arrays() {
    let (module, info) = validate(
        "using Values = int[];
        __global__ void kernel(int *output) {
            int values[3]{2, 3, 5};
            Values *view = &values;
            (*view)[1] += 7;
            output[0] = (*view)[0];
            output[1] = (*view)[1];
            output[2] = (*view)[2];
        }",
    );
    for (_, ty) in module.types.iter() {
        if let naga::TypeInner::Pointer {
            base,
            space: naga::AddressSpace::Function,
        } = ty.inner
        {
            assert!(!matches!(
                module.types[base].inner,
                naga::TypeInner::Array {
                    size: naga::ArraySize::Dynamic,
                    ..
                }
            ));
        }
    }
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
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        for (_, local) in function.local_variables.iter() {
            assert!(!matches!(
                module.types[local.ty].inner,
                naga::TypeInner::Array {
                    size: naga::ArraySize::Dynamic | naga::ArraySize::Pending(_),
                    ..
                }
            ));
        }
    }
    assert!(!module.types.iter().any(|(_, ty)| {
        matches!(ty.inner,
            naga::TypeInner::Pointer { base, space: naga::AddressSpace::Function }
            if matches!(module.types[base].inner,
                naga::TypeInner::Array { size: naga::ArraySize::Dynamic, .. }))
    }));
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
        .find(|(_, local)| local.name.as_deref() == Some(name))
        .unwrap()
        .1
        .ty
}

#[test]
fn cuda_incomplete_array_pointers_preserve_scalar_elements_and_complete_object_layouts() {
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
            "using Values = Element[]; using View = Values *;",
            "typedef Element Values[]; typedef Values *View;",
        ] {
            let module = roundtrip(
                &format!(
                    "using Element = {name}; {declaration}
                    __global__ void kernel(unsigned *output) {{
                        Element values[3]{{}}; View view = &values;
                        (*view)[0] = Element(1);
                        Element *elements = *view; elements[1] = (*view)[0];
                        output[0] = unsigned(elements[1]);
                    }}"
                ),
                capabilities,
            );
            let naga::TypeInner::Array { base, size, stride } =
                module.types[local_type(&module, "values")].inner
            else {
                panic!("expected the original complete scalar array");
            };
            assert_eq!(
                size,
                naga::ArraySize::Constant(core::num::NonZeroU32::new(3).unwrap())
            );
            assert_eq!(stride, u32::from(scalar.width));
            assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
        }
    }
}

#[test]
fn cuda_incomplete_array_pointers_preserve_all_vector_elements_and_packed_strides() {
    for (prefix, scalar) in [
        ("short", naga::Scalar::I16),
        ("ushort", naga::Scalar::U16),
        ("int", naga::Scalar::I32),
        ("uint", naga::Scalar::U32),
        ("float", naga::Scalar::F32),
    ] {
        for width in 1..=4 {
            let capabilities = if scalar.width == 2 {
                naga::valid::Capabilities::SHADER_INT16
            } else {
                naga::valid::Capabilities::empty()
            };
            let module = roundtrip(
                &format!(
                    "using Element = {prefix}{width}; using Values = Element[];
                    __global__ void kernel(unsigned *output) {{
                        Element values[3]{{}}; Values *view = &values;
                        (*view)[0].x = 7; (*view)[1] = (*view)[0];
                        Element *elements = *view; elements[2] = elements[1];
                        output[0] = unsigned((*view)[2].x);
                    }}"
                ),
                capabilities,
            );
            let naga::TypeInner::Array { size, stride, .. } =
                module.types[local_type(&module, "values")].inner
            else {
                panic!("expected the original complete vector array");
            };
            assert_eq!(
                size,
                naga::ArraySize::Constant(core::num::NonZeroU32::new(3).unwrap())
            );
            assert_eq!(stride, width * u32::from(scalar.width));
        }
    }
}

#[test]
fn cuda_incomplete_array_pointers_preserve_record_members_and_dim3_defaults() {
    roundtrip(
        "struct Record { int value; int samples[2]; };
        using Records = Record[]; using Shapes = dim3[];
        __device__ int read(const Records *records) {
            return (*records)[1].value + (*records)[0].samples[1];
        }
        __global__ void kernel(unsigned *output) {
            Record records[2]{{2, {3, 5}}, {7, {11, 13}}};
            Records *view = &records; (*view)[1].samples[0] += 17;
            dim3 shapes[2]{}; Shapes *shape_view = &shapes;
            (*shape_view)[1].x = 19u;
            output[0] = unsigned(read(view));
            output[1] = unsigned((*view)[1].samples[0]);
            output[2] = (*shape_view)[0].z + (*shape_view)[1].x;
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_pointers_preserve_alias_qualification_and_element_references() {
    roundtrip(
        "using Values = int[]; using View = Values *;
        using Frozen = const Values; typedef Frozen *ReadView;
        __device__ int read(ReadView);
        __device__ int read(const Values *values) { return (*values)[1]; }
        __device__ void copy(int &destination, const int &source) { destination = source; }
        __global__ void kernel(int *output) {
            int values[3]{2, 3, 5}; View view = &values;
            View direct(&values); View braced{&values}; View copied_list = {&values};
            View named = static_cast<View>(&values); View c_style = (View)&values;
            View functional = View(&values);
            View const fixed = view; const View copied = fixed;
            ReadView readonly = copied; const int &retained = (*readonly)[1];
            copy((*view)[2], retained); int &changed = (*view)[0]; ++changed;
            output[0] = read(readonly) + (*copied)[2] + changed;
            output[1] = (*direct)[0] + (*braced)[0] + (*copied_list)[0];
            output[2] = (*named)[1] + (*c_style)[1] + (*functional)[1];
        }",
        naga::valid::Capabilities::empty(),
    );
    for body in [
        "const int values[3]{2, 3, 5}; Values *view = &values;",
        "int values[3]{}; const Values *view = &values; (*view)[0] = 1;",
        "int values[3]{}; const Values *readonly = &values; Values *view = readonly;",
        "int first[3]{}, second[5]{}; Values *const fixed = &first; fixed = &second;",
    ] {
        rejected(&format!(
            "using Values = int[]; __global__ void kernel() {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_incomplete_array_pointers_rebind_different_bounds_without_retargeting_captures() {
    roundtrip(
        "using Values = int[]; using View = Values *;
        __global__ void kernel(int *output) {
            int first[3]{2, 3, 5}, second[5]{7, 11, 13, 17, 19};
            View view = &first; View saved = view; int &retained = (*view)[1];
            view = &second; retained += 23; (*saved)[0] += 29;
            (*view)[4] += 31;
            for (int step = 0; step < 4; ++step) {
                view = step % 2 == 0 ? saved : view;
                (*view)[1] += step;
                view = &second;
            }
            view = saved; view = &second;
            output[0] = first[0] + first[1]; output[1] = (*view)[4];
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_pointers_select_erased_views_and_null_values() {
    roundtrip(
        "using Values = int[]; using View = Values *;
        __device__ int read_or_default(const Values *values) {
            return values ? (*values)[1] : 37;
        }
        __global__ void kernel(int *output, unsigned choose) {
            int first[3]{2, 3, 5}, second[5]{7, 11, 13, 17, 19};
            View first_view = &first; View second_view = &second;
            View selected = choose ? first_view : second_view;
            View optional = choose ? selected : nullptr;
            View defaulted{};
            View assigned;
            if (choose) assigned = first_view; else assigned = second_view;
            output[0] = (*selected)[1]; output[1] = read_or_default(optional);
            output[2] = (*assigned)[1]; output[3] = int(optional == nullptr);
            optional = nullptr; output[4] = int(!optional);
            optional = &second; output[5] = (*optional)[4];
            output[6] = int(defaulted == nullptr);
        }",
        naga::valid::Capabilities::empty(),
    );
    roundtrip(
        "using Known = int[3]; using Values = int[];
        __global__ void kernel(int *output, unsigned choose) {
            Known known{2, 3, 5}; const Known frozen{7, 11, 13};
            int longer[5]{17, 19, 23, 29, 31}; Values *unknown = &longer;
            auto left = choose ? &known : unknown;
            auto right = choose ? unknown : &known;
            auto read_left = choose ? &frozen : unknown;
            auto read_right = choose ? unknown : &frozen;
            output[0] = (*left)[1]; output[1] = (*right)[1];
            output[2] = (*read_left)[1]; output[3] = (*read_right)[1];
        }",
        naga::valid::Capabilities::empty(),
    );
    for body in [
        "int first[3]{}, second[5]{}; Values *view = choose ? &first : &second;",
        "Values *view; output[0] = (*view)[0];",
        "Values *first; Values *second; first = second; output[0] = (*first)[0];",
        "const int frozen[3]{}; int values[5]{}; Values *view = &values; auto selected = choose ? &frozen : view; (*selected)[0] = 1;",
        "const int frozen[3]{}; int values[5]{}; Values *view = &values; auto selected = choose ? view : &frozen; (*selected)[0] = 1;",
    ] {
        rejected(&format!(
            "using Values = int[]; __global__ void kernel(int *output, unsigned choose) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_incomplete_array_pointers_forward_helper_parameters_and_scalar_templates() {
    roundtrip(
        "using Values = int[]; using View = Values *; using ReadView = const Values *;
        __device__ int read(ReadView, unsigned);
        __device__ int read(const Values *values, unsigned index) { return (*values)[index]; }
        __device__ int forward(ReadView values, unsigned index) { return read(values, index); }
        __device__ void change(View values, const int &source) { (*values)[0] += source; }
        __device__ int rebind(View values) {
            int replacement[5]{7, 11, 13, 17, 19}; values = &replacement;
            return (*values)[4];
        }
        template<class Element> __device__ Element first(Element seed) {
            Element values[2]{seed, Element(2)};
            using Items = Element[]; Items *view = &values; return (*view)[0];
        }
        template<class Element> __device__ Element read_as(const Values *values, unsigned index) {
            return Element((*values)[index]);
        }
        __global__ void kernel(int *output) {
            int first_values[3]{2, 3, 5}, second_values[5]{7, 11, 13, 17, 19};
            View view = &first_values;
            change(view, (*view)[1]); output[0] = forward(view, 0u);
            view = &second_values; output[1] = forward(view, 4u);
            output[2] = first<int>(23); output[3] = rebind(view);
            output[4] = read_as<int>(view, 4u);
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_pointers_flatten_kernel_resources_without_losing_element_stride() {
    let module = roundtrip(
        "using Values = int[]; using Points = int3[];
        __global__ void kernel(const Values *input, Values *output, const Points *points, unsigned count) {
            unsigned index = threadIdx.x;
            if (index < count) (*output)[index] = (*input)[index] + (*points)[index].z;
        }",
        naga::valid::Capabilities::empty(),
    );
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for (index, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
        if index == 3 {
            assert_eq!(global.space, naga::AddressSpace::Uniform);
            let naga::TypeInner::Struct { span, .. } = module.types[global.ty].inner else {
                panic!("expected the existing count uniform block");
            };
            assert_eq!(span, 16);
        } else {
            assert_eq!(
                global.space,
                naga::AddressSpace::Storage {
                    access: if index == 1 {
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
                panic!("expected one runtime storage array per source pointer");
            };
            assert_eq!(stride, if index == 2 { 12 } else { 4 });
            if index < 2 {
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
            }
        }
    }
    roundtrip(
        "using Rows = int[][3];
        __global__ void kernel(const Rows *input, int *output) {
            output[0] = (*input)[threadIdx.x][2];
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_pointers_keep_pre_erasure_row_offsets_and_element_decay() {
    roundtrip(
        "using Row = int[3]; using Values = int[]; using Rows = Row[];
        __device__ int read(const Values *values) { return (*values)[1]; }
        __global__ void kernel(int *output) {
            Row matrix[3]{{2, 3, 5}, {7, 11, 13}, {17, 19, 23}};
            Row *known = matrix; ++known;
            Values *view = known; known = matrix;
            Values *same = &*view; int *elements = *same;
            output[0] = read(view); output[1] = elements[2];
            Rows *rows = &matrix; Row *cursor = *rows; cursor += 2;
            (*cursor)[0] += 29; output[2] = (*rows)[2][0];
            int *previous = &(*view)[2]; output[3] = previous[-1];
        }",
        naga::valid::Capabilities::empty(),
    );
}

#[test]
fn cuda_incomplete_array_pointers_reuse_shared_and_read_only_constant_storage() {
    let module = roundtrip(
        "using Values = int[];
        __constant__ int coefficients[3];
        __device__ int read(Values *values) { return (*values)[1]; }
        __global__ void kernel(int *output) {
            __shared__ int shared[4]; Values *shared_view = &shared;
            unsigned lane = threadIdx.x; (*shared_view)[lane] = int(lane) + 7;
            __syncthreads();
            Values *constant_view = &coefficients;
            output[lane] = (*shared_view)[(lane + 1u) % 4u] + read(constant_view);
        }",
        naga::valid::Capabilities::empty(),
    );
    let (_, constant) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some("coefficients"))
        .unwrap();
    assert_eq!(
        constant.binding,
        Some(naga::ResourceBinding {
            group: 1,
            binding: 0
        })
    );
    assert_eq!(
        constant.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    roundtrip(
        "using Values = unsigned[]; extern __shared__ Values shared;
        __global__ void kernel(unsigned *output) {
            Values *view = &shared; unsigned lane = threadIdx.x;
            (*view)[lane] = lane + 11u; __syncthreads();
            output[lane] = (*view)[(lane + 1u) % 4u];
        }",
        naga::valid::Capabilities::empty(),
    );
    for body in [
        "Values *view = &coefficients; (*view)[0] = 1;",
        "Values *view = &coefficients; (*view)[0] += 1;",
        "Values *view = &coefficients; ++(*view)[0];",
        "Values *view = &coefficients; write(view);",
        "int local[3]{}; Values *first = &coefficients; Values *second = &local; Values *selected = choose ? first : second; (*selected)[0] = 1;",
    ] {
        rejected(&format!(
            "using Values = int[]; __constant__ int coefficients[3];
            __device__ void write(Values *values) {{ (*values)[0] = 1; }}
            __global__ void kernel(unsigned choose) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_incomplete_array_pointers_preserve_volatile_pointee_access_and_capabilities() {
    let source = "using Values = unsigned[];
        __global__ void kernel(volatile Values *input, unsigned *output) {
            const volatile Values *view = input;
            output[0] = (*view)[threadIdx.x];
        }";
    let module = roundtrip(
        source,
        naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let (_, input) = module
        .global_variables
        .iter()
        .find(|(_, global)| {
            global.binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 0,
                })
        })
        .unwrap();
    assert!(input
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty()
    )
    .validate(&module)
    .is_err());
}

#[test]
fn cuda_incomplete_array_pointers_capture_addresses_once_before_later_alias_changes() {
    let module = roundtrip(
        "using Row = int[3]; using Values = int[];
        __device__ int observed(int value) { return value; }
        __global__ void kernel(int *output, unsigned choose) {
            Row matrix[3]{{2, 3, 5}, {7, 11, 13}, {17, 19, 23}};
            int index = 0; Values *view = &matrix[observed(index++)];
            int &retained = (*view)[index++]; view = &matrix[2]; retained += 29;
            bool lazy = false && ((*view)[index++] != 0);
            output[0] = matrix[0][1]; output[1] = index;
            output[2] = choose ? (*view)[0] : matrix[1][0];
            output[3] = int(lazy);
        }",
        naga::valid::Capabilities::empty(),
    );
    let function = &module.entry_points[0].function;
    let mut observed_calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: called, ..
        } = *statement
        {
            if module.functions[called].name.as_deref() == Some("observed") {
                observed_calls += 1;
            }
        }
        false
    });
    assert_eq!(observed_calls, 1);
}

#[test]
fn cuda_incomplete_array_pointers_reject_whole_array_arithmetic_even_for_known_roots() {
    for expression in [
        "view + 0",
        "0 + view",
        "view - 0",
        "view + 1",
        "view - other",
        "++view",
        "view++",
        "--view",
        "view--",
        "view += 0",
        "view -= 0",
        "view[0]",
        "0[view]",
        "view[1]",
    ] {
        rejected(&format!(
            "using Values = int[]; __global__ void kernel() {{
                int first[3]{{}}, second[5]{{}};
                Values *view = &first; Values *other = &second; {expression};
            }}"
        ));
    }
}

#[test]
fn cuda_incomplete_array_pointers_keep_existing_type_conversion_and_value_boundaries() {
    for source in [
        "using Values = int[]; __global__ void kernel() { float values[3]{}; Values *view = &values; }",
        "using Values = int[]; __global__ void kernel() { int values[3]{}; Values *view = values; }",
        "using Values = int[]; __global__ void kernel() { Values *view = short(0); }",
        "using Values = int[]; using View = Values *; __device__ View result(); __global__ void kernel() {}",
        "using Values = int[]; using View = Values *; __device__ void helper(View &view) {} __global__ void kernel() {}",
        "using Values = int[]; __global__ void kernel() { int values[3]{}; Values *view = &values; Values &whole = *view; }",
        "using Values = int[]; __global__ void kernel() { int values[3]{}; Values *view = &values; Values *copy = view; bool equal = view == copy; }",
        "using Values = int[]; using Complete = int[3]; __global__ void kernel() { int values[3]{}; Values *view = &values; auto known = static_cast<Complete *>(view); }",
        "using Values = int[]; using Complete = int[3]; __global__ void kernel() { int values[3]{}; Values *view = &values; auto known = (Complete *)view; }",
        "using Values = int[]; template<class Element> __device__ int first(Element value) { return value[0]; } __global__ void kernel(int *output) { int values[3]{}; Values *view = &values; output[0] = first<Values>(*view); }",
    ] {
        rejected(source);
    }
    let module = naga::front::cuda::parse_str(
        "using Values = short[]; __global__ void kernel(unsigned *output) {
            short values[2]{2, 3}; Values *view = &values; output[0] = unsigned((*view)[1]);
        }",
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

#[test]
fn cuda_incomplete_array_pointers_rank_bound_erasure_and_qualification_equally() {
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        "using Known = int[3]; using Values = int[];
        __device__ int mutable_pick(Known *values) { return 1; }
        __device__ float mutable_pick(Values *values) { return 2.0f; }
        __device__ int const_pick(const Known *values) { return 1; }
        __device__ float const_pick(const Values *values) { return 2.0f; }
        __device__ int mixed_pick(Known *values) { return 1; }
        __device__ float mixed_pick(const Values *values) { return 2.0f; }
        __device__ int opposite_pick(const Known *values) { return 1; }
        __device__ float opposite_pick(Values *values) { return 2.0f; }
        __global__ void kernel(float *output) {
            Known values{2, 3, 5}; const Known frozen{7, 11, 13};
            int longer[5]{}; const int frozen_longer[5]{};
            Values *mutable_view = &values; const Values *read_only = &values;
            auto exact_known = mutable_pick(&values);
            auto exact_unknown = mutable_pick(mutable_view);
            auto const_known = const_pick(&frozen);
            auto const_unknown = const_pick(read_only);
            auto const_added = const_pick(mutable_view);
            auto mixed_known = mixed_pick(&values);
            auto mixed_frozen = mixed_pick(&frozen);
            auto mixed_unknown = mixed_pick(mutable_view);
            auto mixed_readonly = mixed_pick(read_only);
            auto opposite_frozen = opposite_pick(&frozen);
            auto opposite_unknown = opposite_pick(mutable_view);
            auto different_mutable = mutable_pick(&longer);
            auto different_const = const_pick(&frozen_longer);
            output[0] = float(exact_known); output[1] = exact_unknown;
            output[2] = float(const_known); output[3] = const_unknown;
            output[4] = const_added; output[5] = float(mixed_known);
            output[6] = mixed_frozen; output[7] = mixed_unknown;
            output[8] = mixed_readonly; output[9] = float(opposite_frozen);
            output[10] = opposite_unknown; output[11] = different_mutable;
            output[12] = different_const;
        }",
        &options(),
        naga::valid::Capabilities::empty(),
    );
    let function = &module.entry_points[0].function;
    let function_info = info.get_entry_point(0);
    for (name, scalar) in [
        ("exact_known", naga::Scalar::I32),
        ("exact_unknown", naga::Scalar::F32),
        ("const_known", naga::Scalar::I32),
        ("const_unknown", naga::Scalar::F32),
        ("const_added", naga::Scalar::F32),
        ("mixed_known", naga::Scalar::I32),
        ("mixed_frozen", naga::Scalar::F32),
        ("mixed_unknown", naga::Scalar::F32),
        ("mixed_readonly", naga::Scalar::F32),
        ("opposite_frozen", naga::Scalar::I32),
        ("opposite_unknown", naga::Scalar::F32),
        ("different_mutable", naga::Scalar::F32),
        ("different_const", naga::Scalar::F32),
    ] {
        let value = super::helpers::source_binding_initializer(function, name);
        assert_eq!(
            function_info[value].ty.inner_with(&module.types).scalar(),
            Some(scalar),
            "{name}"
        );
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    for declarations in [
        "__device__ int choose(const Known *values) { return 1; }
         __device__ int choose(const Values *values) { return 2; }",
        "__device__ int choose(const Known *values) { return 1; }
         __device__ int choose(Values *values) { return 2; }",
    ] {
        let error = rejected(&format!(
            "using Known = int[3]; using Values = int[]; {declarations}
            __global__ void kernel(int *output) {{ Known values{{}}; output[0] = choose(&values); }}"
        ));
        assert!(error.message.contains("ambiguous"), "{error}");
    }
}
