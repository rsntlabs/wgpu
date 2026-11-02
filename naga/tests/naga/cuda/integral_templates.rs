use naga::front::cuda::{parse_str, Options};
use naga::valid::{Capabilities, ModuleInfo};

use super::helpers::validate_with_options_and_capabilities;

const FIXTURE: &str = include_str!("../../in/cuda/integral-templates.cu");

fn options() -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 16,
    }
}

fn roundtrip(source: &str) -> (naga::Module, ModuleInfo) {
    let capabilities = Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP;
    let (module, info) = validate_with_options_and_capabilities(source, &options(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &options()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn calls(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut result = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            result.push(function);
        }
        false
    });
    result
}

#[test]
fn cuda_integral_templates_normalize_constant_arguments_and_dependent_bounds() {
    let source = "#define SELECTED (Width)
        using Count = const unsigned;
        constexpr unsigned Width = 3u;
        template<Count Size> __device__ unsigned bounded(unsigned value) {
            unsigned local[Size]; local[Size - 1u] = value;
            return local[Size - 1u] + Size;
        }
        template<const int Offset> __device__ int shifted(int value) { return value + Offset; }
        template<volatile bool Enabled> __device__ unsigned flag(unsigned value) {
            return Enabled ? value + 1u : value + 2u;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = bounded<SELECTED>(7u);
            output[1] = bounded<(2u + 1u)>(11u);
            output[2] = bounded<3>(13u);
            output[3] = unsigned(shifted<-2>(9));
            output[4] = flag<true>(17u);
            output[5] = flag<false>(19u);
            { unsigned bounded = 2u; output[6] = unsigned(bounded < 7u); }
        }";
    let (module, _) = roundtrip(source);
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 6);
    assert_eq!(targets[0], targets[1]);
    assert_eq!(targets[1], targets[2]);
    assert_ne!(targets[4], targets[5]);
    for target in targets {
        assert_eq!(module.functions[target].arguments.len(), 1);
    }
    roundtrip(
        "template<int First, unsigned Second, bool Enabled>
        __device__ int combine(int value) { return Enabled ? value + First + int(Second) : value; }
        __global__ void kernel(int *output) {
            const int First = 2; constexpr unsigned Second = 3u;
            output[0] = combine<First, Second, true>(7);
            output[1] = combine<(8 >> 1), 1u, false>(11);
            output[2] = combine<(3 > 2), (1u, 2u), true>(13);
        }",
    );
}

