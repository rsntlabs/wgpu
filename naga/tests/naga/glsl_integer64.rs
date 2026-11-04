#![cfg(all(feature = "wgsl-in", feature = "glsl-out"))]

#[test]
fn glsl_integer64_storage_and_literals_require_the_integer_extension() {
    let module = naga::front::wgsl::parse_str(
        "struct Record {
            signed_value: i64,
            unsigned_value: u64,
            signed_pair: vec2<i64>,
            unsigned_pair: vec2<u64>,
        }
        const signed_minimum = -9223372036854775807li - 1li;
        const unsigned_maximum = 18446744073709551615lu;
        @group(0) @binding(0) var<storage, read> input: array<Record>;
        @group(0) @binding(1) var<storage, read_write> output: array<Record>;
        @compute @workgroup_size(1) fn main() {
            output[0] = input[0];
            output[1].signed_value = signed_minimum;
            output[1].unsigned_value = unsigned_maximum;
            output[1].signed_pair = vec2<i64>(signed_minimum, 9223372036854775807li);
            output[1].unsigned_pair = vec2<u64>(unsigned_maximum, 0lu);
        }",
    )
    .unwrap();
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(&module)
    .unwrap();
    let options = naga::back::glsl::Options {
        version: naga::back::glsl::Version::Desktop(450),
        ..Default::default()
    };
    let pipeline = naga::back::glsl::PipelineOptions {
        shader_stage: naga::ShaderStage::Compute,
        entry_point: String::from("main"),
        multiview: None,
    };
    let mut output = String::new();
    naga::back::glsl::Writer::new(
        &mut output,
        &module,
        &info,
        &options,
        &pipeline,
        naga::proc::BoundsCheckPolicies::default(),
    )
    .unwrap()
    .write()
    .unwrap();
    assert_eq!(
        output
            .matches("#extension GL_ARB_gpu_shader_int64 : require")
            .count(),
        1,
        "{output}"
    );
    for type_name in ["int64_t", "uint64_t", "i64vec2", "u64vec2"] {
        assert!(output.contains(type_name), "{type_name} missing\n{output}");
    }
    assert!(output.contains("9223372036854775807"), "{output}");
    assert!(output.contains("18446744073709551615"), "{output}");
}

fn write_module_glsl(
    module: &naga::Module,
    info: &naga::valid::ModuleInfo,
    version: naga::back::glsl::Version,
    shader_stage: naga::ShaderStage,
) -> Result<String, naga::back::glsl::Error> {
    let options = naga::back::glsl::Options {
        version,
        ..Default::default()
    };
    let pipeline = naga::back::glsl::PipelineOptions {
        shader_stage,
        entry_point: String::from("main"),
        multiview: None,
    };
    let mut output = String::new();
    naga::back::glsl::Writer::new(
        &mut output,
        module,
        info,
        &options,
        &pipeline,
        naga::proc::BoundsCheckPolicies::default(),
    )?
    .write()?;
    Ok(output)
}

fn write_glsl(
    source: &str,
    version: naga::back::glsl::Version,
    shader_stage: naga::ShaderStage,
) -> Result<String, naga::back::glsl::Error> {
    let module = naga::front::wgsl::parse_str(source)
        .unwrap_or_else(|error| panic!("{}", error.emit_to_string(source)));
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(&module)
    .unwrap();
    write_module_glsl(&module, &info, version, shader_stage)
}

fn assert_integer64_extension(output: &str, extension: &str) {
    assert_eq!(
        output
            .matches(&format!("#extension {extension} : require"))
            .count(),
        1,
        "{output}"
    );
    assert_eq!(
        output.matches("GL_ARB_gpu_shader_int64").count()
            + output
                .matches("GL_EXT_shader_explicit_arithmetic_types_int64")
                .count(),
        1,
        "{output}"
    );
}

const INTEGER64_VERTEX: &str = "
    @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
        let signed_value = i64(index);
        let unsigned_value = u64(index);
        return vec4<f32>(f32(signed_value), f32(unsigned_value), 0.0, 1.0);
    }";

