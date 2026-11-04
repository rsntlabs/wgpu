use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{source_binding_initializer, validate_with_options_and_capabilities};

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
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

#[test]
fn cuda_integer64_preserves_eight_byte_storage_and_mixed_promotion() {
    let (module, info) = roundtrip(
        "using Signed = long long; using Unsigned = unsigned long long;
        __global__ void kernel(const Signed *input, Unsigned *output, Signed bias) {
            auto sum = input[0] + 0xffffffffu;
            output[0] = Unsigned(sum + bias);
        }",
    );
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 3);
    for (index, scalar, access) in [
        (0, naga::Scalar::I64, naga::StorageAccess::LOAD),
        (
            1,
            naga::Scalar::U64,
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
        ),
    ] {
        assert_eq!(
            globals[index].binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
        assert_eq!(globals[index].space, naga::AddressSpace::Storage { access });
        let naga::TypeInner::Array {
            base,
            size: naga::ArraySize::Dynamic,
            stride,
        } = module.types[globals[index].ty].inner
        else {
            panic!("expected a scalar buffer");
        };
        assert_eq!(stride, 8);
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
    }
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[2].ty].inner else {
        panic!("expected a scalar parameter wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I64)
    );
    let sum = source_binding_initializer(&module.entry_points[0].function, "sum");
    assert_eq!(
        info.get_entry_point(0)[sum].ty.inner_with(&module.types),
        &naga::TypeInner::Scalar(naga::Scalar::I64)
    );
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

fn calls(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut targets = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    targets
}

fn binding_scalar(
    module: &naga::Module,
    info: &naga::valid::ModuleInfo,
    name: &str,
) -> naga::Scalar {
    let value = source_binding_initializer(&module.entry_points[0].function, name);
    info.get_entry_point(0)[value]
        .ty
        .inner_with(&module.types)
        .scalar()
        .unwrap()
}

#[test]
fn cuda_integer64_accepts_long_long_specifier_orders_aliases_and_headers() {
    for (spelling, scalar) in [
        ("long long", naga::Scalar::I64),
        ("long long int", naga::Scalar::I64),
        ("long int long", naga::Scalar::I64),
        ("int long long", naga::Scalar::I64),
        ("signed long long", naga::Scalar::I64),
        ("long signed long", naga::Scalar::I64),
        ("long long signed int", naga::Scalar::I64),
        ("int long signed long", naga::Scalar::I64),
        ("unsigned long long", naga::Scalar::U64),
        ("long unsigned long", naga::Scalar::U64),
        ("long long unsigned", naga::Scalar::U64),
        ("unsigned long int long", naga::Scalar::U64),
        ("int long long unsigned", naga::Scalar::U64),
    ] {
        let source = format!(
            "using Element = {spelling}; typedef {spelling} Alias;
            __device__ {spelling} echo(const Element);
            __global__ void kernel(Alias *output, const Element *input) {{
                {{ using Local = Element; Local value(input[0]); output[0] = echo(value); }}
                {{ Element Alias = input[1]; output[1] = Alias; }}
            }}
            __device__ {spelling} echo(Element value) {{ return value; }}"
        );
        let (module, _) = roundtrip(&source);
        let targets = calls(&module.entry_points[0].function);
        assert_eq!(targets.len(), 1, "{spelling}");
        let function = &module.functions[targets[0]];
        assert_eq!(
            module.types[function.arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
        assert_eq!(
            module.types[function.result.as_ref().unwrap().ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    for header in [
        "long __device__ long",
        "static long inline __device__ long int",
        "__device__ unsigned long long",
    ] {
        roundtrip(&format!("{header} echo(unsigned value) {{ return value; }} __global__ void kernel(long long *output) {{ output[0] = echo(7u); }}"));
    }
    for spelling in [
        "long long long",
        "short long long",
        "unsigned signed long long",
        "long long int int",
        "long long float",
        "long long bool",
    ] {
        rejected(&format!("__global__ void kernel() {{ {spelling} value; }}"));
    }
}

#[test]
fn cuda_integer64_literal_suffixes_preserve_full_values_types_and_spans() {
    for (text, expected) in [
        ("0LL", naga::Literal::I64(0)),
        ("2147483648ll", naga::Literal::I64(2_147_483_648)),
        ("4'294'967'296LL", naga::Literal::I64(4_294_967_296)),
        ("9223372036854775807LL", naga::Literal::I64(i64::MAX)),
        ("9223372036854775808LL", naga::Literal::U64(1u64 << 63)),
        ("18446744073709551615LL", naga::Literal::U64(u64::MAX)),
        ("18446744073709551615ULL", naga::Literal::U64(u64::MAX)),
        ("0xffff'ffff'ffff'ffffll", naga::Literal::U64(u64::MAX)),
        ("0x8000000000000000LL", naga::Literal::U64(1u64 << 63)),
        ("01777777777777777777777ULL", naga::Literal::U64(u64::MAX)),
        (
            "0b100000000000000000000000000000000LL",
            naga::Literal::I64(1i64 << 32),
        ),
    ] {
        let source = format!("/* 漢 */ __global__ void kernel() {{ auto value = {text}; }}");
        let (module, _) = roundtrip(&source);
        let function = &module.entry_points[0].function;
        let found = function
            .expressions
            .iter()
            .find_map(|(handle, expression)| {
                let range = function.expressions.get_span(handle).to_range()?;
                (source.get(range) == Some(text)).then_some(expression)
            })
            .unwrap();
        assert_eq!(*found, naga::Expression::Literal(expected), "{text}");
    }
    for suffix in [
        "LL", "ll", "ULL", "uLL", "LLU", "LLu", "Ull", "ull", "llU", "llu", "lL", "Ll", "UlL",
        "ulL", "lLU", "lLu", "ULl", "uLl", "LlU", "Llu",
    ] {
        roundtrip(&format!(
            "__global__ void kernel() {{ auto value = 7{suffix}; }}"
        ));
    }
    for text in ["1lL", "1Ll"] {
        roundtrip(&format!(
            "/* λ */ __global__ void kernel() {{ auto value = {text}; }}"
        ));
    }
    let (module, info) = roundtrip(
        "__global__ void kernel() {
        auto unsigned_minimum = -9223372036854775808LL;
        auto signed_minimum = -9223372036854775807LL - 1LL;
    }",
    );
    assert_eq!(
        binding_scalar(&module, &info, "unsigned_minimum"),
        naga::Scalar::U64
    );
    assert_eq!(
        binding_scalar(&module, &info, "signed_minimum"),
        naga::Scalar::I64
    );
    for text in ["1LLL", "1uULL", "1LLuu", "18446744073709551616ULL"] {
        let source = format!("/* λ */ __global__ void kernel() {{ auto value = {text}; }}");
        let error = rejected(&source);
        assert_eq!(
            source.get(error.span.to_range().unwrap()),
            Some(text),
            "{error}"
        );
    }
    for text in ["1'LL", "0x'1LL"] {
        rejected(&format!(
            "__global__ void kernel() {{ auto value = {text}; }}"
        ));
    }
}

#[test]
fn cuda_integer64_usual_arithmetic_and_conditionals_keep_wide_operand_types() {
    let types = [
        ("bool", "bool(input[0])", naga::Scalar::BOOL),
        ("short", "short(input[0])", naga::Scalar::I16),
        (
            "unsigned short",
            "(unsigned short)input[0]",
            naga::Scalar::U16,
        ),
        ("int", "int(input[0])", naga::Scalar::I32),
        ("unsigned", "unsigned(input[0])", naga::Scalar::U32),
        ("long long", "input[0]", naga::Scalar::I64),
        (
            "unsigned long long",
            "(unsigned long long)input[0]",
            naga::Scalar::U64,
        ),
        ("float", "float(input[0])", naga::Scalar::F32),
    ];
    for (left_type, left, left_scalar) in types {
        for (right_type, right, right_scalar) in types {
            let common = if [left_scalar, right_scalar].contains(&naga::Scalar::F32) {
                naga::Scalar::F32
            } else if [left_scalar, right_scalar].contains(&naga::Scalar::U64) {
                naga::Scalar::U64
            } else if [left_scalar, right_scalar].contains(&naga::Scalar::I64) {
                naga::Scalar::I64
            } else if [left_scalar, right_scalar].contains(&naga::Scalar::U32) {
                naga::Scalar::U32
            } else {
                naga::Scalar::I32
            };
            let source = format!(
                "__global__ void kernel(const long long *input, int condition) {{
                {left_type} left = {left}; {right_type} right = {right};
                auto sum = left + right; auto compared = left < right;
                auto selected = condition ? +left : +right;
            }}"
            );
            let (module, info) = roundtrip(&source);
            assert_eq!(binding_scalar(&module, &info, "sum"), common, "{source}");
            assert_eq!(
                binding_scalar(&module, &info, "selected"),
                common,
                "{source}"
            );
            assert_eq!(
                binding_scalar(&module, &info, "compared"),
                naga::Scalar::BOOL
            );
            let function = &module.entry_points[0].function;
            for (_, expression) in function.expressions.iter() {
                if let naga::Expression::Binary {
                    op: naga::BinaryOperator::Less,
                    left,
                    right,
                } = *expression
                {
                    for operand in [left, right] {
                        assert_eq!(
                            info.get_entry_point(0)[operand]
                                .ty
                                .inner_with(&module.types),
                            &naga::TypeInner::Scalar(common),
                            "{source}"
                        );
                    }
                }
            }
        }
    }
}

#[test]
fn cuda_integer64_casts_preserve_integer_bits_and_check_float_constant_ranges() {
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        constexpr Signed Minimum = -9223372036854775807LL - 1LL;
        constexpr Signed Negative = Signed(18446744073709551615ULL);
        constexpr Unsigned Maximum = Unsigned(-1LL);
        constexpr unsigned Low = unsigned(0x1234567889abcdefULL);
        constexpr Signed Upper = Signed(9223371487098961920.0f);
        constexpr Signed Lower = Signed(-9223372036854775808.0f);
        constexpr Unsigned UnsignedUpper = Unsigned(18446742974197923840.0f);
        constexpr Unsigned TruncatedZero = Unsigned(-0.75f);
        __global__ void kernel(Signed *output, float input) {
            Signed signed_runtime = static_cast<Signed>(input);
            Unsigned unsigned_runtime = (Unsigned)input;
            output[0] = Minimum; output[1] = Negative; output[2] = Signed(Maximum);
            output[3] = Low; output[4] = Upper; output[5] = Lower;
            output[6] = Signed(UnsignedUpper); output[7] = signed_runtime + Signed(unsigned_runtime) + Signed(TruncatedZero);
        }");
    for (name, expected) in [
        ("Minimum", naga::Literal::I64(i64::MIN)),
        ("Negative", naga::Literal::I64(-1)),
        ("Maximum", naga::Literal::U64(u64::MAX)),
        ("Low", naga::Literal::U32(0x89abcdef)),
        ("Upper", naga::Literal::I64(9_223_371_487_098_961_920)),
        ("Lower", naga::Literal::I64(i64::MIN)),
        (
            "UnsignedUpper",
            naga::Literal::U64(18_446_742_974_197_923_840),
        ),
        ("TruncatedZero", naga::Literal::U64(0)),
    ] {
        let constant = module
            .constants
            .iter()
            .find_map(|(_, value)| (value.name.as_deref() == Some(name)).then_some(value))
            .unwrap();
        assert_eq!(
            module.global_expressions[constant.init],
            naga::Expression::Literal(expected),
            "{name}"
        );
    }
    for target in ["Signed", "Unsigned"] {
        for value in ["18446744073709551616.0f", "(0.0f / 0.0f)", "(1.0f / 0.0f)"] {
            rejected(&format!("using Signed = long long; using Unsigned = unsigned long long; constexpr {target} Value = {target}({value}); __global__ void kernel() {{}}"));
        }
    }
    for (target, value) in [
        ("Signed", "9223372036854775808.0f"),
        ("Signed", "-18446744073709551616.0f"),
        ("Unsigned", "-1.0f"),
    ] {
        rejected(&format!("using Signed = long long; using Unsigned = unsigned long long; constexpr {target} Value = {target}({value}); __global__ void kernel() {{}}"));
    }
    for target in [
        "bool",
        "short",
        "unsigned short",
        "int",
        "unsigned",
        "long long",
        "unsigned long long",
        "float",
    ] {
        for source_type in [
            "bool",
            "short",
            "unsigned short",
            "int",
            "unsigned",
            "long long",
            "unsigned long long",
            "float",
        ] {
            roundtrip(&format!("using Target = {target}; using Source = {source_type};
                __device__ Target convert(Source value) {{ return value; }}
                __global__ void kernel(const float *input, unsigned *output) {{ Source source = Source(input[0]); Target value = source; value = (Target)source; value = static_cast<Target>(source); output[0] = unsigned(convert(source)); output[1] = unsigned(value); }}"));
        }
    }
}

#[test]
fn cuda_integer64_braces_use_exact_ranges_and_float_representability() {
    roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        __global__ void kernel(const unsigned *input, const short *halves, Signed *output) {
            Signed widened{input[0]}; Signed half{halves[0]}; Unsigned positive{7LL};
            Signed signed_constant{9223372036854775807ULL}; Unsigned maximum{18446744073709551615ULL};
            float exact_signed{4611686018427387904LL}; float exact_unsigned{18446742974197923840ULL};
            output[0] = widened + half + Signed(positive) + signed_constant;
            output[1] = Signed(maximum) + Signed(exact_signed) + Signed(exact_unsigned);
        }");
    for declaration in [
        "Signed value{unsigned_input[0]};",
        "Unsigned value{signed_input[0]};",
        "Signed value{18446744073709551615ULL};",
        "Unsigned value{-1LL};",
        "int value{signed_input[0]};",
        "unsigned value{unsigned_input[0]};",
        "float value{signed_input[0]};",
        "float value{unsigned_input[0]};",
        "float value{9223372036854775807LL};",
        "float value{18446744073709551615ULL};",
        "float value{16777217LL};",
        "Signed value{1.0f};",
        "bool value{2LL};",
    ] {
        rejected(&format!("using Signed = long long; using Unsigned = unsigned long long; __global__ void kernel(const Signed *signed_input, const Unsigned *unsigned_input) {{ {declaration} }}"));
    }
}

#[test]
fn cuda_integer64_unary_shifts_updates_and_compound_results_keep_source_types() {
    let (module, info) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        __global__ void kernel(Signed *output, Unsigned input, int condition) {
            Signed value = output[0]; Signed &prefix = ++value; auto previous = value++;
            auto positive = +input; auto negative = -input; auto complement = ~value;
            auto shifted_signed = value << 32ULL; auto shifted_unsigned = input >> 63LL;
            auto selected = condition ? value : prefix;
            auto comma = (value += 1ULL, value); Signed &assigned = (value *= 2u);
            bool present = input; output[0] = prefix; output[1] = previous;
            output[2] = Signed(positive + negative); output[3] = complement;
            output[4] = shifted_signed + Signed(shifted_unsigned); output[5] = selected + comma + assigned + int(present);
        }");
    for (name, scalar) in [
        ("previous", naga::Scalar::I64),
        ("negative", naga::Scalar::U64),
        ("complement", naga::Scalar::I64),
        ("shifted_signed", naga::Scalar::I64),
        ("shifted_unsigned", naga::Scalar::U64),
        ("selected", naga::Scalar::I64),
        ("comma", naga::Scalar::I64),
    ] {
        assert_eq!(binding_scalar(&module, &info, name), scalar, "{name}");
    }
    let function = &module.entry_points[0].function;
    let negative = source_binding_initializer(function, "negative");
    let naga::Expression::Binary {
        op: naga::BinaryOperator::Subtract,
        right: input,
        ..
    } = function.expressions[negative]
    else {
        panic!("unsigned negation must subtract the input from zero");
    };
    assert_eq!(
        info.get_entry_point(0)[input].ty.inner_with(&module.types),
        &naga::TypeInner::Scalar(naga::Scalar::U64)
    );
    assert!(
        function
            .expressions
            .iter()
            .any(|(_, expression)| matches!(*expression,
                naga::Expression::Binary { op: naga::BinaryOperator::Add, left, right }
                if left == input && right == negative
            )),
        "unary plus must preserve the input used by the unsigned addition"
    );
    for target in ["long long", "unsigned long long", "int", "unsigned short"] {
        for operator in ["+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>="] {
            roundtrip(&format!("using Target = {target}; __global__ void kernel(Target *output, unsigned long long right) {{ Target value = output[0]; Target &result = (value {operator} right); output[0] = result; }}"));
        }
    }
    rejected("__global__ void kernel() { const long long value = 1LL; value += 2LL; }");
    rejected("using Wide = long long; __global__ void kernel() { Wide &value = Wide(1)++; }");
}

#[test]
fn cuda_integer64_constants_reach_lazy_branches_bounds_cases_and_hints() {
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        constexpr Unsigned Maximum = 18446744073709551615ULL;
        constexpr Unsigned Wrapped = Maximum + 1ULL;
        constexpr Signed Shifted = 1LL << 63;
        constexpr Signed Count = (1LL << 32) >> 30;
        __global__ __launch_bounds__(Count) void kernel(long long *output, int selector) {
            const Signed Local = Count; const auto inferred = 3ULL;
            Signed values[Local]{}; Signed other[inferred]{};
            constexpr auto selected = true ? Count : Signed(1LL / 0LL);
            constexpr bool flag = true || (1ULL / 0ULL);
            constexpr Signed comma = (values[1LL], 2LL);
            #pragma unroll Count
            for (Signed index = 0; index < Count; ++index) values[index] = index;
            switch (selector) { case -1LL: other[0] = 7; break; case 2ULL: other[1] = 9; break; default: break; }
            output[0] = values[selected - 1LL] + other[comma] + Signed(flag) + Signed(Wrapped) + Shifted;
        }");
    let function = &module.entry_points[0].function;
    for (name, expected) in [("values", 4), ("other", 3)] {
        let local = function
            .local_variables
            .iter()
            .find_map(|(_, value)| (value.name.as_deref() == Some(name)).then_some(value))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[local.ty].inner
        else {
            panic!("fixed array");
        };
        assert_eq!((count.get(), stride), (expected, 8));
    }
    roundtrip(
        "__global__ void kernel() {
        int values[2]{};
        constexpr int Count = (values[unsigned(4294967297ULL)], 3);
        int other[Count];
    }",
    );
    for index in ["4294967297ULL", "-4294967295LL"] {
        rejected(&format!("__global__ void kernel() {{ int values[2]{{}}; constexpr int Count = (values[{index}], 3); int other[Count]; }}"));
    }
    roundtrip(
        "__global__ void kernel() {
        int values[2]{};
        constexpr int Count = ((values)[unsigned(4294967297ULL)], 3);
        int other[Count];
    }",
    );
    for index in ["4294967297ULL", "-4294967295LL"] {
        rejected(&format!("__global__ void kernel() {{ int values[2]{{}}; constexpr int Count = ((values)[{index}], 3); int other[Count]; }}"));
    }
    for expression in [
        "9223372036854775807LL + 1LL",
        "(-9223372036854775807LL - 1LL) - 1LL",
        "9223372036854775807LL * 2LL",
        "-(-9223372036854775807LL - 1LL)",
        "(-9223372036854775807LL - 1LL) / -1LL",
        "(-9223372036854775807LL - 1LL) % -1LL",
        "1LL / 0LL",
        "1ULL % 0ULL",
        "1LL << -1LL",
        "1ULL >> 64LL",
        "1LL << 4294967296ULL",
    ] {
        rejected(&format!(
            "constexpr long long Value = {expression}; __global__ void kernel() {{}}"
        ));
    }
    for bound in ["0LL", "-1LL", "4294967299ULL", "runtime", "1.0f"] {
        rejected(&format!(
            "__global__ void kernel(long long runtime) {{ long long values[{bound}]; }}"
        ));
    }
    for arguments in ["4294967360LL", "4294967360ULL"] {
        rejected(&format!(
            "__global__ __launch_bounds__({arguments}) void kernel() {{}}"
        ));
    }
    for body in [
        "switch (signed_value) { default: break; }",
        "switch (unsigned_value) { case 0ULL: break; }",
        "switch (int(signed_value)) { case 4294967296ULL: break; }",
        "switch (unsigned(signed_value)) { case -1LL: break; }",
        "constexpr long long Count = (signed_value++, 3LL); long long values[Count];",
    ] {
        rejected(&format!("__global__ void kernel(long long signed_value, unsigned long long unsigned_value) {{ {body} }}"));
    }
}

#[test]
fn cuda_integer64_overloads_and_prototypes_preserve_exact_scalar_identity() {
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        __device__ int exact(Signed value); __device__ int exact(Unsigned value);
        __device__ int promoted(int value) { return value; }
        __device__ int promoted(Signed value) { return int(value); }
        __device__ int promoted(Unsigned value) { return int(value); }
        __global__ void kernel(const Signed *signed_input, const Unsigned *unsigned_input, int *output) {
            short half = 1; unsigned short unsigned_half = 2;
            output[0] = exact(signed_input[0]); output[1] = exact(unsigned_input[0]);
            output[2] = promoted(half); output[3] = promoted(unsigned_half);
            output[4] = exact(7LL); output[5] = exact(7ULL);
        }
        __device__ int exact(long long value) { return int(value); }
        __device__ int exact(unsigned long long value) { return int(value); }");
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 6);
    for (target, scalar) in targets.into_iter().zip([
        naga::Scalar::I64,
        naga::Scalar::U64,
        naga::Scalar::I32,
        naga::Scalar::I32,
        naga::Scalar::I64,
        naga::Scalar::U64,
    ]) {
        assert_eq!(
            module.types[module.functions[target].arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    let (module, info) = roundtrip("__global__ void kernel(const long long *signed_input, const unsigned long long *unsigned_input) {
        auto minimum_signed = min(signed_input[0], signed_input[1]);
        auto maximum_signed = max(signed_input[0], signed_input[1]);
        auto minimum_unsigned = min(unsigned_input[0], unsigned_input[1]);
        auto maximum_unsigned = max(unsigned_input[0], unsigned_input[1]);
        auto minimum_signed_first = min(signed_input[0], unsigned_input[0]);
        auto maximum_signed_first = max(signed_input[0], unsigned_input[0]);
        auto minimum_unsigned_first = min(unsigned_input[0], signed_input[0]);
        auto maximum_unsigned_first = max(unsigned_input[0], signed_input[0]);
    }");
    for name in ["minimum_signed", "maximum_signed"] {
        assert_eq!(
            binding_scalar(&module, &info, name),
            naga::Scalar::I64,
            "{name}"
        );
    }
    for name in [
        "minimum_unsigned",
        "maximum_unsigned",
        "minimum_signed_first",
        "maximum_signed_first",
        "minimum_unsigned_first",
        "maximum_unsigned_first",
    ] {
        assert_eq!(
            binding_scalar(&module, &info, name),
            naga::Scalar::U64,
            "{name}"
        );
    }
    rejected("__global__ void kernel(unsigned long long *output) { output[0] = min(1ULL, 1u); }");
    rejected("__global__ void kernel(long long *output) { output[0] = max(1LL, 1); }");
    rejected("__device__ int choose(long long value) { return 1; } __device__ int choose(unsigned long long value) { return 2; } __global__ void kernel(unsigned value, int *output) { output[0] = choose(value); }");
    rejected("__device__ long long echo(unsigned); __device__ unsigned long long echo(unsigned); __global__ void kernel() {}");
    rejected("__device__ long long echo(long long); __device__ const long long echo(long long); __global__ void kernel() {}");
}

#[test]
fn cuda_integer64_templates_preserve_wide_values_deduction_and_instance_keys() {
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        __device__ int choose(Signed value) { return 3; }
        __device__ int choose(Unsigned value) { return 5; }
        __device__ int choose(int value) { return 7; }
        template<Signed Value> __device__ int signed_value() { return choose(Value); }
        template<Unsigned Value> __device__ int unsigned_value() { return choose(Value); }
        template<class Value> __device__ Value identity(Value value) { return value; }
        __global__ void kernel(Signed *output) {
            output[0] = signed_value<-1LL>(); output[1] = signed_value<Signed(18446744073709551615ULL)>();
            output[2] = unsigned_value<18446744073709551615ULL>(); output[3] = unsigned_value<Unsigned(-1LL)>();
            output[4] = identity<Signed>(7LL); output[5] = identity<long long>(8LL);
            output[6] = identity(9ULL); output[7] = identity(10LL);
        }");
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 8);
    assert_eq!(targets[0], targets[1]);
    assert_eq!(targets[2], targets[3]);
    assert_eq!(targets[4], targets[5]);
    assert_eq!(targets[4], targets[7]);
    assert_ne!(targets[4], targets[6]);
    for (target, scalar) in [
        (targets[0], naga::Scalar::I64),
        (targets[2], naga::Scalar::U64),
    ] {
        let nested = calls(&module.functions[target]);
        assert_eq!(nested.len(), 1);
        assert_eq!(
            module.types[module.functions[nested[0]].arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        template<class Value> __global__ void copy(Value *output, const Value *input) { output[0] = input[0]; }
        template __global__ void copy<Signed>(Signed *, const Signed *);
        template __global__ void copy<Unsigned>(Unsigned *, const Unsigned *);");
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["copy<long long>", "copy<unsigned long long>"]
    );
    for (target, value) in [
        ("long long", "18446744073709551615ULL"),
        ("unsigned long long", "-1LL"),
        ("long long", "1.0f"),
    ] {
        rejected(&format!("using Target = {target}; template<Target Value> __device__ int selected() {{ return 1; }} __global__ void kernel(int *output) {{ output[0] = selected<{value}>(); }}"));
    }
}

#[test]
fn cuda_integer64_records_and_array_aliases_keep_eight_byte_alignment() {
    let (module, _) = roundtrip(
        "using Signed = long long; using Unsigned = unsigned long long;
        struct Record { short tag; Signed signed_value; Unsigned unsigned_value; int tail; };
        using Row = Signed[3]; using Values = Signed[];
        __device__ Signed read(Values *view) { return (*view)[1LL]; }
        __global__ void kernel(const Record *input, Record *output, Signed *observations) {
            Record copied(input[0]); output[0] = copied;
            Row first{1LL, 2LL, 3LL}; Row second(4LL, 5LL);
            Values *view = &first; observations[0] = read(view);
            view = &second; observations[1] = (*view)[0ULL];
        }",
    );
    let record = module
        .types
        .iter()
        .find_map(|(handle, ty)| {
            ty.name
                .as_deref()
                .is_some_and(|name| name.starts_with("Record_cuda_record_"))
                .then_some(handle)
        })
        .unwrap();
    let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
        panic!("record");
    };
    assert_eq!(span, 32);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 8, 16, 24]
    );
    let mut layouter = naga::proc::Layouter::default();
    layouter.update(module.to_ctx()).unwrap();
    assert_eq!(layouter[record].size, 32);
    assert_eq!(layouter[record].alignment, naga::proc::Alignment::EIGHT);
    for (_, global) in module
        .global_variables
        .iter()
        .filter(|(_, global)| global.binding.is_some_and(|binding| binding.binding < 2))
    {
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("record buffer");
        };
        assert_eq!((base, stride), (record, 32));
    }
    for name in ["first", "second"] {
        let local = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find_map(|(_, value)| (value.name.as_deref() == Some(name)).then_some(value))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[local.ty].inner
        else {
            panic!("row");
        };
        assert_eq!((count.get(), stride), (3, 8));
    }
}

#[test]
fn cuda_integer64_references_constant_shared_and_volatile_storage_keep_source_rules() {
    let (module, _) = roundtrip("using Signed = long long; using Unsigned = unsigned long long;
        __constant__ Signed Coefficients[3]; extern __constant__ const Unsigned Frozen[2];
        __device__ Signed read(Signed *values, Signed index) { return values[index]; }
        __device__ Signed observe(const Signed &value) { return value; }
        __device__ void increment(Signed &value) { value += 1LL; }
        __device__ Signed exchange(Signed value) { __shared__ Signed slot[1]; slot[0] = value; return slot[0]; }
        __global__ void kernel(Signed *output) {
            Signed *target = output; Signed &reference = target[0]; increment(reference);
            const Signed *input = target + 1LL; output[1] = observe(*input);
            output[2] = read(Coefficients, 1LL) + Signed(Frozen[0]); output[3] = exchange(output[0]);
        }");
    let constants: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| {
            global
                .binding
                .filter(|binding| binding.group == 1)
                .map(|binding| (binding, global))
        })
        .collect();
    assert_eq!(constants.len(), 2);
    for (index, &(binding, global)) in constants.iter().enumerate() {
        assert_eq!(binding.binding, index as u32);
        assert_eq!(
            global.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD
            }
        );
        let naga::TypeInner::Array { stride, .. } = module.types[global.ty].inner else {
            panic!("constant array");
        };
        assert_eq!(stride, 8);
    }
    for body in [
        "Values[0] = 1LL;",
        "long long *pointer = Values; *pointer = 1LL;",
        "long long &value = Values[0]; value += 1LL;",
        "long long *pointer = condition ? Values : output; pointer[0] = 1LL;",
    ] {
        rejected(&format!("__constant__ long long Values[2]; __global__ void kernel(long long *output, int condition) {{ {body} }}"));
    }
    rejected("__global__ void kernel(const long long *input) { long long &value = input[0]; }");
    let capabilities = Capabilities::SHADER_INT64
        | Capabilities::MEMORY_DECORATION_VOLATILE
        | Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP;
    let options = Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 32,
    };
    let source = "__global__ void kernel(volatile long long *output, const volatile unsigned long long *input) {
        __shared__ volatile long long fixed[4]; extern __shared__ volatile unsigned long long dynamic[];
        unsigned index = threadIdx.x; fixed[index] = (long long)input[index]; dynamic[index] = input[index];
        __syncthreads(); output[index] = fixed[index] + (long long)dynamic[index];
    }";
    let (module, info) = validate_with_options_and_capabilities(source, &options, capabilities);
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| (global.space == naga::AddressSpace::WorkGroup).then_some(global))
        .collect();
    assert_eq!(shared.len(), 2);
    for global in shared {
        assert!(global
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[global.ty].inner
        else {
            panic!("shared array");
        };
        assert_eq!((count.get(), stride), (4, 8));
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
}

#[test]
fn cuda_integer64_capabilities_null_literals_and_unsupported_boundaries_remain_explicit() {
    let source = "__global__ void kernel(long long *output, const unsigned long long *input) { output[0] = (long long)input[0]; }";
    let module = parse_str(source, &Options::default()).unwrap();
    let error =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), Capabilities::empty())
            .validate(&module)
            .unwrap_err();
    assert!(format!("{error:?}").contains("SHADER_INT64"), "{error:?}");
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT64,
    );
    let _ = (module, info);
    roundtrip(
        "#define ZERO 0LL\n__global__ void kernel(long long *output) {
        long long *first = 0LL; long long *second = 0ULL; long long *third = ZERO;
        output[0] = first == 0ULL; output[1] = 0LL != second; output[2] = third ? 3LL : 5LL;
    }",
    );
    for value in ["Wide(0)", "(Wide)0", "Zero"] {
        rejected(&format!("using Wide = long long; constexpr Wide Zero = 0LL; __global__ void kernel() {{ Wide *pointer = {value}; }}"));
    }
    for source in [
        "__global__ void kernel(long *output) {}", "__global__ void kernel(unsigned long *output) {}",
        "__global__ void kernel() { auto value = 1L; }", "__global__ void kernel() { auto value = 1UL; }",
        "__global__ void kernel() { auto value = 2147483648; }", "__global__ void kernel() { auto value = 4294967296u; }",
        "__global__ void kernel(longlong2 *output) {}", "__global__ void kernel(ulonglong2 *output) {}",
        "__global__ void kernel(long long *output) { atomicAdd(output, 1LL); }",
        "__global__ void kernel(unsigned long long *output) { atomicCAS(output, 0ULL, 1ULL); }",
        "__global__ void kernel() { sizeof(long long); }", "__global__ void kernel() { alignof(long long); }",
        "__device__ long long missing(long long); __global__ void kernel(long long *output) { output[0] = missing(1LL); }",
        "__device__ long long recurse(long long value) { return recurse(value); } __global__ void kernel(long long *output) { output[0] = recurse(1LL); }",
    ] {
        rejected(source);
    }
    let deep = format!(
        "__global__ void kernel(long long value) {{ auto result = {}value{}; }}",
        "(".repeat(65),
        ")".repeat(65)
    );
    rejected(&deep);
}

