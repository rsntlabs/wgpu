use wgpu::{DownlevelFlags, Limits};

use crate::shader::{shader_input_output_test, InputStorageType, ShaderBuffer, ShaderTest};
use wgpu_test::{
    apply, gpu_test, FailureCase, GpuTestConfiguration, GpuTestInitializer, TestParameters,
};

pub fn all_tests(vec: &mut Vec<GpuTestInitializer>) {
    vec.extend([
        NUMERIC_BUILTINS,
        INT64_ATOMIC_MIN_MAX,
        INT64_ATOMIC_ALL_OPS,
        FLOAT32_ATOMIC,
        SPIRV_INTEGER16_BIT_SEARCHES,
        SPIRV_INTEGER32_BIT_SEARCHES,
        SPIRV_INTEGER64_BIT_SEARCHES,
    ]);
}

fn create_numeric_builtin_test() -> Vec<ShaderTest> {
    let mut tests = Vec::new();

    #[rustfmt::skip]
    let clamp_values: &[(f32, f32, f32, &[f32])] = &[
        // value - low - high - valid outputs

        // normal clamps
        (   20.0,  0.0,  10.0,  &[10.0]),
        (  -10.0,  0.0,  10.0,  &[0.0]),
        (    5.0,  0.0,  10.0,  &[5.0]),

        // med-of-three or min/max
        (    3.0,  2.0,  1.0,   &[1.0, 2.0]),
    ];

    for &(input, low, high, output) in clamp_values {
        let mut test = ShaderTest::new(
            format!("clamp({input}, {low}, {high}) == {output:?}"),
            String::from("value: f32, low: f32, high: f32"),
            String::from("output[0] = bitcast<u32>(clamp(input.value, input.low, input.high));"),
            &[input, low, high],
            &[output[0]],
        );
        for &extra in &output[1..] {
            test = test.extra_output_values(&[extra]);
        }

        tests.push(test);
    }

    tests
}

#[apply(gpu_test!)]
static NUMERIC_BUILTINS: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_numeric_builtin_test(),
        )
    });

fn create_int64_atomic_min_max_test() -> Vec<ShaderTest> {
    let mut tests = Vec::new();

    let test = ShaderTest::new(
        "atomicMax".into(),
        "value: u64".into(),
        "atomicMin(&output, 0lu); atomicMax(&output, 2lu);".into(),
        &[0],
        &[2],
    )
    .output_type("atomic<u64>".into());

    tests.push(test);

    let test = ShaderTest::new(
        "atomicMin".into(),
        "value: u64".into(),
        "atomicMax(&output, 100lu); atomicMin(&output, 4lu);".into(),
        &[0],
        &[4],
    )
    .output_type("atomic<u64>".into());

    tests.push(test);

    tests
}

#[apply(gpu_test!)]
static INT64_ATOMIC_MIN_MAX: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::SHADER_INT64 | wgpu::Features::SHADER_INT64_ATOMIC_MIN_MAX)
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_int64_atomic_min_max_test(),
        )
    });

fn create_int64_atomic_all_ops_test() -> Vec<ShaderTest> {
    let mut tests = Vec::new();

    let test = ShaderTest::new(
        "atomicAdd".into(),
        "value: u64".into(),
        "atomicStore(&output, 0lu); atomicAdd(&output, 1lu); atomicAdd(&output, 1lu);".into(),
        &[0],
        &[2],
    )
    .output_type("atomic<u64>".into());

    tests.push(test);

    let test = ShaderTest::new(
        "atomicAnd".into(),
        "value: u64".into(),
        "atomicStore(&output, 31lu); atomicAnd(&output, 30lu); atomicAnd(&output, 3lu);".into(),
        &[0],
        &[2],
    )
    .output_type("atomic<u64>".into());

    tests.push(test);

    let test = ShaderTest::new(
        "atomicOr".into(),
        "value: u64".into(),
        "atomicStore(&output, 0lu); atomicOr(&output, 3lu); atomicOr(&output, 6lu);".into(),
        &[0],
        &[7],
    )
    .output_type("atomic<u64>".into());

    tests.push(test);

    tests
}

