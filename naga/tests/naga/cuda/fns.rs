use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
}

#[test]
fn cuda_fns_accepts_unsigned_mask_base_and_signed_offset() {
    validate(
        "__global__ void kernel(unsigned *out, unsigned mask, unsigned base, int offset) {
        out[0] = __fns(mask, base, offset);
    }",
    );
}

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
}

#[test]
fn cuda_fns_preserves_mixed_canonical_signature_and_unsigned_result() {
    let module = validate(
        "__device__ unsigned __fns(unsigned, unsigned, int);
        __device__ int consume(int value) { return 1; }
        __device__ int consume(unsigned value) { return 2; }
        __global__ void kernel(int *out) { out[0] = consume(__fns(1u, 0u, 1)); }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            if module.functions[*function].arguments.len() == 1 {
                assert_eq!(
                    module.types[module.functions[*function].arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
                calls += 1;
            }
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_fns_coexists_with_unsigned_offset_user_overload() {
    let module = validate(
        "__device__ unsigned __fns(unsigned mask, unsigned base, unsigned offset) { return 7u; }
        __global__ void kernel(unsigned *out) {
            out[0] = __fns(1u, 0u, 1); out[1] = __fns(1u, 0u, 1u);
        }",
    );
    let mut offsets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            offsets.push(
                module.types[module.functions[*function].arguments[2].ty]
                    .inner
                    .clone(),
            );
        }
        false
    });
    assert_eq!(
        offsets,
        [
            naga::TypeInner::Scalar(naga::Scalar::I32),
            naga::TypeInner::Scalar(naga::Scalar::U32)
        ]
    );
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_fns_literal_boundaries_and_extreme_offsets_roundtrip_without_int64() {
    let (module, info) = validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __fns(0xffffffffu, 0u, 32); out[1] = __fns(0xffffffffu, 31u, -32);
        out[2] = __fns(0xaaaaaaaau, 2u, 0); out[3] = __fns(0xaaaaaaaau, 3u, 0);
        out[4] = __fns(0xaaaaaaaau, 2u, 1); out[5] = __fns(0xaaaaaaaau, 2u, -1);
        out[6] = __fns(0xffffffffu, 0u, 2147483647);
        out[7] = __fns(0xffffffffu, 31u, -2147483647 - 1);
        out[8] = __fns(0u, 31u, 0); out[9] = __fns(0xffffffffu, 31u, 33);
    }",
        &Options::default(),
        Capabilities::empty(),
    );
    assert!(!module.types.iter().any(|(_, ty)| matches!(
        ty.inner,
        naga::TypeInner::Scalar(naga::Scalar { width: 8, .. })
    )));
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_fns_converts_each_source_scalar_before_searching() {
    validate_with_options_and_capabilities(
        "__global__ void kernel(unsigned *out) {
        out[0] = __fns(true, false, true); out[1] = __fns((short)-1, (unsigned short)15, (short)-1);
        out[2] = __fns(0x100000001ULL, 0x100000000ULL, 0x100000001ULL);
        out[3] = __fns(-1LL, 0x10000001fUL, 0xffffffffUL);
        out[4] = __fns(3.75f, 1.75f, 1.75f);
    }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
}

#[test]
fn cuda_fns_reads_each_volatile_argument_once() {
    let module = validate_with_options_and_capabilities(
        "__global__ void kernel(volatile unsigned *input, volatile int *offset, unsigned *out) {
        out[0] = __fns(input[0], input[1], offset[0]);
    }",
        &Options::default(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
    )
    .0;
    assert_eq!(
        module.entry_points[0]
            .function
            .expressions
            .iter()
            .filter(|(_, expr)| matches!(expr, naga::Expression::Load { .. }))
            .count(),
        3
    );
}

#[test]
fn cuda_fns_caches_one_helper_across_kernels_and_nested_calls() {
    let mut nested = String::from("1");
    for _ in 0..10 {
        nested = format!("int(__fns(0xffffffffu, 0u, {nested}))");
    }
    let module = validate(&format!(
        "__global__ void first(unsigned *out, unsigned mask) {{
        out[0] = __fns(mask, 0u, 1); out[1] = __fns(mask, 31u, -1);
    }} __global__ void second(unsigned *out) {{ out[0] = unsigned({nested}); }}"
    ));
    let helpers: Vec<_> = module
        .functions
        .iter()
        .filter(|(_, function)| function.name.as_deref() == Some("_naga_fns"))
        .collect();
    assert_eq!(helpers.len(), 1);
    for (entry, count) in module.entry_points.iter().zip([2, 10]) {
        assert_eq!(entry.function.expressions.iter().filter(|(_, expression)| matches!(expression, naga::Expression::CallResult(function) if *function == helpers[0].0)).count(), count);
    }
    let module = validate(
        "__device__ unsigned device_search(unsigned mask);
        __global__ void first(unsigned *out, unsigned mask) {
            out[0] = device_search(mask); out[1] = __fns(mask, 31u, -1);
        }
        __device__ unsigned device_search(unsigned mask) { return __fns(mask, 0u, 1); }
        __global__ void second(unsigned *out, unsigned mask) {
            out[0] = device_search(mask); out[1] = __fns(mask, 0u, 0);
        }",
    );
    assert_eq!(
        module
            .functions
            .iter()
            .filter(|(_, function)| function.name.as_deref() == Some("_naga_fns"))
            .count(),
        1,
    );
}