#[test]
fn glsl_integer64_extension_follows_desktop_and_embedded_profiles() {
    use naga::back::glsl::Version;

    for (version, extension) in [
        (
            Version::Desktop(140),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
        (
            Version::Desktop(150),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
        (
            Version::Desktop(330),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
        (Version::Desktop(400), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(410), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(420), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(430), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(440), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(450), "GL_ARB_gpu_shader_int64"),
        (Version::Desktop(460), "GL_ARB_gpu_shader_int64"),
        (
            Version::new_gles(310),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
        (
            Version::new_gles(320),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
    ] {
        let output = write_glsl(INTEGER64_VERTEX, version, naga::ShaderStage::Vertex).unwrap();
        assert_integer64_extension(&output, extension);
        assert!(output.contains("int64_t"), "{output}");
        assert!(output.contains("uint64_t"), "{output}");
        assert_eq!(
            output.lines().next(),
            Some(format!("#version {version}").as_str()),
            "{output}"
        );
    }
}

#[test]
fn glsl_integer64_rejects_unsupported_profiles_and_webgl() {
    use naga::back::glsl::{Error, Features, Version};

    assert!(matches!(
        write_glsl(
            INTEGER64_VERTEX,
            Version::Desktop(130),
            naga::ShaderStage::Vertex
        ),
        Err(Error::VersionNotSupported)
    ));
    for version in [
        Version::new_gles(300),
        Version::Embedded {
            version: 300,
            is_webgl: true,
        },
        Version::Embedded {
            version: 310,
            is_webgl: true,
        },
        Version::Embedded {
            version: 320,
            is_webgl: true,
        },
    ] {
        match write_glsl(INTEGER64_VERTEX, version, naga::ShaderStage::Vertex) {
            Err(Error::MissingFeatures(missing, actual_version)) => {
                assert_eq!(missing, Features::INT64_TYPE);
                assert_eq!(actual_version, version);
            }
            result => panic!("unexpected integer64 profile result: {result:?}"),
        }
    }
}

#[test]
fn glsl_integer64_vectors_keep_all_component_widths() {
    let source = "
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let signed_pair = vec2<i64>(i64(index));
            let signed_triple = vec3<i64>(i64(index));
            let signed_quad = vec4<i64>(i64(index));
            let unsigned_pair = vec2<u64>(u64(index));
            let unsigned_triple = vec3<u64>(u64(index));
            let unsigned_quad = vec4<u64>(u64(index));
            return vec4<f32>(
                f32(signed_pair.x + signed_triple.y + signed_quad.z),
                f32(unsigned_pair.x + unsigned_triple.y + unsigned_quad.z),
                0.0, 1.0);
        }";
    for version in [
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(310),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Vertex).unwrap();
        for type_name in [
            "i64vec2", "i64vec3", "i64vec4", "u64vec2", "u64vec3", "u64vec4",
        ] {
            assert!(output.contains(type_name), "{type_name} missing\n{output}");
        }
    }
}

#[test]
fn glsl_integer64_globals_functions_and_aggregates_share_the_extension() {
    let source = "
        struct Record { signed_value: i64, unsigned_values: vec2<u64>, values: array<i64, 2> }
        struct Parameters { value: vec2<u64> }
        const Adjustment: i64 = -1li;
        var<private> initial: i64 = 2li;
        var<private> saved: Record;
        var<workgroup> scratch: array<i64, 2>;
        @group(0) @binding(0) var<uniform> parameters: Parameters;
        @group(0) @binding(1) var<storage, read_write> output: array<Record>;
        fn increment(value: Record) -> Record {
            var result = value;
            result.signed_value += 1li;
            return result;
        }
        @compute @workgroup_size(1) fn main() {
            scratch[0] = i64(parameters.value.x) + Adjustment + initial;
            workgroupBarrier();
            saved = increment(Record(scratch[0], parameters.value, array<i64, 2>(-1li, 2li)));
            output[0] = saved;
        }";
    for (version, extension) in [
        (
            naga::back::glsl::Version::Desktop(450),
            "GL_ARB_gpu_shader_int64",
        ),
        (
            naga::back::glsl::Version::new_gles(310),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Compute).unwrap();
        assert_integer64_extension(&output, extension);
        for expected in [
            "struct Record",
            "int64_t",
            "u64vec2",
            "increment(",
            "shared ",
        ] {
            assert!(output.contains(expected), "{expected} missing\n{output}");
        }
    }
}

#[test]
fn glsl_integer64_retained_constants_require_the_extension_without_runtime_uses() {
    let source = "
        const RetainedSigned: i64 = -9223372036854775807li - 1li;
        const RetainedUnsigned: u64 = 18446744073709551615lu;
        @vertex fn main() -> @builtin(position) vec4<f32> { return vec4<f32>(0.0); }";
    for (version, extension) in [
        (
            naga::back::glsl::Version::Desktop(450),
            "GL_ARB_gpu_shader_int64",
        ),
        (
            naga::back::glsl::Version::new_gles(310),
            "GL_EXT_shader_explicit_arithmetic_types_int64",
        ),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Vertex).unwrap();
        assert_integer64_extension(&output, extension);
        assert!(output.contains("int64_t RetainedSigned"), "{output}");
        assert!(output.contains("uint64_t RetainedUnsigned"), "{output}");
        assert!(output.contains("18446744073709551615"), "{output}");
    }
}

#[test]
fn glsl_integer64_expression_value_types_require_the_extension() {
    let mut module = naga::front::wgsl::parse_str(INTEGER64_VERTEX).unwrap();
    naga::compact::compact(&mut module, naga::compact::KeepUnused::No);
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(&module)
    .unwrap();
    for scalar in [naga::Scalar::I64, naga::Scalar::U64] {
        assert!(!module
            .types
            .iter()
            .any(|(_, declared)| declared.inner == naga::TypeInner::Scalar(scalar)));
        assert!(module.entry_points[0].function.expressions.iter().any(|(handle, _)| {
            matches!(&info.get_entry_point(0)[handle].ty,
                naga::proc::TypeResolution::Value(naga::TypeInner::Scalar(actual)) if *actual == scalar)
        }));
    }
    let output = write_module_glsl(
        &module,
        &info,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert_integer64_extension(&output, "GL_ARB_gpu_shader_int64");
}

#[test]
fn glsl_integer64_zero_initialized_arrays_use_typed_elements() {
    let source = "
        var<private> signed_private: array<i64, 2>;
        var<private> unsigned_private: array<u64, 2>;
        var<workgroup> signed_shared: array<i64, 2>;
        var<workgroup> unsigned_shared: array<u64, 2>;
        @group(0) @binding(0) var<storage, read_write> output: array<u64>;
        @compute @workgroup_size(1) fn main() {
            var signed_local: array<i64, 2>;
            var unsigned_local: array<u64, 2>;
            workgroupBarrier();
            output[0] = u64(signed_private[0] + signed_shared[0] + signed_local[0]);
            output[1] = unsigned_private[0] + unsigned_shared[0] + unsigned_local[0];
        }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Compute,
    )
    .unwrap();
    assert!(output.contains("int64_t[2]("), "{output}");
    assert!(output.contains("uint64_t[2]("), "{output}");
    let lowercase = output.to_ascii_lowercase();
    assert!(
        lowercase.contains("0l") || lowercase.contains("int64_t(0)"),
        "{output}"
    );
    assert!(
        lowercase.contains("0ul") || lowercase.contains("uint64_t(0)"),
        "{output}"
    );
}

#[test]
fn glsl_integer64_runtime_shifts_mask_scalar_and_vector_amounts() {
    for scalar in ["i64", "u64"] {
        for components in [1, 2, 3, 4] {
            let value_type = if components == 1 {
                scalar.to_owned()
            } else {
                format!("vec{components}<{scalar}>")
            };
            let amount_type = if components == 1 {
                String::from("u32")
            } else {
                format!("vec{components}<u32>")
            };
            let source = format!(
                "
                @group(0) @binding(0) var<storage> input: array<{value_type}>;
                @group(0) @binding(1) var<storage> amounts: array<{amount_type}>;
                @group(0) @binding(2) var<storage, read_write> output: array<{value_type}>;
                @compute @workgroup_size(1) fn main() {{
                    output[0] = input[0] << amounts[0];
                    output[1] = input[0] >> (amounts[0] + {amount_type}(64u));
                }}"
            );
            let output = write_glsl(
                &source,
                naga::back::glsl::Version::Desktop(450),
                naga::ShaderStage::Compute,
            )
            .unwrap();
            assert!(output.matches("63u").count() >= 2, "{value_type}\n{output}");
            assert!(output.contains('&'), "{value_type}\n{output}");
        }
    }
}

#[test]
fn glsl_integer64_numeric_and_bitcast_conversions_preserve_widths() {
    let source = "
        struct Values { signed_value: i64, unsigned_value: u64, signed_pair: vec2<i64>, unsigned_pair: vec2<u64> }
        @group(0) @binding(0) var<storage> input: array<Values>;
        @group(0) @binding(1) var<storage, read_write> output: array<Values>;
        @group(0) @binding(2) var<storage, read_write> narrowed: array<vec2<u32>>;
        @group(0) @binding(3) var<storage> floats: array<vec2<f32>>;
        @compute @workgroup_size(1) fn main() {
            output[0].signed_value = bitcast<i64>(input[0].unsigned_value);
            output[0].unsigned_value = bitcast<u64>(input[0].signed_value);
            output[0].signed_pair = bitcast<vec2<i64>>(input[0].unsigned_pair);
            output[0].unsigned_pair = bitcast<vec2<u64>>(input[0].signed_pair);
            output[1].signed_value = i64(floats[0].x);
            output[1].unsigned_value = u64(floats[0].y);
            output[1].signed_pair = vec2<i64>(floats[0]);
            output[1].unsigned_pair = vec2<u64>(floats[0]);
            narrowed[0] = vec2<u32>(u32(input[0].signed_value), u32(input[0].unsigned_value));
        }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Compute,
    )
    .unwrap();
    for expected in ["int64_t(", "uint64_t(", "i64vec2(", "u64vec2(", "clamp("] {
        assert!(output.contains(expected), "{expected} missing\n{output}");
    }
    assert!(!output.contains("floatBitsToInt("), "{output}");
    assert!(!output.contains("floatBitsToUint("), "{output}");
}

#[test]
fn glsl_integer64_type_names_do_not_shadow_source_functions() {
    let source = "
        fn int64_t(value: f32) -> f32 { return value + 1.0; }
        fn uint64_t(value: f32) -> f32 { return value + 2.0; }
        fn i64vec2(value: f32) -> f32 { return value + 3.0; }
        fn u64vec4(value: f32) -> f32 { return value + 4.0; }
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let value = f32(index);
            let signed_value = i64(int64_t(value) + i64vec2(value));
            let unsigned_value = u64(uint64_t(value) + u64vec4(value));
            return vec4<f32>(f32(signed_value), f32(unsigned_value), 0.0, 1.0);
        }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    for reserved in ["int64_t", "uint64_t", "i64vec2", "u64vec4"] {
        assert!(!output.contains(&format!("float {reserved}(")), "{output}");
        assert!(output.contains(&format!("float {reserved}_")), "{output}");
    }
}

