use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/uniform-loop-barriers.cu");
const WORKGROUP: [u32; 3] = [8, 1, 1];

fn roundtrip(source: &str) {
    let (module, info) = validate_with_options(
        source,
        &Options {
            workgroup_size: WORKGROUP,
            ..Options::default()
        },
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(
        source,
        &Options {
            workgroup_size: WORKGROUP,
            ..Options::default()
        },
    )
    .unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

fn kernel(body: &str) -> String {
    format!(
        "namespace cg = cooperative_groups; using Block = cg::thread_block;
        __global__ void kernel(unsigned *output, unsigned count) {{
            auto group = cg::this_thread_block(); {body}
        }}"
    )
}

#[test]
fn cuda_uniform_loop_barriers_accept_uniform_counters_loop_forms_and_workgroup_inputs() {
    for sync in [
        "__syncthreads();",
        "cg::sync(group);",
        "group.sync();",
        "Block::sync();",
    ] {
        for body in [
            format!("for (unsigned iteration = 0u; iteration < 3u; ++iteration) {{ {sync} }}"),
            format!("for (unsigned iteration = 0u; iteration < 0u; ++iteration) {{ {sync} }}"),
            format!("while (false) {{ {sync} }}"),
            format!("do {{ {sync} }} while (false);"),
            format!("unsigned remaining = count; while (remaining > 0u) {{ {sync} --remaining; }}"),
            format!("unsigned remaining = 1u; do {{ {sync} --remaining; }} while (remaining > 0u);"),
            format!("for (unsigned stride = 4u; stride > 0u; stride >>= 1u) {{ {sync} }}"),
            format!("for (unsigned iteration = 0u; iteration < blockIdx.x + gridDim.x; ++iteration) {{ {sync} }}"),
            format!("for (unsigned outer = 0u; outer < 2u; ++outer) {{ for (unsigned inner = 0u; inner < 3u; ++inner) {{ {sync} }} }}"),
        ] {
            roundtrip(&kernel(&body));
        }
    }
}

#[test]
fn cuda_uniform_loop_barriers_reconverge_after_divergent_gathers_and_data_only_branches() {
    let (module, info) = validate_with_options(
        FIXTURE,
        &Options {
            workgroup_size: WORKGROUP,
            ..Options::default()
        },
    );
    let mut barriers = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::ControlBarrier(flags) = *statement {
            barriers.push(flags);
        }
        false
    });
    assert!(!barriers.is_empty());
    assert!(barriers
        .iter()
        .all(|&flags| flags == (naga::Barrier::WORK_GROUP | naga::Barrier::STORAGE)));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    roundtrip(&kernel(
        "unsigned observed = 0u;
        for (unsigned index = 0u; index < 3u; ++index) {
            observed = index; if (threadIdx.x < index) break;
        }
        if (threadIdx.x) output[threadIdx.x] = observed;
        for (unsigned stride = 4u; stride > 0u; stride >>= 1u) {
            __syncthreads(); if (threadIdx.x < stride) output[threadIdx.x] += stride;
        }",
    ));
    roundtrip(&kernel(
        "for (unsigned phase = 0u; phase < 2u; ++phase) {
        for (unsigned index = threadIdx.x; index < count; index += 8u) output[threadIdx.x] = index;
        __syncthreads();
    }",
    ));
}

#[test]
fn cuda_uniform_loop_barriers_reject_divergent_conditions_exits_and_backedge_taint() {
    for body in [
        "for (unsigned index = threadIdx.x; index < 4u; ++index) { __syncthreads(); }",
        "for (unsigned index = 0u; index < threadIdx.x + 1u; ++index) { __syncthreads(); }",
        "for (unsigned index = 0u; index < 3u; ++index) { if (threadIdx.x) break; __syncthreads(); }",
        "for (unsigned index = 0u; index < 3u; ++index) { __syncthreads(); if (threadIdx.x) break; }",
        "for (unsigned index = 0u; index < 3u; ++index) { if (threadIdx.x) continue; __syncthreads(); }",
        "for (unsigned index = 0u; index < 3u; ++index) { __syncthreads(); if (threadIdx.x) continue; __syncthreads(); }",
        "for (unsigned index = 0u; index < 3u; ++index) { __syncthreads(); if (threadIdx.x) return; }",
        "unsigned bound = 0u; if (threadIdx.x) bound = 3u; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); }",
        "unsigned stride = 4u; for (; stride > 0u; stride >>= 1u) { __syncthreads(); if (threadIdx.x) stride = 0u; }",
        "unsigned bound = 0u; for (unsigned index = 0u; index < 3u; ++index) { bound = index; if (threadIdx.x < index) break; } for (unsigned index = bound; index > 0u; --index) { __syncthreads(); }",
        "unsigned bound = threadIdx.x; unsigned saved = bound; bound = 3u; for (unsigned index = 0u; index < saved; ++index) { __syncthreads(); }",
    ] {
        rejected(&kernel(body));
    }
    let mut body = String::new();
    for index in 0..1024 {
        body.push_str(&format!("unsigned bound{index} = 0u;"));
    }
    body.push_str("bound1023 = threadIdx.x;");
    for index in (0..1023).rev() {
        body.push_str(&format!("bound{index} = bound{};", index + 1));
    }
    body.push_str(
        "for (unsigned iteration = 0u; iteration < bound0; ++iteration) { __syncthreads(); }",
    );
    rejected(&kernel(&body));
}

#[test]
fn cuda_uniform_loop_barriers_keep_unproved_bounds_and_existing_placement_restrictions() {
    roundtrip("__global__ void kernel(const unsigned *input) { unsigned bound = input[0]; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); } }");
    for body in [
        "for (unsigned index = 0u; index < 3u; ++index) { if (true) { __syncthreads(); } }",
        "for (unsigned index = 0u; index < 3u; ++index) { switch (0u) { case 0u: __syncthreads(); break; default: break; } }",
    ] {
        roundtrip(&kernel(body));
    }
    for body in [
        "unsigned bound = output[0]; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); }",
        "__shared__ unsigned bound; if (threadIdx.x == 0u) bound = 3u; __syncthreads(); for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); }",
        "unsigned bound = 3u; unsigned &alias = bound; alias = threadIdx.x; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); }",
        "unsigned bound = 0u; switch (0u) { case 0u: if (threadIdx.x) break; bound = 1u; break; default: break; } for (unsigned index = bound; index > 0u; --index) { __syncthreads(); }",
        "if (threadIdx.x) return; for (unsigned index = 0u; index < 3u; ++index) { __syncthreads(); }",
        "for (unsigned index = 0u; index < 3u; ++index) { if (threadIdx.x) { __syncthreads(); } }",
        "for (unsigned index = 0u; index < 3u; ++index) { switch (threadIdx.x) { case 0u: __syncthreads(); break; default: break; } }",
    ] { rejected(&kernel(body)); }
    for source in [
        "__global__ void kernel(const unsigned *input) { unsigned bound = input[threadIdx.x]; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); } }",
        "__device__ unsigned opaque() { return 3u; } __global__ void kernel() { for (unsigned index = 0u; index < opaque(); ++index) { __syncthreads(); } }",
        "__device__ void alter(unsigned &value) { value = threadIdx.x; } __global__ void kernel() { unsigned bound = 3u; for (unsigned index = 0u; index < bound; ++index) { __syncthreads(); alter(bound); } }",
    ] { rejected(source); }
    roundtrip("__device__ void helper() { for (unsigned index = 0u; index < 3u; ++index) { __syncthreads(); } } __global__ void kernel() { helper(); }");
}
