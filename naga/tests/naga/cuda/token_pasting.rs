use super::helpers::validate;

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn returned_literal(module: &naga::Module, name: &str) -> naga::Literal {
    let function = module
        .functions
        .iter()
        .find(|(_, function)| function.name.as_deref() == Some(name))
        .unwrap()
        .1;
    let value = function
        .body
        .iter()
        .find_map(|statement| match *statement {
            naga::Statement::Return { value: Some(value) } => Some(value),
            _ => None,
        })
        .unwrap();
    match function.expressions[value] {
        naga::Expression::Literal(literal) => literal,
        ref other => panic!("expected a literal, got {other:?}"),
    }
}

#[test]
fn cuda_token_pasting_generates_identifiers_types_and_function_names() {
    let (module, _) = roundtrip(
        "#define JOIN(left, right) left ## right
        #define COUNT_TYPE u ## nsigned
        using Count = COUNT_TYPE;
        __device__ Count JOIN(incre, ment)(Count value) { return value + 1u; }
        __device__ Count JOIN(lite, ral)() { return 17u; }
        __global__ void JOIN(ker, nel)(Count *output) {
            Count JOIN(local, _value) = JOIN(lite, ral)();
            output[0] = JOIN(incre, ment)(JOIN(local, _value));
        }",
    );
    assert_eq!(module.entry_points[0].name, "kernel");
    assert_eq!(returned_literal(&module, "literal"), naga::Literal::U32(17));
    assert!(module
        .functions
        .iter()
        .any(|(_, function)| function.name.as_deref() == Some("increment")));
}

#[test]
fn cuda_token_pasting_generates_numeric_and_operator_tokens() {
    let (module, _) = roundtrip(
        "#define JOIN(left, right) left ## right
        #define INTEGER 0x ## ffu
        #define APPEND_FLOAT(value) value ## f
        #define PLUS_ASSIGN + ## =
        #define SHIFT_RIGHT > ## >
        __device__ unsigned decimal() { return JOIN(1, 7u); }
        __device__ unsigned hexadecimal() { return INTEGER; }
        __device__ float fraction() { return JOIN(0x1.8p, 1f); }
        __device__ float suffixed() { return APPEND_FLOAT(0x1p0); }
        __global__ void kernel(unsigned *output) {
            unsigned value = decimal();
            value PLUS_ASSIGN hexadecimal();
            value = value SHIFT_RIGHT 1u;
            bool same = value JOIN(=, =) 136u;
            bool enabled = same JOIN(&, &) true;
            output[0] = enabled ? value : 0u;
            output[1] = unsigned(fraction() + suffixed());
        }",
    );
    assert_eq!(returned_literal(&module, "decimal"), naga::Literal::U32(17));
    assert_eq!(
        returned_literal(&module, "hexadecimal"),
        naga::Literal::U32(255)
    );
    assert_eq!(
        returned_literal(&module, "fraction"),
        naga::Literal::F32(3.0)
    );
    assert_eq!(
        returned_literal(&module, "suffixed"),
        naga::Literal::F32(1.0)
    );
}

#[test]
fn cuda_token_pasting_distinguishes_raw_arguments_and_rescans_results() {
    let (module, _) = roundtrip(
        "#define JOIN(left, right) left ## right
        #define EXPAND_JOIN(left, right) JOIN(left, right)
        #define PREFIX human
        #define PREFIX_tail 5u
        #define human_tail 11u
        #define FUNCTION_NAME read ## _value
        #define read_value() 13u
        #define CALL_PASTED(prefix) prefix ## _function()
        #define generated_function() 19u
        __device__ unsigned raw_argument() { return JOIN(PREFIX, _tail); }
        __device__ unsigned expanded_argument() { return EXPAND_JOIN(PREFIX, _tail); }
        __device__ unsigned rescanned_function() { return FUNCTION_NAME(); }
        __device__ unsigned substituted_function() { return CALL_PASTED(generated); }
        __global__ void kernel(unsigned *output) {
            output[0] = raw_argument(); output[1] = expanded_argument();
            output[2] = rescanned_function(); output[3] = substituted_function();
        }",
    );
    for (name, expected) in [
        ("raw_argument", 5),
        ("expanded_argument", 11),
        ("rescanned_function", 13),
        ("substituted_function", 19),
    ] {
        assert_eq!(
            returned_literal(&module, name),
            naga::Literal::U32(expected),
            "{name}"
        );
    }
}

