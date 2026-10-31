use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

const FIXTURE: &str = include_str!("../../in/cuda/uninitialized-pointers.cu");

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

fn rejected(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() || range.start == source.len(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    assert!(!error.message.is_empty(), "{source}");
}

#[test]
fn cuda_uninitialized_pointers_assign_before_using_the_canonical_fixture() {
    roundtrip(FIXTURE);
}

#[test]
fn cuda_uninitialized_pointers_support_existing_pointees_and_aliases() {
    for pointee in [
        "bool", "int", "unsigned", "float", "int2", "int3", "int4", "uint2", "uint3", "uint4",
        "float2", "float3", "float4", "Record",
    ] {
        roundtrip(&format!(
            "struct Record {{ int value; float2 point; }};
            using Element = {pointee};
            __global__ void kernel() {{
                Element values[2]{{}};
                Element *selected;
                selected = values + 1;
                const Element *view;
                view = selected;
                *view;
            }}"
        ));
    }
}

#[test]
fn cuda_uninitialized_pointers_accept_function_workgroup_and_storage_origins() {
    roundtrip(
        "__global__ void kernel(int *out) {
            int value = 17;
            int local[2]{2, 3};
            __shared__ int shared[2];
            shared[0] = 11; shared[1] = 13;
            int *selected;
            selected = &value; out[0] = *selected;
            selected = local + 1; out[1] = *selected;
            selected = shared + 1; out[2] = *selected;
            selected = out + 8; out[3] = *selected;
            const int *view;
            view = selected; out[4] = *view;
        }",
    );
    roundtrip(
        "__global__ void kernel(const int *input, int *out) {
            const int *view;
            view = input + 1;
            out[0] = *view;
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_keep_assigned_ancestor_coordinates_and_copies() {
    roundtrip(
        "struct Record { int samples[2]; int marker; };
        __global__ void kernel(int *out) {
            Record records[2]{{{2, 3}, 5}, {{7, 11}, 13}};
            unsigned row = 0, column = 1;
            int *selected;
            selected = &records[row].samples[column];
            int *saved;
            saved = selected;
            row = 1; column = 0;
            selected = &records[row].samples[column];
            *selected += 10;
            out[0] = *saved; out[1] = *selected;
            out[2] = records[0].samples[1]; out[3] = records[1].samples[0];
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_assign_on_both_branches_before_use() {
    roundtrip(
        "__global__ void kernel(int *out) {
            int first[2]{2, 3}, second[2]{5, 7};
            int *selected;
            if (out[7]) selected = first + 1;
            else selected = second;
            out[0] = *selected;
            *selected += 10;
            out[1] = first[1]; out[2] = second[0];
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_assign_each_loop_iteration_and_for_initializer() {
    roundtrip(
        "__global__ void kernel(int *out) {
            int first[3]{2, 3, 5}, second[3]{7, 11, 13};
            for (int iteration = 0; iteration < 3; ++iteration) {
                int *selected;
                if (iteration % 2 == 0) selected = first + iteration;
                else selected = second + iteration;
                out[iteration] = *selected;
            }
            int slot = 0;
            for (int *cursor; slot < 3; ++slot) {
                cursor = first + slot;
                out[3 + slot] = *cursor;
            }
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_reenter_helpers_with_fresh_assigned_values() {
    roundtrip(
        "__device__ int read(const int *values, unsigned index, bool advance) {
            const int *selected;
            selected = values + index;
            if (advance) ++selected;
            return *selected;
        }
        __global__ void kernel(int *out) {
            int first[3]{2, 3, 5}, second[3]{7, 11, 13};
            out[0] = read(first, 0, true);
            out[1] = read(second, 1, true);
            out[2] = read(first, 2, false);
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_keep_mixed_declarators_and_shadowed_scope() {
    roundtrip(
        "__global__ void kernel(int *out) {
            int value = 7, *selected;
            selected = &value;
            out[0] = *selected;
        }",
    );
    roundtrip(
        "__global__ void kernel(int *out) {
            int values[3]{2, 3, 5};
            int *selected, scalar = 7, *saved = (selected = values + 1);
            out[0] = *selected; out[1] = *saved;
            { int *selected; selected = values; out[2] = *selected; }
            selected = values + 2;
            out[3] = *selected; out[4] = scalar;
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_allow_case_entry_past_a_bare_declaration() {
    roundtrip(
        "__global__ void kernel(int *out) {
            switch (out[0]) {
                case 0: int *cursor;
                case 1: cursor = out + 8; out[1] = *cursor; break;
                default: out[1] = -1;
            }
        }",
    );
    rejected(
        "__global__ void kernel(int *out) {
            switch (out[0]) {
                case 0: int *cursor = out;
                case 1: cursor = out + 8; out[1] = *cursor; break;
                default: break;
            }
        }",
    );
}

#[test]
fn cuda_uninitialized_pointers_allow_unused_and_dead_unassigned_declarations() {
    for source in [
        "__global__ void kernel() { int *unused; const int *view; }",
        "__global__ void kernel() { int *unused; constexpr int Count = (unused, 4); int values[Count]{}; }",
        "__global__ void kernel() { return; int *unused; }",
        "__global__ void kernel() { if (false) { int *unused; } }",
        "__device__ void unused() { int *selected; } __global__ void kernel() {}",
    ] {
        roundtrip(source);
    }
}

#[test]
fn cuda_uninitialized_pointers_keep_const_type_and_scope_errors() {
    for source in [
        "__global__ void kernel() { int *const selected; }",
        "__global__ void kernel() { const int *const selected; }",
        "__global__ void kernel() { float value = 1.0f; int *selected; selected = &value; }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel() { First first{}; Second *selected; selected = &first; }",
        "__global__ void kernel() { const int value = 3; int *selected; selected = &value; }",
        "__global__ void kernel(const int *input) { int *selected; selected = input; }",
        "__global__ void kernel() { int value = 3; const int *view = &value; int *selected; selected = view; }",
        "__global__ void kernel() { int value = 3; const int *view; view = &value; *view = 7; }",
        "__global__ void kernel(int *out) { int values[2]{2,3}; { int *hidden; hidden = values; } out[0] = *hidden; }",
        "__global__ void kernel(int *out) { int values[2]{2,3}; int slot = 0; for (int *cursor; slot < 2; ++slot) { cursor = values + slot; out[slot] = *cursor; } out[2] = *cursor; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_uninitialized_pointers_keep_initialized_self_reference_and_null_forms_rejected() {
    for source in [
        "__global__ void kernel() { int *selected = selected; }",
        "__global__ void kernel() { int values[2]{2,3}; int *selected = values; { int *selected = selected + 1; } }",
        "__global__ void kernel() { int *selected{}; }",
        "__global__ void kernel() { int *selected = {}; }",
        "__global__ void kernel() { int *selected = nullptr; }",
        "__global__ void kernel() { int *selected = 0; }",
        "__global__ void kernel() { int *selected; constexpr int Count = (selected + 0, 4); int values[Count]{}; }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_uninitialized_pointers_reject_live_cycles_without_any_origin() {
    for source in [
        "__global__ void kernel(int *out) { int *selected; out[0] = *selected; }",
        "__global__ void kernel() { int *selected; int *copy = selected; }",
        "__global__ void kernel(int *out) { int *selected; selected = selected; out[0] = *selected; }",
        "__global__ void kernel(int *out) { int *first, *second; first = second; second = first; out[0] = *first; }",
        "__device__ int cycle() { int *first, *second; first = second; second = first; return *first; } __global__ void kernel(int *out) { out[0] = cycle(); }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        assert!(!error.message.is_empty(), "{source}");
    }
}
