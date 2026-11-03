use super::helpers::validate;

fn roundtrip(source: &str) -> naga::Module {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    module
}

fn constant_global<'a>(module: &'a naga::Module, name: &str) -> &'a naga::GlobalVariable {
    let (_, global) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some(name))
        .unwrap();
    assert!(global.binding.is_some_and(|binding| binding.group == 1));
    assert_eq!(
        global.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD,
        }
    );
    assert_eq!(global.init, None);
    global
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Default::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() || range.start == source.len(), "{error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

#[test]
fn cuda_constant_memory_arrays_use_read_only_group_one_without_changing_parameter_bindings() {
    let module = roundtrip(
        "__constant__ float weights[3];
        __global__ void kernel(float *output, const float *input, unsigned count) {
            unsigned index = threadIdx.x;
            if (index < count) output[index] = input[index] * weights[index % 3u];
        }",
    );
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
        .collect();
    resources.sort_by_key(|(binding, _)| (binding.group, binding.binding));
    assert_eq!(resources.len(), 4);
    for (index, &(binding, global)) in resources[..3].iter().enumerate() {
        assert_eq!(binding.group, 0);
        assert_eq!(binding.binding, index as u32);
        assert_eq!(
            global.space,
            match index {
                0 => naga::AddressSpace::Storage {
                    access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
                },
                1 => naga::AddressSpace::Storage {
                    access: naga::StorageAccess::LOAD,
                },
                _ => naga::AddressSpace::Uniform,
            }
        );
    }
    let (binding, weights) = resources[3];
    assert_eq!(
        binding,
        naga::ResourceBinding {
            group: 1,
            binding: 0
        }
    );
    assert_eq!(weights.name.as_deref(), Some("weights"));
    assert_eq!(
        weights.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD,
        }
    );
    assert_eq!(weights.init, None);
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(length),
        stride: 4,
    } = module.types[weights.ty].inner
    else {
        panic!("expected a packed fixed constant-memory array");
    };
    assert_eq!(length.get(), 3);
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::F32)
    );
}

#[test]
fn cuda_constant_memory_reads_preserve_mutable_source_pointer_overload_selection() {
    let module = roundtrip(
        "__constant__ float weights[3];
        __device__ float read(float *value) { return value[0]; }
        __device__ unsigned choose(float *value) { return 1u; }
        __device__ unsigned choose(const float *value) { return 2u; }
        __global__ void kernel(unsigned *output) {
            float *pointer = weights;
            output[0] = unsigned(read(pointer));
            output[1] = choose(pointer);
        }",
    );
    let (weights, _) = module
        .global_variables
        .iter()
        .find(|(_, global)| {
            global.binding
                == Some(naga::ResourceBinding {
                    group: 1,
                    binding: 0,
                })
        })
        .unwrap();
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(_, expression)| *expression == naga::Expression::GlobalVariable(weights)));
    constant_global(&module, "weights");
    assert_eq!(
        module
            .global_variables
            .iter()
            .filter(|(_, global)| global.binding.is_some_and(|binding| binding.group == 1))
            .count(),
        1
    );
}

#[test]
fn cuda_constant_memory_reserves_source_order_including_unused_and_extern_resources() {
    let module = roundtrip(
        "extern __constant__ unsigned first[2];
        __constant__ float unused;
        __constant__ unsigned third;
        __constant__ unsigned first[2];
        __global__ void kernel(unsigned *output) { output[0] = first[0] + third; }",
    );
    for (binding, name) in ["first", "unused", "third"].into_iter().enumerate() {
        assert_eq!(
            constant_global(&module, name).binding,
            Some(naga::ResourceBinding {
                group: 1,
                binding: binding as u32,
            })
        );
    }
    assert_eq!(
        module
            .global_variables
            .iter()
            .filter(|(_, global)| global.binding.is_some_and(|binding| binding.group == 1))
            .count(),
        3
    );
}

