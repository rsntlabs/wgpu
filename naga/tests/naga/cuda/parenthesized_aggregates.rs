use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

const SCALARS: [(&str, naga::Scalar); 5] = [
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

fn assert_first_member_stored_before_load(module: &naga::Module, local_name: &str) {
    let function = &module.entry_points[0].function;
    let local = function
        .local_variables
        .iter()
        .find_map(|(handle, local)| (local.name.as_deref() == Some(local_name)).then_some(handle))
        .unwrap();
    let first_member = |pointer| {
        matches!(function.expressions[pointer], naga::Expression::AccessIndex { base, index: 0 }
            if matches!(function.expressions[base], naga::Expression::LocalVariable(actual) if actual == local))
    };
    let mut first_stored = false;
    naga::proc::any_statement(&function.body, &mut |statement| {
        match statement {
            naga::Statement::Store { pointer, .. } if first_member(*pointer) => first_stored = true,
            naga::Statement::Emit(range) => {
                for expression in range.clone() {
                    if let naga::Expression::Load { pointer } = function.expressions[expression] {
                        if first_member(pointer) {
                            assert!(
                                first_stored,
                                "{local_name}.first was read before its initialization store"
                            );
                        }
                    }
                }
            }
            _ => {}
        }
        false
    });
    assert!(first_stored);
}

#[test]
fn cuda_parenthesized_aggregates_construct_vectors_from_scalar_arguments() {
    roundtrip(
        "__global__ void kernel(int1 *single_output, int2 *pair_output) {
            int1 single = int1(7);
            int2 pair(3, 4);
            single_output[0] = single;
            pair_output[0] = pair;
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregates_initialize_all_twenty_vector_types_and_omitted_fields() {
    for (prefix, scalar) in SCALARS {
        for width in 1..=4 {
            let name = format!("{prefix}{width}");
            for count in 0..=width {
                let arguments = ["2.75f", "true", "3u", "-4"]
                    .into_iter()
                    .take(count)
                    .collect::<Vec<_>>()
                    .join(", ");
                let direct = if count == 0 {
                    format!("Value direct = {name}();")
                } else {
                    format!("Value direct({arguments});")
                };
                roundtrip(
                    &format!(
                        "using Value = {name}; __global__ void kernel(Value *output) {{
                        {direct} Value functional = {name}({arguments});
                        Value copied(functional); Value casted = static_cast<Value>(copied);
                        output[0] = direct; output[1] = functional; output[2] = casted;
                    }}"
                    ),
                    capabilities(scalar),
                );
            }
            roundtrip(
                &format!(
                    "__global__ void kernel({name} *output) {{
                    {name} named = static_cast<{name}>(3);
                    {name} c_style = ({name})4;
                    output[0] = named; output[1] = c_style;
                }}"
                ),
                capabilities(scalar),
            );
        }
    }
}

#[test]
fn cuda_parenthesized_aggregates_construct_partial_records_through_aliases_and_casts() {
    roundtrip(
        "struct Record { int first; float second; short last; }; using Alias = Record;
        __global__ void kernel(Record *output) {
            Record direct(3, 2.75f, short(-1)); Alias partial(4);
            Record functional = Record(5, 6.5f); Alias named = static_cast<Alias>(7);
            Record c_style = (Record)8; Record zero = Record();
            output[0] = direct; output[1] = partial; output[2] = functional;
            output[3] = named; output[4] = c_style; output[5] = zero;
        }",
        Capabilities::SHADER_INT16,
    );
}

#[test]
fn cuda_parenthesized_aggregates_use_ordinary_conversions_and_preserve_brace_diagnostics() {
    roundtrip(
        "struct Small { short first; unsigned short second; };
        __global__ void kernel(short4 *signed_output, ushort4 *unsigned_output, int2 *integers, Small *records, int value) {
            short4 signed_value(value); ushort4 unsigned_value(-1);
            int2 truncated(1.75f, 2.75f); Small record(65535, -1);
            signed_output[0] = signed_value; unsigned_output[0] = unsigned_value;
            integers[0] = truncated; records[0] = record;
        }",
        Capabilities::SHADER_INT16,
    );
    for declaration in [
        "short1 value{65535};",
        "short2 value{input};",
        "int2 value{1.75f, 2.75f};",
    ] {
        let error = rejected(&format!(
            "__global__ void kernel(int input) {{ {declaration} }}"
        ));
        assert!(error.message.contains("narrow"), "{error}");
    }
    for operation in [
        "int1 value = 3;",
        "Record value = 3;",
        "int1 wrapped = int1(3); int value = wrapped;",
    ] {
        rejected(&format!(
            "struct Record {{ int value; }}; __global__ void kernel() {{ {operation} }}"
        ));
    }
}

