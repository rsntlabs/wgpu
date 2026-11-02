use naga::front::cuda::{parse_str, Options};
use naga::valid::ModuleInfo;

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/type-templates.cu");

fn options() -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 16,
    }
}

fn roundtrip(source: &str) -> (naga::Module, ModuleInfo) {
    let (module, info) = validate_with_options(source, &options());
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &options()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn calls(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut result = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            result.push(function);
        }
        false
    });
    result
}

#[test]
fn cuda_type_templates_normalize_value_types_aliases_and_specialization_keys() {
    let (module, _) = roundtrip(
        "using Number = unsigned;
        struct Record { float value; unsigned tag; };
        using RecordAlias = Record;
        template<typename Value> __device__ Value identity(Value value) { return value; }
        __global__ void kernel(unsigned *output) {
            output[0] = identity<unsigned>(7u);
            output[1] = identity<Number>(9u);
            output[2] = identity<unsigned int>(11u);
            float measurement = identity<float>(2.0f);
            bool enabled = identity<bool>(true);
            float2 pair = identity<float2>(make_float2(3.0f, 4.0f));
            Record record{5.0f, 13u};
            Record first = identity<Record>(record);
            Record second = identity<RecordAlias>(first);
            output[3] = unsigned(measurement + pair.x) + unsigned(enabled) + second.tag;
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 8);
    assert_eq!(targets[0], targets[1]);
    assert_eq!(targets[1], targets[2]);
    assert_eq!(targets[6], targets[7]);
    for target in targets {
        let function = &module.functions[target];
        assert_eq!(function.arguments.len(), 1);
        assert_eq!(
            function.result.as_ref().unwrap().ty,
            function.arguments[0].ty
        );
    }
}

#[test]
fn cuda_type_templates_substitute_return_types_locals_casts_and_source_qualifiers() {
    roundtrip(
        "template<class Result, typename Input> __device__ Result converted(Input value) {
            using Target = Result; Target result = Target(value); return result;
        }
        template<typename Value> __device__ Value copied(Value value) {
            Value local = value; return local;
        }
        __global__ void kernel(unsigned *output) {
            output[0] = unsigned(converted<int, float>(2.75f));
            output[1] = converted<unsigned, int>(9);
            output[2] = unsigned(converted<float, bool>(true));
            output[3] = copied<unsigned>(11u);
        }",
    );
    let (module, _) = roundtrip(
        "using Frozen = const unsigned;
        template<class Value> __device__ unsigned copied(Value value) {
            Value local = value; return unsigned(local);
        }
        __global__ void kernel(unsigned *output) {
            output[0] = copied<unsigned>(3u);
            output[1] = copied<const unsigned>(5u);
            output[2] = copied<Frozen>(7u);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 3);
    assert_ne!(targets[0], targets[1]);
    assert_eq!(targets[1], targets[2]);
    assert_eq!(
        module.functions[targets[0]].arguments[0].ty,
        module.functions[targets[1]].arguments[0].ty,
    );
    rejected(
        "template<class Value> __device__ Value changed(Value value) {
            Value local = value; local = Value(4); return local;
        }
        __global__ void kernel(unsigned *output) { output[0] = changed<const unsigned>(3u); }",
    );
}

#[test]
fn cuda_type_templates_keep_pointer_reference_qualifiers_and_group_forwarding() {
    roundtrip(
        "namespace cg = cooperative_groups;
        template<class Value> __device__ Value read(const Value *, unsigned);
        template<typename Value> __device__ void write(Value &destination, const Value &value) {
            destination = value;
        }
        template<class Group> __device__ void synchronize(Group group) { group.sync(); }
        template<typename Value> __device__ Value relay(Value *values, cg::thread_block group, unsigned lane) {
            Value value = read<Value>(values, lane);
            write<Value>(values[lane], value);
            synchronize<cg::thread_block>(group);
            return values[lane] + Value(blockIdx.x);
        }
        __global__ void kernel(unsigned *output) {
            __shared__ unsigned values[4]; unsigned lane = threadIdx.x;
            values[lane] = lane; __syncthreads();
            output[lane] = relay<unsigned>(values, cg::this_thread_block(), lane);
        }
        template<typename Element> __device__ Element read(const Element *values, unsigned lane) {
            return values[lane];
        }",
    );
    roundtrip(
        "using ReadOnlyPointer = const unsigned *;
        template<class Pointer> __device__ unsigned pointed(Pointer value) { return *value; }
        __global__ void kernel(unsigned *output, const unsigned *input) {
            output[0] = pointed<ReadOnlyPointer>(input);
            output[1] = pointed<const unsigned *>(input);
            output[2] = pointed<unsigned *>(output);
            output[3] = pointed<unsigned *const>(output);
        }",
    );
}

