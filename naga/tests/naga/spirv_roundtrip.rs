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

fn integer_conversion_roundtrip(
    source_scalar: naga::Scalar,
    target_scalar: naga::Scalar,
    vector: bool,
) {
    use rspirv::dr::Operand;
    use spirv::Op;

    let type_name = |scalar: naga::Scalar| {
        let prefix = match scalar.kind {
            naga::ScalarKind::Sint => "i",
            naga::ScalarKind::Uint => "u",
            _ => unreachable!(),
        };
        let scalar_name = format!("{prefix}{}", scalar.width * 8);
        if vector {
            format!("vec2<{scalar_name}>")
        } else {
            scalar_name
        }
    };
    let source_type = type_name(source_scalar);
    let target_type = type_name(target_scalar);
    let mut capabilities = naga::valid::Capabilities::empty();
    let header = if [source_scalar.width, target_scalar.width].contains(&2) {
        capabilities |= naga::valid::Capabilities::SHADER_INT16;
        "enable wgpu_int16;"
    } else {
        ""
    };
    if [source_scalar.width, target_scalar.width].contains(&8) {
        capabilities |= naga::valid::Capabilities::SHADER_INT64;
    }
    let source = format!(
        "{header}
        @group(0) @binding(0) var<storage> input: array<{source_type}>;
        @group(0) @binding(1) var<storage, read_write> output: array<{target_type}>;
        @compute @workgroup_size(1) fn main() {{ output[0] = {target_type}(input[0]); }}"
    );
    let module = naga::front::wgsl::parse_str(&source).unwrap();
    let mut validator =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities);
    let info = validator.validate(&module).unwrap();
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: "main".to_owned(),
        shader_stage: naga::ShaderStage::Compute,
    };
    let options = naga::back::spv::Options {
        use_storage_input_output_16: false,
        ..Default::default()
    };
    let words = naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
    super::helpers::validate_spirv(&words);
    let instructions = rspirv::dr::load_words(&words).unwrap();
    let conversions: Vec<_> = instructions
        .functions
        .iter()
        .flat_map(|function| &function.blocks)
        .flat_map(|block| &block.instructions)
        .filter(|instruction| matches!(instruction.class.opcode, Op::SConvert | Op::UConvert))
        .collect();
    assert_eq!(conversions.len(), 1, "{source_type} to {target_type}");
    let conversion = conversions[0];
    let expected_operation = if source_scalar.kind == naga::ScalarKind::Sint {
        Op::SConvert
    } else {
        Op::UConvert
    };
    assert_eq!(
        conversion.class.opcode, expected_operation,
        "{source_type} to {target_type}"
    );
    let integer_type = |type_id| {
        let mut result_type = instructions
            .types_global_values
            .iter()
            .find(|instruction| instruction.result_id == Some(type_id))
            .unwrap();
        if vector {
            assert_eq!(result_type.class.opcode, Op::TypeVector);
            assert_eq!(result_type.operands[1], Operand::LiteralBit32(2));
            let component = match result_type.operands.first() {
                Some(Operand::IdRef(component)) => *component,
                _ => panic!("vector component type"),
            };
            result_type = instructions
                .types_global_values
                .iter()
                .find(|instruction| instruction.result_id == Some(component))
                .unwrap();
        }
        assert_eq!(result_type.class.opcode, Op::TypeInt);
        assert_eq!(
            result_type.operands[0],
            Operand::LiteralBit32(u32::from(target_scalar.width) * 8)
        );
        result_type
    };
    let result_type = integer_type(conversion.result_type.unwrap());
    if expected_operation == Op::UConvert {
        assert_eq!(result_type.operands[1], Operand::LiteralBit32(0));
    }
    if source_scalar.kind == naga::ScalarKind::Uint && target_scalar.kind == naga::ScalarKind::Sint
    {
        let bitcast = instructions
            .functions
            .iter()
            .flat_map(|function| &function.blocks)
            .flat_map(|block| &block.instructions)
            .find(|instruction| {
                instruction.class.opcode == Op::Bitcast
                    && instruction.operands == [Operand::IdRef(conversion.result_id.unwrap())]
            })
            .unwrap();
        let signed_type = integer_type(bitcast.result_type.unwrap());
        assert_eq!(signed_type.operands[1], Operand::LiteralBit32(1));
    }
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
}

