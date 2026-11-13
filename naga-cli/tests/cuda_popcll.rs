mod common;

use common::TestFiles;

#[test]
fn cuda_popcll_cli_preserves_wide_input_stride_and_signed_count_output() {
    let files = TestFiles::new("cu", include_str!("../../naga/tests/in/cuda/popcll.cu"));
    let result = files.translate(&["--compact", "--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    for (binding, expected, expected_stride) in
        [(0, naga::Scalar::I32, 4), (1, naga::Scalar::U64, 8)]
    {
        let global = module
            .global_variables
            .iter()
            .find_map(|(_, global)| {
                (global.binding == Some(naga::ResourceBinding { group: 0, binding }))
                    .then_some(global)
            })
            .unwrap();
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("expected runtime array");
        };
        assert_eq!(stride, expected_stride);
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(expected));
    }
    let helper = module.functions.iter().next().unwrap().1;
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
}

#[test]
fn cuda_popcll_cli_reports_invalid_uses_without_creating_output() {
    for body in [
        "__popcll();",
        "__popcll(1ULL, 2ULL);",
        "int __popcll = 0; __popcll(1ULL);",
        "constexpr int Count = __popcll(3ULL);",
    ] {
        let files = TestFiles::new("cu", &format!("__global__ void kernel() {{ {body} }}"));
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{body}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_popcll_cli_source_overloads_do_not_require_unused_wide_shader_types() {
    let files = TestFiles::new(
        "cu",
        "__device__ int __popcll(bool value) { return value ? 99 : 98; }
        __global__ void kernel(int *output) { output[0] = __popcll(true); }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
}