#[test]
fn cuda_type_templates_mix_type_and_integral_parameters_without_runtime_arguments() {
    let (module, _) = roundtrip(
        "template<class Value, int Width, bool Enabled> __device__ Value bounded(Value value) {
            Value local[Width]; local[Width - 1] = value;
            return Enabled ? local[Width - 1] + Value(Width) : value;
        }
        template<int Offset, typename Value> __device__ Value shifted(Value value) {
            return value + Value(Offset);
        }
        __global__ void kernel(unsigned *output) {
            output[0] = bounded<unsigned, 3, true>(7u);
            output[1] = unsigned(bounded<float, 2, false>(11.0f));
            output[2] = unsigned(shifted<-2, int>(9));
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 3);
    for target in targets {
        assert_eq!(module.functions[target].arguments.len(), 1);
    }
}

#[test]
fn cuda_type_templates_keep_kernel_instance_order_names_and_parameter_interfaces() {
    let (module, info) = roundtrip(FIXTURE);
    let names: Vec<_> = module
        .entry_points
        .iter()
        .map(|entry| entry.name.as_str())
        .collect();
    assert_eq!(names, ["copy_typed<unsigned>", "copy_typed<float>"]);
    for (entry_index, scalar) in [naga::Scalar::U32, naga::Scalar::F32]
        .into_iter()
        .enumerate()
    {
        assert_eq!(module.entry_points[entry_index].workgroup_size, [4, 1, 1]);
        let mut resources: Vec<_> = module
            .global_variables
            .iter()
            .filter(|&(handle, global)| {
                global.binding.is_some() && !info.get_entry_point(entry_index)[handle].is_empty()
            })
            .collect();
        resources.sort_by_key(|(_, global)| global.binding.unwrap().binding);
        assert_eq!(resources.len(), 3);
        for (binding, &(handle, global)) in resources.iter().enumerate() {
            assert_eq!(
                global.binding,
                Some(naga::ResourceBinding {
                    group: 0,
                    binding: binding as u32
                })
            );
            assert!(info.get_entry_point(1 - entry_index)[handle].is_empty());
            if binding == 2 {
                assert_eq!(global.space, naga::AddressSpace::Uniform);
                let naga::TypeInner::Struct {
                    ref members,
                    span: 16,
                } = module.types[global.ty].inner
                else {
                    panic!("scalar kernel parameter");
                };
                assert_eq!(members.len(), 1);
                assert_eq!(members[0].offset, 0);
                assert_eq!(
                    module.types[members[0].ty].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            } else {
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: if binding == 0 {
                            naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                        } else {
                            naga::StorageAccess::LOAD
                        },
                    }
                );
                let naga::TypeInner::Array {
                    base,
                    size: naga::ArraySize::Dynamic,
                    stride: 4,
                } = module.types[global.ty].inner
                else {
                    panic!("typed kernel storage array");
                };
                assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            }
        }
    }
}

