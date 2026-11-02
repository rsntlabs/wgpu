use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

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
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_direct_borrowed_initializers_support_pointer_aliases_views_and_null_values() {
    roundtrip(
        "using Pointer = int *;
        __global__ void kernel(int *output) {
            int values[3]{3, 7, 11};
            int *pointer(values + 1);
            Pointer copied(pointer);
            const int *view(copied);
            int *const fixed(copied);
            int *empty(0);
            int *missing(nullptr);
            output[0] = *fixed + view[1];
            output[1] = int(empty == 0 && missing == nullptr);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_preserve_reference_aliases_indices_and_temporaries() {
    roundtrip(
        "__global__ void kernel(int *output) {
            int value = 3;
            int &alias(value);
            const int &view(alias);
            alias += 4;
            const int &temporary(3.75f);
            int values[2]{5, 7};
            int index = 0;
            int &captured(values[index++]);
            index = 1;
            captured += view;
            output[0] = view + temporary;
            output[1] = values[0];
            output[2] = index;
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_preserve_source_null_reference_call_effects() {
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ Null observe(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            Null value;
            Null &alias(value);
            const Null &literal(nullptr);
            const Null &zero(0);
            const Null &returned(Null(observe(counter)));
            alias = 0;
            output[0] = counter;
            output[1] = unsigned(value == literal && literal == zero && zero == returned);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_reject_invalid_pointer_conversions() {
    for operand in [
        "zero",
        "named_zero",
        "int(0)",
        "static_cast<int>(0)",
        "(int)0",
        "+0",
        "1 - 1",
        "false",
        "(0, 0)",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{
                int zero = 0; constexpr int named_zero = 0;
                int *selected({operand});
            }}"
        ));
    }
    for source in [
        "__global__ void kernel(const int *input) { int *selected(input); }",
        "__global__ void kernel() { const int value = 3; int *selected(&value); }",
        "__global__ void kernel() { float value = 3.0f; int *selected(&value); }",
        "__global__ void kernel() { int value = 3; int *const selected(&value); selected = nullptr; }",
        "__global__ void kernel() { int value = 3; const int *selected(&value); *selected = 7; }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel() { First value{}; Second *selected(&value); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "#define ZERO 0
        __global__ void kernel(unsigned *output) {
            auto source = nullptr;
            int *first(((0u))), *second(ZERO), *third(source);
            output[0] = unsigned(first == 0 && second == nullptr && third == 0);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_bind_supported_scalar_vector_and_record_references() {
    for (scalar, initial, update) in [
        ("bool", "false", "true"),
        ("int", "-3", "7"),
        ("unsigned", "5u", "11u"),
        ("float", "1.5f", "2.0f"),
    ] {
        roundtrip(&format!(
            "using Element = {scalar}; using Frozen = const Element;
            __global__ void kernel(unsigned *output) {{
                Element value = {initial};
                Element &alias(value); Frozen &view(alias);
                alias = {update}; output[0] = unsigned(view);
            }}"
        ));
    }
    for scalar in ["int", "uint", "float"] {
        for width in 2..=4 {
            let vector = format!("{scalar}{width}");
            let initial = core::iter::repeat_n("1", width)
                .collect::<Vec<_>>()
                .join(", ");
            roundtrip(&format!(
                "__global__ void kernel(unsigned *output) {{
                    {vector} value{{{initial}}};
                    {vector} &alias(value);
                    const {vector} &view(alias);
                    alias.x = 3; output[0] = unsigned(view.x);
                }}"
            ));
        }
    }
    roundtrip(
        "struct Leaf { int value; };
        struct Record { Leaf leaves[2]; float2 point; };
        using Alias = Record;
        __device__ Record make_record(int value) {
            return Record{{{value}, {}}, {1.0f, 2.0f}};
        }
        __global__ void kernel(unsigned *output) {
            Record value{{{3}, {5}}, {7.0f, 11.0f}};
            Alias &alias(value);
            Leaf &leaf(alias.leaves[1]);
            int &field(leaf.value);
            float2 &point(alias.point);
            float &component(point.y);
            field += 2; component += 3.0f;
            const Alias &view(alias);
            const Record &temporary(make_record(13));
            const float2 &vector(make_float2(17.0f, 19.0f));
            output[0] = unsigned(view.leaves[1].value);
            output[1] = unsigned(component + vector.y);
            output[2] = unsigned(temporary.leaves[0].value);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_preserve_reference_type_category_and_const_checks() {
    for source in [
        "__global__ void kernel() { int &alias(3); }",
        "__global__ void kernel() { const int value = 3; int &alias(value); }",
        "__global__ void kernel() { float value = 3.0f; int &alias(value); }",
        "__global__ void kernel() { unsigned value = 3u; int &alias(value); }",
        "__global__ void kernel() { int value = 3; const int &view(value); int &alias(view); }",
        "__global__ void kernel() { float2 value{}; int2 &alias(value); }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel() { First value{}; const Second &alias(value); }",
        "using Null = decltype(nullptr); __global__ void kernel() { Null &alias(nullptr); }",
        "using Null = decltype(nullptr); __global__ void kernel() { const Null value = nullptr; Null &alias(value); }",
        "using Null = decltype(nullptr); __global__ void kernel() { const Null &alias(nullptr); alias = 0; }",
        "using Null = decltype(nullptr); __global__ void kernel() { int zero = 0; const Null &alias(zero); }",
        "using Null = decltype(nullptr); __global__ void kernel() { const Null &alias(1 - 1); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_direct_borrowed_initializers_keep_reference_boolean_conversion_implicit() {
    roundtrip(
        "__global__ void kernel(unsigned *output) {
            int storage = 7;
            int *pointer(&storage), *missing(nullptr);
            const bool &present(pointer), &absent(missing);
            const bool &explicit_null(bool(nullptr));
            const int &truncated(3.75f);
            const unsigned &wrapped(-1);
            const bool &numeric(2);
            bool direct(nullptr);
            output[0] = unsigned(present && !absent && !explicit_null && !direct);
            output[1] = unsigned(truncated) + unsigned(numeric);
            output[2] = wrapped;
        }",
    );
    for declaration in [
        "const bool &value(nullptr);",
        "const bool &value = nullptr;",
        "const bool &value{2};",
        "const int &value{3.75f};",
        "const unsigned &value{-1};",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
}

#[test]
fn cuda_direct_borrowed_initializers_keep_mixed_loops_lists_and_auto_grammars() {
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            int values[3]{3, 7, 11};
            int first(2), *pointer(values), &alias(*pointer), second{5};
            int *copied = pointer, *listed{copied};
            int &assigned = alias, &braced{assigned};
            auto *inferred(values);
            auto &inferred_alias(values[1]);
            Null source(nullptr), &null_alias(source), copied_null = nullptr;
            const Null &zero(0), &literal(nullptr);
            braced += second; inferred_alias += first; null_alias = copied_null;
            int iteration = 0, total = 0;
            for (int *cursor(values), limit(2); iteration < limit; ++iteration) {
                int &entry(cursor[iteration]);
                total += entry;
            }
            int count = 0;
            for (int &entry(values[2]), limit(2); count < limit; ++count) ++entry;
            output[0] = unsigned(total + *listed + *inferred);
            output[1] = unsigned(values[1] + values[2]);
            output[2] = unsigned(source == zero && zero == literal);
        }",
    );
    for source in [
        "__global__ void kernel() { int values[2]{}; for (int *cursor(values); false;) {} int *outside(cursor); }",
        "__global__ void kernel() { int value = 3; for (int &alias(value); false;) {} int &outside(alias); }",
        "__global__ void kernel(unsigned choice, int *output) { switch (choice) { case 0: int *pointer(output); case 1: break; default: break; } }",
        "__global__ void kernel(unsigned choice, int *output) { switch (choice) { case 0: int &alias(output[0]); case 1: break; default: break; } }",
        "using Null = decltype(nullptr); __global__ void kernel(unsigned choice) { Null source; switch (choice) { case 0: Null &alias(source); case 1: break; default: break; } }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_direct_borrowed_initializers_keep_pending_and_uninitialized_reads_rejected() {
    for source in [
        "__global__ void kernel() { int *pointer(pointer); }",
        "__global__ void kernel() { int values[2]{}; int *pointer(values); { int *pointer(pointer + 1); } }",
        "__global__ void kernel() { int *unassigned; int *pointer(unassigned); }",
        "__global__ void kernel() { int &alias(alias); }",
        "__global__ void kernel() { const int &alias(alias); }",
        "using Null = decltype(nullptr); __global__ void kernel() { Null &alias(alias); }",
        "using Null = decltype(nullptr); __global__ void kernel() { const Null &alias(alias); }",
        "__global__ void kernel() { int *pointer(later), *later(nullptr); }",
        "__global__ void kernel() { int &alias(later), later(3); }",
    ] {
        rejected(source);
    }
    roundtrip(
        "using Null = decltype(nullptr);
        __global__ void kernel(unsigned *output) {
            int storage;
            int *pointer(&storage);
            int &alias(*pointer);
            alias = 23;
            Null source(source);
            constexpr Null constant_source(constant_source);
            const Null &view(source);
            output[0] = unsigned(storage);
            output[1] = unsigned(view == constant_source);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_report_the_outer_argument_comma() {
    for (declaration, first, second) in [
        ("int *selected", "&first", "&second"),
        ("int &selected", "first", "second"),
        ("const int &selected", "first", "second"),
        ("Null &selected", "first_null", "second_null"),
        ("const Null &selected", "nullptr", "nullptr"),
    ] {
        for arguments in [format!("{first}, {second}"), format!("{first},")] {
            let source = format!(
                "/* café 漢 */ using Null = decltype(nullptr);
                __global__ void kernel() {{
                    int first = 3; int second = 7;
                    Null first_null; Null second_null;
                    {declaration}({arguments});
                }}"
            );
            let comma = source.find(',').unwrap();
            let error = rejected(&source);
            assert_eq!(
                error.span.to_range(),
                Some(comma..comma + 1),
                "{source}: {error}"
            );
        }
    }
}

#[test]
fn cuda_direct_borrowed_initializers_distinguish_functions_from_forced_expressions() {
    for declaration in [
        "int *selected();",
        "int &selected();",
        "int *selected(int(seed));",
        "const int &selected(int(seed));",
        "int *selected(int(factory()));",
        "const int &selected(int(factory()));",
        "int *selected(int(*pointer));",
        "const int &selected(int(array[2]));",
        "const Record &selected(Record(record));",
        "const Null &selected(Null());",
        "const Null &selected(Null(source));",
        "const Null &selected(Null(produce()));",
        "const Null &selected(decltype(nullptr)());",
    ] {
        let source = format!(
            "using Null = decltype(nullptr); struct Record {{ int value; }};
            __global__ void kernel() {{
                int seed = 3; int array[2]{{5, 7}}; int *pointer = array;
                Record record{{11}}; Null source;
                {declaration}
            }}"
        );
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
    }
    for declaration in [
        "int *selected(int(*)());",
        "const int &selected(int[2]);",
        "const Null &selected(Null(*)());",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {declaration} }}"
        ));
    }
    roundtrip(
        "using Null = decltype(nullptr);
        __device__ int observe(int &counter) { ++counter; return counter; }
        __device__ Null produce(int &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            int seed = 3, counter = 0;
            int values[2]{5, 7};
            int *pointer((values));
            int &alias((seed));
            const int &forced((int(seed)));
            const int &called(int(observe(counter)));
            const int &assigned(int(counter = 9));
            Null source;
            const Null &wrapped((Null(source)));
            const Null &returned(Null(produce(counter)));
            output[0] = unsigned(*pointer + alias + forced + called + assigned);
            output[1] = unsigned(counter);
            output[2] = unsigned(wrapped == returned);
        }",
    );
}

#[test]
fn cuda_direct_borrowed_initializers_keep_expression_and_declaration_depth_bounded() {
    for (declaration, operand, setup) in [
        ("int *selected", "values", "int values[2]{3, 7};"),
        ("int &selected", "value", "int value = 3;"),
        ("const Null &selected", "nullptr", ""),
        ("Null &selected", "source", "Null source;"),
    ] {
        let source = |depth: usize| {
            format!(
                "using Null = decltype(nullptr); __global__ void kernel() {{
                    {setup} {declaration}({}{operand}{});
                }}",
                "(".repeat(depth),
                ")".repeat(depth),
            )
        };
        roundtrip(&source(8));
        let error = rejected(&source(512));
        assert!(
            error.message.contains("limit") || error.message.contains("nesting"),
            "{error}"
        );
    }
    for (result, parameter_type) in [
        ("int *selected", "int"),
        ("const int &selected", "int"),
        ("const Null &selected", "Null"),
    ] {
        for depth in [8, 512] {
            let mut parameter = format!("{parameter_type}()");
            for _ in 0..depth {
                parameter = format!("{parameter_type}({parameter})");
            }
            let source = format!(
                "using Null = decltype(nullptr); __global__ void kernel() {{
                    {result}({parameter});
                }}"
            );
            let error = rejected(&source);
            if depth == 8 {
                assert!(error.message.contains("function declaration"), "{error}");
            } else {
                assert!(
                    error.message.contains("limit") || error.message.contains("nesting"),
                    "{error}"
                );
            }
        }
    }
    for declaration in [
        "int **pointer(nullptr);",
        "int *pointer = nullptr; int *&alias(pointer);",
        "int values[2]{}; int (&alias)[2](values);",
        "int *pointer({nullptr});",
        "int value = 3; int &alias({value});",
        "int value = 3; constexpr int &alias(value);",
        "int value = 3; volatile int *volatile pointer(&value);",
        "Null source; volatile Null &alias(source);",
        "int *pointers[2](nullptr);",
        "int values[2]{}; int (*pointer)[2](&values);",
    ] {
        rejected(&format!(
            "using Null = decltype(nullptr); __global__ void kernel() {{ {declaration} }}"
        ));
    }
}
