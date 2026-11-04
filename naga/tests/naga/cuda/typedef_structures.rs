use super::helpers::validate;

fn roundtrip(source: &str) -> naga::Module {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    module
}

fn storage_record(module: &naga::Module, binding: u32) -> (naga::Handle<naga::Type>, u32) {
    let (_, global) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.binding == Some(naga::ResourceBinding { group: 0, binding }))
        .unwrap();
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Dynamic,
        stride,
    } = module.types[global.ty].inner
    else {
        panic!("expected a record storage array");
    };
    (base, stride)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Default::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_typedef_structures_roundtrip_anonymous_records_with_natural_storage_layout() {
    for fields in [
        "first, second",
        "first, second, third",
        "first, second, third, fourth",
    ] {
        let module = roundtrip(&format!(
            "typedef struct {{ unsigned {fields}; }} Record;
            __global__ void kernel(Record *output, const Record *input) {{
                unsigned index = threadIdx.x;
                Record value = input[index];
                value.first += 1u;
                output[index] = value;
            }}"
        ));
        let (record, stride) = storage_record(&module, 0);
        let (input_record, input_stride) = storage_record(&module, 1);
        assert_eq!(record, input_record);
        assert_eq!(stride, input_stride);
        let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
            panic!("expected an anonymous typedef record");
        };
        let field_names: Vec<_> = fields.split(", ").collect();
        assert_eq!(members.len(), field_names.len());
        assert_eq!(span, 4 * field_names.len() as u32);
        assert_eq!(stride, span);
        for (index, (member, expected_name)) in members.iter().zip(field_names).enumerate() {
            assert_eq!(member.name.as_deref(), Some(expected_name));
            assert_eq!(member.offset, 4 * index as u32);
            assert_eq!(
                module.types[member.ty].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
        }
    }
}

#[test]
fn cuda_typedef_structures_share_comma_aliases_and_keep_separate_nominal_definitions() {
    let module = roundtrip(
        "typedef struct { unsigned value; } First, Alias;
        typedef struct { unsigned value; } Second;
        __device__ unsigned choose(First value) { return value.value + 1u; }
        __device__ unsigned choose(Second value) { return value.value + 2u; }
        __global__ void kernel(First *first_output, Alias *alias_output, Second *second_output) {
            First first{3u};
            Alias alias = first;
            Second second{5u};
            first_output[0] = first;
            alias.value = choose(alias);
            alias_output[0] = alias;
            second.value = choose(second);
            second_output[0] = second;
        }",
    );
    let (first, first_stride) = storage_record(&module, 0);
    let (alias, alias_stride) = storage_record(&module, 1);
    let (second, second_stride) = storage_record(&module, 2);
    assert_eq!(first, alias);
    assert_ne!(first, second);
    assert_eq!([first_stride, alias_stride, second_stride], [4, 4, 4]);
    let overload_arguments: Vec<_> = module
        .functions
        .iter()
        .filter(|(_, function)| function.name.as_deref() == Some("choose"))
        .map(|(_, function)| function.arguments[0].ty)
        .collect();
    assert_eq!(overload_arguments, [first, second]);
}

#[test]
fn cuda_typedef_structures_named_definitions_keep_tag_identity_and_template_names() {
    let module = roundtrip(
        "typedef struct Tag { unsigned value; } Alias, Tag, *Pointer;
        template<class Value> __global__ void copy(Value *output, const Value *input) {
            output[threadIdx.x] = input[threadIdx.x];
        }
        template __global__ void copy<Alias>(Alias *, const Alias *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "copy<Tag>");
    assert_eq!(storage_record(&module, 0), storage_record(&module, 1));
    let (record, _) = storage_record(&module, 0);
    assert!(module.types[record]
        .name
        .as_deref()
        .unwrap()
        .starts_with("Tag_cuda_record_"));
    roundtrip(
        "typedef struct Tag { unsigned value; } *Pointer;
        __global__ void kernel(Pointer output) { output[threadIdx.x] = Tag{7u}; }",
    );
}

#[test]
fn cuda_typedef_structures_pointer_first_aliases_use_first_direct_template_name() {
    let module = roundtrip(
        "typedef struct { unsigned first, second, third; } *Pointer, Record, Alias, *OtherPointer;
        template<class Value> __global__ void copy(Value *output, const Value *input) {
            output[threadIdx.x] = input[threadIdx.x];
        }
        template __global__ void copy<Alias>(Alias *, const Alias *);",
    );
    assert_eq!(module.entry_points[0].name, "copy<Record>");
    let (record, stride) = storage_record(&module, 0);
    assert_eq!(stride, 12);
    assert_eq!(storage_record(&module, 1), (record, stride));
    assert!(module.types[record]
        .name
        .as_deref()
        .unwrap()
        .starts_with("Record_cuda_record_"));
    roundtrip(
        "typedef struct { unsigned value; } *Pointer, Record, *const FixedPointer;
        __global__ void kernel(Pointer output) {
            FixedPointer fixed = output;
            Record value{9u};
            fixed[threadIdx.x] = value;
        }",
    );
}

#[test]
fn cuda_typedef_structures_pointer_only_definitions_support_ordinary_record_access() {
    let module = roundtrip(
        "typedef struct { unsigned first, second; } *Pointer;
        __device__ void advance(Pointer value) { value->first += value->second; }
        __global__ void kernel(Pointer output) { advance(output + threadIdx.x); }",
    );
    let (record, stride) = storage_record(&module, 0);
    assert_eq!(stride, 8);
    let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
        panic!("expected an unnamed pointer-only record");
    };
    assert_eq!(span, 8);
    assert_eq!(members.len(), 2);
}

