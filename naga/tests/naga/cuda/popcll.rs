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
fn cuda_popcll_converts_arguments_and_returns_signed_int_using_two_32bit_counts() {
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
            "__global__ void kernel(int *output) {{ {declaration}; output[0] = __popcll(value); }}"
        ));
        let function = &module.entry_points[0].function;
        let counts: Vec<_> = function
            .expressions
            .iter()
            .filter_map(|(handle, expression)| match *expression {
                naga::Expression::Math {
                    fun: naga::MathFunction::CountOneBits,
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
fn cuda_popcll_preserves_long_long_signature_identity_and_source_overloads() {
    validate(
        "using Word = unsigned long long;
        __device__ int __popcll(const Word value);
        __device__ int __popcll(unsigned long value) { return 77; }
        __device__ int __popcll(bool value) { return value ? 99 : 98; }
        __global__ void kernel(int *output, Word value) {
            output[0] = __popcll(value);
            output[1] = __popcll(1UL);
            output[2] = __popcll(1ULL);
            output[3] = __popcll(true);
        }",
    );
}

#[test]
fn cuda_popcll_captures_arguments_once_and_preserves_lazy_calls() {
    let (module, _) = validate(
        "__device__ unsigned long long next(int value) { return (unsigned long long)value; }
        __device__ int pair(int first, int second) { return first * 100 + second; }
        __global__ void kernel(int *output, unsigned choose) {
            int value = 3;
            output[0] = pair(__popcll(next(value++)), value++);
            output[1] = choose ? __popcll(value++) : 17;
            bool active = choose && __popcll(value++);
            output[2] = int(active); output[3] = value;
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
fn cuda_popcll_rejects_redefinition_hiding_and_constant_expression_uses() {
    for source in [
        "__device__ int __popcll(unsigned long long value) { return 7; } __global__ void kernel() {}",
        "__device__ unsigned __popcll(unsigned long long value); __global__ void kernel() {}",
        "__global__ void kernel() { __popcll(); }",
        "__global__ void kernel() { __popcll(1ULL, 2ULL); }",
        "__global__ void kernel() { int __popcll = 0; __popcll(1ULL); }",
        "__global__ void kernel() { constexpr int Count = __popcll(3ULL); }",
        "__global__ void kernel() { int values[__popcll(3ULL)]; }",
    ] { rejected(source); }
}

#[test]
fn cuda_popcll_loads_a_volatile_argument_once() {
    let source = "__global__ void kernel(int *output, volatile unsigned long long *input) { output[0] = __popcll(input[0]); }";
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
fn cuda_popcll_bounds_generated_expression_depth() {
    let mut value = String::from("1ULL");
    for _ in 0..40 {
        value = format!("__popcll({value})");
    }
    let error = rejected(&format!(
        "__global__ void kernel(int *output) {{ output[0] = {value}; }}"
    ));
    assert!(error.message.contains("graph depth"), "{error}");
}
