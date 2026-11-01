#![cfg(feature = "wgsl-in")]

use naga::valid::{Capabilities, ModuleInfo, ValidationFlags, Validator};

fn validate(module: &naga::Module, capabilities: Capabilities) -> ModuleInfo {
    Validator::new(ValidationFlags::all(), capabilities)
        .validate(module)
        .unwrap()
}

fn named_expression(function: &naga::Function, name: &str) -> naga::Handle<naga::Expression> {
    function
        .named_expressions
        .iter()
        .find_map(|(&handle, actual)| (actual == name).then_some(handle))
        .unwrap()
}

fn assert_uniformity(
    function: &naga::Function,
    info: &naga::valid::FunctionInfo,
    name: &str,
    nonuniform: bool,
) {
    let expression = named_expression(function, name);
    assert_eq!(
        info[expression].uniformity.non_uniform_result.is_some(),
        nonuniform,
        "{name}"
    );
}

#[test]
fn volatile_storage_loads_are_nonuniform_but_their_addresses_and_lengths_are_uniform() {
    let source = "struct Nested { words: array<u32, 4>, }
        struct Data { nested: Nested, tail: array<u32>, }
        @group(0) @binding(0) @volatile var<storage, read> watched: Data;
        @group(0) @binding(1) var<storage, read> ordinary: Data;
        @group(0) @binding(2) var<storage, read_write> mutable_data: Data;
        @group(0) @binding(3) var<storage, read_write> output: array<u32>;
        @compute @workgroup_size(1) fn main() {
            let watched_pointer = &watched.nested.words[0];
            let ordinary_pointer = &ordinary.nested.words[0];
            let watched_length = arrayLength(&watched.tail);
            let dynamic_pointer = &watched.nested.words[watched_length & 3u];
            let watched_value = *watched_pointer;
            let ordinary_value = *ordinary_pointer;
            let dynamic_value = *dynamic_pointer;
            let mutable_value = mutable_data.nested.words[0];
            output[0] = watched_value + ordinary_value + dynamic_value + mutable_value + watched_length;
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = validate(&module, Capabilities::MEMORY_DECORATION_VOLATILE);
    let function = &module.entry_points[0].function;
    let entry_info = info.get_entry_point(0);
    for name in [
        "watched_pointer",
        "ordinary_pointer",
        "watched_length",
        "dynamic_pointer",
        "ordinary_value",
    ] {
        assert_uniformity(function, entry_info, name, false);
    }
    for name in ["watched_value", "dynamic_value", "mutable_value"] {
        assert_uniformity(function, entry_info, name, true);
    }
}

fn resource_source(textures: bool, qualifier: &str, access: &str) -> String {
    let resource = if textures {
        "@group(0) @binding(1) var resources: binding_array<texture_2d<f32>, 2>;
        @group(0) @binding(2) var<storage, read_write> output: array<vec4<f32>>;"
    } else {
        "struct Packet { value: u32, }
        @group(0) @binding(1) var<storage, read> resources: binding_array<Packet, 2>;
        @group(0) @binding(2) var<storage, read_write> output: array<u32>;"
    };
    let value = if textures {
        "textureLoad(resources[resource_index], vec2<i32>(0), 0)"
    } else {
        "resources[resource_index].value"
    };
    format!(
        "enable wgpu_binding_array;
        struct Indices {{ values: array<u32>, }}
        @group(0) @binding(0) {qualifier} var<storage, {access}> indices: Indices;
        {resource}
        @compute @workgroup_size(1) fn main() {{
            let resource_index = indices.values[0] & 1u;
            output[0] = {value};
        }}"
    )
}

fn resource_capabilities(textures: bool) -> (Capabilities, Capabilities) {
    if textures {
        (
            Capabilities::TEXTURE_AND_SAMPLER_BINDING_ARRAY,
            Capabilities::TEXTURE_AND_SAMPLER_BINDING_ARRAY_NON_UNIFORM_INDEXING,
        )
    } else {
        (
            Capabilities::STORAGE_BUFFER_BINDING_ARRAY,
            Capabilities::STORAGE_BUFFER_BINDING_ARRAY_NON_UNIFORM_INDEXING,
        )
    }
}

fn assert_missing_capability(
    module: &naga::Module,
    capabilities: Capabilities,
    missing: Capabilities,
) {
    let error = Validator::new(ValidationFlags::all(), capabilities)
        .validate(module)
        .unwrap_err();
    let function_error = match error.into_inner() {
        naga::valid::ValidationError::Function { source, .. } => source,
        naga::valid::ValidationError::EntryPoint {
            source: naga::valid::EntryPointError::Function(source),
            ..
        } => source,
        other => panic!("unexpected validation error: {other:?}"),
    };
    assert!(
        matches!(function_error,
        naga::valid::FunctionError::Expression {
            source: naga::valid::ExpressionError::MissingCapabilities(actual), ..
        } if actual == missing),
        "{function_error:?}"
    );
}

fn check_resource_index(textures: bool) {
    let (base, nonuniform) = resource_capabilities(textures);
    let base = base | Capabilities::MEMORY_DECORATION_VOLATILE;
    for (qualifier, access, divergent) in [
        ("", "read", false),
        ("", "read_write", true),
        ("@volatile", "read", true),
    ] {
        let source = resource_source(textures, qualifier, access);
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        if divergent {
            assert_missing_capability(&module, base, nonuniform);
        } else {
            let info = validate(&module, base);
            assert_uniformity(
                &module.entry_points[0].function,
                info.get_entry_point(0),
                "resource_index",
                false,
            );
        }
        let info = validate(&module, base | nonuniform);
        assert_uniformity(
            &module.entry_points[0].function,
            info.get_entry_point(0),
            "resource_index",
            divergent,
        );
    }
}

#[test]
fn volatile_texture_binding_indices_require_nonuniform_indexing_capability() {
    check_resource_index(true);
}

#[test]
fn volatile_storage_buffer_binding_indices_preserve_data_uniformity() {
    let (base, nonuniform) = resource_capabilities(false);
    for (qualifier, access, divergent) in [
        ("", "read", false),
        ("", "read_write", true),
        ("@volatile", "read", true),
    ] {
        let source = resource_source(false, qualifier, access);
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        let info = validate(
            &module,
            base | nonuniform | Capabilities::MEMORY_DECORATION_VOLATILE,
        );
        assert_uniformity(
            &module.entry_points[0].function,
            info.get_entry_point(0),
            "resource_index",
            divergent,
        );
    }
}

#[test]
fn volatile_data_divergence_propagates_through_helpers_composition_and_selection() {
    let source = "struct Nested { words: array<u32, 4>, }
        struct Data { nested: Nested, }
        @group(0) @binding(0) @volatile var<storage, read> watched: Data;
        @group(0) @binding(1) var<storage, read> ordinary: Data;
        @group(0) @binding(2) var<storage, read_write> output: array<u32>;
        fn observed() -> u32 { return watched.nested.words[1]; }
        fn stable() -> u32 { return ordinary.nested.words[1]; }
        @compute @workgroup_size(1) fn main() {
            let observed_value = observed();
            let stable_value = stable();
            let combined = vec2<u32>(observed_value, stable_value);
            let component = combined.x;
            let selected = select(stable_value, observed_value, stable_value == 0u);
            output[0] = component + selected;
        }";
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = validate(&module, Capabilities::MEMORY_DECORATION_VOLATILE);
    for (handle, function) in module.functions.iter() {
        assert_eq!(
            info[handle].uniformity.non_uniform_result.is_some(),
            function.name.as_deref() == Some("observed")
        );
    }
    let function = &module.entry_points[0].function;
    for name in ["observed_value", "combined", "component", "selected"] {
        assert_uniformity(function, info.get_entry_point(0), name, true);
    }
    assert_uniformity(function, info.get_entry_point(0), "stable_value", false);
}

#[cfg(spv_out)]
#[test]
fn spirv_marks_volatile_derived_resource_accesses_nonuniform() {
    use naga::FastHashSet;
    use rspirv::dr::Operand;
    use spirv::{Capability, Decoration, Op};

    for textures in [false, true] {
        let (base, nonuniform) = resource_capabilities(textures);
        for is_volatile in [false, true] {
            let source =
                resource_source(textures, if is_volatile { "@volatile" } else { "" }, "read");
            let module = naga::front::wgsl::parse_str(&source).unwrap();
            let info = validate(
                &module,
                base | nonuniform | Capabilities::MEMORY_DECORATION_VOLATILE,
            );
            let words = naga::back::spv::write_vec(
                &module,
                &info,
                &naga::back::spv::Options::default(),
                Some(&naga::back::spv::PipelineOptions {
                    shader_stage: naga::ShaderStage::Compute,
                    entry_point: "main".into(),
                }),
            )
            .unwrap();
            let parsed = rspirv::dr::load_words(words).unwrap();
            let resource = parsed.annotations.iter().find_map(|instruction| {
                match instruction.operands.as_slice() {
                    [Operand::IdRef(variable), Operand::Decoration(Decoration::Binding), Operand::LiteralBit32(1)]
                        if instruction.class.opcode == Op::Decorate => Some(*variable),
                    _ => None,
                }
            }).unwrap();
            let nonuniform_targets: FastHashSet<_> = parsed
                .annotations
                .iter()
                .filter_map(|instruction| match instruction.operands.as_slice() {
                    [Operand::IdRef(target), Operand::Decoration(Decoration::NonUniform)]
                        if instruction.class.opcode == Op::Decorate =>
                    {
                        Some(*target)
                    }
                    _ => None,
                })
                .collect();
            let mut derived = FastHashSet::default();
            derived.insert(resource);
            for instruction in parsed
                .functions
                .iter()
                .flat_map(|function| &function.blocks)
                .flat_map(|block| &block.instructions)
            {
                let pointer = match instruction.class.opcode {
                    Op::AccessChain | Op::InBoundsAccessChain | Op::CopyObject | Op::Load => {
                        instruction.operands.first().map(Operand::unwrap_id_ref)
                    }
                    _ => None,
                };
                if pointer.is_some_and(|pointer| derived.contains(&pointer)) {
                    derived.insert(instruction.result_id.unwrap());
                }
            }
            assert_eq!(
                nonuniform_targets
                    .iter()
                    .any(|target| *target != resource && derived.contains(target)),
                is_volatile
            );
            assert_eq!(
                parsed.capabilities.iter().any(|instruction| {
                    instruction.operands == [Operand::Capability(Capability::ShaderNonUniform)]
                }),
                is_volatile
            );
        }
    }
}
