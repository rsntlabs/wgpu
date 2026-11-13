mod common;

use common::TestFiles;

#[test]
fn cuda_static_assertions_cli_compacts_compile_time_checks_and_preserves_launch_shape() {
    let files = TestFiles::new(
        "cu",
        include_str!("../../naga/tests/in/cuda/static-assertions.cu"),
    );
    let result = files.translate(&["--compact", "--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}

#[test]
fn cuda_static_assertions_cli_reports_failures_without_creating_output() {
    for source in [
        "static_assert(false, \"global constraint\"); __global__ void kernel() {}",
        "__global__ void kernel() { static_assert(false, \"local constraint\"); }",
        "__global__ void kernel(unsigned value) { static_assert(value, \"runtime constraint\"); }",
        "__global__ void kernel() { static_assert(true, 7); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(diagnostic.contains("input.cu"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists(), "{source}");
    }
}

#[test]
fn cuda_static_assertions_cli_checks_all_requested_instances_before_entry_selection() {
    let files = TestFiles::new(
        "cu",
        "template<class Value> __global__ void checked(unsigned *output) {
            static_assert(sizeof(Value) == 4, \"element width\"); output[0] = 7u;
        }
        template __global__ void checked<int>(unsigned *);
        template __global__ void checked<float3>(unsigned *);",
    );
    let result = files.translate(&["--entry-point", "checked<int>"]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(
        diagnostic.contains("static assertion failed: element width"),
        "{diagnostic}"
    );
    assert!(!files.output.exists());
}
