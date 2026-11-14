mod common;

use common::TestFiles;

#[test]
fn cuda_void_forms_cli_accepts_qualified_and_functional_constant_discards() {
    let files = TestFiles::new(
        "cu",
        r#"static_assert((void(), true));
        static_assert((void{}, true));
        static_assert((void((1, 2)), true));
        static_assert(((const volatile void)7, true));
        static_assert((static_cast<volatile const void>(8), true));
        __global__ void kernel(unsigned *output, unsigned parameter) {
            unsigned local = parameter;
            static_assert((void(parameter), true));
            static_assert((void(local), true));
            static_assert((static_cast<const void>(local), true));
            output[0] = (void(), 9u);
        }"#,
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.entry_points.len(), 1);
    assert!(module.functions.is_empty());
}

#[test]
fn cuda_void_forms_cli_preserves_wrapped_calls_and_discarded_pointer_glvalues() {
    let source = r#"__device__ unsigned write(unsigned *output) { output[0] = 17u; return 2u; }
        __global__ void kernel(unsigned *output) {
            (void(write(output)));
            void(write(output));
            (const void)write(output);
            static_cast<volatile void>(write(output));
            (void(*output));
            output[1] = 3u;
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let arguments: &[&str] = if compact { &["--compact"] } else { &[] };
        let result = files.translate(arguments);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        let module = files.read_module();
        let mut helper_writes = 0;
        let mut output_loads = 0;
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            for (_, expression) in function.expressions.iter() {
                if let naga::Expression::Load { pointer } = expression {
                    let mut root = *pointer;
                    loop {
                        match function.expressions[root] {
                            naga::Expression::AccessIndex { base, .. }
                            | naga::Expression::Access { base, .. } => root = base,
                            naga::Expression::GlobalVariable(global) => {
                                if matches!(
                                    module.global_variables[global].space,
                                    naga::AddressSpace::Storage { .. }
                                ) {
                                    output_loads += 1;
                                }
                                break;
                            }
                            _ => break,
                        }
                    }
                }
            }
            naga::proc::any_statement(&function.body, &mut |statement| {
                if let naga::Statement::Store { value, .. } = statement {
                    if matches!(
                        function.expressions[*value],
                        naga::Expression::Literal(naga::Literal::U32(17))
                    ) {
                        helper_writes += 1;
                    }
                }
                false
            });
        }
        assert_eq!(helper_writes, 4);
        assert_eq!(
            output_loads, 0,
            "discarded nonvolatile glvalue must not load output"
        );
    }
}

#[test]
fn cuda_void_forms_cli_rejects_declaration_ambiguities_and_malformed_forms() {
    for body in [
        "void(g);",
        "void(sink());",
        "void(*output);",
        "(void(1, 2));",
        "(void{1});",
        "(const const void)1;",
        "static_cast<volatile volatile void>(1);",
    ] {
        let source = format!("__device__ unsigned write(unsigned *output) {{ output[0] = 17u; return 2u; }} __device__ unsigned sink() {{ return 2u; }} __global__ void kernel(unsigned *output) {{ {body} }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&["--compact"]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_void_forms_cli_keeps_runtime_calls_nonconstant() {
    for expression in [
        "void(helper())",
        "(const void)helper()",
        "static_cast<volatile void>(helper())",
    ] {
        let source = format!("__device__ unsigned helper() {{ return 1u; }} __global__ void kernel() {{ static_assert(({expression}, true)); }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        assert!(!files.output.exists());
    }
}