#[test]
fn glsl_integer32_shaders_do_not_require_integer64_extensions() {
    let source = "
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            return vec4<f32>(f32(i32(index)), f32(index), 0.0, 1.0);
        }";
    for version in [
        naga::back::glsl::Version::Desktop(140),
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(300),
        naga::back::glsl::Version::new_gles(310),
        naga::back::glsl::Version::Embedded {
            version: 300,
            is_webgl: true,
        },
        naga::back::glsl::Version::Embedded {
            version: 310,
            is_webgl: true,
        },
        naga::back::glsl::Version::Embedded {
            version: 320,
            is_webgl: true,
        },
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Vertex).unwrap();
        assert!(!output.contains("GL_ARB_gpu_shader_int64"), "{output}");
        assert!(
            !output.contains("GL_EXT_shader_explicit_arithmetic_types_int64"),
            "{output}"
        );
        assert!(!output.contains("int64_t"), "{output}");
    }
}

#[test]
fn glsl_integer64_subgroups_are_rejected_while_integer32_subgroups_remain_supported() {
    use naga::back::glsl::{Error, Version};
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    for scalar in ["i64", "u64", "i32", "u32"] {
        for (operation, function_name) in [
            ("subgroupAdd(value)", "subgroupAdd"),
            ("subgroupShuffle(value, 0u)", "subgroupShuffle"),
            ("subgroupBroadcast(value, 0u)", "subgroupBroadcast"),
        ] {
            let source = format!(
                "
                @group(0) @binding(0) var<storage> input: array<{scalar}>;
                @group(0) @binding(1) var<storage, read_write> output: array<{scalar}>;
                @compute @workgroup_size(32) fn main(@builtin(local_invocation_index) index: u32) {{
                    let value = input[index];
                    output[index] = {operation};
                }}"
            );
            let module = naga::front::wgsl::parse_str(&source)
                .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
            let info = Validator::new(
                ValidationFlags::all(),
                Capabilities::SHADER_INT64 | Capabilities::SUBGROUP,
            )
            .validate(&module)
            .unwrap();
            let result = write_module_glsl(
                &module,
                &info,
                Version::Desktop(450),
                naga::ShaderStage::Compute,
            );
            if scalar.ends_with("64") {
                match result {
                    Err(Error::Custom(message)) => {
                        assert!(message.contains("64-bit"), "{message}");
                        assert!(
                            message.to_ascii_lowercase().contains("subgroup"),
                            "{message}"
                        );
                    }
                    other => panic!("unexpected {scalar} {operation} result: {other:?}"),
                }
            } else {
                let output = result.unwrap();
                assert!(output.contains(&format!("{function_name}(")), "{output}");
                assert!(!output.contains("GL_ARB_gpu_shader_int64"), "{output}");
            }
        }
    }
}

