use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_rintf_accepts_fixed_scalar_conversions_and_preserves_float_result() {
    for declaration in [
        "bool value = true;",
        "int value = -3;",
        "unsigned value = 5u;",
        "short value = -7;",
        "long long value = -9LL;",
        "float value = 2.5f;",
    ] {
        let (module, _) = validate_with_options_and_capabilities(
            &format!("using Sample = const float; __host__ __device__ float rintf(Sample); __device__ int kind(float value) {{ return 1; }} __device__ int kind(int value) {{ return 2; }} __global__ void kernel(int *out) {{ {declaration} out[0] = kind(rintf(value)); }}"),
            &Options::default(), Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
        );
        let mut calls = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                let callee = &module.functions[function];
                if callee
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("kind"))
                {
                    assert_eq!(
                        module.types[callee.arguments[0].ty].inner,
                        naga::TypeInner::Scalar(naga::Scalar::F32)
                    );
                    calls += 1;
                }
            }
            false
        });
        assert_eq!(calls, 1);
    }
}

#[test]
fn cuda_rintf_reuses_nearest_even_cache_without_changing_roundf_away_cache() {
    let (module, info) = validate("__device__ float rounded(float value);
        __global__ void first(float *out, float value) { out[0] = rintf(value); out[1] = rounded(value); out[2] = roundf(value); }
        __device__ float rounded(float renamed) { return rintf(renamed); }
        __global__ void second(float *out, float value) { out[0] = rintf(rintf(value)); }");
    let even = module
        .functions
        .iter()
        .find_map(|(handle, function)| {
            (function.name.as_deref() == Some("_naga_rintf")).then_some(handle)
        })
        .unwrap();
    let away = module
        .functions
        .iter()
        .find_map(|(handle, function)| {
            (function.name.as_deref() == Some("_naga_roundf")).then_some(handle)
        })
        .unwrap();
    assert_ne!(even, away);
    let helper = &module.functions[even];
    assert_eq!(helper.arguments.len(), 1);
    assert_eq!(
        module.types[helper.arguments[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    for (handle, _) in helper.expressions.iter() {
        assert!(!info[even][handle]
            .ty
            .inner_with(&module.types)
            .scalar()
            .is_some_and(|scalar| scalar.kind == naga::ScalarKind::Float || scalar.width == 8));
    }
    let mut calls = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if matches!(statement, naga::Statement::Call { function, .. } if *function == even) {
                calls += 1;
            }
            false
        });
    }
    assert_eq!(calls, 4);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_rintf_keeps_halfway_neighbors_and_exceptional_literals_runtime() {
    let bits = [
        0u32,
        0x8000_0000,
        1,
        0x8000_0001,
        0x3eff_ffff,
        0x3f00_0000,
        0x3f00_0001,
        0xbf00_0000,
        0x3fc0_0000,
        0x4020_0000,
        0xc020_0000,
        0x4060_0000,
        0x4aff_ffff,
        0x4b00_0000,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
    ];
    let stores = bits
        .iter()
        .enumerate()
        .map(|(index, bits)| {
            format!("out[{index}] = __float_as_uint(rintf(__uint_as_float(0x{bits:08x}u))); ")
        })
        .collect::<String>();
    let (module, info) = validate(&format!(
        "__global__ void kernel(unsigned *out) {{ {stores} }}"
    ));
    assert_eq!(module.functions.len(), 1);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_rintf_preserves_user_overloads_volatile_and_once_only_effects() {
    let (module, _) = validate_with_options_and_capabilities(
        "__device__ int rintf(bool value) { return value ? 7 : 9; }
        __device__ float next(float &value) { return value++; }
        __global__ void kernel(float *out, const volatile float *input, bool choose) {
            float value = 1.5f; out[0] = rintf(input[0]);
            out[1] = choose ? rintf(next(value)) : rintf(next(value));
            bool skipped = false && rintf(next(value));
            out[2] = float(rintf(choose)); out[3] = value + float(skipped);
        }",
        &Options::default(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let function = &module.entry_points[0].function;
    let reads = function
        .expressions
        .iter()
        .filter(|(_, expression)| {
            let naga::Expression::Load { pointer } = **expression else {
                return false;
            };
            let naga::Expression::GlobalVariable(global) =
                function.expressions[root_expression(function, pointer)]
            else {
                return false;
            };
            module.global_variables[global].binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 1,
                })
        })
        .count();
    assert_eq!(reads, 1);
}

#[test]
fn cuda_rintf_rejects_invalid_declarations_calls_and_source_constant_uses() {
    for source in [
        "__device__ float rintf(float value) { return value; } __global__ void kernel() {}",
        "__device__ int rintf(float value); __global__ void kernel() {}",
        "__global__ void kernel() { rintf(); }",
        "__global__ void kernel() { rintf(1.0f, 2.0f); }",
        "__global__ void kernel() { rintf(float2(1.0f)); }",
        "__global__ void kernel(float *input) { rintf(input); }",
        "__global__ void kernel() { unsigned rintf = 1u; rintf(1.0f); }",
        "__global__ void kernel() { rint(1.0f); }",
        "__global__ void kernel() { constexpr float value = rintf(2.5f); }",
        "__global__ void kernel() { static_assert(rintf(2.5f) == 2.0f); }",
        "__global__ void kernel() { const int count = int(rintf(2.5f)); int values[count]; }",
        "__global__ void kernel() { return; rintf(missing); }",
    ] {
        reject(source);
    }
    let source =
        "// π UTF-8 span\n__device__ void empty() {} __global__ void kernel() { rintf(empty()); }";
    assert_eq!(&source[reject(source).span.to_range().unwrap()], "empty()");
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : rintf(2.5f); out[0] = value; }");
}

#[test]
fn cuda_rintf_guard_purity_tracks_actual_cache_after_forward_reference_remapping() {
    validate("__device__ void increment(unsigned &value) { ++value; } __device__ void synchronize(float value);
        __global__ void kernel(float value, unsigned *out) { unsigned count = 0u; increment(count); out[0] = count; synchronize(value); }
        __device__ void synchronize(float renamed) { if (rintf(renamed) > 0.0f) __syncthreads(); }");
    for source in [
        "__global__ void kernel() { if (rintf(float(threadIdx.x)) > 0.0f) __syncthreads(); }",
        "__device__ unsigned _naga_rintf(unsigned value) { return value; } __global__ void kernel(float value, float *out) { out[0] = rintf(value); if (_naga_rintf(1u)) __syncthreads(); }",
        "__device__ float rintf(int value) { return float(value); } __global__ void kernel(float value, float *out) { out[0] = rintf(value); if (rintf(1) > 0.0f) __syncthreads(); }",
    ] {
        let error = reject(source);
        assert!(error.message.contains("barrier"), "{source}: {error}");
    }
    let mut expression = String::from("value");
    for _ in 0..80 {
        expression = format!("rintf({expression})");
    }
    let error = reject(&format!(
        "__global__ void kernel(float *out, float value) {{ out[0] = {expression}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
}
