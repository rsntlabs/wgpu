use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

fn returned_bits(module: &naga::Module, name: &str) -> u32 {
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
    let (value, negative) = match function.expressions[value] {
        naga::Expression::Unary {
            op: naga::UnaryOperator::Negate,
            expr,
        } => (expr, true),
        _ => (value, false),
    };
    let naga::Expression::Literal(naga::Literal::F32(value)) = function.expressions[value] else {
        panic!("expected a direct f32 literal");
    };
    if negative {
        (-value).to_bits()
    } else {
        value.to_bits()
    }
}

fn literal_bits(text: &str) -> u32 {
    let source = format!(
        "/* café 漢 */ __device__ float value() {{ return {text}; }} __global__ void kernel() {{}}"
    );
    let (module, _) = validate(&source);
    let function = module.functions.iter().next().unwrap().1;
    let (handle, _) = function
        .expressions
        .iter()
        .find(|(_, expression)| {
            matches!(expression, naga::Expression::Literal(naga::Literal::F32(_)))
        })
        .unwrap();
    assert_eq!(
        &source[function.expressions.get_span(handle).to_range().unwrap()],
        text.strip_prefix('-').unwrap_or(text)
    );
    returned_bits(&module, "value")
}

fn rejected(text: &str) -> (String, naga::front::cuda::ParseError) {
    let source = format!(
        "/* café 漢 */ __device__ float value() {{ return {text}; }} __global__ void kernel() {{}}"
    );
    let error = parse_str(&source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!error.message.is_empty(), "{text}");
    assert!(!range.is_empty() && source.get(range).is_some(), "{text}");
    (source, error)
}

fn rejected_token(text: &str) {
    let (source, error) = rejected(text);
    assert_eq!(
        &source[error.span.to_range().unwrap()],
        text,
        "{text}: {error}"
    );
}

#[test]
fn cuda_hex_float_literals_accept_binary_exponents_and_digit_separators() {
    for (text, bits) in [
        ("0x1p+0f", 0x3f80_0000),
        ("0X1P+1F", 0x4000_0000),
        ("0x.8p0f", 0x3f00_0000),
        ("0x1.p-1F", 0x3f00_0000),
        ("0xC.68p+2f", 0x4246_8000),
        ("0x1.fp-2F", 0x3ef8_0000),
        ("0x1'0p+2f", 0x4280_0000),
        ("0x1.fp+3f", 0x4178_0000),
        ("0x1.2'8p+0'3f", 0x4114_0000),
        ("0x0'0.8'0P-0'1F", 0x3e80_0000),
        ("0x1f.8p0f", 0x41fc_0000),
        ("0x1e2p0f", 0x43f1_0000),
    ] {
        assert_eq!(literal_bits(text), bits, "{text}");
    }
}

#[test]
fn cuda_hex_float_literals_round_directly_to_nearest_even_binary32() {
    for (text, bits) in [
        ("0x1.000000ffffffp0f", 0x3f80_0000),
        ("0x1.000001p0f", 0x3f80_0000),
        ("0x1.000001000001p0f", 0x3f80_0001),
        ("0x1.000003p0f", 0x3f80_0002),
        ("0x1.000005p0f", 0x3f80_0002),
        ("0x1.ffffffp-1f", 0x3f80_0000),
        (
            "0x1.0000010000000000000000000000000000000001p0f",
            0x3f80_0001,
        ),
        (
            "0x1.0000000000000000000000000000000000000001p-150f",
            0x0000_0001,
        ),
    ] {
        assert_eq!(literal_bits(text), bits, "{text}");
    }
}

#[test]
fn cuda_hex_float_literals_preserve_normal_subnormal_underflow_and_zero_bits() {
    for (text, bits) in [
        ("0x1p-126f", 0x0080_0000),
        ("0x0.fffffep-126f", 0x007f_ffff),
        ("0x0.ffffffp-126f", 0x0080_0000),
        ("0x1p-149f", 0x0000_0001),
        ("0x1p-150f", 0),
        ("0x1.000001p-150f", 0x0000_0001),
        ("0x3p-150f", 0x0000_0002),
        ("0x5p-150f", 0x0000_0002),
        ("0x1.fffffep127f", 0x7f7f_ffff),
        ("0x1p-999999f", 0),
        ("-0x1p-999999f", 0x8000_0000),
        ("0x0p+999999F", 0),
        ("-0x0p0f", 0x8000_0000),
    ] {
        assert_eq!(literal_bits(text), bits, "{text}");
    }
}

