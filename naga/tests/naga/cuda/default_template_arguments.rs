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
fn cuda_default_template_arguments_accept_nondependent_type_defaults() {
    validate("template<class T = unsigned> __device__ T value() { return T(7); }
        __global__ void kernel(unsigned *out) { out[0] = value(); out[1] = value<>(); out[2] = value<unsigned>(); }");
}

#[test]
fn cuda_default_template_arguments_complete_after_deduction_and_allow_nontrailing_defaults() {
    validate("template<class Result = unsigned, class Input> __device__ Result convert(Input value) { return Result(value); }
        template<class T = unsigned> __device__ T same(T first, T second) { return first + second; }
        __global__ void kernel(unsigned *out) {
            out[0] = convert(3); out[1] = unsigned(convert<int>(4u)); out[2] = convert<unsigned, int>(5);
            out[3] = unsigned(same(1, 2)); out[4] = same<unsigned>(1, 2u);
        }");
    reject("template<class T = unsigned> __device__ T same(T first, T second) { return first + second; } __global__ void kernel() { same(1, 2u); }");
    reject("template<class Result = unsigned, class Input> __device__ Result convert() { return Result(7); } __global__ void kernel() { convert(); }");
}

#[test]
fn cuda_default_template_arguments_freeze_initial_bindings_and_reuse_specializations() {
    let module = validate(
        "using Frozen = unsigned;
        template<class T = Frozen> __device__ T value();
        template<class Renamed> __device__ Renamed value() { return Renamed(7); }
        __global__ void kernel(unsigned *out) {
            using Frozen = int;
            out[0] = value(); out[1] = value<>(); out[2] = value<unsigned>();
        }",
    );
    let mut calls = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            calls.push(*function);
        }
        false
    });
    assert_eq!(calls.len(), 3);
    assert_eq!(calls[0], calls[1]);
    assert_eq!(calls[1], calls[2]);
    assert_eq!(
        module.functions[calls[0]].name.as_deref(),
        Some("value<unsigned>")
    );
    validate("using T = unsigned; template<class T = T> __device__ T self_named() { return T(7); } __global__ void kernel(unsigned *out) { out[0] = self_named(); }");
}

