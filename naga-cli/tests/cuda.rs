use std::fs;

mod common;

use common::TestFiles;

#[test]
fn cuda_input_extension_transpiles_to_wgsl() {
    let files = TestFiles::new("cu", "__global__ void empty() {}\n");
    let result = files.translate(&["--cuda-workgroup-size", "64,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "empty");
    assert_eq!(module.entry_points[0].workgroup_size, [64, 1, 1]);
}

#[test]
fn cuda_explicit_input_kind_accepts_both_names() {
    for kind in ["cuda", "cu"] {
        let files = TestFiles::new("txt", "__global__ void empty() {}\n");
        let result = files.translate(&["--input-kind", kind]);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        assert_eq!(files.read_module().entry_points[0].workgroup_size, [1; 3]);
    }
}

#[test]
fn cuda_rejects_invalid_workgroup_dimensions() {
    for dimensions in [
        "0,1,1",
        "1,0,1",
        "1,1,0",
        "64,1",
        "64,1,1,1",
        "64,one,1",
        "4294967296,1,1",
    ] {
        let files = TestFiles::new("cu", "__global__ void empty() {}\n");
        let result = files.translate(&["--cuda-workgroup-size", dimensions]);
        assert!(!result.status.success(), "accepted {dimensions}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("three nonzero u32"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_reports_unsupported_source_with_location() {
    let files = TestFiles::new(
        "cu",
        "__global__ void unsupported() {\n    asm(\"trap;\");\n}\n",
    );
    let result = files.translate(&[]);
    assert!(!result.status.success());
    let diagnostic = String::from_utf8_lossy(&result.stderr);
    assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
    assert!(
        diagnostic.contains(&format!("{}:2:", files.input.display())),
        "{diagnostic}"
    );
    assert!(!files.output.exists());
}

#[test]
fn cuda_hlsl_grid_dimensions_require_special_constants_binding() {
    let mut files = TestFiles::new(
        "cu",
        "__global__ void grid(unsigned int *out) { out[0] = gridDim.x; }",
    );
    let wgsl = files.translate(&[]);
    assert!(
        wgsl.status.success(),
        "{}",
        String::from_utf8_lossy(&wgsl.stderr)
    );
    files.read_module();

    files.output.set_extension("hlsl");
    let hlsl = files.translate(&[]);
    assert!(!hlsl.status.success());
    let diagnostic = String::from_utf8_lossy(&hlsl.stderr);
    assert!(
        diagnostic.contains("special_constants_binding"),
        "{diagnostic}"
    );
    assert!(!files.output.exists());
}

#[test]
fn cuda_hlsl_grid_dimensions_use_configured_special_constants() {
    for (binding, declaration) in [("5,2", "register(b5, space2)"), ("0,0", "register(b0)")] {
        let mut files = TestFiles::new(
            "cu",
            "__global__ void grid(unsigned int *out) { out[0] = gridDim.x; }",
        );
        files.output.set_extension("hlsl");
        let result = files.translate(&["--hlsl-special-constants-binding", binding]);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        let hlsl = fs::read_to_string(&files.output).unwrap();
        assert!(
            hlsl.contains(&format!(
                "ConstantBuffer<NagaConstants> _NagaConstants: {declaration}"
            )),
            "{hlsl}"
        );
        assert!(
            hlsl.contains("uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other)"),
            "{hlsl}"
        );
    }
}

#[test]
fn hlsl_rejects_invalid_special_constants_binding() {
    for binding in ["", "3", "3,0,1", "-1,0", "1,-1", "4294967296,0", "1,256"] {
        let files = TestFiles::new("cu", "__global__ void empty() {}\n");
        let result = files.translate(&["--hlsl-special-constants-binding", binding]);
        assert!(!result.status.success(), "accepted {binding}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("register,space"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_volatile_storage_pointer_preserves_its_resource_binding() {
    let files = TestFiles::new(
        "cu",
        "__global__ void update(volatile unsigned *values) {
            values[0]; values[0] = values[1] + 3u;
        }",
    );
    let result = files.translate(&[]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module =
        files.read_module_with_capabilities(naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, variable)| variable.binding.is_some())
        .collect();
    assert_eq!(resources.len(), 1);
    let (_, resource) = resources[0];
    assert_eq!(
        resource.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0
        })
    );
    assert!(resource
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
}

#[test]
fn cuda_volatile_helper_pointer_decorates_the_shared_allocation() {
    let files = TestFiles::new(
        "cu",
        "__device__ unsigned read(volatile unsigned *values, unsigned index) {
            values[index]; return values[index];
        }
        __global__ void exchange(unsigned *output) {
            __shared__ unsigned values[4];
            unsigned lane = threadIdx.x;
            values[lane] = lane + 1u;
            __syncthreads();
            output[lane] = read(values, (lane + 1u) % 4u);
        }",
    );
    let result = files.translate(&["--cuda-workgroup-size", "4,1,1"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module_with_capabilities(
        naga::valid::Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP,
    );
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, variable)| variable.space == naga::AddressSpace::WorkGroup)
        .collect();
    assert_eq!(shared.len(), 1);
    assert!(shared[0]
        .1
        .memory_decorations
        .contains(naga::MemoryDecorations::VOLATILE));
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
}