#[test]
fn integer_width_conversions_preserve_source_signedness_in_spirv() {
    use naga::ScalarKind::{Sint, Uint};

    for (source_width, target_width) in [(2, 4), (4, 2), (4, 8), (8, 4)] {
        for (source_kind, target_kind) in [(Sint, Sint), (Sint, Uint), (Uint, Sint), (Uint, Uint)] {
            for vector in [false, true] {
                integer_conversion_roundtrip(
                    naga::Scalar {
                        kind: source_kind,
                        width: source_width,
                    },
                    naga::Scalar {
                        kind: target_kind,
                        width: target_width,
                    },
                    vector,
                );
            }
        }
    }
}

#[test]
fn boolean_scalar_and_vector_operations_preserve_eager_operands_in_spirv() {
    fn root_calls(
        body: &naga::Block,
        targets: &[naga::Handle<naga::Function>],
        output: &mut Vec<naga::Handle<naga::Function>>,
    ) {
        for statement in body {
            match *statement {
                naga::Statement::Block(ref body) => root_calls(body, targets, output),
                naga::Statement::Call { function, .. } if targets.contains(&function) => {
                    output.push(function)
                }
                _ => {}
            }
        }
    }

    for components in [1, 2, 3, 4] {
        let numeric_type = if components == 1 {
            String::from("u32")
        } else {
            format!("vec{components}<u32>")
        };
        let boolean_type = if components == 1 {
            String::from("bool")
        } else {
            format!("vec{components}<bool>")
        };
        let source = format!(
            "
            @group(0) @binding(0) var<storage> input: array<{numeric_type}>;
            @group(0) @binding(1) var<storage, read_write> output: array<{numeric_type}>;
            fn observe_left(value: {numeric_type}) -> {boolean_type} {{
                output[2] += {numeric_type}(1u);
                return value != {numeric_type}(0u);
            }}
            fn observe_right(value: {numeric_type}) -> {boolean_type} {{
                output[3] += {numeric_type}(1u);
                return value != {numeric_type}(0u);
            }}
            @compute @workgroup_size(1) fn main() {{
                let left_value = observe_left(input[0]);
                let right_value = observe_right(input[1]);
                let conjunction = left_value & right_value;
                let disjunction = left_value | right_value;
                output[0] = select({numeric_type}(0u), {numeric_type}(1u), conjunction);
                output[1] = select({numeric_type}(0u), {numeric_type}(1u), disjunction);
            }}"
        );
        let module = naga::front::wgsl::parse_str(&source)
            .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
        let mut validator = naga::valid::Validator::new(
            naga::valid::ValidationFlags::all(),
            naga::valid::Capabilities::empty(),
        );
        let info = validator.validate(&module).unwrap();
        let options = naga::back::spv::Options {
            flags: naga::back::spv::Options::default().flags | naga::back::spv::WriterFlags::DEBUG,
            ..Default::default()
        };
        let pipeline = naga::back::spv::PipelineOptions {
            entry_point: String::from("main"),
            shader_stage: naga::ShaderStage::Compute,
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
        let targets: Vec<_> = ["observe_left", "observe_right"]
            .into_iter()
            .map(|name| {
                parsed
                    .functions
                    .iter()
                    .find_map(|(handle, function)| {
                        (function.name.as_deref() == Some(name)).then_some(handle)
                    })
                    .unwrap()
            })
            .collect();
        let functions = parsed
            .functions
            .iter()
            .map(|(handle, function)| (function, &parsed_info[handle]))
            .chain(
                parsed
                    .entry_points
                    .iter()
                    .enumerate()
                    .map(|(index, entry)| (&entry.function, parsed_info.get_entry_point(index))),
            );
        let mut matching_functions = 0;
        for (function, info) in functions {
            let mut calls = Vec::new();
            root_calls(&function.body, &targets, &mut calls);
            if calls != targets {
                continue;
            }
            matching_functions += 1;
            let expected_type = if components == 1 {
                naga::TypeInner::Scalar(naga::Scalar::BOOL)
            } else {
                let size = match components {
                    2 => naga::VectorSize::Bi,
                    3 => naga::VectorSize::Tri,
                    4 => naga::VectorSize::Quad,
                    _ => unreachable!(),
                };
                naga::TypeInner::Vector {
                    size,
                    scalar: naga::Scalar::BOOL,
                }
            };
            let expected_operators = if components == 1 {
                [
                    naga::BinaryOperator::LogicalAnd,
                    naga::BinaryOperator::LogicalOr,
                ]
            } else {
                [naga::BinaryOperator::And, naga::BinaryOperator::InclusiveOr]
            };
            for expected in expected_operators {
                assert!(
                    function.expressions.iter().any(|(handle, expression)| {
                        matches!(*expression, naga::Expression::Binary { op, .. } if op == expected)
                            && *info[handle].ty.inner_with(&parsed.types) == expected_type
                    }),
                    "missing {components}-component {expected:?}"
                );
            }
        }
        assert_eq!(
            matching_functions, 1,
            "operands must both be captured once before the eager boolean operations"
        );
        let rewritten =
            naga::back::spv::write_vec(&parsed, &parsed_info, &options, Some(&pipeline)).unwrap();
        super::helpers::validate_spirv(&rewritten);
    }
}

#[cfg(feature = "wgsl-out")]
#[test]
fn vector_integer_division_and_remainder_roundtrip_through_spirv_and_wgsl() {
    for scalar in ["i32", "i64"] {
        for components in [2, 3, 4] {
            let value_type = format!("vec{components}<{scalar}>");
            let minimum = if scalar == "i64" {
                "(-9223372036854775807li - 1li)"
            } else {
                "(-2147483647i - 1i)"
            };
            let source = format!(
                "
                @group(0) @binding(0) var<storage> input: array<{value_type}>;
                @group(0) @binding(1) var<storage, read_write> output: array<{value_type}>;
                @compute @workgroup_size(1) fn main() {{
                    let numerator = input[0];
                    let denominator = input[1];
                    output[0] = numerator / denominator;
                    output[1] = numerator % denominator;
                    output[2] = {value_type}({minimum}) / (denominator & {value_type}(0));
                    output[3] = {value_type}({minimum}) % (denominator | {value_type}(-1));
                }}"
            );
            let capabilities = if scalar == "i64" {
                naga::valid::Capabilities::SHADER_INT64
            } else {
                naga::valid::Capabilities::empty()
            };
            let module = naga::front::wgsl::parse_str(&source)
                .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
            let mut validator =
                naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities);
            let info = validator.validate(&module).unwrap();
            let pipeline = naga::back::spv::PipelineOptions {
                entry_point: String::from("main"),
                shader_stage: naga::ShaderStage::Compute,
            };
            let options = naga::back::spv::Options::default();
            let words =
                naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
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
            let wgsl = naga::back::wgsl::write_string(
                &parsed,
                &parsed_info,
                naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
            )
            .unwrap();
            let reparsed = naga::front::wgsl::parse_str(&wgsl)
                .unwrap_or_else(|error| panic!("{}\n{wgsl}", error.emit_to_string(&wgsl)));
            let reparsed_info = validator.validate(&reparsed).unwrap();
            let pipeline = naga::back::spv::PipelineOptions {
                entry_point: reparsed.entry_points[0].name.clone(),
                shader_stage: naga::ShaderStage::Compute,
            };
            let rewritten =
                naga::back::spv::write_vec(&reparsed, &reparsed_info, &options, Some(&pipeline))
                    .unwrap();
            super::helpers::validate_spirv(&rewritten);
        }
    }
}

