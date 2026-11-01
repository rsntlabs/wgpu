use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate_with_options};

const FIXTURE: &str = include_str!("../../in/cuda/thread-block.cu");

fn roundtrip(source: &str, workgroup_size: [u32; 3]) {
    let (module, info) = validate_with_options(source, &Options { workgroup_size });
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

#[test]
fn cuda_thread_block_namespace_qualification_filters_values_types_and_alias_targets() {
    roundtrip(
        "namespace cg = cooperative_groups;
        __global__ void kernel(unsigned *output) {
            for (unsigned iteration = 0u; iteration < 1u; ++iteration) {
                namespace local = cg;
                auto group = local::this_thread_block();
                output[threadIdx.x] = group.thread_rank() + iteration;
            }
        }",
        [4, 1, 1],
    );
    roundtrip(
        "namespace cg = cooperative_groups;
        __global__ void kernel(unsigned *output) {
            auto cg = cg::this_thread_block();
            cg::sync(cg); output[threadIdx.x] = cg.size();
        }",
        [4, 1, 1],
    );
    roundtrip(
        "namespace cg = cooperative_groups; namespace blocks = cg; namespace cg = blocks;
        __global__ void kernel(unsigned *output) {
            int cg = 1;
            cg::thread_block group = cg::this_thread_block();
            namespace local = cg;
            local::sync(group);
            { using cg = int;
                namespace restored = cg;
                ::cg::thread_block outer = ::cg::this_thread_block();
                restored::sync(outer);
                output[0] = outer.size();
            }
            { namespace nested = local; nested::thread_block copied = group; copied.sync(); }
            output[1] = cg;
        }",
        [4, 1, 1],
    );
    roundtrip(
        "__global__ void kernel(unsigned *output) {
        cooperative_groups::thread_block group = ::cooperative_groups::this_thread_block();
        cooperative_groups::sync(group); output[0] = group.thread_rank();
    }",
        [4, 1, 1],
    );
    for body in [
        "for (namespace local = cg; false;) {}",
        "using cooperative_groups = int; cooperative_groups::this_thread_block();",
        "namespace invalid = cg::thread_block;",
        "using cg = int; cg::thread_block group = cooperative_groups::this_thread_block();",
        "struct cg { int value; }; cg::thread_block group = cooperative_groups::this_thread_block();",
        "using cg = int; { int cg = 1; cg::thread_block group = cooperative_groups::this_thread_block(); }",
        "struct cg { int value; }; { int cg = 1; cg::thread_block group = cooperative_groups::this_thread_block(); }",
        "{ namespace local = cg; } local::thread_block group = cg::this_thread_block();",
        "int local = 1; namespace local = cg;",
    ] {
        rejected(&format!("namespace cg = cooperative_groups; __global__ void kernel() {{ {body} }}"));
    }
}

