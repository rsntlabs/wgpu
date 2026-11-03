use super::helpers::validate;

const COMPOUND_OPERATORS: &[&str] = &["+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>="];

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

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = naga::front::cuda::parse_str(source, &Default::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() || range.start == source.len(), "{error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

#[test]
fn cuda_operator_assignments_accept_all_ten_mutating_void_record_helpers() {
    for operator in COMPOUND_OPERATORS {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }};
            __device__ void operator{operator}(Record &left, unsigned right) {{
                left.value {operator} right;
            }}
            __global__ void kernel(unsigned *output) {{
                Record value{{32u}};
                value {operator} 2u;
                output[0] = value.value;
            }}"
        ));
    }
}

#[test]
fn cuda_operator_assignments_accept_scalar_left_operands_with_class_right_and_value_results() {
    let module = roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned operator+=(unsigned left, Record right) {
            return left + right.value;
        }
        __global__ void kernel(unsigned *output) {
            unsigned original = 3u;
            unsigned result = (original += Record{5u});
            output[0] = result;
            output[1] = original;
        }",
    );
    let (_, helper) = module
        .functions
        .iter()
        .find(|(_, function)| function.name.as_deref() == Some("operator+="))
        .unwrap();
    assert_eq!(helper.arguments.len(), 2);
    assert_eq!(
        module.types[helper.arguments[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
    assert!(matches!(
        module.types[helper.arguments[1].ty].inner,
        naga::TypeInner::Struct { .. }
    ));
    assert_eq!(
        module.types[helper.result.as_ref().unwrap().ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U32)
    );
}

#[test]
fn cuda_operator_assignments_accept_vector_parameters_and_arbitrary_supported_results() {
    for ty in [
        "float2", "float3", "float4", "int2", "int3", "int4", "uint2", "uint3", "uint4",
    ] {
        roundtrip(&format!(
            "__device__ void operator+=({ty} &left, {ty} right) {{ left.x += right.x; }}
            __global__ void kernel(int *output) {{
                {ty} left{{}}, right{{}}; left += right; output[0] = int(left.x);
            }}"
        ));
    }
    for operator in COMPOUND_OPERATORS {
        for (result_type, body) in [
            ("void", ""),
            ("unsigned", "return left.value;"),
            ("float", "return right;"),
            ("bool", "return left.value != 0u;"),
            ("float2", "return make_float2(right, right);"),
            ("Record", "return Record{left.value};"),
        ] {
            roundtrip(&format!(
                "struct Record {{ unsigned value; }};
                __device__ {result_type} operator{operator}(Record left, float right) {{ {body} }}
                __global__ void kernel() {{ Record value{{3u}}; value {operator} 2.0f; }}"
            ));
        }
    }
}

#[test]
fn cuda_operator_assignments_use_source_signatures_for_const_and_prvalue_left_operands() {
    roundtrip(
        "struct Record { unsigned value; };
        __device__ Record operator*=(const Record &left, unsigned right) {
            return Record{left.value * right};
        }
        __device__ void operator-=(const Record &left, unsigned right) {}
        __global__ void kernel(unsigned *output) {
            const Record original{3u};
            Record first = (original *= 2u);
            Record second = (Record{5u} *= 2u);
            original -= 1u; Record{7u} -= 1u;
            output[0] = first.value + second.value + original.value;
        }",
    );
    roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned operator+=(Record value, unsigned amount) { value.value += amount; return value.value; }
        __global__ void kernel(unsigned *output) {
            const Record original{3u};
            output[0] = (original += 5u);
            output[1] = (Record{7u} += 11u);
            output[2] = original.value;
        }",
    );
    for operand in ["fixed", "Record{7u}"] {
        rejected(&format!(
            "struct Record {{ unsigned value; }};
            __device__ void operator+=(Record &left, unsigned right) {{ left.value += right; }}
            __global__ void kernel() {{ const Record fixed{{3u}}; {operand} += 5u; }}"
        ));
    }
}

#[test]
fn cuda_operator_assignments_reuse_overload_ranking_aliases_and_later_definitions() {
    let module = roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned operator+=(Record left, bool right) { return 1u; }
        __device__ unsigned operator+=(Record left, int right) { return 2u; }
        __device__ unsigned operator+=(Record left, unsigned right) { return 3u; }
        __device__ unsigned operator+=(Record left, float right) { return 4u; }
        __global__ void kernel(unsigned *output) {
            Record value{5u};
            output[0] = (value += true); output[1] = (value += 3);
            output[2] = (value += 3u); output[3] = (value += 3.0f);
        }",
    );
    let mut parameters = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let function = &module.functions[function];
            if function.name.as_deref() == Some("operator+=") {
                parameters.push(function.arguments[1].ty);
            }
        }
        false
    });
    assert_eq!(parameters.len(), 4);
    for (parameter, scalar) in parameters.into_iter().zip([
        naga::Scalar::BOOL,
        naga::Scalar::I32,
        naga::Scalar::U32,
        naga::Scalar::F32,
    ]) {
        assert_eq!(
            module.types[parameter].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    for header in [
        "__device__",
        "static __device__ inline",
        "__host__ __device__",
        "__forceinline__ __device__",
        "__noinline__ __device__",
    ] {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }}; using Alias = Record;
            {header} unsigned operator+=(Alias &, unsigned);
            __global__ void kernel(unsigned *output) {{ Record value{{3u}}; output[0] = (value += 5u); }}
            {header} unsigned operator+=(Record &left, const unsigned right) {{ left.value += right; return left.value; }}"
        ));
    }
}