#[test]
fn glsl_integer64_boundary_literals_have_explicit_legal_suffixes() {
    let source = "
        const SignedMinimum: i64 = -9223372036854775807li - 1li;
        const SignedMaximum: i64 = 9223372036854775807li;
        const UnsignedMaximum: u64 = 18446744073709551615lu;
        @vertex fn main() -> @builtin(position) vec4<f32> { return vec4<f32>(0.0); }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert!(
        output.contains("const int64_t SignedMinimum = (-9223372036854775807l - 1l);"),
        "{output}"
    );
    assert!(
        output.contains("const int64_t SignedMaximum = 9223372036854775807l;"),
        "{output}"
    );
    assert!(
        output.contains("const uint64_t UnsignedMaximum = 18446744073709551615ul;"),
        "{output}"
    );
    assert!(!output.contains("-9223372036854775808l"), "{output}");
}

#[test]
fn glsl_integer64_unreferenced_global_values_require_the_extension_without_declared_types() {
    let mut module = naga::front::wgsl::parse_str(
        "@vertex fn main() -> @builtin(position) vec4<f32> { return vec4<f32>(0.0); }",
    )
    .unwrap();
    let unsigned32 = module.types.insert(
        naga::Type {
            name: None,
            inner: naga::TypeInner::Scalar(naga::Scalar::U32),
        },
        naga::Span::UNDEFINED,
    );
    let wide_value = module.global_expressions.append(
        naga::Expression::Literal(naga::Literal::U64(0x1_0000_0007)),
        naga::Span::UNDEFINED,
    );
    let independent = module.global_expressions.append(
        naga::Expression::Literal(naga::Literal::U32(7)),
        naga::Span::UNDEFINED,
    );
    module.constants.append(
        naga::Constant {
            name: Some(String::from("Independent")),
            ty: unsigned32,
            init: independent,
        },
        naga::Span::UNDEFINED,
    );
    assert!(!module
        .types
        .iter()
        .any(|(_, declared)| declared.inner == naga::TypeInner::Scalar(naga::Scalar::U64)));
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(&module)
    .unwrap();
    assert_eq!(
        info[wide_value].inner_with(&module.types),
        &naga::TypeInner::Scalar(naga::Scalar::U64)
    );
    let output = write_module_glsl(
        &module,
        &info,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert_integer64_extension(&output, "GL_ARB_gpu_shader_int64");
    assert!(output.contains("const uint Independent = 7u;"), "{output}");
}

#[test]
fn glsl_integer64_double_bitcasts_and_float_conversions_keep_scalar_and_vector_widths() {
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    for components in [1, 2, 3, 4] {
        let type_name = |scalar: &str| {
            if components == 1 {
                scalar.to_owned()
            } else {
                format!("vec{components}<{scalar}>")
            }
        };
        let signed_type = type_name("i64");
        let unsigned_type = type_name("u64");
        let float_type = type_name("f64");
        let source = format!(
            "
            @group(0) @binding(0) var<storage> input: array<{float_type}>;
            @group(0) @binding(1) var<storage, read_write> signed_output: array<{signed_type}>;
            @group(0) @binding(2) var<storage, read_write> unsigned_output: array<{unsigned_type}>;
            @group(0) @binding(3) var<storage, read_write> float_output: array<{float_type}>;
            @compute @workgroup_size(1) fn main() {{
                signed_output[0] = bitcast<{signed_type}>(input[0]);
                unsigned_output[0] = bitcast<{unsigned_type}>(input[0]);
                float_output[0] = bitcast<{float_type}>(signed_output[0]);
                float_output[1] = bitcast<{float_type}>(unsigned_output[0]);
                signed_output[1] = {signed_type}(input[1]);
                unsigned_output[1] = {unsigned_type}(input[1]);
            }}"
        );
        let module = naga::front::wgsl::parse_str(&source)
            .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
        let info = Validator::new(
            ValidationFlags::all(),
            Capabilities::SHADER_INT64 | Capabilities::FLOAT64,
        )
        .validate(&module)
        .unwrap();
        let output = write_module_glsl(
            &module,
            &info,
            naga::back::glsl::Version::Desktop(450),
            naga::ShaderStage::Compute,
        )
        .unwrap();
        for function in [
            "doubleBitsToInt64",
            "doubleBitsToUint64",
            "int64BitsToDouble",
            "uint64BitsToDouble",
        ] {
            assert!(
                output.contains(&format!("{function}(")),
                "{function} missing\n{output}"
            );
        }
        assert_eq!(output.matches("clamp(").count(), 2, "{output}");
        assert!(
            output.contains(", -9.223372036854776e18LF, 9.223372036854775e18LF)"),
            "{output}"
        );
        assert!(
            output.contains(", 0.0LF, 1.844674407370955e19LF)"),
            "{output}"
        );
        assert!(!output.contains("floatBitsToInt("), "{output}");
        assert!(!output.contains("floatBitsToUint("), "{output}");
        match write_module_glsl(
            &module,
            &info,
            naga::back::glsl::Version::new_gles(310),
            naga::ShaderStage::Compute,
        ) {
            Err(naga::back::glsl::Error::MissingFeatures(missing, _)) => {
                assert_eq!(missing, naga::back::glsl::Features::DOUBLE_TYPE);
            }
            other => panic!("unexpected embedded double result: {other:?}"),
        }
    }
}

#[test]
fn glsl_resolved_double_types_require_desktop_double_support() {
    let mut module = naga::front::wgsl::parse_str(
        "
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let widened = f64(index);
            return vec4<f32>(f32(widened), 0.0, 0.0, 1.0);
        }",
    )
    .unwrap();
    naga::compact::compact(&mut module, naga::compact::KeepUnused::No);
    assert!(!module
        .types
        .iter()
        .any(|(_, declared)| declared.inner == naga::TypeInner::Scalar(naga::Scalar::F64)));
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::FLOAT64,
    )
    .validate(&module)
    .unwrap();
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(handle, _)| {
            matches!(
                &info.get_entry_point(0)[handle].ty,
                naga::proc::TypeResolution::Value(naga::TypeInner::Scalar(naga::Scalar::F64))
            )
        }));
    let output = write_module_glsl(
        &module,
        &info,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert!(output.contains("double("), "{output}");
    assert!(!output.contains("GL_ARB_gpu_shader_int64"), "{output}");
    match write_module_glsl(
        &module,
        &info,
        naga::back::glsl::Version::new_gles(310),
        naga::ShaderStage::Vertex,
    ) {
        Err(naga::back::glsl::Error::MissingFeatures(missing, _)) => {
            assert_eq!(missing, naga::back::glsl::Features::DOUBLE_TYPE);
        }
        other => panic!("unexpected embedded resolved double result: {other:?}"),
    }
}

