mod common;

use common::TestFiles;

#[test]
fn cuda_void_casts_cli_accepts_constant_discard_and_selected_void_arms() {
    let files = TestFiles::new(
        "cu",
        r#"static_assert(((void)7, true));
        static_assert((static_cast<void>(3), 4) == 4);
        static_assert((true ? (void)1 : static_cast<void>(2), true));
        static_assert((false ? static_cast<void>(1) : (void)2, true));
        __global__ void kernel(unsigned *output, unsigned parameter) {
            unsigned local = parameter;
            static_assert(((void)parameter, true));
            static_assert((static_cast<void>(local), true));
            output[0] = ((void)7, 9u);
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
fn cuda_void_casts_cli_preserves_calls_updates_selection_and_void_returns() {
    let source = r#"__device__ void write(unsigned *output) { output[0] = 11u; }
        __device__ void forward(unsigned *output) { return static_cast<void>(write(output)); }
        __global__ void kernel(unsigned *output, unsigned condition) {
            unsigned index = 0u;
            (void)index++;
            static_cast<void>(forward(output));
            condition ? (void)write(output) : static_cast<void>(index++);
            output[1] = index;
            return (void)0;
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
        assert_eq!(module.entry_points.len(), 1);
        let mut helper_writes = 0;
        let mut selections = 0;
        let mut stores = 0;
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            naga::proc::any_statement(&function.body, &mut |statement| {
                match statement {
                    naga::Statement::If { .. } => selections += 1,
                    naga::Statement::Store { value, .. } => {
                        stores += 1;
                        if matches!(
                            function.expressions[*value],
                            naga::Expression::Literal(naga::Literal::U32(11))
                        ) {
                            helper_writes += 1;
                        }
                    }
                    _ => {}
                }
                false
            });
        }
        assert_eq!(
            helper_writes, 2,
            "both helper invocations must retain their writes"
        );
        assert!(selections >= 1);
        assert!(stores >= 4);
        assert_eq!(
            module
                .global_variables
                .iter()
                .filter(|(_, global)| global.binding.is_some())
                .count(),
            2
        );
    }
}

#[test]
fn cuda_void_casts_cli_rejects_void_values_and_malformed_casts() {
    for body in [
        "unsigned value = (void)1;",
        "output[0] = static_cast<void>(1);",
        "(void)1 + 2;",
        "static_cast<void>();",
        "static_cast<void>(1;",
    ] {
        let source = format!("__global__ void kernel(unsigned *output) {{ {body} }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_void_casts_cli_keeps_discarded_runtime_operations_nonconstant() {
    for source in [
        "__device__ void helper() {} __global__ void kernel() { static_assert(((void)helper(), true)); }",
        "__global__ void kernel(unsigned condition) { static_assert((condition ? (void)1 : (void)2, true)); }",
        "__global__ void kernel(unsigned value) { static_assert((static_cast<void>(value + 1u), true)); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&["--compact"]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}
