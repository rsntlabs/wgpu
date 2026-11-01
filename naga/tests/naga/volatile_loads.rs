#![cfg(feature = "wgsl-in")]

use naga::compact::{compact, KeepUnused};
use naga::valid::{Capabilities, ModuleInfo, ValidationFlags, Validator};

const SOURCE: &str = include_str!("../in/wgsl/volatile-loads.wgsl");

#[derive(Clone, Copy, Debug, PartialEq)]
pub(super) enum Scope {
    Root,
    Conditional,
    Loop,
}

#[derive(Debug, PartialEq)]
pub(super) struct Access {
    pub(super) write: bool,
    pub(super) index: Option<u32>,
    pub(super) scope: Scope,
}

fn validate(module: &naga::Module) -> ModuleInfo {
    Validator::new(
        ValidationFlags::all(),
        Capabilities::MEMORY_DECORATION_VOLATILE,
    )
    .validate(module)
    .unwrap()
}

fn unnamed_module() -> naga::Module {
    let mut module = naga::front::wgsl::parse_str(SOURCE).unwrap();
    // WGSL keeps phony assignments alive by naming their values.
    clear_names(&mut module);
    validate(&module);
    module
}

pub(super) fn clear_names(module: &mut naga::Module) {
    for (_, function) in module.functions.iter_mut() {
        function.named_expressions.clear();
    }
    for entry in &mut module.entry_points {
        entry.function.named_expressions.clear();
    }
}

fn functions(module: &naga::Module) -> impl Iterator<Item = &naga::Function> {
    module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
}

fn split_function_module() -> naga::Module {
    let mut module = naga::front::wgsl::parse_str(
        "struct Data { values: array<u32>, }
        @group(0) @binding(0) @volatile var<storage, read_write> watched: Data;
        @group(0) @binding(1) var<storage, read_write> ordinary: Data;
        fn observe() { _ = watched.values[0]; }
        @compute @workgroup_size(1) fn main() { observe(); _ = ordinary.values[0]; }",
    )
    .unwrap();
    clear_names(&mut module);
    validate(&module);
    module
}

fn pointer_root(
    function: &naga::Function,
    mut pointer: naga::Handle<naga::Expression>,
) -> Option<(naga::Handle<naga::GlobalVariable>, Option<u32>)> {
    let mut index = None;
    let mut indexed = false;
    loop {
        match function.expressions[pointer] {
            naga::Expression::GlobalVariable(global) => return Some((global, index)),
            naga::Expression::AccessIndex {
                base,
                index: element,
            } => {
                if !indexed {
                    index = Some(element);
                    indexed = true;
                }
                pointer = base;
            }
            naga::Expression::Access {
                base,
                index: element,
            } => {
                if !indexed {
                    index = match function.expressions[element] {
                        naga::Expression::Literal(naga::Literal::U32(value)) => Some(value),
                        naga::Expression::Literal(naga::Literal::I32(value)) => {
                            u32::try_from(value).ok()
                        }
                        _ => None,
                    };
                    indexed = true;
                }
                pointer = base;
            }
            _ => return None,
        }
    }
}

pub(super) fn global_accesses(
    module: &naga::Module,
    global: naga::Handle<naga::GlobalVariable>,
) -> Vec<Access> {
    fn visit(
        function: &naga::Function,
        block: &naga::Block,
        global: naga::Handle<naga::GlobalVariable>,
        scope: Scope,
        output: &mut Vec<Access>,
    ) {
        for statement in block {
            match *statement {
                naga::Statement::Emit(ref range) => {
                    for expression in range.clone() {
                        if let naga::Expression::Load { pointer } = function.expressions[expression]
                        {
                            if let Some((root, index)) = pointer_root(function, pointer) {
                                if root == global {
                                    output.push(Access {
                                        write: false,
                                        index,
                                        scope,
                                    });
                                }
                            }
                        }
                    }
                }
                naga::Statement::Store { pointer, .. } => {
                    if let Some((root, index)) = pointer_root(function, pointer) {
                        if root == global {
                            output.push(Access {
                                write: true,
                                index,
                                scope,
                            });
                        }
                    }
                }
                naga::Statement::Block(ref body) => visit(function, body, global, scope, output),
                naga::Statement::If {
                    ref accept,
                    ref reject,
                    ..
                } => {
                    visit(function, accept, global, Scope::Conditional, output);
                    visit(function, reject, global, Scope::Conditional, output);
                }
                naga::Statement::Switch { ref cases, .. } => {
                    for case in cases {
                        visit(function, &case.body, global, Scope::Conditional, output);
                    }
                }
                naga::Statement::Loop {
                    ref body,
                    ref continuing,
                    ..
                } => {
                    visit(function, body, global, Scope::Loop, output);
                    visit(function, continuing, global, Scope::Loop, output);
                }
                _ => {}
            }
        }
    }
    let mut output = Vec::new();
    for function in functions(module) {
        visit(function, &function.body, global, Scope::Root, &mut output);
    }
    output
}