#[test]
fn cuda_integer64_array_indices_lower_to_u32_after_source_bounds_checks() {
    let source = "using Index = unsigned long long;
        struct Packet { long long values[3]; };
        __global__ void kernel(long long *output, Index index) {
            long long values[3]{2LL, 3LL, 5LL};
            long long rows[2][3]{{7LL, 11LL, 13LL}, {17LL, 19LL, 23LL}};
            Packet packet{{29LL, 31LL, 37LL}};
            auto wide = index + 4294967296ULL;
            output[0] = (long long)wide;
            output[1] = values[index];
            output[2] = values[1LL];
            output[3] = values[1ULL];
            output[4] = (values)[index];
            output[5] = rows[index & 1ULL][1LL];
            output[6] = packet.values[index];
        }";
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
    assert_eq!(binding_scalar(&module, &info, "wide"), naga::Scalar::U64);
    let function = &module.entry_points[0].function;
    let mut indices = 0;
    for (_, expression) in function.expressions.iter() {
        if let naga::Expression::Access { index, .. } = *expression {
            let scalar = info.get_entry_point(0)[index]
                .ty
                .inner_with(&module.types)
                .scalar()
                .unwrap();
            assert_eq!(scalar.width, 4, "array access retains a wide index");
            indices += 1;
        }
    }
    assert!(indices >= 7);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT64,
    );
}
