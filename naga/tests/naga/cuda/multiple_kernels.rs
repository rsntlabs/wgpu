use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/multiple-kernels.cu");
const WORKGROUP: [u32; 3] = [4, 1, 1];

fn roundtrip(source: &str, workgroup_size: [u32; 3]) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options(
        source,
        &Options {
            workgroup_size,
            ..Options::default()
        },
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_eq!(
            reparsed
                .entry_points
                .iter()
                .map(|entry| entry.name.as_str())
                .collect::<Vec<_>>(),
            module
                .entry_points
                .iter()
                .map(|entry| entry.name.as_str())
                .collect::<Vec<_>>()
        );
        for entry in &reparsed.entry_points {
            assert_eq!(entry.workgroup_size, workgroup_size);
        }
    }
    (module, info)
}

fn rejected(source: &str) {
    let error = parse_str(
        source,
        &Options {
            workgroup_size: WORKGROUP,
            ..Options::default()
        },
    )
    .unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
}

fn resources(
    module: &naga::Module,
    info: &naga::valid::ModuleInfo,
    entry_index: usize,
) -> Vec<naga::Handle<naga::GlobalVariable>> {
    let mut globals: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(handle, global)| {
            (global.binding.is_some() && !info.get_entry_point(entry_index)[handle].is_empty())
                .then_some(handle)
        })
        .collect();
    globals.sort_by_key(|&handle| module.global_variables[handle].binding.unwrap().binding);
    globals
}

#[test]
fn cuda_multiple_kernels_preserve_source_order_workgroup_and_independent_scopes() {
    let workgroup_size = [4, 2, 1];
    let (module, info) = roundtrip(
        "__global__ void zeta(int *values) {
            __shared__ int scratch[8];
            unsigned index = threadIdx.x + blockDim.x * threadIdx.y;
            int *cursor = values + index;
            scratch[index] = *cursor; *cursor = scratch[index] + 1;
        }
        __global__ void empty() {}
        __global__ void alpha(unsigned *values) {
            __shared__ unsigned scratch[8];
            unsigned index = threadIdx.x + blockDim.x * threadIdx.y;
            unsigned *cursor = values + index;
            scratch[index] = *cursor; *cursor = scratch[index] + 2u;
        }",
        workgroup_size,
    );
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["zeta", "empty", "alpha"]
    );
    for entry in &module.entry_points {
        assert_eq!(entry.stage, naga::ShaderStage::Compute);
        assert_eq!(entry.workgroup_size, workgroup_size);
        assert!(entry.function.result.is_none());
    }
    assert!(module.entry_points[1].function.body.is_empty());
    assert!(resources(&module, &info, 1).is_empty());
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(handle, global)| {
            (global.space == naga::AddressSpace::WorkGroup).then_some(handle)
        })
        .collect();
    assert_eq!(shared.len(), 2);
    assert!(!info.get_entry_point(0)[shared[0]].is_empty());
    assert!(info.get_entry_point(2)[shared[0]].is_empty());
    assert!(info.get_entry_point(0)[shared[1]].is_empty());
    assert!(!info.get_entry_point(2)[shared[1]].is_empty());
    roundtrip(
        "__global__ void first() {} __global__ void second() {}",
        WORKGROUP,
    );
}

#[test]
fn cuda_multiple_kernels_restart_parameter_bindings_with_independent_types_and_qualifiers() {
    let (module, info) = roundtrip(
        "__global__ void integer_values(int *values, const int *input, int amount) {
            values[0] = input[0] + amount;
        }
        __global__ void float_values(const float *values, float *input, float amount) {
            input[0] = values[0] + amount;
        }",
        WORKGROUP,
    );
    let first = resources(&module, &info, 0);
    let second = resources(&module, &info, 1);
    assert_eq!(first.len(), 3);
    assert_eq!(second.len(), 3);
    assert!(first.iter().all(|handle| !second.contains(handle)));
    for (entry_index, (globals, scalar)) in
        [(&first, naga::Scalar::I32), (&second, naga::Scalar::F32)]
            .into_iter()
            .enumerate()
    {
        for (binding, &handle) in globals.iter().enumerate() {
            let global = &module.global_variables[handle];
            assert_eq!(
                global.binding,
                Some(naga::ResourceBinding {
                    group: 0,
                    binding: binding as u32
                })
            );
            assert!(info.get_entry_point(1 - entry_index)[handle].is_empty());
            if binding == 2 {
                assert_eq!(global.space, naga::AddressSpace::Uniform);
                let naga::TypeInner::Struct {
                    ref members,
                    span: 16,
                } = module.types[global.ty].inner
                else {
                    panic!("expected the source scalar uniform block");
                };
                assert_eq!(members.len(), 1);
                assert_eq!(members[0].offset, 0);
                assert_eq!(
                    module.types[members[0].ty].inner,
                    naga::TypeInner::Scalar(scalar)
                );
            } else {
                let writable = binding == entry_index;
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: if writable {
                            naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                        } else {
                            naga::StorageAccess::LOAD
                        },
                    }
                );
                let naga::TypeInner::Array {
                    base,
                    size: naga::ArraySize::Dynamic,
                    stride: 4,
                } = module.types[global.ty].inner
                else {
                    panic!("expected the source pointer array");
                };
                assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            }
        }
    }
}

