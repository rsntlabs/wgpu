use super::helpers::{root_expression, validate};

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

fn workgroup_variables(
    module: &naga::Module,
) -> Vec<(naga::Handle<naga::GlobalVariable>, &naga::GlobalVariable)> {
    module
        .global_variables
        .iter()
        .filter(|(_, global)| global.space == naga::AddressSpace::WorkGroup)
        .collect()
}

fn rejected(source: &str) {
    let error = naga::front::cuda::parse_str(source, &Default::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_device_shared_repeated_calls_reuse_one_workgroup_object() {
    let module = roundtrip(
        "__device__ unsigned retained(unsigned value, bool write) {
            __shared__ unsigned state;
            if (write) state = value;
            return state;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = retained(7u, true);
            output[1] = retained(0u, false);
        }",
    );
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| global.space == naga::AddressSpace::WorkGroup)
        .collect();
    assert_eq!(shared.len(), 1);
    let (state, global) = shared[0];
    assert_eq!(global.name.as_deref(), Some("state"));
    assert_eq!(global.binding, None);
    assert_eq!(global.init, None);
    assert_eq!(
        module.types[global.ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert_eq!(module.functions.len(), 1);
    let (helper_handle, helper) = module.functions.iter().next().unwrap();
    assert!(!helper
        .local_variables
        .iter()
        .any(|(_, local)| local.name.as_deref() == Some("state")));
    assert!(helper.expressions.iter().any(|(_, expression)| {
        matches!(*expression, naga::Expression::Load { pointer }
            if helper.expressions[root_expression(helper, pointer)]
                == naga::Expression::GlobalVariable(state))
    }));
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            calls.push(function);
        }
        false
    });
    assert_eq!(calls, [helper_handle, helper_handle]);
}

#[test]
fn cuda_device_shared_template_specializations_keep_distinct_fixed_arrays() {
    let module = roundtrip(
        "template<int Width> __device__ unsigned retained(unsigned value) {
            __shared__ unsigned tile[Width];
            tile[0] = value;
            return tile[0];
        }
        __global__ void kernel(unsigned *output) {
            output[0] = retained<4>(7u);
            output[1] = retained<4>(11u);
            output[2] = retained<8>(13u);
        }",
    );
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| global.space == naga::AddressSpace::WorkGroup)
        .collect();
    assert_eq!(shared.len(), 2);
    let mut lengths = Vec::new();
    for (_, global) in &shared {
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride: 4,
            ..
        } = module.types[global.ty].inner
        else {
            panic!("expected a fixed shared array");
        };
        lengths.push(count.get());
        assert_eq!(global.binding, None);
        assert_eq!(global.init, None);
    }
    lengths.sort_unstable();
    assert_eq!(lengths, [4, 8]);
    assert_eq!(module.functions.len(), 2);
    let mut referenced_globals = Vec::new();
    for (_, function) in module.functions.iter() {
        let globals: Vec<_> = function
            .expressions
            .iter()
            .filter_map(|(_, expression)| match *expression {
                naga::Expression::GlobalVariable(global)
                    if module.global_variables[global].space == naga::AddressSpace::WorkGroup =>
                {
                    Some(global)
                }
                _ => None,
            })
            .collect();
        assert_eq!(globals.len(), 1);
        referenced_globals.push(globals[0]);
    }
    assert_ne!(referenced_globals[0], referenced_globals[1]);
}

#[test]
fn cuda_device_shared_distinguishes_lexical_declarations_in_blocks_and_helpers() {
    let module = roundtrip(
        "__device__ unsigned first(unsigned value) {
            __shared__ unsigned state;
            state = value;
            unsigned result = state;
            { __shared__ unsigned state; state = value + 1u; result += state; }
            for (unsigned iteration = 0u; iteration < 2u; ++iteration) {
                __shared__ unsigned state;
                state = value + iteration;
                result += state;
            }
            return result;
        }
        __device__ unsigned second(unsigned value) {
            __shared__ unsigned state;
            state = value;
            return state;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = first(7u); output[1] = second(11u);
        }",
    );
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 4);
    assert!(shared.iter().all(|(_, global)| {
        global.name.as_deref() == Some("state") && global.binding.is_none() && global.init.is_none()
    }));
    let counts: Vec<_> = module
        .functions
        .iter()
        .map(|(_, function)| {
            function
                .expressions
                .iter()
                .filter(|&(_, expression)| {
                    matches!(*expression, naga::Expression::GlobalVariable(global)
                        if module.global_variables[global].space == naga::AddressSpace::WorkGroup)
                })
                .count()
        })
        .collect();
    assert_eq!(counts, [3, 1]);
}