#[track_caller]
fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error =
        naga::front::cuda::parse_str(source, &naga::front::cuda::Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    error
}

#[track_caller]
fn selects(definitions: &str, expression: &str) {
    let expression = expression.replace('\n', " ");
    roundtrip(&format!(
        "{definitions}\n#if !({expression})\ninvalid;\n#endif\n__global__ void kernel() {{}}"
    ));
}

#[test]
fn cuda_token_pasting_handles_placemarkers_multitoken_edges_and_portable_chains() {
    selects(
        "#define JOIN(left, right) left ## right
        #define THREE(first, middle, last) first ## middle ## last
        #define value 10u",
        "JOIN(, 7u) == 7u && JOIN(11u, ) == 11u
        && (4u JOIN(, ) + 5u) == 9u
        && JOIN(/* empty */, 13u) == 13u
        && JOIN(17u, /* empty */) == 17u
        && JOIN(3u + val, ue + 2u) == 15u
        && JOIN(2, u + 3u) == 5u
        && THREE(1, 2, 3u) == 123u
        && THREE(1, , 3u) == 13u
        && THREE(, 2, 3u) == 23u
        && THREE(1, 2, ) == 12
        && (7u THREE(, , ) + 11u) == 18u",
    );
    roundtrip(
        "#define SHIFT_ASSIGN > ## > ## =
        __global__ void kernel(unsigned *output) {
            unsigned value = 32u; value SHIFT_ASSIGN 2u; output[0] = value;
        }",
    );
}

#[test]
fn cuda_token_pasting_separates_raw_prescanned_and_empty_macro_arguments() {
    selects(
        "#define JOIN(left, right) left ## right
        #define EXPAND_JOIN(left, right) JOIN(left, right)
        #define VALUE 3u
        #define VALUE_tail 17u
        #define MIXED(value) (value + value ## _tail)
        #define EMPTY
        #define EMPTYtail 23u
        #define tail 29u",
        "MIXED(VALUE) == 20u && JOIN(EMPTY, tail) == 23u
        && EXPAND_JOIN(EMPTY, tail) == 29u",
    );
    selects(
        "#define JOIN(left, right) left ## right",
        "JOIN(__LINE__, _tag) == 0 && JOIN(def, ined_name) == 0",
    );
}

#[test]
fn cuda_token_pasting_preserves_invocation_suppression_and_placemarker_identity() {
    for source in [
        "constexpr unsigned AB = 7u;
        #define AB CAT(A, B)
        #define CAT(left, right) left ## right
        __global__ void kernel(unsigned *output) { output[0] = AB; }",
        "constexpr unsigned CAT = 11u;
        #define AB CAT
        #define CAT(left, right) left ## right
        __global__ void kernel(unsigned *output) { output[0] = AB(A, B); }",
        "constexpr unsigned AB = 13u;
        #define CAT(left, right) left ## right
        #define AB CAT(A, B)
        #define PASS_EMPTY(value) CAT(, value)
        __global__ void kernel(unsigned *output) { output[0] = PASS_EMPTY(AB); }",
        "constexpr unsigned AB = 17u;
        #define CAT(left, right) left ## right
        #define AB CAT(A, B)
        #define PASS_EMPTY(value) CAT(value, )
        __global__ void kernel(unsigned *output) { output[0] = PASS_EMPTY(AB); }",
    ] {
        roundtrip(source);
    }
    for definitions in [
        "#define reenter(value) JOIN(re, enter)(value)",
        "#define reenter(value) JOIN(next_, step)(value)
        #define next_step(value) JOIN(re, enter)(value)",
    ] {
        roundtrip(&format!(
            "__device__ unsigned reenter(unsigned value) {{ return value + 100u; }}
            #define JOIN(left, right) left ## right
            #define IDENTITY(value) value
            {definitions}
            __global__ void kernel(unsigned *output) {{
                output[0] = reenter(7u);
                output[1] = IDENTITY(reenter(11u));
            }}"
        ));
    }
}

