use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{root_expression, validate_with_options_and_capabilities};

fn queries(source: &str, expected: &[u64]) -> naga::Module {
    let capabilities = Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64;
    let (module, info) =
        validate_with_options_and_capabilities(source, &Options::default(), capabilities);
    let function = &module.entry_points[0].function;
    let mut actual = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            if matches!(
                function.expressions[root_expression(function, pointer)],
                naga::Expression::GlobalVariable(_)
            ) {
                let naga::Expression::Literal(naga::Literal::U64(value)) =
                    function.expressions[value]
                else {
                    panic!("expected folded source size");
                };
                actual.push(value);
            }
        }
        false
    });
    assert_eq!(actual, expected);
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

fn reject(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
}

#[test]
fn cuda_sizeof_binary_promotes_scalar_operands_and_preserves_source_widths() {
    queries("__global__ void kernel(unsigned long *out) {
        bool flag; short small; unsigned short narrow; int integer; unsigned word; long native; unsigned long unative; long long wide; float value;
        out[0] = sizeof(flag + flag); out[1] = sizeof(small + small); out[2] = sizeof(narrow + integer);
        out[3] = sizeof(integer + word); out[4] = sizeof(native + word); out[5] = sizeof(wide + unative);
        out[6] = sizeof(native + value); out[7] = sizeof(small << wide); out[8] = sizeof(word >> native);
        out[9] = sizeof(flag & flag); out[10] = sizeof(flag && flag); out[11] = sizeof(value < value);
        out[12] = sizeof(native == wide); out[13] = sizeof(word | narrow); out[14] = sizeof(small ^ narrow);
    }", &[4, 4, 4, 4, 8, 8, 4, 4, 4, 4, 1, 1, 1, 4, 4]);
}

#[test]
fn cuda_sizeof_binary_supports_all_builtin_scalar_operator_type_rules() {
    let operands = [
        "1 + 2",
        "1 - 2",
        "1 * 2",
        "1 / 2",
        "1 % 2",
        "1 << 2",
        "1 >> 2",
        "1 & 2",
        "1 | 2",
        "1 ^ 2",
        "1.0f + 2.0f",
        "1.0f / 2.0f",
        "1 < 2",
        "1 <= 2",
        "1 > 2",
        "1 >= 2",
        "1 == 2",
        "1 != 2",
        "1 && 2",
        "1 || 2",
    ];
    let assignments = operands
        .iter()
        .enumerate()
        .map(|(index, operand)| format!("out[{index}] = sizeof({operand});"))
        .collect::<Vec<_>>()
        .join("\n");
    let mut expected = vec![4; 12];
    expected.extend([1; 8]);
    queries(
        &format!("__global__ void kernel(unsigned long *out) {{ {assignments} }}"),
        &expected,
    );
}

#[test]
fn cuda_sizeof_binary_honors_precedence_grouping_and_unparenthesized_unary_binding() {
    queries(
        "__global__ void kernel(unsigned long *out) {
        short small;
        static_assert(sizeof small + 1 == 3);
        out[0] = sizeof(small + 1); out[1] = sizeof +small;
        out[2] = sizeof(1 + 2 < 3); out[3] = sizeof((1 < 2) + 3);
        out[4] = sizeof(1 | 2 == 3); out[5] = sizeof(1 < 2 && 3 < 4);
        out[6] = sizeof((1 + 2) * 3); out[7] = sizeof -(small + 1);
    }",
        &[4, 4, 1, 4, 4, 1, 4, 4],
    );
}