#[test]
fn cuda_operator_assignments_notation_prepares_right_values_and_addresses_before_left_effects() {
    for right_parameter in ["Record right", "const Record &right"] {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }};
            __device__ Record replace(Record &value, unsigned &index) {{ value.value = 9u; index = 1u; return value; }}
            __device__ unsigned operator+=(Record left, {right_parameter}) {{ return left.value * 100u + right.value; }}
            __global__ void kernel(unsigned *output) {{
                Record values[2]{{{{3u}}, {{5u}}}}; unsigned index = 0u;
                output[0] = (replace(values[0], index) += values[index]);
                output[1] = values[0].value; output[2] = index;
            }}"
        ));
    }
    roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned right_operand(unsigned &index) { ++index; return 5u; }
        __device__ void operator+=(Record &left, unsigned right) { left.value += right; }
        __global__ void kernel(unsigned *output) {
            Record values[2]{{10u}, {20u}}; unsigned index = 0u;
            values[index++] += right_operand(index);
            output[0] = values[0].value; output[1] = values[1].value; output[2] = index;
        }",
    );
}

#[test]
fn cuda_operator_assignments_explicit_calls_use_shared_argument_capture_and_operator_ids() {
    for spelling in ["operator+=", "operator +=", "operator /* λ */ +="] {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }};
            __device__ Record replace(Record &value) {{ value.value = 9u; return value; }}
            __device__ unsigned {spelling}(Record left, Record right) {{ return left.value * 100u + right.value; }}
            __global__ void kernel(unsigned *output) {{
                Record value{{3u}};
                output[0] = {spelling}(replace(value), value);
                output[1] = value.value;
            }}"
        ));
    }
    for operator in COMPOUND_OPERATORS {
        roundtrip(&format!(
            "struct Record {{ unsigned value; }};
            __device__ unsigned operator{operator}(Record left, unsigned right) {{ return left.value + right; }}
            __global__ void kernel(unsigned *output) {{ output[0] = operator{operator}(Record{{3u}}, 5u); }}"
        ));
    }
}

#[test]
fn cuda_operator_assignments_pointer_and_erased_null_operands_keep_logical_parameter_modes() {
    roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned operator+=(unsigned *left, Record right) { return left[0] + right.value; }
        __device__ unsigned operator+=(decltype(nullptr) left, Record &right) { right.value += 1u; return right.value; }
        __device__ unsigned operator-=(Record &left, decltype(nullptr) right) { left.value += 1u; return left.value; }
        __device__ unsigned operator*=(Record left, const unsigned *right) { return left.value + right[0]; }
        __global__ void kernel(unsigned *output) {
            unsigned source[2]{3u, 5u}; unsigned *pointer = source;
            Record value{7u};
            output[0] = (pointer += Record{11u});
            output[1] = (nullptr += value);
            output[2] = (value -= nullptr);
            output[3] = (value *= source + 1);
            output[4] = value.value;
        }",
    );
    for operand in ["0", "0u", "((0))", "nullptr"] {
        let error = rejected(&format!(
            "struct Record {{ unsigned value; }};
            __device__ unsigned operator+=(unsigned *left, Record right) {{ return 1u; }}
            __device__ unsigned operator+=(float *left, Record right) {{ return 2u; }}
            __global__ void kernel() {{ {operand} += Record{{3u}}; }}"
        ));
        assert!(error.message.contains("ambiguous"), "{error}");
    }
    roundtrip(
        "struct Record { unsigned value; };
        __device__ unsigned operator+=(unsigned *left, Record right) { return 1u; }
        __device__ unsigned operator+=(dim3 left, Record right) { return 2u; }
        __global__ void kernel(unsigned *output) { output[0] = (unsigned(0) += Record{3u}); }",
    );
}

