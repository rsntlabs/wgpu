use naga::front::cuda::Options;
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

#[test]
fn cuda_long_types_keep_lp64_long_and_long_long_overloads_distinct() {
    let source = "using Long = long; using ULong = unsigned long;
        __device__ unsigned kind(int value) { return 1u; }
        __device__ unsigned kind(unsigned value) { return 2u; }
        __device__ unsigned kind(Long value) { return 3u; }
        __device__ unsigned kind(ULong value) { return 4u; }
        __device__ unsigned kind(long long value) { return 5u; }
        __device__ unsigned kind(unsigned long long value) { return 6u; }
        __global__ void kernel(const ULong *input, unsigned *output, Long bias) {
            output[0] = kind(1);
            output[1] = kind(2u);
            output[2] = kind(bias);
            output[3] = kind(input[0]);
            output[4] = kind(3LL);
            output[5] = kind(4ULL);
        }";
    let capabilities = Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );

    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 3);
    assert_eq!(
        globals[0].space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Dynamic,
        stride,
    } = module.types[globals[0].ty].inner
    else {
        panic!("expected the unsigned long input buffer");
    };
    assert_eq!(stride, 8);
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::U64)
    );
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[2].ty].inner else {
        panic!("expected the long parameter wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I64)
    );

    let mut targets = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    assert_eq!(targets.len(), 6);
    for (index, scalar) in [
        naga::Scalar::I32,
        naga::Scalar::U32,
        naga::Scalar::I64,
        naga::Scalar::U64,
        naga::Scalar::I64,
        naga::Scalar::U64,
    ]
    .into_iter()
    .enumerate()
    {
        let target = targets[index];
        assert!(targets[..index].iter().all(|previous| *previous != target));
        let function = &module.functions[target];
        assert_eq!(function.arguments.len(), 1);
        assert_eq!(
            module.types[function.arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
        let mut returned = None;
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Return { value: Some(value) } = *statement {
                assert!(returned.replace(value).is_none());
            }
            false
        });
        assert_eq!(
            function.expressions[returned.expect("expected a tag return")],
            naga::Expression::Literal(naga::Literal::U32(index as u32 + 1))
        );
    }
}

const KINDS: &str = "
    __device__ unsigned kind(int value) { return 1u; }
    __device__ unsigned kind(unsigned value) { return 2u; }
    __device__ unsigned kind(long value) { return 3u; }
    __device__ unsigned kind(unsigned long value) { return 4u; }
    __device__ unsigned kind(long long value) { return 5u; }
    __device__ unsigned kind(unsigned long long value) { return 6u; }
    __device__ unsigned kind(float value) { return 7u; }
    __device__ unsigned kind(bool value) { return 8u; }
    __device__ unsigned kind(short value) { return 9u; }
    __device__ unsigned kind(unsigned short value) { return 10u; }";

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    roundtrip_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    )
}

fn roundtrip_with_options_and_capabilities(
    source: &str,
    options: &Options,
    capabilities: Capabilities,
) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options_and_capabilities(source, options, capabilities);
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
    let error = naga::front::cuda::parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

fn call_targets(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut targets = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    targets
}

fn assert_tag_calls(module: &naga::Module, expected: &[u32]) {
    let targets: Vec<_> = call_targets(&module.entry_points[0].function)
        .into_iter()
        .filter(|&target| module.functions[target].name.as_deref() == Some("kind"))
        .collect();
    assert_eq!(targets.len(), expected.len());
    for (target, expected) in targets.into_iter().zip(expected) {
        let function = &module.functions[target];
        let mut returned = None;
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Return { value: Some(value) } = *statement {
                assert!(returned.replace(value).is_none());
            }
            false
        });
        assert_eq!(
            function.expressions[returned.expect("expected a tag return")],
            naga::Expression::Literal(naga::Literal::U32(*expected))
        );
    }
}

