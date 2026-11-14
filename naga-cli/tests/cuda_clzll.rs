mod common;

use common::TestFiles;

fn check_leading_zero_operations(
    module: &naga::Module,
    expected: usize,
    expected_kind_calls: usize,
) {
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(module)
    .unwrap();
    let mut pending = vec![(&module.entry_points[0].function, info.get_entry_point(0))];
    let mut visited = Vec::new();
    let mut operations = 0;
    let mut kind_calls = 0;
    while let Some((function, function_info)) = pending.pop() {
        for (handle, expression) in function.expressions.iter() {
            if let naga::Expression::Math {
                fun: naga::MathFunction::CountLeadingZeros,
                arg,
                ..
            } = *expression
            {
                operations += 1;
                for value in [handle, arg] {
                    assert_eq!(
                        function_info[value].ty.inner_with(&module.types),
                        &naga::TypeInner::Scalar(naga::Scalar::U32)
                    );
                }
            }
        }
        naga::proc::any_statement(&function.body, &mut |statement| {
            if let naga::Statement::Call { function, .. } = *statement {
                let callee = &module.functions[function];
                if callee
                    .name
                    .as_deref()
                    .is_some_and(|name| name.starts_with("kind"))
                {
                    kind_calls += 1;
                    assert_eq!(
                        module.types[callee.arguments[0].ty].inner,
                        naga::TypeInner::Scalar(naga::Scalar::I32)
                    );
                }
                if !visited.contains(&function) {
                    visited.push(function);
                    pending.push((callee, &info[function]));
                }
            }
            false
        });
    }
    assert_eq!(operations, expected);
    assert_eq!(kind_calls, expected_kind_calls);
}

#[test]
fn cuda_clzll_cli_preserves_signed_word_identity_and_count_result_through_entry_selection() {
    let source = "using Wide = long long;
        using Native = long;
        __device__ int __clzll(const Wide value);
        __device__ int __clzll(Native value) { return int(value & 1L) + 77; }
        __device__ int kind(int value) { return value; }
        __device__ int kind(long long value) { return -7; }
        template<class Value> __global__ void leading(int *output, const Value *input) {
            unsigned index = threadIdx.x;
            output[index] = kind(__clzll(input[index]));
        }
        template __global__ void leading<Wide>(int *, const Wide *);
        template __global__ void leading<Native>(int *, const Native *);";
    for (entry, operations) in [("leading<long long>", 2), ("leading<long>", 0)] {
        for compact in [false, true] {
            let files = TestFiles::new("cu", source);
            let mut arguments = vec!["--entry-point", entry, "--cuda-workgroup-size", "4,1,1"];
            if compact {
                arguments.push("--compact");
            }
            let result = files.translate(&arguments);
            assert!(
                result.status.success(),
                "{}",
                String::from_utf8_lossy(&result.stderr)
            );
            let module =
                files.read_module_with_capabilities(naga::valid::Capabilities::SHADER_INT64);
            assert_eq!(module.entry_points.len(), 1);
            assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
            let mut resources: Vec<_> = module
                .global_variables
                .iter()
                .filter_map(|(_, global)| global.binding.map(|binding| (binding, global)))
                .collect();
            resources.sort_by_key(|(binding, _)| binding.binding);
            assert_eq!(resources.len(), 2);
            for (expected_binding, (binding, global)) in resources.into_iter().enumerate() {
                assert_eq!(
                    binding,
                    naga::ResourceBinding {
                        group: 0,
                        binding: expected_binding as u32
                    }
                );
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected storage array");
                };
                let scalar = if expected_binding == 0 {
                    naga::Scalar::I32
                } else {
                    naga::Scalar::I64
                };
                assert_eq!(stride, u32::from(scalar.width));
                assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
            }
            check_leading_zero_operations(&module, operations, 1);
        }
    }
}

#[test]
fn cuda_clzll_cli_does_not_require_wide_types_for_a_source_boolean_overload() {
    let files = TestFiles::new(
        "cu",
        "__device__ int __clzll(bool value) { return value ? 5 : 7; }
        __global__ void kernel(int *output) { output[0] = __clzll(true); }",
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert!(module
        .types
        .iter()
        .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    check_leading_zero_operations(&module, 0, 0);
}

#[test]
fn cuda_clzll_cli_rejects_malformed_calls_and_changes_to_the_predefined_signature() {
    for source in [
        "__global__ void kernel() { __clzll(); }",
        "__global__ void kernel() { __clzll(1LL, 2LL); }",
        "__global__ void kernel() { int __clzll = 0; __clzll(1LL); }",
        "__device__ unsigned __clzll(long long value); __global__ void kernel() {}",
        "__device__ int __clzll(long long value) { return 7; } __global__ void kernel() {}",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists(), "{source}");
    }
}
