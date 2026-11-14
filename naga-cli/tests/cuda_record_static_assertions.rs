mod common;

use common::TestFiles;

fn check_runtime_interface(module: &naga::Module) {
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| global.binding.is_some())
        .collect();
    assert_eq!(resources.len(), 1);
    let output = resources[0].1;
    assert_eq!(
        output.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    assert_eq!(
        output.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    let naga::TypeInner::Array { base, stride, .. } = module.types[output.ty].inner else {
        panic!("expected output storage array");
    };
    assert_eq!(stride, 4);
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert!(module.functions.is_empty());
    let mut stores = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if matches!(statement, naga::Statement::Store { .. }) {
            stores += 1;
        }
        assert!(!matches!(
            statement,
            naga::Statement::Call { .. } | naga::Statement::If { .. }
        ));
        false
    });
    assert!(stores > 0, "record checks must preserve runtime writes");
}

#[test]
fn cuda_record_static_assertions_cli_compacts_global_local_and_typedef_record_checks() {
    let files = TestFiles::new(
        "cu",
        r#"struct Global {
            unsigned member;
            static_assert(sizeof(member) == 4, "global member");
        };
        typedef struct {
            float3 vector;
            static_assert(sizeof(vector) == 12, "packed vector");
        } Alias;
        __global__ void kernel(unsigned *output) {
            struct Local {
                Global global;
                static_assert(sizeof(global.member) == 4, "nested member");
                Alias alias;
                static_assert(sizeof(alias.vector) == 12, "nested alias");
            };
            Local value;
            value.global.member = 7u;
            value.alias.vector.z = 3.0f;
            unsigned index = threadIdx.x;
            output[index * 2u] = value.global.member;
            output[index * 2u + 1u] = unsigned(value.alias.vector.z);
        }"#,
    );
    let result = files.translate(&["--compact", "--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    check_runtime_interface(&module);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}

#[test]
fn cuda_record_static_assertions_cli_checks_dependent_local_records_in_selected_templates() {
    let source = r#"template<class Value> __global__ void checked(unsigned *output) {
            struct Local {
                Value value;
                static_assert(sizeof(value) == 4, "element width");
            };
            Local value;
            value.value = Value(7);
            output[threadIdx.x] = unsigned(value.value);
        }
        template __global__ void checked<unsigned>(unsigned *);
        template __global__ void checked<float>(unsigned *);"#;
    for entry in ["checked<unsigned>", "checked<float>"] {
        for compact in [false, true] {
            let files = TestFiles::new("cu", source);
            let mut arguments = vec!["--entry-point", entry, "--cuda-workgroup-size", "4,1,1"];
            if compact {
                arguments.push("--compact");
            }
            let result = files.translate(&arguments);
            assert!(
                result.status.success(),
                "{}",
                String::from_utf8_lossy(&result.stderr)
            );
            let module =
                files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
            check_runtime_interface(&module);
            if compact {
                assert!(module
                    .types
                    .iter()
                    .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
            }
        }
    }
}

#[test]
fn cuda_record_static_assertions_cli_validates_all_requested_records_before_entry_selection() {
    let files = TestFiles::new(
        "cu",
        r#"template<class Value> __global__ void checked(unsigned *output) {
            struct Local {
                Value value;
                static_assert(sizeof(value) == 4, "element width");
            };
            output[0] = 7u;
        }
        template __global__ void checked<unsigned>(unsigned *);
        template __global__ void checked<short>(unsigned *);"#,
    );
    let result = files.translate(&["--entry-point", "checked<unsigned>", "--compact"]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(
        diagnostic.contains("static assertion failed: element width"),
        "{diagnostic}"
    );
    assert!(diagnostic.contains("input.cu:4:"), "{diagnostic}");
    assert!(!diagnostic.contains("panicked"), "{diagnostic}");
    assert!(!files.output.exists());
}

#[test]
fn cuda_record_static_assertions_cli_reports_spanned_failures_and_rejects_objectless_values() {
    for (source, expected) in [
        (
            r#"struct Record {
    unsigned member;
    static_assert(sizeof(member) == 8, "record width");
};
__global__ void kernel() {}"#,
            Some("static assertion failed: record width"),
        ),
        (
            r#"struct Record {
    unsigned member;
    static_assert(member == 0);
};
__global__ void kernel() {}"#,
            None,
        ),
        (
            r#"struct Record {
    unsigned member;
    static_assert(sizeof(Record) == 4);
};
__global__ void kernel() {}"#,
            None,
        ),
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        if let Some(expected) = expected {
            assert!(diagnostic.contains(expected), "{diagnostic}");
            assert!(diagnostic.contains("input.cu:3:"), "{diagnostic}");
        }
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists(), "{source}");
    }
}
