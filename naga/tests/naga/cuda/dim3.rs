use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/dim3.cu");

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    error
}

fn storage_element(module: &naga::Module, binding: u32) -> (naga::Handle<naga::Type>, u32) {
    let global = module
        .global_variables
        .iter()
        .find_map(|(_, global)| {
            (global.binding == Some(naga::ResourceBinding { group: 0, binding })).then_some(global)
        })
        .unwrap();
    let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
        panic!("expected a storage array");
    };
    (base, stride)
}

#[test]
fn cuda_dim3_is_nominal_with_twelve_byte_layout_and_canonical_aliases() {
    let source = "using Shape = dim3; typedef Shape Extent;
        __device__ unsigned kind(dim3 value) { return 11u; }
        __device__ unsigned kind(uint3 value) { return 22u; }
        __global__ void kernel(Shape *output, const Extent *input, uint3 *packed) {
            output[0] = input[0]; packed[0] = output[0];
            packed[1].x = kind(output[0]) + kind(packed[0]);
        }";
    let (module, _) = validate(source);
    let (shape, stride) = storage_element(&module, 0);
    let (readonly, readonly_stride) = storage_element(&module, 1);
    let (packed, packed_stride) = storage_element(&module, 2);
    assert_eq!(shape, readonly);
    assert_ne!(shape, packed);
    assert_eq!((stride, readonly_stride, packed_stride), (12, 12, 12));
    let naga::TypeInner::Struct { ref members, span } = module.types[shape].inner else {
        panic!("expected the nominal dim3 record");
    };
    assert_eq!(span, 12);
    assert_eq!(
        members
            .iter()
            .map(|member| member.name.as_deref())
            .collect::<Vec<_>>(),
        [Some("x"), Some("y"), Some("z")]
    );
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 4, 8]
    );
    assert!(members
        .iter()
        .all(|member| module.types[member.ty].inner == naga::TypeInner::Scalar(naga::Scalar::U32)));
    let mut layouter = naga::proc::Layouter::default();
    layouter.update(module.to_ctx()).unwrap();
    assert_eq!(
        layouter[shape].alignment,
        naga::proc::Alignment::new(4).unwrap()
    );
    let overloads: Vec<_> = module
        .functions
        .iter()
        .filter(|&(_, function)| function.name.as_deref() == Some("kind"))
        .map(|(_, function)| function.arguments[0].ty)
        .collect();
    assert_eq!(overloads.len(), 2);
    assert_ne!(overloads[0], overloads[1]);
    roundtrip(source);
}

