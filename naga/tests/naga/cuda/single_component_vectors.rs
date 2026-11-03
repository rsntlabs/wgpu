use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{source_binding_initializer, validate_with_options_and_capabilities};

const TYPES: [(&str, &str, naga::Scalar); 5] = [
    ("float1", "float", naga::Scalar::F32),
    ("int1", "int", naga::Scalar::I32),
    ("uint1", "unsigned", naga::Scalar::U32),
    ("short1", "short", naga::Scalar::I16),
    ("ushort1", "unsigned short", naga::Scalar::U16),
];

fn capabilities(scalar: naga::Scalar) -> Capabilities {
    if scalar.width == 2 {
        Capabilities::SHADER_INT16
    } else {
        Capabilities::empty()
    }
}

fn roundtrip(source: &str, capabilities: Capabilities) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
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
fn cuda_single_component_vectors_preserve_scalar_field_layout_and_storage_access() {
    for (name, scalar) in [
        ("float1", naga::Scalar::F32),
        ("int1", naga::Scalar::I32),
        ("uint1", naga::Scalar::U32),
        ("short1", naga::Scalar::I16),
        ("ushort1", naga::Scalar::U16),
    ] {
        let capabilities = if scalar.width == 2 {
            Capabilities::SHADER_INT16
        } else {
            Capabilities::empty()
        };
        let (module, _) = roundtrip(
            &format!(
                "__global__ void copy(const {name} *input, {name} *output) {{
                output[1] = input[2]; output[0].x = input[0].x;
            }}"
            ),
            capabilities,
        );
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
                stride,
            } = module.types[global.ty].inner
            else {
                panic!("single-component resource array");
            };
            let bytes = u32::from(scalar.width);
            assert_eq!(stride, bytes);
            assert_eq!(layouter[base].size, bytes);
            assert_eq!(
                layouter[base].alignment,
                naga::proc::Alignment::new(bytes).unwrap()
            );
            let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
                panic!("expected a source aggregate distinct from its scalar field");
            };
            assert_eq!(span, bytes);
            assert_eq!(members.len(), 1);
            assert_eq!(members[0].name.as_deref(), Some("x"));
            assert_eq!(members[0].offset, 0);
            assert_eq!(
                module.types[members[0].ty].inner,
                naga::TypeInner::Scalar(scalar)
            );
            assert_ne!(base, members[0].ty);
        }
    }
}

#[test]
fn cuda_single_component_vectors_keep_nested_record_and_local_array_layouts() {
    for (name, component, scalar) in TYPES {
        let (module, _) = roundtrip(
            &format!(
                "using Value = {name}; using Component = {component};
            struct Packet {{ Component head; Value value; Component tail; }};
            __global__ void kernel(const Packet *input, Packet *output) {{
                Value local[2]{{}}; output[0] = input[1]; output[1].value = local[0];
            }}"
            ),
            capabilities(scalar),
        );
        let bytes = u32::from(scalar.width);
        for (_, global) in module.global_variables.iter() {
            let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
                panic!("packet array");
            };
            assert_eq!(stride, bytes * 3);
            let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
                panic!("packet");
            };
            assert_eq!(span, bytes * 3);
            assert_eq!(
                members
                    .iter()
                    .map(|member| member.offset)
                    .collect::<Vec<_>>(),
                [0, bytes, bytes * 2]
            );
            assert_ne!(members[0].ty, members[1].ty);
        }
        let local = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find_map(|(_, local)| (local.name.as_deref() == Some("local")).then_some(local))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[local.ty].inner
        else {
            panic!("local wrapper array");
        };
        assert_eq!((count.get(), stride), (2, bytes));
    }
}

#[test]
fn cuda_single_component_vectors_make_copy_brace_and_zero_initialize_values() {
    for (name, _, scalar) in TYPES {
        for argument in ["true", "3", "7u", "2.75f"] {
            roundtrip(&format!(
                "using Value = {name}; __global__ void kernel(Value *output) {{
                    Value original = make_{name}({argument}); Value copied = original;
                    Value direct(original); Value casted = static_cast<Value>(copied);
                    Value c_style = (Value)direct; Value zero{{}}; Value aggregate{{1}};
                    output[0] = casted; output[1] = c_style; output[2] = zero; output[3] = aggregate;
                }}"
            ), capabilities(scalar));
        }
    }
}