#[test]
fn cuda_typedef_structures_qualified_aliases_keep_pointer_and_pointee_access_rules() {
    for declaration in [
        "typedef const struct { unsigned value; } Frozen;",
        "typedef struct { unsigned value; } const Frozen;",
    ] {
        let module = roundtrip(&format!(
            "{declaration}
            __global__ void kernel(unsigned *output, Frozen *input) {{
                output[threadIdx.x] = input[threadIdx.x].value;
            }}"
        ));
        let (_, input) = module
            .global_variables
            .iter()
            .find(|(_, global)| {
                global.binding
                    == Some(naga::ResourceBinding {
                        group: 0,
                        binding: 1,
                    })
            })
            .unwrap();
        assert_eq!(
            input.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD
            }
        );
        rejected(&format!(
            "{declaration} __global__ void kernel(Frozen *input) {{ input[0].value = 3u; }}"
        ));
    }
    for body in [
        "FixedPointer fixed = output; ++fixed;",
        "FixedPointer fixed = output; fixed = output + 1;",
    ] {
        rejected(&format!(
            "typedef struct {{ unsigned value; }} Record, *Pointer, *const FixedPointer;
            __global__ void kernel(Pointer output) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_typedef_structures_local_shadows_restore_outer_types_and_member_lookup() {
    let module = roundtrip(
        "typedef struct { unsigned value; } Record;
        using Element = unsigned;
        __global__ void kernel(unsigned *output) {
            Record outer{3u};
            {
                typedef struct { Element value; } Record;
                Record inner{5u}; output[0] = inner.value;
            }
            Record restored = outer; output[1] = restored.value;
            { typedef struct { Element value; } Element; Element record{7u}; output[2] = record.value; }
        }",
    );
    let records: Vec<_> = module.entry_points[0]
        .function
        .local_variables
        .iter()
        .filter(|(_, local)| {
            local
                .name
                .as_deref()
                .is_some_and(|name| ["outer", "inner", "restored"].contains(&name))
        })
        .map(|(_, local)| local.ty)
        .collect();
    assert_eq!(records.len(), 3);
    assert_eq!(records[0], records[2]);
    assert_ne!(records[0], records[1]);
    for source in [
        "__global__ void kernel() { { typedef struct { unsigned value; } Local; } Local value{}; }",
        "__device__ void helper() { typedef struct { unsigned value; } Local; } __global__ void kernel() { Local value{}; }",
        "using Element = unsigned; typedef struct { unsigned Element; Element other; } Record; __global__ void kernel() {}",
        "constexpr int Width = 2; typedef struct { unsigned Width; unsigned values[Width]; } Record; __global__ void kernel() {}",
        "typedef struct { Record nested; } Record; __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_typedef_structures_template_locals_and_shared_records_reuse_existing_lowering() {
    let module = roundtrip(
        "template<class Value> __device__ unsigned retained(Value value) {
            typedef struct { Value value; unsigned count; } Local;
            __shared__ Local state;
            state = Local{value, 1u};
            return unsigned(state.value) + state.count;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = retained<unsigned>(3u);
            output[1] = retained<unsigned>(5u);
            output[2] = retained<float>(7.0f);
        }",
    );
    let shared_types: Vec<_> = module
        .global_variables
        .iter()
        .filter(|(_, global)| global.space == naga::AddressSpace::WorkGroup)
        .map(|(_, global)| global.ty)
        .collect();
    assert_eq!(shared_types.len(), 2);
    assert_ne!(shared_types[0], shared_types[1]);
    for record in shared_types {
        let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
            panic!("expected a shared local typedef record");
        };
        assert_eq!(members.len(), 2);
        assert_eq!(span, 8);
    }
}

#[test]
fn cuda_typedef_structures_nested_alias_records_and_references_keep_member_layout() {
    let module = roundtrip(
        "typedef struct { unsigned key; unsigned values[2]; } Inner;
        typedef struct { Inner nested; unsigned tail; } Outer;
        __device__ void advance(Outer &record) { record.nested.values[1] += record.tail; }
        __global__ void kernel(Outer *output) {
            Outer record{{3u, {5u, 7u}}, 11u};
            advance(record);
            output[threadIdx.x] = record;
        }",
    );
    let (record, stride) = storage_record(&module, 0);
    assert_eq!(stride, 16);
    let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
        panic!("expected an outer typedef record");
    };
    assert_eq!(span, 16);
    assert_eq!(members[1].offset, 12);
    let naga::TypeInner::Struct {
        members: ref nested,
        span: 12,
    } = module.types[members[0].ty].inner
    else {
        panic!("expected a nested typedef record");
    };
    assert_eq!(nested[1].offset, 4);
}

#[test]
fn cuda_typedef_structures_redeclarations_preserve_nominal_and_ordinary_name_checks() {
    roundtrip(
        "typedef struct { unsigned value; } Record, Record;
        typedef Record Record; using Alias = Record;
        __global__ void kernel(Record *output) { output[0] = Alias{7u}; }",
    );
    for source in [
        "typedef struct { unsigned value; } First; typedef struct { unsigned value; } Second; __global__ void kernel() { First first{}; Second second = first; }",
        "typedef struct { unsigned value; } Record; typedef struct { unsigned value; } Record; __global__ void kernel() {}",
        "struct Tag { unsigned value; }; typedef struct Tag { unsigned value; } Alias; __global__ void kernel() {}",
        "__global__ void kernel() { unsigned Record = 3u; typedef struct { unsigned value; } Record; }",
        "typedef struct { unsigned value; } Record; __device__ unsigned Record(unsigned value) { return value; } __global__ void kernel() {}",
        "__device__ unsigned Record(unsigned value) { return value; } typedef struct { unsigned value; } Record; __global__ void kernel() {}",
        "typedef struct { unsigned value; } First, Alias; __device__ unsigned choose(First value) { return 1u; } __device__ unsigned choose(Alias value) { return 2u; } __global__ void kernel() {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_typedef_structures_keep_existing_member_and_declarator_boundaries() {
    for fields in [
        "",
        "bool value;",
        "char value;",
        "double value;",
        "const unsigned value;",
        "volatile unsigned value;",
        "unsigned *value;",
        "unsigned &value;",
        "unsigned value = 3u;",
        "unsigned value, value;",
        "static unsigned value;",
        "unsigned value : 3;",
        "unsigned value();",
        "unsigned values[];",
        "struct Nested { unsigned value; }; Nested nested;",
    ] {
        rejected(&format!(
            "typedef struct {{ {fields} }} Record; __global__ void kernel() {{}}"
        ));
    }
    for source in [
        "typedef struct { unsigned value; } &Reference; __global__ void kernel() {}",
        "typedef struct { unsigned value; } Factory(); __global__ void kernel() {}",
        "typedef struct Tag Alias; __global__ void kernel() {}",
        "typedef struct Tag { unsigned value; } Alias; __global__ void kernel(struct Tag *input) {}",
        "typedef struct __align__(16) { unsigned value; } Record; __global__ void kernel() {}",
        "typedef class { unsigned value; } Record; __global__ void kernel() {}",
        "typedef union { unsigned value; float other; } Record; __global__ void kernel() {}",
        "typedef struct { unsigned value; }; __global__ void kernel() {}",
    ] {
        rejected(source);
    }
    roundtrip("typedef struct { unsigned value; } Record[2]; __global__ void kernel() {}");
}

#[test]
fn cuda_typedef_structures_preserve_utf8_spans_and_check_unreachable_declarations() {
    for source in [
        "/* λ */ typedef struct { unsigned value } Record; __global__ void kernel() {}",
        "/* λ */ typedef struct { unsigned; } Record; __global__ void kernel() {}",
        "/* λ */ typedef struct { unsigned value; } Record __global__ void kernel() {}",
        "/* λ */ __global__ void kernel() { return; typedef struct { bool value; } Record; }",
        "/* λ */ __global__ void kernel() { return; typedef struct { unsigned value; } Record; Record value{missing}; }",
    ] {
        rejected(source);
    }
    roundtrip(
        "__global__ void kernel() { return; typedef struct { unsigned value; } Record; Record value{3u}; }",
    );
}

#[test]
fn cuda_typedef_structures_enforce_existing_size_and_nesting_limits() {
    let count = naga::valid::MAX_TYPE_SIZE / 4;
    rejected(&format!(
        "typedef struct {{ unsigned values[{count}u]; unsigned extra; }} Record;
        __global__ void kernel() {{}}"
    ));
    for bound in ["0", "-1", "0xffffffffu", "missing", "1.5f"] {
        rejected(&format!(
            "typedef struct {{ unsigned values[{bound}]; }} Record; __global__ void kernel() {{}}"
        ));
    }
    for depth in [8, 128] {
        let mut source = String::from("typedef struct { unsigned value; } Record0;\n");
        for index in 1..=depth {
            source.push_str(&format!(
                "typedef struct {{ Record{} nested; }} Record{index};\n",
                index - 1
            ));
        }
        source.push_str(&format!(
            "__global__ void kernel() {{ Record{depth} value{{}}; }}"
        ));
        if depth == 8 {
            roundtrip(&source);
        } else {
            rejected(&source);
        }
    }
}