#[test]
fn cuda_dim3_constructors_preserve_defaults_copy_conversion_and_scalar_rules() {
    roundtrip(FIXTURE);
    for declaration in [
        "dim3 value;",
        "const dim3 value;",
        "dim3 value{};",
        "dim3 value = dim3();",
        "dim3 value(2u);",
        "dim3 value(2u, 3u);",
        "dim3 value(2u, 3u, 4u);",
        "dim3 value{2u, 3u};",
        "dim3 value = 2u;",
        "dim3 value = 1.75f;",
        "dim3 value = make_uint3(2u, 3u, 4u);",
        "dim3 value(make_uint3(2u, 3u, 4u));",
        "dim3 value{make_uint3(2u, 3u, 4u)};",
        "dim3 original(2u, 3u); dim3 value(original);",
        "dim3 original(2u, 3u); dim3 value{original};",
        "dim3 value((dim3()));",
        "dim3 value(1.75f, true, -1);",
    ] {
        roundtrip(&format!("__global__ void kernel(unsigned *output) {{ {declaration} output[0] = value.x + value.y + value.z; }}"));
    }
    for declaration in [
        "dim3 value{1.0f};",
        "dim3 value{1.75f};",
        "int count = 2; dim3 value{count};",
        "dim3 value{-1};",
        "dim3 value(1u, 2u, 3u, 4u);",
        "dim3 value(make_int2(1, 2));",
        "dim3 value();",
        "dim3 value(dim3());",
        "dim3 shape; uint3 value{shape};",
        "dim3 shape; uint3 value = {shape};",
        "dim3 values[1]{{-1}};",
        "int runtime = 2; dim3 values[1]{{runtime}};",
        "struct Record { dim3 shape; unsigned tail; }; Record value{{-1}, 7u};",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_dim3_value_conversions_and_overloads_use_standard_before_user_conversion() {
    roundtrip("__device__ unsigned exact(dim3 value) { return 11u; }
        __device__ unsigned exact(uint3 value) { return 22u; }
        __device__ unsigned scalar(unsigned value) { return 33u; }
        __device__ unsigned scalar(dim3 value) { return 44u; }
        __device__ dim3 from_packed(uint3 value) { return value; }
        __device__ uint3 to_packed(dim3 value) { return value; }
        __device__ unsigned volume(dim3 value) { return value.x * value.y * value.z; }
        __device__ void bump(dim3 &value) { ++value.y; }
        __global__ void kernel(unsigned *output, int runtime) {
            dim3 shape(2u, 3u, 4u); uint3 packed = shape;
            uint3 direct(shape); uint3 expression = uint3(shape);
            shape = make_uint3(5u, 6u, 7u); packed = shape;
            const dim3 &view = packed; const uint3 &raw_view = shape; bump(shape);
            const dim3 &braced{packed}; const dim3 &live{shape}; dim3 &mutable_view{shape};
            const dim3 &scalar_copy = -1; const dim3 &runtime_copy = runtime;
            ++mutable_view.z;
            output[0] = exact(shape); output[1] = exact(packed); output[2] = scalar(3);
            output[3] = volume(2u); output[4] = from_packed(packed).z;
            output[5] = to_packed(shape).y; output[6] = view.x + raw_view.y + direct.z + expression.x;
            output[7] = braced.y + live.z + scalar_copy.y + runtime_copy.z;
        }");
    for body in [
        "uint3 packed{}; dim3 &reference = packed;",
        "dim3 shape; uint3 &reference = shape;",
        "uint3 packed{}; dim3 *pointer = &packed;",
        "dim3 shape; uint3 *pointer = &shape;",
        "const dim3 &reference{-1};",
        "int runtime = 2; const dim3 &reference{runtime};",
        "dim3 shape; const uint3 &reference{shape};",
        "dim3 &reference{make_uint3(1u, 2u, 3u)};",
    ] {
        rejected(&format!("__global__ void kernel() {{ {body} }}"));
    }
    let error = rejected(
        "__device__ unsigned crossed(dim3 first, uint3 second) { return 1u; }
        __device__ unsigned crossed(uint3 first, dim3 second) { return 2u; }
        __global__ void kernel() { crossed(dim3(), dim3()); }",
    );
    assert!(error.message.contains("ambiguous"));
    rejected("__global__ void kernel(unsigned choose) { dim3 shape; uint3 packed{}; auto selected = choose ? shape : packed; }");
    rejected("__global__ void kernel() { uint3 packed = 2u; }");
}

#[test]
fn cuda_dim3_mutation_constness_auto_and_scoped_type_lookup_keep_nominal_identity() {
    roundtrip(
        "using Shape = dim3; using Frozen = const Shape; using Pointer = Shape *;
        __device__ void edit(Pointer value) { ++value->x; }
        __global__ void kernel(unsigned *output) {
            Frozen fixed; auto copied = fixed; copied.x = 4u;
            Shape original = copied; Pointer pointer = &copied; edit(pointer);
            auto &live = copied; live.y += 2u; const auto &view = copied;
            { using dim3 = unsigned; dim3 scalar = 7u; output[0] = scalar; }
            { struct dim3 { unsigned x, y, z; }; dim3 local{}; output[1] = local.x; }
            dim3 restored; output[2] = restored.x + original.x + view.y;
        }",
    );
    for body in [
        "const dim3 value; value.x = 2u;",
        "const dim3 value; ++value.y;",
        "auto first = dim3(), second = make_uint3(1u, 1u, 1u);",
        "dim3 value; int dim3 = 1; dim3 other;",
    ] {
        rejected(&format!("__global__ void kernel() {{ {body} }}"));
    }
}

#[test]
fn cuda_dim3_default_initialization_reaches_array_tails_and_nested_record_members() {
    let source = "struct Leaf { dim3 shape; uint3 raw; };
        struct Packet { unsigned tag; Leaf leaves[2]; dim3 grid[2][2]; unsigned tail; };
        __global__ void kernel(Packet *output) {
            dim3 bare[2]; dim3 partial[3]{dim3(2u), dim3(3u, 4u)};
            Packet empty{}; Packet partial_record{7u}; Packet default_record;
            default_record.leaves[0].raw = make_uint3(2u, 3u, 4u);
            empty.grid[1][0] = bare[1]; partial_record.leaves[1].shape = partial[2];
            output[0] = empty; output[1] = partial_record;
            output[2].leaves[0].shape = default_record.leaves[0].shape;
        }";
    roundtrip(source);
    roundtrip("struct Only { dim3 shape; }; struct Nested { Only values[2]; };
        struct Mixed { unsigned tag; dim3 shape; };
        __global__ void kernel(unsigned *output, int runtime) {
            const Only only; const Nested nested; const Mixed initialized{};
            dim3 scalar_values[3]{-1, runtime, 2u}; dim3 listed[2]{{2u}, {3u, 4u}};
            Mixed negative_shape{7u, -1};
            struct Wrapper { dim3 shape; unsigned tail; };
            Wrapper first{-1, 7u}, second{runtime, 9u};
            output[0] = only.shape.x + nested.values[1].shape.z + initialized.shape.y;
            output[1] = scalar_values[1].x + listed[0].z + first.tail + second.tail + negative_shape.shape.z;
        }");
    for fields in ["unsigned tag; dim3 shape;", "dim3 shape; uint3 raw;"] {
        rejected(&format!(
            "struct Mixed {{ {fields} }}; __global__ void kernel() {{ const Mixed value; }}"
        ));
    }
    let (module, _) = validate(
        "struct Packet { unsigned tag; dim3 shape; uint3 raw; unsigned tail; };
        __global__ void kernel(Packet *output) { Packet value{}; output[0] = value; }",
    );
    let (packet, stride) = storage_element(&module, 0);
    let naga::TypeInner::Struct { ref members, span } = module.types[packet].inner else {
        panic!("expected Packet");
    };
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 4, 16, 28]
    );
    assert_eq!((span, stride), (32, 32));
    assert_ne!(members[1].ty, members[2].ty);
}

#[test]
fn cuda_dim3_default_construction_obeys_switch_initialization_and_preserves_pod_rules() {
    for declaration in ["dim3 shape;", "dim3 shapes[2];", "Record record;"] {
        rejected(&format!(
            "struct Record {{ dim3 shape; }}; __global__ void kernel(unsigned selector) {{
            switch (selector) {{ case 0u: {declaration} case 1u: break; default: break; }}
        }}"
        ));
    }
    roundtrip("struct Plain { unsigned value; };
        __global__ void kernel(unsigned *output) {
            switch (output[3]) { case 0u: Plain value; case 1u: value.value = 7u; output[0] = value.value; break; default: break; }
        }");
}

#[test]
fn cuda_dim3_rejects_malformed_values_and_keeps_existing_aggregate_boundaries() {
    for source in [
        "using dim3 = uint3; __global__ void kernel() {}",
        "__global__ void kernel(dim3 value) {}",
        "constexpr dim3 Shape(2u); __global__ void kernel() {}",
        "__global__ void kernel() { constexpr dim3 shape(2u); }",
        "__global__ void kernel() { constexpr unsigned Count = dim3(2u).x; unsigned values[Count]; }",
        "__global__ void kernel() { __shared__ dim3 shape; }",
        "__global__ void kernel() { __shared__ dim3 shapes[2]; }",
        "struct Leaf { dim3 shape; }; struct Record { Leaf values[2]; }; __global__ void kernel() { __shared__ Record value; }",
        "__global__ void kernel() { __shared__ dim3 *pointer; }",
        "__global__ void kernel() { extern __shared__ dim3 values[]; }",
    ] { rejected(source); }
    roundtrip(
        "__global__ void kernel(unsigned *output) {
        constexpr unsigned Count = (dim3(3), dim3(1.75f, 2u, true), 4u);
        unsigned values[Count]{}; output[0] = values[3];
    }",
    );
    for body in [
        "constexpr unsigned Count = (dim3(runtime), 4u);",
        "unsigned counter = 0u; constexpr unsigned Count = (dim3(++counter), 4u);",
    ] {
        rejected(&format!("__global__ void kernel(int runtime) {{ {body} }}"));
    }
    for body in [
        "dim3 shape; shape.w = 1u;",
        "dim3 shape; shape.xy;",
        "dim3 shape; shape[0];",
        "dim3 shape; shape + shape;",
        "dim3 shape; dim3 other = &shape;",
        "dim3 shape = blockDim;",
        "dim3 shape = gridDim;",
        "return; dim3 shape(missing);",
        "return; dim3 shape(1u, 2u, 3u, 4u);",
    ] {
        rejected(&format!("/* π */ __global__ void kernel() {{ {body} }}"));
    }
}