#[test]
fn cuda_constant_memory_redeclarations_keep_helper_template_and_entry_point_handles() {
    let source = "using Element = unsigned;
        extern __constant__ Element values[3];
        __device__ unsigned before() { return values[0]; }
        template<int Index> __device__ unsigned selected() { return values[Index]; }
        __constant__ unsigned values[3];
        extern __device__ __constant__ Element values[3];
        __global__ void first(unsigned *output) { output[0] = before() + selected<1>(); }
        __global__ void second(unsigned *output) { output[0] = selected<2>() + values[0]; }";
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    assert_eq!(module.entry_points.len(), 2);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| global.binding.is_some_and(|binding| binding.group == 1))
        .collect();
    assert_eq!(resources.len(), 1);
    let (values, global) = resources[0];
    assert_eq!(
        global.binding,
        Some(naga::ResourceBinding {
            group: 1,
            binding: 0
        })
    );
    assert!(!info.get_entry_point(0)[values].is_empty());
    assert!(!info.get_entry_point(1)[values].is_empty());
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        for (_, expression) in function.expressions.iter() {
            if let naga::Expression::GlobalVariable(handle) = *expression {
                if module.global_variables[handle]
                    .binding
                    .is_some_and(|binding| binding.group == 1)
                {
                    assert_eq!(handle, values);
                }
            }
        }
    }
}

#[test]
fn cuda_constant_memory_numeric_scalar_and_vector_arrays_preserve_packed_strides() {
    for (ty, projection, stride) in [
        ("float", "", 4),
        ("int", "", 4),
        ("unsigned", "", 4),
        ("float2", ".y", 8),
        ("int2", ".y", 8),
        ("uint2", ".y", 8),
        ("float3", ".z", 12),
        ("int3", ".z", 12),
        ("uint3", ".z", 12),
        ("float4", ".w", 16),
        ("int4", ".w", 16),
        ("uint4", ".w", 16),
    ] {
        let module = roundtrip(&format!(
            "using Element = {ty}; __constant__ Element values[2];
            __global__ void kernel(unsigned *output) {{ output[0] = unsigned(values[1]{projection}); }}"
        ));
        let global = constant_global(&module, "values");
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(length),
            stride: actual_stride,
            ..
        } = module.types[global.ty].inner
        else {
            panic!("expected a fixed constant-memory array of {ty}");
        };
        assert_eq!(length.get(), 2);
        assert_eq!(actual_stride, stride);
        assert_eq!(
            module.types[global.ty].inner.size(module.to_ctx()),
            2 * stride
        );
    }
    for ty in ["float", "int", "unsigned", "float3", "uint4"] {
        let projection = if ty.ends_with('3') {
            ".z"
        } else if ty.ends_with('4') {
            ".w"
        } else {
            ""
        };
        roundtrip(&format!(
            "__constant__ {ty} value;
            __global__ void kernel(unsigned *output) {{ output[0] = unsigned(value{projection}); }}"
        ));
    }
}

#[test]
fn cuda_constant_memory_records_and_multidimensional_arrays_keep_existing_layouts() {
    let module = roundtrip(
        "constexpr int Width = 3;
        typedef struct { unsigned key; float3 position; unsigned values[2]; } Record;
        __constant__ Record records[2];
        __constant__ float matrix[2][Width];
        __device__ float read(float *value) { return value[0]; }
        __global__ void kernel(unsigned *output) {
            Record copy = records[1];
            output[0] = copy.key + copy.values[1] + unsigned(copy.position.z);
            output[1] = unsigned(read(matrix[1]) + matrix[0][2]);
        }",
    );
    let records = constant_global(&module, "records");
    let naga::TypeInner::Array { base, stride, .. } = module.types[records.ty].inner else {
        panic!("record array");
    };
    assert_eq!(stride, 24);
    let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
        panic!("record element");
    };
    assert_eq!(span, 24);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 4, 16]
    );
    let matrix = constant_global(&module, "matrix");
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(rows),
        stride: 12,
    } = module.types[matrix.ty].inner
    else {
        panic!("matrix rows");
    };
    assert_eq!(rows.get(), 2);
    let naga::TypeInner::Array {
        size: naga::ArraySize::Constant(columns),
        stride: 4,
        ..
    } = module.types[base].inner
    else {
        panic!("matrix columns");
    };
    assert_eq!(columns.get(), 3);
}