#[test]
fn cuda_fns_handles_captured_lazy_and_discarded_effects() {
    validate(
        "__device__ unsigned __fns(bool mask, bool base, bool offset) { return 7u; }
        __device__ unsigned next(unsigned &value) { return value++; }
        __global__ void kernel(unsigned choose, unsigned *out) {
            unsigned value = 1;
            out[0] = __fns(next(value), next(value), int(next(value)));
            choose ? __fns(value++, 0u, 1) : 0u;
            false && __fns(value++, 0u, 1); true || __fns(value++, 0u, 1);
            __fns(value++, 0u, 1); out[1] = value;
        }",
    );
}

#[test]
fn cuda_fns_rejects_invalid_calls_definitions_and_constant_contexts() {
    for arguments in [
        "",
        "1u",
        "1u, 0u",
        "1u, 0u, 1, 2",
        "out, 0u, 1",
        "1u, out, 1",
        "1u, 0u, out",
        "make_uint2(1u, 2u), 0u, 1",
    ] {
        reject(&format!(
            "__global__ void kernel(unsigned *out) {{ __fns({arguments}); }}"
        ));
    }
    reject("__device__ int __fns(unsigned, unsigned, int); __global__ void kernel() {}");
    reject("__device__ unsigned __fns(unsigned mask, unsigned base, int offset) { return mask; } __global__ void kernel() {}");
    reject("__global__ void kernel() { constexpr unsigned value = __fns(1u, 0u, 1); }");
    reject("__global__ void kernel() { unsigned __fns = 0; __fns(1u, 0u, 1); }");
    reject(&format!(
        "__global__ void kernel() {{ {}1{}; }}",
        "__fns(1u, 0u, ".repeat(70),
        ")".repeat(70)
    ));
}

#[test]
fn cuda_fns_barriers_accept_uniform_kernel_arguments_and_workgroup_values() {
    for source in [
        "__global__ void kernel(unsigned mask, unsigned base, int offset) { if (__fns(mask, base, offset) != 0xffffffffu) __syncthreads(); }",
        "__global__ void kernel(unsigned mask, unsigned base, int offset) { unsigned selected = __fns(mask, base, offset); if (selected != 0xffffffffu) __syncthreads(); }",
        "__global__ void kernel() { if (__fns(0xffffffffu, blockIdx.x, int(blockDim.x)) != 0xffffffffu) __syncthreads(); }",
        "__global__ void kernel() { if (__fns(gridDim.x, blockDim.x, int(blockIdx.x)) != 0xffffffffu) __syncthreads(); }",
        "__device__ unsigned next_mask(unsigned &value) { return value++; }
        __device__ unsigned next_base(unsigned &value) { return value++; }
        __device__ int next_offset(int &value) { return value++; }
        __global__ void kernel(unsigned *out, unsigned mask, unsigned base, int offset) {
            unsigned left = mask, right = base; int step = offset;
            out[threadIdx.x] = next_mask(left) + next_base(right) + unsigned(next_offset(step));
            if (__fns(mask, base, offset) != 0xffffffffu) __syncthreads();
        }",
    ] {
        validate(source);
    }
}

