use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::validate_with_options_and_capabilities;

fn validate(source: &str) -> naga::Module {
    validate_with_options_and_capabilities(source, &Options::default(), Capabilities::SHADER_INT64)
        .0
}

fn reject(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(
        !range.is_empty() && source.get(range).is_some(),
        "{source}: {error}"
    );
    error
}

#[test]
fn cuda_multidimensional_parameters_merge_named_unnamed_and_alias_row_prototypes() {
    validate("using Row = int[3];
        __device__ int read(const int[][3]);
        __device__ int read(const Row *renamed);
        __device__ int read(const Row renamed[]);
        __device__ int read(const int values[99][3]) { static_assert(sizeof(values) == 8); static_assert(sizeof(*values) == 12); using Pointer = decltype(values); Pointer copy = values; return copy[1][2]; }
        __global__ void kernel(int *out) { int grid[2][3]{}; static_assert(sizeof(grid) == 24); grid[1][2] = 7; out[0] = read(grid); }");
}

#[test]
fn cuda_multidimensional_parameters_distinguish_inner_extents_and_element_constness() {
    validate("__device__ int shape(int values[][3]) { return 3; }
        __device__ int shape(int values[][4]) { return 4; }
        __device__ int access(int values[][3]) { values[0][0] = 1; return 1; }
        __device__ int access(const int values[][3]) { return 2; }
        __global__ void kernel(int *out) { int three[2][3]{}; int four[2][4]{}; const int fixed[2][3]{}; out[0] = shape(three); out[1] = shape(four); out[2] = access(three); out[3] = access(fixed); }");
    reject("__device__ void write(const int values[][3]) { values[0][0] = 1; } __global__ void kernel() {}");
    reject("__device__ int read(int values[][3]) { return values[0][0]; } __global__ void kernel(int *out) { int values[2][4]{}; out[0] = read(values); }");
}

#[test]
fn cuda_multidimensional_parameters_retain_rank_three_and_alias_base_dimension_order() {
    validate("using Row = int[3];
        __device__ int cube(int values[][2][3]) { static_assert(sizeof(values) == 8); static_assert(sizeof(*values) == 24); static_assert(sizeof(**values) == 12); return values[1][1][2]; }
        __device__ int blocks(Row values[][4]) { static_assert(sizeof(values) == 8); static_assert(sizeof(*values) == 48); static_assert(sizeof(**values) == 12); return values[1][3][2]; }
        __global__ void kernel(int *out) { int values[2][2][3]{}; Row groups[2][4]{}; values[1][1][2] = 7; groups[1][3][2] = 9; out[0] = cube(values); out[1] = blocks(groups); }");
}

#[test]
fn cuda_multidimensional_parameters_ignore_first_extent_storage_size_and_keep_argument_effects() {
    let module = validate("using Null = decltype(nullptr);
        __device__ unsigned next(unsigned &counter) { return counter++; }
        __device__ int read(Null erased, int values[4294967295u][3], const unsigned &index) { return values[index][2]; }
        __global__ void kernel(int *out) { int grid[2][3]{}; grid[0][2] = 7; unsigned counter = 0u; out[0] = read(nullptr, grid, next(counter)); out[1] = int(counter); }");
    let function = &module.entry_points[0].function;
    let counters: Vec<_> = function
        .local_variables
        .iter()
        .filter_map(|(handle, variable)| {
            (variable.name.as_deref() == Some("counter")).then_some(handle)
        })
        .collect();
    assert_eq!(counters.len(), 1);
    let mut increments = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            let root = super::helpers::root_expression(function, pointer);
            if matches!(function.expressions[root], naga::Expression::LocalVariable(local) if local == counters[0])
            {
                if let naga::Expression::Binary {
                    op: naga::BinaryOperator::Add,
                    left,
                    right,
                } = function.expressions[value]
                {
                    let naga::Expression::As {
                        expr: one,
                        target: naga::Scalar::U32,
                    } = function.expressions[right]
                    else {
                        panic!("counter increment must convert its one to U32");
                    };
                    assert!(matches!(
                        function.expressions[one],
                        naga::Expression::Literal(naga::Literal::I32(1))
                    ));
                    let naga::Expression::Load { pointer: previous } = function.expressions[left]
                    else {
                        panic!("increment must read the counter");
                    };
                    assert!(
                        matches!(function.expressions[super::helpers::root_expression(function, previous)], naga::Expression::LocalVariable(local) if local == counters[0])
                    );
                    increments += 1;
                }
            }
        }
        false
    });
    assert_eq!(
        increments, 1,
        "captured reference argument must be evaluated once"
    );
}

#[test]
fn cuda_multidimensional_parameters_preserve_vector_record_and_source_long_elements() {
    let module = validate("struct Record { float3 position; unsigned tag; };
        __device__ unsigned vector_one(uint1 values[][2]) { return values[0][1].x; }
        __device__ float vector_three(float3 values[][2]) { return values[0][1].z; }
        __device__ unsigned record(Record values[][2]) { return values[0][1].tag; }
        __device__ int kind(long value) { return 1; } __device__ int kind(long long value) { return 2; }
        __device__ int word(long values[][3]) { return kind(values[0][0]); }
        __device__ int word(long long values[][3]) { return kind(values[0][0]); }
        __global__ void kernel(unsigned *out) { uint1 one[1][2]{}; float3 three[1][2]{}; Record records[1][2]{}; long first[1][3]{}; long long second[1][3]{}; out[0] = vector_one(one) + unsigned(vector_three(three)) + record(records); out[1] = unsigned(word(first)); out[2] = unsigned(word(second)); }");
    let mut tags = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let callee = &module.functions[function];
            if callee
                .name
                .as_deref()
                .is_some_and(|name| name.starts_with("kind"))
            {
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
        }
        false
    });
    assert_eq!(tags, [1, 2]);
}