#[test]
fn spirv_logical_vectors_reject_mismatched_operand_and_result_types() {
    use rspirv::{binary::Assemble, dr::Operand};
    use spirv::Op;

    let source = "
        @group(0) @binding(0) var<storage> input: array<vec3<u32>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec3<u32>>;
        @compute @workgroup_size(1) fn main() {
            let left = input[0].xy != vec2<u32>(17u, 23u);
            let right = input[1].xy != vec2<u32>(29u, 31u);
            let both = left & right;
            let either = left | right;
            let triple = input[0] != vec3<u32>(0u);
            output[0] = select(vec3<u32>(0u), vec3<u32>(1u), triple);
            output[1].x = select(0u, 1u, both.x);
            output[1].y = select(0u, 1u, either.y);
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let mut validator = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    );
    let info = validator.validate(&module).unwrap();
    let options = naga::back::spv::Options::default();
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: String::from("main"),
        shader_stage: naga::ShaderStage::Compute,
    };
    let words = naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
    super::helpers::validate_spirv(&words);
    let instructions = rspirv::dr::load_words(&words).unwrap();
    let boolean = instructions
        .types_global_values
        .iter()
        .find(|instruction| instruction.class.opcode == Op::TypeBool)
        .unwrap()
        .result_id
        .unwrap();
    let unsigned = instructions
        .types_global_values
        .iter()
        .find(|instruction| {
            instruction.class.opcode == Op::TypeInt
                && instruction.operands == [Operand::LiteralBit32(32), Operand::LiteralBit32(0)]
        })
        .unwrap()
        .result_id
        .unwrap();
    let vector_type = |component, size| {
        instructions
            .types_global_values
            .iter()
            .find(|instruction| {
                instruction.class.opcode == Op::TypeVector
                    && instruction.operands
                        == [Operand::IdRef(component), Operand::LiteralBit32(size)]
            })
            .unwrap()
            .result_id
            .unwrap()
    };
    let boolean_pair = vector_type(boolean, 2);
    let boolean_triple = vector_type(boolean, 3);
    let unsigned_pair = vector_type(unsigned, 2);
    let integer_value = instructions
        .types_global_values
        .iter()
        .find(|instruction| {
            instruction.result_type == Some(unsigned_pair)
                && matches!(
                    instruction.class.opcode,
                    Op::ConstantComposite | Op::ConstantNull
                )
        })
        .unwrap()
        .result_id
        .unwrap();

    for operation in [Op::LogicalAnd, Op::LogicalOr] {
        let mut location = None;
        for (function_index, function) in instructions.functions.iter().enumerate() {
            for (block_index, block) in function.blocks.iter().enumerate() {
                if let Some(instruction_index) = block.instructions.iter().position(|instruction| {
                    instruction.class.opcode == operation
                        && instruction.result_type == Some(boolean_pair)
                }) {
                    location = Some((function_index, block_index, instruction_index));
                }
            }
        }
        let (function_index, block_index, instruction_index) = location.unwrap();
        let mut valid_unused = instructions.clone();
        let unused_result = valid_unused.header.as_ref().unwrap().bound;
        valid_unused.header.as_mut().unwrap().bound += 1;
        let block = &mut valid_unused.functions[function_index].blocks[block_index];
        let mut duplicate = block.instructions[instruction_index].clone();
        duplicate.result_id = Some(unused_result);
        block.instructions.insert(instruction_index + 1, duplicate);
        super::helpers::validate_spirv(&valid_unused.assemble());

        for mismatch in [
            "integer_operands",
            "integer_result",
            "different_boolean_size",
        ] {
            let mut malformed = valid_unused.clone();
            let instruction = &mut malformed.functions[function_index].blocks[block_index]
                .instructions[instruction_index + 1];
            match mismatch {
                "integer_operands" => {
                    instruction.operands =
                        vec![Operand::IdRef(integer_value), Operand::IdRef(integer_value)]
                }
                "integer_result" => instruction.result_type = Some(unsigned_pair),
                "different_boolean_size" => instruction.result_type = Some(boolean_triple),
                _ => unreachable!(),
            }
            let result = naga::front::spv::parse_u8_slice(
                &words_to_bytes(&malformed.assemble()),
                &naga::front::spv::Options {
                    adjust_coordinate_space: false,
                    strict_capabilities: true,
                    block_ctx_dump_prefix: None,
                },
            );
            if let Ok(parsed) = result {
                assert!(
                    validator.validate(&parsed).is_err(),
                    "accepted {operation:?} with {mismatch}"
                );
            }
        }
    }
}
