#![cfg(all(feature = "wgsl-in", feature = "spv-in", feature = "spv-out"))]

use naga::valid::{Capabilities, ValidationFlags, Validator};

fn assert_native_bit_search_widths(words: &[u32]) {
    use rspirv::dr::Operand;
    use spirv::{GlslStd450Op, Op};

    let instructions = rspirv::dr::load_words(words).unwrap();
    let glsl_set = instructions
        .ext_inst_imports
        .iter()
        .find(|instruction| {
            instruction.operands == [Operand::LiteralString(String::from("GLSL.std.450"))]
        })
        .unwrap()
        .result_id
        .unwrap();
    let integer_width = |type_id| {
        let mut ty = instructions
            .types_global_values
            .iter()
            .find(|instruction| instruction.result_id == Some(type_id))
            .unwrap();
        if ty.class.opcode == Op::TypeVector {
            let Operand::IdRef(component) = ty.operands[0] else {
                panic!("missing vector component type")
            };
            ty = instructions
                .types_global_values
                .iter()
                .find(|instruction| instruction.result_id == Some(component))
                .unwrap();
        }
        assert_eq!(ty.class.opcode, Op::TypeInt);
        let Operand::LiteralBit32(width) = ty.operands[0] else {
            panic!("missing integer width")
        };
        width
    };
    for instruction in instructions.all_inst_iter() {
        if instruction.class.opcode != Op::ExtInst {
            continue;
        }
        let [Operand::IdRef(set), Operand::LiteralExtInstInteger(operation), Operand::IdRef(argument)] =
            instruction.operands.as_slice()
        else {
            continue;
        };
        if *set != glsl_set
            || ![
                GlslStd450Op::FindILsb as u32,
                GlslStd450Op::FindSMsb as u32,
                GlslStd450Op::FindUMsb as u32,
            ]
            .contains(operation)
        {
            continue;
        }
        let argument_type = instructions
            .all_inst_iter()
            .find(|candidate| candidate.result_id == Some(*argument))
            .unwrap()
            .result_type
            .unwrap();
        assert_eq!(
            integer_width(argument_type),
            32,
            "GLSL.std.450 Find* input must be 32-bit"
        );
        assert_eq!(
            integer_width(instruction.result_type.unwrap()),
            32,
            "GLSL.std.450 Find* result must be 32-bit"
        );
    }
}

