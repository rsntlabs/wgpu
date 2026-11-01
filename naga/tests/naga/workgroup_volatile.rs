#![cfg(feature = "wgsl-in")]

use naga::compact::{compact, KeepUnused};
use naga::valid::{Capabilities, ModuleInfo, ValidationFlags, Validator};

use super::volatile_loads::{clear_names, global_accesses, Access, Scope};

const WORKGROUP_VOLATILE: Capabilities = Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP;
const SOURCE: &str = "struct Inner { values: array<u32, 4>, }
    struct Block { inner: Inner, }
    @volatile var<workgroup> watched: Block;
    var<workgroup> ordinary: Block;
    @group(0) @binding(0) var<storage, read_write> output: array<u32>;
    @group(0) @binding(1) var<storage, read> source: array<u32>;
    @compute @workgroup_size(4) fn main(@builtin(local_invocation_index) lane: u32) {
        _ = watched.inner.values[0];
        watched.inner.values[0] = 1u;
        _ = watched.inner.values[0];
        let value = watched.inner.values[1];
        output[0] = value + value;
        _ = watched.inner.values[2] + watched.inner.values[3];
        if lane == 0u { _ = watched.inner.values[3]; }
        for (var iteration = 0u; iteration < 2u; iteration++) {
            _ = watched.inner.values[iteration];
        }
        let read_index = watched.inner.values[0] & 3u;
        _ = ordinary.inner.values[read_index];
        watched.inner.values[lane] = value;
        output[1] = ordinary.inner.values[0];
        output[2] = source[0];
        output[3] = workgroupUniformLoad(&watched.inner.values[0]);
    }";

fn validate(module: &naga::Module, capabilities: Capabilities) -> ModuleInfo {
    Validator::new(ValidationFlags::all(), capabilities)
        .validate(module)
        .unwrap()
}

fn global(module: &naga::Module, name: &str) -> naga::Handle<naga::GlobalVariable> {
    module
        .global_variables
        .iter()
        .find_map(|(handle, variable)| (variable.name.as_deref() == Some(name)).then_some(handle))
        .unwrap()
}

fn rejected(source: &str, capabilities: Capabilities) {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    assert!(
        Validator::new(ValidationFlags::all(), capabilities)
            .validate(&module)
            .is_err(),
        "{source}"
    );
}

