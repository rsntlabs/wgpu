use super::helpers::validate_with_options_and_capabilities;
use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

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
fn cuda_dependent_type_defaults_complete_chains_and_share_instances() {
    let module = validate("template<class T = unsigned, class U = T, class V = const U> __device__ unsigned value() { V result = 7; return unsigned(result); }
        __global__ void kernel(unsigned *out) { out[0] = value(); out[1] = value<unsigned>(); out[2] = value<unsigned, unsigned, const unsigned>(); }");
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    assert_eq!(calls.len(), 3);
    assert!(calls.iter().all(|function| *function == calls[0]));
}

#[test]
fn cuda_dependent_type_defaults_follow_deduction_and_preserve_source_types() {
    validate("__device__ int kind(int value) { return 1; } __device__ int kind(unsigned value) { return 2; }
        template<class T, class U = T> __device__ int selected(T input) { U copy = input; return kind(copy); }
        template<class T, class U = T> __device__ U copy(T value) { return U(value); }
        __global__ void kernel(unsigned *out) { out[0] = unsigned(selected(1)); out[1] = unsigned(selected(1u)); out[2] = copy(3u); }");
    let (wide, _) = validate_with_options_and_capabilities("__device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        template<class T, class U = T> __device__ int selected(T input) { U copy = input; return kind(copy); }
        __global__ void kernel(int *out) { out[0] = selected(1L); out[1] = selected(1LL); }",
        &Options::default(), Capabilities::SHADER_INT64);
    let mut tags = Vec::new();
    naga::proc::any_statement(&wide.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            let selected = &wide.functions[*function];
            naga::proc::any_statement(&selected.body, &mut |statement| {
                if let naga::Statement::Call { function, .. } = statement {
                    let kind = &wide.functions[*function];
                    naga::proc::any_statement(&kind.body, &mut |statement| {
                        if let naga::Statement::Return { value: Some(value) } = statement {
                            let naga::Expression::Literal(naga::Literal::I32(tag)) =
                                kind.expressions[*value]
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
        }
        false
    });
    assert_eq!(
        tags,
        [1, 2],
        "dependent defaults must preserve long source identity"
    );
    reject("template<class T, class U = T> __device__ int selected(U input) { return 1; } __global__ void kernel(int *out) { out[0] = selected(1); }");
}

#[test]
fn cuda_dependent_type_defaults_merge_by_index_and_respect_visibility() {
    validate("template<class T, class U> __device__ U value(T input) { return U(input); }
        template<class Renamed, class Result = const Renamed> __device__ Result value(Renamed input);
        __global__ void kernel(unsigned *out) { out[0] = value(7u); }");
    reject("template<class T, class U> __device__ U value(T input) { return U(input); } template<int N> __device__ unsigned caller() { return value(7u); } template<class Renamed, class Result = Renamed> __device__ Result value(Renamed input); __global__ void kernel(unsigned *out) { out[0] = caller<1>(); }");
}

#[test]
fn cuda_dependent_type_defaults_preserve_vector_record_dim3_null_and_pointer_shapes() {
    validate("struct R { int x; int y; };
        template<class T, class U = T> __device__ int vector3(T input) { U value = input; return int(value.z); }
        template<class T, class U = T> __device__ int vector1(T input) { U value = input; return value.x; }
        template<class T = R, class U = T> __device__ int record_value() { U value{4, 5}; return value.x + value.y; }
        template<class T = dim3, class U = T> __device__ unsigned shape() { U value; return value.x + value.y + value.z; }
        template<class T = decltype(nullptr), class U = T> __device__ U null_value() { return nullptr; }
        template<class T, class U = const T> __device__ int write(T input) { U pointer = input; *pointer = 9; return *pointer; }
        __global__ void kernel(unsigned *out) { float3 v{1,2,3}; int1 one{7}; int local = 0; out[0] = unsigned(vector3(v)); out[1] = unsigned(vector1(one)); out[2] = unsigned(record_value()); out[3] = shape(); out[4] = unsigned(null_value() == nullptr); out[5] = unsigned(write(&local)); }");
    reject("template<class T, class U = const T> __device__ void replace(T input) { U pointer = input; pointer = input; } __global__ void kernel() { int local = 0; replace(&local); }");
}

#[test]
fn cuda_dependent_type_defaults_bind_own_and_later_names_correctly() {
    validate(
        "using T = unsigned; using Later = int;
        template<class T = T, class U = T> __device__ U first() { return U(7); }
        template<class T = Later, class Later = unsigned> __device__ T second() { return T(3); }
        __global__ void kernel(unsigned *out) { out[0] = first(); out[1] = unsigned(second()); }",
    );
}

#[test]
fn cuda_dependent_type_defaults_reject_declarators_values_and_redefaults() {
    for source in [
        "template<class T, class U = T *> __device__ int f() { return 1; } __global__ void kernel() {}",
        "template<class T, class U = T &> __device__ int f() { return 1; } __global__ void kernel() {}",
        "template<class T, class U = T[3]> __device__ int f() { return 1; } __global__ void kernel() {}",
        "template<int N, int M = N> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<class T, class U = T> __device__ int f(); template<class A, class B = A> __device__ int f() { return 1; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_dependent_type_defaults_reject_type_parameter_namespace_collisions() {
    reject("namespace T = cooperative_groups; template<class T, class U = T::thread_block> __device__ int f() { return 1; } __global__ void kernel() {}");
}

#[test]
fn cuda_dependent_type_defaults_preserve_selected_array_reference_rejection() {
    let source = "__device__ int pick(bool value) { return 2; }
        template<class T, class U = T> __device__ int pick(const T &value) { return 1; }
        __global__ void kernel(int *out) { int values[2] = {1, 2}; out[0] = pick(values); }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(
        error.to_string().to_lowercase().contains("array"),
        "{error}"
    );
}

#[test]
fn cuda_dependent_type_defaults_normalize_kernel_chains_and_duplicate_instantiations() {
    let module = validate(
        "template<class T, class U = T, class V = const U>
        __global__ void filled(U *output, T value) { output[0] = U(value); }
        template __global__ void filled<unsigned>(unsigned *, unsigned);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(
        module.entry_points[0].name,
        "filled<unsigned,unsigned,const unsigned>"
    );
    reject(
        "template<class T, class U = T, class V = const U>
        __global__ void filled(U *output, T value) { output[0] = U(value); }
        template __global__ void filled<unsigned>(unsigned *, unsigned);
        template __global__ void filled<unsigned, unsigned, const unsigned>(unsigned *, unsigned);",
    );
}
