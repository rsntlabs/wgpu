use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_clzll_converts_arguments_and_returns_int_using_32bit_counts() {
    for declaration in [
        "bool value = true",
        "short value = -1",
        "unsigned short value = 7",
        "int value = -1",
        "unsigned value = 0xffffffffu",
        "long value = -1L",
        "unsigned long value = 0xffffffffffffffffUL",
        "long long value = -1LL",
        "unsigned long long value = 0xffffffffffffffffULL",
        "float value = 3.75f",
    ] {
        let (module, info) = validate(&format!(
            "__global__ void kernel(int *output) {{ {declaration}; output[0] = __clzll(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let counts: Vec<_> = function
            .expressions
            .iter()
            .filter_map(|(handle, expression)| match *expression {
                naga::Expression::Math {
                    fun: naga::MathFunction::CountLeadingZeros,
                    arg,
                    ..
                } => Some((handle, arg)),
                _ => None,
            })
            .collect();
        assert_eq!(counts.len(), 2, "{declaration}");
        for (handle, argument) in counts {
            for expression in [handle, argument] {
                assert_eq!(
                    info.get_entry_point(0)[expression]
                        .ty
                        .inner_with(&module.types),
                    &naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
        let mut stores = 0;
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Store { pointer, value } = *statement {
                let root = super::helpers::root_expression(function, pointer);
                if matches!(
                    function.expressions[root],
                    naga::Expression::GlobalVariable(_)
                ) {
                    assert_eq!(
                        info.get_entry_point(0)[value].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(naga::Scalar::I32)
                    );
                    stores += 1;
                }
            }
            false
        });
        assert_eq!(stores, 1);
        assert!(module.functions.is_empty());
    }
}

#[test]
fn cuda_clzll_preserves_signed_long_long_prototypes_and_signed_int_result_overloads() {
    let (module, _) = validate(
        "using Word = long long;
        __device__ int __clzll(const Word value);
        __device__ int __clzll(long value) { return 77; }
        __device__ int __clzll(bool value) { return value ? 99 : 98; }
        __device__ int selected(int value) { return 11; }
        __device__ int selected(long value) { return 22; }
        __device__ int selected(Word value) { return 33; }
        __global__ void kernel(int *output, Word value) {
            auto count = __clzll(value);
            output[0] = selected(count);
            output[1] = selected(__clzll(1LL));
            output[2] = __clzll(1L);
            output[3] = __clzll(true);
            output[4] = __clzll(false);
        }",
    );
    let selected = module
        .functions
        .iter()
        .find_map(|(handle, function)| {
            (function.name.as_deref() == Some("selected")
                && module.types[function.arguments[0].ty].inner
                    == naga::TypeInner::Scalar(naga::Scalar::I32))
            .then_some(handle)
        })
        .unwrap();
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            calls += usize::from(function == selected);
        }
        false
    });
    assert_eq!(calls, 2);
}

#[test]
fn cuda_clzll_captures_arguments_once_and_preserves_lazy_calls() {
    let (module, _) = validate(
        "__device__ long long next(int value) { return (long long)value; }
        __device__ int pair(int first, int second) { return first * 100 + second; }
        __global__ void kernel(int *output, unsigned choose) {
            int value = 3;
            output[0] = pair(__clzll(next(value++)), value++);
            output[1] = choose ? __clzll(value++) : 17;
            bool active = choose && __clzll(value++);
            output[2] = int(active);
            output[3] = value;
        }",
    );
    let next = module
        .functions
        .iter()
        .find_map(|(handle, function)| (function.name.as_deref() == Some("next")).then_some(handle))
        .unwrap();
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            calls += usize::from(function == next);
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_clzll_rejects_canonical_redefinitions_mismatched_results_and_nonconstant_uses() {
    for source in [
        "__device__ int __clzll(long long value) { return 7; } __global__ void kernel() {}",
        "__device__ long __clzll(long long value); __global__ void kernel() {}",
        "__device__ long long __clzll(long long value); __global__ void kernel() {}",
        "__device__ const int __clzll(long long value); __global__ void kernel() {}",
        "__global__ void kernel() { __clzll(); }",
        "__global__ void kernel() { __clzll(1LL, 2LL); }",
        "__global__ void kernel() { int __clzll = 0; __clzll(1LL); }",
        "__global__ void kernel() { constexpr int Count = __clzll(1LL); }",
        "__global__ void kernel() { int values[__clzll(1LL)]; }",
        "__global__ void kernel() { static_assert(__clzll(1LL) == 63); }",
        "__global__ void kernel(int *pointer) { __clzll(pointer); }",
        "__global__ void kernel() { __clzll(make_uint2(1u, 2u)); }",
        "__device__ void ignored() {} __global__ void kernel() { __clzll(ignored()); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_clzll_loads_a_volatile_argument_once() {
    let source = "__global__ void kernel(int *output, volatile long long *input) { output[0] = __clzll(input[0]); }";
    let (module, _) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64 | Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    let input = module
        .global_variables
        .iter()
        .find_map(|(handle, variable)| {
            (variable.name.as_deref() == Some("input")).then_some(handle)
        })
        .unwrap();
    let function = &module.entry_points[0].function;
    let loads = function
        .expressions
        .iter()
        .filter(|(_, expression)| match **expression {
            naga::Expression::Load { pointer } => {
                let root = super::helpers::root_expression(function, pointer);
                function.expressions[root] == naga::Expression::GlobalVariable(input)
            }
            _ => false,
        })
        .count();
    assert_eq!(loads, 1);
    assert!(module.global_variables[input]
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
}

#[test]
fn cuda_clzll_bounds_generated_expression_depth() {
    let mut value = String::from("1LL");
    for _ in 0..40 {
        value = format!("__clzll({value})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(int *output) {{ output[0] = {value}; }}"
    ));
    assert!(error.message.contains("graph depth"), "{error}");
}
