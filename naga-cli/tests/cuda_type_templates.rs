mod common;

use common::TestFiles;

const FIXTURE: &str = include_str!("../../naga/tests/in/cuda/type-templates.cu");

fn check_interface(module: &naga::Module, entry_index: usize, scalar: naga::Scalar) {
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(module)
    .unwrap();
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(handle, global)| {
            global.binding.is_some() && !info.get_entry_point(entry_index)[handle].is_empty()
        })
        .collect();
    resources.sort_by_key(|(_, global)| global.binding.unwrap().binding);
    assert_eq!(resources.len(), 3);
    for (binding, &(_, global)) in resources.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: binding as u32
            })
        );
        if binding == 2 {
            assert_eq!(global.space, naga::AddressSpace::Uniform);
            let naga::TypeInner::Struct { ref members, .. } = module.types[global.ty].inner else {
                panic!("scalar count parameter");
            };
            assert_eq!(members.len(), 1);
            assert_eq!(members[0].offset, 0);
            assert_eq!(
                module.types[members[0].ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
        } else {
            assert_eq!(
                global.space,
                naga::AddressSpace::Storage {
                    access: if binding == 0 {
                        naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    } else {
                        naga::StorageAccess::LOAD
                    },
                }
            );
            let naga::TypeInner::Array {
                base,
                size: naga::ArraySize::Dynamic,
                stride: 4,
            } = module.types[global.ty].inner
            else {
                panic!("typed storage array");
            };
            assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
        }
    }
}

#[test]
fn cuda_type_templates_cli_emits_both_typed_instances_with_the_supplied_workgroup_size() {
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
    check_interface(&module, 0, naga::Scalar::U32);
    check_interface(&module, 1, naga::Scalar::F32);
}

#[test]
fn cuda_type_templates_cli_selects_canonical_source_names_before_backend_sanitizing() {
    for (entry, scalar) in [
        ("copy_typed<unsigned>", naga::Scalar::U32),
        ("copy_typed<float>", naga::Scalar::F32),
    ] {
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
            assert_eq!(
                module
                    .global_variables
                    .iter()
                    .filter(|(_, global)| global.binding.is_some())
                    .count(),
                3
            );
            check_interface(&module, 0, scalar);
        }
    }
}

#[test]
fn cuda_type_templates_cli_checks_other_requested_instances_before_entry_selection() {
    let source = format!("{FIXTURE}\ntemplate __global__ void copy_typed<const float>(const float *, const float *, unsigned);\n");
    let files = TestFiles::new("cu", &source);
    let result = files.translate(&[
        "--cuda-workgroup-size",
        "4,1,1",
        "--entry-point",
        "copy_typed<unsigned>",
    ]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(
        diagnostic.contains("cannot modify a const value"),
        "{diagnostic}"
    );
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}

#[test]
fn cuda_type_templates_cli_rejects_unknown_type_instances_without_output() {
    let files = TestFiles::new("cu", FIXTURE);
    let result = files.translate(&[
        "--cuda-workgroup-size",
        "4,1,1",
        "--entry-point",
        "copy_typed<int>",
    ]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(diagnostic.contains("copy_typed<int>"), "{diagnostic}");
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}
