use super::helpers::validate_with_options;

fn rejected(source: &str, workgroup_size: [u32; 3]) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(
        source,
        &naga::front::cuda::Options {
            workgroup_size,
            ..Default::default()
        },
    )
    .unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

fn roundtrip(source: &str, workgroup_size: [u32; 3]) -> naga::Module {
    let (module, info) = validate_with_options(
        source,
        &naga::front::cuda::Options {
            workgroup_size,
            ..Default::default()
        },
    );
    for entry in &module.entry_points {
        assert_eq!(entry.workgroup_size, workgroup_size);
        assert_eq!(entry.stage, naga::ShaderStage::Compute);
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    module
}

#[test]
fn cuda_launch_bounds_accept_header_positions_and_optional_arguments() {
    for header in [
        "__global__ __launch_bounds__(16) void",
        "__launch_bounds__(16) __global__ void",
        "__global__ void __launch_bounds__(16)",
        "__global__ __launch_bounds__(16, 2) void",
        "__global__ __launch_bounds__(16, 2, 4) void",
        "static __launch_bounds__(16) __global__ inline void",
        "extern \"C\" __global__ void __launch_bounds__(16, 2)",
    ] {
        let module = roundtrip(
            &format!(
                "{header} kernel(unsigned *output) {{
                    unsigned index = threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
                    output[index] = blockDim.x + blockDim.y + blockDim.z;
                }}"
            ),
            [4, 2, 2],
        );
        assert_eq!(module.entry_points.len(), 1);
        assert_eq!(module.entry_points[0].name, "kernel");
        assert_eq!(module.global_variables.len(), 1);
        let (_, output) = module.global_variables.iter().next().unwrap();
        assert_eq!(
            output.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: 0,
            })
        );
        assert_eq!(
            output.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
            }
        );
    }
}

#[test]
fn cuda_launch_bounds_use_constants_macros_and_dependent_template_arguments() {
    let module = roundtrip(
        "#define DOUBLED(value) ((value) * 2u)
        constexpr unsigned BaseThreads = 8u;
        __global__ __launch_bounds__(DOUBLED(BaseThreads), 2) void concrete(unsigned *output) {
            unsigned index = threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
            output[index] = blockDim.x;
        }
        template<unsigned MaximumThreads, int MinimumBlocks>
        __global__ __launch_bounds__(DOUBLED(MaximumThreads), MinimumBlocks, 4)
        void specialized(unsigned *output) {
            unsigned index = threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
            output[index] = MaximumThreads;
        }
        template __global__ void specialized<8u, 2>(unsigned *);",
        [4, 2, 2],
    );
    let names: Vec<_> = module
        .entry_points
        .iter()
        .map(|entry| entry.name.as_str())
        .collect();
    assert_eq!(names, ["concrete", "specialized<8u,2>"]);
    roundtrip(
        "template<int MaximumThreads>
        __global__ __launch_bounds__(8) void unused() {}
        __global__ void kernel() {}",
        [4, 2, 2],
    );
}

#[test]
fn cuda_launch_bounds_check_the_complete_three_dimensional_block_size() {
    let source = "__global__ __launch_bounds__(64, 2, 4) void kernel() {}";
    for shape in [[1, 1, 1], [4, 4, 4], [2, 8, 4], [64, 1, 1]] {
        roundtrip(source, shape);
    }
    for shape in [[4, 4, 5], [2, 8, 5], [65, 1, 1], [1, 1, 65]] {
        rejected(source, shape);
    }
    let source = "__global__ __launch_bounds__(true) void kernel() {}";
    roundtrip(source, [1, 1, 1]);
    rejected(source, [2, 1, 1]);
}