#[test]
fn cuda_dim3_bounds_constructor_nesting_and_array_size_without_unbounded_expansion() {
    let mut value = String::from("dim3(2u)");
    for _ in 0..8 {
        value = format!("dim3({value})");
    }
    roundtrip(&format!(
        "__global__ void kernel(unsigned *output) {{ dim3 shape = {value}; output[0] = shape.x; }}"
    ));
    for _ in 0..80 {
        value = format!("dim3({value})");
    }
    let error = rejected(&format!(
        "__global__ void kernel() {{ dim3 shape = {value}; }}"
    ));
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    rejected("__global__ void kernel() { dim3 shapes[2147483647u]; }");
}

#[test]
fn cuda_dim3_default_construction_scales_with_the_shared_record_type_graph() {
    for leaf_fields in ["dim3 shape;", "dim3 shapes[2];"] {
        let mut source = format!("struct Leaf {{ {leaf_fields} }};");
        let mut child = String::from("Leaf");
        for level in 0..14 {
            let name = format!("Layer{level}");
            source.push_str(&format!(
                "struct {name} {{ {child} first; {child} second; }};"
            ));
            child = name;
        }
        source.push_str(&format!("__global__ void kernel() {{ {child} value; }}"));
        let (module, _) = validate(&source);
        let expression_count = module.global_expressions.len()
            + module
                .functions
                .iter()
                .map(|(_, function)| function.expressions.len())
                .sum::<usize>()
            + module
                .entry_points
                .iter()
                .map(|entry| entry.function.expressions.len())
                .sum::<usize>();
        assert!(expression_count < 512,
            "default construction expanded the repeated record tree into {expression_count} expressions for {leaf_fields}");
    }
}