#[test]
fn glsl_integer64_unavailable_division_remainder_and_bit_builtins_report_errors() {
    for scalar in ["i64", "u64", "vec2<i64>", "vec2<u64>"] {
        for (expression, operation) in [
            ("value / value", "Divide"),
            ("value % value", "Modulo"),
            ("countLeadingZeros(value)", "CountLeadingZeros"),
            ("countTrailingZeros(value)", "CountTrailingZeros"),
            ("countOneBits(value)", "CountOneBits"),
            ("reverseBits(value)", "ReverseBits"),
            ("firstLeadingBit(value)", "FirstLeadingBit"),
            ("firstTrailingBit(value)", "FirstTrailingBit"),
            ("extractBits(value, 1u, 3u)", "ExtractBits"),
            ("insertBits(value, value, 1u, 3u)", "InsertBits"),
        ] {
            let source = format!(
                "
                @group(0) @binding(0) var<storage> input: array<{scalar}>;
                @group(0) @binding(1) var<storage, read_write> output: array<{scalar}>;
                @compute @workgroup_size(1) fn main() {{
                    let value = input[0];
                    output[0] = {expression};
                }}"
            );
            match write_glsl(
                &source,
                naga::back::glsl::Version::Desktop(450),
                naga::ShaderStage::Compute,
            ) {
                Err(naga::back::glsl::Error::Custom(message)) => {
                    assert_eq!(
                        message,
                        format!("64-bit integer {operation} is not supported")
                    );
                }
                other => panic!("unexpected {scalar} {operation} result: {other:?}"),
            }
        }
    }
}

