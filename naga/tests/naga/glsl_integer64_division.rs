#![cfg(all(feature = "wgsl-in", feature = "glsl-out"))]

#[test]
fn glsl_integer64_division_and_remainder_preserve_signed_and_unsigned_widths() {
    let source = "
        struct Operands {
            signed_numerator: i64,
            signed_denominator: i64,
            unsigned_numerator: u64,
            unsigned_denominator: u64,
        }
        struct Results { signed_values: vec2<i64>, unsigned_values: vec2<u64> }
        @group(0) @binding(0) var<storage> input: array<Operands>;
        @group(0) @binding(1) var<storage, read_write> output: array<Results>;
        @compute @workgroup_size(1) fn main() {
            let operands = input[0];
            let signed_quotient = operands.signed_numerator / operands.signed_denominator;
            let signed_remainder = operands.signed_numerator % operands.signed_denominator;
            let unsigned_quotient = operands.unsigned_numerator / operands.unsigned_denominator;
            let unsigned_remainder = operands.unsigned_numerator % operands.unsigned_denominator;
            output[0] = Results(
                vec2<i64>(signed_quotient, signed_remainder),
                vec2<u64>(unsigned_quotient, unsigned_remainder));
        }";
    let module = naga::front::wgsl::parse_str(source)
        .unwrap_or_else(|error| panic!("{}", error.emit_to_string(source)));
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(&module)
    .unwrap();
    let function = &module.entry_points[0].function;
    for (name, scalar) in [
        ("signed_quotient", naga::Scalar::I64),
        ("signed_remainder", naga::Scalar::I64),
        ("unsigned_quotient", naga::Scalar::U64),
        ("unsigned_remainder", naga::Scalar::U64),
    ] {
        let (&handle, _) = function
            .named_expressions
            .iter()
            .find(|(_, actual)| actual.as_str() == name)
            .unwrap();
        assert_eq!(
            info.get_entry_point(0)[handle].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar)
        );
    }
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
    for type_name in ["int64_t", "uint64_t", "i64vec2", "u64vec2"] {
        assert!(output.contains(type_name), "{type_name} missing\n{output}");
    }
    assert_eq!(
        output
            .matches("#extension GL_ARB_gpu_shader_int64 : require")
            .count(),
        1,
        "{output}"
    );
}

fn validate(
    source: &str,
    capabilities: naga::valid::Capabilities,
) -> (naga::Module, naga::valid::ModuleInfo) {
    let module = naga::front::wgsl::parse_str(source)
        .unwrap_or_else(|error| panic!("{}", error.emit_to_string(source)));
    let info = naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities)
        .validate(&module)
        .unwrap();
    (module, info)
}

fn write_glsl(
    module: &naga::Module,
    info: &naga::valid::ModuleInfo,
    entry_point: &str,
    flags: naga::back::glsl::WriterFlags,
) -> String {
    let options = naga::back::glsl::Options {
        version: naga::back::glsl::Version::Desktop(450),
        writer_flags: flags,
        ..Default::default()
    };
    let pipeline = naga::back::glsl::PipelineOptions {
        shader_stage: naga::ShaderStage::Compute,
        entry_point: entry_point.to_owned(),
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
    )
    .unwrap()
    .write()
    .unwrap();
    output
}

fn helper_signature(type_name: &str, operation: &str) -> String {
    format!("{type_name} naga_{operation}64({type_name} dividend, {type_name} divisor)")
}

#[test]
fn glsl_integer64_division_helpers_cover_every_scalar_and_vector_shape() {
    for (scalar, glsl_scalar, prefix) in [("i64", "int64_t", "i64"), ("u64", "uint64_t", "u64")] {
        for components in [1, 2, 3, 4] {
            let value_type = if components == 1 {
                scalar.to_owned()
            } else {
                format!("vec{components}<{scalar}>")
            };
            let glsl_type = if components == 1 {
                glsl_scalar.to_owned()
            } else {
                format!("{prefix}vec{components}")
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
                    output[2] = numerator / denominator;
                    output[3] = numerator % denominator;
                }}"
            );
            let (module, info) = validate(&source, naga::valid::Capabilities::SHADER_INT64);
            let output = write_glsl(
                &module,
                &info,
                "main",
                naga::back::glsl::WriterFlags::empty(),
            );
            for operation in ["div", "mod"] {
                assert_eq!(
                    output
                        .matches(&helper_signature(&glsl_type, operation))
                        .count(),
                    1,
                    "{output}"
                );
                assert_eq!(
                    output
                        .matches(&helper_signature(glsl_scalar, operation))
                        .count(),
                    1,
                    "{output}"
                );
                assert!(
                    output.matches(&format!("naga_{operation}64(")).count() >= 3,
                    "{output}"
                );
            }
        }
    }
}