#[test]
fn cuda_dim3_initializers_reject_named_parameter_declarations() {
    for declaration in [
        "dim3 value();",
        "dim3 value(dim3());",
        "dim3 value(dim3(shape));",
        "dim3 value(dim3((shape)));",
        "Shape value(Shape(shape));",
        "dim3 value(const Shape(shape));",
        "dim3 value(unsigned(seed));",
        "dim3 value(Count(seed));",
        "dim3 value(dim3(produce()));",
        "dim3 value(unsigned(observe()));",
        "dim3 value(dim3(shape), unsigned(seed));",
    ] {
        let source = format!(
            "using Shape = dim3; using Count = unsigned;
            __global__ void kernel() {{ dim3 shape(2u); unsigned seed = 3u; {declaration} }}"
        );
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
    }
}

#[test]
fn cuda_dim3_initializers_preserve_genuine_constructor_expressions() {
    roundtrip(
        "using Shape = dim3; using Count = unsigned;
        __device__ unsigned observe(unsigned &counter) { ++counter; return counter + 2u; }
        __device__ dim3 produce(unsigned &counter) { ++counter; return dim3(counter, 5u, 7u); }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            dim3 defaulted;
            dim3 one(2u), two(3u, 4u), three(5u, 6u, 7u);
            dim3 source(11u, 13u, 17u);
            Shape copied((source));
            Shape forced((Shape(source)));
            Shape scalar(Count(observe(counter)));
            Shape returned(produce(counter));
            Shape typed(Shape(produce(counter)));
            Shape comma((++counter, source));
            uint3 packed{19u, 23u, 29u};
            Shape converted(packed);
            dim3 forced_empty((dim3()));
            output[0] = counter;
            output[1] = defaulted.x + defaulted.y + defaulted.z;
            output[2] = one.x + one.y + one.z + two.x + two.y + two.z + three.x + three.y + three.z;
            output[3] = copied.x + forced.y + comma.z;
            output[4] = scalar.x + returned.x + typed.x;
            output[5] = converted.x + converted.y + converted.z;
            output[6] = forced_empty.x + forced_empty.y + forced_empty.z;
        }",
    );
}

