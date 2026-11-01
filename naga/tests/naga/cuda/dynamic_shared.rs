use naga::front::cuda::{parse_str, Options};

use super::helpers::validate_with_options;

const FIXTURE: &str = include_str!("../../in/cuda/dynamic-shared.cu");

fn options(bytes: u32) -> Options {
    Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: bytes,
    }
}

fn roundtrip(source: &str, bytes: u32) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options(source, &options(bytes));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

fn rejected(source: &str, bytes: u32) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &options(bytes)).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn shared(module: &naga::Module) -> Vec<naga::Handle<naga::GlobalVariable>> {
    module
        .global_variables
        .iter()
        .filter_map(|(handle, global)| {
            (global.space == naga::AddressSpace::WorkGroup).then_some(handle)
        })
        .collect()
}

fn array_layout(
    module: &naga::Module,
    global: naga::Handle<naga::GlobalVariable>,
) -> (naga::Handle<naga::Type>, u32, u32) {
    let variable = &module.global_variables[global];
    assert_eq!(variable.binding, None);
    assert_eq!(variable.init, None);
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Constant(count),
        stride,
    } = module.types[variable.ty].inner
    else {
        panic!("expected specialized workgroup storage");
    };
    (base, count.get(), stride)
}

#[test]
fn cuda_dynamic_shared_preserves_numeric_vector_record_and_inner_array_layouts() {
    for (name, scalar) in [
        ("float", naga::Scalar::F32),
        ("int", naga::Scalar::I32),
        ("uint", naga::Scalar::U32),
    ] {
        for (width, stride, alignment) in [(1, 4, 4), (2, 8, 8), (3, 12, 4), (4, 16, 16)] {
            let kind = if width == 1 {
                if name == "uint" {
                    String::from("unsigned")
                } else {
                    String::from(name)
                }
            } else {
                format!("{name}{width}")
            };
            let value = if width == 1 {
                String::from("3")
            } else {
                format!("make_{kind}({})", vec!["3"; width].join(", "))
            };
            let (module, _) = roundtrip(
                &format!(
                    "__global__ void kernel({kind} *output) {{
                    extern __shared__ {kind} values[];
                    values[0] = {value}; output[0] = values[0];
                }}"
                ),
                stride + 1,
            );
            let globals = shared(&module);
            assert_eq!(globals.len(), 1);
            let (base, count, actual_stride) = array_layout(&module, globals[0]);
            assert_eq!((count, actual_stride), (2, stride));
            let mut layouter = naga::proc::Layouter::default();
            layouter.update(module.to_ctx()).unwrap();
            assert_eq!(layouter[base].size, stride);
            assert_eq!(
                layouter[base].alignment,
                naga::proc::Alignment::new(alignment).unwrap()
            );
            match &module.types[base].inner {
                naga::TypeInner::Scalar(actual) => {
                    assert_eq!(width, 1);
                    assert_eq!(*actual, scalar);
                }
                naga::TypeInner::Vector {
                    size,
                    scalar: actual,
                } => {
                    assert_eq!(*size as usize, width);
                    assert_eq!(*actual, scalar);
                }
                naga::TypeInner::Struct { members, span } => {
                    assert_eq!((width, *span, members.len()), (3, 12, 3));
                    for (index, member) in members.iter().enumerate() {
                        assert_eq!(member.offset, index as u32 * 4);
                        assert_eq!(
                            module.types[member.ty].inner,
                            naga::TypeInner::Scalar(scalar)
                        );
                    }
                }
                _ => panic!("unexpected numeric element type"),
            }
        }
    }
    let (module, _) = roundtrip(
        "struct Record { unsigned marker; int2 pair; int values[2]; };
        using Item = Record;
        __global__ void kernel(Record *output) {
            extern __shared__ Item records[];
            records[0] = Record{7u, {2, 3}, {5, 11}};
            output[0] = records[0];
        }",
        25,
    );
    let (base, count, stride) = array_layout(&module, shared(&module)[0]);
    assert_eq!((count, stride), (2, 24));
    let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
        panic!("expected the nominal record");
    };
    assert_eq!(span, 24);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 8, 16]
    );
    let (module, _) = roundtrip(
        "__global__ void kernel(int *output) { extern __shared__ int rows[][3]; rows[0][2] = 7; output[0] = rows[0][2]; }", 13,
    );
    let (row, count, stride) = array_layout(&module, shared(&module)[0]);
    assert_eq!((count, stride), (2, 12));
    assert!(
        matches!(module.types[row].inner, naga::TypeInner::Array { size: naga::ArraySize::Constant(count), stride: 4, .. } if count.get() == 3)
    );
}