#[test]
fn cuda_launch_bounds_convert_integer_constants_and_keep_inactive_bounds() {
    for arguments in [
        "0",
        "-1",
        "(-2147483647 - 1)",
        "false",
        "0xffffffffu",
        "0x80000000u",
        "16, 0, 0",
        "16, -2, -4",
        "16, 0xffffffffu, 0x80000000u",
        "(0xffffffffu + 17u), true, true",
        "int(16.75f), int(2.5f), int(4.5f)",
        "2147483647",
        "0x7fffffffu",
    ] {
        roundtrip(
            &format!("__global__ __launch_bounds__({arguments}) void kernel() {{}}"),
            [4, 2, 2],
        );
    }
    roundtrip(
        "template<int MaximumThreads>
        __global__ __launch_bounds__(MaximumThreads) void specialized() {}
        template __global__ void specialized<0>();
        template __global__ void specialized<-16>();",
        [4, 2, 2],
    );
}

#[test]
fn cuda_launch_bounds_accept_post_parameter_attributes_in_declaration_scope() {
    for source in [
        "__global__ void kernel() __launch_bounds__(16, 2, 4) {}",
        "constexpr int MaximumThreads = 16;
        __global__ void kernel(int MaximumThreads) __launch_bounds__(MaximumThreads, 2) {}",
        "constexpr int MaximumThreads = 16;
        __global__ __launch_bounds__(MaximumThreads, 2) void kernel(int MaximumThreads) {}",
    ] {
        roundtrip(source, [4, 2, 2]);
    }
    let source = "__global__ void kernel(int maximum) __launch_bounds__(maximum) {}";
    let error = rejected(source, [1, 1, 1]);
    assert_eq!(&source[error.span.to_range().unwrap()], "maximum");
}

#[test]
fn cuda_launch_bounds_use_the_first_attribute_on_each_declaration() {
    for attributes in [
        "__launch_bounds__(16) __launch_bounds__(8)",
        "__launch_bounds__(16, 2) __launch_bounds__(16, 2)",
        "__launch_bounds__(0) __launch_bounds__(1)",
    ] {
        roundtrip(
            &format!("__global__ {attributes} void kernel() {{}}"),
            [4, 2, 2],
        );
    }
    rejected(
        "__global__ __launch_bounds__(8) __launch_bounds__(16) void kernel() {}",
        [4, 2, 2],
    );
    rejected(
        "__global__ __launch_bounds__(16) __launch_bounds__(16.0f) void kernel() {}",
        [4, 2, 2],
    );
}

#[test]
fn cuda_launch_bounds_ignore_valid_attributes_on_device_helpers() {
    for header in [
        "__device__ __launch_bounds__(1) unsigned",
        "__host__ __device__ __launch_bounds__(1, 2, 4) unsigned",
        "__launch_bounds__(-1, 0, -2) unsigned __device__",
    ] {
        let module = roundtrip(
            &format!(
                "{header} identity(unsigned value) {{ return value; }}
                __global__ void kernel(unsigned *output) {{
                    unsigned index = threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
                    output[index] = identity(index);
                }}"
            ),
            [4, 2, 2],
        );
        assert_eq!(module.functions.len(), 1);
    }
}

#[test]
fn cuda_launch_bounds_inherit_and_replace_template_declaration_attributes() {
    for source in [
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized();
        template<int Capacity> __global__ void specialized() {}
        template __global__ void specialized<16>();",
        "template<int MaximumThreads> __global__ void specialized();
        template<int Capacity> __global__ __launch_bounds__(Capacity, 2) void specialized() {}
        template __global__ void specialized<16>();",
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized();
        template<int Capacity> __global__ __launch_bounds__(Capacity * 2, 4) void specialized() {}
        template __global__ void specialized<8>();",
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized();
        template<int Capacity> __global__ __launch_bounds__(Capacity * 2, 4) void specialized();
        template<int Bound> __global__ void specialized() {}
        template __global__ void specialized<8>();",
    ] {
        roundtrip(source, [4, 2, 2]);
    }
    for source in [
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized();
        template<int Capacity> __global__ void specialized() {}
        template __global__ void specialized<8>();",
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized();
        template<int Capacity> __global__ __launch_bounds__(Capacity / 2, 4) void specialized() {}
        template __global__ void specialized<16>();",
    ] {
        rejected(source, [4, 2, 2]);
    }
}