fn bit_search_roundtrip(scalar: &str, components: usize, operation: naga::MathFunction) {
    let (capabilities, enable, high_bit, all_bits) = match scalar {
        "i16" => (
            Capabilities::SHADER_INT16,
            "enable wgpu_int16;",
            "i16(-32768)",
            "i16(-1)",
        ),
        "u16" => (
            Capabilities::SHADER_INT16,
            "enable wgpu_int16;",
            "u16(32768)",
            "u16(65535)",
        ),
        "i32" => (Capabilities::empty(), "", "(-2147483647i - 1i)", "-1i"),
        "u32" => (Capabilities::empty(), "", "2147483648u", "4294967295u"),
        "i64" => (
            Capabilities::SHADER_INT64,
            "",
            "(-9223372036854775807li - 1li)",
            "-1li",
        ),
        "u64" => (
            Capabilities::SHADER_INT64,
            "",
            "9223372036854775808lu",
            "18446744073709551615lu",
        ),
        _ => unreachable!(),
    };
    let function_name = match operation {
        naga::MathFunction::CountLeadingZeros => "countLeadingZeros",
        naga::MathFunction::CountTrailingZeros => "countTrailingZeros",
        naga::MathFunction::FirstLeadingBit => "firstLeadingBit",
        naga::MathFunction::FirstTrailingBit => "firstTrailingBit",
        _ => unreachable!(),
    };
    let value_type = if components == 1 {
        scalar.to_owned()
    } else {
        format!("vec{components}<{scalar}>")
    };
    let source = format!(
        "{enable}
        @group(0) @binding(0) var<storage> input: array<{value_type}>;
        @group(0) @binding(1) var<storage, read_write> output: array<{value_type}>;
        @compute @workgroup_size(1) fn main() {{
            let value = input[0];
            output[0] = {function_name}(value);
            output[1] = {function_name}(value & {value_type}(0));
            output[2] = {function_name}(value | {value_type}({high_bit}));
            output[3] = {function_name}(value | {value_type}(1));
            output[4] = {function_name}(value | {value_type}({all_bits}));
        }}"
    );
    let module = naga::front::wgsl::parse_str(&source)
        .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
    let mut validator = Validator::new(ValidationFlags::all(), capabilities);
    let info = validator.validate(&module).unwrap();
    let function = &module.entry_points[0].function;
    let function_info = info.get_entry_point(0);
    let input_type = function
        .expressions
        .iter()
        .find_map(|(handle, expression)| {
            matches!(*expression, naga::Expression::Math { fun, .. } if fun == operation)
                .then_some(function_info[handle].ty.inner_with(&module.types).clone())
        })
        .unwrap();
    let expected_scalar = match scalar {
        "i16" => naga::Scalar::I16,
        "u16" => naga::Scalar::U16,
        "i32" => naga::Scalar::I32,
        "u32" => naga::Scalar::U32,
        "i64" => naga::Scalar::I64,
        "u64" => naga::Scalar::U64,
        _ => unreachable!(),
    };
    assert_eq!(input_type.scalar(), Some(expected_scalar));
    let mut result_count = 0;
    for (handle, expression) in function.expressions.iter() {
        if matches!(*expression, naga::Expression::Math { fun, .. } if fun == operation) {
            assert_eq!(
                function_info[handle].ty.inner_with(&module.types),
                &input_type
            );
            result_count += 1;
        }
    }
    assert_eq!(result_count, 5);
    let options = naga::back::spv::Options {
        use_storage_input_output_16: false,
        ..Default::default()
    };
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: String::from("main"),
        shader_stage: naga::ShaderStage::Compute,
    };
    let words = naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
    assert_native_bit_search_widths(&words);
    super::helpers::validate_spirv(&words);
    let bytes: Vec<_> = words.iter().flat_map(|word| word.to_le_bytes()).collect();
    let parsed = naga::front::spv::parse_u8_slice(
        &bytes,
        &naga::front::spv::Options {
            adjust_coordinate_space: false,
            strict_capabilities: true,
            block_ctx_dump_prefix: None,
        },
    )
    .unwrap();
    let parsed_info = validator.validate(&parsed).unwrap();
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: parsed.entry_points[0].name.clone(),
        shader_stage: naga::ShaderStage::Compute,
    };
    let rewritten =
        naga::back::spv::write_vec(&parsed, &parsed_info, &options, Some(&pipeline)).unwrap();
    assert_native_bit_search_widths(&rewritten);
    super::helpers::validate_spirv(&rewritten);
    #[cfg(feature = "wgsl-out")]
    {
        let output = naga::back::wgsl::write_string(
            &parsed,
            &parsed_info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        )
        .unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output)
            .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
        let reparsed_info = validator.validate(&reparsed).unwrap();
        let pipeline = naga::back::spv::PipelineOptions {
            entry_point: reparsed.entry_points[0].name.clone(),
            shader_stage: naga::ShaderStage::Compute,
        };
        let rewritten =
            naga::back::spv::write_vec(&reparsed, &reparsed_info, &options, Some(&pipeline))
                .unwrap();
        assert_native_bit_search_widths(&rewritten);
        super::helpers::validate_spirv(&rewritten);
    }
}

fn integer64_bit_search_roundtrip(operation: naga::MathFunction) {
    for scalar in ["i64", "u64"] {
        for components in [1, 2, 3, 4] {
            bit_search_roundtrip(scalar, components, operation);
        }
    }
}