#[test]
fn cuda_constant_memory_source_const_and_reference_qualification_remain_distinct() {
    for qualification in ["", "const"] {
        let storage = if qualification.is_empty() {
            "__constant__"
        } else {
            "extern __constant__"
        };
        let module = roundtrip(&format!(
            "{storage} {qualification} unsigned value;
            __device__ unsigned choose(unsigned &input) {{ return 1u; }}
            __device__ unsigned choose(const unsigned &input) {{ return 2u; }}
            __device__ unsigned read(const unsigned &input) {{ return input; }}
            __global__ void kernel(unsigned *output) {{
                output[0] = read(value);
                output[1] = choose(value);
            }}"
        ));
        constant_global(&module, "value");
    }
    roundtrip(
        "__constant__ unsigned values[3];
        __device__ unsigned read(unsigned &value) { return value; }
        __global__ void kernel(unsigned *output) {
            unsigned *pointer = values; ++pointer;
            unsigned &reference = *pointer;
            auto copied = reference; ++copied;
            output[0] = read(reference) + copied;
        }",
    );
    rejected("extern __constant__ const unsigned values[2]; __global__ void kernel() { unsigned *pointer = values; }");
    rejected("extern __constant__ const unsigned value; __device__ unsigned read(unsigned &input) { return input; } __global__ void kernel(unsigned *output) { output[0] = read(value); }");
}

#[test]
fn cuda_constant_memory_pointer_state_and_conditional_reads_preserve_address_spaces() {
    roundtrip(
        "__constant__ unsigned values[3];
        __device__ unsigned read(unsigned *value) { return value[0]; }
        __global__ void kernel(unsigned *output, unsigned selector) {
            unsigned local[3]{3u, 5u, 7u};
            unsigned *pointer = values;
            unsigned first = *pointer++;
            pointer = selector == 0u ? values + 1 : local + 1;
            unsigned &reference = *pointer;
            output[0] = first + read(pointer) + reference;
            output[1] = read(selector == 0u ? values : output + 2);
        }",
    );
    roundtrip(
        "__constant__ unsigned values[2];
        __global__ void kernel(unsigned *output) {
            unsigned *pointer = values;
            unsigned copied = *pointer;
            pointer = output;
            *pointer = copied;
        }",
    );
}

#[test]
fn cuda_constant_memory_uniform_indexed_reads_allow_barriers_and_tainted_indices_do_not() {
    for index in ["0u", "blockIdx.x % 2u"] {
        roundtrip(&format!(
            "__constant__ unsigned flags[2];
            __global__ void kernel(unsigned *output) {{
                if (flags[{index}] != 0u) __syncthreads();
                output[threadIdx.x] = flags[0];
            }}"
        ));
    }
    for source in [
        "__constant__ unsigned flags[2]; __global__ void kernel() { if (flags[threadIdx.x % 2u] != 0u) __syncthreads(); }",
        "__constant__ unsigned flags[2]; __device__ void synchronize(unsigned flag) { if (flag != 0u) __syncthreads(); } __global__ void kernel() { synchronize(flags[threadIdx.x % 2u]); }",
    ] {
        rejected(source);
    }
    roundtrip("__constant__ unsigned flags[2]; __device__ void synchronize(unsigned flag) { if (flag != 0u) __syncthreads(); } __global__ void kernel() { synchronize(flags[blockIdx.x % 2u]); }");
}

#[test]
fn cuda_constant_memory_volatile_reads_require_capability_and_preserve_uniformity_taint() {
    let source = "__constant__ volatile unsigned values[2];
        __device__ unsigned read(volatile unsigned *pointer) { return pointer[0]; }
        __global__ void kernel(unsigned *output) { output[0] = read(values); }";
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        source,
        &Default::default(),
        naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    assert!(constant_global(&module, "values")
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .is_err());
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let _ = info;
    rejected("__constant__ volatile unsigned flags[2]; __global__ void kernel() { if (flags[0] != 0u) __syncthreads(); }");
    rejected("__constant__ volatile unsigned flags[2]; __device__ unsigned read(unsigned *pointer) { return pointer[0]; } __global__ void kernel(unsigned *output) { output[0] = read(flags); }");
}