#[test]
fn cuda_long_types_accept_specifier_orders_aliases_and_qualified_headers() {
    for (spelling, scalar) in [
        ("long", naga::Scalar::I64),
        ("long int", naga::Scalar::I64),
        ("int long", naga::Scalar::I64),
        ("signed long", naga::Scalar::I64),
        ("long signed", naga::Scalar::I64),
        ("signed long int", naga::Scalar::I64),
        ("signed int long", naga::Scalar::I64),
        ("long signed int", naga::Scalar::I64),
        ("long int signed", naga::Scalar::I64),
        ("int signed long", naga::Scalar::I64),
        ("int long signed", naga::Scalar::I64),
        ("unsigned long", naga::Scalar::U64),
        ("long unsigned", naga::Scalar::U64),
        ("unsigned long int", naga::Scalar::U64),
        ("unsigned int long", naga::Scalar::U64),
        ("long unsigned int", naga::Scalar::U64),
        ("long int unsigned", naga::Scalar::U64),
        ("int unsigned long", naga::Scalar::U64),
        ("int long unsigned", naga::Scalar::U64),
    ] {
        let (module, _) = roundtrip(&format!(
            "using Element = {spelling}; typedef Element Alias;
            __device__ Alias echo(const Element value);
            __global__ void kernel(const Alias *input, Element *output) {{
                {{ using Local = Alias; const Local value(input[0]); output[0] = echo(value); }}
            }}
            __device__ Element echo(Element value) {{ return value; }}"
        ));
        let targets = call_targets(&module.entry_points[0].function);
        assert_eq!(targets.len(), 1);
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
}

#[test]
fn cuda_long_types_preserve_size_t_aliases_redeclarations_shadowing_and_macros() {
    for include in ["", "#include <cstddef>\n"] {
        let (module, _) = roundtrip(&format!(
            "{include}{KINDS}
            namespace standard = std;
            typedef unsigned long size_t; using size_t = unsigned long;
            __global__ void kernel(unsigned *output) {{
                output[0] = kind(size_t(1)); output[1] = kind(::size_t(2));
                output[2] = kind(std::size_t(3));
                {{ unsigned size_t = 4u; output[3] = kind(size_t); }}
                {{ using size_t = long long; output[4] = kind(size_t(5)); }}
                output[5] = kind(size_t(6));
                output[6] = kind(standard::size_t(7));
            }}"
        ));
        assert_tag_calls(&module, &[4, 4, 4, 2, 5, 4, 4]);
    }
    let (module, _) = roundtrip(&format!(
        "#define size_t unsigned long long\n{KINDS}
        __global__ void kernel(unsigned *output) {{ size_t value=1ULL; output[0] = kind(value); }}"
    ));
    assert_tag_calls(&module, &[6]);
    rejected("using size_t = long long; __global__ void kernel() {}");
    rejected("__global__ void kernel() { std::unsupported_name value; }");
}

#[test]
fn cuda_long_types_keep_long_suffix_and_unsuffixed_candidate_identity() {
    let literals = [
        ("1", 1),
        ("1u", 2),
        ("1L", 3),
        ("1l", 3),
        ("1ul", 4),
        ("1uL", 4),
        ("1Ul", 4),
        ("1UL", 4),
        ("1lu", 4),
        ("1lU", 4),
        ("1Lu", 4),
        ("1LU", 4),
        ("2147483648", 3),
        ("4294967296u", 4),
        ("0x80000000", 2),
        ("0xffffffff", 2),
        ("0x100000000", 3),
        ("0xffffffffffffffff", 4),
        ("01777777777777777777777", 4),
        ("0b100000000000000000000000000000000", 3),
        ("9223372036854775807L", 3),
        ("18446744073709551615UL", 4),
        ("9223372036854775808", 6),
        ("18446744073709551615", 6),
        ("9223372036854775808L", 6),
        ("18446744073709551615L", 6),
        ("0x8000000000000000L", 4),
        ("0xffffffffffffffffL", 4),
        ("1LL", 5),
        ("1ULL", 6),
        ("1lL", 5),
    ];
    for (literal, tag) in literals {
        let (module, _) = roundtrip(&format!(
            "{KINDS} __global__ void kernel(unsigned *output) {{ output[0] = kind({literal}); }}"
        ));
        assert_tag_calls(&module, &[tag]);
    }
    let (module, _) = roundtrip(&format!(
        "{KINDS} __global__ void kernel(unsigned *output) {{
        output[0] = kind(-2147483648); output[1] = kind(-9223372036854775807L - 1L);
        output[2] = kind(0x1'0000'0000L); output[3] = kind(0xffff'ffff'ffff'ffffUL);
        output[4] = kind(-9223372036854775808L); output[5] = kind(-9223372036854775808);
    }}"
    ));
    assert_tag_calls(&module, &[3, 3, 3, 4, 6, 6]);
    for literal in ["18446744073709551616UL", "1LLL", "1uul", "1LUL", "1z"] {
        rejected(&format!(
            "__global__ void kernel() {{ auto value = {literal}; }}"
        ));
    }
}

