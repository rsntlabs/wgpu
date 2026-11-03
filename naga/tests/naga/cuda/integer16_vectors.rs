use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{source_binding_initializer, validate_with_options_and_capabilities};

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT16,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn calls(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut targets = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    targets
}

#[test]
fn cuda_integer16_vectors_preserve_cuda_element_layouts_and_storage_access() {
    for (name, scalar) in [("short", naga::Scalar::I16), ("ushort", naga::Scalar::U16)] {
        for (width, stride, alignment) in [(2, 4, 4), (3, 6, 2), (4, 8, 8)] {
            let (module, _) = roundtrip(&format!(
                "__global__ void copy(const {name}{width} *input, {name}{width} *output) {{
                    output[1] = input[2]; output[0].x = input[0].x;
                }}"
            ));
            assert_eq!(module.global_variables.len(), 2);
            let mut layouter = naga::proc::Layouter::default();
            layouter.update(module.to_ctx()).unwrap();
            for (binding, (_, global)) in module.global_variables.iter().enumerate() {
                assert_eq!(
                    global.binding,
                    Some(naga::ResourceBinding {
                        group: 0,
                        binding: binding as u32
                    })
                );
                let access = if binding == 0 {
                    naga::StorageAccess::LOAD
                } else {
                    naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                };
                assert_eq!(global.space, naga::AddressSpace::Storage { access });
                let naga::TypeInner::Array {
                    base,
                    size: naga::ArraySize::Dynamic,
                    stride: actual_stride,
                } = module.types[global.ty].inner
                else {
                    panic!("expected a runtime vector array");
                };
                assert_eq!(actual_stride, stride);
                assert_eq!(layouter[base].size, stride);
                assert_eq!(
                    layouter[base].alignment,
                    naga::proc::Alignment::new(alignment).unwrap()
                );
                match &module.types[base].inner {
                    naga::TypeInner::Vector {
                        size,
                        scalar: actual,
                    } => {
                        assert_ne!(width, 3);
                        assert_eq!(*size as u32, width);
                        assert_eq!(*actual, scalar);
                    }
                    naga::TypeInner::Struct { members, span } => {
                        assert_eq!(width, 3);
                        assert_eq!(*span, 6);
                        assert_eq!(members.len(), 3);
                        for (index, member) in members.iter().enumerate() {
                            assert_eq!(member.name.as_deref(), Some(["x", "y", "z"][index]));
                            assert_eq!(member.offset, index as u32 * 2);
                            assert_eq!(
                                module.types[member.ty].inner,
                                naga::TypeInner::Scalar(scalar)
                            );
                        }
                    }
                    _ => panic!("expected a native vector or packed three-field record"),
                }
            }
        }
    }
}

#[test]
fn cuda_integer16_vectors_keep_nested_record_offsets_and_array_strides() {
    for name in ["short", "ushort"] {
        for (width, member_offset, tail_offset, stride) in
            [(2, 4, 8, 12), (3, 2, 8, 10), (4, 8, 16, 24)]
        {
            let (module, _) = roundtrip(&format!(
                "using Value = {name}{width};
                struct Packet {{ short head; Value value; unsigned short tail; }};
                __global__ void kernel(const Packet *input, Packet *output) {{ output[0] = input[1]; }}"
            ));
            for (_, global) in module.global_variables.iter() {
                let naga::TypeInner::Array {
                    base,
                    stride: actual_stride,
                    ..
                } = module.types[global.ty].inner
                else {
                    panic!("packet array");
                };
                assert_eq!(actual_stride, stride);
                let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
                    panic!("packet element");
                };
                assert_eq!(span, stride);
                assert_eq!(
                    members
                        .iter()
                        .map(|member| member.offset)
                        .collect::<Vec<_>>(),
                    [0, member_offset, tail_offset]
                );
            }
        }
    }
}

