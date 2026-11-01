use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate_with_options};

const FIXTURE: &str = include_str!("../../in/cuda/thread-block-dimensions.cu");
const WORKGROUP: [u32; 3] = [4, 3, 2];
const METHODS: [&str; 4] = ["group_index", "thread_index", "dim_threads", "group_dim"];

fn roundtrip(source: &str) {
    let (module, info) = validate_with_options(
        source,
        &Options {
            workgroup_size: WORKGROUP,
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
        },
    )
    .unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

#[test]
fn cuda_thread_block_dimensions_return_nominal_dim3_and_select_exact_overloads() {
    let source = "namespace cg = cooperative_groups;
        __device__ unsigned kind(dim3 value) { return 11u; }
        __device__ unsigned kind(uint3 value) { return 22u; }
        __global__ void kernel(unsigned *output) {
            const auto group = cg::this_thread_block();
            auto block = group.group_index(); auto local = group.thread_index();
            auto extent = group.dim_threads(); auto legacy = group.group_dim();
            output[0] = kind(block); output[1] = kind(local);
            output[2] = kind(extent); output[3] = kind(legacy);
        }";
    let (module, info) = validate_with_options(
        source,
        &Options {
            workgroup_size: WORKGROUP,
        },
    );
    let shape = module
        .types
        .iter()
        .find_map(|(handle, ty)| (ty.name.as_deref() == Some("dim3")).then_some(handle))
        .unwrap();
    let function = &module.entry_points[0].function;
    for name in ["block", "local", "extent", "legacy"] {
        let initializer = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[initializer].ty.handle(),
            Some(shape)
        );
    }
    let mut selected = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            if module.functions[function].name.as_deref() == Some("kind") {
                selected.push(function);
            }
        }
        false
    });
    assert_eq!(selected.len(), 4);
    assert!(selected
        .iter()
        .all(|&handle| module.functions[handle].arguments[0].ty == shape));
    roundtrip(source);
    roundtrip(FIXTURE);
}

#[test]
fn cuda_thread_block_dimensions_share_static_member_temporary_and_qualified_lookup() {
    for method in METHODS {
        roundtrip(&format!(
            "#define BLOCK_METHOD {method}
            namespace cg = cooperative_groups; namespace blocks = cg;
            using Block = blocks::thread_block; typedef const Block Frozen;
            __global__ void kernel(dim3 *output) {{
                Frozen group = cg::this_thread_block(); int cg = 3;
                output[0] = group.BLOCK_METHOD();
                output[1] = blocks::thread_block::BLOCK_METHOD();
                output[2] = ::cooperative_groups::thread_block::{method}();
                output[3] = Block::{method}();
                output[4] = cg::this_thread_block().{method}();
                output[5] = Block(group).{method}();
                {{ namespace local = blocks; output[6] = local::thread_block::{method}(); }}
            }}"
        ));
    }
}

#[test]
fn cuda_thread_block_dimension_helpers_initialize_inputs_before_forward_calls_and_returns() {
    let source = "namespace cg = cooperative_groups;
        __device__ dim3 local_position(); __device__ dim3 block_position();
        __device__ bool skip();
        __global__ void kernel(unsigned *output) {
            if (skip()) return;
            output[0] = local_position().z; output[1] = block_position().y;
        }
        __device__ dim3 block_position() { return cg::thread_block::group_index(); }
        __device__ dim3 local_position() { return cg::this_thread_block().thread_index(); }
        __device__ bool skip() { return local_position().x == 99u; }";
    let (module, _) = validate_with_options(
        source,
        &Options {
            workgroup_size: WORKGROUP,
        },
    );
    let entry = &module.entry_points[0].function;
    for builtin in [naga::BuiltIn::LocalInvocationId, naga::BuiltIn::WorkGroupId] {
        assert_eq!(
            entry
                .arguments
                .iter()
                .filter(|argument| argument.binding == Some(naga::Binding::BuiltIn(builtin)))
                .count(),
            1
        );
    }
    let first_call = entry
        .body
        .iter()
        .position(|statement| matches!(statement, naga::Statement::Call { .. }))
        .unwrap();
    let private: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(_, global)| global.space == naga::AddressSpace::Private)
        .collect();
    assert!(!private.is_empty());
    for (handle, global) in private {
        assert!(
            entry
                .body
                .iter()
                .take(first_call)
                .any(|statement| match *statement {
                    naga::Statement::Store { pointer, .. } => matches!(entry.expressions[pointer],
                naga::Expression::GlobalVariable(stored) if stored == handle),
                    _ => false,
                }),
            "{:?}",
            global.name
        );
    }
    assert_eq!(
        module
            .global_variables
            .iter()
            .filter(|&(_, global)| global.binding.is_some())
            .count(),
        1
    );
    roundtrip(source);
    roundtrip(
        "namespace cg = cooperative_groups;
        __device__ dim3 shape() { return cg::thread_block::dim_threads(); }
        __device__ dim3 legacy() { return cg::thread_block::group_dim(); }
        __global__ void kernel(dim3 *output) { output[0] = shape(); output[1] = legacy(); }",
    );
}

