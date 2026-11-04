#![cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]

use naga::valid::{Capabilities, ValidationFlags, Validator};

fn check_compacted_expression_types(
    type_name: &str,
    scalar: naga::Scalar,
    extension: &str,
    capabilities: Capabilities,
) {
    for initializer in ["7.0", "input[0]"] {
        for helper in [false, true] {
            let body = format!("let narrowed = {type_name}({initializer}); return i32(narrowed);");
            let function = if helper {
                format!("fn convert() -> i32 {{ {body} }}")
            } else {
                String::new()
            };
            let entry_body = if helper {
                String::from("output[0] = convert();")
            } else {
                format!("let narrowed = {type_name}({initializer}); output[0] = i32(narrowed);")
            };
            let source = format!(
                "enable {extension};
                @group(0) @binding(0) var<storage> input: array<f32>;
                @group(0) @binding(1) var<storage, read_write> output: array<i32>;
                {function}
                @compute @workgroup_size(1) fn main() {{ {entry_body} }}"
            );
            let mut module = naga::front::wgsl::parse_str(&source).unwrap();
            Validator::new(ValidationFlags::all(), capabilities)
                .validate(&module)
                .unwrap();
            naga::compact::compact(&mut module, naga::compact::KeepUnused::Yes);
            assert!(module
                .types
                .iter()
                .all(|(_, ty)| ty.inner.scalar() != Some(scalar)));
            let info = Validator::new(ValidationFlags::all(), capabilities)
                .validate(&module)
                .unwrap();
            let output = naga::back::wgsl::write_string(
                &module,
                &info,
                naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
            )
            .unwrap();
            assert_eq!(
                output.matches(&format!("enable {extension};")).count(),
                1,
                "{output}"
            );
            let reparsed = naga::front::wgsl::parse_str(&output)
                .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&output)));
            Validator::new(ValidationFlags::all(), capabilities)
                .validate(&reparsed)
                .unwrap();
        }
    }
}

#[test]
fn wgsl_writer_enables_narrow_integer_expression_types_after_compaction() {
    for (name, scalar) in [("i16", naga::Scalar::I16), ("u16", naga::Scalar::U16)] {
        check_compacted_expression_types(name, scalar, "wgpu_int16", Capabilities::SHADER_INT16);
    }
}

#[test]
fn wgsl_writer_enables_half_expression_types_after_compaction() {
    check_compacted_expression_types(
        "f16",
        naga::Scalar::F16,
        "f16",
        Capabilities::SHADER_FLOAT16,
    );
}

#[test]
fn wgsl_writer_enables_cross_kind_narrow_bitcasts_after_compaction() {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_FLOAT16;
    for (input_scalar, target_scalar, output_scalar, target) in [
        ("u16", "f16", "f32", naga::Scalar::F16),
        ("f16", "u16", "i32", naga::Scalar::U16),
    ] {
        for components in [1, 2, 4] {
            let value_type = |scalar: &str| {
                if components == 1 {
                    scalar.to_owned()
                } else {
                    format!("vec{components}<{scalar}>")
                }
            };
            let input_type = value_type(input_scalar);
            let target_type = value_type(target_scalar);
            let output_type = value_type(output_scalar);
            for helper in [false, true] {
                let expression = format!("{output_type}(bitcast<{target_type}>(input[0]))");
                let function = if helper {
                    format!("fn convert() -> {output_type} {{ return {expression}; }}")
                } else {
                    String::new()
                };
                let entry_value = if helper {
                    String::from("convert()")
                } else {
                    expression
                };
                let source = format!(
                    "enable f16;
                    enable wgpu_int16;
                    @group(0) @binding(0) var<storage> input: array<{input_type}>;
                    @group(0) @binding(1) var<storage, read_write> output: array<{output_type}>;
                    {function}
                    @compute @workgroup_size(1) fn main() {{ output[0] = {entry_value}; }}"
                );
                let mut module = naga::front::wgsl::parse_str(&source).unwrap();
                let mut validator = Validator::new(ValidationFlags::all(), capabilities);
                validator.validate(&module).unwrap();
                naga::compact::compact(&mut module, naga::compact::KeepUnused::Yes);
                assert!(module
                    .types
                    .iter()
                    .all(|(_, ty)| ty.inner.scalar() != Some(target)));
                let info = validator.validate(&module).unwrap();
                let output = naga::back::wgsl::write_string(
                    &module,
                    &info,
                    naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
                )
                .unwrap();
                for extension in ["f16", "wgpu_int16"] {
                    assert_eq!(
                        output.matches(&format!("enable {extension};")).count(),
                        1,
                        "{source}\n{output}"
                    );
                }
                let reparsed = naga::front::wgsl::parse_str(&output)
                    .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&output)));
                validator.validate(&reparsed).unwrap();
            }
        }
    }
}