#[test]
fn workgroup_volatile_requires_a_capability_separate_from_storage() {
    let workgroup = naga::front::wgsl::parse_str("@volatile var<workgroup> watched: u32; @compute @workgroup_size(1) fn main() { _ = watched; }").unwrap();
    let storage = naga::front::wgsl::parse_str("@group(0) @binding(0) @volatile var<storage, read> watched: u32; @compute @workgroup_size(1) fn main() { _ = watched; }").unwrap();
    for caps in [
        Capabilities::empty(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
    ] {
        assert!(Validator::new(ValidationFlags::all(), caps)
            .validate(&workgroup)
            .is_err());
    }
    assert!(Validator::new(ValidationFlags::all(), WORKGROUP_VOLATILE)
        .validate(&storage)
        .is_err());
    validate(&workgroup, WORKGROUP_VOLATILE);
    validate(&storage, Capabilities::MEMORY_DECORATION_VOLATILE);
    let both = WORKGROUP_VOLATILE | Capabilities::MEMORY_DECORATION_VOLATILE;
    validate(&workgroup, both);
    validate(&storage, both);
    let boolean = naga::front::wgsl::parse_str("@volatile var<workgroup> watched: bool; @compute @workgroup_size(1) fn main() { _ = watched; }").unwrap();
    validate(&boolean, WORKGROUP_VOLATILE);
    for source in [
        "@coherent var<workgroup> watched: u32;",
        "@coherent @volatile var<workgroup> watched: u32;",
        "@volatile var<private> watched: u32;",
        "@group(0) @binding(0) @volatile var<uniform> watched: vec4<u32>;",
    ] {
        rejected(source, Capabilities::all() | WORKGROUP_VOLATILE);
    }
}

#[test]
fn workgroup_volatile_rejects_noncopyable_types_and_cooperative_memory_operations() {
    for declaration in [
        "@volatile var<workgroup> watched: atomic<u32>;",
        "@volatile var<workgroup> watched: array<atomic<i32>, 4>;",
        "struct Inner { counter: atomic<u32>, } struct Outer { nested: array<Inner, 2>, } @volatile var<workgroup> watched: Outer;",
    ] { rejected(declaration, Capabilities::all() | WORKGROUP_VOLATILE); }
    for declaration in [
        "@volatile var<workgroup> watched: coop_mat8x8<f32, C>;",
        "@volatile var<workgroup> watched: array<coop_mat8x8<f32, C>, 2>;",
        "struct Inner { matrix: coop_mat8x8<f32, C>, } struct Outer { nested: array<Inner, 2>, } @volatile var<workgroup> watched: Outer;",
    ] {
        rejected(&format!("enable wgpu_cooperative_matrix; {declaration}"), Capabilities::all() | WORKGROUP_VOLATILE);
    }
    for body in [
        "let matrix = coopLoad<coop_mat8x8<f32, C>>(&values[0]);",
        "coopStore(matrix, &values[0]);",
        "let pointer = &values[1]; let loaded = coopLoad<coop_mat8x8<f32, C>>(pointer);",
        "let pointer = &values[1]; coopStore(matrix, pointer);",
    ] {
        let source = format!(
            "enable wgpu_cooperative_matrix;
            var<private> matrix: coop_mat8x8<f32, C>;
            var<workgroup> values: array<f32, 128>;
            @compute @workgroup_size(8, 8) fn main() {{ {body} }}"
        );
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        validate(&module, Capabilities::COOPERATIVE_MATRIX);
        rejected(
            &source.replace("var<workgroup>", "@volatile var<workgroup>"),
            Capabilities::COOPERATIVE_MATRIX | WORKGROUP_VOLATILE,
        );
    }
    for operation in [
        "let loaded = coopLoad<coop_mat8x8<f32, C>>(pointer);",
        "coopStore(matrix, pointer);",
    ] {
        let source = format!(
            "enable wgpu_cooperative_matrix;
            struct Rows {{ values: array<array<f32, 64>, 2>, }}
            var<private> matrix: coop_mat8x8<f32, C>;
            var<workgroup> rows: Rows;
            @compute @workgroup_size(8, 8) fn main() {{
                let pointer = &rows.values[1][0]; {operation}
            }}"
        );
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        validate(&module, Capabilities::COOPERATIVE_MATRIX);
        rejected(
            &source.replace("var<workgroup>", "@volatile var<workgroup>"),
            Capabilities::COOPERATIVE_MATRIX | WORKGROUP_VOLATILE,
        );
    }
}

fn assert_accesses(module: &naga::Module, ordinary_reads: usize) {
    let watched = global(module, "watched");
    assert_eq!(
        module.global_variables[watched].space,
        naga::AddressSpace::WorkGroup
    );
    assert!(module.global_variables[watched].binding.is_none());
    assert!(module.global_variables[watched]
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
    let expected = [
        (false, Some(0), Scope::Root),
        (true, Some(0), Scope::Root),
        (false, Some(0), Scope::Root),
        (false, Some(1), Scope::Root),
        (false, Some(2), Scope::Root),
        (false, Some(3), Scope::Root),
        (false, Some(3), Scope::Conditional),
        (false, None, Scope::Loop),
        (false, Some(0), Scope::Root),
        (true, None, Scope::Root),
    ]
    .map(|(write, index, scope)| Access {
        write,
        index,
        scope,
    });
    assert_eq!(global_accesses(module, watched), expected);
    assert_eq!(
        global_accesses(module, global(module, "ordinary")).len(),
        ordinary_reads
    );
    let mut uniform_loads = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        uniform_loads += usize::from(matches!(
            *statement,
            naga::Statement::WorkGroupUniformLoad { .. }
        ));
        false
    });
    assert_eq!(uniform_loads, 1);
}