#[test]
fn glsl_integer64_atomics_and_images_remain_explicitly_unsupported() {
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    let supported = naga::back::glsl::supported_capabilities();
    assert!(supported.contains(Capabilities::SHADER_INT64));
    assert!(!supported.intersects(
        Capabilities::SHADER_INT64_ATOMIC_ALL_OPS
            | Capabilities::SHADER_INT64_ATOMIC_MIN_MAX
            | Capabilities::TEXTURE_INT64_ATOMIC,
    ));
    for (source, capabilities, expected) in [
        (
            "var<workgroup> counter: atomic<u64>;
             @compute @workgroup_size(1) fn main() { atomicAdd(&counter, 1lu); }",
            Capabilities::SHADER_INT64 | Capabilities::SHADER_INT64_ATOMIC_ALL_OPS,
            "64-bit integer atomics are not supported",
        ),
        (
            "@group(0) @binding(0) var image: texture_storage_2d<r64uint, atomic>;
             @compute @workgroup_size(1) fn main() { textureAtomicMax(image, vec2<i32>(0), 1lu); }",
            Capabilities::SHADER_INT64 | Capabilities::TEXTURE_INT64_ATOMIC,
            "64-bit storage images are not supported",
        ),
    ] {
        let module = naga::front::wgsl::parse_str(source)
            .unwrap_or_else(|error| panic!("{}", error.emit_to_string(source)));
        let info = Validator::new(ValidationFlags::all(), capabilities)
            .validate(&module)
            .unwrap();
        match write_module_glsl(
            &module,
            &info,
            naga::back::glsl::Version::Desktop(450),
            naga::ShaderStage::Compute,
        ) {
            Err(naga::back::glsl::Error::Custom(message)) => assert_eq!(message, expected),
            other => panic!("unexpected advanced integer64 result: {other:?}"),
        }
    }
}