#[test]
fn cuda_fns_barriers_accept_uniform_calls_in_synchronizing_helpers() {
    for source in [
        "__device__ void synchronize(unsigned mask, unsigned base, int offset) { if (__fns(mask, base, offset) != 0xffffffffu) __syncthreads(); } __global__ void kernel(unsigned mask, unsigned base, int offset) { synchronize(mask, base, offset); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel(unsigned mask, unsigned base, int offset) { if (__fns(mask, base, offset) != 0xffffffffu) synchronize(); }",
    ] {
        validate(source);
    }
}

#[test]
fn cuda_fns_barriers_reject_each_varying_argument_and_source_overloads() {
    for arguments in [
        "threadIdx.x, 0u, 1",
        "0xffffffffu, threadIdx.x, 1",
        "0xffffffffu, 0u, int(threadIdx.x)",
    ] {
        for source in [
            format!("__global__ void kernel() {{ if (__fns({arguments}) != 0xffffffffu) __syncthreads(); }}"),
            format!("__device__ unsigned next_mask(unsigned &value) {{ return value++; }}
                __device__ unsigned next_base(unsigned &value) {{ return value++; }}
                __device__ int next_offset(int &value) {{ return value++; }}
                __global__ void kernel(unsigned *out) {{
                    unsigned mask = 0xffffffffu, base = 0u; int offset = 1;
                    out[threadIdx.x] = next_mask(mask) + next_base(base) + unsigned(next_offset(offset));
                    if (__fns({arguments}) != 0xffffffffu) __syncthreads();
                }}"),
            format!("__device__ void synchronize(unsigned mask, unsigned base, int offset) {{ if (__fns(mask, base, offset) != 0xffffffffu) __syncthreads(); }} __global__ void kernel() {{ synchronize({arguments}); }}"),
        ] {
            let error = parse_str(&source, &Options::default()).unwrap_err();
            assert!(error.message.contains("barrier"), "{source}: {error}");
        }
    }
    let source = "__device__ unsigned next_mask(unsigned &value) { return value++; }
        __device__ unsigned next_base(unsigned &value) { return value++; }
        __device__ int next_offset(int &value) { return value++; }
        __device__ unsigned native(unsigned mask, unsigned base, int offset) { return __fns(mask, base, offset); }
        __device__ unsigned padding(unsigned value) { return value; }
        __device__ unsigned __fns(unsigned mask, unsigned base, unsigned offset) { return padding(threadIdx.x); }
        __global__ void kernel(unsigned *out, unsigned mask, unsigned base, int offset) {
            unsigned left = mask, right = base; int step = offset;
            out[threadIdx.x] = next_mask(left) + next_base(right) + unsigned(next_offset(step));
            out[0] = native(mask, base, offset);
            if (__fns(mask, base, 1u) != 0xffffffffu) __syncthreads();
        }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(error.message.contains("barrier"), "{error}");
    let source = "__device__ unsigned __fns(unsigned mask, unsigned base, unsigned offset) { return threadIdx.x; } __global__ void kernel(unsigned *out, unsigned mask, unsigned base, int offset) { out[0] = __fns(mask, base, offset); if (__fns(mask, base, 1u) != 0xffffffffu) __syncthreads(); }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(error.message.contains("barrier"), "{error}");
}
