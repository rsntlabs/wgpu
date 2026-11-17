use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

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
fn cuda_nearbyintf_alias_reuses_rintf_cache_across_forward_functions_and_entries() {
    let (module, info) = validate("using Sample = const float;
        __host__ __device__ float nearbyintf(Sample);
        __device__ float rounded(float value);
        __global__ void first(float *out, float value) { out[0] = nearbyintf(value); out[1] = rintf(value); out[2] = rounded(value); }
        __device__ float rounded(float renamed) { return nearbyintf(renamed); }
        __global__ void second(float *out, float value) { out[0] = nearbyintf(rintf(value)); }");
    let helpers: Vec<_> = module
        .functions
        .iter()
        .filter_map(|(handle, function)| {
            (function.name.as_deref() == Some("_naga_rintf")).then_some(handle)
        })
        .collect();
    assert_eq!(helpers.len(), 1);
    let helper = &module.functions[helpers[0]];
    assert_eq!(helper.arguments.len(), 1);
    assert_eq!(
        module.types[helper.arguments[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert!(!module
        .functions
        .iter()
        .any(|(_, function)| function.name.as_deref() == Some("_naga_nearbyintf")));
    let mut calls = 0;
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if matches!(statement, naga::Statement::Call { function, .. } if *function == helpers[0])
            {
                calls += 1;
            }
            false
        });
    }
    assert_eq!(calls, 5);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_nearbyintf_preserves_float_return_and_exact_user_overloads() {
    let (module, _) = validate("__device__ int nearbyintf(bool value) { return value ? 7 : 9; }
        __device__ int kind(float value) { return 1; } __device__ int kind(int value) { return 2; }
        __global__ void kernel(int *out, float value) { out[0] = kind(nearbyintf(value)); out[1] = nearbyintf(true); }");
    let mut float_results = 0;
    let mut boolean_overloads = 0;
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
                float_results += 1;
            } else if callee
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("nearbyintf"))
            {
                assert_eq!(
                    module.types[callee.arguments[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::BOOL)
                );
                boolean_overloads += 1;
            }
        }
        false
    });
    assert_eq!((float_results, boolean_overloads), (1, 1));
    validate("__global__ void kernel(float *out) { out[0] = nearbyintf(3); }");
}

#[test]
fn cuda_nearbyintf_rejects_reserved_invalid_and_nonconstant_uses() {
    for source in [
        "__device__ float nearbyintf(float value) { return value; } __global__ void kernel() {}",
        "__device__ int nearbyintf(float value); __global__ void kernel() {}",
        "__global__ void kernel() { nearbyintf(); }",
        "__global__ void kernel() { nearbyintf(1.0f, 2.0f); }",
        "__global__ void kernel() { nearbyintf(float2(1.0f)); }",
        "__global__ void kernel(float *input) { nearbyintf(input); }",
        "__global__ void kernel() { unsigned nearbyintf = 1u; nearbyintf(1.0f); }",
        "__global__ void kernel() { nearbyint(1.0f); }",
        "__global__ void kernel() { constexpr float value = nearbyintf(2.5f); }",
        "__global__ void kernel() { static_assert(nearbyintf(2.5f) == 2.0f); }",
        "__global__ void kernel() { return; nearbyintf(missing); }",
    ] {
        reject(source);
    }
    let source = "// π UTF-8 span\n__device__ void empty() {} __global__ void kernel() { nearbyintf(empty()); }";
    assert_eq!(&source[reject(source).span.to_range().unwrap()], "empty()");
    validate("__global__ void kernel(float *out) { constexpr float value = true ? 3.0f : nearbyintf(2.5f); out[0] = value; }");
}