#[test]
fn glsl_integer64_mixed_scalar_vector_operands_use_normalized_splats() {
    for scalar in ["i64", "u64"] {
        for components in [2, 3, 4] {
            let source = format!("
                @group(0) @binding(0) var<storage> input: array<vec{components}<{scalar}>>;
                @group(0) @binding(1) var<storage, read_write> output: array<vec{components}<{scalar}>>;
                @compute @workgroup_size(1) fn main() {{
                    let vector_value = input[0];
                    let scalar_value = input[1].x;
                    output[0] = vector_value / scalar_value;
                    output[1] = scalar_value / vector_value;
                    output[2] = vector_value % scalar_value;
                    output[3] = scalar_value % vector_value;
                }}");
            let (module, info) = validate(&source, naga::valid::Capabilities::SHADER_INT64);
            let function = &module.entry_points[0].function;
            let mut left_splats = 0;
            let mut right_splats = 0;
            for (_, expression) in function.expressions.iter() {
                if let naga::Expression::Binary {
                    op: naga::BinaryOperator::Divide | naga::BinaryOperator::Modulo,
                    left,
                    right,
                } = *expression
                {
                    left_splats += usize::from(matches!(
                        function.expressions[left],
                        naga::Expression::Splat { .. }
                    ));
                    right_splats += usize::from(matches!(
                        function.expressions[right],
                        naga::Expression::Splat { .. }
                    ));
                }
            }
            assert_eq!((left_splats, right_splats), (2, 2), "{source}");
            let output = write_glsl(
                &module,
                &info,
                "main",
                naga::back::glsl::WriterFlags::empty(),
            );
            assert!(output.contains("naga_div64("), "{output}");
            assert!(output.contains("naga_mod64("), "{output}");
        }
    }
}

#[test]
fn glsl_integer64_scalar_helpers_guard_zero_and_signed_minimum_divisors() {
    let source = "
        @group(0) @binding(0) var<storage> signed_input: array<i64>;
        @group(0) @binding(1) var<storage> unsigned_input: array<u64>;
        @group(0) @binding(2) var<storage, read_write> signed_output: array<i64>;
        @group(0) @binding(3) var<storage, read_write> unsigned_output: array<u64>;
        @compute @workgroup_size(1) fn main() {
            let minimum = -9223372036854775807li - 1li;
            let signed_zero = signed_input[0] & 0li;
            let unsigned_zero = unsigned_input[0] & 0lu;
            signed_output[0] = minimum / signed_zero;
            signed_output[1] = minimum % signed_zero;
            signed_output[2] = minimum / (signed_zero - 1li);
            signed_output[3] = minimum % (signed_zero - 1li);
            signed_output[4] = (-signed_input[1]) / signed_input[2];
            signed_output[5] = signed_input[1] / (-signed_input[2]);
            signed_output[6] = (-signed_input[1]) % signed_input[2];
            signed_output[7] = signed_input[1] % (-signed_input[2]);
            unsigned_output[0] = unsigned_input[1] / unsigned_zero;
            unsigned_output[1] = unsigned_input[1] % unsigned_zero;
        }";
    let (module, info) = validate(source, naga::valid::Capabilities::SHADER_INT64);
    let output = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::empty(),
    );
    for type_name in ["int64_t", "uint64_t"] {
        for operation in ["div", "mod"] {
            let signature = helper_signature(type_name, operation);
            let body = output
                .split(&signature)
                .nth(1)
                .unwrap()
                .split("\n}")
                .next()
                .unwrap();
            assert!(
                body.contains(&format!("{type_name} safe_divisor")),
                "{body}"
            );
            assert!(body.contains("divisor == 0"), "{body}");
            if type_name == "int64_t" {
                assert!(body.contains("(-9223372036854775807l - 1l)"), "{body}");
                assert!(body.contains("divisor == -1l"), "{body}");
            }
        }
    }
}

#[test]
fn glsl_integer64_vector_helpers_delegate_each_lane_to_scalar_guards() {
    let source = "
        @group(0) @binding(0) var<storage> input: array<vec4<i64>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec4<i64>>;
        @compute @workgroup_size(1) fn main() {
            output[0] = input[0] / input[1];
            output[1] = input[0] % input[1];
        }";
    let (module, info) = validate(source, naga::valid::Capabilities::SHADER_INT64);
    let output = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::empty(),
    );
    for operation in ["div", "mod"] {
        let signature = helper_signature("i64vec4", operation);
        let body = output
            .split(&signature)
            .nth(1)
            .unwrap()
            .split("\n}")
            .next()
            .unwrap();
        for component in ["x", "y", "z", "w"] {
            assert!(
                body.contains(&format!(
                    "naga_{operation}64(dividend.{component}, divisor.{component})"
                )),
                "{body}"
            );
        }
        assert!(
            output
                .find(&helper_signature("int64_t", operation))
                .unwrap()
                < output.find(&signature).unwrap(),
            "{output}"
        );
    }
}

