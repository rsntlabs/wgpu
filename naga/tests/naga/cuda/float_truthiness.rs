use naga::front::cuda::{parse_str, Options};

use super::helpers::validate;

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    (module, info)
}

#[test]
fn cuda_float_truthiness_uses_integer_predicates_and_evaluates_converted_values_once() {
    let (module, info) = roundtrip(
        "__device__ float observed(float value) { return value; }
        __global__ void kernel(const float *input, unsigned *output) {
            bool copied = input[0]; bool direct(input[0]); bool functional = bool(input[0]);
            bool named = static_cast<bool>(input[0]); bool c_style = (bool)input[0];
            const bool &retained = input[0]; bool branch = false;
            if (input[0]) branch = true;
            bool negated = !input[0]; bool conjunction = input[0] && input[1];
            bool disjunction = input[0] || input[1];
            int counter = 0; bool once = observed((counter++, input[0]));
            output[0] = unsigned(copied); output[1] = unsigned(direct);
            output[2] = unsigned(functional); output[3] = unsigned(named);
            output[4] = unsigned(c_style); output[5] = unsigned(retained);
            output[6] = unsigned(branch); output[7] = unsigned(negated);
            output[8] = unsigned(conjunction); output[9] = unsigned(disjunction);
            output[10] = unsigned(once); output[11] = unsigned(counter);
        }",
    );
    let mut integer_predicates = 0;
    for (function, function_info) in module
        .functions
        .iter()
        .map(|(handle, function)| (function, &info[handle]))
        .chain(core::iter::once((
            &module.entry_points[0].function,
            info.get_entry_point(0),
        )))
    {
        for (_, expression) in function.expressions.iter() {
            if let naga::Expression::Binary { op, left, right } = *expression {
                if matches!(
                    op,
                    naga::BinaryOperator::Equal
                        | naga::BinaryOperator::NotEqual
                        | naga::BinaryOperator::Less
                        | naga::BinaryOperator::LessEqual
                        | naga::BinaryOperator::Greater
                        | naga::BinaryOperator::GreaterEqual
                ) {
                    let left_scalar = function_info[left].ty.inner_with(&module.types).scalar();
                    let right_scalar = function_info[right].ty.inner_with(&module.types).scalar();
                    assert_ne!(left_scalar, Some(naga::Scalar::F32));
                    assert_ne!(right_scalar, Some(naga::Scalar::F32));
                    if op == naga::BinaryOperator::NotEqual
                        && left_scalar == Some(naga::Scalar::U32)
                        && right_scalar == Some(naga::Scalar::U32)
                    {
                        integer_predicates += 1;
                    }
                }
            }
        }
    }
    assert!(integer_predicates > 0);

    let function = &module.entry_points[0].function;
    let counter = function
        .local_variables
        .iter()
        .find_map(|(handle, local)| (local.name.as_deref() == Some("counter")).then_some(handle))
        .unwrap();
    let mut observed_calls = 0;
    let mut counter_stores = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        match *statement {
            naga::Statement::Call {
                function: target, ..
            } if module.functions[target].name.as_deref() == Some("observed") => {
                observed_calls += 1
            }
            naga::Statement::Store { pointer, .. } if matches!(function.expressions[pointer], naga::Expression::LocalVariable(local) if local == counter) => {
                counter_stores += 1
            }
            _ => {}
        }
        false
    });
    assert_eq!(observed_calls, 1);
    assert_eq!(counter_stores, 2);
}

#[test]
fn cuda_float_truthiness_preserves_the_existing_expression_graph_depth_boundary() {
    let source = |terms: usize| {
        format!(
        "__global__ void kernel(const float *input, unsigned *output) {{ bool present = (input[0]{}); if (present) output[0] = 1u; }}\n",
        " + 0.0f".repeat(terms - 1)
    )
    };
    for terms in [62, 63] {
        roundtrip(&source(terms));
    }
    let rejected = source(64);
    let error = parse_str(&rejected, &Options::default()).unwrap_err();
    assert!(
        error.message.contains("depth") && error.message.contains("limit"),
        "{error}"
    );
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(rejected.get(range).is_some());
}

