use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/device-helper-barriers.cu");

fn options() -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    }
}

fn roundtrip_with_options(
    source: &str,
    options: &Options,
) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options(source, options);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    roundtrip_with_options(source, &options())
}

fn rejected(source: &str) {
    let error = parse_str(source, &options()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
}

fn function<'a>(
    module: &'a naga::Module,
    name: &str,
) -> (naga::Handle<naga::Function>, &'a naga::Function) {
    module
        .functions
        .iter()
        .find(|(_, function)| function.name.as_deref() == Some(name))
        .unwrap()
}

fn calls(body: &naga::Block) -> Vec<naga::Handle<naga::Function>> {
    let mut calls = Vec::new();
    naga::proc::any_statement(body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            calls.push(function);
        }
        false
    });
    calls
}

fn assert_barriers(function: &naga::Function, count: usize) {
    let mut barriers = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::ControlBarrier(flags) = *statement {
            barriers.push(flags);
        }
        false
    });
    assert_eq!(
        barriers,
        vec![naga::Barrier::WORK_GROUP | naga::Barrier::STORAGE; count]
    );
}

#[test]
fn cuda_device_helper_barriers_keep_ordinary_calls_and_accept_nonuniform_data() {
    let (module, _) = roundtrip(
        "__device__ unsigned synchronized_value(unsigned data) { __syncthreads(); return data + 1u; }
        __device__ unsigned ordinary(unsigned data) { return data + 3u; }
        __global__ void kernel(unsigned *output) {
            unsigned lane = threadIdx.x;
            output[lane] = synchronized_value(lane);
            output[4u + lane] = ordinary(lane);
            __syncthreads();
        }",
    );
    let (synchronized, helper) = function(&module, "synchronized_value");
    let (ordinary, _) = function(&module, "ordinary");
    assert_barriers(helper, 1);
    assert_barriers(&module.entry_points[0].function, 1);
    assert_eq!(
        calls(&module.entry_points[0].function.body),
        [synchronized, ordinary]
    );
    assert_eq!(function(&module, "ordinary").1.arguments.len(), 1);
    for sync in [
        "__syncthreads();",
        "cg::sync(group);",
        "group.sync();",
        "Block::sync();",
    ] {
        roundtrip(&format!(
            "namespace cg = cooperative_groups; using Block = cg::thread_block;
            __device__ void synchronize(unsigned data) {{ auto group = cg::this_thread_block(); {sync} }}
            __global__ void kernel() {{ synchronize(threadIdx.x); }}"
        ));
    }
    roundtrip("__device__ unsigned ordinary(unsigned value) { if (value) return 3u; return 7u; } __global__ void kernel(unsigned *output) { if (threadIdx.x) output[threadIdx.x] = ordinary(threadIdx.x); }");
}

#[test]
fn cuda_device_helper_barriers_follow_uniform_arguments_through_late_calls_and_control_flow() {
    let (module, _) = roundtrip(
        "__device__ void outer(unsigned count, unsigned mode);
        __device__ void inner(unsigned count, unsigned mode);
        __global__ void kernel(unsigned count, unsigned mode) { outer(count, mode); }
        __device__ void outer(unsigned count, unsigned mode) { inner(count, mode); }
        __device__ void inner(unsigned count, unsigned mode) {
            for (unsigned iteration = 0u; iteration < count; ++iteration) {
                if (mode) __syncthreads(); else __syncthreads();
                switch (mode) { case 0u: __syncthreads(); break; case 1u: __syncthreads(); default: __syncthreads(); break; }
            }
            unsigned remaining = count;
            while (remaining > 0u) { __syncthreads(); --remaining; }
            do { __syncthreads(); } while (false);
        }",
    );
    let (outer, outer_function) = function(&module, "outer");
    let (inner, _) = function(&module, "inner");
    assert_eq!(calls(&module.entry_points[0].function.body), [outer]);
    assert_eq!(calls(&outer_function.body), [inner]);
    roundtrip("__device__ void synchronize(unsigned count) { for (unsigned iteration = 0u; iteration < count; ++iteration) __syncthreads(); } __global__ void kernel() { synchronize(0u); synchronize(1u); synchronize(blockIdx.x + gridDim.x); }");
    let (module, _) = roundtrip(FIXTURE);
    for name in ["synchronize", "rounds", "finish"] {
        function(&module, name);
    }
}