#[test]
fn integer64_count_leading_zeros_roundtrips_through_spirv() {
    integer64_bit_search_roundtrip(naga::MathFunction::CountLeadingZeros);
}

#[test]
fn integer64_count_trailing_zeros_roundtrips_through_spirv() {
    integer64_bit_search_roundtrip(naga::MathFunction::CountTrailingZeros);
}

#[test]
fn integer64_first_leading_bit_roundtrips_through_spirv() {
    integer64_bit_search_roundtrip(naga::MathFunction::FirstLeadingBit);
}

#[test]
fn integer64_first_trailing_bit_roundtrips_through_spirv() {
    integer64_bit_search_roundtrip(naga::MathFunction::FirstTrailingBit);
}

#[test]
fn integer16_bit_searches_preserve_result_widths_through_spirv() {
    for operation in [
        naga::MathFunction::CountLeadingZeros,
        naga::MathFunction::CountTrailingZeros,
        naga::MathFunction::FirstLeadingBit,
        naga::MathFunction::FirstTrailingBit,
    ] {
        for scalar in ["i16", "u16"] {
            for components in [1, 2, 3, 4] {
                bit_search_roundtrip(scalar, components, operation);
            }
        }
    }
}

#[test]
fn integer32_bit_searches_remain_valid_through_spirv() {
    for operation in [
        naga::MathFunction::CountLeadingZeros,
        naga::MathFunction::CountTrailingZeros,
        naga::MathFunction::FirstLeadingBit,
        naga::MathFunction::FirstTrailingBit,
    ] {
        for scalar in ["i32", "u32"] {
            for components in [1, 2, 3, 4] {
                bit_search_roundtrip(scalar, components, operation);
            }
        }
    }
}

#[test]
fn integer64_vector_bit_search_shifts_keep_full_width_counts_for_cross() {
    use rspirv::dr::Operand;
    use spirv::Op;

    let source = "
        @group(0) @binding(0) var<storage> input: array<vec2<u64>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec2<u64>>;
        @compute @workgroup_size(1) fn main() {
            output[0] = countLeadingZeros(input[0]);
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = Validator::new(ValidationFlags::all(), Capabilities::SHADER_INT64)
        .validate(&module)
        .unwrap();
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: String::from("main"),
        shader_stage: naga::ShaderStage::Compute,
    };
    let words = naga::back::spv::write_vec(
        &module,
        &info,
        &naga::back::spv::Options::default(),
        Some(&pipeline),
    )
    .unwrap();
    super::helpers::validate_spirv(&words);
    let instructions = rspirv::dr::load_words(&words).unwrap();
    let shift = instructions
        .all_inst_iter()
        .find(|instruction| instruction.class.opcode == Op::ShiftRightLogical)
        .unwrap();
    let [Operand::IdRef(base), Operand::IdRef(count)] = shift.operands.as_slice() else {
        panic!("missing vector shift operands")
    };
    for operand in [*base, *count] {
        let definition = instructions
            .all_inst_iter()
            .find(|instruction| instruction.result_id == Some(operand))
            .unwrap();
        assert_eq!(
            definition.result_type, shift.result_type,
            "64-bit vector word shifts need full-width counts for SPIRV-Cross interoperability"
        );
    }
    let vector = instructions
        .types_global_values
        .iter()
        .find(|instruction| instruction.result_id == shift.result_type)
        .unwrap();
    assert_eq!(vector.class.opcode, Op::TypeVector);
    assert_eq!(vector.operands[1], Operand::LiteralBit32(2));
    let Operand::IdRef(component) = vector.operands[0] else {
        panic!("missing vector component")
    };
    let scalar = instructions
        .types_global_values
        .iter()
        .find(|instruction| instruction.result_id == Some(component))
        .unwrap();
    assert_eq!(scalar.class.opcode, Op::TypeInt);
    assert_eq!(
        scalar.operands,
        [Operand::LiteralBit32(64), Operand::LiteralBit32(0)]
    );
}