#[test]
fn workgroup_volatile_reads_survive_compaction_and_native_wgsl_roundtrips() {
    let mut original = naga::front::wgsl::parse_str(SOURCE).unwrap();
    clear_names(&mut original);
    validate(&original, WORKGROUP_VOLATILE);
    assert_accesses(&original, 2);
    for mode in [None, Some(KeepUnused::Yes), Some(KeepUnused::No)] {
        let mut module = original.clone();
        if let Some(keep_unused) = mode {
            compact(&mut module, keep_unused);
        }
        let info = validate(&module, WORKGROUP_VOLATILE);
        assert!(info.get_entry_point(0)[global(&module, "watched")]
            .contains(naga::valid::GlobalUse::READ | naga::valid::GlobalUse::WRITE));
        assert_accesses(&module, if mode.is_some() { 1 } else { 2 });
        #[cfg(feature = "wgsl-out")]
        for flags in [
            naga::back::wgsl::WriterFlags::empty(),
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        ] {
            let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
            let reparsed = naga::front::wgsl::parse_str(&output).unwrap();
            validate(&reparsed, WORKGROUP_VOLATILE);
            assert_accesses(&reparsed, 1);
        }
    }
}

#[cfg(spv_out)]
#[test]
fn workgroup_volatile_spirv_uses_memory_access_operands_without_variable_decorations() {
    use naga::back::spv::{WriterFlags, ZeroInitializeWorkgroupMemoryMode};
    use naga::proc::{BoundsCheckPolicies, BoundsCheckPolicy};
    use naga::FastHashSet;
    use rspirv::dr::Operand;
    use spirv::{Decoration, MemoryAccess, Op, StorageClass};

    for policy in [
        BoundsCheckPolicy::Unchecked,
        BoundsCheckPolicy::ReadZeroSkipWrite,
    ] {
        for polyfill in [false, true] {
            let mut module = naga::front::wgsl::parse_str(SOURCE).unwrap();
            clear_names(&mut module);
            let info = validate(&module, WORKGROUP_VOLATILE);
            let mut options = naga::back::spv::Options {
                lang_version: (1, 0),
                bounds_check_policies: BoundsCheckPolicies {
                    index: policy,
                    buffer: policy,
                    ..Default::default()
                },
                zero_initialize_workgroup_memory: if polyfill {
                    ZeroInitializeWorkgroupMemoryMode::Polyfill
                } else {
                    ZeroInitializeWorkgroupMemoryMode::None
                },
                ..Default::default()
            };
            options.flags |= WriterFlags::DEBUG;
            let words = naga::back::spv::write_vec(
                &module,
                &info,
                &options,
                Some(&naga::back::spv::PipelineOptions {
                    shader_stage: naga::ShaderStage::Compute,
                    entry_point: "main".into(),
                }),
            )
            .unwrap();
            assert_eq!(words[1], 0x0001_0000);
            let parsed = rspirv::dr::load_words(words).unwrap();
            let watched = parsed
                .debug_names
                .iter()
                .find_map(|instruction| match instruction.operands.as_slice() {
                    [Operand::IdRef(variable), Operand::LiteralString(name)]
                        if instruction.class.opcode == Op::Name && name == "watched" =>
                    {
                        Some(*variable)
                    }
                    _ => None,
                })
                .unwrap();
            let variable = parsed
                .types_global_values
                .iter()
                .find(|instruction| instruction.result_id == Some(watched))
                .unwrap();
            assert!(matches!(
                variable.operands.first(),
                Some(Operand::StorageClass(StorageClass::Workgroup))
            ));
            assert!(!parsed.annotations.iter().any(|instruction| instruction
                .operands
                .iter()
                .any(|operand| matches!(operand, Operand::Decoration(Decoration::Volatile)))));
            let mut pointers = FastHashSet::default();
            pointers.insert(watched);
            let mut reads = 0;
            let mut writes = 0;
            let mut ordinary_reads = 0;
            let mut ordinary_writes = 0;
            for instruction in parsed
                .functions
                .iter()
                .flat_map(|function| &function.blocks)
                .flat_map(|block| &block.instructions)
            {
                match instruction.class.opcode {
                    Op::AccessChain | Op::InBoundsAccessChain | Op::CopyObject => {
                        if pointers.contains(&instruction.operands[0].unwrap_id_ref()) {
                            pointers.insert(instruction.result_id.unwrap());
                        }
                    }
                    Op::Load | Op::Store => {
                        let write = instruction.class.opcode == Op::Store;
                        let is_volatile = matches!(instruction.operands.get(if write { 2 } else { 1 }), Some(Operand::MemoryAccess(flags)) if flags.contains(MemoryAccess::VOLATILE));
                        let watched_access =
                            pointers.contains(&instruction.operands[0].unwrap_id_ref());
                        assert_eq!(is_volatile, watched_access, "{instruction:?}");
                        match (watched_access, write) {
                            (true, false) => reads += 1,
                            (true, true) => writes += 1,
                            (false, false) => ordinary_reads += 1,
                            (false, true) => ordinary_writes += 1,
                        }
                    }
                    _ => {}
                }
            }
            assert_eq!(reads, 9);
            assert_eq!(writes, if polyfill { 3 } else { 2 });
            assert!(ordinary_reads > 0 && ordinary_writes > 0);
        }
    }
}

