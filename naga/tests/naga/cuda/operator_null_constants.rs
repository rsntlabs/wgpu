use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const BOX: &str = "struct Box { unsigned value; };";
const BINARY: &[&str] = &["+", "-", "*", "/", "%", "&", "|", "^", "<<", ">>"];
const LOGICAL: &[&str] = &["&&", "||"];
const LITERALS: &[(&str, &str)] = &[
    ("", "0"),
    ("", "(( /* zero */ 0u ))"),
    ("", "0x0u"),
    ("", "0b0u"),
    ("", "0'0"),
    ("#define ZERO 0\n", "ZERO"),
    ("#define IDENTITY(value) value\n", "IDENTITY((0u))"),
];

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

fn overloads(symbol: &str, zero_on_left: bool, second_pointer: bool) -> String {
    let parameters = |ty: &str| {
        if zero_on_left {
            format!("{ty} zero, Box value")
        } else {
            format!("Box value, {ty} zero")
        }
    };
    let mut source = format!(
        "{BOX}
        __device__ unsigned operator{symbol}({}) {{ return 1u; }}
        __device__ unsigned operator{symbol}({}) {{ return 2u; }}",
        parameters("unsigned *"),
        parameters("dim3"),
    );
    if second_pointer {
        source.push_str(&format!(
            "__device__ unsigned operator{symbol}({}) {{ return 3u; }}",
            parameters("float *"),
        ));
    }
    source
}

fn expression(symbol: &str, zero_on_left: bool, operand: &str) -> String {
    if zero_on_left {
        format!("{operand} {symbol} Box{{7u}}")
    } else {
        format!("Box{{7u}} {symbol} {operand}")
    }
}

fn ambiguous_literals(symbols: &[&str], zero_on_left: bool) {
    for symbol in symbols {
        for &(prefix, operand) in LITERALS {
            let source = format!(
                "{prefix}{}
                __global__ void kernel(unsigned *output) {{ output[0] = {}; }}",
                overloads(symbol, zero_on_left, true),
                expression(symbol, zero_on_left, operand),
            );
            let error = rejected(&source);
            assert!(error.message.contains("ambiguous"), "{source}: {error}");
        }
    }
}

#[test]
fn cuda_operator_null_literals_keep_right_binary_pointer_candidates() {
    ambiguous_literals(BINARY, false);
}

#[test]
fn cuda_operator_null_literals_keep_left_binary_pointer_candidates() {
    ambiguous_literals(BINARY, true);
}

#[test]
fn cuda_operator_null_literals_keep_right_logical_pointer_candidates() {
    ambiguous_literals(LOGICAL, false);
}

#[test]
fn cuda_operator_null_literals_keep_left_logical_pointer_candidates() {
    ambiguous_literals(LOGICAL, true);
}

fn assert_dimension_overload(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 1, "{source}");
    let selected = &module.functions[targets[0]];
    let naga::Statement::Return {
        value: Some(result),
    } = selected.body.last().unwrap()
    else {
        panic!("selected overload must return a value: {source}");
    };
    assert!(
        matches!(
            selected.expressions[*result],
            naga::Expression::Literal(naga::Literal::U32(2))
        ),
        "{source}",
    );
}

fn nonliteral_zeros(symbols: &[&str]) {
    for symbol in symbols {
        for zero_on_left in [false, true] {
            for (prefix, declaration, operand) in [
                ("", "constexpr unsigned zero = 0u;", "zero"),
                ("", "", "unsigned(0)"),
                ("", "", "static_cast<unsigned>(0)"),
                ("", "", "(unsigned)0"),
                ("", "", "(1u - 1u)"),
                ("", "", "+0"),
                ("", "", "-0"),
                ("", "", "false"),
                ("", "", "0.0f"),
                ("", "", "(1u, 0u)"),
                ("", "", "(true ? 0u : 0u)"),
                ("#define ZERO (1u - 1u)\n", "", "ZERO"),
            ] {
                let source = format!(
                    "{prefix}{}
                    __global__ void kernel(unsigned *output) {{
                        {declaration} output[0] = {};
                    }}",
                    overloads(symbol, zero_on_left, true),
                    expression(symbol, zero_on_left, operand),
                );
                assert_dimension_overload(&source);
            }
        }
    }
}

#[test]
fn cuda_operator_computed_zero_uses_binary_dimension_overloads() {
    nonliteral_zeros(BINARY);
}

#[test]
fn cuda_operator_computed_zero_uses_logical_dimension_overloads() {
    nonliteral_zeros(LOGICAL);
}