#[test]
fn glsl_integer64_helpers_preserve_call_and_volatile_snapshot_order() {
    use super::volatile_loads::global_accesses;

    let source = "
        @group(0) @binding(0) @volatile var<storage, read_write> watched: array<i64>;
        @group(0) @binding(1) var<storage, read_write> output: array<i64>;
        fn numerator() -> i64 { watched[2] += 1li; return watched[0]; }
        fn denominator() -> i64 { watched[3] += 1li; return watched[1]; }
        @compute @workgroup_size(1) fn main() {
            let quotient = numerator() / denominator();
            let snapshot = watched[4];
            watched[4] = 99li;
            let remainder = snapshot % watched[1];
            output[0] = quotient;
            output[1] = remainder;
        }";
    let capabilities = naga::valid::Capabilities::SHADER_INT64
        | naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE;
    let (module, info) = validate(source, capabilities);
    let watched = module
        .global_variables
        .iter()
        .find_map(|(handle, variable)| {
            (variable.name.as_deref() == Some("watched")).then_some(handle)
        })
        .unwrap();
    assert_eq!(
        global_accesses(&module, watched)
            .iter()
            .map(|access| (access.write, access.index))
            .collect::<Vec<_>>(),
        [
            (false, Some(2)),
            (true, Some(2)),
            (false, Some(0)),
            (false, Some(3)),
            (true, Some(3)),
            (false, Some(1)),
            (false, Some(4)),
            (true, Some(4)),
            (false, Some(1))
        ]
    );
    let output = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::empty(),
    );
    let main_body = output.split("void main()").nth(1).unwrap();
    let numerator_call = main_body.find("= numerator(").unwrap();
    let denominator_call = main_body.find("= denominator(").unwrap();
    assert_eq!(main_body.matches("= numerator(").count(), 1, "{output}");
    assert_eq!(main_body.matches("= denominator(").count(), 1, "{output}");
    assert!(numerator_call < denominator_call, "{output}");
    let snapshot = main_body.find(" snapshot =").unwrap();
    let mutation = main_body.find("99l").unwrap();
    let remainder_call = main_body.rfind("naga_mod64(").unwrap();
    assert!(snapshot < mutation && mutation < remainder_call, "{output}");
    assert!(main_body[remainder_call..].contains("snapshot"), "{output}");
    assert!(output.contains("volatile"), "{output}");
}

#[test]
fn glsl_integer64_helpers_reserve_function_and_local_names() {
    let source = "
        @group(0) @binding(0) var<storage> input: array<i64>;
        @group(0) @binding(1) var<storage, read_write> output: array<i64>;
        fn naga_div64(value: f32) -> f32 { return value + 1.0; }
        fn naga_mod64(value: f32) -> f32 { return value - 1.0; }
        fn sample(value: f32) -> f32 { return naga_div64(value) + naga_mod64(value); }
        @compute @workgroup_size(1) fn main() {
            let naga_div64 = input[0];
            let naga_mod64 = input[1];
            output[0] = naga_div64 / naga_mod64;
            output[1] = naga_div64 % naga_mod64;
            output[2] = i64(sample(f32(naga_div64)));
        }";
    let (module, info) = validate(source, naga::valid::Capabilities::SHADER_INT64);
    let output = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::empty(),
    );
    for operation in ["div", "mod"] {
        assert_eq!(
            output
                .matches(&helper_signature("int64_t", operation))
                .count(),
            1,
            "{output}"
        );
        assert!(
            !output.contains(&format!("float naga_{operation}64(")),
            "{output}"
        );
        assert!(
            !output.contains(&format!("int64_t naga_{operation}64 =")),
            "{output}"
        );
    }
}

