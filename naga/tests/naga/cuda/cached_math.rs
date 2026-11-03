use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate, validate_with_options};

const PARTICLES: &str = include_str!("../../in/cuda/particles.cu");
const CALLERS: &str = "__device__ float lower(float value) { return floorf(value); }
    __device__ float upper(float value) { return ceilf(value); }
    __device__ float magnitude(float value) { return fabsf(value) + fabs(value); }";

fn roundtrip(module: &naga::Module, info: &naga::valid::ModuleInfo) {
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(module, info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES);
    let _ = (module, info);
}

fn calls(block: &naga::Block) -> Vec<naga::Handle<naga::Function>> {
    let mut callees = Vec::new();
    naga::proc::any_statement(block, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            callees.push(function);
        }
        false
    });
    callees
}

fn named_function<'a>(module: &'a naga::Module, name: &str) -> &'a naga::Function {
    module
        .functions
        .iter()
        .find_map(|(_, function)| (function.name.as_deref() == Some(name)).then_some(function))
        .unwrap_or_else(|| panic!("missing function {name}"))
}

fn is_bit_helper(module: &naga::Module, handle: naga::Handle<naga::Function>) -> bool {
    let function = &module.functions[handle];
    function.arguments.len() == 1
        && module.types[function.arguments[0].ty].inner
            == naga::TypeInner::Scalar(naga::Scalar::U32)
        && function.result.as_ref().is_some_and(|result| {
            module.types[result.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)
        })
}

fn bit_helpers(module: &naga::Module) -> Vec<naga::Handle<naga::Function>> {
    module
        .functions
        .iter()
        .filter_map(|(handle, _)| is_bit_helper(module, handle).then_some(handle))
        .collect()
}

fn operation_helpers(module: &naga::Module) -> [naga::Handle<naga::Function>; 3] {
    let lower = calls(&named_function(module, "lower").body);
    let upper = calls(&named_function(module, "upper").body);
    let magnitude = calls(&named_function(module, "magnitude").body);
    assert_eq!(lower.len(), 1);
    assert_eq!(upper.len(), 1);
    assert_eq!(magnitude.len(), 2);
    assert_eq!(
        magnitude[0], magnitude[1],
        "fabs and fabsf must share one helper"
    );
    let helpers = [lower[0], upper[0], magnitude[0]];
    assert!(helpers.iter().all(|&handle| is_bit_helper(module, handle)));
    assert_ne!(helpers[0], helpers[1]);
    assert_ne!(helpers[0], helpers[2]);
    assert_ne!(helpers[1], helpers[2]);
    helpers
}

#[test]
fn cuda_cached_math_reuses_one_integer_bit_helper_per_operation_across_callers() {
    let source = format!(
        "{CALLERS}
        __global__ void kernel(float *output, float value) {{
            output[0] = floorf(value); output[1] = ceilf(value);
            output[2] = fabs(value); output[3] = fabsf(value);
            output[4] = lower(value) + upper(value) + magnitude(value);
        }}"
    );
    let (module, info) = validate(&source);
    let [floor, ceiling, absolute] = operation_helpers(&module);
    assert_eq!(bit_helpers(&module).len(), 3);
    let kernel_helpers: Vec<_> = calls(&module.entry_points[0].function.body)
        .into_iter()
        .filter(|&handle| is_bit_helper(&module, handle))
        .collect();
    assert_eq!(kernel_helpers, [floor, ceiling, absolute, absolute]);
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        assert!(!function.expressions.iter().any(|(_, expression)| matches!(
            *expression,
            naga::Expression::Math {
                fun: naga::MathFunction::Floor | naga::MathFunction::Ceil | naga::MathFunction::Abs,
                ..
            }
        )));
    }
    roundtrip(&module, &info);
    for name in ["floorf", "ceilf", "fabsf", "fabs"] {
        let source = format!(
            "__global__ void kernel(float *output, float value) {{
            output[0] = {name}(value); output[1] = {name}(value);
        }}"
        );
        let (module, info) = validate(&source);
        let helpers = bit_helpers(&module);
        assert_eq!(
            helpers.len(),
            1,
            "unused math operations must not create helpers"
        );
        assert_eq!(
            calls(&module.entry_points[0].function.body),
            [helpers[0], helpers[0]]
        );
        roundtrip(&module, &info);
    }
    assert!(validate("__global__ void kernel() {}")
        .0
        .functions
        .is_empty());
}

#[test]
fn cuda_cached_math_keeps_ordinary_overloads_and_source_names_independent() {
    let (module, info) = validate(
        "__device__ int floorf(int value) { return value + 40; }
        __device__ int ceilf(bool value) { return value ? 7 : 9; }
        __device__ unsigned fabs(unsigned value) { return value + 50u; }
        __device__ int fabsf(int first, int second) { return first + second; }
        __device__ unsigned _naga_floorf(unsigned value) { return value + 40u; }
        __device__ unsigned _naga_ceilf(unsigned value) { return value + 50u; }
        __device__ unsigned _naga_fabsf(unsigned value) { return value + 60u; }
        __device__ int floorf_bits(int value) { return value + 1; }
        __device__ int ceilf_bits(int value) { return value + 2; }
        __device__ int fabsf_bits(int value) { return value + 3; }
        __global__ void kernel(float *output, float value) {
            auto selected = floorf(3); auto chosen = ceilf(true); auto integer = fabs(4u);
            output[0] = selected + chosen + integer + fabsf(2, 3);
            output[1] = floorf(value) + ceilf(value) + fabs(value) + fabsf(value);
            output[2] = _naga_floorf(2u) + _naga_ceilf(4u) + _naga_fabsf(6u);
            output[3] = floorf_bits(1) + ceilf_bits(2) + fabsf_bits(3);
        }",
    );
    let function = &module.entry_points[0].function;
    for (name, scalar) in [
        ("selected", naga::Scalar::I32),
        ("chosen", naga::Scalar::I32),
        ("integer", naga::Scalar::U32),
    ] {
        let expression = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[expression]
                .ty
                .inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar)
        );
    }
    roundtrip(&module, &info);
}

