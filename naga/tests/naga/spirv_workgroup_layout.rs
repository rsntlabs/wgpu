#![cfg(all(feature = "wgsl-in", spv_out))]

use naga::valid::{Capabilities, ValidationFlags, Validator};
use naga::{FastHashSet, ShaderStage};
use rspirv::dr::{Instruction, Module, Operand};
use spirv::{Decoration, Op};

pub(super) const MESH_COMPOSITE_SOURCE: &str = "enable wgpu_mesh_shader;
        enable clip_distances;
        struct VertexOutput {
            @builtin(position) position: vec4<f32>,
            @builtin(clip_distances) distances: array<f32, 2>,
        }
        struct PrimitiveOutput { @builtin(triangle_indices) indices: vec3<u32>, }
        struct MeshOutput {
            @builtin(vertices) vertices: array<VertexOutput, 3>,
            @builtin(primitives) primitives: array<PrimitiveOutput, 1>,
            @builtin(vertex_count) vertex_count: u32,
            @builtin(primitive_count) primitive_count: u32,
        }
        var<workgroup> mesh_output: MeshOutput;
        @mesh(mesh_output) @workgroup_size(1) fn main() {
            mesh_output.vertex_count = 3u;
            mesh_output.primitive_count = 1u;
            for (var vertex = 0u; vertex < 3u; vertex++) {
                mesh_output.vertices[vertex].position = vec4<f32>(f32(vertex), 0.0, 0.0, 1.0);
                mesh_output.vertices[vertex].distances = array<f32, 2>(1.0, 2.0);
            }
            mesh_output.primitives[0].indices = vec3<u32>(0u, 1u, 2u);
        }";

fn emit(source: &str, version: (u8, u8)) -> (naga::Module, Module, usize) {
    emit_entry(
        source,
        version,
        Capabilities::empty(),
        ShaderStage::Compute,
        "main",
        if version == (1, 0) {
            "vulkan1.0"
        } else {
            "vulkan1.1spv1.4"
        },
    )
}

fn emit_entry(
    source: &str,
    version: (u8, u8),
    capabilities: Capabilities,
    stage: ShaderStage,
    entry_point: &str,
    target_env: &str,
) -> (naga::Module, Module, usize) {
    let module = naga::front::wgsl::parse_str(source).unwrap();
    let info = Validator::new(ValidationFlags::all(), capabilities)
        .validate(&module)
        .unwrap();
    let mut options = naga::back::spv::Options {
        lang_version: version,
        ..Default::default()
    };
    options.flags |= naga::back::spv::WriterFlags::DEBUG;
    let words = naga::back::spv::write_vec(
        &module,
        &info,
        &options,
        Some(&naga::back::spv::PipelineOptions {
            shader_stage: stage,
            entry_point: entry_point.into(),
        }),
    )
    .unwrap();
    super::helpers::validate_spirv_with_target_env(&words, Some(target_env));
    let length = words.len();
    (module, rspirv::dr::load_words(words).unwrap(), length)
}

#[test]
fn spirv_mesh_and_task_helpers_use_the_actual_workgroup_pointee_types() {
    let triangles = include_str!("../in/wgsl/mesh-shader.wgsl");
    for (stage, entry) in [
        (ShaderStage::Task, "ts_main"),
        (ShaderStage::Task, "ts_divergent"),
        (ShaderStage::Mesh, "ms_main"),
        (ShaderStage::Mesh, "ms_no_ts"),
        (ShaderStage::Mesh, "ms_divergent"),
    ] {
        let (_, parsed, _) = emit_entry(
            triangles,
            (1, 4),
            Capabilities::MESH_SHADER,
            stage,
            entry,
            "vulkan1.3",
        );
        if stage == ShaderStage::Mesh {
            assert_implicit_workgroup_layout(&parsed, "mesh_output");
        }
    }
    let points = include_str!("../in/wgsl/mesh-shader-points.wgsl");
    for (stage, entry) in [
        (ShaderStage::Task, "ts_main"),
        (ShaderStage::Mesh, "ms_main"),
    ] {
        let (_, parsed, _) = emit_entry(
            points,
            (1, 4),
            Capabilities::MESH_SHADER | Capabilities::MESH_SHADER_POINT_TOPOLOGY,
            stage,
            entry,
            "vulkan1.3",
        );
        if stage == ShaderStage::Mesh {
            assert_implicit_workgroup_layout(&parsed, "mesh_output");
        }
    }
    let composite = MESH_COMPOSITE_SOURCE;
    let (_, parsed, _) = emit_entry(
        composite,
        (1, 4),
        Capabilities::MESH_SHADER | Capabilities::CLIP_DISTANCES,
        ShaderStage::Mesh,
        "main",
        "vulkan1.3",
    );
    assert_implicit_workgroup_layout(&parsed, "mesh_output");
}

