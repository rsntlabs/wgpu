use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate};

const FIXTURE: &str = include_str!("../../in/cuda/auto-declarations.cu");

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

fn rejected(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
}

#[test]
fn cuda_auto_values_preserve_scalar_vector_and_nominal_record_types() {
    for (initializer, scalar) in [
        ("= true", naga::Scalar::BOOL),
        ("(-2)", naga::Scalar::I32),
        ("{3u,}", naga::Scalar::U32),
        ("= 1.25f", naga::Scalar::F32),
    ] {
        let (module, info) = validate(&format!(
            "__global__ void kernel() {{ auto value {initializer}; }}"
        ));
        let function = &module.entry_points[0].function;
        let value = source_binding_initializer(function, "value");
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(scalar)
        );
    }
    let (module, info) = validate(
        "struct Record { int value; float2 pair; };
        __global__ void kernel() { auto point = make_float2(1.0f, 2.0f); auto record{Record{3, point}}; }",
    );
    let function = &module.entry_points[0].function;
    let point = source_binding_initializer(function, "point");
    assert_eq!(
        info.get_entry_point(0)[point].ty.inner_with(&module.types),
        &naga::TypeInner::Vector {
            size: naga::VectorSize::Bi,
            scalar: naga::Scalar::F32
        }
    );
    let record = source_binding_initializer(function, "record");
    assert!(matches!(
        info.get_entry_point(0)[record].ty.inner_with(&module.types),
        naga::TypeInner::Struct { .. }
    ));
    roundtrip(FIXTURE);
}

