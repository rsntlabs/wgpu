use std::{fs, process::Output};

mod common;

use common::TestFiles;

const CUDA: &str = "
__device__ unsigned first_helper(unsigned value) { return value + 1u; }
__device__ unsigned second_helper(unsigned value) { return value + 2u; }
__global__ void first(unsigned *first_output) { first_output[0] = first_helper(threadIdx.x); }
__global__ void second(unsigned *second_output) { second_output[0] = second_helper(threadIdx.x); }
";

const WGSL: &str = "
@group(0) @binding(0) var<storage, read_write> first_output: array<u32>;
@group(0) @binding(1) var<storage, read_write> second_output: array<u32>;
fn first_helper(value: u32) -> u32 { return value + 1u; }
fn second_helper(value: u32) -> u32 { return value + 2u; }
@compute @workgroup_size(2, 3, 1)
fn first() { first_output[0] = first_helper(3u); }
@compute @workgroup_size(4, 1, 2)
fn second() { second_output[0] = second_helper(5u); }
";

const OVERRIDES: &str = "
@id(7) override selected_size: u32 = 2u;
override selected_value: u32 = 5u;
override other_size: u32;
@group(0) @binding(0) var<storage, read_write> first_output: array<u32>;
@group(0) @binding(1) var<storage, read_write> second_output: array<u32>;
fn first_helper() -> u32 { return selected_value; }
fn second_helper() -> u32 { return other_size; }
@compute @workgroup_size(selected_size)
fn first() { first_output[0] = first_helper(); }
@compute @workgroup_size(other_size)
fn second() { second_output[0] = second_helper(); }
";

const GLSL_INPUT: &str = "
fn first_helper(value: u32) -> u32 { return value + 1u; }
fn second_helper(value: u32) -> u32 { return value + 2u; }
@compute @workgroup_size(2, 3, 1)
fn first() { first_helper(3u); }
@compute @workgroup_size(4, 1, 2)
fn second() { second_helper(5u); }
";

const GLSL_OVERRIDES: &str = "
@id(7) override selected_size: u32 = 2u;
override selected_value: u32 = 5u;
override other_size: u32;
fn first_helper() -> u32 { return selected_value; }
fn second_helper() -> u32 { return other_size; }
@compute @workgroup_size(selected_size)
fn first() { first_helper(); }
@compute @workgroup_size(other_size)
fn second() { second_helper(); }
";

fn successful(result: &Output) {
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
}

fn clean_failure(files: &TestFiles, result: &Output, expected: &str) {
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(diagnostic.contains(expected), "{diagnostic}");
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}

fn names(module: &naga::Module) -> Vec<&str> {
    module
        .entry_points
        .iter()
        .map(|entry| entry.name.as_str())
        .collect()
}

fn selected_module(module: &naga::Module, entry: &str, workgroup: [u32; 3], compact: bool) {
    assert_eq!(names(module), [entry]);
    assert_eq!(module.entry_points[0].workgroup_size, workgroup);
    assert_eq!(module.entry_points[0].stage, naga::ShaderStage::Compute);
    let helper = format!("{entry}_helper");
    let (helper_handle, _) = module
        .functions
        .iter()
        .find(|(_, function)| function.name.as_deref() == Some(helper.as_str()))
        .unwrap();
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            calls.push(function);
        }
        false
    });
    assert_eq!(calls, [helper_handle]);
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(module)
    .unwrap();
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(handle, global)| {
            global.binding.is_some() && !info.get_entry_point(0)[handle].is_empty()
        })
        .collect();
    assert_eq!(resources.len(), 1);
    assert_eq!(
        resources[0].1.name.as_deref(),
        Some(format!("{entry}_output").as_str())
    );
    if compact {
        assert_eq!(module.functions.len(), 1);
        assert_eq!(module.global_variables.len(), 1);
    }
}