#[test]
fn cuda_dim3_declaration_guards_keep_alias_cv_spans_and_mixed_arguments() {
    for declaration in [
        "dim3 value(unsigned(seed), unsigned(other));",
        "Shape value(Count(seed), Count(other), Count(third));",
        "const Shape value(Shape(shape));",
        "Frozen value(Shape(shape));",
    ] {
        let source = format!(
            "/* café 漢 */ using Shape = dim3; using Frozen = const Shape;
            using Count = unsigned;
            __global__ void kernel() {{
                dim3 shape(2u); unsigned seed = 3u, other = 5u, third = 7u;
                {declaration}
            }}"
        );
        let opening = source.find("value(").unwrap() + "value".len();
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
        assert_eq!(
            error.span.to_range(),
            Some(opening..opening + 1),
            "{source}: {error}"
        );
    }
    roundtrip(
        "using Shape = dim3; using Frozen = const Shape; using Count = unsigned;
        __global__ void kernel(unsigned *output) {
            unsigned seed = 3u;
            Shape mixed(Count(seed), 5u, 7u);
            Frozen fixed(Count(seed), 11u);
            const Shape forced((Shape(seed)));
            output[0] = mixed.x + mixed.y + mixed.z;
            output[1] = fixed.x + fixed.y + fixed.z;
            output[2] = forced.x + forced.y + forced.z;
        }",
    );
}

#[test]
fn cuda_dim3_declaration_guards_bound_lookahead_and_genuine_constructors() {
    for depth in [8, 512] {
        let mut parameter = String::from("Shape()");
        for _ in 0..depth {
            parameter = format!("Shape({parameter})");
        }
        let source =
            format!("using Shape = dim3; __global__ void kernel() {{ Shape value({parameter}); }}");
        let error = rejected(&source);
        if depth == 8 {
            assert!(error.message.contains("function declaration"), "{error}");
        } else {
            assert!(
                error.message.contains("nesting") && error.message.contains("limit"),
                "{error}"
            );
        }
    }
    let source = |depth: usize| {
        format!(
            "using Shape = dim3; __global__ void kernel(unsigned *output) {{
                Shape value({}2u{});
                output[0] = value.x + value.y + value.z;
            }}",
            "Shape(".repeat(depth),
            ")".repeat(depth),
        )
    };
    roundtrip(&source(8));
    let error = rejected(&source(512));
    assert!(
        error.message.contains("nesting") && error.message.contains("limit"),
        "{error}"
    );
}