#[test]
fn cuda_integer16_vector_constructors_convert_scalars_and_preserve_copy_and_zero_values() {
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let arguments = ["true", "65535u", "-2", "32767.75f"]
                .into_iter()
                .take(width)
                .collect::<Vec<_>>()
                .join(", ");
            roundtrip(&format!(
                "using Value = {name}{width};
                __global__ void kernel(Value *output) {{
                    Value original = make_{name}{width}({arguments});
                    Value copied = original; Value direct(original);
                    Value casted = static_cast<Value>(copied); Value c_style = (Value)direct;
                    Value zero{{}}; Value values[2]{{}};
                    output[0] = casted; output[1] = c_style; output[2] = zero;
                    output[3] = values[1];
                }}"
            ));
            let initializer = vec!["1"; width].join(", ");
            roundtrip(&format!("__global__ void kernel({name}{width} *output) {{ {name}{width} value{{{initializer}}}; output[0] = value; }}"));
            rejected(&format!(
                "__global__ void kernel(int value) {{ {name}{width} vector{{value}}; }}"
            ));
        }
    }
}

#[test]
fn cuda_integer16_vector_fields_keep_scalar_types_and_promote_arithmetic_to_int() {
    for (name, scalar) in [("short", naga::Scalar::I16), ("ushort", naga::Scalar::U16)] {
        for width in [2, 3, 4] {
            let (module, info) = roundtrip(&format!(
                "__global__ void kernel(const {name}{width} *input, int *output) {{
                    {name}{width} value = input[0];
                    auto component = value.x; auto sum = value.x + value.y;
                    auto positive = +value.x; auto negative = -value.y;
                    auto complemented = ~value.x; auto shifted = value.y << 16;
                    auto previous = value.x++;
                    output[0] = component; output[1] = sum; output[2] = positive;
                    output[3] = negative; output[4] = complemented; output[5] = shifted;
                    output[6] = previous;
                }}"
            ));
            let function = &module.entry_points[0].function;
            for (binding, expected) in [
                ("component", scalar),
                ("previous", scalar),
                ("sum", naga::Scalar::I32),
                ("positive", naga::Scalar::I32),
                ("negative", naga::Scalar::I32),
                ("complemented", naga::Scalar::I32),
                ("shifted", naga::Scalar::I32),
            ] {
                let value = source_binding_initializer(function, binding);
                assert_eq!(
                    info.get_entry_point(0)[value].ty.inner_with(&module.types),
                    &naga::TypeInner::Scalar(expected),
                    "{name}{width} binding {binding}"
                );
            }
            for field in ["x", "y", "z", "w"].into_iter().take(width) {
                roundtrip(&format!(
                    "__global__ void kernel({name}{width} *output) {{
                        output[0].{field} += 2; ++output[0].{field};
                        output[1].{field} = output[0].{field}++;
                    }}"
                ));
            }
        }
    }
}

#[test]
fn cuda_integer16_vector_aliases_helpers_and_templates_keep_exact_source_identity() {
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let (module, _) = roundtrip(&format!(
                "using Value = {name}{width}; using Frozen = const Value;
                template<class Type> __device__ Type identity(Type value) {{ return value; }}
                __device__ Value changed(const Value);
                __device__ Value changed(Value value) {{ value.x += 1; return value; }}
                __global__ void kernel(Frozen *input, Value *output) {{
                    output[0] = identity<Value>(input[0]);
                    output[1] = identity<{name}{width}>(input[1]);
                    output[2] = changed(input[2]);
                    {{ using {name}{width} = int; {name}{width} count = 3; output[3].x = count; }}
                }}"
            ));
            let targets = calls(&module.entry_points[0].function);
            assert_eq!(targets.len(), 3);
            assert_eq!(targets[0], targets[1]);
            assert_ne!(targets[0], targets[2]);
            for target in targets {
                let function = &module.functions[target];
                assert_eq!(
                    function.arguments[0].ty,
                    function.result.as_ref().unwrap().ty
                );
            }
            rejected(&format!(
                "using {name}{width} = int; __global__ void kernel() {{}}"
            ));
        }
    }
    roundtrip(
        "__device__ int choose(short2 value) { return value.x; }
        __device__ int choose(ushort2 value) { return value.y; }
        __device__ int choose(short3 value) { return value.z; }
        __global__ void kernel(int *output) {
            output[0] = choose(make_short2(1, 2)); output[1] = choose(make_ushort2(3, 4));
            output[2] = choose(make_short3(5, 6, 7));
        }",
    );
}

