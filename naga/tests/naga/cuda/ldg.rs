use naga::front::cuda::{parse_str, Options};
use naga::{AddressSpace, Expression, StorageAccess, TypeInner};

use super::helpers::{root_expression, validate};

const FIXTURE: &str = include_str!("../../in/cuda/ldg.cu");

#[test]
fn cuda_ldg_lowers_to_ordinary_read_only_storage_loads() {
    let (module, info) = validate(FIXTURE);
    let function = &module.entry_points[0].function;
    let mut input_loads = 0;
    for (_, expression) in function.expressions.iter() {
        if let Expression::Load { pointer } = *expression {
            if let Expression::GlobalVariable(global) =
                function.expressions[root_expression(function, pointer)]
            {
                assert_eq!(
                    module.global_variables[global].space,
                    AddressSpace::Storage {
                        access: StorageAccess::LOAD
                    },
                );
                input_loads += 1;
            }
        }
    }
    assert_eq!(input_loads, 5);
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| !matches!(ty.inner, TypeInner::Atomic(_))));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_ldg_resolves_overloads_and_multiple_read_only_origins() {
    validate(
        "__device__ unsigned __ldg(const unsigned * const pointer);
        __device__ unsigned __ldg(bool flag) { return flag ? 7u : 9u; }
        __device__ unsigned read_ref(const unsigned &value) { return __ldg(&value); }
        struct Record { unsigned value; };
        __global__ void kernel(const unsigned *left, const Record *right, unsigned *out) {
            const unsigned *choice = left;
            if (threadIdx.x != 0u) { choice = &right[0].value; }
            out[0] = __ldg(choice);
            out[1] = __ldg(&right[0].value);
            out[2] = read_ref(left[1]);
            out[3] = __ldg(true);
        }",
    );
}

#[test]
fn cuda_ldg_preserves_a_better_user_pointer_overload() {
    validate(
        "__device__ unsigned __ldg(unsigned *pointer) { return *pointer; }
        __global__ void kernel(unsigned *out) {
            unsigned value = 1u; out[0] = __ldg(&value);
        }",
    );
}

