use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{validate, validate_with_options_and_capabilities};

const SCALARS: [(&str, naga::Scalar); 6] = [
    ("bool", naga::Scalar::BOOL),
    ("int", naga::Scalar::I32),
    ("unsigned", naga::Scalar::U32),
    ("float", naga::Scalar::F32),
    ("short", naga::Scalar::I16),
    ("unsigned short", naga::Scalar::U16),
];

const VECTOR_SCALARS: [(&str, naga::Scalar); 5] = [
    ("float", naga::Scalar::F32),
    ("int", naga::Scalar::I32),
    ("uint", naga::Scalar::U32),
    ("short", naga::Scalar::I16),
    ("ushort", naga::Scalar::U16),
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

fn array_type(module: &naga::Module, name: &str) -> (naga::Handle<naga::Type>, u32, u32) {
    let local = module.entry_points[0]
        .function
        .local_variables
        .iter()
        .find_map(|(_, local)| (local.name.as_deref() == Some(name)).then_some(local))
        .unwrap();
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[local.ty].inner
    else {
        panic!("expected a complete fixed array for {name}");
    };
    (base, count.get(), stride)
}

#[test]
fn cuda_parenthesized_arrays_initialize_fixed_elements_in_source_order() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int values[3](7, values[0] + 1);
            out[0] = values[0] + values[1] + values[2];
        }",
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_parenthesized_arrays_preserve_all_scalar_element_types_counts_and_strides() {
    for (name, scalar) in SCALARS {
        for (bound, count) in [("3", 3), ("", 2)] {
            let (module, _) = roundtrip(
                &format!(
                    "using Element = {name}; __global__ void kernel(unsigned *output) {{
                    Element values[{bound}](1, 2); output[0] = unsigned(values[1]);
                }}"
                ),
                capabilities(scalar),
            );
            let (base, actual_count, stride) = array_type(&module, "values");
            assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            assert_eq!(actual_count, count);
            let mut layouter = naga::proc::Layouter::default();
            layouter.update(module.to_ctx()).unwrap();
            assert_eq!(stride, layouter[base].to_stride());
            assert!(module.entry_points[0]
                .function
                .local_variables
                .iter()
                .all(|(_, local)| local.init.is_none()));
        }
    }
    let source =
        "__global__ void kernel(short *output) { short values[2](1); output[0] = values[0]; }";
    let module = parse_str(source, &Options::default()).unwrap();
    assert!(naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        Capabilities::empty()
    )
    .validate(&module)
    .is_err());
    roundtrip(source, Capabilities::SHADER_INT16);
}

#[test]
fn cuda_parenthesized_arrays_use_copy_conversions_and_preserve_explicit_brace_narrowing() {
    roundtrip(
        "__global__ void kernel(unsigned *output, int input) {
            int integers[3](3.75f, -2.75f); unsigned counts[](-1, 7);
            short signed_values[3](65535, 32768); unsigned short unsigned_values[](-1, 65536);
            float samples[2](input, 1.5f); bool flags[](2, 0, -1, 0.25f);
            int local = 7; int *present = &local; int *missing = nullptr;
            bool pointer_flags[4](present, missing, bool(present), bool(nullptr));
            output[0] = unsigned(integers[0] + integers[1]); output[1] = counts[0];
            output[2] = unsigned(signed_values[1]); output[3] = unsigned(unsigned_values[1]);
            output[4] = unsigned(samples[0]); output[5] = unsigned(flags[2]);
            output[6] = unsigned(pointer_flags[0]) + unsigned(pointer_flags[2]);
        }",
        Capabilities::SHADER_INT16,
    );
    rejected("__global__ void kernel() { bool flags[1](nullptr); }");
    for declaration in [
        "short values[2]({65535}, 2);",
        "short values[2]({input}, 2);",
        "unsigned values[2]({-1}, 2);",
        "float values[2]({input}, 2.0f);",
        "int values[2]({1.5f}, 2);",
        "bool values[2]({2}, false);",
    ] {
        let error = rejected(&format!(
            "__global__ void kernel(int input) {{ {declaration} }}"
        ));
        assert!(error.message.contains("narrow"), "{error}");
    }
}