#[test]
fn cuda_sizeof_binary_never_evaluates_division_shifts_or_volatile_values() {
    let module = queries("__global__ void kernel(unsigned long *out, volatile int *input) {
        volatile int &left = input[0]; volatile int &right = input[1];
        out[0] = sizeof(1 / 0); out[1] = sizeof(1 << 99); out[2] = sizeof(0.0f / 0.0f);
        out[3] = sizeof(left + right); out[4] = sizeof(left / right); out[5] = sizeof(left && right);
    }", &[4, 4, 4, 4, 4, 1]);
    let baseline = queries(
        "__global__ void kernel(unsigned long *out, volatile int *input) {
        volatile int &left = input[0]; volatile int &right = input[1];
        out[0] = 4UL; out[1] = 4UL; out[2] = 4UL; out[3] = 4UL; out[4] = 4UL; out[5] = 1UL;
    }",
        &[4, 4, 4, 4, 4, 1],
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert_eq!(
        module.entry_points[0].function.expressions.len(),
        baseline.entry_points[0].function.expressions.len(),
        "type-only binary queries must not emit operand evaluation"
    );
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_binary_subscripts_keep_rows_members_and_integral_index_promotions() {
    queries("struct Record { float3 vector; int rows[2][3]; };
        __global__ void kernel(unsigned long *out) {
            int grid[2][3]; Record records[2]; Record *pointer; long index; short small;
            out[0] = sizeof(grid[index + 1]); out[1] = sizeof(grid[small + 1][index & 1]);
            out[2] = sizeof(records[index << 1].vector.z); out[3] = sizeof(records[index == 1].rows);
            out[4] = sizeof(grid[1 / 0][1 << 99]); out[5] = sizeof((index + 1)[grid]);
            out[6] = sizeof(pointer->vector.x + 1);
        }", &[12, 4, 4, 24, 4, 12, 4]);
}

#[test]
fn cuda_sizeof_binary_reuses_known_template_object_types_without_new_deduction() {
    let source = "template<class T> __device__ unsigned width(T value) { return unsigned(sizeof(value + value)); }
        template<class T> __device__ unsigned fixed(T unused, int value, unsigned bytes = unsigned(sizeof(value + 1))) { return bytes; }
        __global__ void kernel(unsigned *out) { out[0] = width(1.0f); out[1] = width(1L); out[2] = fixed(1.0f, 3); }";
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::SHADER_INT64);
    reject("template<class T> __device__ unsigned width(T value, unsigned bytes = unsigned(sizeof(value + 1))) { return bytes; } __global__ void kernel() {}");
}

#[test]
fn cuda_sizeof_binary_keeps_unsupported_expression_and_type_boundaries() {
    for operand in [
        "pointer + 1",
        "pointer == pointer",
        "vector + vector",
        "record + record",
        "value(1)",
        "int(1)",
        "helper() + 1",
        "value++ + 1",
        "value = 1",
        "value, 1",
        "value + sizeof(int)",
        "1.0 + value",
        "double",
        "value % 1.0f",
        "value << 1.0f",
        "pointer[value + 1.0f]",
        "missing + 1",
    ] {
        reject(&format!("// π UTF-8 prefix\nstruct Record {{ int value; }}; __device__ int helper() {{ return 1; }} __global__ void kernel(unsigned long *out) {{ int value; int *pointer; int2 vector; Record record; out[0] = sizeof({operand}); }}"));
    }
}

#[test]
fn cuda_sizeof_conditional_preserves_matching_types_and_combines_mixed_arms() {
    queries(
        "__global__ void kernel(unsigned long *out) {
        bool flag; short small; short other; int word; unsigned index; long wide;
        int grid[2][3];
        static_assert((sizeof small ? 7 : 9) == 7);
        out[0] = sizeof(flag ? true : false);
        out[1] = sizeof(flag ? small : other);
        out[2] = sizeof(flag ? small : word);
        out[3] = sizeof(flag ? index : wide);
        out[4] = sizeof(flag ? index : 1.0f);
        out[5] = sizeof(flag || word ? small : other);
        out[6] = sizeof(flag ? small : flag ? small : other);
        out[7] = sizeof(flag ? flag ? small : other : small);
        out[8] = sizeof(grid[flag ? index : word]);
        out[9] = sizeof(grid[flag ? index : word][flag ? small : other]);
        out[10] = sizeof(flag ? wide : flag ? small : other);
    }",
        &[1, 2, 4, 8, 4, 2, 2, 2, 12, 4, 8],
    );
}