#[test]
fn cuda_dynamic_shared_aliases_external_names_without_merging_static_storage() {
    let (module, info) = roundtrip(FIXTURE, 16);
    let globals = shared(&module);
    assert_eq!(globals.len(), 2);
    assert!(globals
        .iter()
        .all(|&handle| !info.get_entry_point(0)[handle].is_empty()));
    for &handle in &globals {
        assert_eq!(array_layout(&module, handle).1, 4);
    }
    roundtrip(
        "using Integer = int;
        extern __shared__ Integer values[];
        extern __shared__ signed int values[];
        __device__ void fill(int value) { extern __shared__ int helper_values[]; helper_values[0] = value; }
        __global__ void kernel(int *output) {
            extern __shared__ int values[];
            extern __shared__ Integer values[];
            fill(7);
            { extern __shared__ int nested_values[]; output[0] = nested_values[0]; }
            output[1] = values[0];
        }", 4,
    );
    let (module, info) = roundtrip(
        "__device__ void unused() { extern __shared__ float unused_values[]; unused_values[0] = 2.0f; }
        __global__ void kernel(int *output) {
            extern __shared__ float ignored_values[];
            extern __shared__ int used_values[];
            used_values[0] = 7; output[0] = used_values[0];
        }", 4,
    );
    let live_shared: Vec<_> = shared(&module)
        .into_iter()
        .filter(|&global| !info.get_entry_point(0)[global].is_empty())
        .collect();
    assert_eq!(live_shared.len(), 1);
    let (base, count, stride) = array_layout(&module, live_shared[0]);
    assert_eq!((count, stride), (1, 4));
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    for global in shared(&module) {
        let (base, _, _) = array_layout(&module, global);
        if module.types[base].inner == naga::TypeInner::Scalar(naga::Scalar::F32) {
            assert!(info.get_entry_point(0)[global].is_empty());
        }
    }
    for declaration in [
        "extern __shared__ int unused[];",
        "extern __shared__ float3 unused[];",
    ] {
        let (module, _) = roundtrip(&format!("__global__ void empty() {{ {declaration} }}"), 0);
        assert!(module.entry_points[0].function.body.is_empty());
        assert!(shared(&module).is_empty());
    }
}

#[test]
fn cuda_dynamic_shared_preserves_discarded_addresses_without_exposing_constant_values() {
    for bytes in [0, 16, 64] {
        for expression in [
            "(values, 4)",
            "(values[0], 4)",
            "(&values[0], 4)",
            "(values + 0, 4)",
            "(+values, 4)",
            "(values[64], 4)",
            "(&values[64], 4)",
        ] {
            let source = format!("__global__ void kernel() {{ extern __shared__ int values[]; constexpr int Count = {expression}; int local[Count]; }}");
            roundtrip(&source, bytes);
        }
        for body in [
            "int &reference = values[0]; constexpr int Count = (&reference, 4);",
            "int &reference = values[0]; constexpr int Count = (reference, 4);",
            "const int &reference = values[0]; constexpr int Count = (&reference, 4);",
        ] {
            roundtrip(
                &format!("__global__ void kernel() {{ extern __shared__ int values[]; {body} }}"),
                bytes,
            );
        }
        for declaration in [
            "constexpr int *pointer = values;",
            "constexpr int *pointer = &values[0];",
            "constexpr int &reference = values[0];",
        ] {
            rejected(
                &format!(
                    "__global__ void kernel() {{ extern __shared__ int values[]; {declaration} }}"
                ),
                bytes,
            );
        }
        roundtrip("__global__ void kernel(int *output) { extern __shared__ int values[]; constexpr int Count = true ? 4 : values[0]; int local[Count]{}; output[0] = local[3]; }", bytes);
    }
    roundtrip("__global__ void kernel() { __shared__ int values[4]; constexpr int Count = (&values[0], 4); int local[Count]; }", 16);
    rejected("__global__ void kernel() { extern __shared__ int values[]; constexpr int Count = values[0]; }", 16);
    rejected("__global__ void kernel() { extern __shared__ int values[]; values[0] = 4; constexpr int Count = values[0]; }", 16);
    rejected("__global__ void kernel() { extern __shared__ int values[]; unsigned index = threadIdx.x; constexpr int Count = (&values[index++], 4); }", 16);
    rejected(
        "__global__ void kernel() { extern __shared__ int values[]; int local[values[0]]; }",
        16,
    );
}

#[test]
fn cuda_dynamic_shared_reuses_pointer_reference_auto_and_atomic_paths() {
    for kind in ["int", "unsigned"] {
        roundtrip(
            &format!(
                "__device__ {kind} add({kind} *value) {{ return atomicAdd(value, 3); }}
            __device__ void advance({kind} &value) {{ ++value; }}
            __global__ void kernel({kind} *output) {{
                extern __shared__ {kind} values[];
                __shared__ {kind} fixed[4];
                unsigned lane = threadIdx.x;
                values[lane] = lane + 10u; fixed[lane] = lane + 30u;
                __syncthreads();
                auto pointer = values;
                {kind} &saved = pointer[lane];
                {kind} *selected = lane % 2u ? &saved : &fixed[lane];
                output[lane] = add(selected);
                advance(saved);
                __syncthreads();
                output[4u + lane] = values[lane];
            }}"
            ),
            16,
        );
    }
    roundtrip(
        "struct Counter { int value; int marker; };
        __device__ Counter copied(Counter value) { value.marker += 2; return value; }
        __global__ void kernel(Counter *output) {
            extern __shared__ Counter values[];
            values[threadIdx.x] = Counter{3, 5};
            __syncthreads();
            int previous = atomicAdd(&values[threadIdx.x].value, 4);
            output[threadIdx.x] = copied(values[threadIdx.x]);
            output[threadIdx.x].marker += previous;
        }",
        32,
    );
}