#[test]
fn cuda_thread_block_scope_tokens_match_preprocessed_source_and_reject_separate_colons() {
    roundtrip(
        "#define GROUP_NAMESPACE cg
        #define GROUP_TYPE GROUP_NAMESPACE::thread_block
        #define CURRENT_GROUP() GROUP_NAMESPACE::this_thread_block()
        namespace cg = cooperative_groups;
        __global__ void kernel(unsigned *output) {
            GROUP_TYPE group = CURRENT_GROUP();
            GROUP_NAMESPACE::sync(group); output[0] = group.num_threads();
        }",
        [4, 1, 1],
    );
    for separator in [": :", ":/**/:", ":\n:"] {
        for prefix in ["", "#define UNUSED 1\n"] {
            rejected(&format!("{prefix}namespace cg = cooperative_groups;
                __global__ void kernel() {{ cg{separator}thread_block group = cg::this_thread_block(); }}"));
        }
    }
}

#[test]
fn cuda_thread_block_bindings_preserve_copies_const_auto_and_lexical_scope() {
    roundtrip(
        "namespace cg = cooperative_groups;
        using Block = cg::thread_block; typedef const Block Frozen;
        __global__ void kernel(unsigned *output) {
            Block group = cg::this_thread_block(); Frozen fixed = group;
            auto copied = fixed; const auto also_fixed = copied;
            Block direct(copied); const Block braced{direct};
            auto temporary = Block(braced); auto other_temporary = Block{temporary};
            { auto group = cg::this_thread_block(); output[0] = group.thread_rank(); }
            output[1] = also_fixed.size(); copied.sync(); fixed.sync();
            output[2] = cg::this_thread_block().num_threads();
            output[3] = Block(other_temporary).size();
        }",
        [4, 1, 1],
    );
    for body in [
        "switch (threadIdx.x) { case 0u: cg::thread_block group = cg::this_thread_block(); case 1u: break; default: break; }",
        "cg::thread_block group;",
        "const cg::thread_block group;",
        "cg::thread_block group{};",
        "auto group = cg::thread_block();",
        "auto group = cg::thread_block{};",
        "cg::thread_block group = group;",
        "auto group = group;",
        "cg::thread_block group = 1;",
        "cg::thread_block group = cg::this_thread_block(1);",
        "{ auto group = cg::this_thread_block(); } group.sync();",
        "auto group = cg::this_thread_block(); { int group = 1; group.sync(); }",
        "auto group = cg::this_thread_block(); int group = 1;",
        "switch (0) { case 0: auto group = cg::this_thread_block(); case 1: break; }",
    ] {
        rejected(&format!("namespace cg = cooperative_groups; __global__ void kernel() {{ {body} }}"));
    }
}

#[test]
fn cuda_thread_block_free_and_member_sync_keep_memory_scope_and_barrier_safety() {
    let (module, _) = validate_with_options(
        FIXTURE,
        &Options {
            workgroup_size: [4, 1, 1],
        },
    );
    let function = &module.entry_points[0].function;
    for name in ["original", "fixed", "group"] {
        assert!(function
            .local_variables
            .iter()
            .all(|(_, local)| local.name.as_deref() != Some(name)));
        assert!(function
            .named_expressions
            .values()
            .all(|value| value != name));
    }
    let mut barriers = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::ControlBarrier(flags) = *statement {
            barriers.push(flags);
        }
        false
    });
    assert_eq!(
        barriers,
        [naga::Barrier::WORK_GROUP | naga::Barrier::STORAGE; 3]
    );
    roundtrip(FIXTURE, [4, 1, 1]);
    for sync in [
        "cg::sync(group);",
        "group.sync();",
        "cg::thread_block::sync();",
        "Block::sync();",
        "::cg::thread_block::sync();",
        "cg::this_thread_block().sync();",
        "(++counter, group).sync();",
        "cg::sync((++counter, group));",
        "(group.sync(), group.sync());",
    ] {
        roundtrip(
            &format!(
                "namespace cg = cooperative_groups; using Block = cg::thread_block;
            __global__ void kernel(unsigned *output) {{
                auto group = cg::this_thread_block(); unsigned counter = 0u;
                if (threadIdx.x == 0u) output[0] = 1u; else output[1] = 2u;
                {{ {sync} }}
            }}"
            ),
            [4, 1, 1],
        );
        for statement in [
            format!("if (threadIdx.x == 0u) {sync}"),
            format!("if (true) {{ {sync} }}"),
            format!("for (int index = 0; index < 2; ++index) {{ {sync} }}"),
            format!("while (false) {{ {sync} }}"),
            format!("switch (threadIdx.x) {{ case 0u: {sync} break; default: break; }}"),
            format!("if (threadIdx.x == 0u) return; {sync}"),
        ] {
            let source = format!("namespace cg = cooperative_groups; using Block = cg::thread_block;
                __global__ void kernel() {{ auto group = cg::this_thread_block(); unsigned counter = 0u; {statement} }}");
            assert!(rejected(&source).message.contains("straight-line"));
        }
        let source = format!("namespace cg = cooperative_groups; using Block = cg::thread_block;
            __device__ void helper() {{ auto group = cg::this_thread_block(); unsigned counter = 0u; {sync} }}
            __global__ void kernel() {{ helper(); }}");
        assert!(rejected(&source).message.contains("helper"));
    }
    roundtrip(
        "namespace cg = cooperative_groups;
        __device__ void ignore() {}
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            auto group = (++counter, cg::this_thread_block());
            auto copied = cg::thread_block((++counter, group));
            cg::sync((++counter, copied)); (++counter, group).sync();
            output[threadIdx.x] = counter;
            return (group, ignore());
        }",
        [4, 1, 1],
    );
    roundtrip(
        "namespace cg = cooperative_groups;
        __global__ void kernel() { return cg::thread_block::sync(); }",
        [4, 1, 1],
    );
    for expression in [
        "true ? group.sync() : group.sync()",
        "threadIdx.x ? cg::sync(group) : cg::thread_block::sync()",
        "threadIdx.x ? cg::this_thread_block().sync() : group.sync()",
    ] {
        let source = format!(
            "namespace cg = cooperative_groups;
            __global__ void kernel() {{ auto group = cg::this_thread_block(); {expression}; }}"
        );
        assert!(rejected(&source).message.contains("straight-line"));
    }
}

#[test]
fn cuda_thread_block_scalar_queries_return_runtime_unsigned_values_in_three_dimensions() {
    let source = "namespace cg = cooperative_groups;
        __device__ unsigned rank() { return cg::thread_block::thread_rank(); }
        __global__ void kernel(unsigned *output) {
            using Block = cg::thread_block;
            const auto group = cg::this_thread_block();
            unsigned lane = group.thread_rank(); unsigned size = group.size();
            unsigned count = group.num_threads();
            unsigned static_lane = cg::thread_block::thread_rank();
            unsigned static_size = ::cg::thread_block::size();
            unsigned static_count = Block::num_threads();
            output[0] = lane; output[1] = size; output[2] = count; output[3] = rank();
            output[4] = static_lane; output[5] = static_size; output[6] = static_count;
        }";
    let (module, info) = validate_with_options(
        source,
        &Options {
            workgroup_size: [4, 3, 2],
        },
    );
    let function = &module.entry_points[0].function;
    for name in [
        "lane",
        "size",
        "count",
        "static_lane",
        "static_size",
        "static_count",
    ] {
        let expression = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[expression]
                .ty
                .inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    roundtrip(source, [4, 3, 2]);
    for body in [
        "constexpr unsigned Count = (cg::this_thread_block(), 3u);",
        "constexpr unsigned Count = (group.size(), 3u);",
        "constexpr unsigned Size = group.size();",
        "constexpr unsigned Count = group.num_threads();",
        "constexpr unsigned Lane = group.thread_rank();",
        "constexpr unsigned Size = cg::thread_block::size();",
        "constexpr unsigned Lane = ::cg::thread_block::thread_rank();",
        "constexpr unsigned Count = cg::thread_block::num_threads();",
        "const unsigned Count = group.size(); int values[Count];",
    ] {
        rejected(&format!(
            "namespace cg = cooperative_groups;
            __global__ void kernel() {{ auto group = cg::this_thread_block(); {body} }}"
        ));
    }
}

#[test]
fn cuda_thread_block_rejects_other_groups_escaping_handles_and_invalid_calls() {
    for source in [
        "namespace cg = Missing; __global__ void kernel() {}",
        "namespace custom {} __global__ void kernel() {}",
        "using namespace cooperative_groups; __global__ void kernel() {}",
        "namespace cg = cooperative_groups; __global__ void kernel(cg::thread_block group) {}",
        "namespace cg = cooperative_groups; __device__ unsigned helper(cg::thread_block group) { return group.size(); } __global__ void kernel() {}",
        "namespace cg = cooperative_groups; __device__ cg::thread_block helper() { return cg::this_thread_block(); } __global__ void kernel() {}",
        "namespace cg = cooperative_groups; struct Record { cg::thread_block group; }; __global__ void kernel() {}",
        "namespace cg = cooperative_groups; __global__ void kernel() { return cg::this_thread_block(); }",
        "namespace cg = cooperative_groups; __device__ void helper() { return cg::this_thread_block(); } __global__ void kernel() { helper(); }",
        "namespace cg = cooperative_groups; __global__ void kernel() { auto group = cg::this_thread_block(); return (group, group); }",
    ] { rejected(source); }
    for body in [
        "cg::grid_group group = cg::this_grid();",
        "auto group = cg::coalesced_threads();",
        "auto group = cg::tiled_partition<2>(cg::this_thread_block());",
        "cg::thread_block groups[2];",
        "using Pointer = cg::thread_block *;",
        "auto group = cg::this_thread_block(); cg::thread_block *pointer = &group;",
        "auto group = cg::this_thread_block(); cg::thread_block &reference = group;",
        "__shared__ cg::thread_block group;",
        "constexpr auto group = cg::this_thread_block();",
        "auto group = cg::this_thread_block(); auto *pointer = &group;",
        "auto group = cg::this_thread_block(); auto &reference = group;",
        "auto group = cg::this_thread_block(); unsigned value = group;",
        "auto group = cg::this_thread_block(); if (group) return;",
        "auto group = cg::this_thread_block(); group.size(1);",
        "auto group = cg::this_thread_block(); group.sync(1);",
        "auto group = cg::this_thread_block(); group.thread_index();",
        "auto group = cg::this_thread_block(); group.group_index();",
        "auto group = cg::this_thread_block(); group.dim_threads();",
        "auto group = cg::this_thread_block(); group.group_dim();",
        "cg::sync();",
        "cg::sync(1);",
        "auto group = cg::this_thread_block(); cg::sync(group, group);",
        "auto group = cg::this_thread_block(); unsigned value = group.sync();",
        "auto group = cg::this_thread_block(); return; group.unknown();",
    ] {
        rejected(&format!(
            "namespace cg = cooperative_groups; __global__ void kernel() {{ {body} }}"
        ));
    }
}