#[test]
fn cuda_multiple_kernels_initialize_late_helper_builtins_for_every_caller() {
    let (module, info) = roundtrip(FIXTURE, WORKGROUP);
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["next_neighbor", "previous_neighbor"]
    );
    let private: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(handle, global)| {
            (global.space == naga::AddressSpace::Private).then_some(handle)
        })
        .collect();
    assert_eq!(private.len(), 3);
    let coordinates: Vec<_> = module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (function.name.as_deref() == Some("coordinate")).then_some(handle)
        })
        .collect();
    assert_eq!(coordinates.len(), 1);
    for (entry_index, entry) in module.entry_points.iter().enumerate() {
        let first_call = entry
            .function
            .body
            .iter()
            .position(|statement| matches!(statement, naga::Statement::Call { .. }))
            .unwrap();
        for &global in &private {
            assert!(!info.get_entry_point(entry_index)[global].is_empty());
            assert!(entry.function.body.iter().take(first_call).any(|statement| match *statement {
                naga::Statement::Store { pointer, .. } => matches!(entry.function.expressions[pointer], naga::Expression::GlobalVariable(target) if target == global),
                _ => false,
            }));
        }
        let mut calls = Vec::new();
        naga::proc::any_statement(&entry.function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                calls.push(function);
            }
            false
        });
        assert!(calls.contains(&coordinates[0]));
        for builtin in [
            naga::BuiltIn::LocalInvocationId,
            naga::BuiltIn::WorkGroupId,
            naga::BuiltIn::NumWorkGroups,
        ] {
            assert_eq!(
                entry
                    .function
                    .arguments
                    .iter()
                    .filter(|argument| argument.binding == Some(naga::Binding::BuiltIn(builtin)))
                    .count(),
                1
            );
        }
    }
}

#[test]
fn cuda_multiple_kernels_keep_atomic_storage_views_separate_from_value_copies() {
    let (module, info) = roundtrip(
        "struct Record { unsigned value; unsigned untouched; };
        __device__ unsigned change(unsigned *value) { return atomicAdd(value, 2u); }
        __device__ Record copy_record(Record value) { value.untouched += 1u; return value; }
        __global__ void atomic_records(Record *records, unsigned *output) {
            unsigned *selected = &records[threadIdx.x].value;
            output[threadIdx.x] = change(selected);
        }
        __global__ void copy_records(const Record *records, Record *output) {
            output[threadIdx.x] = copy_record(records[threadIdx.x]);
        }",
        WORKGROUP,
    );
    for entry_index in 0..2 {
        let globals = resources(&module, &info, entry_index);
        assert_eq!(globals.len(), 2);
        let global = &module.global_variables[globals[0]];
        let naga::TypeInner::Array {
            base, stride: 8, ..
        } = module.types[global.ty].inner
        else {
            panic!("record array layout");
        };
        let naga::TypeInner::Struct {
            ref members,
            span: 8,
        } = module.types[base].inner
        else {
            panic!("record storage view");
        };
        assert_eq!(members.len(), 2);
        assert_eq!(members[0].offset, 0);
        assert_eq!(members[1].offset, 4);
        assert_eq!(
            module.types[members[0].ty].inner,
            if entry_index == 0 {
                naga::TypeInner::Atomic(naga::Scalar::U32)
            } else {
                naga::TypeInner::Scalar(naga::Scalar::U32)
            }
        );
        assert_eq!(
            module.types[members[1].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
}

#[test]
fn cuda_multiple_kernels_validate_unsafe_alternate_entries_and_complete_source() {
    for invalid in [
        "if (threadIdx.x) __syncthreads();",
        "for (unsigned iteration = 0u; iteration < threadIdx.x; ++iteration) __syncthreads();",
        "if (threadIdx.x) return; __syncthreads();",
        "int local = 3; atomicAdd(&local, 1);",
        "int *unset; atomicAdd(unset, 1);",
        "missing();",
        "return; int value = missing;",
    ] {
        for (first, second) in [("", invalid), (invalid, "")] {
            rejected(&format!(
                "__global__ void first() {{ {first} }} __global__ void second() {{ {second} }}"
            ));
        }
    }
    rejected("__device__ int missing(); __global__ void first() {} __global__ void second(int *output) { output[0] = missing(); }");
    roundtrip("__device__ void helper() { __syncthreads(); } __global__ void first() {} __global__ void second() { helper(); }", WORKGROUP);
    rejected("__device__ void helper() { __syncthreads(); } __global__ void first() {} __global__ void second() { if (threadIdx.x) helper(); }");
    rejected("__global__ void first(int *output) { output[0] = 1; } __global__ void second(const int *output) { output[0] = 2; }");
    rejected("__global__ void first() {} __global__ void second() {} /* 漢 */ @");
    roundtrip("__global__ void first() { for (unsigned iteration = 0u; iteration < 2u; ++iteration) __syncthreads(); } __global__ void second() { __syncthreads(); }", WORKGROUP);
}

#[test]
fn cuda_multiple_kernels_preserve_duplicate_definition_and_kernel_call_errors() {
    for source in [
        "__global__ void repeated() {} __global__ void repeated() {}",
        "__global__ void repeated(int *output) { output[0] = 1; } __global__ void other() {} __global__ void repeated(int *output) { output[0] = 2; }",
        "__device__ int helper(int value) { return value; } __global__ void first() {} __device__ int helper(int value) { return value; } __global__ void second() {}",
        "__global__ void first() {} __global__ void second() { first(); }",
        "__global__ void first() {} __global__ void second() { second(); }",
    ] {
        rejected(source);
    }
    assert!(parse_str("__device__ void helper() {}", &Options::default()).is_err());
    let mut source = String::new();
    for kernel_index in 0..131_072 {
        source.push_str(&format!("__global__ void entry_{kernel_index}() {{}}\n"));
    }
    let error = parse_str(&source, &Options::default()).unwrap_err();
    assert!(error.message.contains("limit"), "{error}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{error}");
    assert!(source.get(range).is_some(), "{error}");
}
