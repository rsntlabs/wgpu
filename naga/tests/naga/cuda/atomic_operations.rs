use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/atomic-operations.cu");
const OPERATIONS: [&str; 7] = [
    "atomicSub",
    "atomicMin",
    "atomicMax",
    "atomicAnd",
    "atomicOr",
    "atomicXor",
    "atomicExch",
];

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
fn cuda_integer_atomic_operations_lower_both_signed_and_unsigned_variants() {
    for source in [
        FIXTURE,
        "__global__ void kernel(unsigned *output) {
            output[8] = atomicSub(output, 3u);
            output[9] = atomicMin(output + 1, 7u);
            output[10] = atomicMax(output + 2, 7u);
            output[11] = atomicAnd(output + 3, 0x80000003u);
            output[12] = atomicOr(output + 4, 0x80000000u);
            output[13] = atomicXor(output + 5, 0xffffffffu);
            output[14] = atomicExch(output + 6, 3u);
        }",
    ] {
        let (module, info) = validate(source);
        let mut operations = Vec::new();
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Atomic { fun, .. } = *statement {
                operations.push(fun);
            }
            false
        });
        for operation in [
            naga::AtomicFunction::Subtract,
            naga::AtomicFunction::Min,
            naga::AtomicFunction::Max,
            naga::AtomicFunction::And,
            naga::AtomicFunction::InclusiveOr,
            naga::AtomicFunction::ExclusiveOr,
            naga::AtomicFunction::Exchange { compare: None },
        ] {
            assert!(operations.contains(&operation), "{operation:?}: {source}");
        }
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = info;
    }
}

#[test]
fn cuda_integer_atomic_operations_forward_helpers_origins_and_projected_aggregate_fields() {
    roundtrip(
        "__device__ int combine(int *destination, int amount);
        __global__ void kernel(int *output) {
            __shared__ int shared;
            shared = 10;
            __syncthreads();
            int *selected = output[7] ? &shared : output + 8;
            int previous = combine(selected, 3);
            __syncthreads();
            output[0] = previous;
            output[1] = shared;
            output[2] = output[8];
            unsigned index = 9;
            int amount = 3;
            output[3] = atomicSub(output + index++, amount++);
            output[4] = index;
            output[5] = amount;
            bool skipped = false && atomicAnd(output + 9, 0);
            bool ready = true || atomicXor(output + 9, 255);
            output[6] = int(skipped) + int(ready);
            output[10] = output[7] ? atomicMin(output + 9, 10) : atomicMax(output + 9, 40);
            output[11] = output[9];
        }
        __device__ int combine(int *destination, int amount) {
            int previous = atomicSub(destination, amount);
            atomicOr(destination, 8);
            return previous;
        }",
    );
    roundtrip(
        "struct Counter { int value; int2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            int previous = atomicMax(&records[0].value, 7);
            int previous_component = atomicXor(&records[0].pair.y, 3);
            Counter after = records[0];
            records[1] = after;
            records[2].value = previous;
            records[2].pair.x = previous_component;
            records[2].pair.y = before.pair.y;
        }",
    );
}

#[test]
fn cuda_integer_atomic_operations_merge_prototypes_and_keep_extra_scalar_overloads() {
    for operation in OPERATIONS {
        roundtrip(&format!(
            "__device__ int {operation}(int *, int);
            __device__ unsigned {operation}(unsigned *, unsigned);
            __device__ int {operation}(int value, int amount) {{ return value + amount; }}
            __global__ void kernel(int *output, unsigned *other) {{
                output[1] = {operation}(output, 2);
                other[1] = {operation}(other, 3u);
                output[2] = {operation}(4, 5);
                output[3] = atomicAdd(output + 3, 1);
            }}"
        ));
    }
}

#[test]
fn cuda_integer_atomic_operations_reject_invalid_pointees_arity_and_private_operations() {
    for operation in OPERATIONS {
        rejected(&format!(
            "__global__ void kernel(const int *input) {{ {operation}(input, 1); }}"
        ));
        rejected(&format!(
            "__global__ void kernel(int *output) {{ {operation}(output); }}"
        ));
        rejected(&format!(
            "__global__ void kernel() {{ int local = 3; {operation}(&local, 1); }}"
        ));
    }
    for source in [
        "__global__ void kernel(float *output) { atomicExch(output, 1.0f); }",
        "__global__ void kernel(unsigned long long *output) { atomicMax(output, 1); }",
        "__global__ void kernel(int2 *output) { atomicMin(output, int2{1, 2}); }",
        "__global__ void kernel(int *output) { atomicAnd(output, int2{1, 2}); }",
        "__global__ void kernel(int *output) { atomicOr(0, 1); }",
        "__global__ void kernel(int *output) { atomicXor(output, 1, 2); }",
        "__global__ void kernel(int *output) { atomicSub(output, 1); int local = 3; atomicSub(&local, 1); }",
        "__device__ int exchange(int *destination) { return atomicExch(destination, 1); } __global__ void kernel(int *output) { exchange(output); int local = 3; exchange(&local); }",
        "__global__ void kernel() { int *destination; atomicMax(destination, 1); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_integer_atomic_operations_preserve_signature_errors_and_local_name_hiding() {
    for operation in OPERATIONS {
        rejected(&format!(
            "__device__ unsigned {operation}(int *, int); __global__ void kernel() {{}}"
        ));
        rejected(&format!(
            "__device__ int {operation}(int *destination, int amount) {{ return amount; }} __global__ void kernel() {{}}"
        ));
        rejected(&format!(
            "__global__ void kernel(int *output) {{ int {operation} = 3; output[0] = {operation}(output, 1); }}"
        ));
    }
}