#[test]
fn cuda_device_shared_keeps_one_object_under_inlining_hints_and_indirect_calls() {
    for specifier in ["inline", "static", "__forceinline__", "__noinline__"] {
        let module = roundtrip(&format!(
            "__device__ {specifier} void retained(unsigned &result, unsigned value) {{
                __shared__ unsigned state[2];
                unsigned *pointer = state;
                unsigned &reference = pointer[0];
                reference = value;
                result = reference;
            }}
            __global__ void kernel(unsigned *output) {{
                unsigned first = 0u; unsigned second = 0u;
                retained(first, 7u); retained(second, 11u);
                output[0] = first; output[1] = second;
            }}"
        ));
        assert_eq!(workgroup_variables(&module).len(), 1);
    }
}

#[test]
fn cuda_device_shared_type_specializations_and_aliases_preserve_fixed_layouts() {
    let module = roundtrip(
        "using Element = unsigned;
        constexpr unsigned Columns = 3u;
        template<class Value> __device__ Value retained(Value value) {
            constexpr unsigned Rows = 2u;
            __shared__ Value tile[Rows][Columns];
            tile[1][2] = value;
            return tile[1][2];
        }
        __global__ void kernel(unsigned *output) {
            output[0] = retained<Element>(7u);
            output[1] = __float_as_uint(retained<float>(1.5f));
            output[2] = retained<unsigned>(11u);
        }",
    );
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 2);
    let mut layouter = naga::proc::Layouter::default();
    layouter.update(module.to_ctx()).unwrap();
    let mut scalars = Vec::new();
    for (_, global) in shared {
        assert_eq!(layouter[global.ty].size, 24);
        let naga::TypeInner::Array {
            base: row,
            size: naga::ArraySize::Constant(rows),
            stride: 12,
        } = module.types[global.ty].inner
        else {
            panic!("expected two shared rows");
        };
        assert_eq!(rows.get(), 2);
        let naga::TypeInner::Array {
            base: element,
            size: naga::ArraySize::Constant(columns),
            stride: 4,
        } = module.types[row].inner
        else {
            panic!("expected three shared columns");
        };
        assert_eq!(columns.get(), 3);
        scalars.push(module.types[element].inner.clone());
    }
    assert!(scalars.contains(&naga::TypeInner::Scalar(naga::Scalar::U32)));
    assert!(scalars.contains(&naga::TypeInner::Scalar(naga::Scalar::F32)));
}

#[test]
fn cuda_device_shared_records_and_vectors_reuse_existing_type_lowering() {
    let module = roundtrip(
        "struct Record { unsigned value; float3 point; };
        __device__ unsigned retained(unsigned value) {
            __shared__ Record record;
            __shared__ float3 points[2];
            record.value = value;
            record.point = make_float3(1.0f, 2.0f, 3.0f);
            points[1] = record.point;
            return record.value + unsigned(points[1].z);
        }
        __global__ void kernel(unsigned *output) { output[0] = retained(7u); }",
    );
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 2);
    assert!(shared.iter().any(|(_, global)| {
        global.name.as_deref() == Some("record")
            && matches!(
                module.types[global.ty].inner,
                naga::TypeInner::Struct { .. }
            )
    }));
    assert!(shared.iter().any(|(_, global)| {
        global.name.as_deref() == Some("points")
            && matches!(
                module.types[global.ty].inner,
                naga::TypeInner::Array { stride: 12, .. }
            )
    }));
}