fn barrier_roundtrip(source: &str) {
    let (module, info) = super::helpers::validate_with_options(
        source,
        &Options {
            workgroup_size: [4, 1, 1],
            ..Options::default()
        },
    );
    assert!(module
        .entry_points
        .iter()
        .all(|entry| entry.workgroup_size == [4, 1, 1]));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected_barrier(source: &str) {
    let error = parse_str(
        source,
        &Options {
            workgroup_size: [4, 1, 1],
            ..Options::default()
        },
    )
    .unwrap_err();
    assert!(error.message.contains("barrier"), "{source}: {error}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(source.get(range).is_some());
}

#[test]
fn cuda_float_truthiness_preserves_uniform_branch_and_loop_barriers() {
    for source in [
        "__global__ void kernel(float enabled) { if (enabled) __syncthreads(); }",
        "__global__ void kernel(const float *input) { if (input[0]) __syncthreads(); }",
        "__global__ void kernel(float enabled) { float copy = enabled; const float &view = copy; bool present = view; if (present) __syncthreads(); }",
        "__global__ void kernel() { float remaining = 3.0f; while (remaining) { __syncthreads(); remaining -= 1.0f; } }",
        "__global__ void kernel(float enabled) { for (float remaining = enabled; remaining; remaining -= 1.0f) __syncthreads(); }",
        "__global__ void kernel() { float remaining = 2.0f; do { __syncthreads(); remaining -= 1.0f; } while (remaining); }",
        "__global__ void kernel(const float *input) { bool first = input[0]; bool both = first && input[1]; if (both) __syncthreads(); }",
        "__global__ void kernel(float enabled, const float *input) { if (!enabled || input[0]) __syncthreads(); }",
        "__global__ void kernel() { if (float(blockIdx.x)) __syncthreads(); }",
        "__device__ float unused(float value); __global__ void warmup(const float *input, unsigned *out) { out[0] = unsigned(bool(input[0])); } __global__ void kernel(float enabled) { if (enabled) __syncthreads(); }",
    ] {
        barrier_roundtrip(source);
    }
}

#[test]
fn cuda_float_truthiness_preserves_uniform_calls_to_synchronizing_helpers() {
    for source in [
        "__device__ void synchronize(float enabled) { if (enabled) __syncthreads(); } __global__ void kernel(float enabled) { synchronize(enabled); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel(float enabled) { if (enabled) synchronize(); }",
        "__device__ void synchronize(float enabled) { float copy = enabled; while (copy) { __syncthreads(); copy -= 1.0f; } } __global__ void kernel(const float *input) { synchronize(input[0]); }",
        "__device__ void synchronize(float enabled); __global__ void kernel(float enabled) { synchronize(enabled); } __device__ void synchronize(float enabled) { if (enabled) __syncthreads(); }",
        "__device__ void inner(float enabled) { if (enabled) __syncthreads(); } __device__ void outer(float enabled) { inner(enabled); } __global__ void kernel(const float *input) { outer(input[0]); }",
    ] {
        barrier_roundtrip(source);
    }
}

#[test]
fn cuda_float_truthiness_keeps_nonuniform_and_opaque_barrier_conditions_rejected() {
    for source in [
        "__global__ void kernel() { if (float(threadIdx.x)) __syncthreads(); }",
        "__global__ void kernel(const float *input) { if (input[threadIdx.x]) __syncthreads(); }",
        "__global__ void kernel(float *input) { if (input[0]) __syncthreads(); }",
        "__global__ void kernel(const volatile float *input) { if (input[0]) __syncthreads(); }",
        "__global__ void kernel(float enabled) { float decision = enabled; if (threadIdx.x) decision = 0.0f; if (decision) __syncthreads(); }",
        "__global__ void kernel(float enabled) { float decision = enabled; float &view = decision; view = float(threadIdx.x); if (decision) __syncthreads(); }",
        "__global__ void kernel(float enabled) { float decision = float(threadIdx.x); bool saved = decision; decision = enabled; if (saved) __syncthreads(); }",
        "__global__ void kernel(float enabled) { float decision = enabled; for (unsigned iteration = 0u; iteration < 2u; ++iteration) { if (decision) __syncthreads(); decision = float(threadIdx.x); } }",
        "__device__ void synchronize(float enabled) { if (enabled) __syncthreads(); } __global__ void kernel() { synchronize(float(threadIdx.x)); }",
        "__device__ void synchronize() { __syncthreads(); } __global__ void kernel(const float *input) { if (input[threadIdx.x]) synchronize(); }",
        "__device__ float opaque(float value) { return value; } __global__ void kernel(float enabled) { if (opaque(enabled)) __syncthreads(); }",
        "__device__ unsigned _naga_fabsf(unsigned value) { return threadIdx.x + value; } __global__ void kernel(unsigned value) { if (_naga_fabsf(value)) __syncthreads(); }",
        "__device__ float unused(float value); __global__ void warmup(const float *input, unsigned *out) { out[0] = unsigned(bool(input[0])); } __device__ unsigned _naga_fabsf(unsigned value) { return threadIdx.x + value; } __global__ void kernel(unsigned value) { if (_naga_fabsf(value)) __syncthreads(); }",
    ] {
        rejected_barrier(source);
    }
}