#[test]
fn glsl_integer64_shifts_accept_valid_ir_unsigned16_and_unsigned64_amounts() {
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    for amount_scalar in [naga::Scalar::U16, naga::Scalar::U64] {
        for scalar in ["i64", "u64"] {
            for components in [1, 2, 3, 4] {
                let value_type = if components == 1 {
                    scalar.to_owned()
                } else {
                    format!("vec{components}<{scalar}>")
                };
                let amount_scalar_name = if amount_scalar == naga::Scalar::U16 {
                    "u16"
                } else {
                    "u64"
                };
                let amount_type = if components == 1 {
                    amount_scalar_name.to_owned()
                } else {
                    format!("vec{components}<{amount_scalar_name}>")
                };
                let converted_type = if components == 1 {
                    String::from("u32")
                } else {
                    format!("vec{components}<u32>")
                };
                let header = if amount_scalar == naga::Scalar::U16 {
                    "enable wgpu_int16;"
                } else {
                    ""
                };
                let source = format!(
                    "{header}
                    @group(0) @binding(0) var<storage> input: array<{value_type}>;
                    @group(0) @binding(1) var<storage> amounts: array<{amount_type}>;
                    @group(0) @binding(2) var<storage, read_write> output: array<{value_type}>;
                    @compute @workgroup_size(1) fn main() {{
                        output[0] = input[0] << {converted_type}(amounts[0]);
                        output[1] = input[0] >> {converted_type}(amounts[0]);
                    }}"
                );
                let mut module = naga::front::wgsl::parse_str(&source)
                    .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
                let function = &mut module.entry_points[0].function;
                let replacements: Vec<_> = function
                    .expressions
                    .iter()
                    .filter_map(|(handle, expression)| {
                        let naga::Expression::Binary {
                            op: naga::BinaryOperator::ShiftLeft | naga::BinaryOperator::ShiftRight,
                            right,
                            ..
                        } = *expression
                        else {
                            return None;
                        };
                        let naga::Expression::As {
                            expr,
                            kind: naga::ScalarKind::Uint,
                            convert: Some(4),
                        } = function.expressions[right]
                        else {
                            panic!("expected the WGSL shift amount conversion");
                        };
                        Some((handle, expr))
                    })
                    .collect();
                assert_eq!(replacements.len(), 2);
                for (handle, amount) in replacements {
                    let naga::Expression::Binary { ref mut right, .. } =
                        function.expressions[handle]
                    else {
                        unreachable!()
                    };
                    *right = amount;
                }
                let info = Validator::new(
                    ValidationFlags::all(),
                    Capabilities::SHADER_INT64 | Capabilities::SHADER_INT16,
                )
                .validate(&module)
                .unwrap();
                for (_, expression) in module.entry_points[0].function.expressions.iter() {
                    if let naga::Expression::Binary {
                        op: naga::BinaryOperator::ShiftLeft | naga::BinaryOperator::ShiftRight,
                        right,
                        ..
                    } = *expression
                    {
                        assert_eq!(
                            info.get_entry_point(0)[right]
                                .ty
                                .inner_with(&module.types)
                                .scalar(),
                            Some(amount_scalar)
                        );
                    }
                }
                let output = write_module_glsl(
                    &module,
                    &info,
                    naga::back::glsl::Version::Desktop(450),
                    naga::ShaderStage::Compute,
                )
                .unwrap();
                assert!(
                    output.matches("63u").count() >= 2,
                    "{amount_type}\n{output}"
                );
                assert!(output.contains('&'), "{amount_type}\n{output}");
            }
        }
    }
}