#[test]
fn cuda_single_component_vectors_select_nominal_overloads_separately_from_scalars() {
    for (name, component, scalar) in TYPES {
        let (module, _) = roundtrip(&format!(
            "using Value = {name}; using Component = {component};
            __device__ unsigned choose(Value value) {{ return 1u; }}
            __device__ unsigned choose(Component value) {{ return 2u; }}
            __global__ void kernel(unsigned *output) {{
                Value value = make_{name}(1); output[0] = choose(value); output[1] = choose(value.x);
            }}"
        ), capabilities(scalar));
        let targets = calls(&module.entry_points[0].function);
        assert_eq!(targets.len(), 2);
        assert_ne!(targets[0], targets[1]);
        assert!(matches!(
            module.types[module.functions[targets[0]].arguments[0].ty].inner,
            naga::TypeInner::Struct { .. }
        ));
        assert_eq!(
            module.types[module.functions[targets[1]].arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
}

#[test]
fn cuda_single_component_vector_fields_keep_scalar_identity_and_integral_promotions() {
    for (name, _, scalar) in TYPES {
        let (module, info) = roundtrip(
            &format!(
                "__global__ void kernel(const {name} *input, unsigned *output) {{
                {name} value = input[0]; auto field = value.x; auto positive = +value.x;
                auto sum = value.x + value.x; auto previous = value.x++;
                output[0] = unsigned(field); output[1] = unsigned(positive);
                output[2] = unsigned(sum); output[3] = unsigned(previous);
            }}"
            ),
            capabilities(scalar),
        );
        let promoted = if scalar.width == 2 {
            naga::Scalar::I32
        } else {
            scalar
        };
        for (name, expected) in [
            ("field", scalar),
            ("previous", scalar),
            ("positive", promoted),
            ("sum", promoted),
        ] {
            let value = source_binding_initializer(&module.entry_points[0].function, name);
            assert_eq!(
                info.get_entry_point(0)[value].ty.inner_with(&module.types),
                &naga::TypeInner::Scalar(expected),
                "{name}"
            );
        }
    }
}

#[test]
fn cuda_single_component_vector_aliases_templates_and_helpers_retain_nominal_types() {
    for (name, component, scalar) in TYPES {
        let (module, _) = roundtrip(
            &format!(
                "using Value = {name}; using Component = {component};
            template<class Type> __device__ Type identity(Type value) {{ return value; }}
            __device__ Value changed(const Value);
            __device__ Value changed(Value value) {{ value.x += 1; return value; }}
            __global__ void kernel(const Value *input, Value *output) {{
                output[0] = identity<Value>(input[0]); output[1] = identity<{name}>(input[1]);
                output[2].x = identity<Component>(input[2].x); output[3] = changed(input[3]);
                {{ using {name} = int; {name} count = 3; output[4].x = count; }}
                output[5] = identity(input[0]);
            }}"
            ),
            capabilities(scalar),
        );
        let targets = calls(&module.entry_points[0].function);
        assert_eq!(targets.len(), 5);
        assert_eq!(targets[0], targets[1]);
        assert_eq!(targets[0], targets[4]);
        assert_ne!(targets[0], targets[2]);
        for target in targets {
            let function = &module.functions[target];
            assert_eq!(
                function.arguments[0].ty,
                function.result.as_ref().unwrap().ty
            );
        }
        rejected(&format!(
            "using {name} = int; __global__ void kernel() {{}}"
        ));
    }
}

#[test]
fn cuda_single_component_vector_references_and_const_qualifiers_reach_the_field() {
    for (name, component, scalar) in TYPES {
        roundtrip(&format!(
            "using Value = {name}; using Component = {component};
            __device__ Component read(const Value &value) {{ return value.x; }}
            __device__ void alter(Value &target, const Value &source) {{ target = source; target.x += 1; }}
            __global__ void kernel(const Value *input, Value *output, int condition) {{
                Value local = input[0]; Value &selected = condition ? output[0] : local;
                alter(selected, input[1]); const Value &observed = local;
                output[1] = observed; output[2].x = read(observed);
            }}"
        ), capabilities(scalar));
        for operation in [
            "input[0].x = 1;",
            "++input[0].x;",
            "Value *pointer = input;",
            "Value &reference = input[0];",
            "(condition ? input[0] : output[0]).x += 1;",
        ] {
            rejected(&format!("using Value = {name}; __global__ void kernel(const Value *input, Value *output, int condition) {{ {operation} }}"));
        }
    }
}

#[test]
fn cuda_single_component_vectors_preserve_local_shared_and_read_only_constant_storage() {
    for (name, _, scalar) in TYPES {
        let (module, _) = roundtrip(
            &format!(
                "using Value = {name}; __constant__ Value Table[2];
            __global__ void kernel(Value *output) {{
                Value local[2]{{}}; __shared__ Value shared[2]; shared[0] = Table[0];
                __syncthreads(); local[0] = shared[0]; output[0] = local[0]; output[1] = Table[1];
            }}"
            ),
            capabilities(scalar),
        );
        let arrays: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, global)| {
                (global.space == naga::AddressSpace::WorkGroup
                    || global.binding.is_some_and(|binding| binding.group == 1))
                .then_some(global)
            })
            .collect();
        assert_eq!(arrays.len(), 2);
        for global in arrays {
            let naga::TypeInner::Array {
                size: naga::ArraySize::Constant(count),
                stride,
                ..
            } = module.types[global.ty].inner
            else {
                panic!("fixed wrapper array");
            };
            assert_eq!((count.get(), stride), (2, u32::from(scalar.width)));
            if global.binding.is_some() {
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD
                    }
                );
            }
        }
        rejected(&format!("using Value = {name}; __constant__ Value Table[2]; __global__ void kernel() {{ Table[0].x += 1; }}"));
    }
}

