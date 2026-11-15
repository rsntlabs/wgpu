use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT64
            | Capabilities::MEMORY_DECORATION_VOLATILE
            | Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP,
    )
    .0
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
fn cuda_decltype_pointer_arrays_preserve_pointer_object_and_pointee_qualifiers() {
    validate(
        "__global__ void kernel(int *out) {
        int value = 1; int other = 3;
        int *const fixed = &value; using Fixed = decltype(fixed); Fixed copy = &value; *copy = 2;
        const int *read = &value; using Read = decltype(read); Read moved = &value; moved = &other;
        int *uninitialized; using Unread = decltype(uninitialized); Unread null = nullptr;
        using Values = int[]; Values *incomplete = nullptr; using IncompletePointer = decltype(incomplete); static_assert(sizeof(IncompletePointer) == 8);
        out[0] = value + *moved + int(null == nullptr);
    }",
    );
    reject("__global__ void kernel() { int value = 1, other = 2; int *const fixed = &value; decltype(fixed) copy = &value; copy = &other; }");
    reject("__global__ void kernel() { int value = 1; const int *read = &value; decltype(read) copy = &value; *copy = 2; }");
}

#[test]
fn cuda_decltype_pointer_arrays_preserve_full_shapes_and_adjust_parameter_arrays_once() {
    validate("using Row = int[3];
        __device__ unsigned grid(Row values[2]) { using View = decltype(values); View copy = values; static_assert(sizeof(View) == 8); static_assert(sizeof(*copy) == 12); return unsigned(sizeof(View) + sizeof(*copy)); }
        __device__ unsigned row(Row values) { using View = decltype(values); static_assert(sizeof(View) == 8); static_assert(sizeof(*values) == 4); return unsigned(sizeof(View)); }
        __device__ unsigned pointer(Row *values) { using View = decltype(values); static_assert(sizeof(View) == 8); static_assert(sizeof(*values) == 12); return unsigned(sizeof(*values)); }
        __global__ void kernel(unsigned *out, int *input) {
            using Input = decltype(input); Input view = input; static_assert(sizeof(Input) == 8); static_assert(sizeof(*view) == 4);
            int matrix[2][3]{}; using Grid = decltype(matrix); Grid fresh{};
            static_assert(sizeof(Grid) == 24); static_assert(sizeof(fresh[0]) == 12);
            fresh[1][2] = view[0]; out[0] = grid(fresh) + row(fresh[0]) + pointer(&fresh[0]); out[1] = unsigned(fresh[1][2]);
        }");
}

#[test]
fn cuda_decltype_pointer_arrays_keep_vector_record_const_and_shared_array_layouts() {
    validate("struct Record { float3 position; unsigned tag; };
        __global__ void kernel(unsigned *out) {
            uint1 singles[2]; decltype(singles) one{}; one[1].x = 3u;
            float3 triples[2]; decltype(triples) three{}; three[1].z = 4.0f;
            Record records[2]; decltype(records) copied{}; copied[1].tag = 5u;
            const int constants[2] = {1, 2}; decltype(constants) frozen = {3, 4};
            __shared__ unsigned shared_values[4]; using Shared = decltype(shared_values); Shared local{}; local[0] = 7u;
            static_assert(sizeof(one) == 8); static_assert(sizeof(three) == 24); static_assert(sizeof(copied) == 32);
            out[0] = one[1].x + unsigned(three[1].z) + copied[1].tag + unsigned(frozen[0]) + local[0];
        }");
    reject("__global__ void kernel() { const int values[2] = {1, 2}; decltype(values) copy = {3, 4}; copy[0] = 5; }");
}

#[test]
fn cuda_decltype_pointer_arrays_preserve_source_long_identity_through_template_aliases() {
    let module = validate("__device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        template<class T> __device__ int selected(T input) { using Pointer = decltype(input); Pointer copy = input; return kind(*copy); }
        __global__ void kernel(int *out) { long first[2]{}; long long second[2]{}; decltype(first) a{}; decltype(second) b{}; out[0] = selected(&a[0]); out[1] = selected(&b[0]); }");
    let mut tags = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let callee = &module.functions[function];
            if callee
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("kind"))
            {
                naga::proc::any_statement(&callee.body, &mut |statement| {
                    if let naga::Statement::Return { value: Some(value) } = statement {
                        if let naga::Expression::Literal(naga::Literal::I32(tag)) =
                            callee.expressions[*value]
                        {
                            tags.push(tag);
                        }
                    }
                    false
                });
            }
        }
        false
    });
    tags.sort();
    assert_eq!(tags, [1, 2]);
}

#[test]
fn cuda_decltype_pointer_arrays_queries_add_no_loads_or_runtime_expressions() {
    let control = "__global__ void kernel(unsigned *out, const volatile unsigned *input) { __shared__ volatile unsigned values[2]; QUERY out[0] = input[0]; }";
    let baseline = validate(&control.replace("QUERY", ""));
    let queried = validate(&control.replace(
        "QUERY",
        "using Pointer = decltype(input); using Array = decltype(values);",
    ));
    let a = &baseline.entry_points[0].function;
    let b = &queried.entry_points[0].function;
    assert_eq!(a.expressions.len(), b.expressions.len());
    assert_eq!(a.local_variables.len(), b.local_variables.len());
    assert_eq!(
        a.expressions
            .iter()
            .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
            .count(),
        b.expressions
            .iter()
            .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
            .count()
    );
}

#[test]
fn cuda_decltype_pointer_arrays_keep_non_direct_reference_and_pending_operands_unsupported() {
    for body in [
        "int value = 1; int *pointer = &value; using Type = decltype((pointer));",
        "int value = 1; int *pointer = &value; using Type = decltype(*pointer);",
        "int value = 1; int *pointer = &value; using Type = decltype(pointer++);",
        "int values[2]; int (&reference)[2] = values; using Type = decltype(reference);",
        "int *pointer = decltype(pointer)(nullptr);",
        "auto pointer = decltype(pointer)(nullptr);",
        "int values[] = {unsigned(sizeof(decltype(values)))};",
        "using Pointer = decltype(missing);",
        "using Values = int[]; Values *pointer = nullptr; using Pointer = decltype(pointer); static_assert(sizeof(*pointer) == 0);",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    reject("__device__ void invalid(int *&pointer) { using Type = decltype(pointer); } __global__ void kernel() {}");
}
