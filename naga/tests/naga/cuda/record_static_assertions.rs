use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    module
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
fn cuda_record_static_assertions_query_earlier_members_without_changing_layout() {
    let module = validate(
        "struct Inner { float3 vector; int row[3]; };
        struct Record {
            static_assert(sizeof(int) == 4);
            int scalar;
            static_assert(sizeof(scalar) == 4);
            float3 vector;
            static_assert(sizeof(vector) == 12);
            int matrix[2][3];
            static_assert(sizeof(matrix) == 24);
            static_assert(sizeof(matrix[0]) == 12);
            Inner nested;
            static_assert(sizeof(nested.row) == 12);
            static_assert(sizeof(nested.vector.z) == 4);
        };
        __global__ void kernel(unsigned *output) {
            Record value;
            output[0] = unsigned(sizeof(value));
        }",
    );
    let record = module
        .types
        .iter()
        .find_map(|(_, ty)| {
            ty.name
                .as_deref()
                .is_some_and(|name| name.starts_with("Record_cuda_record_"))
                .then_some(ty)
        })
        .unwrap();
    let naga::TypeInner::Struct { members, span } = &record.inner else {
        panic!("record layout")
    };
    assert_eq!(*span, 64);
    assert_eq!(members.len(), 4);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 4, 16, 40]
    );
    assert!(module.functions.is_empty());
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        assert!(!matches!(
            statement,
            naga::Statement::Call { .. } | naga::Statement::If { .. }
        ));
        false
    });
}

#[test]
fn cuda_record_static_assertions_cover_local_anonymous_and_typedef_records() {
    validate(
        "constexpr unsigned Width = 4u;
        typedef struct {
            static_assert(Width == 4u);
            unsigned value;
            static_assert(sizeof(value) == Width);
        } Alias;
        __global__ void kernel(unsigned *output) {
            constexpr unsigned Count = 3u;
            typedef struct {
                short element;
                static_assert(sizeof(element) == 2);
                static_assert(sizeof(+element) == 4);
                int values[Count];
                static_assert(sizeof(values) == 12);
            } LocalAlias;
            struct Named {
                static_assert(Count == 3u);
                unsigned index;
                int values[3];
                static_assert(sizeof(values[index]) == 4);
            };
            LocalAlias local;
            Alias global_alias;
            output[0] = unsigned(sizeof(local));
            output[1] = unsigned(sizeof(Named));
            output[2] = unsigned(sizeof(global_alias));
        }",
    );
}

#[test]
fn cuda_record_static_assertions_preserve_name_hiding_and_restore_enclosing_scope() {
    validate(
        "using Value = long;
        constexpr unsigned long Count = 9UL;
        struct Outer {
            unsigned Count;
            static_assert(sizeof(Count) == 4);
        };
        static_assert(sizeof(Count) == 8);
        __global__ void kernel(unsigned *output) {
            constexpr unsigned long Count = 3UL;
            struct Local {
                int Count;
                static_assert(sizeof(Count) == 4);
                int Value;
                static_assert(sizeof(Value) == 4);
            };
            static_assert(Count == 3UL);
            static_assert(sizeof(Count) == 8);
            static_assert(sizeof(Value) == 8);
            Local value;
            output[0] = unsigned(sizeof(value));
        }",
    );
    rejected(
        "__global__ void kernel() {
            struct Local { int member; static_assert(sizeof(member) == 4); };
            static_assert(sizeof(member) == 4);
        }",
    );
}

#[test]
fn cuda_record_static_assertions_report_false_conditions_and_validate_objectless_reads() {
    for (declaration, message) in [
        (
            "struct Bad { static_assert(false, \"before fields\"); int value; };",
            "before fields",
        ),
        (
            "struct Bad { int value; static_assert(sizeof(value) == 8, \"member \" \"layout\"); };",
            "member layout",
        ),
    ] {
        let error = rejected(&format!("{declaration} __global__ void kernel() {{}}"));
        assert!(error.message.contains("static assertion failed"), "{error}");
        assert!(error.message.contains(message), "{error}");
    }
    for assertion in [
        "static_assert(value);",
        "static_assert(value == 0);",
        "static_assert(true || value);",
        "static_assert(true, 7);",
    ] {
        rejected(&format!(
            "struct Bad {{ int value; {assertion} }};
            __global__ void kernel() {{}}"
        ));
    }
}

#[test]
fn cuda_record_static_assertions_preserve_incomplete_current_tags_and_existing_record_restrictions()
{
    rejected(
        "struct Record { float3 vector; };
        __global__ void kernel() {
            struct Record {
                static_assert(sizeof(Record) == 12);
                unsigned value;
            };
        }",
    );
    let empty = rejected("struct Empty { static_assert(true); }; __global__ void kernel() {}");
    assert!(empty.message.contains("empty structures"), "{empty}");
    for declaration in [
        "struct Record { int value; static_assert(sizeof(Record*) == 8); };",
        "struct Record { static constexpr int Count = 3; int value; };",
        "struct Record { int value; static_assert(sizeof(Record::value) == 4); };",
        "template<class Value> struct Record { Value value; };",
    ] {
        rejected(&format!("{declaration} __global__ void kernel() {{}}"));
    }
}

#[test]
fn cuda_record_static_assertions_check_function_template_instances_and_defer_unused_bodies() {
    validate(
        "template<class Value, unsigned Count> __device__ unsigned inspect(Value value) {
            struct Local {
                static_assert(sizeof(Value) == 4, \"element width\");
                Value values[Count];
                static_assert(sizeof(values) == sizeof(Value) * Count);
            };
            Local local;
            local.values[0] = value;
            return unsigned(local.values[0]);
        }
        template<class Value> __device__ unsigned unused() {
            struct Hidden { unsigned field; static_assert(false); };
            return 0u;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = inspect<unsigned, 3u>(7u);
            output[1] = inspect<float, 2u>(9.0f);
        }",
    );
    let error = rejected(
        "template<class Value> __device__ unsigned inspect(Value value) {
            struct Local {
                static_assert(sizeof(Value) == 4, \"element width\");
                Value field;
            };
            return 7u;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = inspect<short>(short(1));
        }",
    );
    assert!(error.message.contains("element width"), "{error}");
    let error = rejected(
        "template<class Value> __device__ unsigned requested() {
            struct Hidden { unsigned field; static_assert(false, \"requested body\"); };
            return 0u;
        }
        __global__ void kernel(unsigned *output) { output[0] = requested<unsigned>(); }",
    );
    assert!(error.message.contains("requested body"), "{error}");
}