#[test]
fn cuda_device_helper_barriers_distinguish_workgroup_and_invocation_builtin_provenance() {
    for predicate in [
        "blockIdx.x < gridDim.x",
        "blockIdx.y + blockIdx.z",
        "blockDim.x == 4u",
        "gridDim.x + gridDim.y + gridDim.z",
    ] {
        let (module, info) = roundtrip(&format!(
            "__device__ void synchronize() {{ if ({predicate}) __syncthreads(); }}
            __global__ void first() {{ synchronize(); }} __global__ void second() {{ synchronize(); }}"
        ));
        let (handle, _) = function(&module, "synchronize");
        for (global, variable) in module.global_variables.iter() {
            if variable.space == naga::AddressSpace::Private {
                assert!(
                    info[handle][global].is_empty(),
                    "uniform helper controls must not load private builtin storage"
                );
            }
        }
    }
    for predicate in [
        "threadIdx.x",
        "threadIdx.y + threadIdx.z",
        "blockIdx.x * blockDim.x + threadIdx.x",
    ] {
        rejected(&format!("__device__ void synchronize() {{ if ({predicate}) __syncthreads(); }} __global__ void kernel() {{ synchronize(); }}"));
    }
    roundtrip("__device__ void synchronize(unsigned count) { if (count) __syncthreads(); } __global__ void kernel(unsigned count) { if (blockIdx.x < gridDim.x) synchronize(count); }");
}

#[test]
fn cuda_device_helper_barriers_keep_helper_returns_local_to_the_call() {
    roundtrip(
        "__device__ unsigned finish(unsigned lane) {
            __syncthreads();
            if (lane) return lane + 10u;
            return 3u;
        }
        __global__ void kernel(unsigned *output) {
            output[threadIdx.x] = finish(threadIdx.x);
            __syncthreads();
        }",
    );
    roundtrip("__device__ void observe(unsigned lane) { if (lane) return; } __device__ void synchronize() { __syncthreads(); } __global__ void kernel() { observe(threadIdx.x); synchronize(); }");
    for source in [
        "__device__ void synchronize(unsigned lane) { if (lane) return; __syncthreads(); } __global__ void kernel() { synchronize(threadIdx.x); }",
        "__device__ void synchronize(unsigned lane) { __syncthreads(); if (lane) return; __syncthreads(); } __global__ void kernel() { synchronize(threadIdx.x); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel() { if (threadIdx.x) return; synchronize(); }",
    ] { rejected(source); }
}

#[test]
fn cuda_device_helper_barriers_validate_every_callsite_entry_and_divergent_exit() {
    for source in [
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel() { synchronize(); if (threadIdx.x) synchronize(); }",
        "__device__ void leaf() { __syncthreads(); } __device__ void wrapper() { leaf(); } __global__ void kernel() { if (threadIdx.x) wrapper(); }",
        "__device__ void synchronize(unsigned count) { if (count) __syncthreads(); } __global__ void first(unsigned count) { synchronize(count); } __global__ void second() { synchronize(threadIdx.x); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void first() { synchronize(); } __global__ void second() { if (threadIdx.x) synchronize(); }",
        "__device__ void synchronize(unsigned count) { for (unsigned iteration = 0u; iteration < count; ++iteration) __syncthreads(); } __global__ void kernel() { synchronize(threadIdx.x); }",
        "__device__ void synchronize(unsigned count) { if (threadIdx.x) count = 0u; for (unsigned iteration = 0u; iteration < count; ++iteration) __syncthreads(); } __global__ void kernel(unsigned count) { synchronize(count); }",
        "__device__ void synchronize(unsigned count) { switch (count) { case 0u: if (threadIdx.x) break; __syncthreads(); break; default: break; } } __global__ void kernel(unsigned count) { synchronize(count); }",
        "__device__ void synchronize(unsigned lane) { for (unsigned iteration = 0u; iteration < 3u; ++iteration) { __syncthreads(); if (lane) break; } } __global__ void kernel() { synchronize(threadIdx.x); }",
        "__device__ void synchronize(unsigned lane) { for (unsigned iteration = 0u; iteration < 3u; ++iteration) { __syncthreads(); if (lane) continue; __syncthreads(); } } __global__ void kernel() { synchronize(threadIdx.x); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel(const unsigned *input) { if (input[0]) synchronize(); }",
        "__device__ void synchronize(unsigned count) { if (count) __syncthreads(); } __global__ void kernel(unsigned *output) { synchronize(atomicAdd(output, 0u)); }",
        "__device__ unsigned lane() { return threadIdx.x; } __device__ void synchronize(unsigned count) { if (count) __syncthreads(); } __global__ void kernel() { synchronize(lane()); }",
    ] { rejected(source); }
    roundtrip("__device__ void synchronize(unsigned count) { if (count) __syncthreads(); } __global__ void first(unsigned count) { synchronize(count); } __global__ void second(unsigned count) { synchronize(count + 1u); }");
}

