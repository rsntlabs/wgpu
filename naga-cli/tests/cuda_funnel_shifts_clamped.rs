mod common;

use common::TestFiles;

#[test]
fn cuda_funnel_shifts_clamped_cli_preserves_unsigned_interface_and_safe_dynamic_counts() {
    let source = r#"__device__ unsigned __funnelshift_lc(unsigned low, unsigned high, unsigned shift);
        __device__ unsigned __funnelshift_rc(unsigned low, unsigned high, unsigned shift);
        __device__ unsigned kind(unsigned value) { return value; }
        __device__ unsigned kind(int value) { return 99u; }
        template<class Value> __global__ void funnel(Value *output, const Value *input) {
            unsigned index = threadIdx.x;
            output[index * 2u] = kind(__funnelshift_lc(input[0], input[1], input[2]));
            output[index * 2u + 1u] = kind(__funnelshift_rc(input[0], input[1], input[2]));
        }
        template __global__ void funnel<unsigned>(unsigned *, const unsigned *);"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let mut arguments = vec![
            "--entry-point",
            "funnel<unsigned>",
            "--cuda-workgroup-size",
            "4,1,1",
        ];
        if compact {
            arguments.push("--compact");
        }
        let result = files.translate(&arguments);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        let module = files.read_module();
        assert_eq!(module.entry_points.len(), 1);
        assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
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
            let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
                panic!("expected storage array");
            };
            assert_eq!(stride, 4);
            assert_eq!(
                module.types[base].inner,
                naga::TypeInner::Scalar(naga::Scalar::U32)
            );
            if index == 1 {
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD
                    }
                );
            }
        }
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
        let mut shifts = 0;
        let mut masks = 0;
        let mut clamped_selections = 0;
        let mut unsigned_kind_calls = 0;
        for function in module
            .functions
            .iter()
            .map(|(_, function)| function)
            .chain(module.entry_points.iter().map(|entry| &entry.function))
        {
            naga::proc::any_statement(&function.body, &mut |statement| {
                if let naga::Statement::Call { function, .. } = *statement {
                    let callee = &module.functions[function];
                    if callee
                        .name
                        .as_deref()
                        .is_some_and(|name| name.starts_with("kind"))
                    {
                        assert_eq!(
                            module.types[callee.arguments[0].ty].inner,
                            naga::TypeInner::Scalar(naga::Scalar::U32)
                        );
                        unsigned_kind_calls += 1;
                    }
                }
                false
            });
            for (_, expression) in function.expressions.iter() {
                if let naga::Expression::Select { condition, .. } = *expression {
                    if let naga::Expression::Binary {
                        op: naga::BinaryOperator::GreaterEqual,
                        left,
                        right,
                    } = function.expressions[condition]
                    {
                        if matches!(
                            function.expressions[right],
                            naga::Expression::Literal(naga::Literal::U32(32))
                        ) {
                            assert!(
                                !matches!(
                                    function.expressions[left],
                                    naga::Expression::Binary {
                                        op: naga::BinaryOperator::And,
                                        ..
                                    }
                                ),
                                "clamping must inspect the raw count"
                            );
                            clamped_selections += 1;
                        }
                    }
                }
                if let naga::Expression::Binary { op, right, .. } = *expression {
                    if matches!(
                        op,
                        naga::BinaryOperator::ShiftLeft | naga::BinaryOperator::ShiftRight
                    ) {
                        shifts += 1;
                        assert!(
                            !matches!(function.expressions[right], naga::Expression::Literal(_)),
                            "dynamic funnel counts must remain bounded expressions"
                        );
                    }
                    if op == naga::BinaryOperator::And
                        && matches!(
                            function.expressions[right],
                            naga::Expression::Literal(naga::Literal::U32(31))
                        )
                    {
                        masks += 1;
                    }
                }
            }
        }
        assert_eq!(unsigned_kind_calls, 2);
        assert_eq!(shifts, 4);
        assert_eq!(clamped_selections, 2);
        assert!(masks >= 4, "both counts of each funnel must be masked");
    }
}

#[test]
fn cuda_funnel_shifts_clamped_cli_resolves_scalar_user_overloads() {
    let files = TestFiles::new(
        "cu",
        r#"__device__ int __funnelshift_lc(int low, int high, int shift) { return low + high + shift; }
        __device__ int __funnelshift_rc(int low, int high, int shift) { return low - high - shift; }
        __global__ void kernel(int *output, const int *input) {
            output[0] = __funnelshift_lc(input[0], input[1], input[2]);
            output[1] = __funnelshift_rc(input[0], input[1], input[2]);
        }"#,
    );
    let result = files.translate(&["--compact"]);
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    let module = files.read_module();
    assert!(module.entry_points[0]
        .function
        .expressions
        .iter()
        .all(|(_, expression)| !matches!(
            expression,
            naga::Expression::Binary {
                op: naga::BinaryOperator::ShiftLeft | naga::BinaryOperator::ShiftRight,
                ..
            }
        )));
}

#[test]
fn cuda_funnel_shifts_clamped_cli_rejects_invalid_calls_and_reserved_signatures() {
    for source in [
        "__device__ unsigned __funnelshift_lc(unsigned a, unsigned b, unsigned c) { return a; } __global__ void kernel() {}",
        "__device__ int __funnelshift_rc(unsigned a, unsigned b, unsigned c); __global__ void kernel() {}",
        "__global__ void kernel() { __funnelshift_lc(1u, 2u); }",
        "__global__ void kernel() { static_assert(__funnelshift_rc(1u, 2u, 32u) == 2u); }",
        "__global__ void kernel(unsigned *pointer) { __funnelshift_rc(pointer, 2u, 3u); }",
        "__global__ void kernel() { __funnelshift_lc(uint2(1u), 2u, 3u); }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}