#[test]
fn cuda_dynamic_shared_isolates_entries_and_checks_complete_nominal_view_types() {
    let (module, info) = roundtrip(
        "__device__ int read_integer() { extern __shared__ int integers[]; return integers[threadIdx.x]; }
        __device__ float read_float() { extern __shared__ float floats[]; return floats[threadIdx.x]; }
        __global__ void integer_kernel(int *output) {
            extern __shared__ int integers[]; integers[threadIdx.x] = 7; output[threadIdx.x] = read_integer();
        }
        __global__ void empty() {}
        __global__ void float_kernel(float *output) {
            extern __shared__ float floats[]; floats[threadIdx.x] = 2.5f; output[threadIdx.x] = read_float();
        }", 16,
    );
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["integer_kernel", "empty", "float_kernel"]
    );
    let globals = shared(&module);
    assert_eq!(globals.len(), 2);
    for entry in [0, 2] {
        let used: Vec<_> = globals
            .iter()
            .copied()
            .filter(|&global| !info.get_entry_point(entry)[global].is_empty())
            .collect();
        assert_eq!(used.len(), 1);
        assert!(info.get_entry_point(2 - entry)[used[0]].is_empty());
        assert!(info.get_entry_point(1)[used[0]].is_empty());
    }
    for source in [
        "__global__ void first() { extern __shared__ int same[]; } __global__ void second() { extern __shared__ float same[]; }",
        "__global__ void kernel(int *output) { extern __shared__ int integers[]; extern __shared__ float floats[]; integers[0] = 3; floats[0] = 2.0f; output[0] = integers[0] + int(floats[0]); }",
        "__device__ float read() { extern __shared__ float floats[]; return floats[0]; } __global__ void kernel(int *output) { extern __shared__ int integers[]; integers[0] = 3; output[0] = integers[0] + int(read()); }",
        "struct First { int value; }; struct Second { int value; }; __global__ void kernel(int *output) { extern __shared__ First first[]; extern __shared__ Second second[]; first[0].value = 3; second[0].value = 5; output[0] = first[0].value + second[0].value; }",
        "__global__ void kernel(int *output) { extern __shared__ int first[][2]; extern __shared__ int second[][3]; first[0][0] = 3; second[0][0] = 5; output[0] = first[0][0] + second[0][0]; }",
    ] { rejected(source, 64); }
}

#[test]
fn cuda_dynamic_shared_preserves_declaration_barrier_scope_and_resource_limits() {
    for declaration in [
        "extern __shared__ bool values[];",
        "extern __shared__ const int values[];",
        "extern __shared__ int *values[];",
        "extern __shared__ dim3 values[];",
        "extern __shared__ int values[4];",
        "extern __shared__ int value;",
        "extern __shared__ int values[] = {};",
        "extern __shared__ int values[][];",
        "extern __shared__ int values[][0];",
    ] {
        rejected(&format!("__global__ void kernel() {{ {declaration} }}"), 32);
        rejected(
            &format!("__global__ void kernel() {{ return; {declaration} }}"),
            32,
        );
    }
    for source in [
        "__global__ void kernel() { { extern __shared__ int hidden[]; } hidden[0] = 7; }",
        "__global__ void kernel(int *values) { extern __shared__ int values[]; }",
        "__device__ void invalid() { __shared__ int fixed[4]; } __global__ void kernel() {}",
        "__device__ void invalid() { extern __shared__ int values[]; __syncthreads(); } __global__ void kernel() { invalid(); }",
        "__global__ void kernel() { extern __shared__ int values[]; if (threadIdx.x) __syncthreads(); }",
        "__global__ void kernel() { extern __shared__ int values[]; if (threadIdx.x) return; __syncthreads(); }",
    ] { rejected(source, 16); }
    let error = rejected(
        "__global__ void kernel() { extern __shared__ int values[]; }",
        u32::MAX,
    );
    assert!(error.message.contains("limit"), "{error}");
    let nested = format!(
        "__global__ void kernel() {{ {}extern __shared__ int values[];{} }}",
        "{".repeat(80),
        "}".repeat(80)
    );
    rejected(&nested, 16);
    let mut source = String::from("__global__ void kernel(int *output) {");
    for index in 0..96 {
        source.push_str(&format!(
            "extern __shared__ int values{index}[]; values{index}[0] = {index};"
        ));
    }
    source.push_str("output[0] = values0[0]; }");
    let (module, _) = roundtrip(&source, 4);
    assert_eq!(shared(&module).len(), 1);
    assert!(module.entry_points[0].function.expressions.len() < 4096);
}
