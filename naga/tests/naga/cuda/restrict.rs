use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/restrict.cu");

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
fn cuda_restrict_preserves_kernel_bindings_and_pointee_access() {
    let (module, _) = validate(FIXTURE);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter(|&(_, variable)| variable.binding.is_some())
        .collect();
    assert_eq!(resources.len(), 2);
    for ((_, variable), (binding, name, access)) in resources.into_iter().zip([
        (
            0,
            "output",
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
        ),
        (1, "input", naga::StorageAccess::LOAD),
    ]) {
        assert_eq!(variable.name.as_deref(), Some(name));
        assert_eq!(
            variable.binding,
            Some(naga::ResourceBinding { group: 0, binding })
        );
        assert_eq!(variable.space, naga::AddressSpace::Storage { access });
    }
    roundtrip(FIXTURE);
}

#[test]
fn cuda_restrict_accepts_both_spellings_and_pointer_const_orders() {
    for spelling in ["__restrict__", "__restrict"] {
        for qualifiers in [
            spelling.into(),
            format!("const {spelling}"),
            format!("{spelling} const"),
        ] {
            roundtrip(&format!(
                "using Element = int; using View = const Element;
                __device__ int read(View *{qualifiers} values) {{ return values[0]; }}
                __global__ void kernel(Element *{qualifiers} output, View *{qualifiers} input) {{
                    output[0] = read(input);
                }}"
            ));
            roundtrip(&format!(
                "using View = const int;
                __global__ void kernel(int *output, View *input) {{
                    View *{qualifiers} selected = input;
                    output[0] = *selected;
                }}"
            ));
        }
    }
}

#[test]
fn cuda_restrict_keeps_bare_mixed_declarators_and_expression_lookahead() {
    roundtrip(
        "using View = const int;
        __global__ void kernel(int *output, View *input, View *other) {
            View *const __restrict__ fixed = input, *__restrict selected;
            selected = other;
            output[0] = *fixed; output[1] = *selected;
            selected = other + 1; output[2] = *selected;
            int restrict = 2;
            int(restrict) + 1;
            output[3] = restrict;
        }",
    );
    roundtrip(
        "using View = const int;
        __global__ void kernel(int *output, View *input) {
            int index = 0;
            for (View *__restrict__ selected; index < 2; ++index) {
                selected = input + index;
                output[index] = *selected;
            }
        }",
    );
    for spelling in ["__restrict__", "__restrict"] {
        let source =
            format!("__global__ void kernel(int *input) {{ int (*{spelling} selected) = input; }}");
        let error = rejected(&source);
        assert_eq!(error.message, "parenthesized declarators are unsupported");
        let start = source.find("(*").unwrap();
        assert_eq!(error.span, naga::Span::from(start..start + 1));
    }
}

#[test]
fn cuda_restrict_does_not_distinguish_prototype_and_definition_signatures() {
    for (prototype, definition) in [
        ("__restrict__", ""),
        ("", "__restrict"),
        ("__restrict", "__restrict__ const"),
    ] {
        roundtrip(&format!(
            "__device__ int read(const int *{prototype});
            __global__ void kernel(int *output, const int *input) {{ output[0] = read(input); }}
            __device__ int read(const int *{definition} values) {{ return values[0]; }}"
        ));
    }
    rejected("__device__ int read(const int *values) { return values[0]; } __device__ int read(const int *__restrict values) { return values[0]; } __global__ void kernel() {}");
}

#[test]
fn cuda_restrict_accepts_repeated_and_mixed_restrict_qualifiers() {
    for qualifiers in [
        "__restrict__ __restrict__",
        "__restrict __restrict",
        "__restrict__ __restrict",
        "__restrict __restrict__",
    ] {
        roundtrip(&format!(
            "__device__ void copy(int *{qualifiers}, const int *{qualifiers});
            __global__ void kernel(int *{qualifiers} output, const int *input) {{
                const int *{qualifiers} selected;
                selected = input;
                copy(output, selected);
            }}
            __device__ void copy(int *destination, const int *source) {{ *destination = *source; }}"
        ));
    }
}

#[test]
fn cuda_restrict_expands_macros_and_retains_original_error_spans() {
    roundtrip(
        "#define RESTRICT __restrict__\n#define FIXED __restrict const\n
        __global__ void kernel(int *RESTRICT output, const int *FIXED input) { output[0] = input[0]; }",
    );
    let source = "#define AGAIN const\n/* λ 漢 */ __global__ void kernel(int *output) { int *const __restrict__ AGAIN selected = output; }";
    assert_eq!(
        source.get(rejected(source).span.to_range().unwrap()),
        Some("AGAIN")
    );
}

#[test]
fn cuda_restrict_keeps_pointer_const_pending_names_and_const_loss_errors() {
    for spelling in ["__restrict__", "__restrict"] {
        for body in [
            format!("int *{spelling} const selected;"),
            format!("int *const {spelling} selected = output; selected = output + 1;"),
            format!("int *{spelling} selected = selected;"),
            format!("int *{spelling} selected = input;"),
            format!("const int *{spelling} selected = input; *selected = 7;"),
        ] {
            rejected(&format!(
                "__global__ void kernel(int *output, const int *input) {{ {body} }}"
            ));
        }
        let source = format!("__global__ void kernel(int *output) {{ int *const {spelling} const selected = output; }}");
        let second = source.match_indices("const").nth(1).unwrap().0;
        assert_eq!(
            rejected(&source).span,
            naga::Span::from(second..second + "const".len())
        );
    }
}

#[test]
fn cuda_restrict_keeps_unsupported_placements_and_reserved_identifiers_rejected() {
    for spelling in ["__restrict__", "__restrict"] {
        for source in [
            format!("__global__ void kernel() {{ int {spelling} = 3; }}"),
            format!("using {spelling} = int; __global__ void kernel() {{}}"),
            format!("__global__ void {spelling}() {{}}"),
            format!("__global__ void kernel() {{ int {spelling} value; }}"),
            format!("__global__ void kernel(int {spelling} *input) {{}}"),
            format!("__global__ void kernel(int *input {spelling}) {{}}"),
            format!(
                "__global__ void kernel() {{ int value = 3; int &{spelling} reference = value; }}"
            ),
        ] {
            rejected(&source);
        }
    }
}
