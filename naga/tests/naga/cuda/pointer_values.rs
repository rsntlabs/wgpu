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
fn cuda_pointer_values_construct_typed_nulls_and_drop_pointer_object_cv() {
    for pointer in [
        "Pointer",
        "ReadPointer",
        "Frozen",
        "Observed",
        "::Pointer",
        "::Observed",
    ] {
        for arguments in ["()", "{}", "(0u)", "{0}", "(nullptr)", "{nullptr,}"] {
            roundtrip(&format!(
                "using Pointer = unsigned *;
                using ReadPointer = const unsigned *;
                using Frozen = const Pointer;
                using Observed = volatile Pointer;
                __global__ void kernel(unsigned *output) {{
                    auto value = {pointer}{arguments};
                    output[0] = unsigned(!value);
                    value = output;
                    output[1] = unsigned(bool(value));
                    value = nullptr;
                    output[2] = unsigned(value == nullptr);
                }}"
            ));
        }
    }
}

#[test]
fn cuda_pointer_values_copy_convert_and_decay_through_each_spelling() {
    for expression in [
        "ReadPointer{cursor}",
        "ReadPointer(cursor)",
        "static_cast<ReadPointer>(cursor)",
        "(ReadPointer)cursor",
        "ReadPointer{values}",
        "ReadPointer(values)",
        "static_cast<ReadPointer>(values)",
        "(ReadPointer)values",
    ] {
        for origin in ["values", "shared", "output + 8"] {
            roundtrip(&format!(
                "using Pointer = unsigned *;
                using ReadPointer = const unsigned *;
                __global__ void kernel(unsigned *output) {{
                    unsigned values[3]{{3u, 5u, 7u}};
                    __shared__ unsigned shared[3];
                    shared[0] = 11u; shared[1] = 13u; shared[2] = 17u;
                    output[8] = 19u; output[9] = 23u; output[10] = 29u;
                    Pointer cursor = {origin};
                    auto saved = {expression};
                    ++cursor;
                    output[0] = *saved;
                    output[1] = *cursor;
                }}"
            ));
        }
    }
}

#[test]
fn cuda_pointer_values_support_generic_helpers_and_keep_pointer_source_types() {
    roundtrip(
        "using Pointer = unsigned *;
        using ReadPointer = const unsigned *;
        __device__ unsigned choose(decltype(nullptr) value) { return 3u; }
        __device__ unsigned choose(ReadPointer value) { return 5u; }
        template<class Value> __device__ void inspect(unsigned *output, Value input) {
            auto absent = Value{};
            auto copied = Value(input);
            auto braced = Value{input};
            auto named = static_cast<Value>(input);
            auto c_style = (Value)input;
            output[0] = unsigned(!absent);
            output[1] = *copied + *braced + *named + *c_style;
        }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{7u, 11u};
            inspect<Pointer>(output, values);
            inspect<ReadPointer>(output + 2, values);
            output[4] = choose(Pointer{}) + choose(nullptr);
            output[5] = choose(static_cast<Pointer>(0));
            output[6] = choose((Pointer)nullptr);
        }",
    );
}

#[test]
fn cuda_pointer_values_allow_pure_automatic_addresses_in_constant_commas() {
    roundtrip(
        "using Pointer = unsigned *;
        __global__ void kernel(unsigned *output) {
            unsigned values[3]{3u, 5u, 7u};
            unsigned object = 11u;
            constexpr unsigned Array = (Pointer{values}, 3u);
            constexpr unsigned Object = (Pointer{&object}, 5u);
            constexpr unsigned Offset = (static_cast<Pointer>(values) + 1, 7u);
            unsigned selected[Array]{13u, 17u, 19u};
            output[0] = selected[0] + Object + Offset;
        }",
    );
    for expression in [
        "Pointer{(++counter, values)}",
        "Pointer{(++counter, &object)}",
        "Pointer{values} + (++counter, 1)",
        "Pointer{&(++counter, *Pointer{&object})}",
        "Pointer{&(++counter, *Pointer{values})}",
        "Pointer{&((*Pointer{&object}) = 17u)}",
        "Pointer{&(++*Pointer{&object})}",
        "Pointer{&values[index]}",
        "Pointer{parameter}",
    ] {
        rejected(&format!(
            "using Pointer = unsigned *;
            __global__ void kernel(unsigned *parameter, unsigned index) {{
                unsigned values[3]{{3u, 5u, 7u}};
                unsigned object = 11u; unsigned counter = 0u;
                constexpr unsigned Value = ({expression}, 3u);
            }}"
        ));
    }
    rejected(
        "using Pointer = unsigned *;
        __global__ void kernel() {
            unsigned object = 11u;
            unsigned &reference = *Pointer{&object};
            constexpr unsigned Value = (reference, 3u);
        }",
    );
}

