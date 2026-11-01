mod common;

use common::TestFiles;

fn successful(files: &TestFiles, arguments: &[&str]) -> naga::Module {
    let result = files.translate(arguments);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    files.read_module()
}

fn shared_arrays(module: &naga::Module) -> Vec<(naga::Handle<naga::GlobalVariable>, u32, u32)> {
    module
        .global_variables
        .iter()
        .filter_map(|(handle, global)| {
            if global.space != naga::AddressSpace::WorkGroup {
                return None;
            }
            assert_eq!(global.binding, None);
            assert_eq!(global.init, None);
            let naga::TypeInner::Array {
                size: naga::ArraySize::Constant(count),
                stride,
                ..
            } = module.types[global.ty].inner
            else {
                panic!("expected a specialized shared array");
            };
            Some((handle, count.get(), stride))
        })
        .collect()
}

#[test]
fn cuda_dynamic_shared_defaults_to_zero_bytes_and_accepts_unused_declarations() {
    let source = "__global__ void empty() { extern __shared__ float values[]; }";
    for arguments in [vec![], vec!["--cuda-dynamic-shared-memory-size", "0"]] {
        let files = TestFiles::new("cu", source);
        let module = successful(&files, &arguments);
        assert_eq!(module.entry_points.len(), 1);
        assert_eq!(module.entry_points[0].name, "empty");
        assert!(shared_arrays(&module).is_empty());
    }
    let files = TestFiles::new("cu", "__global__ void empty() {}");
    let module = successful(&files, &["--cuda-dynamic-shared-memory-size", "4294967295"]);
    assert!(module.global_variables.is_empty());
}

#[test]
fn cuda_dynamic_shared_byte_sizes_specialize_typed_storage_without_changing_the_launch() {
    for (bytes, count) in [("4", 1), ("5", 2), ("16", 4), ("17", 5)] {
        let files = TestFiles::new(
            "cu",
            "__global__ void exchange(unsigned *output) {
                extern __shared__ unsigned values[];
                values[0] = 7u;
                output[0] = values[0];
            }",
        );
        let module = successful(
            &files,
            &[
                "--cuda-dynamic-shared-memory-size",
                bytes,
                "--cuda-workgroup-size",
                "4,2,1",
            ],
        );
        assert_eq!(module.entry_points[0].workgroup_size, [4, 2, 1]);
        let shared = shared_arrays(&module);
        assert_eq!(shared.len(), 1);
        assert_eq!((shared[0].1, shared[0].2), (count, 4));
        let naga::TypeInner::Array { base, .. } =
            module.types[module.global_variables[shared[0].0].ty].inner
        else {
            unreachable!();
        };
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
    }
}

#[test]
fn cuda_dynamic_shared_names_alias_across_scopes_and_helpers_while_static_storage_is_separate() {
    let files = TestFiles::new(
        "cu",
        "extern __shared__ int global_values[];
        __device__ void write_lane(int value) {
            extern __shared__ int helper_values[];
            helper_values[threadIdx.x] = value;
        }
        __global__ void exchange(int *output) {
            extern __shared__ int local_values[];
            extern __shared__ int local_values[];
            __shared__ int fixed_values[4];
            unsigned lane = threadIdx.x;
            write_lane(int(lane) + 3);
            fixed_values[lane] = int(lane) + 20;
            __syncthreads();
            { extern __shared__ int nested_values[];
                output[lane] = global_values[lane] + local_values[lane]
                    + nested_values[lane] + fixed_values[lane];
            }
        }",
    );
    let module = successful(
        &files,
        &[
            "--cuda-dynamic-shared-memory-size",
            "32",
            "--cuda-workgroup-size",
            "4,1,1",
        ],
    );
    let mut sizes: Vec<_> = shared_arrays(&module)
        .into_iter()
        .map(|(_, count, stride)| (count, stride))
        .collect();
    sizes.sort_unstable();
    assert_eq!(sizes, [(4, 4), (8, 4)]);
}

#[test]
fn cuda_dynamic_shared_specialization_is_module_wide_with_independent_entry_storage() {
    let files = TestFiles::new(
        "cu",
        "__global__ void integers(int *output) {
            extern __shared__ int integer_values[];
            integer_values[0] = 3; output[0] = integer_values[0];
        }
        __global__ void floats(float *output) {
            extern __shared__ float float_values[];
            float_values[0] = 2.5f; output[0] = float_values[0];
        }",
    );
    let module = successful(
        &files,
        &[
            "--cuda-dynamic-shared-memory-size",
            "17",
            "--cuda-workgroup-size",
            "4,1,1",
        ],
    );
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["integers", "floats"]
    );
    let shared = shared_arrays(&module);
    assert_eq!(shared.len(), 2);
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .unwrap();
    for (entry_index, scalar) in [naga::Scalar::I32, naga::Scalar::F32]
        .into_iter()
        .enumerate()
    {
        assert_eq!(module.entry_points[entry_index].workgroup_size, [4, 1, 1]);
        let used: Vec<_> = shared
            .iter()
            .filter(|&&(handle, _, _)| !info.get_entry_point(entry_index)[handle].is_empty())
            .collect();
        assert_eq!(used.len(), 1);
        let &(handle, count, stride) = used[0];
        assert_eq!((count, stride), (5, 4));
        assert!(info.get_entry_point(1 - entry_index)[handle].is_empty());
        let naga::TypeInner::Array { base, .. } =
            module.types[module.global_variables[handle].ty].inner
        else {
            unreachable!();
        };
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
    }
}

#[test]
fn cuda_dynamic_shared_reports_invalid_options_declarations_and_layout_limits_cleanly() {
    for bytes in ["-1", "4294967296", "1,2", "words", ""] {
        let files = TestFiles::new("cu", "__global__ void empty() {}");
        let result = files.translate(&["--cuda-dynamic-shared-memory-size", bytes]);
        assert!(!result.status.success(), "accepted {bytes:?}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(
            diagnostic.contains("cuda-dynamic-shared-memory-size"),
            "{diagnostic}"
        );
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
    for (bytes, source) in [
        ("16", "__global__ void invalid() { extern __shared__ const int values[]; }"),
        ("16", "__global__ void invalid() { extern __shared__ int values[] = {1}; }"),
        ("16", "__global__ void integers() { extern __shared__ int values[]; } __global__ void floats() { extern __shared__ float values[]; }"),
        ("4294967295", "__global__ void invalid() { extern __shared__ int values[]; }"),
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&["--cuda-dynamic-shared-memory-size", bytes]);
        assert!(!result.status.success(), "accepted {source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(diagnostic.contains(&format!("{}:1:", files.input.display())), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}
