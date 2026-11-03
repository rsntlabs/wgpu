#![cfg(all(feature = "wgsl-in", feature = "hlsl-out"))]

const FLOAT_CONVERSIONS: &str = "enable wgpu_int16;
    @group(0) @binding(0) var<storage, read> input: array<vec4<f32>>;
    @group(0) @binding(1) var<storage, read_write> signed_output: array<vec4<i16>>;
    @group(0) @binding(2) var<storage, read_write> unsigned_output: array<vec4<u16>>;

    @compute @workgroup_size(1) fn main() {
        let value = input[0];
        signed_output[0] = vec4<i16>(i16(value.x), i16(value.y), i16(value.z), i16(value.w));
        signed_output[1] = vec4<i16>(vec2<i16>(value.xy), vec2<i16>(value.zw));
        signed_output[2] = vec4<i16>(vec3<i16>(value.xyz), i16(value.w));
        signed_output[3] = vec4<i16>(value);
        unsigned_output[0] = vec4<u16>(u16(value.x), u16(value.y), u16(value.z), u16(value.w));
        unsigned_output[1] = vec4<u16>(vec2<u16>(value.xy), vec2<u16>(value.zw));
        unsigned_output[2] = vec4<u16>(vec3<u16>(value.xyz), u16(value.w));
        unsigned_output[3] = vec4<u16>(value);
    }";

fn write_hlsl(source: &str, capabilities: naga::valid::Capabilities) -> String {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities)
        .validate(&module)
        .unwrap();
    let mut options = naga::back::hlsl::Options {
        shader_model: naga::back::hlsl::ShaderModel::V6_2,
        fake_missing_bindings: false,
        ..Default::default()
    };
    for binding in 0..3 {
        options.binding_map.insert(
            naga::ResourceBinding { group: 0, binding },
            naga::back::hlsl::BindTarget {
                register: binding,
                space: 0,
                ..Default::default()
            },
        );
    }
    let pipeline = naga::back::hlsl::PipelineOptions::default();
    let mut output = String::new();
    let reflection = naga::back::hlsl::Writer::new(&mut output, &options, &pipeline)
        .write(&module, &info, None)
        .unwrap();
    assert_eq!(reflection.entry_point_names.len(), 1);
    assert!(reflection.entry_point_names[0].is_ok(), "{output}");
    output
}

fn assert_cast_helper(
    output: &str,
    name: &str,
    source_type: &str,
    destination_type: &str,
    minimum: &str,
    maximum: &str,
) {
    let signature = format!("{destination_type} {name}({source_type} value)");
    assert_eq!(output.matches(&signature).count(), 1, "{output}");
    let body = format!(
        "{signature} {{\n    return {destination_type}(clamp(value, {minimum}, {maximum}));\n}}"
    );
    assert!(output.contains(&body), "{output}");
    assert!(output.matches(&format!("{name}(")).count() > 4, "{output}");
}

#[test]
fn hlsl_integer16_runtime_float_conversions_have_typed_saturating_helpers() {
    let output = write_hlsl(FLOAT_CONVERSIONS, naga::valid::Capabilities::SHADER_INT16);
    for (source_type, signed_type, unsigned_type) in [
        ("float", "int16_t", "uint16_t"),
        ("float2", "int16_t2", "uint16_t2"),
        ("float3", "int16_t3", "uint16_t3"),
        ("float4", "int16_t4", "uint16_t4"),
    ] {
        assert_cast_helper(
            &output,
            "naga_f2i16",
            source_type,
            signed_type,
            "-32768.0",
            "32767.0",
        );
        assert_cast_helper(
            &output,
            "naga_f2u16",
            source_type,
            unsigned_type,
            "0.0",
            "65535.0",
        );
    }
}

#[test]
fn hlsl_integer16_runtime_half_conversions_stay_within_integer_bounds() {
    let source = format!("enable f16;\n{}", FLOAT_CONVERSIONS.replace("f32", "f16"));
    let output = write_hlsl(
        &source,
        naga::valid::Capabilities::SHADER_INT16 | naga::valid::Capabilities::SHADER_FLOAT16,
    );
    for (source_type, signed_type, unsigned_type) in [
        ("half", "int16_t", "uint16_t"),
        ("half2", "int16_t2", "uint16_t2"),
        ("half3", "int16_t3", "uint16_t3"),
        ("half4", "int16_t4", "uint16_t4"),
    ] {
        assert_cast_helper(
            &output,
            "naga_f2i16",
            source_type,
            signed_type,
            "-32768.0h",
            "32752.0h",
        );
        assert_cast_helper(
            &output,
            "naga_f2u16",
            source_type,
            unsigned_type,
            "0.0h",
            "65504.0h",
        );
    }
}

#[test]
fn hlsl_integer16_conversion_helpers_reserve_their_names() {
    let source = format!(
        "enable wgpu_int16;
        fn naga_f2i16(value: f32) -> f32 {{ return value + 1.0; }}
        fn naga_f2u16(value: f32) -> f32 {{ return value - 1.0; }}\n{}",
        FLOAT_CONVERSIONS.replace("enable wgpu_int16;", "").replace(
            "let value = input[0];",
            "let value = input[0] + vec4<f32>(naga_f2i16(input[1].x) + naga_f2u16(input[1].y));"
        )
    );
    let output = write_hlsl(&source, naga::valid::Capabilities::SHADER_INT16);
    assert_cast_helper(
        &output,
        "naga_f2i16",
        "float",
        "int16_t",
        "-32768.0",
        "32767.0",
    );
    assert_cast_helper(&output, "naga_f2u16", "float", "uint16_t", "0.0", "65535.0");
    assert!(!output.contains("float naga_f2i16("), "{output}");
    assert!(!output.contains("float naga_f2u16("), "{output}");
}

#[test]
fn hlsl_integer16_helpers_preserve_float_to_integer32_conversions() {
    let source = FLOAT_CONVERSIONS
        .replace("i16", "i32")
        .replace("u16", "u32");
    let output = write_hlsl(&source, naga::valid::Capabilities::SHADER_INT16);
    for (source_type, signed_type, unsigned_type) in [
        ("float", "int", "uint"),
        ("float2", "int2", "uint2"),
        ("float3", "int3", "uint3"),
        ("float4", "int4", "uint4"),
    ] {
        assert_cast_helper(
            &output,
            "naga_f2i32",
            source_type,
            signed_type,
            "-2147483600.0",
            "2147483500.0",
        );
        assert_cast_helper(
            &output,
            "naga_f2u32",
            source_type,
            unsigned_type,
            "0.0",
            "4294967000.0",
        );
    }
}