fn translated(extension: &str, source: &str, arguments: &[&str]) -> TestFiles {
    let mut files = TestFiles::new("wgsl", source);
    files.output.set_extension(extension);
    successful(&files.translate(arguments));
    files
}

fn selection_arguments(entry: &str, compact: bool) -> Vec<&str> {
    let mut arguments = vec!["--entry-point", entry];
    if compact {
        arguments.push("--compact");
    }
    arguments
}

fn specialized_arguments(compact: bool) -> Vec<&'static str> {
    let mut arguments = vec![
        "--entry-point",
        "first",
        "--override",
        "7=3,selected_value=11",
    ];
    if compact {
        arguments.push("--compact");
    }
    arguments
}

fn spirv_module(files: &TestFiles) -> naga::Module {
    let module = naga::front::spv::parse_u8_slice(
        &fs::read(&files.output).unwrap(),
        &naga::front::spv::Options::default(),
    )
    .unwrap();
    naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .unwrap();
    module
}

fn glsl_module(files: &TestFiles) -> naga::Module {
    let source = fs::read_to_string(&files.output).unwrap();
    let module = naga::front::glsl::Frontend::default()
        .parse(
            &naga::front::glsl::Options {
                stage: naga::ShaderStage::Compute,
                defines: Default::default(),
            },
            &source,
        )
        .unwrap();
    naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .unwrap();
    module
}

#[test]
fn default_and_compact_only_preserve_cuda_and_wgsl_entries() {
    for (extension, source) in [("cu", CUDA), ("wgsl", WGSL)] {
        for compact in [false, true] {
            let files = TestFiles::new(extension, source);
            let mut arguments = Vec::new();
            if extension == "cu" {
                arguments.extend(["--cuda-workgroup-size", "4,2,1"]);
            }
            if compact {
                arguments.push("--compact");
            }
            successful(&files.translate(&arguments));
            let module = files.read_module();
            assert_eq!(names(&module), ["first", "second"]);
            assert_eq!(module.functions.len(), 2);
            assert_eq!(module.global_variables.len(), 2);
            let expected = if extension == "cu" {
                [[4, 2, 1], [4, 2, 1]]
            } else {
                [[2, 3, 1], [4, 1, 2]]
            };
            for (entry, workgroup) in module.entry_points.iter().zip(expected) {
                assert_eq!(entry.workgroup_size, workgroup);
            }
        }
    }
}

#[test]
fn wgsl_output_selects_cuda_and_wgsl_entries_with_or_without_compaction() {
    for (extension, source) in [("cu", CUDA), ("wgsl", WGSL)] {
        for (entry, original_workgroup) in [("first", [2, 3, 1]), ("second", [4, 1, 2])] {
            for compact in [false, true] {
                let files = TestFiles::new(extension, source);
                let mut arguments = selection_arguments(entry, compact);
                if extension == "cu" {
                    arguments.extend(["--cuda-workgroup-size", "4,2,1"]);
                }
                successful(&files.translate(&arguments));
                selected_module(
                    &files.read_module(),
                    entry,
                    if extension == "cu" {
                        [4, 2, 1]
                    } else {
                        original_workgroup
                    },
                    compact,
                );
            }
        }
    }
}

#[test]
fn hlsl_output_selects_entries_and_specializes_only_selected_overrides() {
    for entry in ["first", "second"] {
        for compact in [false, true] {
            let files = translated("hlsl", WGSL, &selection_arguments(entry, compact));
            let output = fs::read_to_string(&files.output).unwrap();
            let other = if entry == "first" { "second" } else { "first" };
            assert!(output.contains(&format!("void {entry}(")), "{output}");
            assert!(!output.contains(&format!("void {other}(")), "{output}");
        }
    }
    for compact in [false, true] {
        let files = translated("hlsl", OVERRIDES, &specialized_arguments(compact));
        let output = fs::read_to_string(&files.output).unwrap();
        let normalized: String = output
            .chars()
            .filter(|character| !character.is_whitespace())
            .collect();
        assert!(normalized.contains("[numthreads(3,1,1)]"), "{output}");
        assert!(!output.contains("second_helper"), "{output}");
    }
}