#[test]
fn cuda_type_templates_reject_invalid_substitutions_and_bound_source_replay() {
    for source in [
        "template<class Value> __device__ Value identity(Value value) { return value; } __global__ void kernel() { identity<3>(1); }",
        "template<int Count> __device__ int value() { return Count; } __global__ void kernel() { value<int>(); }",
        "template<class Value> __device__ Value identity(Value value) { return value; } __global__ void kernel() { identity<int, float>(1); }",
        "template<class Value> __device__ Value make() { return Value(1); } __global__ void kernel() { make<>(); }",
        "template<class Value, typename Value> __device__ int duplicate() { return 1; } __global__ void kernel() {}",
        "template<class Value> __device__ Value changed(Value value) { { int Value = 3; } return value; } __global__ void kernel() { changed<int>(1); }",
        "template<class Value> __device__ Value read(Value *values) { return values[0]; } __global__ void kernel(const unsigned *input) { read<unsigned>(input); }",
        "template<class Value> __device__ Value identity(Value value) { return value; } __global__ void kernel(int runtime) { identity<runtime>(1); }",
        "template<class Value> __device__ Value identity(Value); __global__ void kernel() { identity<int>(1); }",
        "template<class Value> __device__ Value malformed(Value value) { return (value; } __global__ void kernel() {}",
        "template<class Value = int> __device__ Value value() { return Value(1); } __global__ void kernel() {}",
        "template<class... Values> __device__ int value() { return 1; } __global__ void kernel() {}",
        "template<class Value> struct Record { Value value; }; __global__ void kernel() {}",
        "template<class Value> __device__ Value value(Value &&input) { return input; } __global__ void kernel() { value<int>(1); }",
        "template<class Value> __device__ Value value(Value input) { return value<Value>(input); } __global__ void kernel() { value<int>(1); }",
        "template<class Value> __global__ void kernel(Value *output) { output[0] = Value(1); } template __global__ void kernel<unsigned>(float *);",
        "using Number = unsigned; template<class Value> __global__ void kernel(Value *output) { output[0] = Value(1); } template __global__ void kernel<unsigned>(unsigned *); template __global__ void kernel<Number>(unsigned *);",
    ] {
        rejected(source);
    }
    let growth = "template<class Value, unsigned Count> __device__ Value next(Value value) { return next<Value, Count + 1u>(value); } __global__ void kernel() { next<int, 0u>(1); }";
    let error = rejected(growth);
    assert!(error.message.contains("limit"), "{error}");
    let nested = format!("template<class Value> __device__ Value identity(Value value) {{ return value; }} __global__ void kernel() {{ {} }}", "identity<int>(".repeat(512) + "1" + &")".repeat(512) + ";");
    rejected(&nested);
}

#[test]
fn cuda_type_templates_skip_unmatched_pointer_candidates_before_lowering() {
    roundtrip(
        "template<class Value> __device__ unsigned selected(Value *value) { return 1u; }
        template<class Value> __device__ unsigned selected(Value value) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected<unsigned *>(output); }",
    );
}

#[test]
fn cuda_type_templates_skip_pointer_references_for_scalar_arguments() {
    roundtrip(
        "template<class Value> __device__ unsigned selected(Value &value) { return 1u; }
        template<class Value> __device__ unsigned selected(unsigned value) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected<unsigned *>(3u); }",
    );
}

#[test]
fn cuda_type_templates_skip_mutable_pointer_references_for_temporaries() {
    roundtrip(
        "template<class Value> __device__ unsigned selected(Value &value) { return 1u; }
        template<class Value> __device__ unsigned selected(Value value) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected<unsigned *>(output + 1u); }",
    );
}

#[test]
fn cuda_type_templates_rank_candidates_before_lowering_return_types() {
    roundtrip(
        "template<class Value> __device__ Value selected(float value) { return Value(0); }
        template<class Value> __device__ unsigned selected(unsigned value) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected<unsigned *>(3u); }",
    );
}

#[test]
fn cuda_type_templates_diagnose_the_selected_unsupported_return() {
    let error = rejected(
        "template<class Value> __device__ Value selected(unsigned value) { return Value(0); }
        template<class Value> __device__ unsigned selected(float value) { return 2u; }
        __global__ void kernel() { selected<unsigned *>(3u); }",
    );
    assert!(error.message.contains("pointer"), "{error}");
}

#[test]
fn cuda_type_templates_do_not_treat_computed_or_named_zero_as_null_pointer_constants() {
    for (declaration, expression) in [
        ("constexpr unsigned zero = 0u;", "zero"),
        ("", "int(0)"),
        ("", "1 - 1"),
        ("", "+0"),
        ("", "false"),
    ] {
        roundtrip(&format!(
            "template<class Pointer> __device__ unsigned selected(const Pointer &) {{ return 1u; }}
            template<class Pointer> __device__ unsigned selected(dim3 value) {{ return 2u; }}
            __global__ void kernel(unsigned *output) {{
                {declaration}
                output[0] = selected<unsigned *>({expression});
            }}"
        ));
    }
}

#[test]
fn cuda_type_templates_keep_literal_zero_pointer_reference_candidates_viable() {
    for (prefix, expression) in [("", "0"), ("", "((0u))"), ("#define ZERO 0\n", "ZERO")] {
        let source = format!(
            "{prefix}
            template<class Pointer> __device__ unsigned selected(const Pointer &) {{ return 1u; }}
            template<class Pointer> __device__ unsigned selected(dim3 value) {{ return 2u; }}
            __global__ void kernel(unsigned *output) {{ output[0] = selected<unsigned *>({expression}); }}"
        );
        let error = rejected(&source);
        assert!(
            error.message.contains("pointer reference"),
            "{source}: {error}"
        );
    }
}

