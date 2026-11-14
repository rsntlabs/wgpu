mod common;

use common::TestFiles;

fn check_reverse_operations(module: &naga::Module, expected: usize) {
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::SHADER_INT64,
    )
    .validate(module)
    .unwrap();
    let mut pending = vec![(&module.entry_points[0].function, info.get_entry_point(0))];
    let mut visited = Vec::new();
    let mut operations = 0;
    while let Some((function, function_info)) = pending.pop() {
        for (handle, expression) in function.expressions.iter() {
            if let naga::Expression::Math {
                fun: naga::MathFunction::ReverseBits,
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
                if !visited.contains(&function) {
                    visited.push(function);
                    pending.push((&module.functions[function], &info[function]));
                }
            }
            false
        });
    }
    assert_eq!(operations, expected);
}

#[test]
fn cuda_brevll_cli_preserves_source_word_identity_when_selecting_typed_entries() {
    let source = "using Word = unsigned long long;
        using NativeWord = unsigned long;
        __device__ Word __brevll(const Word value);
        __device__ NativeWord __brevll(NativeWord value) { return value; }
        template<class Value> __global__ void reverse(Value *output, const Value *input) {
            unsigned index = threadIdx.x;
            output[index] = __brevll(input[index]);
        }
        template __global__ void reverse<Word>(Word *, const Word *);
        template __global__ void reverse<NativeWord>(NativeWord *, const NativeWord *);";
    for (entry, operations) in [
        ("reverse<unsigned long long>", 2),
        ("reverse<unsigned long>", 0),
    ] {
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
            let resources: Vec<_> = module
                .global_variables
                .iter()
                .filter_map(|(_, global)| global.binding.map(|binding| (binding.binding, global)))
                .collect();
            assert_eq!(resources.len(), 2);
            for (binding, global) in resources {
                assert!(binding < 2);
                let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner
                else {
                    panic!("expected wide storage array");
                };
                assert_eq!(stride, 8);
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U64)
                );
            }
            check_reverse_operations(&module, operations);
        }
    }
}

#[test]
fn cuda_brevll_cli_keeps_unused_wide_builtin_types_out_of_source_overloads() {
    let files = TestFiles::new(
        "cu",
        "__device__ unsigned __brevll(bool value) { return value ? 7u : 9u; }
        __global__ void kernel(unsigned *output) { output[0] = __brevll(true); }",
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
    check_reverse_operations(&module, 0);
}

#[test]
fn cuda_brevll_cli_rejects_malformed_calls_and_canonical_signature_changes() {
    for source in [
        "__global__ void kernel() { __brevll(); }",
        "__global__ void kernel() { __brevll(1ULL, 2ULL); }",
        "__global__ void kernel() { int __brevll = 0; __brevll(1ULL); }",
        "__device__ unsigned __brevll(unsigned long long value); __global__ void kernel() {}",
        "__device__ unsigned long long __brevll(unsigned long long value) { return 0ULL; } __global__ void kernel() {}",
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