#[test]
fn cuda_thread_block_dimensions_are_independent_values_with_once_evaluated_receivers() {
    roundtrip("namespace cg = cooperative_groups; using Block = cg::thread_block;
        __device__ void bump(dim3 &value) { ++value.y; }
        __device__ unsigned encode(const dim3 &value) { return value.x + 10u * value.y + 100u * value.z; }
        __global__ void kernel(unsigned *output) {
            auto group = cg::this_thread_block(); unsigned counter = 0u;
            auto original = (++counter, group).thread_index();
            auto copied = original; copied.x += 10u; bump(copied);
            const auto fixed = Block((++counter, group)).group_index();
            dim3 extent = (++counter, cg::this_thread_block()).dim_threads();
            uint3 packed = extent; const dim3 &snapshot = packed;
            ++packed.x; extent.y += 2u;
            output[0] = encode(original); output[1] = encode(copied);
            output[2] = fixed.z; output[3] = snapshot.x; output[4] = counter;
            output[5] = group.thread_index().x; output[6] = group.group_dim().y;
        }");
    for body in [
        "const auto value = group.thread_index(); value.x = 1u;",
        "const dim3 value = group.group_index(); ++value.y;",
        "group.thread_index().x = 1u;",
        "dim3 &value = group.dim_threads();",
        "uint3 &value = group.group_dim();",
    ] {
        rejected(&format!(
            "namespace cg = cooperative_groups; __global__ void kernel() {{
            auto group = cg::this_thread_block(); {body} }}"
        ));
    }
}

#[test]
fn cuda_thread_block_dimensions_remain_runtime_and_reject_invalid_calls_in_dead_source() {
    for method in METHODS {
        for body in [
            format!("constexpr auto value = group.{method}();"),
            format!("constexpr unsigned Count = (group.{method}(), 3u);"),
            format!("const unsigned Count = group.{method}().x; unsigned values[Count];"),
            format!("constexpr unsigned Count = cg::thread_block::{method}().x;"),
            format!("group.{method}(1u);"),
            format!("cg::thread_block::{method}(1u);"),
            format!("return; group.{method}(missing);"),
            format!("group.{method}().w;"),
            format!("group.{method}()[0];"),
        ] {
            rejected(&format!(
                "/* π */ namespace cg = cooperative_groups;
                __global__ void kernel() {{ auto group = cg::this_thread_block(); {body} }}"
            ));
        }
    }
    for body in [
        "group.block_index();",
        "group.grid_dim();",
        "cg::thread_index();",
        "unsigned value = group.group_dim();",
    ] {
        rejected(&format!(
            "namespace cg = cooperative_groups; __global__ void kernel() {{
            auto group = cg::this_thread_block(); {body} }}"
        ));
    }
}

#[test]
fn cuda_thread_block_dimension_queries_preserve_existing_barrier_restrictions() {
    roundtrip(
        "namespace cg = cooperative_groups;
        __device__ dim3 position() { return cg::thread_block::thread_index(); }
        __global__ void kernel(unsigned *output) {
            auto group = cg::this_thread_block();
            if (group.thread_index().x) output[0] = group.group_index().z;
            for (unsigned index = 0u; index < 2u; ++index) output[index] = group.dim_threads().y;
            group.sync(); output[2] = position().x;
        }",
    );
    for sync in [
        "group.sync();",
        "cg::sync(group);",
        "cg::thread_block::sync();",
    ] {
        roundtrip(&format!(
            "namespace cg = cooperative_groups; __global__ void kernel() {{
            auto group = cg::this_thread_block();
            for (unsigned index = 0u; index < group.dim_threads().x; ++index) {{ {sync} }}
        }}"
        ));
        for statement in [
            format!("if (group.thread_index().x) {{ {sync} }}"),
            format!("if (group.group_index().y) return; {sync}"),
        ] {
            let error = rejected(&format!(
                "namespace cg = cooperative_groups; __global__ void kernel() {{
                auto group = cg::this_thread_block(); {statement} }}"
            ));
            assert!(error.message.contains("straight-line"));
        }
        let error = rejected(&format!("namespace cg = cooperative_groups;
            __device__ dim3 helper() {{ auto group = cg::this_thread_block(); {sync} return group.thread_index(); }}
            __global__ void kernel(dim3 *output) {{ output[0] = helper(); }}"));
        assert!(error.message.contains("helper"));
    }
}
