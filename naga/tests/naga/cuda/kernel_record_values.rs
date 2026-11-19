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
fn cuda_kernel_record_values_keep_one_to_four_scalar_fields_and_fixed_launch_wrappers() {
    let fields = ["int x;", "unsigned y;", "float z;", "unsigned w;"];
    for count in 1..=4 {
        let declaration = fields[..count].join(" ");
        let (module, _) = validate(&format!("struct Record {{ {declaration} }}; __global__ void kernel(unsigned *out, const Record original, Record value, const Record *source) {{ Record copy = value; value.x += 1; copy.x = 2; out[0] = unsigned(original.x + value.x + copy.x + source[0].x); }}"));
        assert_eq!(module.global_variables.len(), 4);
        let (_, storage) = module
            .global_variables
            .iter()
            .find(|(_, global)| global.name.as_deref() == Some("source"))
            .unwrap();
        let naga::TypeInner::Array {
            base: record_ty,
            stride,
            ..
        } = module.types[storage.ty].inner
        else {
            panic!("expected storage array of the same record type");
        };
        assert_eq!(stride, count as u32 * 4);
        let function = &module.entry_points[0].function;
        for (global_handle, global) in module
            .global_variables
            .iter()
            .filter(|(_, global)| global.space == naga::AddressSpace::Uniform)
        {
            let naga::TypeInner::Struct { ref members, span } = module.types[global.ty].inner
            else {
                panic!("expected launch wrapper");
            };
            assert_eq!(span, 16);
            assert_eq!(members.len(), 1);
            assert_eq!(members[0].offset, 0);
            assert_eq!(members[0].ty, record_ty);
            let naga::TypeInner::Struct {
                members: ref fields,
                span,
            } = module.types[record_ty].inner
            else {
                panic!("expected nominal record");
            };
            assert_eq!(span, count as u32 * 4);
            assert_eq!(fields.len(), count);
            for (index, field) in fields.iter().enumerate() {
                assert_eq!(field.offset, index as u32 * 4);
                assert_eq!(
                    module.types[field.ty].inner,
                    naga::TypeInner::Scalar(
                        [
                            naga::Scalar::I32,
                            naga::Scalar::U32,
                            naga::Scalar::F32,
                            naga::Scalar::U32
                        ][index]
                    )
                );
            }
            let loads = function.expressions.iter().filter(|(_, expression)| {
                let naga::Expression::Load { pointer } = **expression else { return false; };
                matches!(function.expressions[root_expression(function, pointer)], naga::Expression::GlobalVariable(handle) if handle == global_handle)
            }).count();
            assert_eq!(loads, 1);
            naga::proc::any_statement(&function.body, &mut |statement| {
                if let naga::Statement::Store { pointer, .. } = statement {
                    assert!(
                        !matches!(function.expressions[root_expression(function, *pointer)], naga::Expression::GlobalVariable(handle) if handle == global_handle)
                    );
                }
                false
            });
        }
    }
}

#[test]
fn cuda_kernel_record_values_preserve_nominal_overloads_aliases_and_template_instances() {
    let (module, _) = validate("struct Record { int x; unsigned y; float z; }; struct Twin { int x; unsigned y; float z; }; using Config = Record;
        __device__ unsigned kind(Record value) { return 11u; } __device__ unsigned kind(Twin value) { return 22u; }
        __device__ void change(Record &value) { ++value.y; }
        template<class T> __device__ unsigned classify(T value) { return kind(value); }
        __global__ void kernel(unsigned *out, Config value, Twin other) { decltype(value) copy = value; change(copy); out[0] = classify(value) + kind(other) + copy.y; }");
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
    let (module, info) = validate("struct Record { int x; unsigned y; float z; }; template<class T> __global__ void launch(unsigned *out, T value) { T copy = value; copy.y += 1u; out[0] = copy.y; } template __global__ void launch<Record>(unsigned *, Record);");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_kernel_record_values_keep_source_layout_storage_stride_and_mixed_indices() {
    let (module, _) = validate_with_options_and_capabilities("struct Record { int x; unsigned y; float z; }; __global__ void kernel(unsigned *out, unsigned count, int2 offset, dim3 shape, Record value, const Record fixed, const Record *input) { static_assert(sizeof(Record) == 12); static_assert(alignof(Record) == 4); Record local[2]; static_assert(sizeof(local) == 24); out[0] = count + unsigned(offset.x) + shape.z + value.y + fixed.y + input[0].y; }", &Options::default(), naga::valid::Capabilities::SHADER_INT64);
    let mut bindings: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| binding.binding))
        .collect();
    bindings.sort();
    assert_eq!(bindings, [0, 1, 2, 3, 4, 5, 6]);
    let storage = module
        .global_variables
        .iter()
        .find_map(|(_, global)| {
            (global.binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 6,
                }))
            .then_some(global)
        })
        .unwrap();
    let naga::TypeInner::Array { stride, .. } = module.types[storage.ty].inner else {
        panic!("expected storage array");
    };
    assert_eq!(stride, 12);
}

#[test]
fn cuda_kernel_record_values_reject_excluded_fields_const_mutation_and_incomplete_shapes() {
    for fields in [
        "",
        "bool x;",
        "short x;",
        "long x;",
        "int *x;",
        "int x[2];",
        "float2 x;",
        "dim3 x;",
        "Inner x;",
        "unsigned a,b,c,d,e;",
    ] {
        reject(&format!("struct Inner {{ unsigned x; }}; struct Record {{ {fields} }}; __global__ void kernel(Record value) {{}}"));
    }
    for source in [
        "struct Record; __global__ void kernel(Record value) {}",
        "struct Record { unsigned x; }; __global__ void kernel(const Record value) { value.x = 1u; }",
        "struct Record { unsigned x; }; __global__ void kernel(const Record value) { Record other{}; value = other; }",
        "struct Record { unsigned x; }; __global__ void kernel(Record value);",
        "struct Record { unsigned x; }; __global__ void kernel(Record value = Record{}) {}",
    ] { reject(source); }
}
