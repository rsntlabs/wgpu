fn words_to_bytes(words: &[u32]) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(words.len() * 4);
    for word in words {
        bytes.extend_from_slice(&word.to_le_bytes());
    }
    bytes
}

#[test]
fn atomic_compare_exchange_roundtrip_to_spirv() {
    let source = include_str!("../in/wgsl/atomicCompareExchange.wgsl");
    let module = naga::front::wgsl::parse_str(source).unwrap();

    let mut validator = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    );
    let info = validator.validate(&module).unwrap();

    let pipeline_options = naga::back::spv::PipelineOptions {
        entry_point: "test_atomic_compare_exchange_u32".to_string(),
        shader_stage: naga::ShaderStage::Compute,
    };
    let options = naga::back::spv::Options::default();
    let spv_words =
        naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline_options)).unwrap();

    let spv_bytes = words_to_bytes(&spv_words);
    let parsed = naga::front::spv::parse_u8_slice(
        &spv_bytes,
        &naga::front::spv::Options {
            adjust_coordinate_space: true,
            strict_capabilities: false,
            block_ctx_dump_prefix: None,
        },
    )
    .unwrap();

    let parsed_info = validator.validate(&parsed).unwrap();
    naga::back::spv::write_vec(&parsed, &parsed_info, &options, Some(&pipeline_options)).unwrap();
}

fn integer16_roundtrip(source: &str, entry_point: &str) -> naga::Module {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let mut validator = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT16,
    );
    let info = validator.validate(&module).unwrap();
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: entry_point.to_owned(),
        shader_stage: naga::ShaderStage::Compute,
    };
    let options = naga::back::spv::Options {
        use_storage_input_output_16: false,
        ..Default::default()
    };
    let words = naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
    super::helpers::validate_spirv(&words);
    let parsed = naga::front::spv::parse_u8_slice(
        &words_to_bytes(&words),
        &naga::front::spv::Options {
            adjust_coordinate_space: false,
            strict_capabilities: true,
            block_ctx_dump_prefix: None,
        },
    )
    .unwrap();
    let parsed_info = validator.validate(&parsed).unwrap();
    let rewritten =
        naga::back::spv::write_vec(&parsed, &parsed_info, &options, Some(&pipeline)).unwrap();
    super::helpers::validate_spirv(&rewritten);
    parsed
}

#[test]
fn integer16_scalar_constants_roundtrip_to_spirv() {
    let parsed = integer16_roundtrip(
        "enable wgpu_int16;
        @group(0) @binding(0) var<storage, read_write> signed_output: array<i16>;
        @group(0) @binding(1) var<storage, read_write> unsigned_output: array<u16>;
        @compute @workgroup_size(1) fn main() {
            signed_output[0] = i16(-32768);
            signed_output[1] = i16(-1);
            signed_output[2] = i16(0);
            signed_output[3] = i16(1);
            signed_output[4] = i16(32767);
            unsigned_output[0] = u16(0);
            unsigned_output[1] = u16(1);
            unsigned_output[2] = u16(32767);
            unsigned_output[3] = u16(32768);
            unsigned_output[4] = u16(65535);
        }",
        "main",
    );
    for literal in [
        naga::Literal::I16(-32768),
        naga::Literal::I16(-1),
        naga::Literal::I16(0),
        naga::Literal::I16(1),
        naga::Literal::I16(32767),
        naga::Literal::U16(0),
        naga::Literal::U16(1),
        naga::Literal::U16(32767),
        naga::Literal::U16(32768),
        naga::Literal::U16(65535),
    ] {
        assert!(
            parsed.global_expressions.iter().any(|(_, expression)| {
                matches!(*expression, naga::Expression::Literal(actual) if actual == literal)
            }),
            "missing integer16 literal {literal:?}"
        );
    }
}

#[test]
fn integer16_vector_constants_roundtrip_to_spirv() {
    let parsed = integer16_roundtrip(
        "enable wgpu_int16;
        @group(0) @binding(0) var<storage, read_write> signed_output: array<vec4<i16>>;
        @group(0) @binding(1) var<storage, read_write> unsigned_output: array<vec4<u16>>;
        @compute @workgroup_size(1) fn main() {
            signed_output[0] = vec4<i16>(i16(-32768), i16(-1), i16(0), i16(32767));
            unsigned_output[0] = vec4<u16>(u16(0), u16(1), u16(32768), u16(65535));
        }",
        "main",
    );
    for scalar in [naga::Scalar::I16, naga::Scalar::U16] {
        assert!(parsed.global_expressions.iter().any(|(_, expression)| {
            matches!(expression, naga::Expression::Compose { ty, components }
            if components.len() == 4
                && parsed.types[*ty].inner == (naga::TypeInner::Vector {
                    size: naga::VectorSize::Quad,
                    scalar,
                }))
        }));
    }
}

#[test]
fn integer16_storage_fixture_roundtrips_to_spirv() {
    let parsed = integer16_roundtrip(
        include_str!("../in/wgsl/int16-glsl.wgsl"),
        "integer_storage",
    );
    assert_eq!(parsed.entry_points.len(), 1);
    assert_eq!(parsed.entry_points[0].workgroup_size, [4, 1, 1]);
}