#[test]
fn cuda_parenthesized_arrays_copy_all_twenty_vector_types_and_default_remaining_elements() {
    for (prefix, scalar) in VECTOR_SCALARS {
        for width in 1..=4 {
            let name = format!("{prefix}{width}");
            let (module, _) = roundtrip(
                &format!(
                    "using Value = {name}; __global__ void kernel(Value *output) {{
                    Value source{{1}}; Value fixed[3](source, Value(2));
                    Value inferred[](source, Value(3)); source.x = 9;
                    output[0] = fixed[0]; output[1] = fixed[1]; output[2] = fixed[2];
                    output[3] = inferred[1];
                }}"
                ),
                capabilities(scalar),
            );
            let (base, count, stride) = array_type(&module, "fixed");
            assert_eq!(count, 3);
            assert_eq!(stride, width * u32::from(scalar.width));
            assert_eq!(array_type(&module, "inferred"), (base, 2, stride));
            let global = module.global_variables.iter().next().unwrap().1;
            assert!(
                matches!(module.types[global.ty].inner, naga::TypeInner::Array { base: actual, .. } if actual == base)
            );
        }
    }
}

#[test]
fn cuda_parenthesized_arrays_apply_cuda_elision_before_inferring_complete_elements() {
    for (prefix, scalar) in VECTOR_SCALARS {
        for width in 1..=4 {
            let name = format!("{prefix}{width}");
            let arguments = (1..=width + 1)
                .map(|value| value.to_string())
                .collect::<Vec<_>>()
                .join(", ");
            let (module, _) = roundtrip(
                &format!(
                    "__global__ void kernel({name} *output) {{
                    {name} fixed[3]({arguments}); {name} inferred[]({arguments});
                    output[0] = fixed[0]; output[1] = fixed[2]; output[2] = inferred[1];
                }}"
                ),
                capabilities(scalar),
            );
            assert_eq!(array_type(&module, "fixed").1, 3);
            assert_eq!(array_type(&module, "inferred").1, 2);
        }
    }
    let (module, _) = roundtrip(
        "struct Pair { int first; int second; }; struct Packet { int values[2]; Pair pair; };
        __global__ void kernel(Pair *pairs, Packet *packets) {
            Pair inferred[](1, 2, 3); Pair mixed[3]({1, 2}, Pair(3, 5), 7, 11);
            Packet nested[2](1, 2, 3, 4, 5);
            pairs[0] = inferred[1]; pairs[1] = mixed[2]; packets[0] = nested[1];
        }",
        Capabilities::empty(),
    );
    assert_eq!(array_type(&module, "inferred").1, 2);
}