#[test]
fn cuda_default_template_arguments_preserve_deduced_type_identity_and_const_defaults() {
    validate("__device__ int kind(int value) { return 1; }
        __device__ int kind(unsigned value) { return 2; }
        __device__ int pick(int &value) { return 3; }
        __device__ int pick(const int &value) { return 4; }
        template<class T = unsigned> __device__ int deduced(T value) { return kind(value); }
        template<class T = const int> __device__ int frozen() { T value = 7; return pick(value); }
        __global__ void kernel(int *out) { out[0] = deduced(1); out[1] = deduced(1u); out[2] = frozen(); out[3] = frozen<int>(); }");
    let (module, _) = validate_with_options_and_capabilities(
        "using Word = long;
        template<class T = Word> __device__ T value() { return T(7); }
        __global__ void kernel(long long *out) { out[0] = value(); out[1] = value<long long>(); }
        ",
        &Options::default(),
        Capabilities::SHADER_INT64,
    );
    let names: Vec<_> = module
        .functions
        .iter()
        .filter_map(|(_, function)| function.name.as_deref())
        .filter(|name| name.starts_with("value<"))
        .collect();
    assert!(names.contains(&"value<long>"));
    assert!(names.contains(&"value<long long>"));
}

#[test]
fn cuda_default_template_arguments_support_vector_record_dim3_nullptr_and_pointer_defaults() {
    validate("struct Record { int x; int y; };
        template<class T = float3> __device__ int vector_value() { T value{1.0f, 2.0f, 3.0f}; return int(value.z); }
        template<class T = Record> __device__ int record_value() { T value{4, 5}; return value.x + value.y; }
        template<class T = dim3> __device__ unsigned shape_value() { T value; return value.x + 10u * value.y + 100u * value.z; }
        template<class T = decltype(nullptr)> __device__ T null_value() { return nullptr; }
        template<class Pointer = const int *> __device__ int read(const int *input) { Pointer value = input; return value[0]; }
        __global__ void kernel(unsigned *out, const int *input) { out[0] = unsigned(vector_value()); out[1] = unsigned(record_value()); out[2] = shape_value(); out[3] = unsigned(null_value() == nullptr); out[4] = unsigned(read(input)); }");
}

#[test]
fn cuda_default_template_arguments_preserve_ordinary_overload_ranking_and_side_effects() {
    validate("__device__ int selected(int value) { return 10 + value; }
        template<class T = unsigned> __device__ int selected(T value) { return 20 + int(value); }
        template<class T = unsigned> __device__ int bump(int &value, int amount = 2) { int old = value; value += amount; return old; }
        __global__ void kernel(int *out) { int value = 1; out[0] = selected(1); out[1] = selected(1u); out[2] = selected<>(1); out[3] = bump(value); out[4] = bump<unsigned>(value, 3); false && bump(value); bump(value); out[5] = value; }");
}

#[test]
fn cuda_default_template_arguments_support_kernel_selector_defaults_and_explicit_instantiation() {
    let module = validate(
        "template<class T = unsigned> __global__ void filled(T *output) { output[0] = T(7); }
        template __global__ void filled<>(unsigned *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "filled<unsigned>");
}

#[test]
fn cuda_default_template_arguments_reject_later_additions_redefaults_and_dependent_types() {
    for source in [
        "template<class T = unsigned> __device__ T f(); template<class U = unsigned> __device__ U f() { return U(1); } __global__ void kernel() {}",
        "template<class T> __device__ T f(); template<class U = unsigned> __device__ U f() { return U(1); } __global__ void kernel() {}",
        "using A = unsigned; template<class A, class B = A> __device__ B f(A value) { return B(value); } __global__ void kernel() {}",
        "template<class A = unsigned, class B = A> __device__ B f(A value) { return B(value); } __global__ void kernel() {}",
        "template<int N, int M = N> __device__ int f() { return M; } __global__ void kernel() {}",
        "template<class T = void> __device__ int f() { return 1; } __global__ void kernel() {}",
        "using Row = int[3]; template<class T = Row> __device__ int f() { return 1; } __global__ void kernel() {}",
        "template<class T = int &> __device__ int f() { return 1; } __global__ void kernel() {}",
    ] { reject(source); }
}

#[test]
fn cuda_default_template_arguments_deduce_pointer_before_defaults_and_normalize_kernels() {
    let pointer_module = validate(
        "__device__ int kind(int value) { return 1; }
        __device__ int kind(unsigned value) { return 2; }
        template<class T = int> __device__ int pointed(T *value) { return kind(*value); }
        __global__ void kernel(unsigned *out) { out[0] = unsigned(pointed(out)); }",
    );
    let mut tags = Vec::new();
    naga::proc::any_statement(
        &pointer_module.entry_points[0].function.body,
        &mut |statement| {
            if let naga::Statement::Call { function, .. } = statement {
                let callee = &pointer_module.functions[*function];
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
            false
        },
    );
    assert_eq!(
        tags,
        [2],
        "pointer deduction must select the unsigned overload"
    );
    let module = validate(
        "template<class T = unsigned> __global__ void filled(T *output);
        template<class Renamed> __global__ void filled(Renamed *output) { output[0] = Renamed(7); }
        template __global__ void filled<>(unsigned *);",
    );
    assert_eq!(module.entry_points.len(), 1);
    assert_eq!(module.entry_points[0].name, "filled<unsigned>");
    for source in [
        "template<class T = int> __device__ int f() { return 1; } template<class T = int, class U = unsigned> __device__ int f() { return 2; } __global__ void kernel(int *out) { out[0] = f<>(); }",
        "template<class T = unsigned> __global__ void filled(T *output) { output[0] = T(7); } template __global__ void filled<>(unsigned *); template __global__ void filled<unsigned>(unsigned *);",
        "template<class T, class U = T *> __device__ int f(T value) { return 1; } __global__ void kernel(int *out) { out[0] = f<int, int *>(1); }",
        "template<int N, class T = unsigned> __device__ T f() { return T(N); } __global__ void kernel(unsigned *out) { out[0] = f(); }",
    ] {
        reject(source);
    }
}
