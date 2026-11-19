use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate};

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_kernel_named_vector_values_preserve_nominal_layouts_in_fixed_uniform_wrappers() {
    for (name, size, scalar) in [
        ("int1", 1usize, naga::Scalar::I32),
        ("uint1", 1usize, naga::Scalar::U32),
        ("float1", 1usize, naga::Scalar::F32),
        ("int3", 3usize, naga::Scalar::I32),
        ("uint3", 3usize, naga::Scalar::U32),
        ("float3", 3usize, naga::Scalar::F32),
    ] {
        let components = core::iter::repeat_n("3", size)
            .collect::<Vec<_>>()
            .join(", ");
        let (module, _) = validate(&format!("__global__ void kernel(unsigned *out, {name} value) {{ {name} original = value; value.x = 7; value = {name}({components}); out[0] = unsigned(original.x) + unsigned(value.x); }}"));
        assert_eq!(module.global_variables.len(), 2);
        let (uniform_handle, uniform) = module
            .global_variables
            .iter()
            .find(|(_, global)| global.space == naga::AddressSpace::Uniform)
            .unwrap();
        assert_eq!(
            uniform.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: 1
            })
        );
        let naga::TypeInner::Struct { ref members, span } = module.types[uniform.ty].inner else {
            panic!("expected value wrapper");
        };
        assert_eq!(span, 16);
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        let inner = &module.types[members[0].ty];
        assert_eq!(inner.name.as_deref(), Some(name));
        let naga::TypeInner::Struct {
            members: ref components,
            span: inner_span,
        } = inner.inner
        else {
            panic!("expected nominal CUDA vector struct, not native vec3");
        };
        assert_eq!(inner_span, size as u32 * 4);
        assert_eq!(components.len(), size);
        for (index, component) in components.iter().enumerate() {
            assert_eq!(component.name.as_deref(), Some(["x", "y", "z"][index]));
            assert_eq!(component.offset, index as u32 * 4);
            assert_eq!(
                module.types[component.ty].inner,
                naga::TypeInner::Scalar(scalar)
            );
        }
        let function = &module.entry_points[0].function;
        assert!(
            function
                .local_variables
                .iter()
                .any(|(_, local)| local.ty == members[0].ty),
            "launch value must have a private mutable copy"
        );
        let loads = function.expressions.iter().filter(|(_, expression)| {
            let naga::Expression::Load { pointer } = **expression else { return false; };
            matches!(function.expressions[root_expression(function, pointer)], naga::Expression::GlobalVariable(global) if global == uniform_handle)
        }).count();
        assert_eq!(loads, 1);
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Store { pointer, .. } = statement {
                assert!(
                    !matches!(function.expressions[root_expression(function, *pointer)], naga::Expression::GlobalVariable(global) if global == uniform_handle)
                );
            }
            false
        });
    }
}

#[test]
fn cuda_kernel_named_vector_values_keep_mixed_binding_indices_aliases_and_const_rules() {
    let (module, _) = validate("using Offset = int1; using Weights = const float3;
        __device__ unsigned use(Offset value) { return unsigned(value.x); }
        __global__ void kernel(unsigned *out, bool enabled, Offset offset, Weights weights, unsigned count, uint4 native, const unsigned *input) { decltype(offset) copy = offset; copy.x += int(count); out[0] = enabled ? use(copy) + unsigned(weights.z) + native.x + input[0] : count; }");
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
        .collect();
    resources.sort_by_key(|(binding, _)| binding.binding);
    assert_eq!(resources.len(), 7);
    for (index, (binding, global)) in resources.iter().enumerate() {
        assert_eq!(
            *binding,
            naga::ResourceBinding {
                group: 0,
                binding: index as u32
            }
        );
        if (1..=5).contains(&index) {
            assert_eq!(global.space, naga::AddressSpace::Uniform);
            let naga::TypeInner::Struct { span, .. } = module.types[global.ty].inner else {
                panic!("expected uniform wrapper");
            };
            assert_eq!(span, 16);
        }
    }
    let naga::TypeInner::Struct { ref members, .. } = module.types[resources[1].1.ty].inner else {
        unreachable!()
    };
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    for ty in ["int1", "uint1", "float1", "int3", "uint3", "float3"] {
        reject(&format!(
            "__global__ void kernel(const {ty} value) {{ value.x = 1; }}"
        ));
        let constructor = if ty.ends_with('3') {
            format!("{ty}(1, 1, 1)")
        } else {
            format!("{ty}(1)")
        };
        reject(&format!(
            "__global__ void kernel(const {ty} value) {{ value = {constructor}; }}"
        ));
    }
}

#[test]
fn cuda_kernel_named_vector_values_route_fixed_and_deduced_template_instances() {
    let (module, info) = validate("template<class Value> __device__ Value copy(Value input) { return input; }
        template<class Value> __global__ void kernel(unsigned *out, Value input) { Value local = copy(input); local.x = 3; out[0] = unsigned(local.x) + unsigned(input.x); }
        template __global__ void kernel<uint1>(unsigned *, uint1);
        template __global__ void kernel<float3>(unsigned *, float3);");
    assert_eq!(module.entry_points.len(), 2);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_kernel_named_vector_values_keep_other_aggregate_value_families_out_of_scope() {
    for ty in [
        "short2",
        "ushort4",
        "long2",
        "ulong4",
        "longlong2",
        "Record",
        "dim3",
    ] {
        reject(&format!(
            "struct Record {{ unsigned value; }}; __global__ void kernel({ty} value) {{}}"
        ));
    }
    reject("__global__ void kernel(float3 value);");
    reject("__global__ void kernel(float3 &value) {}");
}

#[test]
fn cuda_kernel_named_vector_values_preserve_decltype_size_alignment_and_storage_stride() {
    let (module, _) = super::helpers::validate_with_options_and_capabilities(
        "__global__ void kernel(float3 *out, float3 value, int1 single) { using Triple = decltype(value); using Single = decltype(single); static_assert(sizeof(Triple) == 12); static_assert(alignof(Triple) == 4); static_assert(sizeof(Single) == 4); static_assert(alignof(Single) == 4); Triple copy = value; copy.x += float(single.x); out[0] = copy; }",
        &Options::default(), naga::valid::Capabilities::SHADER_INT64,
    );
    let storage = module
        .global_variables
        .iter()
        .find_map(|(_, global)| {
            (global.binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 0,
                }))
            .then_some(global)
        })
        .unwrap();
    let naga::TypeInner::Array { base, stride, .. } = module.types[storage.ty].inner else {
        panic!("expected vector3 storage array");
    };
    assert_eq!(stride, 12);
    let naga::TypeInner::Struct { span, ref members } = module.types[base].inner else {
        panic!("expected original nominal vector3");
    };
    assert_eq!(span, 12);
    assert_eq!(members.len(), 3);
}
