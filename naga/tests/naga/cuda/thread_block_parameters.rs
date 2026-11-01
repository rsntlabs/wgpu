use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/thread-block-parameters.cu");
const PRELUDE: &str = "namespace cg = cooperative_groups; using Block = cg::thread_block;";

fn options() -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 16,
    }
}

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options(source, &options());
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn rejected(source: &str) {
    let source = format!("{PRELUDE}\n{source}");
    let error = parse_str(&source, &options()).unwrap_err();
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

fn calls(body: &naga::Block) -> Vec<(naga::Handle<naga::Function>, usize)> {
    let mut calls = Vec::new();
    naga::proc::any_statement(body, &mut |statement| {
        if let naga::Statement::Call {
            function,
            ref arguments,
            ..
        } = *statement
        {
            calls.push((function, arguments.len()));
        }
        false
    });
    calls
}

#[test]
fn cuda_thread_block_parameters_erase_handles_and_keep_ordinary_calls() {
    let (module, _) = roundtrip(&format!("{PRELUDE}
        __device__ unsigned encode(Block leading, int signed_value, Block middle,
                                   unsigned value, float scale, const Block trailing) {{
            return unsigned(signed_value) + value + unsigned(scale) + leading.size() + trailing.size();
        }}
        __device__ unsigned block_size(Block group) {{ return group.size(); }}
        __device__ void ignore(Block unnamed) {{}}
        __global__ void kernel(unsigned *output) {{
            auto local_group = cg::this_thread_block();
            output[0] = encode(local_group, 2, local_group, 3u, 4.0f, local_group);
            output[1] = block_size(local_group);
            ignore(local_group);
        }}"));
    let (encode, encode_function) = function(&module, "encode");
    let (block_size, size_function) = function(&module, "block_size");
    let (ignore, ignore_function) = function(&module, "ignore");
    assert_eq!(encode_function.arguments.len(), 3);
    for (argument, scalar) in encode_function.arguments.iter().zip([
        naga::Scalar::I32,
        naga::Scalar::U32,
        naga::Scalar::F32,
    ]) {
        assert_eq!(
            module.types[argument.ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    assert!(size_function.arguments.is_empty());
    assert!(ignore_function.arguments.is_empty());
    assert_eq!(
        calls(&module.entry_points[0].function.body),
        [(encode, 3), (block_size, 0), (ignore, 0)]
    );
    assert_eq!(module.global_variables.len(), 1);
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        for name in [
            "leading",
            "middle",
            "trailing",
            "group",
            "unnamed",
            "local_group",
        ] {
            assert!(!function
                .arguments
                .iter()
                .any(|argument| argument.name.as_deref() == Some(name)));
            assert!(!function
                .local_variables
                .iter()
                .any(|(_, local)| local.name.as_deref() == Some(name)));
            assert!(!function
                .named_expressions
                .values()
                .any(|value| value == name));
        }
    }
    assert!(!module.types.iter().any(|(_, ty)| ty
        .name
        .as_deref()
        .is_some_and(|name| name == "Block" || name.contains("thread_block"))));
}

#[test]
fn cuda_thread_block_parameters_merge_alias_const_and_unnamed_prototypes() {
    let (module, _) = roundtrip(&format!(
        "{PRELUDE}
        typedef const Block Frozen;
        __device__ unsigned forward(const Block, unsigned);
        __device__ unsigned leaf(Frozen, unsigned);
        __device__ unsigned unnamed(const Block) {{ return 9u; }}
        __global__ void kernel(unsigned *output) {{
            const Block group = cg::this_thread_block();
            output[0] = forward(Block{{group}}, 3u) + unnamed(Block(group));
        }}
        __device__ unsigned forward(Block group, unsigned value) {{
            auto copied = group;
            const Block second(copied);
            return leaf(second, value);
        }}
        __device__ unsigned leaf(Block group, unsigned value) {{ return value + group.size(); }}"
    ));
    let (forward, forward_function) = function(&module, "forward");
    let (leaf, _) = function(&module, "leaf");
    assert_eq!(forward_function.arguments.len(), 1);
    assert_eq!(calls(&forward_function.body), [(leaf, 1)]);
    assert_eq!(
        calls(&module.entry_points[0].function.body)[0],
        (forward, 1)
    );
    assert!(function(&module, "unnamed").1.arguments.is_empty());
    for source in [
        "__device__ unsigned value(Block) { return 1u; } __device__ unsigned value(const Block) { return 2u; } __global__ void kernel() {}",
        "__device__ unsigned value(Block); __device__ float value(const Block); __global__ void kernel() {}",
        "__device__ unsigned value(Block); __global__ void kernel() { value(cg::this_thread_block()); }",
        "__device__ unsigned value(Block group) { return value(group); } __global__ void kernel() { value(cg::this_thread_block()); }",
    ] { rejected(source); }
}

#[test]
fn cuda_thread_block_parameters_resolve_logical_overloads_and_builtin_names() {
    let (module, _) = roundtrip(&format!(
        "{PRELUDE}
        __device__ unsigned choose() {{ return 11u; }}
        __device__ unsigned choose(Block) {{ return 17u; }}
        __device__ unsigned choose(unsigned) {{ return 23u; }}
        __device__ unsigned choose(Block, unsigned) {{ return 29u; }}
        __device__ unsigned choose(unsigned, Block) {{ return 31u; }}
        __device__ unsigned min(unsigned first, Block, unsigned second) {{ return first + second; }}
        __device__ unsigned sqrt(Block) {{ return 37u; }}
        __device__ unsigned sqrt(unsigned value) {{ return value + 1u; }}
        __device__ unsigned fabs(Block) {{ return 41u; }}
        __global__ void kernel(unsigned *output) {{
            auto group = cg::this_thread_block();
            output[0] = choose(); output[1] = choose(group); output[2] = choose(1u);
            output[3] = choose(group, 2u); output[4] = choose(3u, group);
            output[5] = min(3u, group, 5u); output[6] = min(3u, 5u);
            output[7] = sqrt(group) + fabs(group);
            output[8] = sqrt(5u);
        }}"
    ));
    let entry_calls = calls(&module.entry_points[0].function.body);
    assert_eq!(entry_calls.len(), 9);
    assert_eq!(
        entry_calls[..5]
            .iter()
            .map(|(_, count)| *count)
            .collect::<Vec<_>>(),
        [0, 0, 1, 1, 1]
    );
    for first in 0..5 {
        for second in first + 1..5 {
            assert_ne!(entry_calls[first].0, entry_calls[second].0);
        }
    }
    assert_eq!(entry_calls[5], (function(&module, "min").0, 2));
    assert_eq!(entry_calls[6], (function(&module, "sqrt").0, 0));
    assert_eq!(entry_calls[7], (function(&module, "fabs").0, 0));
    assert_eq!(entry_calls[8].1, 1);
    assert_ne!(entry_calls[6].0, entry_calls[8].0);
    for source in [
        "__device__ void value(Block) {} __global__ void kernel() { value(); }",
        "__device__ void value() {} __global__ void kernel() { value(cg::this_thread_block()); }",
        "__device__ void value(Block, unsigned) {} __global__ void kernel() { value(1u, cg::this_thread_block()); }",
        "__device__ void value(Block) {} __global__ void kernel() { value(1u); }",
        "__device__ void value(Block) {} __global__ void kernel() { value(false); }",
        "__device__ void value(Block) {} __global__ void kernel() { value(nullptr); }",
        "__device__ void value(unsigned) {} __global__ void kernel() { value(cg::this_thread_block()); }",
        "__global__ void kernel() { min(cg::this_thread_block(), 1u); }",
        "__global__ void kernel() { sqrt(cg::this_thread_block()); }",
        "__global__ void kernel() { fabs(cg::this_thread_block()); }",
    ] { rejected(source); }
}

#[test]
fn cuda_thread_block_parameters_preserve_nominal_queries_and_source_scopes() {
    let (module, _) = roundtrip(&format!("{PRELUDE}
        __device__ unsigned kind(dim3 value) {{ return 17u; }}
        __device__ unsigned kind(uint3 value) {{ return 29u; }}
        __device__ unsigned query(Block group, unsigned value) {{
            dim3 local = group.thread_index();
            dim3 block = group.group_index();
            {{ const Block value = group; value.size(); }}
            return value + local.x + block.y + group.thread_rank() + group.num_threads()
                 + kind(group.dim_threads()) + kind(group.group_dim());
        }}
        __global__ void kernel(unsigned *output) {{ output[0] = query(cg::this_thread_block(), threadIdx.x); }}"));
    let (_, query) = function(&module, "query");
    assert_eq!(query.arguments.len(), 1);
    let query_calls = calls(&query.body);
    assert_eq!(query_calls.len(), 2);
    assert_eq!(query_calls[0].0, query_calls[1].0);
    let kind = &module.functions[query_calls[0].0];
    let naga::TypeInner::Struct { ref members, span } = module.types[kind.arguments[0].ty].inner
    else {
        panic!("dim3 is nominal");
    };
    assert_eq!(span, 12);
    assert_eq!(members.len(), 3);
    for source in [
        "__device__ unsigned value(Block group) { constexpr unsigned count = group.size(); return count; } __global__ void kernel() {}",
        "__device__ void value(Block group) { unsigned values[group.size()]; } __global__ void kernel() {}",
        "__device__ void value(Block group) { group.size(1u); } __global__ void kernel() {}",
        "__device__ void value(Block group) { group.unknown(); } __global__ void kernel() {}",
        "__device__ void value(Block group) { unsigned group = 1u; } __global__ void kernel() {}",
        "__device__ void value(Block group, unsigned group) {} __global__ void kernel() {}",
    ] { rejected(source); }
}

#[test]
fn cuda_thread_block_parameters_preserve_sync_context_and_uniform_builtin_arguments() {
    let (module, info) = roundtrip(FIXTURE);
    let (synchronize, synchronized_function) = function(&module, "synchronize");
    let (reduce, reduce_function) = function(&module, "reduce");
    assert!(calls(&module.entry_points[0].function.body)
        .iter()
        .any(|(callee, _)| *callee == reduce));
    assert!(calls(&reduce_function.body)
        .iter()
        .any(|(callee, _)| *callee == synchronize));
    for (global, variable) in module.global_variables.iter() {
        if variable.space == naga::AddressSpace::Private {
            assert!(!info[synchronize][global].contains(naga::valid::GlobalUse::READ));
        }
    }
    assert!(synchronized_function
        .arguments
        .iter()
        .all(|argument| argument.name.as_deref() != Some("group")));
    roundtrip(&format!("{PRELUDE}
        __device__ unsigned finish(Block group, unsigned data) {{ group.sync(); if (data) return data; return 3u; }}
        __device__ void rounds(Block first, unsigned count, const Block last, unsigned mode) {{
            for (unsigned iteration = 0u; iteration < count; ++iteration) {{
                if (mode) cg::sync(first); else last.sync();
                switch (mode) {{ case 0u: Block::sync(); break; default: cg::sync(last); break; }}
            }}
        }}
        __global__ void kernel(unsigned *output, unsigned count, unsigned mode) {{
            auto group = cg::this_thread_block();
            rounds(group, count, group, mode); output[threadIdx.x] = finish(group, threadIdx.x);
        }}"));
    for source in [
        "__device__ void sync(Block group, unsigned count) { if (count) group.sync(); } __global__ void kernel() { sync(cg::this_thread_block(), threadIdx.x); }",
        "__device__ void sync(Block group) { group.sync(); } __global__ void kernel() { auto group = cg::this_thread_block(); sync(group); if (threadIdx.x) sync(group); }",
        "__device__ void sync(Block group) { group.sync(); } __global__ void kernel() { if (threadIdx.x) return; sync(cg::this_thread_block()); }",
        "__device__ void sync(Block group, unsigned data) { if (data) return; group.sync(); } __global__ void kernel() { sync(cg::this_thread_block(), threadIdx.x); }",
        "__device__ void sync(Block group) { group.sync(); } __global__ void first() { sync(cg::this_thread_block()); } __global__ void second() { if (threadIdx.x) sync(cg::this_thread_block()); }",
    ] { rejected(source); }
}

#[test]
fn cuda_thread_block_parameters_mix_pointer_reference_and_erased_argument_positions() {
    roundtrip(&format!("{PRELUDE}
        __device__ void store(Block, unsigned &value, unsigned amount) {{ value = amount; }}
        __device__ unsigned update(unsigned *values, Block first, unsigned &destination, const Block second, unsigned amount) {{
            values[first.thread_rank()] += amount; store(first, destination, values[first.thread_rank()]);
            cg::sync(second); return values[(first.thread_rank() + 1u) % 4u];
        }}
        __device__ unsigned read(const unsigned *values, Block, const unsigned &value) {{ return values[0] + value; }}
        __device__ unsigned add(unsigned *values, Block group) {{ unsigned old = atomicAdd(values, 1u); group.sync(); return old; }}
        __global__ void kernel(unsigned *output) {{
            __shared__ unsigned values[4]; unsigned lane = threadIdx.x; values[lane] = lane;
            auto group = cg::this_thread_block(); unsigned index = lane;
            output[4u + lane] = update(values, group, output[index++], (++index, group), 2u);
            output[8u + lane] = read(output, group, index);
            output[12u + lane] = add(values, group);
        }}"));
    for source in [
        "__device__ void write(Block, unsigned &value) { value = threadIdx.x; } __global__ void kernel() { unsigned count = 1u; write(cg::this_thread_block(), count); if (count) __syncthreads(); }",
        "__device__ void write(unsigned *value, Block) { value[0] = threadIdx.x; } __global__ void kernel() { unsigned count = 1u; write(&count, cg::this_thread_block()); for (unsigned iteration = 0u; iteration < count; ++iteration) __syncthreads(); }",
        "__device__ void write(Block, unsigned &value) { ++value; } __global__ void kernel() { const unsigned value = 1u; write(cg::this_thread_block(), value); }",
        "__device__ void write(unsigned *value, Block) { ++value[0]; } __global__ void kernel(const unsigned *input) { write(input, cg::this_thread_block()); }",
    ] { rejected(source); }
}

#[test]
fn cuda_thread_block_parameters_keep_unsupported_escapes_and_source_errors_bounded() {
    for source in [
        "__global__ void kernel(Block group) {}",
        "__device__ void value(Block *group) {} __global__ void kernel() {}",
        "__device__ void value(Block &group) {} __global__ void kernel() {}",
        "__device__ void value(const Block &group) {} __global__ void kernel() {}",
        "__device__ Block value() { return cg::this_thread_block(); } __global__ void kernel() {}",
        "__device__ void value(Block group[2]) {} __global__ void kernel() {}",
        "__device__ void value(Block group) { group + 1u; } __global__ void kernel() {}",
        "__device__ unsigned operator+(int2 left, Block right) { return unsigned(left.x); } __global__ void kernel() {}",
        "__device__ void value(Block group) { bool(group); } __global__ void kernel() {}",
        "__device__ void value(Block group) { group == group; } __global__ void kernel() {}",
        "__device__ void value(Block group) { sizeof(group); } __global__ void kernel() {}",
        "__global__ void kernel() { unsigned scratch[4]; cg::this_thread_block(scratch); }",
        "__global__ void kernel() { cg::this_thread_block(1); }",
        "__device__ void value(Block) {} __global__ void kernel() { value(threadIdx.x ? cg::this_thread_block() : cg::this_thread_block()); }",
        "__device__ void value(Block group) { missing; } __global__ void kernel() {}",
        "__device__ void value(Block group) { return; missing; } __global__ void kernel() {}",
        "__device__ void first(Block); __device__ void second(Block group) { first(group); } __device__ void first(Block group) { second(group); } __global__ void kernel() { first(cg::this_thread_block()); }",
    ] { rejected(source); }
    let mut source =
        format!("{PRELUDE}\n__device__ unsigned level0(Block group) {{ return group.size(); }}\n");
    for level in 1..32 {
        source.push_str(&format!(
            "__device__ unsigned level{level}(Block group) {{ return level{}(group); }}\n",
            level - 1
        ));
    }
    source.push_str("__global__ void kernel(unsigned *output) { output[0] = level31(cg::this_thread_block()); }");
    let (module, _) = roundtrip(&source);
    assert_eq!(module.functions.len(), 32);
    assert!(module
        .functions
        .iter()
        .all(|(_, function)| function.arguments.is_empty()));
    for (_, function) in module.functions.iter().skip(1) {
        assert_eq!(calls(&function.body).len(), 1);
    }
}