#[test]
fn cuda_device_shared_helpers_remain_shared_between_entry_points() {
    let source = "__device__ unsigned retained(unsigned value) {
        __shared__ unsigned state; state = value; return state;
    }
    __global__ void first(unsigned *output) { output[0] = retained(7u); }
    __global__ void second(unsigned *output) { output[0] = retained(11u); }";
    let (module, info) = validate(source);
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 1);
    assert_eq!(module.entry_points.len(), 2);
    for index in 0..2 {
        assert!(!info.get_entry_point(index)[shared[0].0].is_empty());
    }
    let bindings: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding)
        .collect();
    assert_eq!(
        bindings,
        [
            naga::ResourceBinding {
                group: 0,
                binding: 0
            },
            naga::ResourceBinding {
                group: 0,
                binding: 0
            },
        ]
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_device_shared_atomic_accesses_upgrade_the_shared_object() {
    for body in [
        "__shared__ unsigned counter; counter = 7u; return atomicAdd(&counter, 3u);",
        "__shared__ unsigned counters[2]; counters[0] = 7u; return atomicAdd(counters, 3u);",
    ] {
        let module = roundtrip(&format!(
            "__device__ unsigned retained() {{ {body} }}
            __global__ void kernel(unsigned *output) {{ output[0] = retained(); }}"
        ));
        let shared = workgroup_variables(&module);
        assert_eq!(shared.len(), 1);
        let mut ty = shared[0].1.ty;
        if let naga::TypeInner::Array { base, .. } = module.types[ty].inner {
            ty = base;
        }
        assert_eq!(
            module.types[ty].inner,
            naga::TypeInner::Atomic(naga::Scalar::U32)
        );
    }
}

#[test]
fn cuda_device_shared_volatile_accesses_require_the_existing_workgroup_capability() {
    let source = "__device__ unsigned retained(unsigned value) {
        __shared__ volatile unsigned state[2]; state[0] = value; return state[0];
    }
    __global__ void kernel(unsigned *output) { output[0] = retained(7u); }";
    let capabilities = naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP;
    let (module, info) = super::helpers::validate_with_options_and_capabilities(
        source,
        &Default::default(),
        capabilities,
    );
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 1);
    assert!(shared[0]
        .1
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
        capabilities,
    );
    let _ = info;
}

#[test]
fn cuda_device_shared_barriers_keep_uniform_call_and_control_requirements() {
    let helper = "__device__ unsigned neighbor(unsigned lane) {
        __shared__ unsigned tile[4]; tile[lane] = lane + 1u;
        __syncthreads(); return tile[(lane + 1u) % 4u];
    }";
    let (module, info) = super::helpers::validate_with_options(
        &format!("{helper} __global__ void kernel(unsigned *output) {{ output[threadIdx.x] = neighbor(threadIdx.x); }}"),
        &naga::front::cuda::Options {
            workgroup_size: [4, 1, 1],
            ..Default::default()
        },
    );
    assert_eq!(workgroup_variables(&module).len(), 1);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    rejected(&format!("{helper} __global__ void kernel(unsigned *output) {{ if (threadIdx.x) output[threadIdx.x] = neighbor(threadIdx.x); }}"));
    rejected("__device__ void synchronize() { __shared__ unsigned decision; if (decision) __syncthreads(); } __global__ void kernel() { synchronize(); }");
}

#[test]
fn cuda_device_shared_keeps_initializer_type_and_scope_boundaries() {
    for declaration in [
        "__shared__ unsigned state = 7u;",
        "__shared__ unsigned state{};",
        "__shared__ unsigned state[2] = {7u, 11u};",
        "__shared__ unsigned state[];",
        "__shared__ unsigned state[0];",
        "__shared__ unsigned state[-1];",
        "__shared__ unsigned state[width];",
        "__shared__ bool state;",
        "__shared__ const unsigned state;",
        "__shared__ unsigned *state;",
        "__shared__ unsigned first, second;",
        "__shared__ unsigned state; __shared__ unsigned state;",
        "{ __shared__ unsigned state; } state = 7u;",
    ] {
        rejected(&format!(
            "__device__ void retained(unsigned width) {{ {declaration} }}
            __global__ void kernel() {{}}"
        ));
    }
    rejected("struct Record { unsigned value = 7u; }; __device__ void retained() { __shared__ Record state; } __global__ void kernel() {}");
    rejected("__device__ unsigned retained() { __shared__ unsigned state; return retained(); } __global__ void kernel(unsigned *output) { output[0] = retained(); }");
}

#[test]
fn cuda_device_shared_array_layout_keeps_the_common_type_size_limit() {
    let count = naga::valid::MAX_TYPE_SIZE / 4;
    let (module, _) = validate(&format!(
        "__device__ void retained() {{ __shared__ unsigned tile[{count}u]; }}
        __global__ void kernel() {{ retained(); }}"
    ));
    let shared = workgroup_variables(&module);
    assert_eq!(shared.len(), 1);
    assert_eq!(
        module.types[shared[0].1.ty].inner.try_size(module.to_ctx()),
        Some(count * 4)
    );
    rejected(&format!(
        "__device__ void retained() {{ __shared__ unsigned tile[{}u]; }}
        __global__ void kernel() {{ retained(); }}",
        count + 1,
    ));
}