#[test]
fn cuda_long_types_apply_rank_and_representability_before_physical_width() {
    let cases = [
        ("long", "unsigned", 3),
        ("unsigned", "long", 3),
        ("long", "unsigned long", 4),
        ("unsigned long", "long", 4),
        ("long", "long long", 5),
        ("long long", "long", 5),
        ("long long", "unsigned long", 6),
        ("unsigned long", "long long", 6),
        ("unsigned long", "unsigned long long", 6),
        ("unsigned long long", "long", 6),
        ("short", "long", 3),
        ("unsigned short", "long", 3),
        ("bool", "unsigned long", 4),
        ("int", "unsigned long", 4),
        ("float", "long", 7),
        ("unsigned long", "float", 7),
    ];
    for (left, right, tag) in cases {
        let (module, _) = roundtrip(&format!("{KINDS}
            __global__ void kernel(unsigned *output, int condition) {{
                using Left = {left}; using Right = {right}; Left left = Left(2); Right right = Right(1);
                output[0] = kind(left + right); output[1] = kind(left - right);
                output[2] = kind(left * right); output[3] = kind(left / right);
                output[4] = kind(condition ? left : right);
                output[5] = kind(left < right); output[6] = kind(left == right);
            }}"));
        assert_tag_calls(&module, &[tag, tag, tag, tag, tag, 8, 8]);
    }
    let (module, _) = roundtrip(&format!(
        "{KINDS} __global__ void kernel(unsigned *output) {{
        long left = 7L; unsigned long right = 3UL;
        output[0] = kind(left % right); output[1] = kind(left & right);
        output[2] = kind(left | right); output[3] = kind(left ^ right);
        output[4] = kind(left << right); output[5] = kind(right >> left);
    }}"
    ));
    assert_tag_calls(&module, &[4, 4, 4, 4, 3, 4]);
}

#[test]
fn cuda_long_types_casts_and_list_initialization_preserve_target_identity() {
    for (target, tag) in [
        ("int", 1),
        ("unsigned", 2),
        ("long", 3),
        ("unsigned long", 4),
        ("long long", 5),
        ("unsigned long long", 6),
        ("float", 7),
        ("bool", 8),
        ("short", 9),
        ("unsigned short", 10),
    ] {
        let (module, _) = roundtrip(&format!("{KINDS} using Target = {target};
            __global__ void kernel(const long *input, const unsigned long *other, unsigned *output) {{
                Target copied = input[0];
                output[0] = kind(copied); output[1] = kind(Target(other[0]));
                output[2] = kind(static_cast<Target>(input[0])); output[3] = kind((Target)other[0]);
            }}"));
        assert_tag_calls(&module, &[tag, tag, tag, tag]);
    }
    let (module, _) = roundtrip(&format!(
        "{KINDS} __global__ void kernel(const long *input, unsigned *output) {{
        long long same_range{{input[0]}}; long copied{{same_range}};
        constexpr long exact = 16777216L; float converted{{exact}};
        constexpr unsigned long maximum = 18446744073709551615UL;
        unsigned long long unsigned_copy{{maximum}};
        output[0] = kind(same_range); output[1] = kind(copied);
        output[2] = kind(converted); output[3] = kind(unsigned_copy);
    }}"
    ));
    assert_tag_calls(&module, &[5, 3, 7, 6]);
    for declaration in [
        "unsigned long value{input[0]};",
        "long value{other[0]};",
        "int value{input[0]};",
        "float value{input[0]};",
        "float value{16777217L};",
        "long value{9223372036854775808.0f};",
        "unsigned long value{-1.0f};",
    ] {
        rejected(&format!("__global__ void kernel(const long *input, const unsigned long *other) {{ {declaration} }}"));
    }
}