#[test]
fn cuda_integer16_vector_references_and_const_qualifiers_reach_members() {
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            roundtrip(&format!(
                "using Value = {name}{width}; using Frozen = const Value;
                __device__ void alter(Value &target, const Value &source) {{ target = source; target.x += 1; }}
                __global__ void kernel(Frozen *input, Value *output, int condition) {{
                    Value local = input[0]; Value &selected = condition ? output[0] : local;
                    alter(selected, input[1]); const Value &observed = local;
                    output[1] = observed; output[2] = local;
                }}"
            ));
            for operation in [
                "input[0].x = 1;",
                "input[0].y++;",
                "output[0] = input[0]; input[1] = output[0];",
                "Value *pointer = input;",
                "Value &reference = input[0];",
                "(condition ? input[0] : output[0]).x += 1;",
            ] {
                let error = rejected(&format!("using Value = {name}{width}; __global__ void kernel(const Value *input, Value *output, int condition) {{ {operation} }}"));
                assert!(!error.message.is_empty());
            }
        }
    }
}

#[test]
fn cuda_integer16_vectors_share_storage_layouts_across_local_shared_and_constant_arrays() {
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let (module, _) = roundtrip(&format!(
                "using Value = {name}{width}; __constant__ Value Table[2];
                __global__ void kernel(Value *output) {{
                    Value local[2]{{}}; __shared__ Value shared[2];
                    shared[0] = Table[0]; __syncthreads();
                    local[0] = shared[0]; output[0] = local[0]; output[1] = Table[1];
                }}"
            ));
            let function = &module.entry_points[0].function;
            let local = function
                .local_variables
                .iter()
                .find_map(|(_, local)| (local.name.as_deref() == Some("local")).then_some(local))
                .unwrap();
            let mut arrays = vec![local.ty];
            for (_, global) in module.global_variables.iter() {
                if global.space == naga::AddressSpace::WorkGroup
                    || global.binding.is_some_and(|binding| binding.group == 1)
                {
                    arrays.push(global.ty);
                    if global.binding.is_some() {
                        assert_eq!(
                            global.space,
                            naga::AddressSpace::Storage {
                                access: naga::StorageAccess::LOAD
                            }
                        );
                    }
                }
            }
            assert_eq!(arrays.len(), 3);
            for ty in arrays {
                let naga::TypeInner::Array {
                    size: naga::ArraySize::Constant(count),
                    stride,
                    ..
                } = module.types[ty].inner
                else {
                    panic!("fixed vector array");
                };
                assert_eq!((count.get(), stride), (2, width * 2));
            }
            rejected(&format!("using Value = {name}{width}; __constant__ Value Table[2]; __global__ void kernel() {{ Table[0].x = 1; }}"));
        }
    }
}

#[test]
fn cuda_integer16_vector_dynamic_shared_uses_cuda_element_strides() {
    let options = Options {
        workgroup_size: [1, 1, 1],
        dynamic_shared_memory_size: 24,
    };
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let arguments = vec!["1"; width as usize].join(", ");
            let source = format!(
                "using Value = {name}{width}; __global__ void kernel(Value *output) {{
                    extern __shared__ Value shared[];
                    shared[0] = make_{name}{width}({arguments}); __syncthreads(); output[0] = shared[0];
                }}"
            );
            let (module, info) = validate_with_options_and_capabilities(
                &source,
                &options,
                Capabilities::SHADER_INT16,
            );
            let shared = module
                .global_variables
                .iter()
                .find_map(|(_, global)| {
                    (global.space == naga::AddressSpace::WorkGroup).then_some(global)
                })
                .unwrap();
            let naga::TypeInner::Array {
                size: naga::ArraySize::Constant(count),
                stride,
                ..
            } = module.types[shared.ty].inner
            else {
                panic!("specialized dynamic vector array");
            };
            assert_eq!((count.get(), stride), (24 / (width * 2), width * 2));
            #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
            super::helpers::wgsl_roundtrip_with_capabilities(
                &module,
                &info,
                naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
                Capabilities::SHADER_INT16,
            );
            let _ = info;
        }
    }
}