#[test]
fn cuda_integral_templates_preserve_parameter_prvalues_and_integral_conversions() {
    let (module, _) = roundtrip(
        "__device__ unsigned category(unsigned &value) { return 11u; }
        __device__ unsigned category(const unsigned &value) { return 17u; }
        template<const volatile unsigned Count> __device__ unsigned materialize() {
            const unsigned &view = Count; return view + category(Count);
        }
        template<unsigned Count> __device__ unsigned high() { return Count; }
        template<int Count> __device__ int signed_value() { return Count; }
        template<bool Enabled> __device__ unsigned flag() { return Enabled ? 1u : 0u; }
        __global__ void kernel(unsigned *output) {
            output[0] = materialize<3u>();
            output[1] = high<0xffffffffu>();
            output[2] = flag<0>(); output[3] = flag<1>();
            output[4] = unsigned(signed_value<int(2.5f)>());
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 5);
    assert_eq!(
        module.types[module.functions[targets[1]].result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    for source in [
        "template<unsigned Count> __device__ unsigned value() { unsigned &view = Count; return view; } __global__ void kernel() { value<3u>(); }",
        "__device__ void change(unsigned &value) { ++value; } template<unsigned Count> __device__ void value() { change(Count); } __global__ void kernel() { value<3u>(); }",
        "template<unsigned Count> __device__ unsigned value() { Count = 4u; return Count; } __global__ void kernel() { value<3u>(); }",
        "template<unsigned Count> __device__ unsigned value() { const unsigned *pointer = &Count; return *pointer; } __global__ void kernel() { value<3u>(); }",
        "template<unsigned Count> __device__ unsigned value() { { unsigned Count = 3u; return Count; } } __global__ void kernel() { value<2u>(); }",
        "template<int Count> __device__ int value() { return Count; } __global__ void kernel() { value<0xffffffffu>(); }",
        "template<bool Enabled> __device__ bool value() { return Enabled; } __global__ void kernel() { value<2>(); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_integral_templates_preserve_ordinary_overloads_and_definition_scope() {
    let source = "__device__ unsigned choose(unsigned value) { return value + 100u; }
        template<int Bias> __device__ unsigned choose(unsigned value) { return value + unsigned(Bias); }
        __device__ unsigned selected(float value) { return unsigned(value) + 10u; }
        template<int Count> __device__ unsigned earlier(unsigned value) { return selected(Count) + value; }
        __device__ unsigned selected(int value) { return unsigned(value) + 20u; }
        template<unsigned Bias> __device__ unsigned min(unsigned value) { return value + Bias; }
        __global__ void kernel(unsigned *output) {
            output[0] = choose(2u);
            output[1] = choose<3>(2u);
            output[2] = earlier<4>(7u);
            output[3] = min<5u>(11u);
            output[4] = min(13u, 17u);
        }";
    let (module, _) = roundtrip(source);
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 4);
    assert_ne!(targets[0], targets[1]);
    let selected = calls(&module.functions[targets[2]]);
    assert_eq!(selected.len(), 1);
    assert_eq!(module.functions[selected[0]].arguments.len(), 1);
    assert_eq!(
        module.types[module.functions[selected[0]].arguments[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::F32)
    );
    roundtrip("template<int Bias> __device__ unsigned adjusted(unsigned value) { return value + unsigned(Bias); }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 2u;
            output[0] = adjusted<3>(counter++);
            output[1] = adjusted<4>(adjusted<5>(counter++));
            output[2] = counter;
        }");
}

#[test]
fn cuda_integral_templates_keep_forward_definitions_and_indirect_qualifications() {
    roundtrip("namespace cg = cooperative_groups;
        template<int Bias> __device__ unsigned read(const volatile unsigned *, unsigned);
        template<int Bias> __device__ void write(unsigned &, unsigned);
        template<int Rounds> __device__ void synchronize(cg::thread_block group) {
            for (int iteration = 0; iteration < Rounds; ++iteration) group.sync();
        }
        template<int Bias> __device__ unsigned relay(unsigned *values, cg::thread_block group, unsigned lane) {
            unsigned value = read<Bias>(values, lane);
            write<Bias>(values[lane], value);
            synchronize<1>(group);
            return values[lane] + blockIdx.x;
        }
        __global__ void kernel(unsigned *output) {
            __shared__ unsigned values[4]; unsigned lane = threadIdx.x;
            values[lane] = lane; __syncthreads();
            output[lane] = relay<3>(values, cg::this_thread_block(), lane);
        }
        template<int Bias> __device__ unsigned read(volatile const unsigned *values, unsigned index) {
            return values[index] + unsigned(Bias);
        }
        template<int Bias> __device__ void write(unsigned &destination, unsigned value) {
            destination = value + unsigned(Bias);
        }");
    roundtrip("template<int Bias> __device__ unsigned tail(unsigned);
        template<int Bias> __device__ unsigned first(unsigned value) { return tail<Bias + 1>(value); }
        __global__ void kernel(unsigned *output) { output[0] = first<2>(7u); }
        template<int Bias> __device__ unsigned tail(unsigned value) { return value + unsigned(Bias); }");
}

#[test]
fn cuda_integral_templates_keep_kernel_instance_order_workgroup_size_and_interfaces() {
    let (module, info) = roundtrip(FIXTURE);
    let names: Vec<_> = module
        .entry_points
        .iter()
        .map(|entry| entry.name.as_str())
        .collect();
    assert_eq!(names, ["reduce<4>", "reduce<8>"]);
    for entry in &module.entry_points {
        assert_eq!(entry.workgroup_size, [4, 1, 1]);
    }
    let mut resources = Vec::new();
    for index in 0..2 {
        let used: Vec<_> = module
            .global_variables
            .iter()
            .filter(|&(handle, variable)| {
                variable.binding.is_some() && !info.get_entry_point(index)[handle].is_empty()
            })
            .collect();
        assert_eq!(used.len(), 2);
        for binding in 0..2 {
            let &(handle, variable) = used
                .iter()
                .find(|(_, variable)| {
                    variable.binding == Some(naga::ResourceBinding { group: 0, binding })
                })
                .unwrap();
            assert_eq!(
                variable.space,
                naga::AddressSpace::Storage {
                    access: if binding == 0 {
                        naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    } else {
                        naga::StorageAccess::LOAD
                    },
                }
            );
            resources.push(handle);
        }
    }
    assert_ne!(resources[0], resources[2]);
    assert_ne!(resources[1], resources[3]);
    let mut extents: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, variable)| {
            if variable.space != naga::AddressSpace::WorkGroup {
                return None;
            }
            let naga::TypeInner::Array {
                size: naga::ArraySize::Constant(count),
                stride: 4,
                ..
            } = module.types[variable.ty].inner
            else {
                panic!("shared scalar array");
            };
            Some(count.get())
        })
        .collect();
    extents.sort_unstable();
    assert_eq!(extents, [4, 8]);
}

#[test]
fn cuda_integral_templates_reject_invalid_arguments_and_unsupported_template_forms() {
    for source in [
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel(int runtime) { value<runtime>(1); }",
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel(const volatile int *input) { value<*input>(1); }",
        "template<int Count> __device__ int value() { return Count; } __global__ void kernel() { value<2.5f>(); }",
        "template<unsigned Count> __device__ unsigned value() { return Count; } __global__ void kernel() { value<-1>(); }",
        "template<bool Enabled> __device__ bool value() { return Enabled; } __global__ void kernel() { value<2>(); }",
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel() { value<>(1); }",
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel() { value<1, 2>(1); }",
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel() { value<1>(1, 2); }",
        "template<int Count> __device__ int value(int input) { return input + Count; } __global__ void kernel() { value(1); }",
        "template<int Count> __device__ int value() { Count = 3; return Count; } __global__ void kernel() { value<1>(); }",
        "template<int Count> __device__ int value() { const int *pointer = &Count; return *pointer; } __global__ void kernel() { value<1>(); }",
        "template<int Count> __device__ void write(unsigned *values) { *values = unsigned(Count); } __global__ void kernel(volatile unsigned *values) { write<1>(values); }",
        "template<int Count> __device__ int value(int); __global__ void kernel() { value<1>(2); }",
        "template<int Width> __global__ void kernel(unsigned *output) { output[0] = unsigned(Width); } template __global__ void kernel<4>(float *);",
        "template<int Count> __device__ int value() { return Count; } template<int Count> __device__ int value() { return Count + 1; } __global__ void kernel() { value<1>(); }",
        "template<int Count> __device__ int value() { int local[Count - 1]; return local[0]; } __global__ void kernel() { value<1>(); }",
        "template<int Count = 1> __device__ int value() { return Count; } __global__ void kernel() {}",
        "template<int... Counts> __device__ int value() { return 1; } __global__ void kernel() {}",
        "template<> __device__ int value<1>() { return 1; } __global__ void kernel() {}",
        "template<float Count> __device__ float value() { return Count; } __global__ void kernel() {}",
        "template<int Count> struct Record { int value; }; __global__ void kernel() {}",
        "template<int Count> __device__ int value() { if constexpr (Count) return 1; return 0; } __global__ void kernel() { value<1>(); }",
        "template<int Count> __device__ int value() { return (Count + 1; } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    roundtrip("template<int Count> __device__ int value() { int local[Count - 1]; local[0] = Count; return local[0]; } __global__ void kernel(int *output) { output[0] = value<2>(); }");
}

#[test]
fn cuda_integral_templates_bound_specialization_growth_cycles_and_source_nesting() {
    for source in [
        "template<int Count> __device__ int value(int input) { return value<Count>(input); } __global__ void kernel() { value<1>(2); }",
        "template<int Count> __device__ int first(int); template<int Count> __device__ int second(int value) { return first<Count>(value); } template<int Count> __device__ int first(int value) { return second<Count>(value); } __global__ void kernel() { first<1>(2); }",
    ] {
        rejected(source);
    }
    let growth = "template<unsigned Count> __device__ unsigned next(unsigned value) { return next<Count + 1u>(value); } __global__ void kernel() { next<0u>(1u); }";
    let error = rejected(growth);
    assert!(error.message.contains("limit"), "{error}");
    let nested = format!("template<int Count> __device__ int value() {{ return Count; }} __global__ void kernel() {{ value<{}1{}>(); }}", "(".repeat(512), ")".repeat(512));
    rejected(&nested);
    let oversized = "template<unsigned Count> __global__ void kernel(unsigned *output) { __shared__ unsigned values[Count]; values[0] = 1u; output[0] = values[0]; } template __global__ void kernel<0xffffffffu>(unsigned *);";
    let error = rejected(oversized);
    assert!(
        error.message.contains("limit") || error.message.contains("size"),
        "{error}"
    );
}

#[test]
fn cuda_integral_templates_reject_conflicting_inlining_across_prototype_chains() {
    let error = rejected(
        "template<int Count> __device__ int adjusted(int);
        template<int Count> __device__ __forceinline__ int adjusted(int);
        template<int Count> __device__ __noinline__ int adjusted(int value) { return value + Count; }
        __global__ void kernel(int *output) { output[0] = adjusted<3>(7); }",
    );
    assert!(error.message.contains("inlining specifiers"), "{error}");
}

#[test]
fn cuda_integral_templates_keep_internal_linkage_across_nonstatic_definitions() {
    roundtrip(
        "template<int Count> static __device__ int adjusted(int);
        template<int Count> __device__ int adjusted(int value) { return value + Count; }
        template<int Count> static __device__ int adjusted(int);
        __global__ void kernel(int *output) { output[0] = adjusted<3>(7); }",
    );
}

#[test]
fn cuda_integral_templates_shadow_global_aliases_in_return_types() {
    rejected(
        "using Count = int;
        template<int Count> __device__ Count value() { return Count; }
        __global__ void kernel(int *output) { output[0] = value<2>(); }",
    );
}

#[test]
fn cuda_integral_templates_shadow_global_aliases_in_later_template_formals() {
    rejected(
        "using Count = int;
        template<int Count, Count Other> __device__ int value() { return Count + Other; }
        __global__ void kernel(int *output) { output[0] = value<2,3>(); }",
    );
}

#[test]
fn cuda_integral_templates_keep_the_kernel_name_boundary_for_later_helpers() {
    rejected(
        "template<int Count> __global__ void same(unsigned *output) { output[0] = unsigned(Count); }
        __device__ void same(unsigned *output) { output[0] = 9u; }
        template __global__ void same<1>(unsigned *);",
    );
}

#[test]
fn cuda_integral_templates_reject_unparenthesized_right_shifts() {
    for argument in ["8 >> 1", "SHIFT"] {
        let source = format!(
            "#define SHIFT 8 >> 1\n\
            template<int Count> __device__ int value() {{ return Count; }}\n\
            __global__ void kernel(int *output) {{ output[0] = value<{argument}>(); }}"
        );
        rejected(&source);
    }
}

#[test]
fn cuda_integral_templates_check_unrequested_parameter_delimiters() {
    rejected(
        "template<int Count> __device__ int malformed(unsigned values[(Count]]) { return 1; }
        __global__ void kernel() {}",
    );
}

#[test]
fn cuda_integral_templates_allow_parameters_to_shadow_global_types() {
    roundtrip(
        "using Count = unsigned;
        template<int Count> __device__ int adjusted(int value) { return value + Count; }
        __global__ void kernel(int *output) { output[0] = adjusted<3>(7); }",
    );
}

#[test]
fn cuda_integral_templates_keep_canonical_selectors_in_mixed_kernel_order() {
    let (module, info) = roundtrip(
        "__global__ void first(unsigned *output) { output[0] = 1u; }
        template<unsigned Count> __global__ void counted(unsigned *output) { output[0] = Count; }
        template<bool Enabled> __global__ void active(unsigned *);
        template __global__ void active<1>(unsigned *);
        __global__ void middle(unsigned *output) { output[0] = 2u; }
        template __global__ void counted<3>(unsigned *);
        template<bool Enabled> __global__ void active(unsigned *output) { output[0] = unsigned(Enabled); }
        __global__ void last(unsigned *output) { output[0] = 3u; }",
    );
    let names: Vec<_> = module
        .entry_points
        .iter()
        .map(|entry| entry.name.as_str())
        .collect();
    assert_eq!(
        names,
        ["first", "active<true>", "middle", "counted<3u>", "last"]
    );
    for (index, entry) in module.entry_points.iter().enumerate() {
        assert_eq!(entry.workgroup_size, [4, 1, 1]);
        let resources: Vec<_> = module
            .global_variables
            .iter()
            .filter(|&(handle, global)| {
                global.binding.is_some() && !info.get_entry_point(index)[handle].is_empty()
            })
            .collect();
        assert_eq!(resources.len(), 1);
        assert_eq!(
            resources[0].1.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: 0
            })
        );
    }
}

#[test]
fn cuda_integral_templates_bound_nested_runtime_calls() {
    let mut argument = String::from("1u");
    for _ in 0..8 {
        argument = format!("adjusted<1>({argument})");
    }
    let source = |argument: &str| {
        format!(
        "template<int Bias> __device__ unsigned adjusted(unsigned value) {{ return value + unsigned(Bias); }}\n\
        __global__ void kernel(unsigned *output) {{ output[0] = {argument}; }}"
    )
    };
    roundtrip(&source(&argument));
    for _ in 0..512 {
        argument = format!("adjusted<1>({argument})");
    }
    let error = rejected(&source(&argument));
    assert!(
        error.message.contains("depth") || error.message.contains("nesting"),
        "{error}"
    );
}
