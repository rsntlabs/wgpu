use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::empty()).0
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
fn cuda_decltype_objects_accept_local_and_value_parameter_types() {
    validate(
        "__device__ int copy(int value) { decltype(value) other = value; return other; }
        __global__ void kernel(int *out, unsigned seed) {
            int value = 3; using Value = decltype(value); Value other = copy(value);
            decltype(seed) count = seed; out[0] = other + int(count);
        }",
    );
}

#[test]
fn cuda_decltype_objects_support_casts_and_all_existing_construction_forms() {
    validate("struct Pair { int x; int y; };
        __device__ int next(int &value) { return value++; }
        __global__ void kernel(int *out) {
            int source = 1; int counter = 1;
            decltype(source) first = next(counter);
            decltype(source) second{next(counter)};
            decltype(source) third(next(counter));
            int fourth = static_cast<decltype(source)>(next(counter));
            int fifth = (decltype(source))next(counter);
            int sixth = decltype(source)(next(counter));
            int seventh = decltype(source){next(counter)};
            Pair pair{1, 2}; decltype(pair) copied{3, 4};
            Pair expression = decltype(pair){5, 6};
            out[0] = first + second + third + fourth + fifth + sixth + seventh + counter + copied.x + expression.y;
        }");
}

#[test]
fn cuda_decltype_objects_preserve_vectors_records_and_dim3_constructors() {
    validate("struct Record { int x; float3 vector; };
        __global__ void kernel(unsigned *out) {
            float1 one = make_float1(2.0f); decltype(one) one_copy{3.0f};
            float2 two = make_float2(1.0f, 2.0f); decltype(two) two_copy{3.0f, 4.0f};
            float3 three = make_float3(1.0f, 2.0f, 3.0f); decltype(three) three_copy{4.0f, 5.0f, 6.0f};
            float4 four = make_float4(1.0f, 2.0f, 3.0f, 4.0f); decltype(four) four_copy{5.0f, 6.0f, 7.0f, 8.0f};
            Record record{7, {1.0f, 2.0f, 3.0f}}; decltype(record) record_copy{9, {4.0f, 5.0f, 6.0f}};
            dim3 shape; decltype(shape) default_shape; decltype(shape) explicit_shape(2u, 3u);
            out[0] = unsigned(one_copy.x + two_copy.y + three_copy.z + four_copy.w + record_copy.vector.y);
            out[1] = default_shape.x + default_shape.y + default_shape.z + explicit_shape.z;
        }");
}

#[test]
fn cuda_decltype_objects_preserve_const_constants_and_global_return_types() {
    validate(
        "constexpr unsigned Global = 7u;
        __device__ decltype(Global) global_value() { return Global; }
        __device__ int pick(int &value) { return 1; }
        __device__ int pick(const int &value) { return 2; }
        __global__ void kernel(unsigned *out) {
            int mutable_value = 1; const int frozen = 2; constexpr int Constant = 3;
            decltype(mutable_value) a = 4; decltype(frozen) b = 5; decltype(Constant) c = 6;
            out[0] = unsigned(pick(a)); out[1] = unsigned(pick(b)); out[2] = unsigned(pick(c));
            out[3] = global_value();
        }",
    );
    for declaration in ["const int value = 1", "constexpr int value = 1"] {
        reject(&format!(
            "__global__ void kernel() {{ {declaration}; decltype(value) copy = 2; copy = 3; }}"
        ));
    }
    reject("constexpr int Global = 1; __global__ void kernel() { decltype(Global) copy = 2; copy = 3; }");
}

#[test]
fn cuda_decltype_objects_preserve_long_identity_and_narrow_scalar_types() {
    let (module, _) = validate_with_options_and_capabilities(
        "__device__ int kind(long value) { return 1; }
        __device__ int kind(long long value) { return 2; }
        __global__ void kernel(int *out) {
            long first = 1L; long long second = 1LL;
            decltype(first) a = first; decltype(second) b = second;
            short small = -1; unsigned short word = 65535;
            decltype(small) c = small; decltype(word) d = word;
            out[0] = kind(a); out[1] = kind(b); out[2] = int(c) + int(d);
        }",
        &Options::default(),
        Capabilities::SHADER_INT16 | Capabilities::SHADER_INT64,
    );
    let mut tags = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            let callee = &module.functions[*function];
            naga::proc::any_statement(&callee.body, &mut |statement| {
                if let naga::Statement::Return { value: Some(value) } = statement {
                    let naga::Expression::Literal(naga::Literal::I32(tag)) =
                        callee.expressions[*value]
                    else {
                        panic!("expected overload return tag");
                    };
                    tags.push(tag);
                }
                false
            });
        }
        false
    });
    assert_eq!(tags, [1, 2]);
}