#[test]
fn cuda_type_templates_deduce_values_without_arithmetic_common_types() {
    let (module, _) = roundtrip(
        "template<class Value> __device__ Value identity(Value value) { return value; }
        template<class Value> __device__ Value sum(Value first, Value second) { return first + second; }
        template<class Result, class Input> __device__ Result converted(Input value) { return Result(value); }
        __global__ void kernel(unsigned *output) {
            const unsigned frozen = 3u;
            output[0] = identity(frozen);
            output[1] = identity<unsigned>(7u);
            output[2] = identity<>(9u);
            output[3] = sum<unsigned>(1, 2u);
            output[4] = unsigned(converted<int>(2.75f));
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 5);
    assert_eq!(targets[0], targets[1]);
    assert_eq!(targets[1], targets[2]);
    rejected("template<class Value> __device__ Value sum(Value first, Value second) { return first + second; } __global__ void kernel() { sum(1, 2u); }");
}

#[test]
fn cuda_type_templates_deduce_pointer_and_reference_qualifiers_and_array_decay() {
    roundtrip(
        "template<class Value> __device__ Value read(Value *values) { return values[0]; }
        template<class Value> __device__ unsigned view(Value &value) { return unsigned(value); }
        template<class Value> __device__ Value frozen(const Value &value) { return value; }
        template<class Pointer> __device__ unsigned first(Pointer pointer) { return *pointer; }
        template<class Value> __device__ Value adjusted_array(Value values[]) { return values[0]; }
        __global__ void kernel(unsigned *output, const unsigned *input) {
            unsigned local[2]{3u, 5u}; const unsigned immutable = 7u;
            output[0] = read(input);
            output[1] = view(immutable);
            output[2] = frozen(immutable);
            output[3] = first(local);
            output[4] = adjusted_array(local);
        }",
    );
    rejected("template<class Value> __device__ unsigned consistent(Value &, Value &) { return 1u; } __global__ void kernel() { unsigned first = 1u; const unsigned second = 2u; consistent(first, second); }");
    rejected("template<class Value> __device__ void changed(Value *value) { *value = Value(4); } __global__ void kernel(const unsigned *input) { changed(input); }");
}

#[test]
fn cuda_type_templates_join_ordinary_overloads_and_preserve_explicit_selection() {
    let (module, _) = roundtrip(
        "__device__ unsigned selected(unsigned value) { return value + 100u; }
        template<class Value> __device__ unsigned selected(Value value) { return unsigned(value) + 200u; }
        template<class Value> __device__ unsigned __clz(Value value) { return unsigned(value) + 300u; }
        __global__ void kernel(unsigned *output) {
            output[0] = selected(3u);
            output[1] = selected<unsigned>(5u);
            output[2] = selected<>(7u);
            output[3] = selected(9);
            output[4] = __clz<unsigned>(11u);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 5);
    assert_ne!(targets[0], targets[1]);
    assert_eq!(targets[1], targets[2]);
    assert_ne!(targets[1], targets[3]);
    rejected("template<class Value> __device__ unsigned __clz(Value value) { return unsigned(value); } __global__ void kernel(unsigned *output) { unsigned __clz = 3u; output[0] = __clz(7u); }");
}

#[test]
fn cuda_type_templates_order_pointer_patterns_without_ordering_value_reference_ties() {
    let (module, _) = roundtrip(
        "template<class Value> __device__ unsigned selected(Value value) { return 1u; }
        template<class Value> __device__ unsigned selected(Value *value) { return 2u; }
        template<class Value> __device__ unsigned selected(const Value *value) { return 3u; }
        __global__ void kernel(unsigned *output, const unsigned *input) {
            output[0] = selected(output); output[1] = selected(input);
        }",
    );
    assert_eq!(module.entry_points.len(), 1);
    rejected("template<class Value> __device__ unsigned selected(Value value) { return 1u; } template<class Value> __device__ unsigned selected(Value &value) { return 2u; } __global__ void kernel() { unsigned input = 3u; selected(input); }");
}

#[test]
fn cuda_type_templates_compare_symbolic_parameter_and_return_patterns() {
    let (module, _) = roundtrip(
        "template<class Value> __device__ unsigned selected(Value value) { return 1u; }
        template<class Value> __device__ unsigned selected(int value) { return 2u; }
        __global__ void kernel(unsigned *output) {
            output[0] = selected<float>(3); output[1] = selected<float>(5.0f);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 2);
    assert_ne!(targets[0], targets[1]);
    roundtrip("template<class Value> __device__ Value returned(Value value) { return value; } template<class Value> __device__ int returned(Value value) { return 2; } __global__ void kernel() {}");
    rejected("template<class Value> __device__ Value returned(Value value) { return value; } template<class Value> __device__ int returned(Value value) { return 2; } __global__ void kernel() { returned<int>(3); }");
}

#[test]
fn cuda_type_templates_keep_crossed_ordinary_and_template_conversions_ambiguous() {
    let error = rejected(
        "__device__ unsigned selected(int first, float second) { return 1u; }
        template<class Value> __device__ unsigned selected(float first, Value second) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected(3, 5); }",
    );
    assert!(error.message.contains("ambiguous"), "{error}");
}

#[test]
fn cuda_type_templates_keep_crossed_template_conversions_ambiguous() {
    let error = rejected(
        "template<class Value> __device__ unsigned selected(Value first, float second) { return 1u; }
        template<class Value> __device__ unsigned selected(float first, Value second) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = selected(3, 5); }",
    );
    assert!(error.message.contains("ambiguous"), "{error}");
}

#[test]
fn cuda_type_templates_order_repeated_type_constraints() {
    let (module, _) = roundtrip(
        "template<class Value> __device__ unsigned selected(Value first, Value second) { return 1u; }
        template<class First, class Second> __device__ unsigned selected(First first, Second second) { return 2u; }
        __global__ void kernel(unsigned *output) {
            output[0] = selected(3u, 5u);
            output[1] = selected(3u, 5.0f);
            output[2] = selected<unsigned>(7u, 9u);
            output[3] = selected<unsigned, float>(11u, 13u);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 4);
    assert_eq!(targets[0], targets[2]);
    assert_eq!(targets[1], targets[3]);
    assert_ne!(targets[0], targets[1]);
    for (target, expected) in targets.into_iter().zip([1u32, 2, 1, 2]) {
        let function = &module.functions[target];
        let naga::Statement::Return { value: Some(value) } = function.body.last().unwrap() else {
            panic!("constant overload result");
        };
        let naga::Expression::Literal(naga::Literal::U32(actual)) = function.expressions[*value]
        else {
            panic!("constant overload result");
        };
        assert_eq!(actual, expected);
    }
}

#[test]
fn cuda_type_templates_keep_explicit_bindings_while_deducing_remaining_parameters() {
    roundtrip(
        "template<class First, class Second> __device__ unsigned converted(First first, First second, Second third) {
            return unsigned(first) + unsigned(second) + unsigned(third);
        }
        template<class First, class Second> __device__ unsigned consistent(First first, Second second, Second third) {
            return unsigned(first) + unsigned(second) + unsigned(third);
        }
        template<int Offset, class Value> __device__ Value shifted(Value value) { return value + Value(Offset); }
        template<class Value, int Width, class Other> __device__ Value mixed(Value first, Other second) {
            return first + Value(second) + Value(Width);
        }
        __global__ void kernel(unsigned *output) {
            output[0] = converted<int>(1u, 2.75f, 7u);
            output[1] = consistent<int, unsigned>(1, 2u, 3.0f);
            output[2] = shifted<3>(7u);
            output[3] = mixed<unsigned, 4>(1u, 2.5f);
        }",
    );
    rejected(
        "template<class First, class Second> __device__ unsigned consistent(First, Second, Second) { return 1u; }
        __global__ void kernel(unsigned *output) { output[0] = consistent<int>(1, 2u, 3.0f); }",
    );
}

#[test]
fn cuda_type_templates_preserve_ordinary_fallback_when_deduction_fails() {
    roundtrip(
        "__device__ unsigned selected(float value) { return 7u; }
        template<class Value> __device__ unsigned selected(Value *, Value *) { return 9u; }
        __global__ void kernel(unsigned *output) { output[0] = selected(3u); }",
    );
    rejected(
        "__device__ unsigned selected(unsigned value) { return 7u; }
        template<class Value> __device__ unsigned selected(unsigned value) { return 9u; }
        __global__ void kernel(unsigned *output) { output[0] = selected<>(3u); }",
    );
}

#[test]
fn cuda_type_templates_preserve_builtin_fallback_without_bypassing_explicit_template_ids() {
    let (module, _) = roundtrip(
        "template<class Value> __device__ unsigned __clz(Value *) { return 9u; }
        __global__ void kernel(unsigned *output) { output[0] = __clz(7u); }",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .any(|(_, expression)| {
            matches!(
                expression,
                naga::Expression::Math {
                    fun: naga::MathFunction::CountLeadingZeros,
                    ..
                }
            )
        }));
    rejected(
        "template<class Value> __device__ unsigned __clz(unsigned value) { return 9u; }
        __global__ void kernel(unsigned *output) { output[0] = __clz<>(7u); }",
    );
}