#[test]
fn metal_output_selects_entries_and_specializes_only_selected_overrides() {
    for entry in ["first", "second"] {
        for compact in [false, true] {
            let files = translated("metal", WGSL, &selection_arguments(entry, compact));
            let output = fs::read_to_string(&files.output).unwrap();
            let other = if entry == "first" { "second" } else { "first" };
            assert!(
                output.contains(&format!("kernel void {entry}(")),
                "{output}"
            );
            assert!(
                !output.contains(&format!("kernel void {other}(")),
                "{output}"
            );
        }
    }
    for compact in [false, true] {
        let files = translated("metal", OVERRIDES, &specialized_arguments(compact));
        let output = fs::read_to_string(&files.output).unwrap();
        assert!(output.contains("kernel void first("), "{output}");
        assert!(!output.contains("second_helper"), "{output}");
    }
}

#[test]
fn spirv_output_preserves_selected_entry_workgroups_and_override_specialization() {
    for (entry, workgroup) in [("first", [2, 3, 1]), ("second", [4, 1, 2])] {
        for compact in [false, true] {
            let files = translated("spv", WGSL, &selection_arguments(entry, compact));
            let module = spirv_module(&files);
            assert_eq!(names(&module), [entry]);
            assert_eq!(module.entry_points[0].workgroup_size, workgroup);
        }
    }
    for compact in [false, true] {
        let files = translated("spv", OVERRIDES, &specialized_arguments(compact));
        let module = spirv_module(&files);
        assert_eq!(names(&module), ["first"]);
        assert_eq!(module.entry_points[0].workgroup_size, [3, 1, 1]);
        assert!(module.overrides.is_empty());
    }
}

#[test]
fn glsl_output_preserves_selected_workgroups_and_override_specialization() {
    for (entry, workgroup) in [("first", [2, 3, 1]), ("second", [4, 1, 2])] {
        for compact in [false, true] {
            let mut arguments = selection_arguments(entry, compact);
            arguments.extend(["--profile", "core450"]);
            let files = translated("comp", GLSL_INPUT, &arguments);
            let module = glsl_module(&files);
            assert_eq!(module.entry_points.len(), 1);
            assert_eq!(module.entry_points[0].workgroup_size, workgroup);
        }
    }
    for compact in [false, true] {
        let mut arguments = specialized_arguments(compact);
        arguments.extend(["--profile", "core450"]);
        let files = translated("comp", GLSL_OVERRIDES, &arguments);
        assert_eq!(
            glsl_module(&files).entry_points[0].workgroup_size,
            [3, 1, 1]
        );
    }
}

#[test]
fn unselected_wgsl_output_preserves_override_declarations() {
    for compact in [false, true] {
        let files = TestFiles::new("wgsl", OVERRIDES);
        successful(&files.translate(if compact { &["--compact"] } else { &[] }));
        let module = files.read_module();
        assert_eq!(names(&module), ["first", "second"]);
        assert_eq!(module.overrides.len(), 3);
        let declarations: Vec<_> = module
            .overrides
            .iter()
            .map(|(_, declaration)| {
                (
                    declaration.name.as_deref(),
                    declaration.id,
                    declaration.init.is_some(),
                )
            })
            .collect();
        assert_eq!(
            declarations,
            [
                (Some("selected_size"), Some(7), true),
                (Some("selected_value"), None, true),
                (Some("other_size"), None, false)
            ]
        );
    }
}