#[test]
fn cuda_sizeof_conditional_never_evaluates_operands() {
    let module = queries(
        "__global__ void kernel(unsigned long *out, volatile int *input) {
        out[0] = sizeof(input[0] ? input[1] : input[2]);
        out[1] = sizeof(1 / 0 ? 1 << 99 : 1 / 0);
    }",
        &[4, 4],
    );
    let baseline = queries(
        "__global__ void kernel(unsigned long *out, volatile int *input) {
        out[0] = 4UL; out[1] = 4UL;
    }",
        &[4, 4],
    );
    let function = &module.entry_points[0].function;
    assert_eq!(
        function.expressions.len(),
        baseline.entry_points[0].function.expressions.len(),
    );
    assert!(function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(expression, naga::Expression::Load { .. })));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_pointer_conditions_keep_scalar_arm_types_without_reads() {
    let compile = |body| {
        queries(
            &format!(
                "__global__ void kernel(unsigned long *out, volatile int *input) {{
        int *pointer; auto null_object = nullptr;
        bool flag; short small; short other; int grid[2][3]; {body}
    }}"
            ),
            &[2, 1, 8, 4, 1, 12, 4, 2],
        )
    };
    let module = compile(
        "out[0] = sizeof(pointer ? small : other);
        out[1] = sizeof((pointer) ? flag : false);
        out[2] = sizeof(nullptr ? 1u : 2L);
        out[3] = sizeof(null_object ? 1.0f : 2);
        out[4] = sizeof(grid ? true : flag);
        out[5] = sizeof(grid[pointer ? 0 : 1u]);
        out[6] = sizeof(input ? *input : input[99]);
        out[7] = sizeof(input ? nullptr ? small : other : small);",
    );
    let baseline = compile(
        "out[0]=2UL; out[1]=1UL; out[2]=8UL; out[3]=4UL;
        out[4]=1UL; out[5]=12UL; out[6]=4UL; out[7]=2UL;",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .eq(baseline.entry_points[0].function.expressions.iter()));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_pointer_conditions_accept_incomplete_arrays_without_launch_storage() {
    let module = queries(
        "extern __shared__ int scratch[];
        __global__ void kernel(unsigned long *out) {
            out[0] = sizeof(scratch ? scratch[99] : 1u);
            out[1] = sizeof(scratch ? true : false);
        }",
        &[4, 1],
    );
    assert_eq!(module.global_variables.len(), 1);
}

