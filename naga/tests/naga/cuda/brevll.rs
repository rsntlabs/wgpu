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
fn cuda_brevll_converts_arguments_and_returns_unsigned_long_long_using_32bit_reversals() {
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
            "__global__ void kernel(unsigned long long *output) {{ {declaration}; output[0] = __brevll(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let reversals: Vec<_> = function
            .expressions
            .iter()
            .filter_map(|(handle, expression)| match *expression {
                naga::Expression::Math {
                    fun: naga::MathFunction::ReverseBits,
                    arg,
                    ..
                } => Some((handle, arg)),
                _ => None,
            })
            .collect();
        assert_eq!(reversals.len(), 2, "{declaration}");
        for (handle, argument) in reversals {
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
                        &naga::TypeInner::Scalar(naga::Scalar::U64)
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
fn cuda_brevll_preserves_long_long_prototypes_and_result_overloads() {
    validate(
        "using Word = unsigned long long;
        __device__ Word __brevll(const Word value);
        __device__ Word __brevll(unsigned long value) { return 77ULL; }
        __device__ Word __brevll(bool value) { return value ? 99ULL : 98ULL; }
        __device__ int selected(Word value) { return 11; }
        __device__ int selected(unsigned long value) { return 22; }
        __device__ int selected(int value) { return 33; }
        __global__ void kernel(int *output, Word value) {
            auto reversed = __brevll(value);
            output[0] = selected(reversed);
            output[1] = selected(__brevll(1ULL));
            output[2] = int(__brevll(1UL));
            output[3] = int(__brevll(true));
            output[4] = int(__brevll(false));
        }",
    );
}

#[test]
fn cuda_brevll_captures_arguments_once_and_preserves_lazy_calls() {
    let (module, _) = validate(
        "__device__ unsigned long long next(int value) { return (unsigned long long)value; }
        __device__ unsigned long long pair(unsigned long long first, int second) { return first | (unsigned long long)second; }
        __global__ void kernel(unsigned long long *output, unsigned choose) {
            int value = 3;
            output[0] = pair(__brevll(next(value++)), value++);
            output[1] = choose ? __brevll(value++) : 17ULL;
            bool active = choose && __brevll(value++);
            output[2] = (unsigned long long)active;
            output[3] = (unsigned long long)value;
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
fn cuda_brevll_rejects_canonical_redefinitions_mismatched_results_and_nonconstant_uses() {
    for source in [
        "__device__ unsigned long long __brevll(unsigned long long value) { return value; } __global__ void kernel() {}",
        "__device__ unsigned long __brevll(unsigned long long value); __global__ void kernel() {}",
        "__device__ int __brevll(unsigned long long value); __global__ void kernel() {}",
        "__device__ const unsigned long long __brevll(unsigned long long value); __global__ void kernel() {}",
        "__global__ void kernel() { __brevll(); }",
        "__global__ void kernel() { __brevll(1ULL, 2ULL); }",
        "__global__ void kernel() { int __brevll = 0; __brevll(1ULL); }",
        "__global__ void kernel() { constexpr unsigned long long Bits = __brevll(3ULL); }",
        "__global__ void kernel() { int values[__brevll(0ULL)]; }",
        "__global__ void kernel() { static_assert(__brevll(1ULL)); }",
        "__global__ void kernel(int *pointer) { __brevll(pointer); }",
        "__global__ void kernel() { __brevll(make_uint2(1u, 2u)); }",
    ] { rejected(source); }
}

#[test]
fn cuda_brevll_loads_a_volatile_argument_once() {
    let source = "__global__ void kernel(unsigned long long *output, volatile unsigned long long *input) { output[0] = __brevll(input[0]); }";
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
fn cuda_brevll_bounds_generated_expression_depth() {
    let mut value = String::from("1ULL");
    for _ in 0..40 {
        value = format!("__brevll({value})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(unsigned long long *output) {{ output[0] = {value}; }}"
    ));
    assert!(error.message.contains("graph depth"), "{error}");
}