#[test]
fn cuda_type_templates_prefer_ordinary_value_reference_conversion_ties() {
    let (module, _) = roundtrip(
        "__device__ unsigned selected(int value) { return 1u; }
        template<class Value> __device__ unsigned selected(const Value &value) { return 2u; }
        __device__ unsigned other(const int &value) { return 3u; }
        template<class Value> __device__ unsigned other(Value value) { return 4u; }
        __global__ void kernel(unsigned *output) {
            output[0] = selected(3); output[1] = other(5);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 1);
    let function = &module.functions[targets[0]];
    let naga::Statement::Return { value: Some(value) } = function.body.last().unwrap() else {
        panic!("ordinary by-value overload result");
    };
    assert!(matches!(
        function.expressions[*value],
        naga::Expression::Literal(naga::Literal::U32(1))
    ));
}

#[test]
fn cuda_type_templates_do_not_deduce_arrays_from_pointer_address_origins() {
    for expression in ["+values", "values + 0"] {
        roundtrip(&format!(
            "__device__ unsigned selected(unsigned *values) {{ return 2u; }}
            template<class Value> __device__ unsigned selected(const Value &value) {{ return 1u; }}
            __global__ void kernel(unsigned *output) {{
                unsigned values[2]{{3u, 5u}};
                output[0] = selected({expression});
            }}"
        ));
    }
}

#[test]
fn cuda_type_templates_keep_ordinary_array_overloads_before_unsupported_reference_deduction() {
    roundtrip(
        "__device__ unsigned selected(unsigned *values) { return 2u; }
        template<class Value> __device__ unsigned selected(const Value &value) { return 1u; }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{3u, 5u}; output[0] = selected(values);
        }",
    );
}