#[apply(gpu_test!)]
static INT64_ATOMIC_ALL_OPS: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::SHADER_INT64 | wgpu::Features::SHADER_INT64_ATOMIC_ALL_OPS)
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_int64_atomic_all_ops_test(),
        )
    });

fn create_float32_atomic_test() -> Vec<ShaderTest> {
    let mut tests = Vec::new();

    let test = ShaderTest::new(
        "atomicAdd".into(),
        "value: f32".into(),
        "atomicStore(&output, 0.0); atomicAdd(&output, -0.50); atomicAdd(&output, 1.75);".into(),
        &[0_f32],
        &[1.25_f32],
    )
    .output_type("atomic<f32>".into());

    tests.push(test);

    let test = ShaderTest::new(
        "atomicAdd".into(),
        "value: f32".into(),
        "atomicStore(&output, 0.0); atomicSub(&output, -2.5); atomicSub(&output, 3.0);".into(),
        &[0_f32],
        &[-0.5_f32],
    )
    .output_type("atomic<f32>".into());

    tests.push(test);

    tests
}

#[apply(gpu_test!)]
static FLOAT32_ATOMIC: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::SHADER_FLOAT32_ATOMIC)
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(ctx, InputStorageType::Storage, create_float32_atomic_test())
    });

fn integer_bit_values(bit_width: u32) -> Vec<u64> {
    let mask = u64::MAX >> (64 - bit_width);
    let sign_bit = 1_u64 << (bit_width - 1);
    let mut values = vec![0, mask, sign_bit, sign_bit - 1, sign_bit + 1];
    for bit in 0..bit_width {
        let single_bit = 1_u64 << bit;
        values.extend([single_bit, mask ^ single_bit, single_bit - 1]);
    }
    values.sort_unstable();
    values.dedup();
    values
}

fn integer_bit_results(bits: u64, bit_width: u32, signed: bool) -> [u64; 4] {
    let mask = u64::MAX >> (64 - bit_width);
    let output_mask = if bit_width == 64 {
        u64::MAX
    } else {
        u64::from(u32::MAX)
    };
    let missing_bit = if signed { output_mask } else { mask };
    let leading_bits = if signed && bits & (1_u64 << (bit_width - 1)) != 0 {
        bits ^ mask
    } else {
        bits
    };
    [
        u64::from(bits.leading_zeros() - (64 - bit_width)),
        u64::from(bits.trailing_zeros().min(bit_width)),
        if leading_bits == 0 {
            missing_bit
        } else {
            u64::from(63 - leading_bits.leading_zeros())
        },
        if bits == 0 {
            missing_bit
        } else {
            u64::from(bits.trailing_zeros())
        },
    ]
}

fn integer_bit_roundtrip(source: &str, bit_width: u32) -> (String, String) {
    let capabilities = match bit_width {
        16 => naga::valid::Capabilities::SHADER_INT16,
        32 => naga::valid::Capabilities::empty(),
        64 => naga::valid::Capabilities::SHADER_INT64,
        _ => unreachable!(),
    };
    let mut validator =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities);
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = validator.validate(&module).unwrap();
    let options = naga::back::spv::Options {
        use_storage_input_output_16: false,
        ..Default::default()
    };
    let pipeline = naga::back::spv::PipelineOptions {
        entry_point: String::from("cs_main"),
        shader_stage: naga::ShaderStage::Compute,
    };
    let words = naga::back::spv::write_vec(&module, &info, &options, Some(&pipeline)).unwrap();
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
    let info = validator.validate(&parsed).unwrap();
    let wgsl = naga::back::wgsl::write_string(
        &parsed,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    )
    .unwrap();
    let reparsed = naga::front::wgsl::parse_str(&wgsl).unwrap();
    validator.validate(&reparsed).unwrap();
    assert_eq!(reparsed.entry_points.len(), 1);
    assert_eq!(reparsed.entry_points[0].workgroup_size, [4, 1, 1]);
    let entry_point = reparsed.entry_points[0].name.clone();
    (wgsl, entry_point)
}