fn definition(module: &Module, id: u32) -> &Instruction {
    module
        .types_global_values
        .iter()
        .find(|instruction| instruction.result_id == Some(id))
        .unwrap()
}

fn named_id(module: &Module, name: &str) -> u32 {
    module
        .debug_names
        .iter()
        .find_map(|instruction| match instruction.operands.as_slice() {
            [Operand::IdRef(id), Operand::LiteralString(actual)]
                if instruction.class.opcode == Op::Name && actual == name =>
            {
                Some(*id)
            }
            _ => None,
        })
        .unwrap()
}

fn pointee(module: &Module, variable: u32) -> u32 {
    let pointer = definition(module, definition(module, variable).result_type.unwrap());
    assert_eq!(pointer.class.opcode, Op::TypePointer);
    pointer.operands[1].unwrap_id_ref()
}

fn type_graph(module: &Module, root: u32) -> FastHashSet<u32> {
    let mut used = FastHashSet::default();
    let mut pending = vec![root];
    while let Some(id) = pending.pop() {
        if !used.insert(id) {
            continue;
        }
        let instruction = definition(module, id);
        match instruction.class.opcode {
            Op::TypeStruct => {
                pending.extend(instruction.operands.iter().map(Operand::unwrap_id_ref))
            }
            Op::TypeArray | Op::TypeRuntimeArray | Op::TypeMatrix | Op::TypeVector => {
                pending.push(instruction.operands[0].unwrap_id_ref())
            }
            _ => {}
        }
    }
    used
}

fn assert_implicit_workgroup_layout(module: &Module, name: &str) -> u32 {
    let root = pointee(module, named_id(module, name));
    let graph = type_graph(module, root);
    for instruction in &module.annotations {
        if !matches!(instruction.class.opcode, Op::Decorate | Op::MemberDecorate) {
            continue;
        }
        let target = instruction.operands[0].unwrap_id_ref();
        if !graph.contains(&target) {
            continue;
        }
        for operand in &instruction.operands {
            assert!(
                !matches!(
                    operand,
                    Operand::Decoration(
                        Decoration::Offset
                            | Decoration::ArrayStride
                            | Decoration::MatrixStride
                            | Decoration::RowMajor
                            | Decoration::ColMajor
                            | Decoration::Block
                            | Decoration::BufferBlock
                    )
                ),
                "workgroup {name}: {instruction:?}"
            );
        }
    }
    root
}

fn member_offset(module: &Module, structure: u32, member: u32) -> u32 {
    module.annotations.iter().find_map(|instruction| match instruction.operands.as_slice() {
        [Operand::IdRef(target), Operand::LiteralBit32(index), Operand::Decoration(Decoration::Offset), Operand::LiteralBit32(offset)]
            if instruction.class.opcode == Op::MemberDecorate && *target == structure && *index == member => Some(*offset),
        _ => None,
    }).unwrap()
}

fn assert_storage_layout(module: &Module) -> u32 {
    let graph = type_graph(module, pointee(module, named_id(module, "data")));
    let block = graph
        .iter()
        .copied()
        .find(|&id| {
            let instruction = definition(module, id);
            if instruction.class.opcode != Op::TypeStruct || instruction.operands.len() != 2 {
                return false;
            }
            let array = definition(module, instruction.operands[1].unwrap_id_ref());
            array.class.opcode == Op::TypeArray && array.operands[0] == instruction.operands[0]
        })
        .unwrap();
    let members = &definition(module, block).operands;
    let leaf = members[0].unwrap_id_ref();
    assert_eq!(
        [
            member_offset(module, block, 0),
            member_offset(module, block, 1)
        ],
        [0, 32]
    );
    assert_eq!(
        [
            member_offset(module, leaf, 0),
            member_offset(module, leaf, 1),
            member_offset(module, leaf, 2)
        ],
        [0, 16, 28]
    );
    let array = members[1].unwrap_id_ref();
    assert!(module.annotations.iter().any(|instruction| {
        instruction.class.opcode == Op::Decorate
            && instruction.operands
                == [
                    Operand::IdRef(array),
                    Operand::Decoration(Decoration::ArrayStride),
                    Operand::LiteralBit32(32),
                ]
    }));
    block
}

