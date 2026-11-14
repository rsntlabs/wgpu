mod common;

use common::TestFiles;

fn check_interface(module: &naga::Module, binding: u32, logical: naga::Scalar) {
    assert_eq!(module.entry_points.len(), 1);
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(module)
    .unwrap();
    let uniform = module
        .global_variables
        .iter()
        .find_map(|(handle, global)| {
            (global.binding == Some(naga::ResourceBinding { group: 0, binding })
                && !info.get_entry_point(0)[handle].is_empty())
            .then_some(global)
        })
        .unwrap();
    assert_eq!(uniform.space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, .. } = module.types[uniform.ty].inner else {
        panic!("expected scalar uniform block");
    };
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(if logical == naga::Scalar::BOOL {
            naga::Scalar::U32
        } else {
            logical
        })
    );
    let function = &module.entry_points[0].function;
    let mut selected = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call {
            function: callee, ..
        } = *statement
        {
            let callee = &module.functions[callee];
            if callee
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("kind"))
            {
                assert_eq!(
                    module.types[callee.arguments[0].ty].inner,
                    naga::TypeInner::Scalar(logical)
                );
                selected += 1;
            }
        }
        false
    });
    assert_eq!(selected, 1);
    if logical == naga::Scalar::BOOL {
        assert!(function.expressions.iter().any(|(_, expression)| matches!(
            *expression,
            naga::Expression::Binary { op: naga::BinaryOperator::And, right, .. }
                if function.expressions[right] == naga::Expression::Literal(naga::Literal::U32(0xff))
        )));
    }
}

#[test]
fn cuda_boolean_parameters_cli_preserves_const_aliases_and_the_scalar_uniform_binding() {
    let files = TestFiles::new(
        "cu",
        "using Flag = const bool;
        __device__ unsigned kind(bool value) { return 17u; }
        __device__ unsigned kind(int value) { return 21u; }
        __global__ void kernel(unsigned *output, Flag enabled) { output[0] = kind(enabled); }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    check_interface(&files.read_module(), 1, naga::Scalar::BOOL);
}

#[test]
fn cuda_boolean_parameters_cli_selects_typed_entries_with_or_without_compaction() {
    let source = "using Flag = bool;
        __device__ unsigned kind(bool value) { return 17u; }
        __device__ unsigned kind(int value) { return 21u; }
        template<class Value> __global__ void decode(Value enabled, unsigned *output) {
            output[0] = kind(enabled);
            enabled = !enabled;
            output[1] = unsigned(enabled);
        }
        template __global__ void decode<Flag>(Flag, unsigned *);
        template __global__ void decode<int>(int, unsigned *);";
    for (entry, scalar) in [
        ("decode<bool>", naga::Scalar::BOOL),
        ("decode<int>", naga::Scalar::I32),
    ] {
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
            let module = files.read_module();
            assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
            assert_eq!(
                module
                    .global_variables
                    .iter()
                    .filter(|(_, global)| global.binding.is_some())
                    .count(),
                2
            );
            check_interface(&module, 0, scalar);
            if scalar == naga::Scalar::BOOL {
                let function = &module.entry_points[0].function;
                assert!(function.local_variables.iter().any(|(_, local)| local
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("enabled"))
                    && module.types[local.ty].inner
                        == naga::TypeInner::Scalar(naga::Scalar::BOOL)));
            }
        }
    }
}

#[test]
fn cuda_boolean_parameters_cli_keeps_pointer_reference_and_volatile_restrictions() {
    for parameter in [
        "bool *enabled",
        "bool &enabled",
        "volatile bool enabled",
        "bool enabled[2]",
    ] {
        let files = TestFiles::new("cu", &format!("__global__ void kernel({parameter}) {{}}"));
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{parameter}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists(), "{parameter}");
    }
}