#[test]
fn cuda_parenthesized_aggregate_members_are_initialized_before_later_self_accesses() {
    for (prefix, scalar) in SCALARS {
        for width in 2..=4 {
            let arguments = ["3", "value.x + 1", "value.y + 1", "value.z + 1"]
                .into_iter()
                .take(width)
                .collect::<Vec<_>>()
                .join(", ");
            roundtrip(
                &format!(
                    "__global__ void kernel({prefix}{width} *output) {{
                    {prefix}{width} value({arguments}); output[0] = value;
                }}"
                ),
                capabilities(scalar),
            );
        }
    }
    let (module, _) = roundtrip(
        "struct Pair { int first; int second; };
        __global__ void kernel(int *output) {
            Pair value(3, value.first + 1); Pair modified(4, ++modified.first);
            output[0] = value.second; output[1] = modified.first; output[2] = modified.second;
        }",
        Capabilities::empty(),
    );
    assert_first_member_stored_before_load(&module, "value");
}

#[test]
fn cuda_parenthesized_aggregates_copy_class_arguments_before_later_alias_mutations() {
    roundtrip(
        "struct Pair { int first; int second; }; struct Snapshot { Pair pair; int marker; };
        __device__ int mutate(Pair &value) { value.first += 100; return value.first; }
        __global__ void kernel(int *output) {
            Pair source(3, 4); Snapshot direct(source, mutate(source));
            Pair another(5, 6); Snapshot functional = Snapshot(another, mutate(another));
            Snapshot named = static_cast<Snapshot>(source); Snapshot c_style = (Snapshot)another;
            output[0] = direct.pair.first; output[1] = direct.marker;
            output[2] = functional.pair.first; output[3] = functional.marker;
            output[4] = named.pair.second; output[5] = c_style.marker;
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregates_initialize_nested_records_and_array_members() {
    roundtrip(
        "struct Pair { int first; int second; };
        struct Packet { int head; int values[2]; Pair pair; };
        __global__ void kernel(Packet *output, int *scalars) {
            Packet omitted(3); Packet members(5, {7, 11}, {13, 17});
            Packet functional = Packet(19, {23, 29}, Pair(31, 37));
            Packet whole({41, {43, 47}, {53, 59}});
            Packet whole_functional = Packet({61, {67, 71}, {73, 79}});
            output[0] = omitted; output[1] = members; output[2] = functional;
            output[3] = whole; output[4] = whole_functional;
            scalars[0] = omitted.values[1] + omitted.pair.second;
        }",
        Capabilities::empty(),
    );
    roundtrip(
        "struct Pair { int first; int second; };
        __global__ void kernel(int2 *vectors, Pair *records) {
            int2 direct({1, 2}); int2 functional = int2({3, 4});
            Pair record({5, 6}); Pair copied = Pair({7, 8});
            vectors[0] = direct; vectors[1] = functional;
            records[0] = record; records[1] = copied;
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregates_keep_dim3_defaults_and_vector_cache_identity() {
    roundtrip(
        "__global__ void kernel(uint3 *output, unsigned *scalars) {
            uint1 single(7u); uint3 empty = uint3(); uint3 partial(3u);
            dim3 shape = dim3(2u); dim3 zero_arguments = dim3();
            uint3 packed(shape); dim3 restored = dim3(packed);
            output[0] = empty; output[1] = partial; output[2] = packed;
            scalars[0] = single.x; scalars[1] = shape.y; scalars[2] = shape.z;
            scalars[3] = zero_arguments.x + zero_arguments.y + zero_arguments.z;
            scalars[4] = restored.z + threadIdx.y + blockDim.z;
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregates_preserve_function_declaration_lookahead_and_limits() {
    for declaration in [
        "int2 copied();",
        "int2 copied(int2(source));",
        "Record copied(Record(source));",
        "Record copied(Record());",
        "uint3 copied(dim3(shape));",
    ] {
        let error = rejected(&format!(
            "struct Record {{ int value; }}; __global__ void kernel() {{ {declaration} }}"
        ));
        assert!(error.message.contains("function declaration"), "{error}");
    }
    for expression in ["int1(1, 2)", "int2(1, 2, 3)", "Record(1, 2, 3)"] {
        rejected(&format!("struct Record {{ int first; int second; }}; __global__ void kernel() {{ auto value = {expression}; }}"));
    }
    for depth in [8, 512] {
        let source = format!(
            "struct Record {{ int value; }}; __global__ void kernel(Record *output) {{ output[0] = {}Record(3){}; }}",
            "Record(".repeat(depth), ")".repeat(depth)
        );
        if depth == 8 {
            roundtrip(&source, Capabilities::empty());
        } else {
            let error = rejected(&source);
            assert!(
                error.message.contains("limit") || error.message.contains("nesting"),
                "{error}"
            );
        }
    }
    rejected("struct Pair { int first; int second; }; __global__ void kernel() { return; Pair value(1, missing); }");
}

#[test]
fn cuda_parenthesized_aggregates_sequence_effects_and_reinitialize_omitted_members() {
    roundtrip(
        "struct Pair { int first; int second; };
        __device__ int next(int &counter) { return counter++; }
        __device__ int read(const Pair &value) { return value.second; }
        __global__ void kernel(int *output) {
            int counter = 0; Pair direct(next(counter), next(counter));
            Pair functional = Pair(next(counter), next(counter));
            const Pair frozen(5, 6); const int &observed = frozen.first;
            output[0] = direct.first; output[1] = functional.second;
            output[2] = read(Pair(7, 8)); output[3] = observed;
            for (int index = 0; index < 3; ++index) {
                Pair reset(index); output[4 + index] = reset.second; reset.second = 9;
            }
        }",
        Capabilities::empty(),
    );
    rejected("struct Pair { int first; int second; }; __global__ void kernel() { const Pair value(3, ++value.first); }");
    rejected("struct Pair { int first; int second; }; __global__ void kernel() { Pair value = Pair(1, 2); int &member = Pair(3, 4).first; }");
}

#[test]
fn cuda_parenthesized_aggregates_instantiate_dependent_vector_and_record_constructions() {
    for (prefix, scalar) in SCALARS {
        for width in 1..=4 {
            let name = format!("{prefix}{width}");
            roundtrip(&format!(
                "template<class Value> __device__ Value direct(int seed) {{ Value result(seed); return result; }}
                template<class Value> __device__ Value functional(int seed) {{ return Value(seed); }}
                template<class Value> __device__ Value named(int seed) {{ return static_cast<Value>(seed); }}
                __global__ void kernel({name} *output) {{
                    output[0] = direct<{name}>(3); output[1] = functional<{name}>(4);
                    output[2] = named<{name}>(5);
                }}"
            ), capabilities(scalar));
        }
    }
    roundtrip(
        "struct Pair { int first; int second; }; using Alias = Pair;
        template<class Value> __device__ Value made(int seed) { return Value(seed); }
        __global__ void kernel(Pair *output) { output[0] = made<Alias>(3); output[1] = made<Pair>(4); }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregate_canonical_fixture_uses_the_three_binding_interface() {
    let source = include_str!("../../in/cuda/parenthesized-aggregates.cu");
    let options = Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    };
    let (module, info) =
        validate_with_options_and_capabilities(source, &options, Capabilities::SHADER_INT16);
    assert_eq!(module.entry_points[0].name, "parenthesized_aggregates");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
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
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    let _ = info;
}

#[test]
fn cuda_parenthesized_aggregates_match_cuda_nested_member_elision() {
    roundtrip(
        "struct Pair { int first; int second; };
        struct Nested { Pair pair; int tail; };
        struct Leaf { int first; };
        struct NestedLeaf { Leaf leaf; int tail; };
        struct VectorBox { int2 value; unsigned tail; };
        struct ArrayBox { int values[2]; int tail; };
        __global__ void kernel(int *output, int seed) {
            Nested nested(seed, seed + 1, seed + 2);
            NestedLeaf leaf(seed, seed + 1);
            VectorBox vector(seed);
            ArrayBox array(seed, seed + 1);
            ArrayBox comma((seed, seed + 1), seed + 2);
            Nested functional = Nested(seed, seed + 1, seed + 2);
            Nested named = static_cast<Nested>(seed);
            Nested c_style = (Nested)seed;
            ArrayBox named_array = static_cast<ArrayBox>(seed);
            VectorBox c_style_vector = (VectorBox)seed;
            output[0] = nested.pair.first; output[1] = nested.pair.second; output[2] = nested.tail;
            output[3] = leaf.leaf.first; output[4] = leaf.tail;
            output[5] = vector.value.x; output[6] = vector.value.y; output[7] = int(vector.tail);
            output[8] = array.values[0]; output[9] = array.values[1]; output[10] = array.tail;
            output[11] = comma.values[0]; output[12] = comma.values[1]; output[13] = comma.tail;
            output[14] = functional.tail; output[15] = named.pair.first;
            output[16] = named.pair.second + named.tail;
            output[17] = c_style.pair.first; output[18] = c_style.pair.second + c_style.tail;
            output[19] = named_array.values[0]; output[20] = named_array.values[1] + named_array.tail;
            output[21] = c_style_vector.value.x; output[22] = c_style_vector.value.y + int(c_style_vector.tail);
        }",
        Capabilities::empty(),
    );
}

#[test]
fn cuda_parenthesized_aggregates_keep_copy_and_empty_constructions_free_of_anonymous_locals() {
    for (prefix, scalar) in SCALARS {
        for width in 1..=4 {
            let (module, _) = roundtrip(
                &format!(
                    "using Value = {prefix}{width}; __global__ void kernel(Value *output) {{
                    Value source{{1}};
                    output[0] = Value(source);
                    output[1] = Value();
                }}"
                ),
                capabilities(scalar),
            );
            for (_, local) in module.entry_points[0].function.local_variables.iter() {
                if local.name.is_none() {
                    assert!(
                        !matches!(module.types[local.ty].inner,
                            naga::TypeInner::Vector { .. } | naga::TypeInner::Struct { .. }),
                        "{prefix}{width} copy or empty construction introduced an anonymous aggregate local"
                    );
                }
            }
        }
    }
}

#[test]
fn cuda_parenthesized_aggregate_prvalues_initialize_the_named_result_before_self_accesses() {
    for (ty, declaration) in [
        ("Pair", "Pair value = Pair(3, value.first + 1);"),
        ("Pair", "Pair value = (Pair(3, value.first + 1));"),
        ("Pair", "Pair value = Pair(Pair(3, value.first + 1));"),
        ("Pair", "Pair value(Pair(3, value.first + 1));"),
        (
            "Pair",
            "Pair value = static_cast<Pair>(Pair(3, value.first + 1));",
        ),
        ("Pair", "Pair value = (Pair)Pair(3, value.first + 1);"),
        (
            "Pair",
            "int counter = 0; Pair value = (++counter, Pair(3, value.first + 1));",
        ),
        ("Pair", "Pair value = Pair(3, ++value.first);"),
        ("int2", "int2 value = int2(3, value.x + 1);"),
        ("int2", "int2 value(int2(3, ++value.x));"),
    ] {
        let (module, _) = roundtrip(
            &format!(
                "struct Pair {{ int first; int second; }};
            __global__ void kernel({ty} *output) {{
                {declaration} output[0] = value;
            }}"
            ),
            Capabilities::empty(),
        );
        assert_first_member_stored_before_load(&module, "value");
    }
    for initializer in [
        "condition ? Pair(3, value.first + 1) : Pair(5, value.first + 2)",
        "static_cast<Pair>(condition ? Pair(3, value.first + 1) : Pair(5, ++value.first))",
    ] {
        let (module, _) = roundtrip(
            &format!(
                "struct Pair {{ int first; int second; }};
            __global__ void kernel(Pair *output, unsigned condition) {{
                Pair value = {initializer}; output[0] = value;
            }}"
            ),
            Capabilities::empty(),
        );
        let branches = module.entry_points[0]
            .function
            .body
            .iter()
            .find_map(|statement| {
                if let naga::Statement::If { accept, reject, .. } = statement {
                    Some([accept.clone(), reject.clone()])
                } else {
                    None
                }
            })
            .expect("expected the runtime conditional initializer");
        for branch in branches {
            let mut branch_module = module.clone();
            branch_module.entry_points[0].function.body = branch;
            assert_first_member_stored_before_load(&branch_module, "value");
        }
    }
}