#[test]
fn glsl_integer64_helpers_are_deduplicated_on_each_repeated_writer_output() {
    let source = "
        @group(0) @binding(0) var<storage> input: array<i64>;
        @group(0) @binding(1) var<storage, read_write> output: array<i64>;
        fn first(left: i64, right: i64) -> i64 { return left / right + left % right; }
        fn second(left: i64, right: i64) -> i64 { return left / right + left % right; }
        @compute @workgroup_size(1) fn main() {
            output[0] = first(input[0], input[1]) + second(input[0], input[1]);
            output[1] = input[0] / input[1] + input[0] % input[1];
        }";
    let (module, info) = validate(source, naga::valid::Capabilities::SHADER_INT64);
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
    {
        let mut writer = naga::back::glsl::Writer::new(
            &mut output,
            &module,
            &info,
            &options,
            &pipeline,
            naga::proc::BoundsCheckPolicies::default(),
        )
        .unwrap();
        writer.write().unwrap();
        writer.write().unwrap();
    }
    assert_eq!(output.matches("#version 450 core").count(), 2);
    for module_output in output.split("#version 450 core").skip(1) {
        for operation in ["div", "mod"] {
            assert_eq!(
                module_output
                    .matches(&helper_signature("int64_t", operation))
                    .count(),
                1,
                "{module_output}"
            );
        }
    }
}

#[test]
fn glsl_integer64_helper_discovery_respects_entry_point_function_filtering() {
    let source = "
        @group(0) @binding(0) var<storage> input: array<i64>;
        @group(0) @binding(1) var<storage, read_write> output: array<i64>;
        @group(0) @binding(2) var<storage, read_write> ordinary: array<u32>;
        fn unused_quotient() -> i64 { return input[0] / input[1]; }
        @compute @workgroup_size(1) fn main() { ordinary[0] = 7u; }
        @compute @workgroup_size(1) fn alternate() { output[0] = unused_quotient(); }";
    let (module, info) = validate(source, naga::valid::Capabilities::SHADER_INT64);
    let filtered = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::empty(),
    );
    assert!(!filtered.contains("unused_quotient("), "{filtered}");
    assert!(!filtered.contains("naga_div64("), "{filtered}");
    let included = write_glsl(
        &module,
        &info,
        "main",
        naga::back::glsl::WriterFlags::INCLUDE_UNUSED_ITEMS,
    );
    assert!(included.contains("unused_quotient("), "{included}");
    assert_eq!(
        included
            .matches(&helper_signature("int64_t", "div"))
            .count(),
        1,
        "{included}"
    );
    let alternate = write_glsl(
        &module,
        &info,
        "alternate",
        naga::back::glsl::WriterFlags::empty(),
    );
    assert_eq!(
        alternate
            .matches(&helper_signature("int64_t", "div"))
            .count(),
        1,
        "{alternate}"
    );
}

#[test]
fn glsl_integer16_and_integer32_division_do_not_request_integer64_helpers() {
    for (scalar, header, capabilities) in [
        ("i32", "", naga::valid::Capabilities::empty()),
        ("u32", "", naga::valid::Capabilities::empty()),
        (
            "i16",
            "enable wgpu_int16;",
            naga::valid::Capabilities::SHADER_INT16,
        ),
        (
            "u16",
            "enable wgpu_int16;",
            naga::valid::Capabilities::SHADER_INT16,
        ),
    ] {
        let source = format!(
            "{header}
            @group(0) @binding(0) var<storage> input: array<{scalar}>;
            @group(0) @binding(1) var<storage, read_write> output: array<{scalar}>;
            @compute @workgroup_size(1) fn main() {{
                output[0] = input[0] / input[1];
                output[1] = input[0] % input[1];
            }}"
        );
        let (module, info) = validate(&source, capabilities);
        let output = write_glsl(
            &module,
            &info,
            "main",
            naga::back::glsl::WriterFlags::empty(),
        );
        assert!(!output.contains("naga_div64("), "{output}");
        assert!(!output.contains("naga_mod64("), "{output}");
        assert!(!output.contains("GL_ARB_gpu_shader_int64"), "{output}");
    }
}

#[cfg(feature = "wgsl-out")]
#[test]
fn glsl_integer64_division_survives_shared_wgsl_roundtrip() {
    let source = "
        @group(0) @binding(0) var<storage> input: array<vec3<i64>>;
        @group(0) @binding(1) var<storage, read_write> output: array<vec3<i64>>;
        @compute @workgroup_size(1) fn main() {
            output[0] = input[0] / input[1].x;
            output[1] = input[1].x % input[0];
        }";
    let capabilities = naga::valid::Capabilities::SHADER_INT64;
    let (module, info) = validate(source, capabilities);
    for flags in [
        naga::back::wgsl::WriterFlags::empty(),
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    ] {
        let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
        let (reparsed, info) = validate(&output, capabilities);
        let glsl = write_glsl(
            &reparsed,
            &info,
            "main",
            naga::back::glsl::WriterFlags::empty(),
        );
        for operation in ["div", "mod"] {
            assert_eq!(
                glsl.matches(&helper_signature("i64vec3", operation))
                    .count(),
                1,
                "{glsl}"
            );
        }
    }
}
