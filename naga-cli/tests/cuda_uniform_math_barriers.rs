mod common;

use common::TestFiles;

#[test]
fn cuda_uniform_math_barriers_cli_validates_cached_arithmetic_controls() {
    let expressions = [
        "floorf(value)",
        "ceilf(value)",
        "roundf(value)",
        "fabsf(value)",
        "sqrtf(value)",
        "fmodf(value, 2.0f)",
        "sinf(value)",
        "cosf(value)",
        "value / 2.0f",
        "rsqrtf(value)",
    ];
    let controls = expressions
        .iter()
        .map(|expression| format!("if ({expression} > 0.0f) {{ __syncthreads(); }}"))
        .collect::<Vec<_>>()
        .join("\n");
    let source = format!("__global__ void gate(unsigned *output, float value) {{ {controls} output[threadIdx.x] = 7u; }}");
    for compact in [false, true] {
        let files = TestFiles::new("cu", &source);
        let mut arguments = vec!["--cuda-workgroup-size", "4,1,1"];
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
        let mut workgroup_barriers = 0;
        let mut storage_barriers = 0;
        naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
            if let naga::Statement::ControlBarrier(flags) = statement {
                workgroup_barriers += usize::from(flags.contains(naga::Barrier::WORK_GROUP));
                storage_barriers += usize::from(flags.contains(naga::Barrier::STORAGE));
            }
            false
        });
        assert_eq!(workgroup_barriers, expressions.len());
        assert_eq!(storage_barriers, expressions.len());
        let resources: Vec<_> = module
            .global_variables
            .iter()
            .filter(|(_, global)| global.binding.is_some())
            .collect();
        assert_eq!(resources.len(), 2);
        let output = resources
            .iter()
            .find_map(|(_, global)| {
                (global.binding
                    == Some(naga::ResourceBinding {
                        group: 0,
                        binding: 0,
                    }))
                .then_some(*global)
            })
            .unwrap();
        assert_eq!(
            output.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
            }
        );
        let naga::TypeInner::Array { base, stride, .. } = module.types[output.ty].inner else {
            panic!("expected output storage array");
        };
        assert_eq!(stride, 4);
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        let uniform = resources
            .iter()
            .find_map(|(_, global)| {
                (global.space == naga::AddressSpace::Uniform).then_some(*global)
            })
            .unwrap();
        assert_eq!(
            uniform.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: 1
            })
        );
        let naga::TypeInner::Struct { ref members, .. } = module.types[uniform.ty].inner else {
            panic!("expected uniform scalar block");
        };
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        assert_eq!(
            module.types[members[0].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::F32)
        );
        assert!(module
            .types
            .iter()
            .all(|(_, ty)| ty.inner.scalar().is_none_or(|scalar| scalar.width <= 4)));
    }
}

#[test]
fn cuda_uniform_math_barriers_cli_rejects_varying_arithmetic_controls() {
    for expression in [
        "floorf(float(threadIdx.x))",
        "sinf(float(threadIdx.x))",
        "float(threadIdx.x) / 2.0f",
    ] {
        let source =
            format!("__global__ void gate() {{ if ({expression} > 0.0f) {{ __syncthreads(); }} }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&["--compact"]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}

#[test]
fn cuda_uniform_math_barriers_cli_keeps_user_overload_results_opaque() {
    for (declaration, expression) in [
        (
            "__device__ float floorf(int value) { return float(value); }",
            "floorf(int(value))",
        ),
        (
            "__device__ int floorf(unsigned value) { return int(value); }",
            "floorf(unsigned(value))",
        ),
    ] {
        let source = format!("{declaration} __global__ void gate(unsigned *output, float value) {{ output[0] = unsigned(floorf(value)); if ({expression} > 0) {{ __syncthreads(); }} }}");
        let files = TestFiles::new("cu", &source);
        let result = files.translate(&["--compact"]);
        assert!(!result.status.success(), "{source}");
        let diagnostic = String::from_utf8_lossy(&result.stderr);
        assert!(diagnostic.contains("Could not parse CUDA"), "{diagnostic}");
        assert!(!diagnostic.contains("panicked"), "{diagnostic}");
        assert!(!files.output.exists());
    }
}