#[test]
fn cuda_long_types_updates_compound_assignments_and_unary_keep_source_kind() {
    for (target, tag, value) in [("long", 3, "7L"), ("unsigned long", 4, "7UL")] {
        let (module, _) = roundtrip(&format!(
            "{KINDS} using Value = {target};
            __global__ void kernel(unsigned *output) {{
                Value value = {value};
                output[0] = kind(+value); output[1] = kind(-value); output[2] = kind(~value);
                output[3] = kind(value++); output[4] = kind(++value);
                output[5] = kind(value--); output[6] = kind(--value);
                output[7] = kind(value += 1); output[8] = kind(value -= 1u);
                output[9] = kind(value *= 3LL); output[10] = kind(value /= 2ULL);
                output[11] = kind(value %= 5L); output[12] = kind(value &= 15UL);
                output[13] = kind(value |= 16u); output[14] = kind(value ^= 3);
                output[15] = kind(value <<= 1u); output[16] = kind(value >>= 1LL);
            }}"
        ));
        assert_tag_calls(&module, &[tag; 17]);
    }
    for body in ["value++;", "++value;", "value += 1L;", "value = 2L;"] {
        rejected(&format!(
            "__global__ void kernel() {{ const long value = 1L; {body} }}"
        ));
    }
}

#[test]
fn cuda_long_types_constant_metadata_survives_ice_consumers_without_wrapping() {
    let (module, _) = roundtrip(&format!(
        "{KINDS}
        constexpr long Count = (1L << 32u) >> 30u;
        constexpr unsigned long Maximum = 18446744073709551615UL;
        constexpr auto Wrapped = Maximum + 1UL;
        constexpr auto Inferred = 7L;
        __global__ __launch_bounds__(Count) void kernel(unsigned *output, int selector) {{
            constexpr auto local = true ? Count : 1L / 0L;
            constexpr bool flag = true || (1UL / 0UL);
            const auto copied = Count;
            long values[local]{{1L, 2L, 3L, 4L}};
            switch (selector) {{ case 1L: values[0] = 5L; break; case 2UL: break; default: break; }}
            output[0] = kind(Count); output[1] = kind(Maximum); output[2] = kind(Wrapped);
            output[3] = kind(local); output[4] = kind(flag); output[5] = kind(values[1L]);
            output[6] = kind(Inferred); output[7] = kind(copied);
        }}"
    ));
    assert_tag_calls(&module, &[3, 4, 4, 3, 8, 3, 3, 3]);
    roundtrip("__global__ void kernel(int *output) { int values[3]{2,3,5}; constexpr long Value = ((values)[unsigned(4294967297UL)], 7L); output[0] = int(Value); }");
    for expression in [
        "9223372036854775807L + 1L",
        "1L / 0L",
        "1UL % 0UL",
        "1L << 64u",
        "1L << -1",
        "1UL >> 4294967296UL",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{ constexpr auto Value = {expression}; }}"
        ));
    }
    for expression in ["4294967297UL", "-4294967295L"] {
        for array in ["values", "(values)"] {
            rejected(&format!("__global__ void kernel() {{ int values[3]{{2,3,5}}; constexpr long Value = ({array}[{expression}], 7L); }}"));
        }
    }
    for bound in ["0L", "-1L", "4294967299UL", "runtime"] {
        rejected(&format!(
            "__global__ void kernel(long runtime) {{ int values[{bound}]; }}"
        ));
    }
    for bound in ["4294967296UL", "4294967360L"] {
        rejected(&format!(
            "__global__ __launch_bounds__({bound}) void kernel() {{}}"
        ));
    }
    rejected("__global__ void kernel(unsigned selector) { switch(selector) { case 4294967296UL: break; } }");
    rejected("__global__ void kernel(long selector) { switch(selector) { default: break; } }");
}