#[test]
fn cuda_integer16_vector_make_functions_keep_arity_scalar_types_and_overload_boundaries() {
    for (name, component) in [("short", "short"), ("ushort", "unsigned short")] {
        for width in [2, 3, 4] {
            for count in 0..=5 {
                if count == width {
                    continue;
                }
                let arguments = vec!["1"; count].join(", ");
                rejected(&format!(
                    "__global__ void kernel() {{ make_{name}{width}({arguments}); }}"
                ));
            }
            let parameters = ["x", "y", "z", "w"]
                .into_iter()
                .take(width)
                .map(|field| format!("Component {field}"))
                .collect::<Vec<_>>()
                .join(", ");
            let arguments = ["x", "y", "z", "w"]
                .into_iter()
                .take(width)
                .collect::<Vec<_>>()
                .join(", ");
            rejected(&format!("using Component = {component}; __device__ {name}{width} make_{name}{width}({parameters}) {{ return make_{name}{width}({arguments}); }} __global__ void kernel() {{}}"));
            let arguments = vec!["1"; width - 1].join(", ");
            rejected(&format!("__global__ void kernel(short *pointer) {{ make_{name}{width}(pointer, {arguments}); }}"));
        }
    }
    roundtrip(
        "__device__ short3 make_short3(int value) { return make_short3(value, value, value); }
        __global__ void kernel(short3 *output) { output[0] = make_short3(7); output[1] = make_short3(1, 2, 3); }",
    );
}

#[test]
fn cuda_integer16_vectors_reject_invalid_fields_unrelated_casts_and_implicit_arithmetic() {
    roundtrip(
        "__device__ short2 operator+(short2 left, short2 right) {
            return make_short2(left.x + right.x, left.y + right.y);
        }
        __global__ void kernel(short2 *output) { output[0] = output[1] + output[2]; }",
    );
    for name in ["short", "ushort"] {
        for width in [2, 3, 4] {
            let arguments = vec!["1"; width].join(", ");
            for expression in [
                "value + value",
                "value * value",
                "value == value",
                "-value",
                "!value",
                "value++",
                "value += value",
                "value ? 1 : 2",
                "value[0]",
            ] {
                rejected(&format!("__global__ void kernel() {{ {name}{width} value = make_{name}{width}({arguments}); {expression}; }}"));
            }
            for field in ["xy", "missing", "r"] {
                let source = format!("// λ\n__global__ void kernel({name}{width} *output) {{ output[0].{field} = 1; }}");
                let error = rejected(&source);
                assert_eq!(&source[error.span.to_range().unwrap()], field);
            }
            for field in ["x", "y", "z", "w"].into_iter().skip(width) {
                let source = format!(
                    "__global__ void kernel({name}{width} *output) {{ output[0].{field} = 1; }}"
                );
                assert_eq!(&source[rejected(&source).span.to_range().unwrap()], field);
            }
            rejected(&format!("__global__ void kernel({name}{width} value) {{}}"));
        }
    }
    for (source, target) in [
        ("short2", "ushort2"),
        ("short3", "int3"),
        ("ushort4", "uint4"),
        ("short2", "short3"),
    ] {
        for expression in [
            String::from("input[0]"),
            format!("static_cast<{target}>(input[0])"),
            format!("({target})input[0]"),
        ] {
            rejected(&format!("__global__ void kernel(const {source} *input, {target} *output) {{ output[0] = {expression}; }}"));
        }
    }
}

#[test]
fn cuda_integer16_vector_resources_require_the_integer16_capability() {
    for name in [
        "short2", "short3", "short4", "ushort2", "ushort3", "ushort4",
    ] {
        let source = format!("__global__ void kernel(const {name} *input, {name} *output) {{ output[0] = input[0]; }}");
        let module = parse_str(&source, &Options::default()).unwrap();
        let error =
            naga::valid::Validator::new(naga::valid::ValidationFlags::all(), Capabilities::empty())
                .validate(&module)
                .unwrap_err();
        assert!(format!("{error:?}").contains("SHADER_INT16"), "{error:?}");
        roundtrip(&source);
    }
}

#[test]
fn cuda_integer16_vector_canonical_fixture_preserves_packed_triples_and_count_binding() {
    let options = Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    };
    let (module, info) = validate_with_options_and_capabilities(
        include_str!("../../in/cuda/integer16-vectors.cu"),
        &options,
        Capabilities::SHADER_INT16,
    );
    assert_eq!(module.entry_points[0].name, "integer16_vectors");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for global in &globals[..2] {
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("triple array");
        };
        assert_eq!(stride, 6);
        let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
            panic!("packed triple");
        };
        assert_eq!(span, 6);
        assert_eq!(
            members
                .iter()
                .map(|member| member.offset)
                .collect::<Vec<_>>(),
            [0, 2, 4]
        );
    }
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[3].ty].inner else {
        panic!("count wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U16)
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    let _ = info;
}