#[test]
fn cuda_sizeof_pointer_arms_preserve_layouts_without_evaluation() {
    let compile = |body| {
        queries(
            &format!(
                "using Row = int[3]; struct Record {{ int values[3]; }};
        __global__ void kernel(unsigned long *out, volatile int *input) {{
            bool flag; auto empty = nullptr; Row *row; Record *record;
            {body}
        }}"
            ),
            &[8, 4, 12, 12, 8, 4, 1],
        )
    };
    let module = compile(
        "out[0] = sizeof(flag ? input : nullptr);
        out[1] = sizeof(*(flag ? empty : input));
        out[2] = sizeof((flag ? row : empty)[99]);
        out[3] = sizeof((flag ? nullptr : record)->values);
        out[4] = sizeof(flag ? nullptr : empty);
        out[5] = sizeof(*(flag ? flag ? input : nullptr : empty));
        out[6] = sizeof((flag ? nullptr : input) ? true : false);",
    );
    let baseline = compile(
        "out[0] = 8UL; out[1] = 4UL; out[2] = 12UL; out[3] = 12UL;
        out[4] = 8UL; out[5] = 4UL; out[6] = 1UL;",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .eq(baseline.entry_points[0].function.expressions.iter()));
    assert!(module
        .global_variables
        .iter()
        .all(|(_, global)| global.memory_decorations.is_empty()));
}

#[test]
fn cuda_sizeof_pointer_arms_preserve_incomplete_pointee_checks() {
    queries(
        "using Values = int[];
        __global__ void kernel(unsigned long *out, Values *view) {
            out[0] = sizeof(true ? view : nullptr);
            out[1] = sizeof((*(true ? nullptr : view))[0]);
            out[2] = sizeof(true ? view : view);
            out[3] = sizeof((*(true ? view : view))[0]);
        }",
        &[8, 4, 8, 4],
    );
    for operand in [
        "*(true ? view : nullptr)",
        "(true ? nullptr : view)[0]",
        "*(true ? view : view)",
    ] {
        let source = format!(
            "using Values = int[];
            __global__ void kernel(unsigned long *out, Values *view) {{
                out[0] = sizeof({operand});
            }}"
        );
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert!(error.message.contains("complete"), "{error}");
    }
}

#[test]
fn cuda_sizeof_pointer_pairs_preserve_source_layouts_without_evaluation() {
    let compile = |body| {
        queries(
            &format!(
                "using Alias = int; using Row = int[3]; struct Record {{ int values[3]; }};
        __global__ void kernel(unsigned long *out, volatile int *input, const Alias *other) {{
            bool flag; Row *row; const Row *other_row; Record *record; const Record *other_record;
            {body}
        }}"
            ),
            &[8, 4, 12, 12, 4, 4],
        )
    };
    let module = compile(
        "out[0] = sizeof(flag ? input : other);
        out[1] = sizeof(*(flag ? other : input));
        out[2] = sizeof((flag ? row : other_row)[99]);
        out[3] = sizeof((flag ? record : other_record)->values);
        out[4] = sizeof(*(flag ? flag ? input : nullptr : other));
        out[5] = sizeof((flag ? input : other)[flag ? 0 : 1]);",
    );
    let baseline = compile(
        "out[0] = 8UL; out[1] = 4UL; out[2] = 12UL;
        out[3] = 12UL; out[4] = 4UL; out[5] = 4UL;",
    );
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .eq(baseline.entry_points[0].function.expressions.iter()));
}

#[test]
fn cuda_sizeof_pointer_pairs_reject_distinct_pointee_types() {
    for (left, right) in [
        ("int", "float"),
        ("int", "unsigned"),
        ("long", "long long"),
        ("Row", "OtherRow"),
        ("Record", "OtherRecord"),
    ] {
        let source = format!(
            "using Row = int[3]; using OtherRow = int[4];
            struct Record {{ int value; }}; struct OtherRecord {{ int value; }};
            __global__ void kernel(unsigned long *out) {{
                {left} *left; {right} *right;
                out[0] = sizeof(true ? left : right);
            }}"
        );
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert!(
            error.message.contains("sizeof conditional requires"),
            "{source}: {error}"
        );
    }
}

#[test]
fn cuda_sizeof_conditional_checks_both_arms_and_keeps_unsupported_boundaries() {
    for operand in [
        "record ? value : 1",
        "vector ? value : 1",
        "&value ? value : 1",
        "pointer ? value : missing",
        "nullptr ? pointer : value",
        "values ? value : nullptr",
        "true ? value : pointer",
        "true ? pointer : value",
        "true ? value : vector",
        "true ? value : record",
        "true ? value : values",
        "true ? value : nullptr",
        "true ? pointer : 0",
        "true ? pointer : false",
        "true ? values : nullptr",
        "true ? values : values",
        "*(true ? nullptr : nullptr)",
        "(true ? nullptr : nullptr)[0]",
        "true ? value : missing",
        "true ? value : (1.0f % 2)",
        "values[true ? 1 : 2.0f]",
        "true ? value++, value : 1",
        "true ? value, 1 : 2",
        "true ? value : (value = 1)",
        "true ? value",
        "true ? value :",
    ] {
        reject(&format!("// π UTF-8 prefix\nstruct Record {{ int value; }}; __global__ void kernel(unsigned long *out) {{ int value; int *pointer; int values[2]; int2 vector; Record record; out[0] = sizeof({operand}); }}"));
    }
}