#[test]
fn cuda_type_templates_diagnose_selected_array_reference_deduction() {
    let error = rejected(
        "template<class Value> __device__ unsigned selected(const Value &value) { return 1u; }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{3u, 5u}; output[0] = selected(values);
        }",
    );
    assert!(
        error.message.contains("array") && error.message.contains("reference"),
        "{error}"
    );
}

#[test]
fn cuda_type_templates_strip_only_qualifiers_written_on_reference_patterns() {
    roundtrip(
        "template<class Value> __device__ unsigned same(const Value &first, const Value &second) {
            return unsigned(first) + unsigned(second);
        }
        __global__ void kernel(unsigned *output) {
            unsigned first = 3u; const unsigned second = 5u;
            output[0] = same(first, second);
        }",
    );
    roundtrip(
        "template<class Value> __device__ unsigned same(const volatile Value &first, const volatile Value &second) {
            return 1u;
        }
        __global__ void kernel(unsigned *output, volatile unsigned *first, const unsigned *second) {
            output[0] = same(*first, *second);
        }",
    );
    rejected(
        "template<class Value> __device__ unsigned same(volatile Value &first, volatile Value &second) { return 1u; }
        __global__ void kernel(unsigned *output, const volatile unsigned *first, volatile unsigned *second) {
            output[0] = same(*first, *second);
        }",
    );
}

#[test]
fn cuda_type_templates_bound_nested_deduced_calls_without_losing_instance_reuse() {
    let source = |depth| {
        format!(
            "template<class Value> __device__ Value identity(Value value) {{ return value; }}
            __global__ void kernel(unsigned *output) {{ output[0] = {}3u{}; }}",
            "identity(".repeat(depth),
            ")".repeat(depth),
        )
    };
    let (module, _) = roundtrip(&source(8));
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 8);
    assert!(targets.iter().all(|&target| target == targets[0]));
    let error = rejected(&source(512));
    assert!(
        error.message.contains("limit") || error.message.contains("nesting"),
        "{error}"
    );
}
