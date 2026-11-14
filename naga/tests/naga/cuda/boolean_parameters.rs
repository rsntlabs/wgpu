use naga::front::cuda::{parse_str, Options};

use super::helpers::{
    source_binding_initializer, validate, validate_with_options_and_capabilities,
};

#[test]
fn cuda_boolean_parameters_use_unsigned_uniform_storage_and_boolean_locals() {
    let (module, info) = validate(
        "using Flag = bool; __global__ void kernel(Flag enabled, int *output, const bool disabled) {
            output[0] = int(enabled) + int(disabled);
        }",
    );
    let function = &module.entry_points[0].function;
    for (index, name) in [(0, "enabled"), (2, "disabled")] {
        let (_, global) = module
            .global_variables
            .iter()
            .find(|(_, global)| global.name.as_deref() == Some(name))
            .unwrap();
        assert_eq!(global.space, naga::AddressSpace::Uniform);
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index,
            })
        );
        let naga::TypeInner::Struct { members, span } = &module.types[global.ty].inner else {
            panic!("Boolean parameter must use a uniform block");
        };
        assert_eq!(*span, 16);
        assert_eq!(members.len(), 1);
        assert_eq!(members[0].offset, 0);
        assert_eq!(
            module.types[members[0].ty].inner,
            naga::TypeInner::Scalar(naga::Scalar::U32)
        );
        let initializer = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[initializer]
                .ty
                .inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::BOOL)
        );
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_boolean_parameters_preserve_source_layout_and_overloads() {
    let (module, _) = validate_with_options_and_capabilities(
        "using Flag = bool;
        __device__ int category(bool value) { return 1; }
        __device__ int category(int value) { return 2; }
        __global__ void kernel(Flag flag, int *output) {
            static_assert(sizeof(flag) == 1);
            static_assert(alignof(Flag) == 1);
            output[0] = category(flag);
            output[1] = category(+flag);
        }",
        &Options::default(),
        naga::valid::Capabilities::SHADER_INT64,
    );
    let mut argument_types = Vec::new();
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            let ty = module.functions[function].arguments[0].ty;
            argument_types.push(module.types[ty].inner.clone());
        }
        false
    });
    assert_eq!(
        argument_types,
        [
            naga::TypeInner::Scalar(naga::Scalar::BOOL),
            naga::TypeInner::Scalar(naga::Scalar::I32),
        ]
    );
}

#[test]
fn cuda_boolean_parameters_support_local_references_and_mutation() {
    validate(
        "__device__ void flip(bool &value) { value = !value; }
        __device__ bool observe(const bool &value) { return value; }
        __global__ void kernel(bool flag, unsigned *output) {
            bool &reference = flag;
            flip(reference);
            output[0] = unsigned(observe(flag));
            flag = false;
            output[1] = unsigned(flag);
        }",
    );
}

#[test]
fn cuda_boolean_parameters_preserve_uniform_barrier_analysis() {
    validate("__global__ void kernel(bool flag) { if (flag) __syncthreads(); }");
    let source = "__global__ void kernel(bool flag) {
        flag = bool(threadIdx.x); if (flag) __syncthreads();
    }";
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(error.message.contains("straight-line"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "__syncthreads();");
}

#[test]
fn cuda_boolean_parameters_keep_const_and_storage_restrictions() {
    for source in [
        "__global__ void kernel(const bool flag) { flag = true; }",
        "__device__ void flip(bool &flag) { flag = !flag; } __global__ void kernel(const bool flag) { flip(flag); }",
        "__global__ void kernel(bool &flag) {}",
        "__global__ void kernel(volatile bool flag) {}",
        "__global__ void kernel(bool *flags) {}",
        "__global__ void kernel(bool flags[2]) {}",
        "using Flags = bool[2]; __global__ void kernel(Flags flags) {}",
        "using Flags = bool[]; __global__ void kernel(Flags flags) {}",
        "using Flag = bool; __global__ void kernel() { __shared__ Flag flag; }",
    ] {
        let error = parse_str(source, &Options::default()).unwrap_err();
        let range = error.span.to_range().unwrap();
        assert!(!range.is_empty() && source.get(range).is_some(), "{source}: {error}");
    }
}
