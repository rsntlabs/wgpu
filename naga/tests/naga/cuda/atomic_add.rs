use naga::front::cuda::{parse_str, Options};

use super::helpers::{validate, validate_with_options};

const FIXTURE: &str = include_str!("../../in/cuda/atomic-add.cu");

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
    assert!(
        source.get(error.span.to_range().unwrap()).is_some(),
        "{source}"
    );
}

#[test]
fn cuda_atomic_add_preserves_old_results_scalar_conversions_and_ordinary_accesses() {
    let (module, _) = validate(FIXTURE);
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| {
            matches!(
                *statement,
                naga::Statement::Atomic {
                    fun: naga::AtomicFunction::Add,
                    ..
                }
            )
        }
    ));
    roundtrip(FIXTURE);
}

#[test]
fn cuda_atomic_add_supports_unsigned_only_sources_and_wrapping_updates() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            unsigned previous = atomicAdd(output, 3u);
            output[1] = previous;
            output[2] = output[0];
            atomicAdd(output, 0xffffffffu);
            output[3] = output[0];
        }",
    );
}

#[test]
fn cuda_atomic_add_supports_shared_counters_with_separated_normal_accesses() {
    let (module, info) = validate_with_options(
        "__global__ void kernel(unsigned *output) {
            __shared__ unsigned counter;
            unsigned lane = threadIdx.x;
            if (lane == 0u) counter = output[30];
            __syncthreads();
            unsigned ticket = atomicAdd(&counter, 1u);
            unsigned base = blockIdx.x * 9u;
            output[base + ticket + 1u] = ticket;
            __syncthreads();
            if (lane == 0u) output[base] = counter;
        }",
        &Options {
            workgroup_size: [8, 1, 1],
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

#[test]
fn cuda_atomic_add_forwards_selected_pointer_origins_and_projected_fields() {
    roundtrip(
        "__device__ int add(int *destination, int amount) { return atomicAdd(destination, amount); }
        __global__ void kernel(int *output) {
            __shared__ int shared;
            shared = 10;
            int private_local = 17;
            int *selected = &private_local;
            selected = output[7] ? &shared : output + 8;
            int previous = add(selected, 3);
            output[0] = previous;
            output[1] = shared;
            output[2] = output[8];
            output[3] = private_local;
        }",
    );
    roundtrip(
        "struct Counter { int value; int marker; };
        __global__ void kernel(Counter *counters, int *output) {
            int *selected = &counters[0].value;
            output[0] = atomicAdd(selected, 2);
            counters[0].marker = counters[0].value;
            output[1] = counters[0].marker;
        }",
    );
    roundtrip(
        "struct Counter { int value; int samples[2]; };
        __device__ Counter copied(Counter value) { value.samples[1] += 1; return value; }
        __global__ void kernel(Counter *records, const Counter *input) {
            Counter before = records[0];
            int previous = atomicAdd(&records[0].value, 4);
            Counter after = copied(records[0]);
            records[1] = after;
            Counter untouched = input[0];
            records[2].value = previous;
            records[2].samples[0] = before.value;
            records[2].samples[1] = after.value;
            records[3].value = after.samples[1];
            records[3].samples[0] = untouched.value;
            records[3].samples[1] = untouched.samples[1];
        }",
    );
    roundtrip(
        "struct Block { int marker; int2 pair; int4 quad; int tail; };
        __global__ void kernel(Block *records) {
            int previous_pair = atomicAdd(&records[0].pair.y, 5);
            int previous_quad = atomicAdd(&records[0].quad.z, 7);
            int2 pair = records[0].pair;
            int4 quad = records[0].quad;
            records[1].pair = pair; records[1].quad = quad;
            records[1].marker = previous_pair; records[1].tail = previous_quad;
            Block copied = records[0];
            records[2] = copied;
        }",
    );
    roundtrip(
        "__global__ void kernel(int3 *records) {
            atomicAdd(&records[0].z, 2);
            int3 copied = records[0];
            records[1] = copied;
        }",
    );
}

#[test]
fn cuda_atomic_add_keeps_lazy_branches_and_evaluates_both_arguments_once() {
    roundtrip(
        "__global__ void kernel(int *output) {
            unsigned index = 8;
            int amount = 3;
            output[0] = atomicAdd(output + index++, amount++);
            bool skipped = false && atomicAdd(output + 8, 100);
            bool selected = true || atomicAdd(output + 8, 100);
            output[1] = output[7] ? atomicAdd(output + 8, 2) : atomicAdd(output + 9, -2);
            output[2] = index;
            output[3] = amount;
            output[4] = int(skipped) + int(selected);
        }",
    );
}

#[test]
fn cuda_atomic_add_matching_prototypes_preserve_the_intrinsic() {
    roundtrip(
        "__device__ int atomicAdd(int *, int);
        __device__ unsigned atomicAdd(unsigned *, unsigned);
        __global__ void kernel(int *output, unsigned *other) {
            output[0] = atomicAdd(output + 8, 1);
            other[0] = atomicAdd(other + 8, 1u);
        }",
    );
    roundtrip(
        "__device__ int atomicAdd(int value, int increment) { return value + increment; }
        __global__ void kernel(int *output) {
            output[1] = atomicAdd(output, 2);
            output[2] = atomicAdd(3, 4);
        }",
    );
    for source in [
        "__device__ unsigned atomicAdd(int *, int); __global__ void kernel() {}",
        "__device__ int atomicAdd(int *destination, int value) { return value; } __global__ void kernel() {}",
        "__global__ void kernel(int *output) { int atomicAdd = 3; output[0] = atomicAdd(output, 1); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_atomic_add_rejects_unsupported_pointees_addresses_and_argument_lists() {
    for source in [
        "__global__ void kernel(const int *input) { atomicAdd(input, 1); }",
        "__global__ void kernel(float *output) { atomicAdd(output, 1.0f); }",
        "__global__ void kernel(int2 *output) { atomicAdd(output, int2{1, 2}); }",
        "__device__ void add(bool *value) { atomicAdd(value, true); } __global__ void kernel() {}",
        "__global__ void kernel() { int value = 3; atomicAdd(&value, 1); }",
        "__global__ void kernel(int *output) { atomicAdd(output, 1); int local = 3; atomicAdd(&local, 1); }",
        "__device__ int add(int *destination) { return atomicAdd(destination, 1); } __global__ void kernel(int *output) { add(output); int local = 3; add(&local); }",
        "__global__ void kernel(int *output) { atomicAdd(output[0], 1); }",
        "__global__ void kernel(int *output) { atomicAdd(0, 1); }",
        "__global__ void kernel(int *output) { atomicAdd(); }",
        "__global__ void kernel(int *output) { atomicAdd(output); }",
        "__global__ void kernel(int *output) { atomicAdd(output, 1, 2); }",
        "__global__ void kernel(int *output) { atomicAdd(output, int2{1, 2}); }",
        "__global__ void kernel() { int *destination; atomicAdd(destination, 1); }",
        "__global__ void kernel() { int *first; int *second; first = second; second = first; atomicAdd(first, 1); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_atomic_add_bounds_generated_work_for_whole_aggregate_copies() {
    let source = "struct Payload { int values[16777216]; };
        __global__ void kernel(Payload *records) {
            atomicAdd(&records[0].values[0], 1);
            Payload snapshot = records[0];
            records[1] = snapshot;
        }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert_eq!(
        error.message,
        "CUDA helper parameter expansion limit exceeded"
    );
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(source.get(range).is_some());
}
