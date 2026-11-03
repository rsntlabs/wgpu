#![cfg(all(feature = "wgsl-in", feature = "glsl-out"))]

#[test]
fn glsl_integer16_storage_requires_the_explicit_arithmetic_extension() {
    let module = naga::front::wgsl::parse_str(
        "enable wgpu_int16;
        struct Record { signed_value: i16, unsigned_value: u16 }
        @group(0) @binding(0) var<storage, read> input: array<Record>;
        @group(0) @binding(1) var<storage, read_write> output: array<Record>;
        @compute @workgroup_size(1) fn main() { output[0] = input[0]; }",
    )
    .unwrap();
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT16,
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
            .matches("#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require")
            .count(),
        1,
        "{output}"
    );
    assert!(output.contains("int16_t"), "{output}");
    assert!(output.contains("uint16_t"), "{output}");
}

fn write_glsl(
    source: &str,
    version: naga::back::glsl::Version,
    shader_stage: naga::ShaderStage,
) -> Result<String, naga::back::glsl::Error> {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT16,
    )
    .validate(&module)
    .unwrap();
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
        &module,
        &info,
        &options,
        &pipeline,
        naga::proc::BoundsCheckPolicies::default(),
    )?
    .write()?;
    Ok(output)
}

#[test]
fn glsl_integer16_minimum_desktop_version_has_a_legal_header() {
    let output = write_glsl(
        "enable wgpu_int16;
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let value = i16(index);
            return vec4<f32>(f32(value), 0.0, 0.0, 1.0);
        }",
        naga::back::glsl::Version::Desktop(140),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert_eq!(output.lines().next(), Some("#version 140"), "{output}");
    for (version, expected) in [
        (130, "130"),
        (140, "140"),
        (150, "150 core"),
        (450, "450 core"),
    ] {
        assert_eq!(
            naga::back::glsl::Version::Desktop(version).to_string(),
            expected
        );
    }
    let output = write_glsl(
        "@vertex fn main() -> @builtin(position) vec4<f32> { return vec4<f32>(0.0); }",
        naga::back::glsl::Version::Desktop(140),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert_eq!(output.lines().next(), Some("#version 140"), "{output}");
    assert!(!output.contains("GL_EXT_shader_explicit_arithmetic_types_int16"));
}

fn assert_integer16_extension(output: &str) {
    assert_eq!(
        output
            .matches("#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require")
            .count(),
        1,
        "{output}"
    );
    assert!(!output.contains("GL_EXT_shader_16bit_storage"), "{output}");
}

const INTEGER16_VERTEX: &str = "enable wgpu_int16;
    @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
        let signed_value = i16(index);
        let unsigned_value = u16(index);
        return vec4<f32>(f32(signed_value), f32(unsigned_value), 0.0, 1.0);
    }";

#[test]
fn glsl_integer16_extension_follows_supported_desktop_and_embedded_profiles() {
    use naga::back::glsl::Version;

    for version in [140, 150, 330, 400, 410, 420, 430, 440, 450, 460]
        .into_iter()
        .map(Version::Desktop)
        .chain([Version::new_gles(310), Version::new_gles(320)])
    {
        let output = write_glsl(INTEGER16_VERTEX, version, naga::ShaderStage::Vertex).unwrap();
        assert_integer16_extension(&output);
        assert!(output.contains("int16_t"), "{output}");
        assert!(output.contains("uint16_t"), "{output}");
    }
}

#[test]
fn glsl_integer16_rejects_versions_below_the_extension_requirements() {
    use naga::back::glsl::{Error, Features, Version};

    assert!(matches!(
        write_glsl(
            INTEGER16_VERTEX,
            Version::Desktop(130),
            naga::ShaderStage::Vertex
        ),
        Err(Error::VersionNotSupported)
    ));
    match write_glsl(
        INTEGER16_VERTEX,
        Version::new_gles(300),
        naga::ShaderStage::Vertex,
    ) {
        Err(Error::MissingFeatures(missing, version)) => {
            assert_eq!(missing, Features::INT16_TYPE);
            assert_eq!(version, Version::new_gles(300));
        }
        result => panic!("unexpected embedded integer16 version result: {result:?}"),
    }
}

#[test]
fn glsl_integer16_signed_and_unsigned_vectors_require_one_extension() {
    let source = "enable wgpu_int16;
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let signed_pair = vec2<i16>(i16(index));
            let signed_triple = vec3<i16>(i16(index));
            let signed_quad = vec4<i16>(i16(index));
            let unsigned_pair = vec2<u16>(u16(index));
            let unsigned_triple = vec3<u16>(u16(index));
            let unsigned_quad = vec4<u16>(u16(index));
            return vec4<f32>(
                f32(signed_pair.x) + f32(signed_triple.y) + f32(signed_quad.z),
                f32(unsigned_pair.x) + f32(unsigned_triple.y) + f32(unsigned_quad.z),
                0.0, 1.0);
        }";
    for version in [
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(310),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Vertex).unwrap();
        assert_integer16_extension(&output);
        for type_name in [
            "i16vec2", "i16vec3", "i16vec4", "u16vec2", "u16vec3", "u16vec4",
        ] {
            assert!(output.contains(type_name), "missing {type_name}\n{output}");
        }
    }
}