#[test]
fn cuda_long_types_functions_references_and_prototypes_use_nominal_identity() {
    let source = "
        __device__ int select(long value); __device__ float select(long long value);
        __device__ int select(long value) { return int(value); }
        __device__ float select(long long value) { return float(value); }
        __device__ int ref_kind(long &value) { value += 1L; return 1; }
        __device__ float ref_kind(long long &value) { value += 1LL; return 2.0f; }
        __device__ long observe(const long &value) { return value; }
        __global__ void kernel(long input, long long other, long *output) {
            auto from_long = select(input); auto from_long_long = select(other);
            auto reference_long = ref_kind(input); auto reference_long_long = ref_kind(other);
            output[0] = observe(other); output[1] = long(from_long + from_long_long);
            output[2] = long(reference_long + reference_long_long);
        }";
    let (module, info) = roundtrip(source);
    for (name, scalar) in [
        ("from_long", naga::Scalar::I32),
        ("from_long_long", naga::Scalar::F32),
        ("reference_long", naga::Scalar::I32),
        ("reference_long_long", naga::Scalar::F32),
    ] {
        let value =
            super::helpers::source_binding_initializer(&module.entry_points[0].function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar)
        );
    }
    for source in [
        "__device__ long value(long); __device__ long long value(long); __global__ void kernel() {}",
        "__device__ long value(long input) { long long &alias = input; return alias; } __global__ void kernel() {}",
        "__global__ void kernel(const long *input) { long &alias = input[0]; }",
        "__device__ int choose(long); __device__ int choose(unsigned long); __global__ void kernel(long long value, int *output) { output[0] = choose(value); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_long_types_templates_keep_type_and_value_keys_distinct() {
    let (module, _) = roundtrip(&format!(
        "{KINDS}
        template<class Value> __device__ Value identity(Value value) {{ return value; }}
        template<long Value> __device__ unsigned signed_value() {{ return kind(Value); }}
        template<unsigned long Value> __device__ unsigned unsigned_value() {{ return kind(Value); }}
        __global__ void kernel(unsigned *output) {{
            output[0] = kind(identity(1L)); output[1] = kind(identity(2LL));
            output[2] = kind(identity(3UL)); output[3] = kind(identity(4ULL));
            output[4] = signed_value<-1L>(); output[5] = signed_value<-1LL>();
            output[6] = unsigned_value<18446744073709551615UL>();
            output[7] = unsigned_value<static_cast<unsigned long>(-1LL)>();
        }}"
    ));
    let targets = call_targets(&module.entry_points[0].function);
    assert_eq!(targets.len(), 12);
    assert_ne!(targets[0], targets[2]);
    assert_ne!(targets[4], targets[6]);
    assert_eq!(targets[8], targets[9]);
    assert_eq!(targets[10], targets[11]);
    for (target, tag) in [(targets[8], 3), (targets[10], 4)] {
        let nested = call_targets(&module.functions[target]);
        assert_eq!(nested.len(), 1);
        let function = &module.functions[nested[0]];
        assert!(function.expressions.iter().any(
            |(_, expression)| *expression == naga::Expression::Literal(naga::Literal::U32(tag))
        ));
    }
    let (module, _) = roundtrip("using Count = size_t;
        template<class Value> __global__ void copy(Value *output, const Value *input) { output[0] = input[0]; }
        template __global__ void copy<long>(long *, const long *);
        template __global__ void copy<Count>(Count *, const Count *);
        template __global__ void copy<long long>(long long *, const long long *);
        ");
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["copy<long>", "copy<unsigned long>", "copy<long long>"]
    );
    for (target, value) in [
        ("long", "18446744073709551615UL"),
        ("unsigned long", "-1L"),
        ("long", "1.0f"),
    ] {
        rejected(&format!("template<{target} Value> __device__ int selected() {{ return 1; }} __global__ void kernel(int *output) {{ output[0] = selected<{value}>(); }}"));
    }
}

