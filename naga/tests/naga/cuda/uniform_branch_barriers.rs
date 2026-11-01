use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const WORKGROUP: [u32; 3] = [4, 1, 1];
const FIXTURE: &str = include_str!("../../in/cuda/uniform-branch-barriers.cu");

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

fn rejected(source: &str) {
    let error = parse_str(
        source,
        &Options {
            workgroup_size: WORKGROUP,
            ..Options::default()
        },
    )
    .unwrap_err();
    assert!(!error.message.is_empty(), "{error}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{error}");
    assert!(source.get(range).is_some(), "{error}");
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
fn cuda_uniform_branch_barriers_accept_uniform_predicates_and_barrier_spellings() {
    for sync in [
        "__syncthreads();",
        "cg::sync(group);",
        "group.sync();",
        "Block::sync();",
    ] {
        for body in [
            format!("if (true) {{ {sync} }} if (false) {{}} else {{ {sync} }}"),
            format!("if (count) {{ {sync} }} else {{ {sync} }}"),
            format!("if ((blockIdx.x & 1u) != 0u) {{ {sync} }} else {{ {sync} }}"),
            format!("if (gridDim.x > 1u && blockDim.x == 4u) {{ {sync} }}"),
            format!("unsigned decision = count; const unsigned &view = decision; if (view) {{ {sync} }}"),
            format!("unsigned decision = count; decision += 1u; if (decision > 1u) {{ {sync} }}"),
            format!("if (count) {{ if (blockIdx.x < gridDim.x) {{ {sync} }} else {{ {sync} }} }}"),
            format!("if (count) {{ for (unsigned index = threadIdx.x; index < 16u; index += 4u) output[threadIdx.x] = index; {sync} }}"),
        ] {
            roundtrip(&kernel(&body));
        }
    }
}

#[test]
fn cuda_uniform_branch_barriers_accept_nested_switches_fallthrough_and_uniform_exits() {
    for sync in [
        "__syncthreads();",
        "cg::sync(group);",
        "group.sync();",
        "Block::sync();",
    ] {
        for body in [
            format!("switch (count) {{ case 0u: {sync} break; case 1u: {sync} default: {sync} break; }}"),
            format!("if (count) {{ switch (blockIdx.x % 3u) {{ case 0u: {sync} break; default: {sync} break; }} }}"),
            format!("switch (count) {{ case 0u: if (blockIdx.x) break; {sync} break; default: {sync} break; }}"),
            format!("for (unsigned phase = 0u; phase < 3u; ++phase) {{ switch (count) {{ case 0u: continue; default: {sync} break; }} if (phase < 2u) {{ {sync} }} }}"),
            format!("for (unsigned phase = 0u; phase < 2u; ++phase) {{ if (count) {{ switch (phase) {{ case 0u: {sync} default: {sync} break; }} }} }}"),
            format!("switch (count) {{ case 0u: switch (threadIdx.x & 1u) {{ case 0u: output[threadIdx.x] = 1u; break; default: output[threadIdx.x] = 2u; break; }} {sync} break; default: {sync} break; }}"),
        ] {
            roundtrip(&kernel(&body));
        }
    }
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
    assert_eq!(
        barriers,
        [naga::Barrier::WORK_GROUP | naga::Barrier::STORAGE; 8],
        "the default barrier is also emitted in the fallthrough case"
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_uniform_branch_barriers_reject_nonuniform_and_unproved_predicates() {
    for predicate in [
        "threadIdx.x",
        "blockIdx.x * blockDim.x + threadIdx.x",
        "output[0]",
        "atomicAdd(output, 0u)",
    ] {
        rejected(&kernel(&format!("if ({predicate}) __syncthreads();")));
        rejected(&kernel(&format!(
            "switch ({predicate}) {{ case 0u: __syncthreads(); break; default: break; }}"
        )));
    }
    for body in [
        "unsigned decision = count; if (threadIdx.x) decision = 0u; if (decision) __syncthreads();",
        "unsigned decision = count; unsigned &view = decision; view = threadIdx.x; if (decision) __syncthreads();",
        "unsigned decision = count; unsigned *view = &decision; *view = threadIdx.x; if (decision) __syncthreads();",
        "unsigned decision = threadIdx.x; unsigned saved = decision; decision = count; if (saved) __syncthreads();",
        "unsigned decision = count; const unsigned &view = decision; decision = threadIdx.x; if (view) __syncthreads();",
        "unsigned decision = 0u; for (unsigned index = 0u; index < 3u; ++index) { decision = index; if (threadIdx.x < index) break; } if (decision) __syncthreads();",
        "unsigned decision = 0u; switch (0u) { case 0u: if (threadIdx.x) break; decision = 1u; break; default: break; } if (decision) __syncthreads();",
        "__shared__ unsigned decision; if (threadIdx.x == 0u) decision = count; __syncthreads(); if (decision) __syncthreads();",
    ] {
        rejected(&kernel(body));
    }
    for source in [
        "__global__ void kernel(const unsigned *input) { if (input[0]) __syncthreads(); }",
        "__device__ unsigned opaque() { return 3u; } __global__ void kernel() { if (opaque()) __syncthreads(); }",
        "__device__ void change(unsigned &value) { value = threadIdx.x; } __global__ void kernel(unsigned count) { unsigned decision = count; change(decision); if (decision) __syncthreads(); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_uniform_branch_barriers_reject_escaping_control_flow_and_preserve_safety_guards() {
    for body in [
        "if (threadIdx.x) { if (true) __syncthreads(); }",
        "switch (threadIdx.x) { case 0u: if (count) __syncthreads(); break; default: break; }",
        "for (unsigned phase = 0u; phase < threadIdx.x; ++phase) { if (count) __syncthreads(); }",
        "switch (count) { case 0u: if (threadIdx.x) break; __syncthreads(); break; default: break; }",
        "switch (count) { case 0u: __syncthreads(); if (threadIdx.x) break; __syncthreads(); break; default: break; }",
        "switch (count) { case 0u: if (threadIdx.x) break; case 1u: __syncthreads(); break; default: break; }",
        "for (unsigned phase = 0u; phase < 2u; ++phase) { switch (count) { case 0u: if (threadIdx.x) continue; __syncthreads(); break; default: break; } __syncthreads(); }",
        "switch (count) { case 0u: if (threadIdx.x) return; __syncthreads(); break; default: break; }",
        "if (threadIdx.x) return; if (count) __syncthreads();",
        "if (count) return; switch (blockIdx.x) { case 0u: __syncthreads(); break; default: break; }",
    ] {
        rejected(&kernel(body));
    }
    roundtrip("namespace cg = cooperative_groups; __device__ void helper(unsigned count) { if (count) cg::thread_block::sync(); } __global__ void kernel(unsigned count) { helper(count); }");
    let mut body = String::new();
    for index in 0..1024 {
        body.push_str(&format!("unsigned decision{index} = 0u;"));
    }
    body.push_str("decision1023 = threadIdx.x;");
    for index in (0..1023).rev() {
        body.push_str(&format!("decision{index} = decision{};", index + 1));
    }
    for branch in [
        "if (decision0) __syncthreads();",
        "switch (decision0) { case 0u: __syncthreads(); break; default: break; }",
    ] {
        rejected(&kernel(&format!("{body}{branch}")));
    }
}