#[test]
fn workgroup_volatile_is_rejected_by_unsupported_backends_even_with_validated_ir() {
    let source = "@volatile var<workgroup> watched: u32; @compute @workgroup_size(1) fn main() { _ = watched; }";
    for (text, volatile) in [
        (source.replace("@volatile", ""), false),
        (source.to_string(), true),
    ] {
        let module = naga::front::wgsl::parse_str(&text).unwrap();
        let info = validate(&module, Capabilities::all() | WORKGROUP_VOLATILE);
        #[cfg(feature = "wgsl-out")]
        assert!(naga::back::wgsl::supported_capabilities().contains(WORKGROUP_VOLATILE));
        #[cfg(spv_out)]
        assert!(naga::back::spv::supported_capabilities().contains(WORKGROUP_VOLATILE));
        #[cfg(feature = "glsl-out")]
        {
            assert!(!naga::back::glsl::supported_capabilities().contains(WORKGROUP_VOLATILE));
            let mut output = String::new();
            let result = naga::back::glsl::Writer::new(
                &mut output,
                &module,
                &info,
                &naga::back::glsl::Options::default(),
                &naga::back::glsl::PipelineOptions {
                    shader_stage: naga::ShaderStage::Compute,
                    entry_point: "main".into(),
                    multiview: None,
                },
                naga::proc::BoundsCheckPolicies::default(),
            )
            .and_then(|mut writer| writer.write());
            if volatile {
                assert!(result
                    .unwrap_err()
                    .to_string()
                    .contains("volatile workgroup"));
            } else {
                result.unwrap();
            }
        }
        #[cfg(hlsl_out)]
        {
            assert!(!naga::back::hlsl::supported_capabilities().contains(WORKGROUP_VOLATILE));
            let mut output = String::new();
            let options = naga::back::hlsl::Options::default();
            let pipeline = naga::back::hlsl::PipelineOptions::default();
            let result = naga::back::hlsl::Writer::new(&mut output, &options, &pipeline)
                .write(&module, &info, None);
            if volatile {
                assert!(result
                    .unwrap_err()
                    .to_string()
                    .contains("volatile workgroup"));
            } else {
                result.unwrap();
            }
        }
        #[cfg(msl_out)]
        {
            assert!(!naga::back::msl::supported_capabilities().contains(WORKGROUP_VOLATILE));
            let result = naga::back::msl::write_string(
                &module,
                &info,
                &Default::default(),
                &Default::default(),
            );
            if volatile {
                assert!(
                    matches!(result.unwrap_err(), naga::back::msl::Error::CapabilityNotSupported(capability) if capability == WORKGROUP_VOLATILE)
                );
            } else {
                result.unwrap();
            }
        }
    }
}