#[test]
fn cuda_operator_assignments_void_lazy_and_nested_results_follow_expression_contexts() {
    roundtrip(
        "struct Record { unsigned value; };
        __device__ void operator+=(Record &left, unsigned right) { left.value += right; }
        __device__ void update(Record &value) { return value += 2u; }
        __global__ void kernel(unsigned *output, unsigned selector) {
            Record value{3u};
            selector ? (value += 5u) : (value += 7u);
            (value += 11u, output[0] = value.value);
            update(value); output[1] = value.value;
        }",
    );
    roundtrip(
        "struct Record { unsigned value; };
        __device__ bool operator+=(Record &left, unsigned right) { left.value += right; return true; }
        __global__ void kernel(unsigned *output) {
            Record value{3u};
            bool first = false && (value += 5u);
            bool second = true || (value += 7u);
            output[0] = first; output[1] = second; output[2] = value.value;
        }",
    );
    roundtrip(
        "struct Record { unsigned value; };
        __device__ Record operator+=(Record &left, Record right) { left.value += right.value; return left; }
        __global__ void kernel(unsigned *output) {
            Record first{1u}, second{2u}, third{3u};
            Record result = (first += second += third);
            output[0] = result.value; output[1] = first.value; output[2] = second.value;
        }",
    );
}

#[test]
fn cuda_operator_assignments_source_readonly_objects_can_be_copied_and_actual_writes_reject() {
    let module = roundtrip(
        "struct Record { unsigned value; };
        __constant__ Record fixed;
        __device__ Record operator+=(Record left, unsigned right) { left.value += right; return left; }
        __global__ void kernel(Record *output) { output[0] = (fixed += 5u); }",
    );
    let (_, fixed) = module
        .global_variables
        .iter()
        .find(|(_, global)| global.name.as_deref() == Some("fixed"))
        .unwrap();
    assert_eq!(
        fixed.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    for source in [
        "struct Record { unsigned value; }; __device__ void operator+=(Record &left, unsigned right) { left.value += right; } __global__ void kernel(const Record *input) { input[0] += 3u; }",
        "struct Record { unsigned value; }; __constant__ Record fixed; __device__ void operator+=(Record &left, unsigned right) { left.value += right; } __global__ void kernel() { fixed += 3u; }",
        "struct Record { unsigned value; }; __constant__ Record fixed; __device__ void operator+=(decltype(nullptr), Record &right) { right.value += 1u; } __global__ void kernel() { nullptr += fixed; }",
        "struct Record { unsigned value; }; __device__ void operator+=(Record &left, unsigned right) { left.value += right; } __global__ void kernel() { const Record fixed{3u}; return; fixed += 3u; }",
    ] {
        rejected(source);
    }
    for source in [
        "struct Record { unsigned value; }; __constant__ Record fixed; __device__ void operator+=(Record &left, unsigned right) { left.value += right; } __global__ void kernel() { return; fixed += 3u; }",
        "struct Record { unsigned value; }; __constant__ Record fixed; __device__ void update(Record &left, unsigned right) { left.value += right; } __global__ void kernel() { return; update(fixed, 3u); }",
    ] {
        let module = roundtrip(source);
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            assert!(!naga::proc::any_statement(&function.body, &mut |statement| {
                matches!(statement, naga::Statement::Store { .. } | naga::Statement::Atomic { .. })
            }));
        }
    }
}