#[test]
fn cuda_hex_float_literals_keep_the_existing_finite_rounded_range_policy() {
    for text in [
        "0x1.fffffe8p127f",
        "0x1.fffffefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffp127f",
    ] {
        assert_eq!(literal_bits(text), 0x7f7f_ffff, "{text}");
    }
    for text in [
        "0x1p128f",
        "0x1.ffffffp127f",
        "0x1.ffffff0000000000000000000000000000000001p127f",
        "0x1p999999f",
    ] {
        rejected_token(text);
    }
}

#[test]
fn cuda_hex_float_literals_reject_malformed_tokens_and_unsupported_types() {
    for text in [
        "0xp0f", "0x.p0f", "0x1.f", "0x.8f", "0x1p", "0x1pf", "0x1p+f", "0x1p-f", "0x1paf",
        "0x1p0x1f", "0x1p1.0f", "0x1p0ff", "0x1p0fF", "0x1p0u", "0x1p0f32", "0x1p0h", "0x1p0",
        "0x1.8p0", "0x1p0L", "0x1p0l", "0x1p0f.5", "0x1_p0f", "0x1p0_f", "0x1e+2", "0x1E-2",
    ] {
        rejected_token(text);
    }
    for text in [
        "0x'1p0f",
        "0x1'.0p0f",
        "0x1.'0p0f",
        "0x.'8p0f",
        "0x1.0'p0f",
        "0x1p'0f",
        "0x1p+'0f",
        "0x1p-'0f",
        "0x1p0'f",
        "0x1p0f'1",
        "0x1''0p0f",
        "0x1p0''1f",
        "0x1p0漢f",
    ] {
        rejected(text);
    }
    let source = "/* café 漢 */ __global__ void kernel() { return; float value = 0x1p+f; }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert_eq!(&source[error.span.to_range().unwrap()], "0x1p+f");
}