#[test]
fn cuda_decltype_objects_query_emits_no_extra_loads() {
    let source = "__global__ void kernel(const int *input, int *out) {
        int local = input[0]; using Copy = decltype(local);
        Copy first = 2; decltype(local) second = 3;
        out[0] = local + first + static_cast<decltype(local)>(second);
    }";
    let control = source.replace("decltype(local)", "int");
    let queried = validate(source);
    let explicit = validate(&control);
    let load_count = |module: &naga::Module| {
        module.entry_points[0]
            .function
            .expressions
            .iter()
            .filter(|(_, expression)| matches!(expression, naga::Expression::Load { .. }))
            .count()
    };
    assert_eq!(load_count(&queried), load_count(&explicit));
    let function = &queried.entry_points[0].function;
    let input = queried
        .global_variables
        .iter()
        .find_map(|(handle, variable)| {
            (variable.name.as_deref() == Some("input")).then_some(handle)
        })
        .unwrap();
    let input_reads = function
        .expressions
        .iter()
        .filter(|(_, expression)| match **expression {
            naga::Expression::Load { pointer } => {
                function.expressions[super::helpers::root_expression(function, pointer)]
                    == naga::Expression::GlobalVariable(input)
            }
            _ => false,
        })
        .count();
    assert_eq!(input_reads, 1);
}

