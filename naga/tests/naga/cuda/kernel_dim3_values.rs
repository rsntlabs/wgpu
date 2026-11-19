use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate, validate_with_options_and_capabilities};

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_kernel_dim3_values_use_a_nominal_twelve_byte_value_in_sixteen_byte_uniform() {
    let (module, _) = validate("using Shape = dim3; __global__ void kernel(unsigned *out, Shape shape) { Shape original = shape; shape.x += 2u; shape = dim3(shape.x, 3u); dim3 local; out[0] = original.x + original.y + original.z + shape.z + local.z; }");
    assert_eq!(module.global_variables.len(), 2);
    let (handle, uniform) = module
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
        panic!("expected launch wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(module.types[members[0].ty].name.as_deref(), Some("dim3"));
    let naga::TypeInner::Struct {
        members: ref fields,
        span,
    } = module.types[members[0].ty].inner
    else {
        panic!("expected nominal dim3");
    };
    assert_eq!(span, 12);
    assert_eq!(fields.len(), 3);
    for (index, field) in fields.iter().enumerate() {
        assert_eq!(field.name.as_deref(), Some(["x", "y", "z"][index]));
        assert_eq!(field.offset, index as u32 * 4);
        assert_eq!(
            module.types[field.ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
    let function = &module.entry_points[0].function;
    assert!(function
        .local_variables
        .iter()
        .any(|(_, local)| local.ty == members[0].ty));
    let reads = function.expressions.iter().filter(|(_, expression)| {
        let naga::Expression::Load { pointer } = **expression else { return false; };
        matches!(function.expressions[root_expression(function, pointer)], naga::Expression::GlobalVariable(global) if global == handle)
    }).count();
    assert_eq!(reads, 1);
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, .. } = statement {
            assert!(
                !matches!(function.expressions[root_expression(function, *pointer)], naga::Expression::GlobalVariable(global) if global == handle)
            );
        }
        false
    });
}

#[test]
fn cuda_kernel_dim3_values_preserve_source_identity_templates_aliases_and_mixed_bindings() {
    let (module, _) = validate("using Shape = dim3;
        __device__ unsigned kind(dim3 value) { return 11u; } __device__ unsigned kind(uint3 value) { return 22u; }
        template<class T> __device__ unsigned classify(T value) { return kind(value); }
        __global__ void kernel(unsigned *out, bool enabled, unsigned count, uint2 offset, Shape shape, const Shape fixed, const unsigned *input) { decltype(shape) copied = shape; uint3 packed = shape; copied = packed; out[0] = enabled ? classify(shape) + kind(packed) + fixed.z + offset.x + count + input[0] : copied.y; }");
    let mut bindings: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| binding.binding))
        .collect();
    bindings.sort();
    assert_eq!(bindings, [0, 1, 2, 3, 4, 5, 6]);
    let mut tags = Vec::new();
    for function in module
        .functions
        .iter()
        .map(|(_, function)| function)
        .chain(module.entry_points.iter().map(|entry| &entry.function))
    {
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                let callee = &module.functions[function];
                if callee
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("kind"))
                {
                    naga::proc::any_statement(&callee.body, &mut |statement| {
                        if let naga::Statement::Return { value: Some(value) } = statement {
                            if let naga::Expression::Literal(naga::Literal::U32(tag)) =
                                callee.expressions[*value]
                            {
                                tags.push(tag);
                            }
                        }
                        false
                    });
                }
            }
            false
        });
    }
    tags.sort();
    assert_eq!(tags, [11, 22]);
    let (module, info) = validate("template<class Shape> __global__ void launch(unsigned *out, Shape shape) { Shape copy = shape; copy.x += 1u; out[0] = copy.x + shape.z; } template __global__ void launch<dim3>(unsigned *, dim3);");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_kernel_dim3_values_retain_size_alignment_array_stride_and_local_defaults() {
    validate_with_options_and_capabilities("__global__ void kernel(unsigned *out, dim3 shape) { using Shape = decltype(shape); static_assert(sizeof(Shape) == 12); static_assert(alignof(Shape) == 4); Shape local[2]; static_assert(sizeof(local) == 24); out[0] = local[0].x + local[1].y + shape.z; }", &Options::default(), naga::valid::Capabilities::SHADER_INT64);
}

#[test]
fn cuda_kernel_dim3_values_do_not_broaden_const_record_or_storage_rules() {
    for source in [
        "__global__ void kernel(const dim3 shape) { shape.x = 1u; }",
        "__global__ void kernel(const dim3 shape) { shape = dim3(1u); }",
        "struct Record { dim3 shape; }; __global__ void kernel(Record record) {}",
        "__global__ void kernel(dim3 shape);",
        "__global__ void kernel(dim3 shape = dim3()) {}",
        "__global__ void kernel() { __shared__ dim3 shape; }",
        "__global__ void kernel() { extern __shared__ dim3 shapes[]; }",
        "__constant__ dim3 shape; __global__ void kernel() {}",
        "__global__ void kernel(dim3 input) { dim3 shape{1.5f}; }",
    ] {
        reject(source);
    }
}