#[test]
fn cuda_token_pasting_preserves_quoted_tokens_and_existing_preprocessing_modes() {
    selects(
        r###"#define JOIN(left, right) left ## right
        #define IGNORE(value) 7u
        #define EXPAND_IGNORE(value) IGNORE(value)
        #define TEXT "## value""###,
        r###"EXPAND_IGNORE(JOIN(L, "ignored")) == 7u
        && EXPAND_IGNORE(JOIN(u, 'a')) == 7u
        && EXPAND_IGNORE(TEXT) == 7u"###,
    );
    for definitions in [
        "#define JOIN(left, right) left ## right
        #define QUERY JOIN(def, ined)
        #define NAME 7
        #if QUERY(NAME)
        #endif",
        "#define JOIN(left, right) left ## right
        #define PROVIDER JOIN(__LI, NE__)",
    ] {
        let body = if definitions.contains("PROVIDER") {
            "__global__ void kernel(unsigned *output) { output[0] = PROVIDER; }"
        } else {
            "__global__ void kernel() {}"
        };
        rejected(&format!("{definitions}\n{body}"));
    }
    rejected(
        "#define JOIN(left, right) left ## right
        #define FACTOR JOIN(1, 6)
        __global__ void kernel(unsigned *output) {
        #pragma unroll FACTOR
            for (unsigned index = 0u; index < 2u; ++index) output[index] = index;
        }",
    );
}

#[test]
fn cuda_token_pasting_defers_language_conversion_and_keeps_generated_hashes_ordinary() {
    selects(
        "#define BAD_NUMBER 1e+ ## f
        #define DROP(value) 7u
        #define FORWARD(value) DROP(value)
        #define HASH_HASH # ## #",
        "FORWARD(BAD_NUMBER) == 7u && FORWARD(HASH_HASH) == 7u",
    );
    roundtrip(
        "#define BAD_PASTE + ## *
        #define DROP(value) 7u
        #if 0
        BAD_PASTE
        #endif
        __global__ void kernel(unsigned *output) { output[0] = DROP(BAD_PASTE); }",
    );
    for body in [
        "unsigned human_count = 7u; output[0] = WRAP(human, _count);",
        "output[0] = IDENTITY(##);",
        "return; output[0] = WRAP(human, _count);",
    ] {
        rejected(&format!(
            "#define HASH_HASH # ## #
            #define WRAP(left, right) left HASH_HASH right
            #define IDENTITY(value) value
            __global__ void kernel(unsigned *output) {{ {body} }}"
        ));
    }
    for (definitions, invocation) in [
        ("#define JOIN(left, right) left ## right", "JOIN(1e+, f)"),
        (
            "#define JOIN(left, right) left ## right\n#define OUTER(value) value",
            "OUTER(JOIN(1e+, f))",
        ),
        ("#define BAD_NUMBER 1e+ ## f", "BAD_NUMBER"),
    ] {
        let source = format!(
            "/* café 漢 */\n{definitions}\n__global__ void kernel(float *output) {{
                output[0] = {invocation};
            }}"
        );
        let error = rejected(&source);
        let start = source.rfind(invocation).unwrap();
        assert_eq!(
            error.span.to_range(),
            Some(start..start + invocation.len()),
            "{error}"
        );
    }
}

#[test]
fn cuda_token_pasting_rejects_invalid_endpoints_and_non_token_results() {
    for definition in [
        "#define BAD ## token",
        "#define BAD token ##",
        "#define BAD(value) ## value",
        "#define BAD(value) value ##",
        "#define BAD ##",
    ] {
        rejected(&format!("{definition}\n__global__ void kernel() {{}}"));
    }
    for invocation in ["JOIN(+, *)", "JOIN(/, *)", "JOIN(/, /)", "JOIN(human, +)"] {
        rejected(&format!(
            "#define JOIN(left, right) left ## right
            __global__ void kernel() {{ {invocation}; }}"
        ));
    }
    rejected(
        "#define BAD_PASTE + ## *
        __global__ void kernel() { return; BAD_PASTE; }",
    );
}

#[test]
fn cuda_token_pasting_keeps_long_spellings_and_expansion_depth_bounded() {
    let suffix = "x".repeat(4096);
    roundtrip(&format!(
        "#define JOIN(left, right) left ## right
        __global__ void kernel(unsigned *output) {{
            unsigned JOIN(human, {suffix}) = 7u;
            output[0] = JOIN(human, {suffix});
        }}"
    ));
    let source = |depth: usize| {
        let mut definitions = String::new();
        for index in 0..depth {
            definitions.push_str(&format!(
                "#define branch_{index} branch_ ## {}\n",
                index + 1
            ));
        }
        definitions.push_str(&format!("#define branch_{depth} 7u\n"));
        format!("{definitions}__global__ void kernel(unsigned *output) {{ output[0] = branch_0; }}")
    };
    roundtrip(&source(8));
    let error = rejected(&source(512));
    assert!(error.message.contains("limit"), "{error}");
}
