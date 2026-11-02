mod common;

use common::TestFiles;

const FIXTURE: &str = include_str!("../../naga/tests/in/cuda/integral-templates.cu");

fn shared_extents(module: &naga::Module) -> Vec<u32> {
    let mut extents: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, variable)| {
            if variable.space != naga::AddressSpace::WorkGroup {
                return None;
            }
            let naga::TypeInner::Array {
                size: naga::ArraySize::Constant(count),
                ..
            } = module.types[variable.ty].inner
            else {
                panic!("shared array");
            };
            Some(count.get())
        })
        .collect();
    extents.sort_unstable();
    extents
}

#[test]
fn cuda_integral_templates_cli_emits_all_instances_with_the_module_workgroup_size() {
    let files = TestFiles::new("cu", FIXTURE);
    let result = files.translate(&["--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.entry_points.len(), 2);
    assert!(module
        .entry_points
        .iter()
        .all(|entry| entry.workgroup_size == [4, 1, 1]));
    assert_eq!(shared_extents(&module), [4, 8]);
}

#[test]
fn cuda_integral_templates_cli_selects_raw_specialization_names_before_wgsl_sanitizing() {
    for (entry, extent) in [("reduce<4>", 4), ("reduce<8>", 8)] {
        for compact in [false, true] {
            let files = TestFiles::new("cu", FIXTURE);
            let mut arguments = vec!["--cuda-workgroup-size", "4,1,1", "--entry-point", entry];
            if compact {
                arguments.push("--compact");
            }
            let result = files.translate(&arguments);
            assert!(
                result.status.success(),
                "{}",
                String::from_utf8_lossy(&result.stderr)
            );
            let module = files.read_module();
            assert_eq!(module.entry_points.len(), 1);
            assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
            assert_eq!(shared_extents(&module), [extent]);
            let mut bindings: Vec<_> = module
                .global_variables
                .iter()
                .filter_map(|(_, variable)| variable.binding)
                .collect();
            bindings.sort_by_key(|binding| (binding.group, binding.binding));
            assert_eq!(
                bindings,
                [
                    naga::ResourceBinding {
                        group: 0,
                        binding: 0
                    },
                    naga::ResourceBinding {
                        group: 0,
                        binding: 1
                    }
                ]
            );
        }
    }
}

#[test]
fn cuda_integral_templates_cli_checks_every_requested_instance_before_selection() {
    let source = FIXTURE.replace("reduce<8>", "reduce<0>");
    let files = TestFiles::new("cu", &source);
    let result = files.translate(&[
        "--cuda-workgroup-size",
        "4,1,1",
        "--entry-point",
        "reduce<4>",
    ]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(diagnostic.contains("CUDA"), "{diagnostic}");
    assert!(
        diagnostic.contains("array extent must be a positive integral constant expression"),
        "{diagnostic}"
    );
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}

#[test]
fn cuda_integral_templates_cli_rejects_unknown_specialization_without_output() {
    let files = TestFiles::new("cu", FIXTURE);
    let result = files.translate(&[
        "--cuda-workgroup-size",
        "4,1,1",
        "--entry-point",
        "reduce<7>",
    ]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(diagnostic.contains("reduce<7>"), "{diagnostic}");
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}