#[test]
fn cuda_decltype_objects_preserve_lexical_shadowing_and_instantiated_template_bodies() {
    validate("using Hidden = float;
        template<class T> __device__ int copied(T value) { using Copy = decltype(value); Copy other{value}; return int(other); }
        __global__ void kernel(int *out) {
            int Hidden = 3; decltype(Hidden) first = 4;
            { float Hidden = 2.0f; decltype(Hidden) second = 3.0f; out[0] = int(second); }
            decltype(Hidden) third = first; out[1] = third;
            out[2] = copied(7); out[3] = copied(9u);
        }");
    reject("__global__ void kernel() { int value = 1; { auto value = static_cast<decltype(value)>(2); } }");
    reject("template<class T> __device__ int f(T value, int count = sizeof(decltype(value))) { return count; } __global__ void kernel() {}");
}

#[test]
fn cuda_decltype_objects_reject_reference_pointer_array_and_source_only_operands() {
    for body in [
        "int value = 1; int &ref = value; decltype(ref) copy = value;",
        "int value = 1; const int &ref = value; decltype(ref) copy = value;",
        "int value = 1; int *pointer = &value; decltype(pointer) copy = pointer;",
        "int values[2]{}; decltype(values) copy{};",
        "using Null = decltype(nullptr); Null value = nullptr; decltype(value) copy = nullptr;",
        "auto group = cooperative_groups::this_thread_block(); decltype(group) copy = group;",
    ] {
        reject(&format!("__global__ void kernel() {{ {body} }}"));
    }
    for ty in ["int &", "const int &", "float3 &"] {
        reject(&format!("__device__ void invalid({ty}value) {{ decltype(value) copy{{}}; }} __global__ void kernel() {{}}"));
    }
    for source in [
        "using Null = decltype(nullptr); __device__ void invalid(Null erased, int &value) { decltype(value) copy{}; } __global__ void kernel() {}",
        "namespace cg = cooperative_groups; __device__ void invalid(cg::thread_block erased, int &value) { decltype(value) copy{}; } __global__ void kernel() {}",
        "template<class T> __device__ void invalid(T &value) { decltype(value) copy{}; } __global__ void kernel() { int value = 1; invalid(value); }",
        "using Null = decltype(nullptr); template<class T> __device__ void invalid(Null erased, T &value) { decltype(value) copy{}; } __global__ void kernel() { int value = 1; invalid(nullptr, value); }",
    ] { reject(source); }
}

#[test]
fn cuda_decltype_objects_reject_other_expressions_unknown_names_and_type_names() {
    for operand in [
        "(value)", "value++", "helper()", "value.x", "Unknown", "Integer", "int", "1",
    ] {
        reject(&format!("using Integer = int; __device__ int helper() {{ return 1; }} __global__ void kernel() {{ int value = 1; decltype({operand}) copy{{}}; }}"));
    }
    reject("template<class T> __device__ decltype(value) invalid(T value) { return value; } __global__ void kernel() {}");
}

#[test]
fn cuda_decltype_objects_keep_decltype_nullptr_behavior() {
    validate("using Null = decltype(nullptr); __device__ Null produced() { return nullptr; }
        __global__ void kernel(unsigned *out) { Null value = produced(); out[0] = unsigned(value == nullptr); }");
}

#[test]
fn cuda_decltype_objects_retain_vector_array_strides_and_record_offsets() {
    let module = validate("struct Record { int tag; float3 vector; };
        __global__ void kernel(int *out) {
            float1 one = make_float1(1.0f); decltype(one) singles[2]{{2.0f}, {3.0f}};
            float3 three = make_float3(1.0f, 2.0f, 3.0f); decltype(three) triples[2]{{4.0f, 5.0f, 6.0f}, {7.0f, 8.0f, 9.0f}};
            Record record{1, {2.0f, 3.0f, 4.0f}}; decltype(record) copy_record{5, {6.0f, 7.0f, 8.0f}};
            out[0] = int(singles[1].x + triples[1].z + copy_record.vector.y);
        }");
    for (name, expected_stride) in [("singles", 4), ("triples", 12)] {
        let local = module.entry_points[0]
            .function
            .local_variables
            .iter()
            .find_map(|(_, local)| (local.name.as_deref() == Some(name)).then_some(local))
            .unwrap();
        let naga::TypeInner::Array { stride, .. } = module.types[local.ty].inner else {
            panic!("expected vector array");
        };
        assert_eq!(stride, expected_stride);
    }
    let record = module.entry_points[0]
        .function
        .local_variables
        .iter()
        .find_map(|(_, local)| (local.name.as_deref() == Some("copy_record")).then_some(local.ty))
        .unwrap();
    let naga::TypeInner::Struct { ref members, span } = module.types[record].inner else {
        panic!("expected record");
    };
    assert_eq!(members[1].offset, 4);
    assert_eq!(span, 16);
}

#[test]
fn cuda_decltype_objects_distinguish_type_query_before_declarator_from_own_auto_initializer() {
    validate("__global__ void kernel(int *out) { int value = 1; { decltype(value) value = 2; out[0] = value; } }");
    reject(
        "struct S { int x; }; __global__ void kernel() { S value{1}; decltype(value.x) copy = 1; }",
    );
}

#[test]
fn cuda_decltype_objects_preserve_volatile_shared_qualification_without_query_reads() {
    let (module, _) = validate_with_options_and_capabilities(
        "__global__ void kernel(int *out) {
            __shared__ volatile int value;
            value = 7;
            using Copy = decltype(value);
            __shared__ Copy copy;
            copy = 9;
            (void)copy;
            out[0] = 1;
        }",
        &Options::default(),
        Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP,
    );
    let function = &module.entry_points[0].function;
    for (name, expected_reads) in [("value", 0), ("copy", 1)] {
        let (handle, global) = module
            .global_variables
            .iter()
            .find(|(_, global)| global.name.as_deref() == Some(name))
            .unwrap();
        assert!(global
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
        let reads = function
            .expressions
            .iter()
            .filter(|(_, expression)| match **expression {
                naga::Expression::Load { pointer } => {
                    function.expressions[super::helpers::root_expression(function, pointer)]
                        == naga::Expression::GlobalVariable(handle)
                }
                _ => false,
            })
            .count();
        assert_eq!(reads, expected_reads, "{name}");
    }
}
