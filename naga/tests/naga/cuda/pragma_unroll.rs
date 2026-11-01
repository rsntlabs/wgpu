use naga::front::cuda::{parse_str, Options};

use super::helpers::{validate, validate_with_options};

const FIXTURE: &str = include_str!("../../in/cuda/pragma-unroll.cu");

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

fn kernel(definitions: &str, body: &str) -> String {
    format!(
        "{definitions}\n__global__ void kernel(unsigned *output, unsigned runtime) {{\n{body}\n}}"
    )
}

#[test]
fn cuda_pragma_unroll_preserves_loop_values_launch_and_resource_bindings() {
    let (module, info) = validate_with_options(
        FIXTURE,
        &Options {
            workgroup_size: [4, 1, 1],
        },
    );
    assert_eq!(module.entry_points[0].name, "loops");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| (binding, global.space)))
        .collect();
    assert_eq!(
        resources,
        [
            (
                naga::ResourceBinding {
                    group: 0,
                    binding: 0
                },
                naga::AddressSpace::Storage {
                    access: naga::StorageAccess::LOAD
                }
            ),
            (
                naga::ResourceBinding {
                    group: 0,
                    binding: 1
                },
                naga::AddressSpace::Storage {
                    access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                }
            ),
        ]
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_pragma_unroll_accepts_source_integral_constants_and_conversion_expressions() {
    for factor in [
        "",
        "0",
        "1",
        "-1",
        "2147483648u",
        "0xffffffffu",
        "true",
        "false",
        "Count",
        "Local + 1",
        "(Count * 2 - 1)",
        "(1, 3)",
        "int(3.75f)",
        "static_cast<unsigned>(2.5f)",
    ] {
        roundtrip(&kernel("constexpr int Count = 4;", &format!(
            "const int Local = 2; unsigned total = 0u;\n#pragma unroll {factor}\nfor (unsigned index = 0u; index < runtime; ++index) total += index;\noutput[0] = total;"
        )));
    }
    roundtrip(
        "__device__ unsigned helper(unsigned count) {
        constexpr unsigned Factor = 3u;
        unsigned result = 0u;
#pragma unroll Factor + 1u
        for (unsigned index = 0u; index < count; ++index) result += index;
        return result;
    }
    __global__ void kernel(unsigned *output) { output[0] = helper(4u); }",
    );
}

#[test]
fn cuda_pragma_unroll_keeps_raw_factors_and_preserves_macros_logical_lines_and_placement() {
    roundtrip(&kernel("#define BODY(index) ((index) + 1u)\n#if 0\n#pragma unroll missing(\n#endif", "const int Factor = 2; unsigned total = 0u;\n#pragma unroll Factor + 1\nfor (unsigned index = 0u; index < 2u; ++index) total += BODY(index);\n#define Factor missing\n#pragma unroll Factor\nwhile (total < 3u) ++total;\n#undef Factor\n{ const int Count = 2;\n#define Count 9\n#pragma unroll Count + 1\nfor (unsigned index = 0u; index < 2u; ++index) ++total;\n#undef Count\n}\n{ constexpr unsigned Count = 1u;\n#pragma unroll Count + 1u\ndo { --total; } while (total > 3u); }\noutput[0] = total;"));
    for ending in ["\n", "\r\n", "\r"] {
        roundtrip(&format!("constexpr int Factor = 2;{ending}__global__ void kernel(unsigned *output) {{{ending}\t# /* between */ pragma unroll /* factor */ (Factor + \\{ending}1){ending}for (unsigned index = 0u; index < 3u; ++index) output[index] = index;{ending}}}"));
    }
    roundtrip(&kernel("#if 1\n#define COUNT 3\n#elif missing(\n#pragma unroll not a valid payload\n#endif", "#pragma unroll 3\nfor (unsigned index = 0u; index < COUNT; ++index) output[index] = index;"));
    roundtrip(&kernel("#pragma unroll", "#pragma unroll\nunsigned value = 0u;\n#pragma unroll\nif (runtime) ++value;\n#pragma unroll\n;\n#pragma unroll\n{ ++value; }\n#pragma unroll\n#pragma unroll 2\n#pragma unroll 1\nfor (unsigned index = 0u; index < 2u; ++index) value += index;\nfor (\n#pragma unroll\nunsigned index = 0u; index < 2u; ++index) ++value;\noutput[0] = value;\n#pragma unroll"));
}