fn accesses(module: &naga::Module, binding: u32) -> Vec<Access> {
    let Some((global, _)) = module.global_variables.iter().find(|(_, variable)| {
        variable
            .binding
            .as_ref()
            .is_some_and(|resource| resource.group == 0 && resource.binding == binding)
    }) else {
        return Vec::new();
    };
    global_accesses(module, global)
}

fn assert_volatile_accesses(module: &naga::Module) {
    let expected = [
        (false, Some(0), Scope::Root),
        (true, Some(0), Scope::Root),
        (false, Some(0), Scope::Root),
        (false, Some(1), Scope::Root),
        (false, Some(1), Scope::Root),
        (false, Some(2), Scope::Root),
        (false, Some(2), Scope::Root),
        (false, Some(3), Scope::Root),
        (false, Some(3), Scope::Conditional),
        (false, None, Scope::Loop),
        (false, Some(0), Scope::Root),
    ]
    .map(|(write, index, scope)| Access {
        write,
        index,
        scope,
    });
    assert_eq!(accesses(module, 0), expected);
    let (_, watched) = module
        .global_variables
        .iter()
        .find(|(_, variable)| {
            variable
                .binding
                .as_ref()
                .is_some_and(|resource| resource.binding == 0)
        })
        .unwrap();
    assert!(watched
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
}

fn arena_reads(module: &naga::Module, binding: u32) -> usize {
    functions(module)
        .map(|function| {
            function
                .expressions
                .iter()
                .filter(|&(_, expression)| {
                    let naga::Expression::Load { pointer } = *expression else {
                        return false;
                    };
                    pointer_root(function, pointer).is_some_and(|(global, _)| {
                        module.global_variables[global]
                            .binding
                            .as_ref()
                            .is_some_and(|resource| resource.binding == binding)
                    })
                })
                .count()
        })
        .sum()
}

#[test]
fn volatile_reads_survive_compaction_without_retaining_ordinary_unused_reads() {
    let mut switched = naga::front::wgsl::parse_str(
        "@group(0) @binding(0) @volatile var<storage, read_write> watched: array<u32>;
        @compute @workgroup_size(4) fn main(@builtin(local_invocation_id) lane: vec3<u32>) {
            switch lane.x {
                case 0u: { _ = watched[0]; }
                case 1u: { watched[1] = 7u; }
                default: { _ = watched[2]; }
            }
        }",
    )
    .unwrap();
    clear_names(&mut switched);
    validate(&switched);
    for keep_unused in [KeepUnused::Yes, KeepUnused::No] {
        let mut module = switched.clone();
        compact(&mut module, keep_unused);
        validate(&module);
        assert_eq!(
            accesses(&module, 0),
            [(false, 0), (true, 1), (false, 2)].map(|(write, index)| Access {
                write,
                index: Some(index),
                scope: Scope::Conditional,
            })
        );
    }
    let mut source = unnamed_module();
    assert_volatile_accesses(&source);
    assert_eq!(accesses(&source, 1).len(), 2);
    let function = &mut source.entry_points[0].function;
    let pointer = function
        .expressions
        .iter()
        .find_map(|(_, expression)| {
            if let naga::Expression::Load { pointer } = *expression {
                pointer_root(function, pointer).and_then(|(global, _)| {
                    source.global_variables[global]
                        .binding
                        .as_ref()
                        .is_some_and(|resource| resource.binding == 0)
                        .then_some(pointer)
                })
            } else {
                None
            }
        })
        .unwrap();
    function
        .expressions
        .append(naga::Expression::Load { pointer }, naga::Span::UNDEFINED);
    assert_eq!(arena_reads(&source, 0), 11);
    validate(&source);
    for keep_unused in [KeepUnused::Yes, KeepUnused::No] {
        let mut module = source.clone();
        compact(&mut module, keep_unused);
        validate(&module);
        assert_volatile_accesses(&module);
        assert_eq!(arena_reads(&module, 0), 10);
        assert!(accesses(&module, 1).is_empty());
        let first = format!("{module:?}");
        compact(&mut module, keep_unused);
        validate(&module);
        assert_eq!(format!("{module:?}"), first);
    }
    #[cfg(any(hlsl_out, glsl_out, msl_out, spv_out))]
    {
        let source = format!(
        "override selected_size: u32 = 1u;\n{}\n@compute @workgroup_size(1) fn alternate() {{}}",
        SOURCE.replace("@workgroup_size(1)", "@workgroup_size(selected_size)")
    );
        let mut module = naga::front::wgsl::parse_str(&source).unwrap();
        clear_names(&mut module);
        let info = validate(&module);
        let (selected, _) = naga::back::pipeline_constants::process_overrides(
            &module,
            &info,
            Some((naga::ShaderStage::Compute, "main")),
            &[("selected_size".to_string(), 2.0)].into_iter().collect(),
        )
        .unwrap();
        validate(&selected);
        assert_eq!(selected.entry_points.len(), 1);
        assert_eq!(selected.entry_points[0].workgroup_size, [2, 1, 1]);
        assert_volatile_accesses(&selected);
        assert!(accesses(&selected, 1).is_empty());
    }
}

#[cfg(feature = "wgsl-out")]
fn assert_wgsl_roundtrip(module: &naga::Module) {
    let info = validate(module);
    for flags in [
        naga::back::wgsl::WriterFlags::empty(),
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    ] {
        let output = naga::back::wgsl::write_string(module, &info, flags).unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output)
            .unwrap_or_else(|error| panic!("{}\n{output}", error.emit_to_string(&output)));
        validate(&reparsed);
        assert_volatile_accesses(&reparsed);
        assert!(accesses(&reparsed, 1).is_empty(), "{output}");
    }
}