#[test]
fn spirv_workgroup_nested_records_arrays_matrices_and_booleans_have_implicit_layout() {
    let source = "struct Leaf { ready: bool, vector: vec3<f32>, matrix: mat3x2<f32>, values: array<u32, 4>, }
        struct Block { leaves: array<Leaf, 2>, rows: array<array<i32, 3>, 2>, }
        var<workgroup> scratch: Block;
        @group(0) @binding(0) var<storage, read_write> output: array<u32>;
        @compute @workgroup_size(1) fn main(@builtin(local_invocation_index) lane: u32) {
            scratch.leaves[0].ready = true;
            scratch.leaves[0].vector = vec3<f32>(2.0, 3.0, 5.0);
            scratch.leaves[1].matrix = mat3x2<f32>(vec2<f32>(7.0, 11.0), vec2<f32>(13.0, 17.0), vec2<f32>(19.0, 23.0));
            scratch.leaves[0].values[lane] = 7u;
            scratch.rows[1][0] = -3;
            output[0] = select(0u, 1u, scratch.leaves[0].ready);
            output[1] = u32(scratch.leaves[1].matrix[2][1]);
            output[2] = scratch.leaves[0].values[lane] + u32(scratch.rows[1][0]);
        }";
    let (_, parsed, _) = emit(source, (1, 0));
    assert_implicit_workgroup_layout(&parsed, "scratch");
}

#[test]
fn spirv_storage_and_workgroup_views_share_source_types_and_preserve_aggregate_copies() {
    let prelude = "struct Leaf { first: u32, vector: vec3<u32>, last: u32, }
        struct Block { leaf: Leaf, rows: array<Leaf, 2>, }
        @group(0) @binding(0) var<storage, read_write> data: Block;
        var<workgroup> scratch: Block;
        fn identity(value: Block) -> Block { return value; }";
    for version in [(1, 0), (1, 4)] {
        let source = if version == (1, 0) {
            format!(
                "{prelude} var<private> saved: Block;
                @compute @workgroup_size(1) fn main() {{
                    saved = identity(data); scratch = saved; workgroupBarrier();
                    var local = scratch; local.rows[1].last += 1u; data = identity(local);
                }}"
            )
        } else {
            format!(
                "{prelude} @compute @workgroup_size(1) fn main() {{
                let original = identity(data); scratch = original; workgroupBarrier();
                let copied = identity(scratch); data = copied;
            }}"
            )
        };
        let (module, parsed, _) = emit(&source, version);
        let source_type = |name| {
            module
                .global_variables
                .iter()
                .find_map(|(_, variable)| {
                    (variable.name.as_deref() == Some(name)).then_some(variable.ty)
                })
                .unwrap()
        };
        assert_eq!(source_type("data"), source_type("scratch"));
        let workgroup = assert_implicit_workgroup_layout(&parsed, "scratch");
        let storage = assert_storage_layout(&parsed);
        assert_ne!(workgroup, storage);
        if version >= (1, 4) {
            assert!(module
                .functions
                .iter()
                .all(|(_, function)| function.local_variables.is_empty()));
            assert!(module.entry_points[0].function.local_variables.is_empty());
            assert!(parsed
                .functions
                .iter()
                .flat_map(|function| &function.blocks)
                .flat_map(|block| &block.instructions)
                .any(|instruction| instruction.class.opcode == Op::CopyLogical));
        }
    }
}

#[test]
fn spirv_workgroup_aggregate_conversion_size_is_bounded_by_type_structure() {
    fn array_source(length: u32) -> String {
        format!("struct Block {{ values: array<u32, {length}>, }}
            @group(0) @binding(0) var<storage, read_write> data: Block;
            var<workgroup> scratch: Block;
            @compute @workgroup_size(1) fn main() {{ scratch = data; workgroupBarrier(); data = scratch; }}")
    }
    for version in [(1, 0), (1, 4)] {
        let (_, _, small) = emit(&array_source(8), version);
        let (_, large, size) = emit(&array_source(65536), version);
        assert_implicit_workgroup_layout(&large, "scratch");
        assert!(
            size <= small + 1024,
            "{version:?}: {small} words became {size}"
        );
        let mut source = "struct Level0 { value: u32, }\n".to_string();
        for level in 1..=14 {
            source.push_str(&format!(
                "struct Level{level} {{ left: Level{}, right: Level{}, }}\n",
                level - 1,
                level - 1
            ));
        }
        source.push_str("@group(0) @binding(0) var<storage, read_write> data: Level14; var<workgroup> scratch: Level14; @compute @workgroup_size(1) fn main() { scratch = data; workgroupBarrier(); data = scratch; }");
        let (_, parsed, size) = emit(&source, version);
        assert_implicit_workgroup_layout(&parsed, "scratch");
        assert!(
            size < 20000,
            "{version:?}: repeated record graph produced {size} words"
        );
    }
}