#[test]
fn selected_wgsl_overrides_use_defaults_ids_names_and_original_key_lookup() {
    for compact in [false, true] {
        for (overrides, workgroup, value) in [
            (None, [2, 1, 1], 5),
            (Some("7=3,selected_value=11"), [3, 1, 1], 11),
            (Some("7=3,selected_value=11,other_size=9"), [3, 1, 1], 11),
        ] {
            let files = TestFiles::new("wgsl", OVERRIDES);
            let mut arguments = selection_arguments("first", compact);
            if let Some(values) = overrides {
                arguments.extend(["--override", values]);
            }
            successful(&files.translate(&arguments));
            let module = files.read_module();
            selected_module(&module, "first", workgroup, compact);
            assert!(module.overrides.is_empty());
            assert!(module.entry_points[0].workgroup_size_overrides.is_none());
            let (_, constant) = module
                .constants
                .iter()
                .find(|(_, constant)| constant.name.as_deref() == Some("selected_value"))
                .unwrap();
            assert_eq!(
                module.global_expressions[constant.init],
                naga::Expression::Literal(naga::Literal::U32(value))
            );
        }
        let files = TestFiles::new("wgsl", OVERRIDES);
        let mut arguments = selection_arguments("second", compact);
        arguments.extend(["--override", "other_size=6"]);
        successful(&files.translate(&arguments));
        let module = files.read_module();
        selected_module(&module, "second", [6, 1, 1], compact);
        assert!(module.overrides.is_empty());
        let (_, constant) = module
            .constants
            .iter()
            .find(|(_, constant)| constant.name.as_deref() == Some("other_size"))
            .unwrap();
        assert_eq!(
            module.global_expressions[constant.init],
            naga::Expression::Literal(naga::Literal::U32(6))
        );
    }
}

#[test]
fn selected_wgsl_reports_missing_values_and_unknown_override_keys_cleanly() {
    for compact in [false, true] {
        let files = TestFiles::new("wgsl", OVERRIDES);
        let result = files.translate(&selection_arguments("second", compact));
        clean_failure(&files, &result, "other_size");
        let files = TestFiles::new("wgsl", OVERRIDES);
        let mut arguments = selection_arguments("first", compact);
        arguments.extend(["--override", "missing_value=1"]);
        let result = files.translate(&arguments);
        clean_failure(&files, &result, "missing_value");
    }
}

#[test]
fn unknown_entry_names_fail_cleanly_before_creating_any_output_format() {
    for (extension, source) in [("cu", CUDA), ("wgsl", WGSL)] {
        for output in ["wgsl", "hlsl", "metal", "spv", "comp", "txt", "bin", "dot"] {
            let mut files = TestFiles::new(extension, source);
            files.output.set_extension(output);
            let result = files.translate(&["--entry-point", "missing_entry"]);
            clean_failure(&files, &result, "missing_entry");
        }
    }
}

#[test]
fn selected_shader_output_does_not_mutate_a_later_raw_module_output() {
    let files = TestFiles::new("wgsl", OVERRIDES);
    let raw_output = files.output.with_extension("bin");
    successful(&files.translate_outputs(
        &["--entry-point", "first"],
        &[files.output.as_path(), raw_output.as_path()],
    ));
    selected_module(&files.read_module(), "first", [2, 1, 1], false);
    let bytes = fs::read(raw_output).unwrap();
    let (module, consumed): (naga::Module, usize) =
        bincode::serde::decode_from_slice(&bytes, bincode::config::standard()).unwrap();
    assert_eq!(consumed, bytes.len());
    assert_eq!(names(&module), ["first", "second"]);
    assert_eq!(module.overrides.len(), 3);
    naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .unwrap();
}

#[test]
fn cuda_alternate_bodies_are_checked_before_cli_entry_selection() {
    for body in [
        "if (threadIdx.x) __syncthreads();",
        "missing();",
        "return; int value = missing;",
    ] {
        for compact in [false, true] {
            let source =
                format!("__global__ void first() {{}} __global__ void second() {{ {body} }}");
            let files = TestFiles::new("cu", &source);
            let result = files.translate(&selection_arguments("first", compact));
            clean_failure(&files, &result, "Could not parse CUDA");
        }
    }
}