fn create_spirv_integer_bit_test(bit_width: u32) -> Vec<ShaderTest> {
    let values = integer_bit_values(bit_width);
    let record_count = values.len();
    let words_per_record = 122;
    let lane_offsets = [0, 5, 8, 11];
    let output_width = if bit_width == 64 { 64 } else { 32 };
    let extension = if bit_width == 16 {
        "enable wgpu_int16;"
    } else {
        ""
    };
    let mut source = format!(
        r#"{extension}
        alias Unsigned = u{bit_width};
        alias Signed = i{bit_width};
        alias Output = u{output_width};
        @group(0) @binding(0) var<storage> input: array<Unsigned>;
        @group(0) @binding(1) var<storage, read_write> output: array<Output>;

        fn supplied_unsigned_scalar(index: u32, calls: ptr<function, u32>) -> Unsigned {{
            *calls += 1u;
            return input[index + 1u];
        }}

        fn supplied_unsigned_vector(index: u32, calls: ptr<function, u32>) -> vec4<Unsigned> {{
            *calls += 1u;
            return vec4<Unsigned>(
                input[index + 1u],
                input[(index + 5u) % {record_count}u + 1u],
                input[(index + 8u) % {record_count}u + 1u],
                input[(index + 11u) % {record_count}u + 1u]);
        }}

        fn supplied_signed_scalar(index: u32, calls: ptr<function, u32>) -> Signed {{
            return bitcast<Signed>(supplied_unsigned_scalar(index, calls));
        }}

        fn supplied_signed_vector(index: u32, calls: ptr<function, u32>) -> vec4<Signed> {{
            return bitcast<vec4<Signed>>(supplied_unsigned_vector(index, calls));
        }}

        @compute @workgroup_size(4)
        fn cs_main(@builtin(global_invocation_id) invocation: vec3<u32>) {{
            let index = invocation.x;
            if index >= {record_count}u {{
                return;
            }}
            let output_start = (index + 1u) * {words_per_record}u;
            var unsigned_calls = 0u;
            var signed_calls = 0u;
            let unsigned_values = vec4<Unsigned>(
                input[index + 1u],
                input[(index + 5u) % {record_count}u + 1u],
                input[(index + 8u) % {record_count}u + 1u],
                input[(index + 11u) % {record_count}u + 1u]);
            let signed_values = bitcast<vec4<Signed>>(unsigned_values);
        "#,
    );
    let mut output_offset = 0;
    for (shape_index, component_count) in [1, 2, 3, 4, 1, 4].into_iter().enumerate() {
        for sign in ["unsigned", "signed"] {
            let argument = if shape_index >= 4 {
                let shape = if component_count == 1 {
                    "scalar"
                } else {
                    "vector"
                };
                format!("supplied_{sign}_{shape}(index, &{sign}_calls)")
            } else {
                match component_count {
                    1 => format!("{sign}_values.x"),
                    2 => format!("{sign}_values.xy"),
                    3 => format!("{sign}_values.xyz"),
                    4 => format!("{sign}_values"),
                    _ => unreachable!(),
                }
            };
            for operation in [
                "countLeadingZeros",
                "countTrailingZeros",
                "firstLeadingBit",
                "firstTrailingBit",
            ] {
                source.push_str(&format!(
                    "let {sign}_{operation}_{shape_index} = {operation}({argument});\n"
                ));
                for component in 0..component_count {
                    let field = if component_count == 1 {
                        ""
                    } else {
                        [".x", ".y", ".z", ".w"][component]
                    };
                    source.push_str(&format!(
                        "output[output_start + {output_offset}u] = Output({sign}_{operation}_{shape_index}{field});\n"
                    ));
                    output_offset += 1;
                }
            }
        }
    }
    assert_eq!(output_offset, words_per_record - 2);
    source.push_str(&format!(
        "output[output_start + {output_offset}u] = Output(unsigned_calls);\n\
         output[output_start + {}u] = Output(signed_calls);\n}}\n",
        output_offset + 1,
    ));

    let guard = if output_width == 64 {
        0x96a5_5a69_5a69_a596_u64
    } else {
        0x96a5_5a69_u64
    };
    let initial_output = vec![guard; (record_count + 4) * words_per_record];
    let mut expected = initial_output.clone();
    for index in 0..record_count {
        let mut row = Vec::with_capacity(words_per_record);
        for component_count in [1, 2, 3, 4, 1, 4] {
            for signed in [false, true] {
                for operation in 0..4 {
                    for &offset in &lane_offsets[..component_count] {
                        let bits = values[(index + offset) % record_count];
                        row.push(integer_bit_results(bits, bit_width, signed)[operation]);
                    }
                }
            }
        }
        row.extend([8, 8]);
        assert_eq!(row.len(), words_per_record);
        let start = (index + 1) * words_per_record;
        expected[start..start + words_per_record].copy_from_slice(&row);
    }
    let mut input = vec![0x5aa5_5aa5_5aa5_5aa5_u64];
    input.extend(values);
    input.extend([0x5aa5_5aa5_5aa5_5aa5; 3]);
    let (roundtrip, roundtrip_entry) = integer_bit_roundtrip(&source, bit_width);
    let mut tests = Vec::new();
    for (path, source, entry) in [
        ("direct WGSL", source, String::from("cs_main")),
        ("SPIR-V roundtrip", roundtrip, roundtrip_entry),
    ] {
        let input_buffer = match bit_width {
            16 => ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input.iter().map(|&value| value as u16).collect::<Vec<_>>(),
            ),
            32 => ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input.iter().map(|&value| value as u32).collect::<Vec<_>>(),
            ),
            64 => ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            _ => unreachable!(),
        };
        let name = format!("SPIR-V {bit_width}-bit signed/unsigned integer bit searches, {path}");
        let (test, output_buffer) = if output_width == 64 {
            (
                ShaderTest::new(name, String::new(), String::new(), &[] as &[u32], &expected),
                ShaderBuffer::new(
                    1,
                    wgpu::BufferBindingType::Storage { read_only: false },
                    &initial_output,
                ),
            )
        } else {
            let expected: Vec<_> = expected.iter().map(|&value| value as u32).collect();
            let initial: Vec<_> = initial_output.iter().map(|&value| value as u32).collect();
            (
                ShaderTest::new(name, String::new(), String::new(), &[] as &[u32], &expected),
                ShaderBuffer::new(
                    1,
                    wgpu::BufferBindingType::Storage { read_only: false },
                    &initial,
                ),
            )
        };
        tests.push(test.module_source(source, entry).module_buffers(
            vec![input_buffer, output_buffer],
            1,
            [(record_count as u32).div_ceil(4) + 1, 1, 1],
        ));
    }
    tests
}

#[apply(gpu_test!)]
static SPIRV_INTEGER16_BIT_SEARCHES: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::SHADER_I16)
            .skip(FailureCase::backend(!wgpu::Backends::VULKAN))
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_spirv_integer_bit_test(16),
        )
    });

#[apply(gpu_test!)]
static SPIRV_INTEGER32_BIT_SEARCHES: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .skip(FailureCase::backend(!wgpu::Backends::VULKAN))
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_spirv_integer_bit_test(32),
        )
    });

#[apply(gpu_test!)]
static SPIRV_INTEGER64_BIT_SEARCHES: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(wgpu::Features::SHADER_INT64)
            .skip(FailureCase::backend(!wgpu::Backends::VULKAN))
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits::downlevel_defaults()),
    )
    .run_async(|ctx| {
        shader_input_output_test(
            ctx,
            InputStorageType::Storage,
            create_spirv_integer_bit_test(64),
        )
    });
