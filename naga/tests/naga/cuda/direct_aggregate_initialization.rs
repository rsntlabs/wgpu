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
fn cuda_direct_aggregate_initializers_copy_supported_vectors() {
    for scalar in ["int", "uint", "float"] {
        for width in 2..=4 {
            let vector = format!("{scalar}{width}");
            roundtrip(&format!(
                "using Vector = {vector};
                __global__ void kernel(unsigned *output) {{
                    Vector source{{3}};
                    Vector copied(source);
                    const Vector snapshot(copied);
                    copied.x = 7; source.x = 11;
                    output[0] = unsigned(snapshot.x);
                    output[1] = unsigned(copied.x);
                    output[2] = unsigned(source.x);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_direct_aggregate_initializers_copy_nested_records_and_array_members() {
    roundtrip(
        "struct Leaf { int values[2]; float2 point; };
        struct Record { Leaf leaves[2]; dim3 shape; };
        using Alias = Record;
        __global__ void kernel(unsigned *output) {
            Record source{{{{3, 5}, {7, 11}}, {{13, 17}, {19, 23}}}, {2u, 3u, 4u}};
            Alias copied(source);
            const Record snapshot(copied);
            source.leaves[0].values[1] = 29;
            copied.leaves[1].point.y = 31;
            copied.shape.z = 37u;
            output[0] = unsigned(snapshot.leaves[0].values[1]);
            output[1] = unsigned(snapshot.leaves[1].point.y);
            output[2] = snapshot.shape.z;
            output[3] = unsigned(source.leaves[0].values[1]);
            output[4] = unsigned(copied.leaves[1].point.y);
            output[5] = copied.shape.z;
        }",
    );
}

#[test]
fn cuda_direct_aggregate_initializers_preserve_helper_and_declarator_effects() {
    roundtrip(
        "struct Record { int value; int values[2]; };
        __device__ Record next(int &counter) {
            ++counter; return Record{counter, {counter + 1, counter + 2}};
        }
        __global__ void kernel(int *output) {
            int counter = 0;
            Record first(next(counter)), second((counter += 2, next(counter))), third{next(counter)};
            Record *pointer(&first), &alias(second), copied(*pointer);
            const Record &view(copied);
            copied.value = 11;
            int total = 0;
            for (Record iteration(next(counter)); iteration.value < 8; ++iteration.value) {
                total += iteration.value;
            }
            output[0] = counter;
            output[1] = first.value + alias.value + third.value + view.value;
            output[2] = total;
        }",
    );
}

#[test]
fn cuda_direct_aggregate_initializers_keep_exact_types_and_source_constness() {
    roundtrip(
        "struct Record { int value; float3 point; };
        using Frozen = const Record;
        __global__ void kernel(const Record *input, Record *output) {
            Frozen source{3, {5, 7, 11}};
            Record copied(source);
            Record stored(input[0]);
            const float3 vector{13, 17, 19};
            float3 mutable_vector(vector);
            copied.value = 23;
            stored.point.y = 29;
            mutable_vector.z = 31;
            output[0] = copied; output[1] = stored;
            output[2] = Record{source.value, mutable_vector};
        }",
    );
    for source in [
        "__global__ void kernel() { float2 source{}; int2 copied(source); }",
        "__global__ void kernel() { int2 source{}; uint2 copied(source); }",
        "__global__ void kernel() { float2 source{}; float3 copied(source); }",
        "__global__ void kernel() { float2 copied(1.0f); }",
        "__global__ void kernel() { uint3 copied(1u); }",
        "__global__ void kernel() { float2 *pointer = nullptr; float2 copied(pointer); }",
        "__global__ void kernel() { float2 copied(nullptr); }",
        "struct Record { int value; }; __global__ void kernel() { Record copied(3); }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel() { First source{}; Second copied(source); }",
        "__global__ void kernel() { float2 source{}; const float2 copied(source); copied.x = 7.0f; }",
        "struct Record { int value; }; __global__ void kernel() { Record source{}; const Record copied(source); copied.value = 7; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_direct_aggregate_initializers_keep_function_declarations_distinct() {
    for declaration in [
        "float2 copied();",
        "float2 copied(float2(source));",
        "float3 copied(float3());",
        "uint3 copied(uint3(source));",
        "uint3 copied(dim3(shape));",
        "uint3 copied(dim3());",
        "uint3 copied(dim3(factory()));",
        "Record copied(Record(source));",
        "Record copied(Record());",
        "Alias copied(Alias(source));",
        "Record copied(Record(factory()));",
    ] {
        let source = format!(
            "struct Record {{ int value; }}; using Alias = Record;
            __global__ void kernel() {{ dim3 shape(2u); {declaration} }}"
        );
        let error = rejected(&source);
        assert!(
            error.message.contains("function declaration"),
            "{source}: {error}"
        );
    }
    for declaration in [
        "float2 copied(float2(*)());",
        "uint3 copied(dim3(*)());",
        "Record copied(Record[2]);",
    ] {
        rejected(&format!(
            "struct Record {{ int value; }}; __global__ void kernel() {{ {declaration} }}"
        ));
    }
    roundtrip(
        "struct Record { int value; };
        __device__ float2 observe(unsigned &counter) {
            ++counter; return float2{3, 5};
        }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            float2 source{7, 11};
            float2 copied((source));
            const float2 returned(observe(counter));
            Record record(Record{13});
            Record forced((record));
            uint3 raw{17u, 19u, 23u};
            uint3 packed(raw);
            dim3 shape(29u, 31u, 37u);
            uint3 converted(shape);
            uint3 constructed(dim3{41u, 43u, 47u});
            uint3 parenthesized((dim3(shape)));
            output[0] = unsigned(copied.x + returned.y) + counter;
            output[1] = unsigned(record.value + forced.value);
            output[2] = packed.z + converted.z + constructed.z + parenthesized.z;
        }",
    );
}

#[test]
fn cuda_direct_aggregate_initializers_report_the_outer_argument_comma() {
    for declaration in ["float2", "float3", "uint3", "Record"] {
        for arguments in ["source, source", "source,"] {
            let source = format!(
                "/* café 漢 */ struct Record {{ int value; }};
                __global__ void kernel() {{
                    {declaration} source{{}};
                    {declaration} copied({arguments});
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
fn cuda_direct_aggregate_initializers_preserve_scope_and_initialization_boundaries() {
    roundtrip(
        "struct Record { int value; };
        __global__ void kernel(int *output) {
            Record source;
            source.value = 3;
            Record copied(source);
            {
                struct Record { float value; };
                Record source{5.0f};
                Record copied(source);
                output[0] = int(copied.value);
            }
            Record restored(copied);
            float3 vector;
            vector = make_float3(7, 11, 13);
            float3 vector_copy(vector);
            output[1] = restored.value + int(vector_copy.z);
        }",
    );
    for source in [
        "struct Record { int value; }; __global__ void kernel() { Record source{}; { struct Record { int value; }; Record copied(source); } }",
        "struct Record { int value; }; __global__ void kernel() { Record source{}; for (Record iteration(source); false;) {} Record copied(iteration); }",
        "__global__ void kernel() { float2 source{}; for (float2 iteration(source); false;) {} float2 copied(iteration); }",
        "struct Record { int value; }; __global__ void kernel(unsigned choice) { Record source{}; switch (choice) { case 0: Record copied(source); case 1: break; default: break; } }",
        "__global__ void kernel(unsigned choice) { float2 source{}; switch (choice) { case 0: float2 copied(source); case 1: break; default: break; } }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_direct_aggregate_initializers_keep_bounds_and_other_aggregate_grammars() {
    for (name, member) in [("float3", "x"), ("uint3", "z"), ("Record", "value")] {
        let source = |depth: usize| {
            format!(
                "struct Record {{ int value; }};
                __device__ {name} identity({name} value) {{ return value; }}
                __global__ void kernel(unsigned *output) {{
                    {name} source{{}};
                    {name} copied({}source{});
                    output[0] = unsigned(copied.{member});
                }}",
                "identity(".repeat(depth),
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
    for name in ["uint3", "Record"] {
        for depth in [8, 512] {
            let mut parameter = format!("{name}()");
            for _ in 0..depth {
                parameter = format!("{name}({parameter})");
            }
            let source = format!(
                "struct Record {{ int value; }};
                __global__ void kernel() {{ {name} copied({parameter}); }}"
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
        "float2 copied(1.0f, 2.0f);",
        "Record copied(1, 2);",
        "float2 source{}; float2 copied({source});",
        "Record source{}; Record copied({source});",
        "Record source{}; Record values[2](source);",
        "float2 source{}; float2(source);",
        "Record source{}; Record(source);",
        "float2 source{}; auto copied(float2(source));",
        "Record source{}; auto copied(Record(source));",
    ] {
        rejected(&format!(
            "struct Record {{ int first; int second; }};
            __global__ void kernel() {{ {declaration} }}"
        ));
    }
}
