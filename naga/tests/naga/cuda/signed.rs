use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/signed.cu");

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
    assert!(!error.message.is_empty(), "{source}");
    assert!(
        source.get(error.span.to_range().unwrap()).is_some(),
        "{source}"
    );
    error
}

#[test]
fn cuda_signed_spellings_preserve_integer_resource_and_struct_types() {
    let (module, _) = validate(FIXTURE);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(_, variable)| variable.binding.is_some())
        .collect();
    assert_eq!(resources.len(), 2);
    for (_, variable) in resources {
        let naga::TypeInner::Array {
            base, stride: 4, ..
        } = module.types[variable.ty].inner
        else {
            panic!("signed resource must have four-byte scalar elements");
        };
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
    }
    let sample = module
        .types
        .iter()
        .find(|&(_, ty)| {
            ty.name
                .as_deref()
                .is_some_and(|name| name.starts_with("Sample_cuda_record_"))
        })
        .unwrap()
        .1;
    let naga::TypeInner::Struct { ref members, .. } = sample.inner else {
        panic!("expected Sample struct");
    };
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    let naga::TypeInner::Array { base, .. } = module.types[members[1].ty].inner else {
        panic!("expected signed array field");
    };
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    roundtrip(FIXTURE);
}

#[test]
fn cuda_signed_accepts_const_and_constexpr_specifier_orders() {
    roundtrip(
        "constexpr int signed Global = 1;
        __global__ void kernel(signed *output) {
            signed const first = -1;
            const signed int second = -2;
            int signed const third = -3;
            signed constexpr int Count = 3;
            int constexpr signed Last = 2;
            signed values[Count]{first, second, third};
            output[0] = values[Global]; output[1] = values[Last];
        }",
    );
}

#[test]
fn cuda_signed_aliases_casts_and_alias_name_shadowing_remain_ordinary_ints() {
    roundtrip(
        "typedef signed Whole; using Number = int; using Integer = signed int;
        __global__ void kernel(Integer *output) {
            signed Number = 3;
            Whole first = (signed)-3.75f;
            Integer second = static_cast<signed int>(2.75f);
            int signed third = static_cast<int signed>(4.75f);
            output[0] = Number; output[1] = first;
            output[2] = second; output[3] = third; output[4] = signed(5u);
        }",
    );
    rejected("using Number = int; __global__ void kernel() { Number signed value; }");
}

#[test]
fn cuda_signed_helper_return_specifiers_can_interleave_function_specifiers() {
    for header in [
        "static __device__ signed inline int",
        "int __device__ signed",
        "__device__ inline signed",
    ] {
        let source = format!("{header} increment(int value) {{ return value + 1; }} __global__ void kernel(int *output) {{ output[0] = increment(-3); }}");
        let (module, _) = validate(&source);
        let function = module
            .functions
            .iter()
            .find(|&(_, function)| function.name.as_deref() == Some("increment"))
            .unwrap()
            .1;
        assert_eq!(
            module.types[function.result.as_ref().unwrap().ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
        roundtrip(&source);
    }
}

#[test]
fn cuda_signed_and_int_share_signatures_while_unsigned_keeps_its_overload() {
    let (module, _) = validate(
        "__device__ signed identity(int);
        __device__ int identity(signed int);
        __device__ int signed identity(int signed value) { return value; }
        __global__ void kernel(int *output) { output[0] = identity(-7); }",
    );
    assert_eq!(module.functions.len(), 1);
    roundtrip(
        "__device__ int rank(signed value) { return 3; }
        __device__ int rank(unsigned value) { return 7; }
        __global__ void kernel(int *output) { output[0] = rank(signed(-1)); output[1] = rank(1u); }",
    );
    rejected("__device__ int rank(int value) { return 3; } __device__ signed rank(signed int value) { return 7; } __global__ void kernel() {}");
}

#[test]
fn cuda_signed_rejects_conflicts_repeats_unsupported_widths_and_large_literals() {
    for declaration in [
        "signed signed value;",
        "signed int signed value;",
        "int signed int value;",
        "signed unsigned value;",
        "unsigned signed value;",
        "signed float value;",
        "float signed value;",
        "signed bool value;",
        "signed char value;",
        "signed short value;",
        "signed long value;",
        "signed double value;",
        "signed value = 2147483648;",
        "signed value = -2147483648;",
        "signed value = 4294967296u;",
        "signed value = signed int(3);",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"));
    }
    for header in [
        "signed signed",
        "signed unsigned",
        "unsigned signed",
        "signed float",
        "float signed",
        "void signed",
        "int int signed",
    ] {
        rejected(&format!(
            "{header} __device__ value() {{ return 0; }} __global__ void kernel() {{}}"
        ));
    }
    rejected("using Number = int; Number signed __device__ value() { return 0; } __global__ void kernel() {}");
}

#[test]
fn cuda_signed_macro_errors_point_to_the_original_specifier() {
    roundtrip("#define WHOLE signed int\n__global__ void kernel(WHOLE *output) { WHOLE value = -3; output[0] = value; }");
    let source = "#define SIGN signed\n/* λ 漢 */ __global__ void kernel() { signed SIGN value; }";
    assert_eq!(
        source.get(rejected(source).span.to_range().unwrap()),
        Some("SIGN")
    );
}
