use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/atomic-cas.cu");

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
}

#[test]
fn cuda_atomic_cas_lowers_typed_comparisons_and_preserves_old_values() {
    for source in [
        FIXTURE,
        "__global__ void kernel(unsigned *output) {
            output[8] = atomicCAS(output, 0xffffffffu, 0x80000000u);
            output[9] = atomicCAS(output, 0xffffffffu, 3u);
            output[10] = atomicCAS(output + 1, 0x80000005u, 1u);
            atomicCAS(output + 2, 7u, 0xfffffffeu);
        }",
    ] {
        let (module, info) = validate(source);
        let function = &module.entry_points[0].function;
        assert!(naga::proc::any_statement(
            &function.body,
            &mut |statement| {
                matches!(
                    *statement,
                    naga::Statement::Atomic {
                        fun: naga::AtomicFunction::Exchange { compare: Some(_) },
                        ..
                    }
                )
            }
        ));
        assert!(function.expressions.iter().any(|(_, expression)| {
            matches!(
                *expression,
                naga::Expression::AtomicResult {
                    comparison: true,
                    ..
                }
            )
        }));
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = info;
    }
    let deep_comparison = |terms| {
        format!(
            "__device__ int comparison_value() {{ return 0; }}
        __global__ void kernel(int *output) {{
            output[1] = atomicCAS(output, comparison_value(){}, 7);
        }}",
            " + 0".repeat(terms),
        )
    };
    roundtrip(&deep_comparison(62));
    rejected(&deep_comparison(65));
}

#[test]
fn cuda_atomic_cas_captures_all_operands_once_and_keeps_lazy_calls() {
    roundtrip(
        "__global__ void kernel(int *output) {
            __shared__ int counter;
            counter = output[7];
            unsigned index = 0;
            int compare = 0;
            int replacement = 7;
            output[0] = atomicCAS(&counter + index++, compare++, replacement++);
            output[1] = counter;
            output[4] = compare;
            output[5] = replacement;
            output[6] = index;
            bool skipped = false && atomicCAS(output + 8, 20, 0);
            bool ready = true || atomicCAS(output + 8, 20, 0);
            output[9] = int(skipped) + int(ready);
        }",
    );
}

#[test]
fn cuda_atomic_cas_forwards_helpers_origins_aggregate_fields_and_ticket_loops() {
    roundtrip(
        "__device__ int compare_exchange(int *destination, int compare, int replacement);
        __global__ void kernel(int *output) {
            __shared__ int shared;
            shared = 10;
            __syncthreads();
            int *selected = output[7] ? &shared : output + 8;
            int previous = compare_exchange(selected, 10, 30);
            __syncthreads();
            output[0] = previous;
            output[1] = shared;
            output[2] = output[8];
        }
        __device__ int compare_exchange(int *destination, int compare, int replacement) {
            return atomicCAS(destination, compare, replacement);
        }",
    );
    roundtrip(
        "struct Counter { int value; int2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            int previous = atomicCAS(&records[0].value, 2, 7);
            int previous_component = atomicCAS(&records[0].pair.y, 10, 3);
            Counter after = records[0];
            records[1] = after;
            records[2].value = previous;
            records[2].pair.x = previous_component;
            records[2].pair.y = before.pair.y;
        }",
    );
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            unsigned observed = atomicCAS(output, 0u, 0u);
            while (true) {
                unsigned previous = atomicCAS(output, observed, observed + 1u);
                if (previous == observed) { output[observed + 1u] = observed; break; }
                observed = previous;
            }
        }",
    );
}

#[test]
fn cuda_atomic_cas_matches_prototypes_and_preserves_overloads_and_name_hiding() {
    roundtrip(
        "__device__ int atomicCAS(int *, int, int);
        __device__ unsigned atomicCAS(unsigned *, unsigned, unsigned);
        __device__ int atomicCAS(int value, int compare, int replacement) { return value + compare + replacement; }
        __global__ void kernel(int *output, unsigned *other) {
            output[1] = atomicCAS(output, 2, 3);
            other[1] = atomicCAS(other, 2u, 3u);
            output[2] = atomicCAS(4, 5, 6);
        }",
    );
    for source in [
        "__device__ unsigned atomicCAS(int *, int, int); __global__ void kernel() {}",
        "__device__ int atomicCAS(int *destination, int compare, int replacement) { return replacement; } __global__ void kernel() {}",
        "__global__ void kernel(int *output) { int atomicCAS = 3; output[0] = atomicCAS(output, 0, 1); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_atomic_cas_rejects_invalid_pointees_arity_private_calls_and_unset_compare_origins() {
    for source in [
        "__global__ void kernel(const int *input) { atomicCAS(input, 0, 1); }",
        "__global__ void kernel(float *output) { atomicCAS(output, 0.0f, 1.0f); }",
        "__global__ void kernel(unsigned long long *output) { atomicCAS(output, 0, 1); }",
        "__global__ void kernel(int2 *output) { atomicCAS(output, int2{0, 0}, int2{1, 1}); }",
        "__global__ void kernel(int *output) { atomicCAS(output, int2{0, 0}, 1); }",
        "__global__ void kernel(int *output) { atomicCAS(output, 0, int2{1, 1}); }",
        "__global__ void kernel(int *output) { atomicCAS(0, 0, 1); }",
        "__global__ void kernel() { atomicCAS(); }",
        "__global__ void kernel(int *output) { atomicCAS(output); }",
        "__global__ void kernel(int *output) { atomicCAS(output, 0); }",
        "__global__ void kernel(int *output) { atomicCAS(output, 0, 1, 2); }",
        "__global__ void kernel() { int local = 3; atomicCAS(&local, 3, 4); }",
        "__global__ void kernel(int *output) { atomicCAS(output, 0, 1); int local = 3; atomicCAS(&local, 3, 4); }",
        "__device__ int exchange(int *destination) { return atomicCAS(destination, 0, 1); } __global__ void kernel(int *output) { exchange(output); int local = 3; exchange(&local); }",
        "__global__ void kernel() { int *destination; atomicCAS(destination, 0, 1); }",
        "__global__ void kernel(int *output) { int *unset; atomicCAS(output, *unset, 1); }",
    ] {
        rejected(source);
    }
}
