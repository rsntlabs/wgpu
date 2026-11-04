#![cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]

use naga::valid::{Capabilities, ValidationFlags, Validator};

fn check_unsigned_shift_count_roundtrip(count_width: u8) {
    for (scalar_name, scalar) in [
        ("i16", naga::Scalar::I16),
        ("u16", naga::Scalar::U16),
        ("i32", naga::Scalar::I32),
        ("u32", naga::Scalar::U32),
        ("i64", naga::Scalar::I64),
        ("u64", naga::Scalar::U64),
    ] {
        for components in [1, 2, 3, 4] {
            let value_type = if components == 1 {
                scalar_name.to_owned()
            } else {
                format!("vec{components}<{scalar_name}>")
            };
            let count_scalar = format!("u{}", count_width * 8);
            let count_type = if components == 1 {
                count_scalar
            } else {
                format!("vec{components}<{count_scalar}>")
            };
            let baseline_count_type = if components == 1 {
                String::from("u32")
            } else {
                format!("vec{components}<u32>")
            };
            let mut capabilities = Capabilities::empty();
            let enable = if scalar.width == 2 || count_width == 2 {
                capabilities |= Capabilities::SHADER_INT16;
                "enable wgpu_int16;"
            } else {
                ""
            };
            if scalar.width == 8 || count_width == 8 {
                capabilities |= Capabilities::SHADER_INT64;
            }
            for (operator, expected_operator) in [
                ("<<", naga::BinaryOperator::ShiftLeft),
                (">>", naga::BinaryOperator::ShiftRight),
            ] {
                let source = format!(
                    "{enable}
                    @group(0) @binding(0) var<storage> input: array<{value_type}>;
                    @group(0) @binding(1) var<storage> counts: array<{count_type}>;
                    @group(0) @binding(2) var<storage, read_write> output: array<{value_type}>;
                    @group(0) @binding(3) var<storage, read_write> observations: array<u32>;
                    fn read_count() -> {count_type} {{
                        observations[0] += 1u;
                        return counts[0];
                    }}
                    @compute @workgroup_size(1) fn main() {{
                        let value = input[0];
                        let shift_count = {baseline_count_type}(read_count());
                        output[0] = value {operator} shift_count;
                    }}"
                );
                let mut module = naga::front::wgsl::parse_str(&source)
                    .unwrap_or_else(|error| panic!("{}", error.emit_to_string(&source)));
                let mut validator = Validator::new(ValidationFlags::all(), capabilities);
                validator.validate(&module).unwrap();
                let function = &mut module.entry_points[0].function;
                let count = function
                    .named_expressions
                    .iter()
                    .find_map(|(&handle, name)| (name == "shift_count").then_some(handle))
                    .unwrap();
                match function.expressions[count] {
                    naga::Expression::As {
                        kind: naga::ScalarKind::Uint,
                        ref mut convert,
                        ..
                    } => {
                        assert_eq!(*convert, Some(4));
                        *convert = Some(count_width);
                    }
                    ref expression => panic!("unexpected shift count {expression:?}"),
                }
                let info = validator.validate(&module).unwrap();
                assert_eq!(
                    info.get_entry_point(0)[count]
                        .ty
                        .inner_with(&module.types)
                        .scalar(),
                    Some(naga::Scalar {
                        kind: naga::ScalarKind::Uint,
                        width: count_width
                    })
                );
                for flags in [
                    naga::back::wgsl::WriterFlags::empty(),
                    naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
                ] {
                    let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
                    assert!(
                        output.contains(&format!("{baseline_count_type}(")),
                        "{output}"
                    );
                    let reparsed = naga::front::wgsl::parse_str(&output).unwrap_or_else(|error| {
                        panic!("{}\n{output}", error.emit_to_string(&output))
                    });
                    let reparsed_info = validator.validate(&reparsed).unwrap();
                    let function = &reparsed.entry_points[0].function;
                    let function_info = reparsed_info.get_entry_point(0);
                    let mut shifts = 0;
                    for (handle, expression) in function.expressions.iter() {
                        if let naga::Expression::Binary { op, left, right } = *expression {
                            if op != expected_operator {
                                continue;
                            }
                            shifts += 1;
                            assert_eq!(
                                function_info[left].ty.inner_with(&reparsed.types).scalar(),
                                Some(scalar)
                            );
                            assert_eq!(
                                function_info[handle].ty.inner_with(&reparsed.types),
                                function_info[left].ty.inner_with(&reparsed.types)
                            );
                            assert_eq!(
                                function_info[right].ty.inner_with(&reparsed.types).scalar(),
                                Some(naga::Scalar::U32)
                            );
                            let naga::Expression::As {
                                expr,
                                kind: naga::ScalarKind::Uint,
                                convert: Some(4),
                            } = function.expressions[right]
                            else {
                                panic!("missing explicit u32 shift count in {output}")
                            };
                            assert_eq!(
                                function_info[expr].ty.inner_with(&reparsed.types).scalar(),
                                Some(naga::Scalar {
                                    kind: naga::ScalarKind::Uint,
                                    width: count_width
                                })
                            );
                        }
                    }
                    assert_eq!(shifts, 1, "{output}");
                    let read_count = reparsed
                        .functions
                        .iter()
                        .find_map(|(handle, function)| {
                            (function.name.as_deref() == Some("read_count")).then_some(handle)
                        })
                        .unwrap();
                    let mut calls = 0;
                    naga::proc::any_statement(&function.body, &mut |statement| {
                        calls += usize::from(
                            matches!(*statement, naga::Statement::Call { function, .. } if function == read_count),
                        );
                        false
                    });
                    assert_eq!(
                        calls, 1,
                        "shift count supplier must be evaluated once\n{output}"
                    );
                }
            }
        }
    }
}

#[test]
fn wgsl_writer_converts_unsigned16_shift_counts_to_u32() {
    check_unsigned_shift_count_roundtrip(2);
}

#[test]
fn wgsl_writer_converts_unsigned64_shift_counts_to_u32() {
    check_unsigned_shift_count_roundtrip(8);
}