#[test]
fn cuda_ldg_resolves_signed_and_float_overloads_through_helpers() {
    let (module, info) = validate(
        "__device__ int __ldg(const int * const pointer);
        __host__ __device__ float __ldg(const float *pointer);
        __device__ unsigned __ldg(bool flag) { return flag ? 7u : 9u; }
        __device__ int read_signed(const int *pointer) { return __ldg(pointer); }
        __device__ float read_float(const float &value) { return __ldg(&value); }
        __device__ int __ldg(int *pointer) { return *pointer; }
        __device__ unsigned kind(int value) { return value < 0 ? 1u : 2u; }
        __device__ unsigned kind(float value) { return __float_as_uint(value); }
        __global__ void kernel(const int *signed_input, const float *float_input, unsigned *out) {
            int local = -1;
            out[0] = kind(__ldg(signed_input));
            out[1] = kind(read_signed(&signed_input[1]));
            out[2] = kind(__ldg(float_input));
            out[3] = kind(read_float(float_input[1]));
            out[4] = kind(__ldg(&local));
            out[5] = __ldg(true);
        }",
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_ldg_rejects_invalid_signed_and_float_origins() {
    for ty in ["int", "float"] {
        for body in [
            "const Element *alias = writable; out[0] = unsigned(__ldg(alias));",
            "out[0] = unsigned(read_value(writable));",
            "__shared__ Element shared; out[0] = unsigned(__ldg(&shared));",
            "const Element *alias = input; if (threadIdx.x) alias = writable;
             out[0] = unsigned(read_value(alias));",
        ] {
            let source = format!(
                "using Element = {ty};
                __device__ unsigned __ldg(bool value) {{ return value ? 1u : 0u; }}
                __device__ Element read_value(const Element *pointer) {{ return __ldg(pointer); }}
                __global__ void kernel(const Element *input, Element *writable, unsigned *out) {{ {body} }}"
            );
            let error = parse_str(&source, &Options::default()).unwrap_err();
            assert!(
                error.message.contains("read-only storage"),
                "{ty}, {body}: {error}"
            );
        }
    }
}

#[test]
fn cuda_ldg_rejects_ambiguous_null_calls_and_incompatible_declarations() {
    for argument in ["0", "nullptr"] {
        let source =
            format!("__global__ void kernel(unsigned *out) {{ out[0] = __ldg({argument}); }}");
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert!(error.message.contains("ambiguous"), "{argument}: {error}");
    }
    for source in [
        "__device__ int __ldg(const float *pointer);",
        "__device__ float __ldg(const int *pointer);",
        "__device__ int __ldg(const int *pointer) { return 0; }",
        "__device__ float __ldg(const float *pointer) { return 0.0f; }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        assert!(error.message.contains("builtin"), "{source}: {error}");
    }
}

#[test]
fn cuda_ldg_rejects_non_read_only_storage_origins() {
    for body in [
        "out[0] = __ldg(out);",
        "__ldg(out);",
        "out[0] = false ? __ldg(out) : 0u;",
        "out[0] = __ldg(static_cast<const unsigned *>(out));",
        "out[0] = read_value(out);",
        "out[0] = read_ref(out[0]);",
        "unsigned local = 1u; out[0] = __ldg(&local);",
        "unsigned local = 1u; out[0] = read_value(&local);",
        "__shared__ unsigned shared; out[0] = __ldg(&shared);",
        "out[0] = __ldg(values);",
        "const unsigned *alias = out; out[0] = __ldg(alias);",
        "unsigned local = 1u; out[0] = __ldg(threadIdx.x ? input : &local);",
        "out[0] = __ldg(threadIdx.x ? input : nullptr);",
        "const unsigned *alias = input; if (threadIdx.x) alias = out; out[0] = read_value(alias);",
        "const unsigned *alias = input; if (threadIdx.x) alias = nullptr; out[0] = __ldg(alias);",
    ] {
        let source = format!(
            "__constant__ unsigned values[2];
            __device__ unsigned read_value(const unsigned *pointer) {{ return __ldg(pointer); }}
            __device__ unsigned read_ref(const unsigned &value) {{ return __ldg(&value); }}
            __global__ void kernel(const unsigned *input, unsigned *out) {{ {body} }}"
        );
        let error = parse_str(&source, &Options::default()).unwrap_err();
        assert!(
            error.message.contains("read-only storage"),
            "{body}: {error}"
        );
        assert!(
            source.get(error.span.to_range().unwrap()).is_some(),
            "{body}: {error}"
        );
    }
}

#[test]
fn cuda_ldg_rejects_invalid_overloads_and_constant_calls() {
    for body in [
        "out[0] = __ldg();",
        "out[0] = __ldg(input, 0u);",
        "out[0] = __ldg(1u);",
        "out[0] = __ldg(nullptr);",
        "out[0] = __ldg((const unsigned *)nullptr);",
        "short value = 0; out[0] = __ldg(&value);",
        "long value = 0; out[0] = __ldg(&value);",
        "bool value = false; out[0] = __ldg(&value);",
        "float2 value{}; out[0] = __ldg(&value);",
        "volatile int value = 0; out[0] = __ldg(&value);",
        "volatile float value = 0.0f; out[0] = __ldg(&value);",
        "volatile unsigned value = 0u; out[0] = __ldg(&value);",
        "constexpr unsigned value = __ldg(input); out[0] = value;",
    ] {
        let source =
            format!("__global__ void kernel(const unsigned *input, unsigned *out) {{ {body} }}");
        assert!(parse_str(&source, &Options::default()).is_err(), "{body}");
    }
    for source in [
        "__device__ int __ldg(const unsigned *pointer);",
        "__device__ unsigned __ldg(const unsigned *pointer) { return 0u; }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        assert!(error.message.contains("builtin"), "{error}");
    }
}