#[test]
fn cuda_long_types_records_arrays_and_pointer_views_preserve_pointee_identity() {
    let (module, _) = roundtrip(&format!("{KINDS}
        struct Record {{ long first; long long second; unsigned long third; unsigned long long fourth; }};
        using Row = long[3]; using Values = long[];
        __global__ void kernel(const Record *input, unsigned *output) {{
            Record copy(input[0]); Row row{{1L,2L,3L}}; Values *view = &row;
            long *pointer = *view; pointer += 1;
            output[0] = kind(copy.first); output[1] = kind(copy.second);
            output[2] = kind(copy.third); output[3] = kind(copy.fourth);
            output[4] = kind((*view)[0]); output[5] = kind(*pointer);
            long inferred[](4L,5L); output[6] = kind(inferred[0]);
        }}"));
    assert_tag_calls(&module, &[3, 5, 4, 6, 3, 3, 3]);
    let record = module
        .types
        .iter()
        .find_map(|(_, ty)| {
            ty.name
                .as_deref()
                .is_some_and(|name| name.starts_with("Record_cuda_record_"))
                .then_some(ty)
        })
        .unwrap();
    let naga::TypeInner::Struct { ref members, span } = record.inner else {
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
    for source in [
        "__global__ void kernel(long *input) { long long *other = input; }",
        "__global__ void kernel(unsigned long *input) { unsigned long long *other = input; }",
        "__global__ void kernel(long *input) { const long long *other = input; }",
        "__global__ void kernel() { using Row=long[3]; using Other=long long[3]; Row row{}; Other *view=&row; }",
        "__global__ void kernel() { using Values=long[]; long long row[3]{}; Values *view=&row; }",
        "__device__ void use(long *value) {} __global__ void kernel(long long *input) { use(input); }",
    ] {
        rejected(source);
    }
    roundtrip("__global__ void kernel(size_t *input) { unsigned long *same=input; const unsigned long *view=same; size_t value=view[0]; same[1]=value; }");
}

#[test]
fn cuda_long_types_shared_constant_volatile_and_alias_memory_keep_source_kind() {
    let options = Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 32,
    };
    roundtrip_with_options_and_capabilities("using Long=long; using ULong=unsigned long;
        __constant__ Long Coefficients[4]; extern __constant__ const ULong Frozen[4];
        __device__ Long read(const Long *values) { return values[0]; }
        __global__ void kernel(Long *output) {
            __shared__ Long values[4]; extern __shared__ ULong scratch[];
            unsigned index=threadIdx.x; values[index]=Long(index); scratch[index]=ULong(index+1u);
            __syncthreads(); output[index]=values[(index+1u)&3u]+Long(scratch[index])+read(Coefficients)+Long(Frozen[0]);
        }", &options, Capabilities::SHADER_INT64);
    roundtrip_with_options_and_capabilities(
        "__global__ void kernel(volatile long *output, const volatile unsigned long *input) { output[0]=long(input[0]); output[1]+=1L; }",
        &Options::default(),
        Capabilities::SHADER_INT64 | Capabilities::MEMORY_DECORATION_VOLATILE,
    );
    for body in [
        "Values[0]=1L;",
        "long *pointer=Values; *pointer=1L;",
        "long &value=Values[0]; value++; ",
    ] {
        rejected(&format!(
            "__constant__ long Values[2]; __global__ void kernel() {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_long_types_min_max_keep_long_results_without_eager_wide_32_bit_types() {
    let (module, _) = roundtrip(&format!(
        "{KINDS} __global__ void kernel(unsigned *output, long value, unsigned long other) {{
        output[0]=kind(min(value,value)); output[1]=kind(max(value,value));
        output[2]=kind(min(other,other)); output[3]=kind(max(other,other));
        output[4]=kind(min(value,other)); output[5]=kind(max(value,other));
        output[6]=kind(min(other,value)); output[7]=kind(max(other,value));
    }}"
    ));
    assert_tag_calls(&module, &[3, 3, 4, 4, 4, 4, 4, 4]);
    let source = "__global__ void kernel(unsigned *output, int left, unsigned right) {
        output[0]=unsigned(min(left,left)); output[1]=unsigned(max(left,left));
        output[2]=min(right,right); output[3]=max(right,right);
        output[4]=min(left,right); output[5]=max(left,right);
        output[6]=min(right,left); output[7]=max(right,left);
    }";
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty());
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Literal(naga::Literal::I64(_) | naga::Literal::U64(_))
        )));
    for (_, function) in module.functions.iter() {
        assert!(function.expressions.iter().all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Literal(naga::Literal::I64(_) | naga::Literal::U64(_))
        )));
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::empty(),
    );
}