#[test]
fn cuda_operator_null_literals_match_ordinary_and_explicit_call_rules() {
    for &(prefix, operand) in LITERALS {
        let source = format!(
            "{prefix}{BOX}
            __device__ unsigned selected(unsigned *value) {{ return 1u; }}
            __device__ unsigned selected(float *value) {{ return 3u; }}
            __device__ unsigned selected(dim3 value) {{ return 2u; }}
            __global__ void kernel(unsigned *output) {{ output[0] = selected({operand}); }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("ambiguous"), "{source}: {error}");
        for zero_on_left in [false, true] {
            let arguments = if zero_on_left {
                format!("{operand}, Box{{7u}}")
            } else {
                format!("Box{{7u}}, {operand}")
            };
            let source = format!(
                "{prefix}{}
                __global__ void kernel(unsigned *output) {{ output[0] = operator+({arguments}); }}",
                overloads("+", zero_on_left, true),
            );
            let error = rejected(&source);
            assert!(error.message.contains("ambiguous"), "{source}: {error}");
        }
    }
}

#[test]
fn cuda_operator_null_literals_do_not_fall_back_after_selecting_pointer_overloads() {
    for symbol in BINARY.iter().chain(LOGICAL) {
        for zero_on_left in [false, true] {
            let source = format!(
                "{} __global__ void kernel(unsigned *output) {{ output[0] = {}; }}",
                overloads(symbol, zero_on_left, false),
                expression(symbol, zero_on_left, "0"),
            );
            let error = rejected(&source);
            assert!(
                error.message.contains("expected a borrowed CUDA pointer"),
                "{source}: {error}",
            );
        }
    }
}

#[test]
fn cuda_operator_scalar_syntax_keeps_builtin_unary_and_binary_operations() {
    validate(
        "__device__ unsigned operator+(dim3 value) { return 7u; }
        __device__ unsigned operator!(dim3 value) { return 9u; }
        __device__ unsigned operator+(dim3 left, dim3 right) { return 11u; }
        __device__ unsigned operator&&(dim3 left, dim3 right) { return 13u; }
        __global__ void kernel(unsigned *output) {
            output[0] = unsigned(+0); output[1] = unsigned(!0);
            output[2] = operator+(0); output[3] = operator!(0);
            output[4] = unsigned(0 + 0); output[5] = unsigned(0 && 0);
        }",
    );
    let error = rejected(
        "__device__ unsigned operator*(dim3 value) { return 7u; }
        __global__ void kernel(unsigned *output) { output[0] = *0; }",
    );
    assert!(!error.message.contains("ambiguous"), "{error}");
}

#[test]
fn cuda_operator_converted_and_discarded_zero_values_are_not_null_literals() {
    for operand in [
        "dim3(0)",
        "(1u, 0u)",
        "(true ? 0u : 0u)",
        "static_cast<unsigned>(0)",
        "+0",
    ] {
        let source = format!(
            "__device__ unsigned selected(unsigned *value) {{ return 1u; }}
            __global__ void kernel(unsigned *output) {{ output[0] = selected({operand}); }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("no matching"), "{source}: {error}");
    }
}
fn zero_call_forms(declaration: &str, operand: &str) -> Vec<String> {
    let mut forms = vec![format!(
        "{BOX}
        __device__ unsigned selected(unsigned *value) {{ return 1u; }}
        __device__ unsigned selected(float *value) {{ return 3u; }}
        __device__ unsigned selected(dim3 value) {{ return 2u; }}
        __global__ void kernel(unsigned *output) {{
            {declaration}
            using Count = int; using Frozen = const int;
            using FrozenUnsigned = const unsigned;
            output[0] = selected({operand});
        }}"
    )];
    for symbol in ["+", "&&"] {
        for zero_on_left in [false, true] {
            let declarations = overloads(symbol, zero_on_left, true);
            forms.push(format!(
                "{declarations}
                __global__ void kernel(unsigned *output) {{
                    {declaration}
                    using Count = int; using Frozen = const int;
                    using FrozenUnsigned = const unsigned;
                    output[0] = {};
                }}",
                expression(symbol, zero_on_left, operand),
            ));
            let arguments = if zero_on_left {
                format!("{operand}, Box{{7u}}")
            } else {
                format!("Box{{7u}}, {operand}")
            };
            forms.push(format!(
                "{declarations}
                __global__ void kernel(unsigned *output) {{
                    {declaration}
                    using Count = int; using Frozen = const int;
                    using FrozenUnsigned = const unsigned;
                    output[0] = operator{symbol}({arguments});
                }}"
            ));
        }
    }
    forms
}

#[test]
fn cuda_operator_identity_scalar_casts_are_not_null_pointer_literals() {
    for operand in [
        "int(0)",
        "static_cast<int>(0)",
        "(int)0",
        "unsigned(0u)",
        "static_cast<unsigned>(0u)",
        "(unsigned)0u",
        "Count(0)",
        "Frozen(0)",
        "FrozenUnsigned(0u)",
    ] {
        for source in zero_call_forms("", operand) {
            assert_dimension_overload(&source);
        }
    }
}

#[test]
fn cuda_operator_named_reference_and_member_zeros_are_not_null_pointer_literals() {
    for (declaration, operand) in [
        ("unsigned zero = 0u;", "zero"),
        ("const unsigned zero = 0u;", "zero"),
        (
            "constexpr unsigned zero = 0u; const unsigned &view = zero;",
            "view",
        ),
        ("Box zero{0u};", "zero.value"),
        ("", "Box{0u}.value"),
    ] {
        for source in zero_call_forms(declaration, operand) {
            assert_dimension_overload(&source);
        }
    }
}

#[test]
fn cuda_operator_dimension_construction_and_identity_copy_do_not_inherit_null_literals() {
    for operand in [
        "dim3(0)",
        "dim3(dim3(0))",
        "Dimensions(0)",
        "Dimensions(dim3(0))",
    ] {
        let source = format!(
            "using Dimensions = dim3;
            __device__ unsigned selected(unsigned *value) {{ return 1u; }}
            __global__ void kernel(unsigned *output) {{ output[0] = selected({operand}); }}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("no matching"), "{source}: {error}");
        for symbol in ["+", "&&"] {
            for zero_on_left in [false, true] {
                let parameters = if zero_on_left {
                    "unsigned *pointer, Box value"
                } else {
                    "Box value, unsigned *pointer"
                };
                let call = expression(symbol, zero_on_left, operand);
                let source = format!(
                    "{BOX} using Dimensions = dim3;
                    __device__ unsigned operator{symbol}({parameters}) {{ return 1u; }}
                    __global__ void kernel(unsigned *output) {{ output[0] = {call}; }}"
                );
                let error = rejected(&source);
                assert!(error.message.contains("no matching"), "{source}: {error}");
            }
        }
    }
}
