#![cfg(feature = "wgsl-in")]

use naga::front::cuda::{parse_str, Options};
use naga::valid::{Capabilities, ValidationFlags, Validator};

use super::helpers::validate_with_options_and_capabilities;
use crate::volatile_loads::global_accesses;

fn options() -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 16,
    }
}

fn capabilities() -> Capabilities {
    Capabilities::MEMORY_DECORATION_VOLATILE | Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP
}

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options_and_capabilities(source, &options(), capabilities());
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities(),
    );
    (module, info)
}

fn rejected(source: &str) {
    let error = parse_str(source, &options()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
}

fn global(module: &naga::Module, name: &str) -> naga::Handle<naga::GlobalVariable> {
    module
        .global_variables
        .iter()
        .find_map(|(handle, variable)| (variable.name.as_deref() == Some(name)).then_some(handle))
        .unwrap()
}

fn assert_volatile(module: &naga::Module, name: &str, expected: bool) {
    assert_eq!(
        module.global_variables[global(module, name)]
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE),
        expected,
        "{name}"
    );
}

fn accesses(module: &naga::Module, name: &str) -> Vec<bool> {
    global_accesses(module, global(module, name))
        .into_iter()
        .map(|access| access.write)
        .collect()
}

#[test]
fn cuda_volatile_pointee_spellings_aliases_and_prototypes_preserve_resource_access() {
    for qualifier in [
        "volatile unsigned",
        "unsigned volatile",
        "const volatile unsigned",
        "volatile const unsigned",
        "unsigned const volatile",
    ] {
        let source = format!("using Element = {qualifier}; using View = Element *;
            __device__ unsigned read(View);
            __device__ unsigned value(volatile unsigned);
            __global__ void kernel(volatile unsigned *const __restrict__ output, View input) {{ output[0] = read(input) + value(3u); }}
            __device__ unsigned read(Element *values) {{ return values[0]; }}
            __device__ unsigned value(unsigned data) {{ return data; }}");
        let (module, _) = roundtrip(&source);
        assert_volatile(&module, "output", true);
        assert_volatile(&module, "input", true);
        let output = &module.global_variables[global(&module, "output")];
        assert_eq!(
            output.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
            }
        );
        let input = &module.global_variables[global(&module, "input")];
        let access = if qualifier.contains("const") {
            naga::StorageAccess::LOAD
        } else {
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        };
        assert_eq!(input.space, naga::AddressSpace::Storage { access });
    }
    roundtrip("using Volatile = volatile unsigned; using Pointer = Volatile *; using Frozen = const Pointer;
        __device__ unsigned read(const volatile unsigned &value) { return value; }
        __global__ void kernel(unsigned *output) { Frozen cursor = output; const volatile unsigned &view = *cursor; output[1] = read(view); }");
    roundtrip("using Input = const volatile unsigned;
        __device__ unsigned read(Input *);
        __device__ unsigned read(volatile const unsigned *);
        __device__ unsigned observe(Input &);
        __global__ void kernel(Input *values, unsigned *output) { output[0] = read(values) + observe(values[0]); }
        __device__ unsigned read(const unsigned volatile *values) { return values[0]; }
        __device__ unsigned observe(unsigned volatile const &value) { return value; }");
}

#[test]
fn cuda_volatile_qualifications_may_be_added_but_not_dropped_or_misplaced() {
    roundtrip(
        "__device__ unsigned choose(unsigned *value) { return 1u; }
        __device__ unsigned choose(volatile unsigned *value) { return 2u; }
        __global__ void kernel(unsigned *output) {
            volatile unsigned *view = output; auto inferred = view; auto *copied = inferred;
            output[0] = choose(output); output[1] = choose(copied);
        }",
    );
    let (module, _) = roundtrip(
        "using View = volatile unsigned *;
        __global__ void kernel(volatile unsigned *values, unsigned *output) {
            View cursor; cursor = values;
            auto copied = *cursor; ++copied;
            auto &live = *cursor; const auto &view = live;
            *cursor = 9u; output[0] = copied; output[1] = live; output[2] = view;
        }",
    );
    assert_eq!(accesses(&module, "values"), [false, true, false, false]);
    for source in [
        "__global__ void kernel(volatile unsigned *values) { unsigned *plain = values; }",
        "__device__ void plain(unsigned *value) {} __global__ void kernel(volatile unsigned *values) { plain(values); }",
        "__global__ void kernel(volatile unsigned *values) { unsigned &plain = values[0]; }",
        "__global__ void kernel(volatile unsigned *values) { auto inferred = values; unsigned *plain = inferred; }",
        "__global__ void kernel(const volatile unsigned *values) { volatile unsigned *plain = values; }",
        "__global__ void kernel(const volatile unsigned *values) { values[0] = 1u; }",
        "__device__ unsigned choose(const unsigned *value) { return 1u; } __device__ unsigned choose(volatile unsigned *value) { return 2u; } __global__ void kernel(unsigned *values) { choose(values); }",
        "__global__ void kernel(unsigned *values) { unsigned *volatile cursor = values; }",
        "using Pointer = unsigned *; __global__ void kernel(unsigned *values) { volatile Pointer cursor = values; }",
        "__global__ void kernel() { volatile unsigned value = 3u; }",
        "__global__ void kernel() { volatile auto value = 3u; }",
        "__device__ unsigned read(volatile unsigned value) { return value; } __global__ void kernel() {}",
        "__global__ void kernel(volatile unsigned value) {}",
        "__device__ unsigned read(unsigned *values); __device__ unsigned read(volatile unsigned *values); __global__ void kernel() { read(); }",
        "using View = volatile unsigned *; __global__ void kernel(volatile unsigned *values) { View cursor; cursor = values; unsigned *plain = cursor; }",
        "__device__ void plain(unsigned &value) {} __global__ void kernel(volatile unsigned *values) { auto &view = values[0]; plain(view); }",
        "__device__ void plain(const unsigned &value) {} __global__ void kernel(volatile unsigned *values) { const auto &view = values[0]; plain(view); }",
        "__global__ void kernel() { volatile unsigned &view = 3u; }",
        "__global__ void kernel() { const volatile unsigned &view = 3u; }",
        "__device__ unsigned read(const volatile unsigned *); __device__ unsigned read(const unsigned *value) { return *value; } __global__ void kernel(const volatile unsigned *values) { read(values); }",
    ] { rejected(source); }
}

#[test]
fn cuda_volatile_discarded_reads_stores_and_updates_have_exact_access_sequences() {
    for (body, expected) in [
        ("values[0];", vec![false]),
        ("(*values);", vec![false]),
        ("values[0] = 5u;", vec![true]),
        ("(values[0] = 5u);", vec![true]),
        ("++values[0];", vec![false, true]),
        ("values[0]++;", vec![false, true]),
        ("values[0] += 2u;", vec![false, true]),
        (
            "unsigned saved = (values[0] = 5u); output[0] = saved;",
            vec![true, false],
        ),
        (
            "unsigned saved = ++values[0]; output[0] = saved;",
            vec![false, true, false],
        ),
        (
            "unsigned saved = values[0]++; output[0] = saved;",
            vec![false, true],
        ),
        ("(values[0], 4u);", vec![false]),
        ("(4u, values[0]);", vec![false]),
        ("(values[0] = 5u, values[0]);", vec![true, false]),
        ("(values[0], values[0] = 5u);", vec![false, true]),
        ("(choose ? (values[0] = 5u) : values[1]);", vec![true]),
        ("(choose ? ++values[0] : values[1]);", vec![false, true]),
    ] {
        let source = format!("__global__ void kernel(volatile unsigned *values, unsigned *output, unsigned choose) {{ {body} }}");
        let (module, _) = roundtrip(&source);
        assert_eq!(accesses(&module, "values"), expected, "{body}");
        assert_volatile(&module, "values", true);
    }
}

#[test]
fn cuda_volatile_loads_keep_snapshot_time_and_helper_argument_order() {
    let (module, _) = roundtrip(
        "__device__ void overwrite(volatile unsigned *values) { values[0] = 9u; }
        __device__ unsigned pair(unsigned first, unsigned second) { return first * 10u + second; }
        __global__ void kernel(volatile unsigned *values, unsigned *output) {
            unsigned saved = values[0]; overwrite(values); output[0] = saved + saved;
            output[1] = pair(values[0], (overwrite(values), values[0]));
        }",
    );
    assert_eq!(
        accesses(&module, "values"),
        [false, true, false, true, false]
    );
    let (module, _) = roundtrip("__global__ void kernel(volatile unsigned *values, unsigned *output) {
        unsigned index = 0u; output[0] = values[index++]; output[1] = values[index++]; output[2] = index;
    }");
    assert_eq!(accesses(&module, "values"), [false, false]);
    let (module, _) = roundtrip(
        "__device__ unsigned read(volatile unsigned *values) { return values[0]; }
        __global__ void kernel(volatile unsigned *values, unsigned *output, unsigned choose) {
            if (choose) output[0] = read(values);
            bool skipped = false && bool(read(values));
        }",
    );
    let sites = global_accesses(&module, global(&module, "values"));
    assert_eq!(sites.len(), 2);
    assert!(sites
        .iter()
        .all(|site| site.scope == crate::volatile_loads::Scope::Conditional));
}

#[test]
fn cuda_volatile_conditional_qualifiers_and_constant_contexts_preserve_evaluation() {
    for expression in [
        "(choose ? *values : *ordinary);",
        "volatile unsigned *selected = choose ? values : ordinary; *selected;",
    ] {
        let source = format!("__global__ void kernel(volatile unsigned *values, unsigned *ordinary, unsigned choose) {{ {expression} }}");
        let (module, _) = roundtrip(&source);
        for name in ["values", "ordinary"] {
            assert_volatile(&module, name, true);
            let sites = global_accesses(&module, global(&module, name));
            assert_eq!(sites.len(), 1, "{expression}: {name}");
            assert!(!sites[0].write);
        }
    }
    let (module, _) = roundtrip("__global__ void kernel(const unsigned *ordinary, volatile unsigned *values, unsigned choose) { (choose ? *ordinary : *values); }");
    assert_volatile(&module, "ordinary", false);
    assert_volatile(&module, "values", true);
    let (module, _) = roundtrip("__global__ void kernel(const unsigned *ordinary, volatile unsigned *values, unsigned *output, unsigned choose) {
        auto selected = choose ? ordinary : values; output[0] = *selected;
    }");
    assert_volatile(&module, "ordinary", true);
    assert_volatile(&module, "values", true);
    for body in [
        "*selected = 1u;",
        "const unsigned *lost = selected;",
        "volatile unsigned *lost = selected;",
    ] {
        rejected(&format!("__global__ void kernel(const unsigned *ordinary, volatile unsigned *values, unsigned choose) {{ auto selected = choose ? ordinary : values; {body} }}"));
    }
    rejected("__global__ void kernel(const unsigned *ordinary, volatile unsigned *values, unsigned choose) { const volatile unsigned &view = choose ? *ordinary : *values; }");
    let pure = "__global__ void kernel(volatile unsigned *values, unsigned *output) {
        __shared__ volatile unsigned shared_values[4];
        volatile unsigned *decayed = shared_values; volatile unsigned &view = shared_values[0];
        &values[0];
        constexpr unsigned count = (&shared_values[0], 4u); output[0] = count;
    }";
    let (module, _) = roundtrip(pure);
    assert!(module
        .global_variables
        .iter()
        .all(|(_, variable)| variable.memory_decorations.is_empty()));
    assert!(accesses(&module, "values").is_empty());
    let (module, _) =
        roundtrip("__global__ void kernel() { int value = 1; volatile int &alias = value; }");
    assert!(module
        .global_variables
        .iter()
        .all(|(_, variable)| variable.memory_decorations.is_empty()));
    for source in [
        "__global__ void kernel(unsigned *values) { constexpr unsigned value = (&values[0], 4u); }",
        "__global__ void kernel(volatile unsigned *values) { constexpr unsigned value = (&values[0], 4u); }",
        "__global__ void kernel(volatile unsigned *values) { constexpr unsigned value = values[0]; }",
        "__global__ void kernel(volatile unsigned *values) { constexpr unsigned value = (values[0], 4u); }",
        "__global__ void kernel(volatile unsigned *values) { sizeof(values[0]); }",
    ] { rejected(source); }
}

#[test]
fn cuda_volatile_shared_scalar_views_upgrade_only_their_actual_allocation() {
    for shared in [
        "__shared__ unsigned values[4];",
        "__shared__ volatile unsigned values[4];",
        "extern __shared__ unsigned values[];",
        "__shared__ volatile unsigned extern values[];",
        "__shared__ unsigned volatile extern values[];",
    ] {
        let source = format!("namespace cg = cooperative_groups;
            __device__ unsigned neighbor(unsigned value, volatile unsigned *values, unsigned width, cg::thread_block group) {{
                unsigned lane = group.thread_rank(); values[lane] = value; group.sync();
                return values[(lane + 1u) % width];
            }}
            __global__ void kernel(unsigned *output) {{ {shared}
                auto group = cg::this_thread_block(); output[threadIdx.x] = neighbor(threadIdx.x + 1u, values, 4u, group);
            }}");
        let (module, _) = roundtrip(&source);
        let shared: Vec<_> = module
            .global_variables
            .iter()
            .filter(|&(_, variable)| variable.space == naga::AddressSpace::WorkGroup)
            .collect();
        assert_eq!(shared.len(), 1);
        assert!(shared[0]
            .1
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
        assert_volatile(&module, "output", false);
        assert!(Validator::new(
            ValidationFlags::all(),
            Capabilities::MEMORY_DECORATION_VOLATILE
        )
        .validate(&module)
        .is_err());
    }
    roundtrip("__device__ void write(volatile unsigned &value) { value = 7u; }
        __global__ void kernel(unsigned *output) { __shared__ unsigned values[4]; volatile unsigned &view = values[threadIdx.x]; write(view); __syncthreads(); output[threadIdx.x] = view; }");
    roundtrip("__global__ void kernel(const volatile unsigned *values, unsigned *output) { values[0]; __syncthreads(); output[threadIdx.x] = values[0]; }");
    for control in [
        "if (view) __syncthreads();",
        "for (unsigned iteration = 0u; iteration < view; ++iteration) __syncthreads();",
    ] {
        rejected(&format!("__global__ void kernel(const volatile unsigned *values) {{ const auto &view = values[0]; {control} }}"));
    }
}

#[test]
fn cuda_volatile_scalar_subobjects_preserve_layout_and_reject_unsupported_targets() {
    let (module, _) = roundtrip(
        "__global__ void kernel(unsigned *values, unsigned *output) {
            volatile unsigned *view = values;
            output[0] = *view; atomicAdd(values, 1u); output[1] = *view;
        }",
    );
    assert_volatile(&module, "values", true);
    let (module, _) = roundtrip(
        "struct Record { unsigned value; int3 packed; };
        __global__ void kernel(volatile Record *records, volatile int3 *packed, unsigned *output) {
            records[0].value = 3u; records[0].packed.z += 1;
            packed[1].y = 7; output[0] = records[0].value + unsigned(packed[1].y);
        }",
    );
    assert_volatile(&module, "records", true);
    assert_volatile(&module, "packed", true);
    let naga::TypeInner::Array { stride, .. } =
        module.types[module.global_variables[global(&module, "packed")].ty].inner
    else {
        panic!("packed resource array");
    };
    assert_eq!(stride, 12);
    for source in [
        "__global__ void kernel(unsigned *output) { unsigned local = 3u; volatile unsigned *view = &local; output[0] = *view; }",
        "__device__ unsigned read(volatile unsigned &value) { return value; } __global__ void kernel(unsigned *output) { unsigned local = 3u; output[0] = read(local); }",
        "struct Record { unsigned value; }; __global__ void kernel(volatile Record *values) { Record copied = values[0]; }",
        "struct Record { unsigned value; }; __global__ void kernel(volatile Record *values) { Record copied{1u}; values[0] = copied; }",
        "struct Record { unsigned value; }; __global__ void kernel(volatile Record *values) { values[0]; }",
        "__global__ void kernel(volatile int3 *values) { int3 copied = values[0]; }",
        "struct Record { volatile unsigned value; }; __global__ void kernel() {}",
        "using Observed = volatile unsigned; struct Record { Observed value; }; __global__ void kernel() {}",
        "__global__ void kernel(unsigned *output) { __shared__ unsigned values[4]; atomicAdd(values, 1u); volatile unsigned *view = values; output[0] = *view; }",
    ] { rejected(source); }
}
