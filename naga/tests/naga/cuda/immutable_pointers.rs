use super::helpers::{validate, validate_with_options};

fn assert_direct_resource_access(module: &naga::Module) {
    let function = &module.entry_points[0].function;
    for (_, local) in function.local_variables.iter() {
        assert!(
            !matches!(module.types[local.ty].inner, naga::TypeInner::Array { .. }),
            "pointer bookkeeping array remains: {:?}",
            local.name
        );
    }
}

fn assert_direct_resource_roundtrip(source: &str) {
    let (module, info) = validate(source);
    assert_direct_resource_access(&module);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_direct_resource_access(&reparsed);
    }
    let _ = info;
}

fn assert_pointer_storage(source: &str, name: &str) {
    let (module, info) = validate(source);
    assert!(
        module.entry_points[0]
            .function
            .local_variables
            .iter()
            .any(|(_, local)| {
                local.name.as_deref() == Some(name)
                    && matches!(module.types[local.ty].inner, naga::TypeInner::Array { .. })
            }),
        "missing pointer storage for {name}"
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

fn assert_particles_resource_abi(module: &naga::Module) {
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(_, global)| global.binding.is_some())
        .collect();
    resources.sort_by_key(|&(_, global)| global.binding.unwrap().binding);
    assert_eq!(resources.len(), 2);
    for ((_, global), (binding, name, access, stride)) in resources.into_iter().zip([
        (
            0,
            "points",
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
            16,
        ),
        (1, "params", naga::StorageAccess::LOAD, 4),
    ]) {
        assert_eq!(global.name.as_deref(), Some(name));
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding { group: 0, binding })
        );
        assert_eq!(global.space, naga::AddressSpace::Storage { access });
        let naga::TypeInner::Array {
            base,
            size: naga::ArraySize::Dynamic,
            stride: actual_stride,
        } = module.types[global.ty].inner
        else {
            panic!("resource {name} must remain a runtime array");
        };
        assert_eq!(actual_stride, stride);
        let expected = if binding == 0 {
            naga::TypeInner::Vector {
                size: naga::VectorSize::Quad,
                scalar: naga::Scalar::F32,
            }
        } else {
            naga::TypeInner::Scalar(naga::Scalar::F32)
        };
        assert_eq!(module.types[base].inner, expected);
    }
}

#[test]
fn cuda_immutable_pointer_parameters_access_resources_directly() {
    for (source, name) in [
        ("__global__ void kernel(int *out) { out = out + 1; out[0] = 7; }", "out"),
        ("__global__ void kernel(int *out) { out += 1; out[0] = 7; }", "out"),
        ("__global__ void kernel(int *out) { int *cursor = out; cursor = out + 1; out[0] = *cursor; }", "cursor"),
        ("__global__ void kernel(int *out, int *other) { out[0] = *(out[3] ? out : other); }", "out"),
        ("__global__ void kernel(int *out) { if (out[3]) { const int *cursor = out; out[0] = *cursor; } }", "cursor"),
        ("__global__ void kernel(int *out) { for (unsigned iteration = 0; iteration < 2; ++iteration) { const int *cursor = out + iteration; out[iteration] = *cursor; } }", "cursor"),
    ] {
        assert_pointer_storage(source, name);
    }
    let (module, info) =
        validate("__global__ void kernel(int *out) { out[0] = 7; return; out = out + 1; }");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out, const int *input) {
            unsigned index = threadIdx.x;
            if (index < 4) out[index] = input[index] + 7;
        }",
    );
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out, int *other) {
            out[0] = (out[3] ? (out + 0) : (other + 0))[0];
        }",
    );
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out) { out[0] = 7; return; out += 1; }",
    );
}

#[test]
fn cuda_immutable_resource_bases_preserve_reference_helper_indices() {
    assert_direct_resource_roundtrip(
        "__device__ void copy(int &destination, const int &source) {
            destination = source;
        }
        __global__ void kernel(int *out) {
            unsigned destination_index = 1;
            unsigned source_index = 8;
            copy(out[destination_index++], out[source_index++]);
            out[0] = destination_index * 100 + source_index;
        }",
    );
}

#[test]
fn cuda_immutable_resource_bases_preserve_saved_reference_indices() {
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out) {
            unsigned index = 1;
            int &destination = out[index++];
            const int &source = out[index++];
            ++index;
            destination = source;
            out[0] = index;
        }",
    );
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out) {
            int &live = out[8];
            int first = live;
            live = 7;
            out[0] = first;
            out[1] = live;
        }",
    );
}

#[test]
fn cuda_immutable_pointer_bases_preserve_captured_access_indices() {
    assert_direct_resource_roundtrip(
        "__global__ void kernel(int *out) {
            unsigned index = 1;
            out[index++] = out[index] + 10;
            out[0] = index;
        }",
    );
}

#[test]
fn cuda_immutable_particles_resources_need_no_pointer_bookkeeping() {
    let (module, info) = validate_with_options(
        include_str!("../../in/cuda/particles.cu"),
        &naga::front::cuda::Options {
            workgroup_size: [64, 1, 1],
        },
    );
    assert_particles_resource_abi(&module);
    assert_direct_resource_access(&module);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_particles_resource_abi(&reparsed);
        assert_direct_resource_access(&reparsed);
    }
    let _ = info;
}