#[test]
fn cuda_parenthesized_arrays_keep_braced_arguments_scoped_to_one_element() {
    roundtrip(
        "struct Pair { int first; int second; }; struct Row { int values[2]; int tail; };
        __global__ void kernel(int *output, Pair *pairs, Row *rows) {
            int fixed[3]({1}, {2}); int mixed[]({3}, 5, {7});
            Pair records[2]({11, 13}, {17, 19}); Pair inferred[]({23, 29}, {31, 37});
            Row nested[2]({{19, 23}, 29}, {{31}, 37});
            output[0] = fixed[2]; output[1] = mixed[1]; pairs[0] = records[1];
            pairs[1] = inferred[1]; rows[0] = nested[1];
        }",
        Capabilities::empty(),
    );
    for declaration in [
        "int values[3]({1, 2});",
        "int values[]({1, 2});",
        "Pair values[2]({{1, 2}, {3, 5}});",
        "Pair values[]({{7, 11}, {13, 17}});",
    ] {
        rejected(&format!("struct Pair {{ int first; int second; }}; __global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_parenthesized_arrays_complete_each_element_before_later_reads_and_calls() {
    let (module, _) = roundtrip(
        "__device__ int observed(int value) { return value; }
        __global__ void kernel(int *output) {
            int self[](1, self[0] + 1, self[1] + 1);
            int changed[3](1, ++changed[0], changed[0]);
            int assigned[](1, (assigned[0] = 7, 2), assigned[0]);
            int counter = 0; int ordered[3](counter++, counter++, counter);
            int called[3](observed(3), observed(5));
            output[0] = self[2]; output[1] = changed[0]; output[2] = changed[2];
            output[3] = assigned[0] + assigned[2]; output[4] = ordered[1] + counter;
            output[5] = called[0] + called[1] + called[2];
        }",
        Capabilities::empty(),
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if matches!(statement, naga::Statement::Call { .. }) {
            calls += 1;
        }
        false
    });
    assert_eq!(calls, 2);
    roundtrip(
        "struct Pair { int first; int second; };
        __global__ void kernel(Pair *output) {
            Pair values[2](Pair(7, values[0].first + 1), Pair(11, values[1].first + 1));
            Pair modified[2](Pair(13, ++modified[0].first), Pair(17, ++modified[1].first));
            output[0] = values[0]; output[1] = values[1];
            output[2] = modified[0]; output[3] = modified[1];
        }",
        Capabilities::empty(),
    );
    for initializer in [
        "Pair(3, values[0].first + 1), Pair(5, ++values[0].first)",
        "Pair{3, values[0].first + 1}, Pair{5, ++values[0].first}",
    ] {
        let (module, _) = roundtrip(
            &format!(
                "struct Pair {{ int first; int second; }};
            __global__ void kernel(Pair *output) {{
                Pair values[]({initializer}); output[0] = values[0]; output[1] = values[1];
            }}"
            ),
            Capabilities::empty(),
        );
        assert_eq!(array_type(&module, "values").1, 2);
    }
    roundtrip(
        "struct Pair { int first; int second; };
        __device__ Pair mutate(Pair &value) { value.first += 100; return value; }
        __global__ void kernel(Pair *output) {
            Pair source{3, 5}; Pair values[2](source, mutate(source));
            source.second = 200; output[0] = values[0]; output[1] = values[1];
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_arrays_preserve_constructor_defaults_and_loop_resets() {
    roundtrip(
        "struct WithShape { dim3 shape; int tail; };
        __global__ void kernel(unsigned *output) {
            dim3 shapes[2](2u); dim3 complete[3](dim3(3u, 5u), dim3(make_uint3(7u, 11u, 13u)));
            WithShape records[2](WithShape{dim3(17u), 19});
            output[0] = shapes[1].x + shapes[1].y + shapes[1].z;
            output[1] = complete[2].x + complete[2].y + complete[2].z;
            output[2] = records[1].shape.y + unsigned(records[1].tail);
            int total = 0;
            for (int index = 0; index < 3; ++index) {
                int values[3](index); int2 pairs[2]((int2(index)));
                total += values[1] + values[2] + pairs[0].y + pairs[1].x;
                values[1] = 9; pairs[1].x = 11;
            }
            output[3] = unsigned(total);
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_arrays_reuse_aliases_constness_helpers_templates_and_declarator_scopes() {
    roundtrip(
        "using Number = int; using Frozen = const int;
        template<class Value> __device__ Value first(Value seed) { Value values[2](seed); return values[0]; }
        __device__ int sum(int seed) { int values[](seed, seed + 1); return values[0] + values[1]; }
        __global__ void kernel(int *output, int input) {
            Number Number[](1, 2), next[](Number[1], Number[0]), scalar(next[0]);
            Frozen fixed[3](input), inferred[](input + 1, input + 2);
            int values[2](3), *pointer = values, &alias = values[0];
            int total = 0;
            for (int scratch[2](input), index = 0; index < 2; ++index) total += scratch[1];
            output[0] = scalar + fixed[2] + inferred[1] + *pointer + alias;
            output[1] = total + first<int>(input) + sum(input);
        }",
        Capabilities::empty(),
    );
    for declaration in [
        "const int values[2](1);",
        "using Frozen = const int; Frozen values[](1, 2);",
    ] {
        for operation in ["values[0] = 3;", "++values[0];", "values[1] += 1;"] {
            let error = rejected(&format!(
                "__global__ void kernel() {{ {declaration} {operation} }}"
            ));
            assert!(error.message.contains("const"), "{error}");
        }
    }
    let source = "__global__ void kernel() { for (int hidden[2](1); false;) {} hidden[0]; }";
    assert_eq!(&source[rejected(source).span.to_range().unwrap()], "hidden");
}

#[test]
fn cuda_parenthesized_arrays_keep_nested_shapes_row_defaults_and_inferred_outer_bounds() {
    for (declaration, outer_count, first_leaf) in [
        ("int values[2][3]({1, 2}, {3});", 2, "values[0][0]"),
        (
            "int values[][2]({5, 7}, {11, 13}, {17});",
            3,
            "values[0][0]",
        ),
        ("int values[2][2](1, 2, 3);", 2, "values[0][0]"),
        ("int values[][2](1, 2, 3);", 2, "values[0][0]"),
        ("int values[][2][2](1, 2, 3, 4, 5);", 2, "values[0][0][0]"),
    ] {
        let (module, _) = roundtrip(
            &format!(
                "__global__ void kernel(int *output) {{ {declaration} output[0] = {first_leaf}; }}"
            ),
            Capabilities::empty(),
        );
        let (row, count, stride) = array_type(&module, "values");
        assert_eq!(count, outer_count);
        assert!(matches!(
            module.types[row].inner,
            naga::TypeInner::Array { .. }
        ));
        let mut layouter = naga::proc::Layouter::default();
        layouter.update(module.to_ctx()).unwrap();
        assert_eq!(stride, layouter[row].to_stride());
    }
    roundtrip(
        "__global__ void kernel(int *output) {
            int values[2][2]({1}, {values[0][1] + 2, values[0][0] + 3});
            output[0] = values[1][0] + values[1][1];
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_arrays_preserve_unknown_bound_constant_address_eligibility() {
    roundtrip(
        "__global__ void kernel(int *output) {
            float values[](1.0f, 2.0f, (values[1], 3));
            float explicit_brace[](1.0f, {(explicit_brace[0], 2)});
            float known[3](1.0f, 2.0f, {(known[1], 3)});
            constexpr int Count = (values[2], 3); int scratch[Count](7);
            output[0] = int(values[2] + explicit_brace[1] + known[2]) + scratch[2];
        }",
        Capabilities::empty(),
    );
    for expression in ["(values[1], 3)", "(values[100], 3)"] {
        let error = rejected(&format!(
            "__global__ void kernel() {{ float values[](1.0f, 2.0f, {{{expression}}}); }}"
        ));
        assert!(error.message.contains("narrow"), "{error}");
    }
    roundtrip(
        "__global__ void kernel() { float values[](1.0f, true ? 2 : (values[100], 3)); }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_arrays_preserve_native_declaration_ambiguity_and_element_diagnostics() {
    roundtrip(
        "struct Pair { int first; int second; };
        __global__ void kernel(int *output, Pair *pairs) {
            int seed = 11; Pair source{13, 17}; int values[2]((int(seed)));
            Pair copied[2]((Pair(source))); output[0] = values[1]; pairs[0] = copied[1];
        }",
        Capabilities::empty(),
    );
    for declaration in [
        "int values[2]();",
        "int values[]();",
        "int values[2](int(seed));",
        "int values[](int(seed));",
        "Pair values[2](Pair(source));",
        "int2 values[2](int2(vector));",
        "int values[2](1,);",
        "int values[](1,);",
        "int values[2] = (1, 2);",
        "int values[] = (1, 2);",
        "int values[2](1, 2, 3);",
        "uint2 values[2](vector);",
        "int values[2](vector);",
        "int values[0](1);",
        "int values[-1](1);",
        "int values[input](1);",
        "int values[2][](1);",
        "int source_values[2]{1, 2}; int values[2](source_values);",
        "Pair source_values[2]{}; Pair values[2](source_values);",
        "int *values[2](nullptr);",
        "constexpr int values[2](1);",
        "__shared__ int values[2](1);",
    ] {
        rejected(&format!(
            "/* café 漢 */ struct Pair {{ int first; int second; }};
            __global__ void kernel(int input) {{ int seed = 3; Pair source{{3, 5}}; int2 vector{{7, 11}}; {declaration} }}"
        ));
    }
    let source = "/* café 漢 */ __global__ void kernel() { return; int values[2](1, missing); }";
    assert_eq!(
        &source[rejected(source).span.to_range().unwrap()],
        "missing"
    );
}

#[test]
fn cuda_parenthesized_arrays_bound_initializer_growth_and_nesting_without_large_graphs() {
    for count in [8, 256] {
        let arguments = vec!["1"; count].join(", ");
        for bound in [String::new(), (count * 2).to_string()] {
            let (module, _) = roundtrip(
                &format!("__global__ void kernel() {{ int values[{bound}]({arguments}); }}"),
                Capabilities::empty(),
            );
            let expected_count = if bound.is_empty() { count } else { count * 2 };
            assert_eq!(array_type(&module, "values").1, expected_count as u32);
            assert!(module.entry_points[0].function.expressions.len() < count * 8 + 128);
            assert!(module.entry_points[0].function.local_variables.len() < 16);
        }
    }
    let expression = format!("{}1{}", "(".repeat(160), ")".repeat(160));
    let error = rejected(&format!(
        "__global__ void kernel() {{ int values[2]({expression}); }}"
    ));
    assert!(
        error.message.contains("depth") || error.message.contains("nesting"),
        "{error}"
    );
}

#[test]
fn cuda_parenthesized_array_fixture_preserves_resource_bindings_and_backend_roundtrips() {
    let options = Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    };
    let (module, info) = validate_with_options_and_capabilities(
        include_str!("../../in/cuda/parenthesized-arrays.cu"),
        &options,
        Capabilities::SHADER_INT16,
    );
    assert_eq!(module.entry_points[0].name, "parenthesized_arrays");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect::<Vec<_>>();
    assert_eq!(globals.len(), 3);
    for (binding, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: binding as u32
            })
        );
    }
    assert_eq!(
        globals[0].space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    assert_eq!(
        globals[1].space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    assert_eq!(globals[2].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[2].ty].inner else {
        panic!("expected the existing scalar uniform wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert!(module.entry_points[0]
        .function
        .local_variables
        .iter()
        .all(|(_, local)| !matches!(
            module.types[local.ty].inner,
            naga::TypeInner::Array {
                size: naga::ArraySize::Dynamic | naga::ArraySize::Pending(_),
                ..
            }
        )));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    let _ = info;
}