#[test]
fn cuda_pointer_value_constructors_keep_pointer_and_pointee_qualifiers_separate() {
    roundtrip(
        "using Pointer = unsigned *;
        using ReadPointer = const unsigned *;
        using FixedPointer = Pointer const;
        using ObservedTarget = Pointer volatile;
        using VolatilePointee = volatile unsigned *;
        using ReadObservedTarget = ReadPointer const volatile;
        struct Record { unsigned value; };
        using RecordPointer = Record *;
        using ReadRecordPointer = const Record *;
        using VectorPointer = uint2 *;
        __global__ void kernel(unsigned *output) {
            unsigned local[3]{3u, 5u, 7u};
            FixedPointer fixed = local;
            auto first = FixedPointer(fixed); ++first;
            auto second = FixedPointer{fixed,}; ++second;
            auto third = static_cast<FixedPointer>(fixed); ++third;
            auto fourth = (FixedPointer)fixed; ++fourth;
            auto fifth = ObservedTarget(fixed); ++fifth;
            auto sixth = ObservedTarget{fixed}; ++sixth;
            auto seventh = static_cast<ObservedTarget>(fixed); ++seventh;
            auto eighth = (ObservedTarget)fixed; ++eighth;
            ReadPointer read = ReadObservedTarget{fixed};
            VolatilePointee observed = VolatilePointee{fixed};
            Record record{11u}; RecordPointer record_pointer = &record;
            ReadRecordPointer record_copy = ReadRecordPointer(record_pointer);
            uint2 pair{13u, 17u}; VectorPointer vector_copy = VectorPointer{&pair};
            output[0] = *first + *second + *third + *fourth;
            output[1] = *fifth + *sixth + *seventh + *eighth;
            output[2] = *read + record_copy->value + vector_copy->x;
            output[3] = unsigned(bool(observed));
        }",
    );
    for expression in [
        "Pointer{read_only}",
        "Pointer{observed}",
        "Pointer{different}",
        "static_cast<Pointer>(read_only)",
        "static_cast<Pointer>(observed)",
        "static_cast<Pointer>(different)",
        "Pointer(0.0f)",
        "(Pointer)0.0f",
    ] {
        rejected(&format!(
            "using Pointer = unsigned *;
            __global__ void kernel(const unsigned *read_only,
                volatile unsigned *observed, float *different) {{
                auto copy = {expression};
            }}"
        ));
    }
    for expression in [
        "Pointer(read_only)",
        "(Pointer)read_only",
        "Pointer(observed)",
        "(Pointer)observed",
        "Pointer(different)",
        "(Pointer)different",
        "Pointer(1u)",
        "(Pointer)1u",
        "Pointer(int())",
        "(Pointer)unsigned{}",
    ] {
        let error = rejected(&format!(
            "using Pointer = unsigned *;
            __global__ void kernel(const unsigned *read_only,
                volatile unsigned *observed, float *different) {{
                auto copy = {expression};
            }}"
        ));
        assert!(
            error.message.contains("unsupported"),
            "{expression}: {error}"
        );
    }
}

#[test]
fn cuda_pointer_value_constructors_preserve_null_origin_and_constant_effects() {
    roundtrip(
        "#define ZERO ((0u))
        using Pointer = unsigned *;
        using Null = decltype(nullptr);
        constexpr unsigned First = (Pointer(), 3u);
        constexpr unsigned Second = (Pointer{}, 5u);
        constexpr unsigned Third = (Pointer(nullptr), 7u);
        constexpr unsigned Fourth = (Pointer{ZERO}, 11u);
        constexpr unsigned Fifth = (static_cast<Pointer>(nullptr), 13u);
        constexpr unsigned Sixth = ((Pointer)0, 17u);
        __device__ Null produce(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            Pointer first = Pointer(produce(counter));
            Pointer second = Pointer{(++counter, nullptr)};
            Pointer third = static_cast<Pointer>(produce(counter));
            Pointer fourth = (Pointer)produce(counter);
            auto named_null = produce(counter);
            constexpr unsigned Named = (Pointer{named_null}, 19u);
            unsigned values[(First + Second + Third + Fourth + Fifth + Sixth) / 56u]{23u};
            output[0] = counter + unsigned(!first) + unsigned(!second);
            output[1] = unsigned(!third) + unsigned(!fourth) + Named + values[0];
        }",
    );
    for expression in [
        "Pointer{int()}",
        "Pointer{unsigned{}}",
        "Pointer{bool{false}}",
        "Pointer{Zero}",
        "Pointer{1 - 1}",
        "static_cast<Pointer>(int())",
    ] {
        rejected(&format!(
            "using Pointer = unsigned *; constexpr unsigned Zero = 0u;
            __global__ void kernel() {{ auto value = {expression}; }}"
        ));
    }
    for expression in [
        "Pointer(produce(counter))",
        "Pointer{produce(counter)}",
        "static_cast<Pointer>(produce(counter))",
        "(Pointer)produce(counter)",
        "Pointer{(++counter, nullptr)}",
        "Pointer((++counter, nullptr))",
        "Pointer(parameter)",
        "Pointer{parameter}",
        "static_cast<Pointer>(parameter)",
        "(Pointer)parameter",
    ] {
        rejected(&format!(
            "using Pointer = unsigned *; using Null = decltype(nullptr);
            __device__ Null produce(unsigned &counter) {{ ++counter; return nullptr; }}
            __global__ void kernel(unsigned *parameter) {{
                unsigned counter = 0u;
                constexpr unsigned value = ({expression}, 7u);
            }}"
        ));
    }
    rejected(
        "using Pointer = unsigned *;
        __global__ void kernel() { float *incompatible = Pointer{}; }",
    );
    rejected(
        "using Pointer = unsigned *; using Null = decltype(nullptr);
        __global__ void kernel() { Null incompatible = Pointer{}; }",
    );
}

