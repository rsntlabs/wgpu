use super::helpers::validate;

fn local_names(module: &naga::Module) -> Vec<&str> {
    module.entry_points[0]
        .function
        .local_variables
        .iter()
        .filter_map(|(_, variable)| variable.name.as_deref())
        .collect()
}

#[track_caller]
fn assert_pointer_names(source: &str, expected: &[(&str, usize)]) {
    let (module, info) = validate(source);
    let names = local_names(&module);
    for &(name, count) in expected {
        assert_eq!(
            names
                .iter()
                .copied()
                .filter(|&actual| actual == name)
                .count(),
            count,
            "source pointer name {name:?} in {names:?}"
        );
    }

    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (output, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let names = local_names(&reparsed);
        for &(name, count) in expected {
            let prefix = format!("{name}_");
            assert_eq!(
                names
                    .iter()
                    .copied()
                    .filter(|&actual| actual == name || actual.starts_with(&prefix))
                    .count(),
                count,
                "emitted pointer name {name:?}\n{output}"
            );
        }
        let unique: naga::FastHashSet<_> = names.iter().copied().collect();
        assert_eq!(unique.len(), names.len(), "{output}");
    }
    let _ = info;
}

#[test]
fn cuda_pointer_names_preserve_local_objects_and_copies() {
    assert_pointer_names(
        "__global__ void kernel(int *out) {
            int first[3]{2, 3, 5}, second[3]{7, 11, 13};
            int *selected = first;
            int *saved = selected;
            const int *view = selected;
            int *const fixed = first;
            selected = second + 1;
            out[0] = *selected + *saved + *view + *fixed;
        }",
        &[("selected", 1), ("saved", 1), ("view", 1), ("fixed", 1)],
    );
}

#[test]
fn cuda_pointer_names_preserve_kernel_parameter_objects_alongside_resources() {
    assert_pointer_names(
        "__global__ void kernel(const int *values, int *output) {
            int *destination = output;
            values = values + 1;
            output = output + 2;
            *output = *values;
            *destination = 7;
        }",
        &[("values", 1), ("output", 1), ("destination", 1)],
    );
}

#[test]
fn cuda_pointer_names_preserve_inlined_helper_formals() {
    assert_pointer_names(
        "__device__ int read_next(const int *cursor, const int *replacement) {
            const int *saved = cursor;
            cursor = replacement + 1;
            return *cursor + *saved;
        }
        __global__ void kernel(int *out) {
            int first[3]{2, 3, 5}, second[3]{7, 11, 13};
            out[0] = read_next(first, second);
        }",
        &[("cursor", 1), ("replacement", 1), ("saved", 1)],
    );
}

#[test]
fn cuda_pointer_names_allow_scope_and_inlined_invocation_collisions() {
    assert_pointer_names(
        "__device__ int advance(int *cursor) {
            int *saved = cursor;
            ++cursor;
            return *saved + *cursor;
        }
        __global__ void kernel(int *out) {
            int values[4]{2, 3, 5, 7};
            int *cursor = values;
            { int *cursor = values + 1; out[0] = *cursor; }
            { int *cursor = values + 2; out[1] = *cursor; }
            out[2] = advance(cursor);
            out[3] = advance(cursor + 1);
        }",
        &[("cursor", 5), ("saved", 2)],
    );
}
