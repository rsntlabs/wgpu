use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/atomic-wrap.cu");

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
fn cuda_atomic_wrap_accepts_unsigned_thresholds_conversions_and_deep_runtime_limits() {
    let (module, info) = validate(FIXTURE);
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
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
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    for operation in ["atomicInc", "atomicDec"] {
        let limit_source = |terms| {
            format!(
                "__device__ unsigned limit_value() {{ return 3u; }}
            __global__ void kernel(unsigned *output) {{
                output[1] = {operation}(output, limit_value(){});
            }}",
                " + 0u".repeat(terms),
            )
        };
        roundtrip(&limit_source(64));
        rejected(&limit_source(65));
        roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{ output[1] = {operation}(output, true); }}"
        ));
    }
}

#[test]
fn cuda_atomic_wrap_preserves_existing_atomic_pointer_depth_capacity() {
    let nested_source = |operation: &str, levels: usize| {
        let mut source = String::from("struct Nest0 { unsigned value; };\n");
        for level in 1..=levels {
            source.push_str(&format!(
                "struct Nest{level} {{ Nest{} inner; }};\n",
                level - 1
            ));
        }
        let operands = if operation == "atomicCAS" {
            ", 0u, 1u"
        } else {
            ", 1u"
        };
        source.push_str(&format!(
            "__global__ void kernel(Nest{levels} *records) {{ {operation}(&records[0]{}.value{operands}); }}",
            ".inner".repeat(levels),
        ));
        source
    };
    for operation in ["atomicAdd", "atomicCAS"] {
        roundtrip(&nested_source(operation, 61));
    }
    for operation in ["atomicInc", "atomicDec"] {
        roundtrip(&nested_source(operation, 61));
        let source = nested_source(operation, 62);
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert_eq!(error.message, "CUDA expression graph depth limit exceeded");
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty());
        assert!(source.get(range).is_some());
    }
}

#[test]
fn cuda_atomic_wrap_captures_pointer_and_limit_once() {
    for operation in ["atomicInc", "atomicDec"] {
        roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{
                __shared__ unsigned counter;
                counter = output[9];
                unsigned index = 0;
                unsigned limit = 3;
                output[0] = {operation}(&counter + index++, limit++);
                output[1] = counter;
                output[5] = index;
                output[6] = limit;
            }}"
        ));
    }
}

#[test]
fn cuda_atomic_wrap_forwards_helpers_origins_fields_and_contention_cycles() {
    roundtrip(
        "__device__ unsigned cycle(unsigned *destination, unsigned limit);
        __global__ void kernel(unsigned *output) {
            __shared__ unsigned shared;
            shared = 3u;
            __syncthreads();
            unsigned *selected = output[7] ? &shared : output + 8;
            output[0] = cycle(selected, 3u);
            __syncthreads();
            output[1] = shared;
            output[2] = output[8];
            bool skipped = false && atomicInc(output + 8, 0u);
            bool ready = true || atomicDec(output + 8, 0u);
            output[3] = int(skipped) + int(ready);
            output[4] = output[7] ? atomicInc(output + 8, 3u) : atomicDec(output + 8, 3u);
            output[5] = output[8];
        }
        __device__ unsigned cycle(unsigned *destination, unsigned limit) {
            unsigned previous = atomicInc(destination, limit);
            atomicDec(destination, limit);
            return previous;
        }",
    );
    roundtrip(
        "struct Counter { unsigned value; uint2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            unsigned previous = atomicInc(&records[0].value, 3u);
            unsigned previous_component = atomicDec(&records[0].pair.y, 3u);
            Counter after = records[0];
            records[1] = after;
            records[2].value = previous;
            records[2].pair.x = previous_component;
            records[2].pair.y = before.pair.y;
        }",
    );
    for operation in ["atomicInc", "atomicDec"] {
        roundtrip(&format!(
            "__global__ void kernel(unsigned *output) {{
                unsigned previous = {operation}(output, 3u);
                atomicAdd(output + previous + 1u, 1u);
            }}"
        ));
    }
}

#[test]
fn cuda_atomic_wrap_merges_prototypes_and_preserves_scalar_overloads_and_name_hiding() {
    for operation in ["atomicInc", "atomicDec"] {
        roundtrip(&format!(
            "__device__ unsigned {operation}(unsigned *, unsigned);
            __device__ unsigned {operation}(unsigned value, unsigned limit) {{ return value + limit; }}
            __global__ void kernel(unsigned *output) {{
                output[1] = {operation}(output, 3u);
                output[2] = {operation}(4u, 5u);
            }}"
        ));
        for source in [
            format!("__device__ int {operation}(unsigned *, unsigned); __global__ void kernel() {{}}"),
            format!("__device__ unsigned {operation}(unsigned *destination, unsigned limit) {{ return limit; }} __global__ void kernel() {{}}"),
            format!("__global__ void kernel(unsigned *output) {{ unsigned {operation} = 3u; output[0] = {operation}(output, 1u); }}"),
        ] {
            rejected(&source);
        }
    }
}

#[test]
fn cuda_atomic_wrap_rejects_invalid_pointees_arity_private_calls_and_unset_operands() {
    for operation in ["atomicInc", "atomicDec"] {
        for source in [
            format!("__global__ void kernel(int *output) {{ {operation}(output, 1u); }}"),
            format!("__global__ void kernel(const unsigned *input) {{ {operation}(input, 1u); }}"),
            format!("__global__ void kernel(float *output) {{ {operation}(output, 1u); }}"),
            format!("__global__ void kernel(uint2 *output) {{ {operation}(output, 1u); }}"),
            format!("__global__ void kernel(unsigned *output) {{ {operation}(output, uint2{{1u, 1u}}); }}"),
            format!("__global__ void kernel() {{ {operation}(); }}"),
            format!("__global__ void kernel(unsigned *output) {{ {operation}(output); }}"),
            format!("__global__ void kernel(unsigned *output) {{ {operation}(output, 1u, 2u); }}"),
            format!("__global__ void kernel() {{ unsigned local = 3u; {operation}(&local, 1u); }}"),
            format!("__global__ void kernel(unsigned *output) {{ {operation}(output, 1u); unsigned local = 3u; {operation}(&local, 1u); }}"),
            format!("__device__ unsigned wrap(unsigned *destination) {{ return {operation}(destination, 1u); }} __global__ void kernel(unsigned *output) {{ wrap(output); unsigned local = 3u; wrap(&local); }}"),
            format!("__global__ void kernel() {{ unsigned *destination; {operation}(destination, 1u); }}"),
            format!("__global__ void kernel(unsigned *output) {{ unsigned *unset; {operation}(output, *unset); }}"),
        ] {
            rejected(&source);
        }
    }
}