#[test]
fn cuda_constant_memory_rejects_direct_member_array_and_update_writes() {
    for body in [
        "values[0] = 7u;",
        "values[0] += 7u;",
        "++values[0];",
        "values[0]--;",
        "unsigned *pointer = values; *pointer = 7u;",
        "unsigned &reference = values[0]; reference += 7u;",
        "auto &reference = values[0]; ++reference;",
    ] {
        rejected(&format!(
            "__constant__ unsigned values[2]; __global__ void kernel() {{ {body} }}"
        ));
    }
    for source in [
        "__constant__ float3 value; __global__ void kernel() { value.z = 3.0f; }",
        "struct Record { unsigned key; unsigned values[2]; }; __constant__ Record value; __global__ void kernel() { value.key = 3u; }",
        "struct Record { unsigned key; unsigned values[2]; }; __constant__ Record value; __global__ void kernel() { value.values[1]++; }",
        "struct Record { unsigned key; }; __constant__ Record values[2]; __global__ void kernel() { values[0] = Record{3u}; }",
        "__constant__ unsigned matrix[2][3]; __global__ void kernel() { matrix[1][2] = 3u; }",
        "__constant__ unsigned value; __global__ void kernel() { return; value = 3u; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_constant_memory_rejects_helper_and_mixed_pointer_state_writes() {
    for body in [
        "write(values);",
        "write(selector == 0u ? values : output);",
        "unsigned *pointer = output; pointer = values; *pointer = 7u;",
        "unsigned *pointer = values; if (selector != 0u) pointer = output; *pointer = 7u;",
        "unsigned *pointer = output; if (selector != 0u) pointer = values; *pointer = 7u;",
        "unsigned &reference = selector == 0u ? values[0] : output[0]; reference = 7u;",
        "write_ref(values[0]);",
        "write_ref(selector == 0u ? values[0] : output[0]);",
    ] {
        rejected(&format!(
            "__constant__ unsigned values[2];
            __device__ void write(unsigned *pointer) {{ pointer[0] = 7u; }}
            __device__ void write_ref(unsigned &value) {{ value = 7u; }}
            __global__ void kernel(unsigned *output, unsigned selector) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_constant_memory_rejects_direct_and_expanded_atomic_writes() {
    for expression in [
        "atomicAdd(values, 1u)",
        "atomicCAS(values, 0u, 1u)",
        "atomicExch(values, 1u)",
        "atomicMin(values, 1u)",
        "atomicInc(values, 3u)",
        "increment(values)",
        "increment(selector == 0u ? values : output)",
    ] {
        rejected(&format!(
            "__constant__ unsigned values[2];
            __device__ unsigned increment(unsigned *pointer) {{ return atomicAdd(pointer, 1u); }}
            __global__ void kernel(unsigned *output, unsigned selector) {{ output[0] = {expression}; }}"
        ));
    }
}

#[test]
fn cuda_constant_memory_rejects_incompatible_redeclarations_and_name_collisions() {
    let module = roundtrip(
        "extern __constant__ unsigned values[2];
        extern __device__ unsigned values[2];
        __global__ void kernel(unsigned *output) { output[0] = values[0]; }",
    );
    assert_eq!(
        constant_global(&module, "values").binding,
        Some(naga::ResourceBinding {
            group: 1,
            binding: 0
        })
    );
    for (declarations, specifiers) in [
        (
            "__constant__ unsigned first; __constant__ unsigned second;",
            "extern",
        ),
        (
            "__constant__ unsigned first; __constant__ unsigned second;",
            "extern __device__",
        ),
        (
            "__constant__ unsigned first;",
            "extern __device__ __constant__",
        ),
    ] {
        let module = roundtrip(&format!(
            "{declarations} {specifiers} unsigned first, second;
            __global__ void kernel(unsigned *output) {{ output[0] = first + second; }}"
        ));
        for (binding, name) in ["first", "second"].into_iter().enumerate() {
            assert_eq!(
                constant_global(&module, name).binding,
                Some(naga::ResourceBinding {
                    group: 1,
                    binding: binding as u32
                })
            );
        }
    }
    for declarations in [
        "__constant__ unsigned values[2]; __constant__ unsigned values[2];",
        "extern __constant__ unsigned values[2]; __constant__ unsigned values[3];",
        "extern __constant__ unsigned values[2]; __constant__ float values[2];",
        "extern __constant__ unsigned values[2]; extern __constant__ const unsigned values[2];",
        "extern __constant__ unsigned values[2]; extern __device__ float values[2];",
        "__constant__ unsigned values; extern __device__ unsigned values, other;",
        "__constant__ unsigned values; extern unsigned values, other;",
        "using values = unsigned; __constant__ unsigned values;",
        "constexpr unsigned values = 3u; __constant__ unsigned values;",
        "__constant__ unsigned values; constexpr unsigned values = 3u;",
        "__device__ unsigned values() { return 1u; } __constant__ unsigned values;",
        "__constant__ unsigned values; __device__ unsigned values() { return 1u; }",
    ] {
        rejected(&format!("{declarations} __global__ void kernel() {{}}"));
    }
    roundtrip("static __constant__ unsigned values[2]; extern __constant__ unsigned values[2]; __global__ void kernel(unsigned *output) { unsigned values = 7u; output[0] = values; }");
    rejected("extern __constant__ unsigned values[2]; static __constant__ unsigned values[2]; __global__ void kernel() {}");
}

#[test]
fn cuda_constant_memory_initializers_incomplete_arrays_and_invalid_storage_have_diagnostics() {
    for declaration in [
        "__constant__ unsigned value = 3u;",
        "__constant__ unsigned values[2] = {3u, 5u};",
    ] {
        let error = rejected(&format!("{declaration} __global__ void kernel() {{}}"));
        assert!(error.message.contains("initializ"), "{error}");
    }
    let error = rejected("extern __constant__ float values[]; __global__ void kernel() {}");
    assert!(
        error.message.contains("incomplete") || error.message.contains("bound"),
        "{error}"
    );
    for declaration in [
        "__constant__ bool flag;",
        "__constant__ bool flags[2];",
        "__constant__ double value;",
        "__constant__ unsigned *pointer;",
        "__constant__ unsigned &reference;",
        "__constant__ unsigned values[0];",
        "__constant__ unsigned values[-1];",
        "__constant__ unsigned values[1.5f];",
        "__constant__ unsigned values[missing];",
        "__constant__ void value;",
    ] {
        rejected(&format!(
            "/* λ */ {declaration} __global__ void kernel() {{}}"
        ));
    }
    for declaration in [
        "__constant__ const unsigned value;",
        "__constant__ const float values[2];",
        "using Frozen = const unsigned; __constant__ Frozen value;",
        "typedef struct { unsigned value; } Record; __constant__ const Record value;",
    ] {
        rejected(&format!("{declaration} __global__ void kernel() {{}}"));
    }
    for source in [
        "__global__ void kernel() { __constant__ unsigned value; }",
        "__device__ unsigned read() { static __constant__ unsigned value; return value; } __global__ void kernel() {}",
        "struct Record { __constant__ unsigned value; }; __global__ void kernel() {}",
        "__global__ void kernel(__constant__ unsigned value) {}",
        "__constant__ unsigned values[2] __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    let count = naga::valid::MAX_TYPE_SIZE / 4 + 1;
    rejected(&format!(
        "__constant__ unsigned values[{count}u]; __global__ void kernel() {{}}"
    ));
}

#[test]
fn cuda_constant_memory_lookup_does_not_capture_later_or_shadowed_symbols() {
    for source in [
        "__device__ unsigned read() { return values[0]; } __constant__ unsigned values[2]; __global__ void kernel(unsigned *output) { output[0] = read(); }",
        "template<int Index> __device__ unsigned read() { return values[Index]; } __constant__ unsigned values[2]; __global__ void kernel(unsigned *output) { output[0] = read<0>(); }",
        "__constant__ unsigned values[2]; __global__ void kernel() { unsigned values = 3u; unsigned copy = values[0]; }",
    ] {
        rejected(source);
    }
    roundtrip("__constant__ unsigned value; __device__ unsigned read() { return value; } __global__ void kernel(unsigned *output) { unsigned value = 7u; output[0] = value + read(); }");
    roundtrip("extern __shared__ unsigned scratch[]; __constant__ unsigned value; __global__ void kernel(unsigned *output) { output[0] = value; }");
    rejected("extern __shared__ unsigned values[]; __constant__ unsigned values[2]; __global__ void kernel() {}");
    rejected("__constant__ unsigned values[2]; extern __shared__ unsigned values[]; __global__ void kernel() {}");
}

#[test]
fn cuda_constant_memory_c_linkage_declarations_inherit_without_becoming_definitions() {
    for declarations in [
        "extern \"C\" __constant__ unsigned value; extern \"C\" __constant__ unsigned value; __constant__ unsigned value;",
        "extern \"C\" __constant__ const unsigned value;",
        "extern \"C\" __constant__ unsigned value; extern __constant__ unsigned value;",
    ] {
        let module = roundtrip(&format!(
            "{declarations} __global__ void kernel(unsigned *output) {{ output[0] = value; }}"
        ));
        assert_eq!(
            constant_global(&module, "value").binding,
            Some(naga::ResourceBinding { group: 1, binding: 0 })
        );
        assert_eq!(module.global_variables.len(), 2);
    }
    for declarations in [
        "extern __constant__ unsigned value; extern \"C\" __constant__ unsigned value;",
        "extern \"C\" __constant__ unsigned value; extern \"C++\" __constant__ unsigned value;",
        "extern \"C\" __constant__ unsigned value; __constant__ unsigned value; __constant__ unsigned value;",
    ] {
        rejected(&format!("{declarations} __global__ void kernel() {{}}"));
    }
}