#[test]
fn cuda_single_component_vectors_specialize_dynamic_shared_at_the_scalar_stride() {
    let options = Options {
        workgroup_size: [1, 1, 1],
        dynamic_shared_memory_size: 16,
    };
    for (name, _, scalar) in TYPES {
        let source = format!(
            "__global__ void kernel({name} *output) {{ extern __shared__ {name} values[];
                values[0] = make_{name}(1); __syncthreads(); output[0] = values[0]; }}"
        );
        let (module, info) =
            validate_with_options_and_capabilities(&source, &options, capabilities(scalar));
        let global = module
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
        } = module.types[global.ty].inner
        else {
            panic!("dynamic wrapper array");
        };
        assert_eq!(
            (count.get(), stride),
            (16 / u32::from(scalar.width), u32::from(scalar.width))
        );
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip_with_capabilities(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
            capabilities(scalar),
        );
        let _ = info;
    }
}

#[test]
fn cuda_single_component_vectors_reject_implicit_scalar_conversions_arithmetic_and_extra_fields() {
    for (name, component, _) in TYPES {
        for operation in [
            "Value value = scalar;",
            "Component value = wrapped;",
            "wrapped = scalar;",
            "scalar = wrapped;",
            "wrapped + wrapped;",
            "++wrapped;",
            "wrapped += wrapped;",
            "wrapped ? 1 : 2;",
            "wrapped[0];",
        ] {
            rejected(&format!("using Value = {name}; using Component = {component}; __global__ void kernel(Component scalar) {{ Value wrapped = make_{name}(1); {operation} }}"));
        }
        for field in ["y", "z", "w", "xy", "missing"] {
            let source = format!(
                "// λ\n__global__ void kernel({name} *output) {{ output[0].{field} = 1; }}"
            );
            assert_eq!(&source[rejected(&source).span.to_range().unwrap()], field);
        }
        for arguments in ["", "1, 2", "nullptr"] {
            rejected(&format!(
                "__global__ void kernel() {{ make_{name}({arguments}); }}"
            ));
        }
        rejected(&format!("__global__ void kernel({name} value) {{}}"));
    }
    rejected("__global__ void kernel(const int1 *input, uint1 *output) { output[0] = input[0]; }");
    rejected(
        "__global__ void kernel(const float1 *input, float2 *output) { output[0] = input[0]; }",
    );
}

#[test]
fn cuda_single_component_uint_vectors_do_not_replace_uint3_or_dim3_cached_types() {
    for declarations in [
        "uint1 narrow = make_uint1(7); uint3 first = make_uint3(1, 2, 3);",
        "uint3 first = make_uint3(1, 2, 3); uint1 narrow = make_uint1(7);",
    ] {
        let source = format!(
            "__global__ void kernel(unsigned *output) {{ {declarations}
                uint3 second = make_uint3(4, 5, 6); dim3 shape = second; uint3 restored = shape;
                output[0] = narrow.x; output[1] = first.z; output[2] = second.y;
                output[3] = shape.z; output[4] = restored.y;
                output[5] = threadIdx.y; output[6] = blockDim.z;
                dim3 dimensions(blockDim.x, blockDim.y, blockDim.z); output[7] = dimensions.z;
            }}"
        );
        let options = Options {
            workgroup_size: [2, 3, 4],
            ..Options::default()
        };
        let (module, info) =
            validate_with_options_and_capabilities(&source, &options, Capabilities::empty());
        let triple = module
            .types
            .iter()
            .find_map(|(_, ty)| (ty.name.as_deref() == Some("uint3")).then_some(ty))
            .unwrap();
        let naga::TypeInner::Struct { ref members, span } = triple.inner else {
            panic!("uint3");
        };
        assert_eq!(span, 12);
        assert_eq!(
            members
                .iter()
                .map(|member| member.name.as_deref())
                .collect::<Vec<_>>(),
            [Some("x"), Some("y"), Some("z")]
        );
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = info;
    }
    rejected("__global__ void kernel() { uint1 narrow = make_uint1(7); dim3 shape = narrow; }");
    rejected("__global__ void kernel() { uint1 narrow = make_uint1(7); uint3 triple = narrow; }");
}

#[test]
fn cuda_single_component_vector_canonical_fixture_keeps_the_interface_and_integer16_gate() {
    let source = include_str!("../../in/cuda/single-component-vectors.cu");
    let options = Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    };
    let (module, info) =
        validate_with_options_and_capabilities(source, &options, Capabilities::SHADER_INT16);
    assert_eq!(module.entry_points[0].name, "single_component_vectors");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for (index, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
    }
    for global in &globals[..2] {
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("int1 array");
        };
        assert_eq!(stride, 4);
        let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
            panic!("int1");
        };
        assert_eq!(span, 4);
        assert_eq!(members.len(), 1);
        assert_eq!(
            module.types[members[0].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
    }
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[3].ty].inner else {
        panic!("count uniform");
    };
    assert_eq!(span, 16);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    let error =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), Capabilities::empty())
            .validate(&module)
            .unwrap_err();
    assert!(format!("{error:?}").contains("SHADER_INT16"), "{error:?}");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    let _ = info;
}