#[test]
fn cuda_multidimensional_parameters_expose_kernel_row_storage_strides_and_bindings() {
    let module = validate("__global__ void kernel(int output[][3], const int input[2][3]) { output[1][2] = input[1][2]; }");
    let mut resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
        .collect();
    resources.sort_by_key(|(binding, _)| binding.binding);
    assert_eq!(resources.len(), 2);
    for (index, (binding, global)) in resources.into_iter().enumerate() {
        assert_eq!(
            binding,
            naga::ResourceBinding {
                group: 0,
                binding: index as u32
            }
        );
        assert_eq!(
            global.space,
            naga::AddressSpace::Storage {
                access: if index == 0 {
                    naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                } else {
                    naga::StorageAccess::LOAD
                }
            }
        );
        let naga::TypeInner::Array {
            base: row, stride, ..
        } = module.types[global.ty].inner
        else {
            panic!("expected runtime row array");
        };
        assert_eq!(stride, 12);
        let naga::TypeInner::Array { base, stride, size } = module.types[row].inner else {
            panic!("expected retained fixed-size row");
        };
        assert_eq!(stride, 4);
        assert_eq!(
            size,
            naga::ArraySize::Constant(core::num::NonZeroU32::new(3).unwrap())
        );
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::I32)
        );
    }
    validate("__global__ void kernel(int output[2], const int input[]) { output[0] = input[0]; }");
    validate("struct R { unsigned value; }; __global__ void kernel(float3 output[][2], const R input[][2]) { output[0][1].x = float(input[0][1].value); }");
    for parameter in ["short3 value", "ushort1 value", "R value"] {
        reject(&format!(
            "struct R {{ unsigned value[2]; }}; __global__ void kernel({parameter}) {{}}"
        ));
    }
}

#[test]
fn cuda_multidimensional_parameters_reject_invalid_shapes_and_preserve_template_boundaries() {
    for parameter in [
        "int values[2][]",
        "int values[][0]",
        "int values[][missing]",
        "int *values[2][3]",
        "int (&values)[2][3]",
    ] {
        reject(&format!(
            "__device__ void invalid({parameter}) {{}} __global__ void kernel() {{}}"
        ));
    }
    reject("__device__ void invalid(unsigned count, int values[][count]) {} __global__ void kernel() {}");
    for source in [
        "template<class T> __device__ int invalid(T values[2][3]) { return 1; } __global__ void kernel() {}",
        "template<class T> __device__ int invalid(int values[][3]) { return 1; } __global__ void kernel(int *out) { int values[2][3]{}; out[0] = invalid<unsigned>(values); }",
        "template<class T> __global__ void invalid(T values[2][3]) {}",
    ] { reject(source); }
    validate("using Row = int[3]; template<int N> __device__ int supported(Row *values) { return values[0][0] + N; } __global__ void kernel(int *out) { Row values[2]{}; out[0] = supported<0>(values); }");
    let parameter = format!("int values[]{}", "[1]".repeat(100));
    let error = reject(&format!(
        "__device__ void invalid({parameter}) {{}} __global__ void kernel() {{}}"
    ));
    assert!(
        error.message.contains("depth")
            || error.message.contains("dimension")
            || error.message.contains("rank")
    );
}