#[test]
fn cuda_launch_bounds_keep_definition_attributes_after_later_template_prototypes() {
    for source in [
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized() {}
        template<int Capacity> __global__ __launch_bounds__(Capacity / 2, 4) void specialized();
        template __global__ void specialized<16>();",
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized() {}
        template __global__ void specialized<16>();
        template<int Capacity> __global__ __launch_bounds__(Capacity / 2, 4) void specialized();",
    ] {
        roundtrip(source, [4, 2, 2]);
    }
    rejected(
        "template<int MaximumThreads> __global__ __launch_bounds__(MaximumThreads, 2) void specialized() {}
        template<int Capacity> __global__ __launch_bounds__(Capacity * 2, 4) void specialized();
        template __global__ void specialized<8>();",
        [4, 2, 2],
    );
}

#[test]
fn cuda_launch_bounds_keep_template_instantiation_attributes_from_replacing_the_definition() {
    roundtrip(
        "template<int MaximumThreads>
        __global__ __launch_bounds__(MaximumThreads) void specialized() {}
        template __global__ __launch_bounds__(8) void specialized<16>();",
        [4, 2, 2],
    );
    rejected(
        "template<int MaximumThreads>
        __global__ __launch_bounds__(MaximumThreads) void specialized() {}
        template __global__ __launch_bounds__(16) void specialized<8>();",
        [4, 2, 2],
    );
    for arguments in ["", "16.0f", "missing"] {
        rejected(
            &format!(
                "template<int MaximumThreads>
                __global__ __launch_bounds__(MaximumThreads) void specialized() {{}}
                template __global__ __launch_bounds__({arguments}) void specialized<16>();"
            ),
            [4, 2, 2],
        );
    }
}

#[test]
fn cuda_launch_bounds_reject_nonconstant_nonintegral_and_malformed_arguments() {
    for arguments in [
        "",
        "16,",
        "16, 2, 4, 8",
        "16.0f",
        "16, 2.0f",
        "16, 2, 4.0f",
        "missing",
        "(2147483647 + 1)",
        "(1 / 0)",
        "(1 << 32)",
        "4294967296ull",
        "nullptr",
    ] {
        for declaration in [
            format!("__global__ __launch_bounds__({arguments}) void kernel() {{}}"),
            format!(
                "__device__ __launch_bounds__({arguments}) void helper() {{}}
                __global__ void kernel() {{}}"
            ),
        ] {
            rejected(&declaration, [1, 1, 1]);
        }
    }
    rejected(
        "__device__ int maximum();
        __global__ __launch_bounds__(maximum()) void kernel() {}",
        [1, 1, 1],
    );
    rejected(
        "template<int MaximumThreads>
        __global__ __launch_bounds__(MaximumThreads + 1) void specialized() {}
        template __global__ void specialized<2147483647>();",
        [1, 1, 1],
    );
    for arguments in ["16.0f", "MaximumThreads, 2.0f", "MaximumThreads, 2, 4.0f"] {
        rejected(
            &format!(
                "template<int MaximumThreads>
                __global__ __launch_bounds__({arguments}) void specialized() {{}}
                __global__ void kernel() {{}}"
            ),
            [1, 1, 1],
        );
    }
}

#[test]
fn cuda_launch_bounds_preserve_existing_unsupported_declaration_boundaries() {
    for source in [
        "__launch_bounds__(16) void host_only() {} __global__ void kernel() {}",
        "__global__ __launch_bounds__(16) void kernel();",
        "__global__ void kernel() { __launch_bounds__(16) unsigned local = 1u; }",
        "__launch_bounds__(16) constexpr unsigned Value = 1u; __global__ void kernel() {}",
    ] {
        rejected(source, [1, 1, 1]);
    }
}

#[test]
fn cuda_launch_bounds_apply_existing_expression_depth_limits_to_attribute_arguments() {
    let expression = format!("{}16{}", "(".repeat(256), ")".repeat(256));
    rejected(
        &format!("__global__ __launch_bounds__({expression}) void kernel() {{}}"),
        [1, 1, 1],
    );
    roundtrip(
        "__global__ __launch_bounds__((((16)))) void kernel() {}",
        [4, 2, 2],
    );
}