#[test]
fn glsl_integer16_functions_globals_and_aggregates_share_the_extension() {
    let source = "enable wgpu_int16;
        struct Record { signed_value: i16, unsigned_values: vec2<u16>, values: array<i16, 2> }
        var<private> saved: Record;
        fn increment(value: Record) -> Record {
            var result = value;
            result.signed_value += i16(1);
            return result;
        }
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let value = Record(i16(index), vec2<u16>(u16(index)), array<i16, 2>(i16(-1), i16(2)));
            saved = increment(value);
            return vec4<f32>(f32(saved.signed_value), f32(saved.unsigned_values.y), f32(saved.values[0]), 1.0);
        }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Vertex,
    )
    .unwrap();
    assert_integer16_extension(&output);
    assert!(output.contains("struct Record"), "{output}");
    assert!(output.contains("int16_t"), "{output}");
    assert!(output.contains("u16vec2"), "{output}");
    assert!(output.contains("increment("), "{output}");
}

#[test]
fn glsl_integer16_uniform_storage_and_workgroup_values_share_the_extension() {
    let source = "enable wgpu_int16;
        struct Parameters { @size(16) value: i16 }
        const Adjustment: i16 = i16(-1);
        var<private> initial: i16 = i16(2);
        @group(0) @binding(0) var<uniform> parameters: Parameters;
        @group(0) @binding(1) var<storage, read_write> output: array<i16>;
        var<workgroup> scratch: array<i16, 2>;
        @compute @workgroup_size(1) fn main() {
            scratch[0] = parameters.value + Adjustment + initial;
            workgroupBarrier();
            output[0] = scratch[0];
        }";
    for version in [
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(310),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Compute).unwrap();
        assert_integer16_extension(&output);
        assert!(output.contains("int16_t"), "{output}");
        assert!(output.contains("shared "), "{output}");
    }
}

#[test]
fn glsl_integer16_arithmetic_uses_integer16_scalar_and_vector_types() {
    let source = "enable wgpu_int16;
        @group(0) @binding(0) var<storage, read> input: array<vec4<i16>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec4<i16>>;
        @group(0) @binding(2) var<storage, read_write> unsigned_output: array<vec4<u16>>;
        fn divide(value: i16) -> i16 { return value / i16(3); }
        @compute @workgroup_size(1) fn main() {
            let value = input[0];
            output[0] = (value / vec4<i16>(i16(3))) % vec4<i16>(i16(2));
            output[1] = vec4<i16>(divide(value.x));
            let unsigned_value = vec4<u16>(value);
            unsigned_output[0] = (unsigned_value / vec4<u16>(u16(3))) % vec4<u16>(u16(2));
        }";
    let output = write_glsl(
        source,
        naga::back::glsl::Version::Desktop(450),
        naga::ShaderStage::Compute,
    )
    .unwrap();
    assert_integer16_extension(&output);
    for type_name in ["int16_t", "i16vec4", "uint16_t", "u16vec4"] {
        assert!(output.contains(type_name), "missing {type_name}\n{output}");
    }
}

#[test]
fn glsl_integer32_shaders_do_not_require_the_integer16_extension() {
    let source = "enable wgpu_int16;
        @vertex fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
            let signed_value = i32(index);
            let unsigned_value = vec2<u32>(index);
            return vec4<f32>(f32(signed_value), f32(unsigned_value.y), 0.0, 1.0);
        }";
    for version in [
        naga::back::glsl::Version::Desktop(140),
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(300),
        naga::back::glsl::Version::new_gles(310),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Vertex).unwrap();
        assert!(
            !output.contains("GL_EXT_shader_explicit_arithmetic_types_int16"),
            "{output}"
        );
        assert!(!output.contains("GL_EXT_shader_16bit_storage"), "{output}");
        assert!(!output.contains("int16_t"), "{output}");
    }
}

#[test]
fn glsl_integer16_zero_initialized_arrays_use_explicit_element_types() {
    let source = "enable wgpu_int16;
        var<private> signed_private: array<i16, 2>;
        var<private> unsigned_private: array<u16, 2>;
        var<workgroup> signed_shared: array<i16, 2>;
        var<workgroup> unsigned_shared: array<u16, 2>;
        @group(0) @binding(0) var<storage, read_write> output: array<u32>;
        @compute @workgroup_size(1) fn main() {
            var signed_local: array<i16, 2>;
            var unsigned_local: array<u16, 2>;
            workgroupBarrier();
            output[0] = u32(signed_private[0]) + u32(signed_shared[0]) + u32(signed_local[0]);
            output[1] = u32(unsigned_private[0]) + u32(unsigned_shared[0]) + u32(unsigned_local[0]);
        }";
    for version in [
        naga::back::glsl::Version::Desktop(450),
        naga::back::glsl::Version::new_gles(310),
    ] {
        let output = write_glsl(source, version, naga::ShaderStage::Compute).unwrap();
        assert_integer16_extension(&output);
        for constructor in [
            "int16_t[2](int16_t(0), int16_t(0))",
            "uint16_t[2](uint16_t(0), uint16_t(0))",
        ] {
            assert_eq!(output.matches(constructor).count(), 3, "{output}");
        }
    }
}