#[test]
fn cuda_auto_pointers_preserve_decay_constness_and_row_extents() {
    roundtrip(
        "__global__ void kernel(int *output, const int *input) {
            auto readable = input; auto *also_readable{input}; readable = output;
            const auto fixed = output; *fixed = 7;
            const auto *view = output; ++view;
            auto *const other = output; *other = 9;
            auto *__restrict__ hinted = input;
            output[0] = readable[0] + also_readable[0] + view[0];
        }",
    );
    roundtrip(
        "__global__ void kernel(int *output) {
            int matrix[3][2]{{2, 3}, {5, 7}, {11, 13}};
            int other[2][2]{{17, 19}, {23, 29}};
            const int frozen[2][2]{{31, 37}, {41, 43}};
            auto rows = matrix; ++rows;
            auto *selected = output[15] ? rows : other;
            ++selected; selected[0][0] += 1;
            int index = 0; auto saved = &matrix[index++]; index = 2;
            saved[0][1] += 2; selected = matrix;
            auto readonly_rows = frozen; ++readonly_rows;
            output[0] = rows[0][1] + selected[0][1] + saved[0][0] + readonly_rows[0][1];
        }",
    );
    for body in [
        "const auto fixed = output; ++fixed;",
        "const auto *view = output; *view = 1;",
        "auto readable = input; *readable = 1;",
        "auto writable = output; writable = input;",
        "const int values[2][2]{}; auto rows = values; rows[0][0] = 1;",
        "int first[2][2]{}, second[2][3]{}; auto rows = first; rows = second;",
        "int first[2][2]{}, second[2][3]{}; auto *rows = first, *other = second;",
    ] {
        rejected(&format!(
            "__global__ void kernel(int *output, const int *input) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_auto_references_preserve_live_aliases_cv_and_const_temporaries() {
    roundtrip(
        "struct Record { int value; int2 pair; };
        __global__ void kernel(int *output) {
            const int frozen = 3; auto copied = frozen; copied += 1;
            auto &alias(copied); alias += 2;
            const auto &view{copied};
            const auto &temporary = copied + 1;
            auto point = make_int2(2, 3); auto &point_alias = point; point_alias.x += 4;
            const auto &point_temporary(make_int2(5, 7));
            const auto &record_temporary = Record{11, make_int2(13, 17)};
            output[0] = view + temporary + point.x + point_temporary.y + record_temporary.value;
        }",
    );
    for body in [
        "const int frozen = 3; auto &view = frozen; view = 1;",
        "int value = 3; const auto &view = value; ++view;",
        "auto &view = 3;",
        "auto &pointer = output;",
        "const auto &pointer = output;",
        "int values[2]{}; auto &whole = values;",
        "int values[2][2]{}; const auto &whole = values;",
    ] {
        rejected(&format!("__global__ void kernel(int *output) {{ {body} }}"));
    }
}

#[test]
fn cuda_auto_constexpr_lists_and_comma_declarators_keep_the_same_deduced_placeholder() {
    roundtrip(
        "auto constexpr First = 1;
        const auto constexpr Global = 3u;
        constexpr auto Count{Global}, Last(Count - 1u);
        __global__ void kernel(int *output) {
            const int seed = 3;
            const auto frozen = 1, &view = seed, *pointer = &seed;
            auto &inferred_view = seed, *inferred_pointer = &seed;
            auto value = 1, *const alias = &value, &reference = value;
            reference += 2;
            auto comma((1, 2));
            const auto LocalCount{Count}; int values[LocalCount]{2, 3, 5};
            output[0] = values[Last] + frozen + view + *pointer + *alias + comma + First + inferred_view + *inferred_pointer;
        }",
    );
    for source in [
        "__global__ void kernel() { auto first = 1, second = 2u; }",
        "__global__ void kernel(int *output) { auto pointer = output, *other = output; }",
        "__global__ void kernel() { const int seed = 3; auto value = seed, &view = seed; }",
        "__global__ void kernel() { const int seed = 3; auto *pointer = &seed, value = 1; }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel() { auto first = First{1}, second = Second{2}; }",
        "constexpr auto First = 1, Second = 2u; __global__ void kernel() {}",
        "__global__ void kernel() { auto Count = 3; int values[Count]; }",
        "__global__ void kernel(int runtime) { const auto Count = runtime; int values[Count]; }",
        "constexpr auto Count = threadIdx.x; __global__ void kernel() {}",
        "__global__ void kernel(int *output) { constexpr auto pointer = output; }",
        "__global__ void kernel() { int value = 3; constexpr auto &view = value; }",
        "__global__ void kernel() { constexpr auto point = make_int2(1, 2); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_auto_initializers_run_once_in_declaration_order_and_existing_loop_scopes() {
    roundtrip(
        "using Number = int;
        __device__ int next(int &value) { return value++; }
        __global__ void kernel(int *output) {
            int counter = 2;
            auto first(next(counter)), second{next(counter)}, &reference(counter);
            { auto counter = first + 10; ++counter; output[0] = counter; }
            auto Number = first;
            for (auto index = 0; index < 3; ++index) { auto value = next(counter); output[index + 1] = value; }
            while (counter < 9) { auto value = counter++; output[value] = value; }
            output[4] = first + second + reference + Number;
        }",
    );
    for source in [
        "__global__ void kernel() { auto value = value; }",
        "__global__ void kernel() { int value = 3; { auto value = value; } }",
        "__global__ void kernel() { auto value = true ? 3 : value; }",
        "constexpr auto Value = true ? 3 : Value; __global__ void kernel() {}",
        "__global__ void kernel() { for (auto index = 0; index < 1; ++index) {} index = 3; }",
        "__global__ void kernel(int *output) { switch (output[0]) { case 0: auto value = 3; case 1: output[1] = 7; break; } }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_auto_rejects_missing_initializers_lists_and_unsupported_placeholder_contexts() {
    roundtrip("__global__ void kernel() { return; auto value = 3; }");
    for body in [
        "auto value;",
        "auto *pointer;",
        "auto &reference;",
        "auto value{};",
        "auto value{1, 2};",
        "auto value{{1}};",
        "auto value = {1};",
        "auto value(1, 2);",
        "auto (value) = 3;",
        "auto values[2]{1, 2};",
        "int value = 3; auto &&reference = value;",
        "auto **pointer = output;",
        "int *unset; auto copied = unset;",
        "int *unset; auto *copied = unset;",
        "decltype(auto) value = 3;",
        "return; auto value = missing;",
        "return; auto value = value;",
    ] {
        rejected(&format!(
            "/* 漢 */ __global__ void kernel(int *output) {{ {body} }}"
        ));
    }
    for source in [
        "auto Value = 3; __global__ void kernel() {}",
        "__device__ auto helper() { return 3; } __global__ void kernel() {}",
        "__global__ void kernel(auto value) {}",
        "__device__ void empty() {} __global__ void kernel() { auto value = empty(); }",
        "__global__ void kernel() { while (auto value = 3) {} }",
        "using Deduced = auto; __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    let nested = format!(
        "__global__ void kernel() {{ auto value{}1{}; }}",
        "(".repeat(512),
        ")".repeat(512)
    );
    let error = parse_str(&nested, &Options::default()).unwrap_err();
    assert!(error.message.contains("depth") || error.message.contains("nesting"));
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(nested.get(range).is_some());

    let declarations = |count: usize| {
        let mut source = String::from("__global__ void kernel(int *output) {");
        for index in 0..count {
            source.push_str(&format!(
                "auto value{index} = output[0]; output[1] = value{index};"
            ));
        }
        source.push('}');
        source
    };
    let (single, _) = validate(&declarations(1));
    let (many, info) = validate(&declarations(128));
    assert!(
        many.entry_points[0].function.expressions.len()
            <= single.entry_points[0].function.expressions.len() * 128 + 256
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(&many, &info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES);
    let _ = info;
}