#[test]
fn cuda_long_types_preserve_capability_null_and_unsupported_feature_boundaries() {
    let source = "__global__ void kernel(long *output, const unsigned long *input) { output[0]=long(input[0]); }";
    let module = naga::front::cuda::parse_str(source, &Options::default()).unwrap();
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        Capabilities::empty()
    )
    .validate(&module)
    .is_err());
    roundtrip(source);
    for zero in ["0L", "0UL"] {
        roundtrip(&format!(
            "__global__ void kernel() {{ long *pointer={zero}; }}"
        ));
    }
    for source in [
        "__global__ void kernel() { sizeof(long); }",
        "__global__ void kernel() { alignof(size_t); }",
    ] {
        roundtrip(source);
    }
    for source in [
        "__global__ void kernel() { long *pointer=long(0); }",
        "__global__ void kernel() { constexpr long Zero=0L; long *pointer=Zero; }",
        "__global__ void kernel() { long long long value; }",
        "__global__ void kernel() { unsigned signed long value; }",
        "__global__ void kernel() { short long value; }",
        "__global__ void kernel(long2 *output) {}",
        "__global__ void kernel(ulonglong4 *output) {}",
        "__global__ void kernel(long *output) { atomicAdd(output,1L); }",
        "__device__ long missing(long); __global__ void kernel(long *output) { output[0]=missing(1L); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_long_types_const_locals_remain_integral_constant_expressions() {
    for declaration in [
        "const long Count=3L;",
        "const unsigned long Count=3UL;",
        "const size_t Count=3UL;",
        "using Value=long; const Value Count=3L;",
        "using Value=const long; Value Count=3L;",
        "const auto Count=3L;",
        "const auto Count=3UL;",
        "constexpr long Count=3L;",
    ] {
        let (module, _) = roundtrip(&format!(
            "__global__ void kernel(int *output) {{ {declaration}
                int values[Count]{{2,3,5}}; output[0]=values[Count-1L];
            }}"
        ));
        let (_, values) = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find(|(_, variable)| variable.name.as_deref() == Some("values"))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[values.ty].inner
        else {
            panic!("expected a completed array using the constant bound");
        };
        assert_eq!((count.get(), stride), (3, 4));
    }
}

#[test]
fn cuda_long_types_qualified_volatile_alias_construction_is_scalar() {
    let (module, _) = roundtrip(&format!(
        "{KINDS}
        using V=volatile long; using U=volatile unsigned long;
        using S=volatile std::size_t; using LL=volatile long long;
        __global__ void kernel(unsigned *output) {{
            output[0]=kind(::V(1)); output[1]=kind(::V{{2}});
            output[2]=kind(::U(3)); output[3]=kind(::U{{4}});
            output[4]=kind(V(5)); output[5]=kind(U(6));
            output[6]=kind(::std::size_t(7)); output[7]=kind(::std::size_t{{8}});
            output[8]=kind(::S(9)); output[9]=kind(::LL(10));
        }}"
    ));
    assert_tag_calls(&module, &[3, 3, 4, 4, 3, 4, 4, 4, 4, 5]);
}