#[test]
fn cuda_pragma_unroll_rejects_nonintegral_nonconstant_and_invalid_factors_with_source_spans() {
    for factor in [
        "2.0f",
        "runtime",
        "runtime++",
        "missing",
        "(1 / 0)",
        "(2.5f + 1.0f)",
    ] {
        for prefix in ["", "return;\n"] {
            rejected(&kernel("", &format!("{prefix}#pragma unroll {factor}\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;")));
        }
    }
    let source = kernel("/* π */\n#define BAD_FACTOR 1.5f", "#pragma unroll BAD_FACTOR\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;");
    let error = rejected(&source);
    assert_eq!(&source[error.span.to_range().unwrap()], "BAD_FACTOR");
    rejected(&kernel("", "unsigned Count = 3u;\n#pragma unroll Count\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;"));
    for (definitions, body) in [
        ("#define COUNT 3", "#pragma unroll COUNT\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;"),
        ("#define DOUBLE(value) ((value) + (value))", "#pragma unroll DOUBLE(2)\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;"),
        ("", "unsigned Count = runtime;\n#define Count 3\n#pragma unroll Count\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;"),
    ] {
        rejected(&kernel(definitions, body));
    }
}

#[test]
fn cuda_pragma_unroll_bounds_factor_nesting_and_flat_declaration_growth() {
    let nested = format!("{}3{}", "(".repeat(128), ")".repeat(128));
    rejected(&kernel("", &format!("#pragma unroll {nested}\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;")));
    let mut counts = Vec::new();
    for loop_count in [16, 32] {
        let mut body = String::new();
        for index in 0..loop_count {
            body.push_str(&format!("#pragma unroll 0xffffffffu\nfor (unsigned value = 0u; value < 3u; ++value) output[{index}] = value;\n"));
        }
        let source = kernel("", &body);
        let (module, _) = validate(&source);
        counts.push(module.entry_points[0].function.expressions.len());
        roundtrip(&source);
    }
    assert!(counts[1] <= counts[0] * 3);
}

#[test]
fn cuda_pragma_unroll_ignores_misplaced_payloads_and_checks_all_stacked_loop_factors() {
    for factor in ["missing", "runtime", "2.0f", "()"] {
        let pragma = format!("#pragma unroll {factor}\n");
        let following_loop =
            "for (unsigned index = 0u; index < 2u; ++index) output[index] = index;";
        roundtrip(&kernel(&pragma, following_loop));
        for statement in [
            "unsigned value = 0u;",
            "if (runtime) output[0] = 1u;",
            ";",
            "{ output[0] = 1u; }",
        ] {
            roundtrip(&kernel(
                "",
                &format!("{pragma}{statement}\n{following_loop}"),
            ));
        }
        roundtrip(&kernel(
            "",
            &format!(
                "for (\n{pragma}unsigned index = 0u; index < 2u; ++index) output[index] = index;"
            ),
        ));
        roundtrip(&kernel("", &format!("{following_loop}\n{pragma}")));
        for hints in [
            format!("{pragma}#pragma unroll 2\n"),
            format!("#pragma unroll 2\n{pragma}"),
        ] {
            rejected(&kernel("", &format!("{hints}{following_loop}")));
        }
    }
    for factor in [
        "2, missing",
        "2 ignored",
        "2 \"ignored\"",
        "2 COUNT(missing)",
        "2 = missing",
        "2 += runtime",
        "2 'x'",
        "2 R\"(ignored)\"",
    ] {
        roundtrip(&kernel("#define COUNT(value) ((value) + 1)", &format!("#pragma unroll {factor}\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;")));
    }
    for factor in [
        "(2, missing)",
        "2 + missing",
        "2 +",
        "2 @",
        "2 #",
        "runtime = 3",
        "2++",
        "2'x'",
        "2R\"(ignored)\"",
    ] {
        rejected(&kernel("", &format!("#pragma unroll {factor}\nfor (unsigned index = 0u; index < 2u; ++index) output[index] = index;")));
    }
    roundtrip(&kernel("#define LOOP for", "constexpr int Count = 3;\n#pragma unroll Count\nLOOP (unsigned Count = 0u; Count < 2u; ++Count) output[Count] = Count;"));
}