#[test]
fn cuda_hex_float_literals_survive_supported_macro_substitution() {
    let (module, _) = validate(
        "#define HEX_VALUE 0x1.fp+3f
        #define IDENTITY(value) value
        #define FORWARD(value) IDENTITY(value)
        #define TINY_LITERAL 0x1p-149f
        #define UNUSED_INVALID 0x1p+f
        #if 0
        __device__ float ignored() { return 0x1p+f; }
        #endif
        __device__ float object_macro() { return HEX_VALUE; }
        __device__ float forwarded_value() { return FORWARD(0x1.8p1f); }
        __device__ float forwarded_tiny() { return FORWARD(TINY_LITERAL); }
        __global__ void kernel(float *output) {
            output[0] = object_macro() + forwarded_value();
            output[1] = forwarded_tiny();
        }",
    );
    assert_eq!(returned_bits(&module, "object_macro"), 0x4178_0000);
    assert_eq!(returned_bits(&module, "forwarded_value"), 0x4040_0000);
    assert_eq!(returned_bits(&module, "forwarded_tiny"), 1);
    let (pasted, _) = validate(
        "#define JOIN(left, right) left ## right
        #define WITH_SUFFIX(value) value ## f
        __device__ float pasted_exponent() { return JOIN(0x1.8p, 1f); }
        __device__ float pasted_suffix() { return WITH_SUFFIX(0x1p-149); }
        __global__ void kernel(float *output) {
            output[0] = pasted_exponent(); output[1] = pasted_suffix();
        }",
    );
    assert_eq!(returned_bits(&pasted, "pasted_exponent"), 0x4040_0000);
    assert_eq!(returned_bits(&pasted, "pasted_suffix"), 1);
    for definition in [
        "#define JOIN(left, right) ## left",
        "#define WITH_SUFFIX(value) value ##",
    ] {
        let source = format!("{definition}\n__global__ void kernel() {{}}");
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert_eq!(&source[error.span.to_range().unwrap()], "##");
    }
    for spelling in ["0x1p+f", "0x1p999999f"] {
        let source = format!(
            "#define BAD {spelling}\n__device__ float value() {{ return BAD; }}\n__global__ void kernel() {{}}"
        );
        let error = parse_str(&source, &Options::default()).unwrap_err();
        let start = source.rfind("BAD").unwrap();
        assert_eq!(error.span.to_range(), Some(start..start + 3), "{error}");
    }
    for condition in ["0x1p0f", "0x0p0F", "0x1p0", "1 || 0x1p0f"] {
        let source = format!("#if {condition}\n#endif\n__global__ void kernel() {{}}");
        let error = parse_str(&source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}

#[test]
fn cuda_hex_float_literals_keep_scalar_types_conversions_and_null_origin() {
    let (module, _) = validate(
        "constexpr float Scale = 0x1.8p-1f;
        __device__ float adjust(float value) { return value + 0x1p-1f; }
        __global__ void kernel(float *output, unsigned count) {
            int values[int(0x1p2f)]{3, 5, 7, 11};
            auto value = 0x1.fp+3f + 0x1p-1f;
            value += adjust(Scale);
            bool enabled = 0x.8p0f;
            output[0] = value + float(values[0]) + count;
            output[1] = enabled ? 0x1p0f : -0x0p0f;
        }",
    );
    let function = &module.entry_points[0].function;
    assert!(function.expressions.iter().any(|(_, expression)| {
        matches!(expression, naga::Expression::Literal(naga::Literal::F32(_)))
    }));
    for statement in [
        "unsigned *pointer = 0x0p0f;",
        "consume(0x0p0f);",
        "using Null = decltype(nullptr); Null value = 0x0p0f;",
        "int values[0x1p2f];",
        "__shared__ unsigned values[0x1p2f];",
    ] {
        let source = format!(
            "__device__ void consume(unsigned *value) {{}} __global__ void kernel() {{ {statement} }}"
        );
        let error = parse_str(&source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{error}");
    }
}

#[test]
fn cuda_hex_float_literals_handle_long_significands_and_decimal_exponents() {
    for (text, bits) in [
        (format!("0x{}1p0f", "0'".repeat(1024)), 0x3f80_0000),
        (format!("0x1.{}p0f", "0".repeat(4096)), 0x3f80_0000),
        (format!("0x1.000001{}1p0f", "0".repeat(4096)), 0x3f80_0001),
        (format!("0x1p+{}1f", "0'".repeat(1024)), 0x4000_0000),
        (format!("0x1p-{}9f", "9'".repeat(1024)), 0),
        (format!("0x0p+{}9f", "9'".repeat(1024)), 0),
        (format!("0x1{}p-16384f", "0".repeat(4096)), 0x3f80_0000),
        (format!("0x0.{}1p+16388f", "0".repeat(4096)), 0x3f80_0000),
    ] {
        assert_eq!(literal_bits(&text), bits, "{text}");
    }
    rejected_token(&format!("0x1p+{}9f", "9'".repeat(1024)));
    rejected_token(&format!("0x0p+{}9f32", "9'".repeat(1024)));
}

#[test]
#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
fn cuda_hex_float_literals_preserve_bits_through_shared_wgsl_roundtrip() {
    let (module, info) = validate(
        "__device__ float tiny() { return 0x1p-149f; }
        __device__ float halfway() { return 0x1.000001p0f; }
        __device__ float sticky() { return 0x1.0000010000000000000000000000000000000001p0f; }
        __device__ float negative_zero() { return -0x0p0f; }
        __device__ float largest() { return 0x1.fffffep127f; }
        __global__ void kernel(float *output) {
            output[0] = tiny(); output[1] = halfway(); output[2] = sticky();
            output[3] = negative_zero(); output[4] = largest();
        }",
    );
    let (_, reparsed) =
        super::helpers::wgsl_roundtrip(&module, &info, naga::back::wgsl::WriterFlags::empty());
    for (name, bits) in [
        ("tiny", 1),
        ("halfway", 0x3f80_0000),
        ("sticky", 0x3f80_0001),
        ("negative_zero", 0x8000_0000),
        ("largest", 0x7f7f_ffff),
    ] {
        assert_eq!(returned_bits(&module, name), bits, "{name}");
        assert_eq!(returned_bits(&reparsed, name), bits, "{name}");
    }
}