#[test]
fn cuda_cached_math_literal_and_nonfinite_calls_remain_runtime_operations() {
    let (module, info) = validate(
        "__global__ void kernel(unsigned *output) {
        output[0] = __float_as_uint(floorf(-0.25f));
        output[1] = __float_as_uint(ceilf(-0.25f));
        output[2] = __float_as_uint(fabsf(__uint_as_float(0x7f800001u)));
        output[3] = __float_as_uint(fabs(__uint_as_float(0xff800000u)));
        output[4] = __float_as_uint(floorf(__uint_as_float(0x7f800000u)));
    }",
    );
    assert_eq!(bit_helpers(&module).len(), 3);
    let kernel_calls = calls(&module.entry_points[0].function.body);
    assert_eq!(kernel_calls.len(), 5);
    assert!(kernel_calls
        .iter()
        .all(|&handle| is_bit_helper(&module, handle)));
    roundtrip(&module, &info);
    for name in ["floorf", "ceilf", "fabsf", "fabs"] {
        let source = format!("constexpr float Value = {name}(4.0f); __global__ void kernel() {{}}");
        let error = parse_str(&source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty());
        assert!(source.get(range).is_some());
    }
}

#[test]
fn cuda_cached_math_calls_remain_in_their_selected_branches_and_loop_iterations() {
    let source = format!(
        "{CALLERS}
        __global__ void kernel(unsigned *output, unsigned choose) {{
            float value = -1.5f;
            if (choose) output[0] = __float_as_uint(floorf(value++));
            else output[0] = __float_as_uint(ceilf(value++));
            for (int iteration = 0; iteration < 2; ++iteration) {{
                if (iteration == 0) continue;
                output[1] = __float_as_uint(fabsf(value++));
            }}
            output[2] = __float_as_uint(value);
        }}"
    );
    let (module, info) = validate(&source);
    let [floor, ceiling, absolute] = operation_helpers(&module);
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| {
            matches!(*statement, naga::Statement::If { ref accept, ref reject, .. }
            if calls(accept).contains(&floor) && calls(reject).contains(&ceiling))
        }
    ));
    assert!(naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| {
            matches!(*statement, naga::Statement::Loop { ref body, .. } if calls(body).contains(&absolute))
        }
    ));
    roundtrip(&module, &info);
}

#[test]
fn cuda_cached_math_keeps_the_exact_particle_wave_compact_and_source_named() {
    let (module, info) = validate_with_options(
        PARTICLES,
        &Options {
            workgroup_size: [64, 1, 1],
            ..Options::default()
        },
    );
    let (wave_handle, wave) = module
        .functions
        .iter()
        .find(|&(_, function)| function.name.as_deref() == Some("wave"))
        .unwrap();
    let wave_calls = calls(&wave.body);
    assert_eq!(
        wave_calls.len(),
        4,
        "wave should call division once, rounding once and absolute value twice"
    );
    let division = &module.functions[wave_calls[0]];
    assert_eq!(division.arguments.len(), 2);
    assert!(division.arguments.iter().all(|argument| {
        module.types[argument.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)
    }));
    assert_eq!(
        module.types[division.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    let unary_calls = &wave_calls[1..];
    assert!(unary_calls
        .iter()
        .all(|&handle| is_bit_helper(&module, handle)));
    assert_ne!(unary_calls[0], unary_calls[1]);
    assert_eq!(unary_calls[1], unary_calls[2]);
    assert!(!wave
        .expressions
        .iter()
        .any(|(_, expression)| matches!(*expression, naga::Expression::Select { .. })));
    assert!(
        wave.local_variables
            .iter()
            .all(|(_, local)| local.name.is_some()
                || module.types[local.ty].inner != naga::TypeInner::Scalar(naga::Scalar::U32)),
        "wave retains anonymous integer guard storage"
    );
    for name in ["x", "y"] {
        let value = source_binding_initializer(wave, name);
        assert!(wave.named_expressions.values().any(|actual| actual == name));
        assert_eq!(
            info[wave_handle][value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::F32)
        );
    }
    let root_calls: Vec<_> = calls(&module.entry_points[0].function.body)
        .into_iter()
        .filter(|&handle| is_bit_helper(&module, handle))
        .collect();
    assert_eq!(root_calls.len(), 2);
    assert_eq!(
        root_calls[0], root_calls[1],
        "the existing sqrt helper must remain shared"
    );
    assert!(!wave_calls.contains(&root_calls[0]));
    assert_eq!(bit_helpers(&module).len(), 3);
    roundtrip(&module, &info);
}
