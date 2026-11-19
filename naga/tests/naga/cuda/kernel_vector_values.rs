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
fn cuda_kernel_vector_values_use_six_native_32bit_types_in_fixed_uniform_wrappers() {
    for (name, size, scalar) in [
        ("int2", naga::VectorSize::Bi, naga::Scalar::I32),
        ("uint2", naga::VectorSize::Bi, naga::Scalar::U32),
        ("float2", naga::VectorSize::Bi, naga::Scalar::F32),
        ("int4", naga::VectorSize::Quad, naga::Scalar::I32),
        ("uint4", naga::VectorSize::Quad, naga::Scalar::U32),
        ("float4", naga::VectorSize::Quad, naga::Scalar::F32),
    ] {
        let (module, _) = validate(&format!("__global__ void kernel(unsigned *out, {name} value) {{ {name} original = value; value.x = 7; value = {name}(3); out[0] = unsigned(original.y) + unsigned(value.x); }}"));
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
        assert_eq!(
            module.types[members[0].ty].inner,
            naga::TypeInner::Vector { size, scalar }
        );
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
fn cuda_kernel_vector_values_keep_mixed_binding_indices_aliases_and_const_rules() {
    let (module, _) = validate("using Offset = int2; using Weights = const float4;
        __device__ unsigned use(Offset value) { return unsigned(value.x + value.y); }
        __global__ void kernel(unsigned *out, bool enabled, Offset offset, Weights weights, unsigned count, const unsigned *input) { decltype(offset) copy = offset; copy.x += int(count); out[0] = enabled ? use(copy) + unsigned(weights.w) + input[0] : count; }");
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
        .collect();
    resources.sort_by_key(|(binding, _)| binding.binding);
    assert_eq!(resources.len(), 6);
    for (index, (binding, global)) in resources.iter().enumerate() {
        assert_eq!(
            *binding,
            naga::ResourceBinding {
                group: 0,
                binding: index as u32
            }
        );
        if (1..=4).contains(&index) {
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
    for ty in ["int2", "uint2", "float2", "int4", "uint4", "float4"] {
        reject(&format!(
            "__global__ void kernel(const {ty} value) {{ value.x = 1; }}"
        ));
        reject(&format!(
            "__global__ void kernel(const {ty} value) {{ value = {ty}(1); }}"
        ));
    }
}

#[test]
fn cuda_kernel_vector_values_route_fixed_and_deduced_template_instances() {
    let (module, info) = validate("template<class Value> __device__ Value copy(Value input) { return input; }
        template<class Value> __global__ void kernel(unsigned *out, Value input) { Value local = copy(input); local.x = 3; out[0] = unsigned(local.x) + unsigned(input.y); }
        template __global__ void kernel<uint2>(unsigned *, uint2);
        template __global__ void kernel<float4>(unsigned *, float4);");
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
fn cuda_kernel_vector_values_keep_other_aggregate_value_families_out_of_scope() {
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
    reject("__global__ void kernel(float2 value);");
    reject("__global__ void kernel(float2 &value) {}");
}