#[cfg(feature = "wgsl-out")]
#[test]
fn wgsl_preserves_unused_volatile_reads_without_prior_compaction() {
    assert_wgsl_roundtrip(&unnamed_module());
    let module = split_function_module();
    let info = validate(&module);
    for flags in [
        naga::back::wgsl::WriterFlags::empty(),
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    ] {
        let output = naga::back::wgsl::write_string(&module, &info, flags).unwrap();
        let reparsed = naga::front::wgsl::parse_str(&output).unwrap();
        validate(&reparsed);
        assert_eq!(arena_reads(&reparsed, 0), 1, "{output}");
        assert!(accesses(&reparsed, 1).is_empty(), "{output}");
    }
}

#[cfg(feature = "wgsl-out")]
#[test]
fn wgsl_preserves_volatile_read_order_and_control_flow_after_compaction() {
    let mut module = unnamed_module();
    compact(&mut module, KeepUnused::No);
    assert_wgsl_roundtrip(&module);
}

#[cfg(spv_out)]
#[test]
fn spirv_preserves_each_volatile_read_and_the_intervening_store() {
    use naga::FastHashMap;
    use rspirv::dr::Operand;
    use spirv::{Decoration, Op};

    #[cfg(feature = "spv-in")]
    {
        let named = naga::front::wgsl::parse_str(SOURCE).unwrap();
        let words = naga::back::spv::write_vec(
            &named,
            &validate(&named),
            &naga::back::spv::Options::default(),
            None,
        )
        .unwrap();
        let bytes: Vec<_> = words.iter().flat_map(|word| word.to_le_bytes()).collect();
        let mut imported = naga::front::spv::parse_u8_slice(
            &bytes,
            &naga::front::spv::Options {
                adjust_coordinate_space: true,
                strict_capabilities: false,
                block_ctx_dump_prefix: None,
            },
        )
        .unwrap();
        clear_names(&mut imported);
        validate(&imported);
        assert_eq!(arena_reads(&imported, 0), 10);
        compact(&mut imported, KeepUnused::No);
        validate(&imported);
        assert_eq!(arena_reads(&imported, 0), 10);
        assert!(accesses(&imported, 1).is_empty());
    }

    for should_compact in [false, true] {
        let mut module = unnamed_module();
        if should_compact {
            compact(&mut module, KeepUnused::No);
        }
        let info = validate(&module);
        let words = naga::back::spv::write_vec(
            &module,
            &info,
            &naga::back::spv::Options::default(),
            Some(&naga::back::spv::PipelineOptions {
                entry_point: "main".into(),
                shader_stage: naga::ShaderStage::Compute,
            }),
        )
        .unwrap();
        let parsed = rspirv::dr::load_words(words).unwrap();
        let mut roots = FastHashMap::default();
        let mut volatile = Vec::new();
        for instruction in &parsed.annotations {
            if instruction.class.opcode == Op::Decorate {
                match instruction.operands.as_slice() {
                    [Operand::IdRef(variable), Operand::Decoration(Decoration::Binding), Operand::LiteralBit32(binding)] =>
                    {
                        roots.insert(*variable, (*binding, None));
                    }
                    [Operand::IdRef(variable), Operand::Decoration(Decoration::Volatile)] => {
                        volatile.push(*variable)
                    }
                    _ => {}
                }
            }
        }
        assert!(volatile.iter().any(|variable| roots
            .get(variable)
            .is_some_and(|&(binding, _)| binding == 0)));
        let constants: FastHashMap<_, _> = parsed
            .types_global_values
            .iter()
            .filter_map(|instruction| {
                if instruction.class.opcode != Op::Constant {
                    return None;
                }
                match instruction.operands.as_slice() {
                    [Operand::LiteralBit32(value)] => {
                        Some((instruction.result_id.unwrap(), *value))
                    }
                    _ => None,
                }
            })
            .collect();
        let mut watched_accesses = Vec::new();
        let mut ordinary_reads = 0;
        for instruction in parsed
            .functions
            .iter()
            .flat_map(|function| &function.blocks)
            .flat_map(|block| &block.instructions)
        {
            match instruction.class.opcode {
                Op::AccessChain | Op::InBoundsAccessChain => {
                    let base = instruction.operands[0].unwrap_id_ref();
                    if let Some(&(binding, _)) = roots.get(&base) {
                        let index = instruction
                            .operands
                            .last()
                            .and_then(|operand| constants.get(&operand.unwrap_id_ref()))
                            .copied();
                        roots.insert(instruction.result_id.unwrap(), (binding, index));
                    }
                }
                Op::Load | Op::Store => {
                    let pointer = instruction.operands[0].unwrap_id_ref();
                    if let Some(&(binding, index)) = roots.get(&pointer) {
                        if binding == 0 {
                            watched_accesses.push((instruction.class.opcode == Op::Store, index));
                        }
                        if binding == 1 && instruction.class.opcode == Op::Load {
                            ordinary_reads += 1;
                        }
                    }
                }
                _ => {}
            }
        }
        assert_eq!(
            watched_accesses,
            [
                (false, Some(0)),
                (true, Some(0)),
                (false, Some(0)),
                (false, Some(1)),
                (false, Some(1)),
                (false, Some(2)),
                (false, Some(2)),
                (false, Some(3)),
                (false, Some(3)),
                (false, None),
                (false, Some(0)),
            ]
        );
        assert_eq!(ordinary_reads, 0);
    }
}

#[cfg(feature = "glsl-out")]
#[test]
fn glsl_preserves_unnamed_volatile_reads_before_and_after_compaction() {
    for should_compact in [false, true] {
        let mut module = unnamed_module();
        if should_compact {
            compact(&mut module, KeepUnused::No);
        }
        let info = validate(&module);
        let mut output = String::new();
        naga::back::glsl::Writer::new(
            &mut output,
            &module,
            &info,
            &naga::back::glsl::Options {
                version: naga::back::glsl::Version::Desktop(430),
                ..Default::default()
            },
            &naga::back::glsl::PipelineOptions {
                shader_stage: naga::ShaderStage::Compute,
                entry_point: "main".into(),
                multiview: None,
            },
            naga::proc::BoundsCheckPolicies::default(),
        )
        .unwrap()
        .write()
        .unwrap();
        let declaration = output.split_once("volatile buffer").unwrap().1;
        let instance = declaration
            .split_once('}')
            .unwrap()
            .1
            .split_once(';')
            .unwrap()
            .0
            .trim();
        assert!(!instance.is_empty(), "{output}");
        let accesses = format!("{instance}.values[");
        assert_eq!(output.matches(&accesses).count(), 11, "{output}");
    }
}