#[test]
fn cuda_device_helper_barriers_preserve_pointer_expansion_and_write_taint() {
    let (module, info) = roundtrip(
        "__device__ void synchronize(unsigned &value) {
            ++value;
            if (blockIdx.x < gridDim.x) __syncthreads();
        }
        __global__ void kernel(unsigned *output) {
            unsigned value = 0u;
            synchronize(value);
            output[threadIdx.x] = value;
        }",
    );
    assert_barriers(&module.entry_points[0].function, 1);
    for (global, variable) in module.global_variables.iter() {
        if variable.space == naga::AddressSpace::Private {
            assert!(!info.get_entry_point(0)[global].contains(naga::valid::GlobalUse::READ));
        }
    }
    roundtrip(
        "__device__ unsigned neighbor(unsigned *values, unsigned lane) {
            values[lane] = lane + 1u;
            __syncthreads();
            return values[(lane + 1u) % 4u];
        }
        __device__ void increment(unsigned &value) { ++value; __syncthreads(); }
        __global__ void kernel(unsigned *output) {
            __shared__ unsigned values[4];
            output[threadIdx.x] = neighbor(values, threadIdx.x);
            __syncthreads();
            increment(values[threadIdx.x]);
            output[4u + threadIdx.x] = values[threadIdx.x];
        }",
    );
    roundtrip_with_options(
        "extern __shared__ unsigned values[];
        __device__ void initialize(unsigned lane) { values[lane] = lane + 1u; __syncthreads(); }
        __device__ unsigned neighbor(unsigned lane) { return values[(lane + 1u) % 4u]; }
        __global__ void kernel(unsigned *output) { initialize(threadIdx.x); output[threadIdx.x] = neighbor(threadIdx.x); }",
        &Options { dynamic_shared_memory_size: 16, ..options() },
    );
    for source in [
        "__device__ void change(unsigned *value) { *value = threadIdx.x; __syncthreads(); } __global__ void kernel() { unsigned bound = 3u; change(&bound); for (unsigned iteration = 0u; iteration < bound; ++iteration) __syncthreads(); }",
        "__device__ void change(unsigned &value) { value = threadIdx.x; __syncthreads(); } __global__ void kernel() { unsigned bound = 3u; change(bound); if (bound) __syncthreads(); }",
        "__device__ void synchronize(unsigned *value) { if (*value) __syncthreads(); } __global__ void kernel() { __shared__ unsigned value; if (threadIdx.x == 0u) value = 3u; __syncthreads(); synchronize(&value); }",
    ] { rejected(source); }
}

#[test]
fn cuda_device_helper_barriers_bound_call_graph_and_source_depth_without_inlining() {
    let (module, _) = roundtrip(
        "__device__ void unused_divergent() { if (threadIdx.x) __syncthreads(); }
        __device__ unsigned unused_ordinary(unsigned value) { return value + 1u; }
        __device__ void synchronize() { __syncthreads(); }
        __global__ void kernel() { synchronize(); }",
    );
    assert!(!module
        .functions
        .iter()
        .any(|(_, function)| function.name.as_deref() == Some("unused_divergent")));
    rejected(
        "__device__ void unused() { __syncthreads(); missing = 1; } __global__ void kernel() {}",
    );
    let mut source =
        String::from("__device__ void helper0(unsigned count) { if (count) __syncthreads(); }");
    for index in 1..40 {
        source.push_str(&format!(
            "__device__ void helper{index}(unsigned count) {{ helper{}(count); }}",
            index - 1
        ));
    }
    source.push_str("__global__ void kernel(unsigned count) { helper39(count); }");
    let (module, _) = roundtrip(&source);
    assert_eq!(module.functions.len(), 40);
    assert_eq!(
        calls(&module.entry_points[0].function.body),
        [function(&module, "helper39").0]
    );
    assert!(module
        .functions
        .iter()
        .all(|(_, function)| function.expressions.len() < 32));
    let mut shared_dag =
        String::from("__device__ void helper0(unsigned count) { if (count) __syncthreads(); }");
    for index in 1..15 {
        shared_dag.push_str(&format!(
            "__device__ void helper{index}(unsigned count) {{ helper{}(count); helper{}(count); }}",
            index - 1,
            index - 1
        ));
    }
    roundtrip(&format!(
        "{shared_dag} __global__ void kernel(unsigned count) {{ helper14(count); }}"
    ));
    rejected(&format!(
        "{shared_dag} __global__ void kernel() {{ helper14(threadIdx.x); }}"
    ));
    rejected(&format!("__device__ void synchronize() {{ {}__syncthreads();{} }} __global__ void kernel() {{ synchronize(); }}", "{".repeat(80), "}".repeat(80)));
    rejected("__device__ void recurse() { __syncthreads(); recurse(); } __global__ void kernel() { recurse(); }");
}