#[test]
fn glsl_integer64_index_and_selector_contexts_report_explicit_errors() {
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    for (operation, declaration, body, reason) in [
        (
            "switch", "",
            "switch(i32(wide)) { case 0i: { output[0] = 1u; } default: { output[0] = 2u; } }",
            "switch",
        ),
        (
            "access", "@group(0) @binding(2) var<storage> values: array<u32>;",
            "output[0] = values[i32(wide)];", "access",
        ),
        (
            "load", "@group(0) @binding(2) var image: texture_2d<u32>;",
            "output[0] = textureLoad(image, vec2<i32>(0), i32(wide)).x;", "level",
        ),
        (
            "sample",
            "@group(0) @binding(2) var image: texture_2d_array<f32>;
             @group(0) @binding(3) var sampling: sampler;",
            "output[0] = bitcast<u32>(textureSampleLevel(image, sampling, vec2<f32>(0.0), i32(wide), 0.0).x);",
            "sample",
        ),
        (
            "store", "@group(0) @binding(2) var image: texture_storage_2d_array<r32uint, write>;",
            "textureStore(image, vec2<i32>(0), i32(wide), vec4<u32>(1u));", "store",
        ),
        (
            "atomic", "@group(0) @binding(2) var image: texture_storage_2d_array<r32uint, atomic>;",
            "textureAtomicAdd(image, vec2<i32>(0), i32(wide), 1u);", "atomic",
        ),
    ] {
        let source = format!("
            @group(0) @binding(0) var<storage> input: array<i64>;
            @group(0) @binding(1) var<storage, read_write> output: array<u32>;
            {declaration}
            @compute @workgroup_size(1) fn main() {{ let wide = input[0]; {body} }}");
        let mut module = naga::front::wgsl::parse_str(&source)
            .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
        let capabilities = Capabilities::SHADER_INT64 | Capabilities::TEXTURE_ATOMIC;
        let info = Validator::new(ValidationFlags::all(), capabilities).validate(&module).unwrap();
        write_module_glsl(&module, &info, naga::back::glsl::Version::Desktop(450), naga::ShaderStage::Compute).unwrap();
        let function = &mut module.entry_points[0].function;
        let wide = function.named_expressions.iter().find_map(|(&handle, name)| {
            (name == "wide").then_some(handle)
        }).unwrap();
        let expressions: Vec<_> = function.expressions.iter().filter_map(|(handle, expression)| {
            let replace = match (operation, expression) {
                ("access", naga::Expression::Access { index, .. }) => matches!(
                    function.expressions[*index],
                    naga::Expression::As { expr, convert: Some(4), .. } if expr == wide
                ),
                ("load", naga::Expression::ImageLoad { level: Some(_), .. }) => true,
                ("sample", naga::Expression::ImageSample { array_index: Some(_), .. }) => true,
                _ => false,
            };
            replace.then_some(handle)
        }).collect();
        let mut replacements = 0;
        for handle in expressions {
            match &mut function.expressions[handle] {
                naga::Expression::Access { index, .. } => *index = wide,
                naga::Expression::ImageLoad { level, .. } => *level = Some(wide),
                naga::Expression::ImageSample { array_index, .. } => *array_index = Some(wide),
                _ => unreachable!(),
            }
            replacements += 1;
        }
        for statement in function.body.iter_mut() {
            match (operation, statement) {
                ("switch", naga::Statement::Switch { selector, .. }) => {
                    *selector = wide;
                    replacements += 1;
                }
                ("store", naga::Statement::ImageStore { array_index, .. })
                | ("atomic", naga::Statement::ImageAtomic { array_index, .. }) => {
                    *array_index = Some(wide);
                    replacements += 1;
                }
                _ => {}
            }
        }
        assert_eq!(replacements, 1, "{operation}");
        let info = Validator::new(ValidationFlags::all(), capabilities).validate(&module).unwrap();
        match write_module_glsl(&module, &info, naga::back::glsl::Version::Desktop(450), naga::ShaderStage::Compute) {
            Err(naga::back::glsl::Error::Custom(message)) => {
                assert!(message.contains("64-bit"), "{operation}: {message}");
                assert!(message.to_ascii_lowercase().contains(reason), "{operation}: {message}");
            }
            other => panic!("unexpected 64-bit {operation} result: {other:?}"),
        }
    }
}

#[test]
fn glsl_integer64_half_conversions_report_unsupported_scalars_without_panicking() {
    use naga::valid::{Capabilities, ValidationFlags, Validator};

    for scalar in ["i64", "u64"] {
        for components in [1, 2, 3, 4] {
            let target_type = if components == 1 {
                scalar.to_owned()
            } else {
                format!("vec{components}<{scalar}>")
            };
            let input_type = if components == 1 {
                String::from("u16")
            } else {
                format!("vec{components}<u16>")
            };
            let half_type = if components == 1 {
                String::from("f16")
            } else {
                format!("vec{components}<f16>")
            };
            let source = format!(
                "enable f16; enable wgpu_int16;
                @group(0) @binding(0) var<storage> input: array<{input_type}>;
                @group(0) @binding(1) var<storage, read_write> output: array<{target_type}>;
                @compute @workgroup_size(1) fn main() {{
                    output[0] = {target_type}(bitcast<{half_type}>(input[0]));
                }}"
            );
            let module = naga::front::wgsl::parse_str(&source)
                .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
            let info = Validator::new(
                ValidationFlags::all(),
                Capabilities::SHADER_FLOAT16
                    | Capabilities::SHADER_INT16
                    | Capabilities::SHADER_INT64,
            )
            .validate(&module)
            .unwrap();
            let function = &module.entry_points[0].function;
            assert!(function.expressions.iter().any(|(handle, expression)| {
                matches!(
                    *expression,
                    naga::Expression::As {
                        kind: naga::ScalarKind::Float,
                        convert: None,
                        ..
                    }
                ) && info.get_entry_point(0)[handle]
                    .ty
                    .inner_with(&module.types)
                    .scalar()
                    == Some(naga::Scalar::F16)
                    && info.get_entry_point(0)[handle].ref_count == 1
                    && !function.named_expressions.contains_key(&handle)
            }));
            match write_module_glsl(
                &module,
                &info,
                naga::back::glsl::Version::Desktop(450),
                naga::ShaderStage::Compute,
            ) {
                Err(naga::back::glsl::Error::UnsupportedScalar(scalar)) => {
                    assert_eq!(scalar, naga::Scalar::F16);
                }
                other => panic!("unexpected half-to-integer64 result: {other:?}"),
            }
        }
    }
}