#[test]
fn cuda_operator_assignments_leave_scalar_and_pointer_builtins_and_lvalue_results_available() {
    let module = roundtrip(
        "struct Record { unsigned value; };
        __device__ void operator+=(Record &left, unsigned right) { left.value += right; }
        __global__ void kernel(unsigned *output) {
            unsigned value = 3u;
            unsigned &reference = (value += 2u); reference += 5u;
            unsigned values[2]{7u, 11u}; unsigned *pointer = values;
            pointer += 1; *pointer += 3u;
            output[0] = value; output[1] = *pointer;
        }",
    );
    assert!(!naga::proc::any_statement(
        &module.entry_points[0].function.body,
        &mut |statement| {
            matches!(*statement, naga::Statement::Call { function, .. } if module.functions[function].name.as_deref() == Some("operator+="))
        }
    ));
}

#[test]
fn cuda_operator_assignments_reject_invalid_arities_scalar_only_and_pointer_only_class_signatures()
{
    for operator in COMPOUND_OPERATORS {
        for parameters in [
            "",
            "Record left",
            "Record left, unsigned first, unsigned second",
            "unsigned left, unsigned right",
            "Record *left, unsigned right",
        ] {
            rejected(&format!(
                "struct Record {{ unsigned value; }};
                __device__ unsigned operator{operator}({parameters}) {{ return 1u; }}
                __global__ void kernel() {{}}"
            ));
        }
    }
}

#[test]
fn cuda_operator_assignments_reject_duplicate_ambiguous_and_unsupported_result_signatures() {
    for source in [
        "struct Record { unsigned value; }; using Alias = Record; __device__ unsigned operator+=(Record left, unsigned right) { return 1u; } __device__ unsigned operator+=(const Alias left, const unsigned right) { return 2u; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned operator+=(Record left, unsigned right) { return 1u; } __device__ float operator+=(Record left, unsigned right) { return 2.0f; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned operator+=(Record left, unsigned right) { return 1u; } __device__ unsigned operator+=(const Record &left, unsigned right) { return 2u; } __global__ void kernel() { Record value{3u}; value += 5u; }",
        "struct Record { unsigned value; }; __device__ Record &operator+=(Record &left, unsigned right) { return left; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned *operator+=(unsigned *left, Record right) { return left; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ void operator+=(Record &left, unsigned right) {} __global__ void kernel() { Record value{3u}; unsigned result = (value += 5u); }",
        "struct Record { unsigned value; }; __device__ void operator+=(Record &left, unsigned right) {} __global__ void kernel() { Record value{3u}; bool result = false && (value += 5u); }",
        "struct First { unsigned value; }; struct Second { unsigned value; }; __device__ void operator+=(First &left, unsigned right) {} __global__ void kernel() { Second value{3u}; value += 5u; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_operator_assignments_preserve_operator_spans_and_existing_definition_and_depth_checks() {
    for operator in COMPOUND_OPERATORS {
        let source = format!(
            "/* λ */ struct Record {{ unsigned value; }};
            __device__ unsigned operator{operator}(Record left, unsigned right) {{ return 1u; }}
            __device__ float operator{operator}(Record left, unsigned right) {{ return 2.0f; }}
            __global__ void kernel() {{}}"
        );
        let error = rejected(&source);
        assert!(error.message.contains("duplicate"), "{error}");
        assert_eq!(
            &source[error.span.to_range().unwrap()],
            format!("operator{operator}")
        );
    }
    for source in [
        "struct Record { unsigned value; }; __device__ unsigned operator+=(Record left, unsigned right); __global__ void kernel(unsigned *output) { Record value{3u}; output[0] = (value += 5u); }",
        "struct Record { unsigned value; }; __device__ unsigned operator+=(Record left, unsigned right) { return left += right; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned operator + =(Record left, unsigned right) { return 1u; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned operator < < =(Record left, unsigned right) { return 1u; } __global__ void kernel() {}",
        "struct Record { unsigned value; }; __device__ unsigned operator+=(Record left, unsigned right) { return 1u; } __global__ void kernel() { constexpr unsigned value = (Record{3u} += 5u); }",
    ] {
        rejected(source);
    }
    for depth in [4, 128] {
        let mut expression = String::from("Record{1u}");
        for _ in 0..depth {
            expression = format!("(Record{{1u}} += {expression})");
        }
        let source = format!(
            "struct Record {{ unsigned value; }};
            __device__ Record operator+=(Record left, Record right) {{ return Record{{left.value + right.value}}; }}
            __global__ void kernel(unsigned *output) {{ Record value = {expression}; output[0] = value.value; }}"
        );
        if depth == 4 {
            roundtrip(&source);
        } else {
            rejected(&source);
        }
    }
}