#[cfg(spv_out)]
#[test]
fn workgroup_volatile_mesh_helpers_flag_only_actual_workgroup_memory_accesses() {
    use naga::FastHashSet;
    use rspirv::dr::Operand;
    use spirv::{Decoration, MemoryAccess, Op, StorageClass};

    let ordinary = super::spirv_workgroup_layout::MESH_COMPOSITE_SOURCE;
    assert_eq!(ordinary.matches("var<workgroup> mesh_output").count(), 1);
    for volatile in [false, true] {
        let source = if volatile {
            ordinary.replace(
                "var<workgroup> mesh_output",
                "@volatile var<workgroup> mesh_output",
            )
        } else {
            ordinary.to_string()
        };
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        let info = validate(
            &module,
            Capabilities::MESH_SHADER | Capabilities::CLIP_DISTANCES | WORKGROUP_VOLATILE,
        );
        let mut options = naga::back::spv::Options {
            lang_version: (1, 4),
            ..Default::default()
        };
        options.flags |= naga::back::spv::WriterFlags::DEBUG;
        let words = naga::back::spv::write_vec(
            &module,
            &info,
            &options,
            Some(&naga::back::spv::PipelineOptions {
                shader_stage: naga::ShaderStage::Mesh,
                entry_point: "main".into(),
            }),
        )
        .unwrap();
        super::helpers::validate_spirv_with_target_env(&words, Some("vulkan1.3"));
        let parsed = rspirv::dr::load_words(words).unwrap();
        let output = parsed
            .debug_names
            .iter()
            .find_map(|instruction| match instruction.operands.as_slice() {
                [Operand::IdRef(variable), Operand::LiteralString(name)]
                    if instruction.class.opcode == Op::Name && name == "mesh_output" =>
                {
                    Some(*variable)
                }
                _ => None,
            })
            .unwrap();
        let variable = parsed
            .types_global_values
            .iter()
            .find(|instruction| instruction.result_id == Some(output))
            .unwrap();
        assert!(matches!(
            variable.operands.first(),
            Some(Operand::StorageClass(StorageClass::Workgroup))
        ));
        assert!(!parsed.annotations.iter().any(|instruction| instruction
            .operands
            .iter()
            .any(|operand| matches!(operand, Operand::Decoration(Decoration::Volatile)))));
        let mut pointers = FastHashSet::default();
        pointers.insert(output);
        let mut reads = 0;
        let mut writes = 0;
        let mut ordinary_accesses = 0;
        for instruction in parsed
            .functions
            .iter()
            .flat_map(|function| &function.blocks)
            .flat_map(|block| &block.instructions)
        {
            match instruction.class.opcode {
                Op::AccessChain | Op::InBoundsAccessChain | Op::CopyObject => {
                    if pointers.contains(&instruction.operands[0].unwrap_id_ref()) {
                        pointers.insert(instruction.result_id.unwrap());
                    }
                }
                Op::Load | Op::Store => {
                    let write = instruction.class.opcode == Op::Store;
                    let watched_access =
                        pointers.contains(&instruction.operands[0].unwrap_id_ref());
                    let has_flag = matches!(instruction.operands.get(if write { 2 } else { 1 }), Some(Operand::MemoryAccess(flags)) if flags.contains(MemoryAccess::VOLATILE));
                    assert_eq!(has_flag, volatile && watched_access, "{instruction:?}");
                    if watched_access {
                        if write {
                            writes += 1;
                        } else {
                            reads += 1;
                        }
                    } else {
                        ordinary_accesses += 1;
                    }
                }
                _ => {}
            }
        }
        assert!(
            reads >= 5,
            "synthetic count and composite member reads must be present"
        );
        assert!(writes > 0 && ordinary_accesses > 0);
    }
}