#[test]
fn cuda_pointer_value_constructors_keep_prvalue_categories_and_declaration_guards() {
    roundtrip(
        "using Pointer = unsigned *;
        __device__ void observe(Pointer pointer, unsigned &counter) {
            ++counter; if (pointer) *pointer += 1u;
        }
        __global__ void kernel(unsigned *output) {
            unsigned first[2]{3u, 5u}; unsigned second[2]{7u, 11u};
            Pointer cursor = first;
            unsigned functional = Pointer(cursor)[(cursor = second, 1u)];
            cursor = first;
            unsigned braced = Pointer{cursor}[(cursor = second, 0u)];
            cursor = first;
            unsigned named = static_cast<Pointer>(cursor)[(cursor = second, 1u)];
            cursor = first;
            unsigned c_style = ((Pointer)cursor)[(cursor = second, 0u)];
            Pointer copied((Pointer(cursor)));
            Pointer comma = Pointer((first, second));
            Pointer list = Pointer{(first, second),};
            unsigned counter = 0u;
            observe(Pointer{(++counter, copied)}, counter);
            Pointer{}; (Pointer(cursor)); static_cast<Pointer>(cursor); (Pointer)cursor;
            output[0] = functional + braced + named + c_style + counter;
            output[1] = *comma + *list;
        }",
    );
    for expression in [
        "Pointer{} = input",
        "Pointer(input) += 1u",
        "++Pointer(input)",
        "Pointer{input}++",
        "&static_cast<Pointer>(input)",
        "Pointer{input}.x",
        "Pointer(input, input)",
        "Pointer{input, input}",
        "Pointer(input,)",
        "Pointer{,}",
        "Pointer{{nullptr}}",
        "Pointer{{}}",
    ] {
        rejected(&format!(
            "using Pointer = unsigned *;
            __global__ void kernel(unsigned *input) {{ {expression}; }}"
        ));
    }
    for declaration in [
        "Pointer value();",
        "Pointer value(Pointer());",
        "Pointer value(Pointer(seed));",
        "auto value(Pointer());",
    ] {
        let error = rejected(&format!(
            "using Pointer = unsigned *;
            __global__ void kernel(unsigned *seed) {{ {declaration} }}"
        ));
        assert!(
            error.message.contains("function declaration"),
            "{declaration}: {error}"
        );
    }
    let source = "/* café 漢 */ using Pointer = unsigned *;
        __global__ void kernel(unsigned *input) { auto invalid = &Pointer{input}; }";
    let error = rejected(source);
    let start = source.find("&Pointer{input}").unwrap();
    assert_eq!(
        error.span.to_range(),
        Some(start..start + "&Pointer{input}".len()),
        "{error}"
    );
}

#[test]
fn cuda_pointer_value_constructors_bound_typed_nesting_and_template_locals() {
    roundtrip(
        "template<class Value> __device__ void inspect(unsigned *output, Value source) {
            Value empty = Value{};
            Value copied = Value(source);
            Value braced = Value{source,};
            output[0] = unsigned(!empty) + unsigned(bool(copied)) + unsigned(bool(braced));
        }
        __global__ void kernel(unsigned *output) {
            inspect<unsigned *>(output, output);
            inspect<const unsigned *>(output + 1, output);
        }",
    );
    for mode in ["functional", "braced", "static_cast"] {
        let source = |depth: usize| {
            let mut expression = String::from("nullptr");
            for _ in 0..depth {
                expression = match mode {
                    "functional" => format!("Pointer({expression})"),
                    "braced" => format!("Pointer{{{expression}}}"),
                    _ => format!("static_cast<Pointer>({expression})"),
                };
            }
            format!(
                "using Pointer = unsigned *;
                __global__ void kernel(unsigned *output) {{
                    auto value = {expression}; output[0] = unsigned(!value);
                }}"
            )
        };
        roundtrip(&source(8));
        let error = rejected(&source(512));
        assert!(error.message.contains("limit"), "{mode}: {error}");
    }
}
