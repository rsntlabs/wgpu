use naga::front::cuda::{parse_str, Options};

use super::helpers::{source_binding_initializer, validate};

const FIXTURE: &str = include_str!("../../in/cuda/pointer-aliases.cu");

fn roundtrip(source: &str) {
    let (module, info) = validate(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

fn rejected(source: &str) {
    let error = parse_str(source, &Options::default()).unwrap_err();
    assert!(!error.message.is_empty(), "{source}");
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
}

#[test]
fn cuda_pointer_aliases_flatten_chains_and_reset_each_typedef_declarator() {
    let source = "typedef int *Pointer, Value, *const Fixed;
        using Again = Pointer; typedef Again Pointer;
        using Frozen = const Again; typedef Fixed Frozen;
        __global__ void kernel(Pointer output) {
            Value count = 3; Pointer cursor = output; Fixed fixed = output;
            *cursor = count; *fixed += 1;
            { using Pointer = const float *; float value = 1.5f; Pointer view = &value; output[1] = *view; }
            Again restored = output; restored[2] = count;
        }";
    let (module, info) = validate(source);
    let count = source_binding_initializer(&module.entry_points[0].function, "count");
    assert_eq!(
        info.get_entry_point(0)[count].ty.inner_with(&module.types),
        &naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    roundtrip(source);
    let mut chain = String::from("using OriginalPointer = int *;");
    let mut previous = String::from("OriginalPointer");
    for index in 0..128 {
        let alias = format!("Pointer{index}");
        chain.push_str(&format!("using {alias} = {previous};"));
        previous = alias;
    }
    chain.push_str(&format!(
        "__global__ void kernel({previous} output) {{ {previous} cursor = output; *cursor = 3; }}"
    ));
    roundtrip(&chain);
    for source in [
        "using Pointer = int *; using Pointer = const int *; __global__ void kernel() {}",
        "using Pointer = int *; typedef int *const Pointer; __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel() { int Pointer = 1; Pointer value; }",
        "__global__ void kernel() { { using Pointer = int *; } Pointer value; }",
        "__device__ int helper() { using Pointer = int *; return 1; } __global__ void kernel(Pointer value) {}",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_pointer_alias_bindings_preserve_access_nominal_types_and_packed_stride() {
    let source = "using Pointer = int *; using ReadPointer = const int *;
        using PackedPointer = int3 *; using ReadPacked = const int3 *;
        struct Record { int value; int2 pair; }; using RecordPointer = Record *;
        __global__ void kernel(const Pointer output, ReadPointer input,
            PackedPointer packed, ReadPacked source, RecordPointer records) {
            output[0] = input[0]; packed[1] = source[0]; records[0].value = output[0];
        }";
    let (module, _) = validate(source);
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| global.binding.is_some().then_some(global))
        .collect();
    assert_eq!(resources.len(), 5);
    for (binding, (global, (stride, writable))) in resources
        .iter()
        .zip([(4, true), (4, false), (12, true), (12, false), (16, true)])
        .enumerate()
    {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: binding as u32
            })
        );
        let access = if writable {
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        } else {
            naga::StorageAccess::LOAD
        };
        assert_eq!(global.space, naga::AddressSpace::Storage { access });
        let naga::TypeInner::Array { stride: actual, .. } = module.types[global.ty].inner else {
            panic!("expected a runtime pointer resource");
        };
        assert_eq!(actual, stride);
    }
    roundtrip(source);
    for ty in [
        "bool", "int", "unsigned", "float", "int2", "float3", "uint4",
    ] {
        roundtrip(&format!("using Pointer = {ty} *;
            __device__ void touch(Pointer value) {{ *value = *value; }}
            __global__ void kernel() {{ {ty} value{{}}; Pointer pointer = &value; touch(pointer); }}"));
    }
    rejected("using FlagPointer = bool *; __global__ void kernel(FlagPointer value) {}");
    rejected("struct First { int value; }; struct Second { int value; };
        using Pointer = First *; __global__ void kernel() { Second value{}; Pointer wrong = &value; }");
}

#[test]
fn cuda_pointer_alias_cv_distinguishes_pointer_objects_from_pointees_and_auto_copies() {
    roundtrip("using Pointer = int *; using ReadPointer = const int *;
        using Fixed = int *const; using FixedRead = const int *const;
        __global__ void kernel(Pointer output, ReadPointer input) {
            const Pointer fixed = output; Pointer const also_fixed = output; *fixed = 1; *also_fixed = 2;
            ReadPointer readable; readable = input; ++readable; readable = output;
            Fixed original = output; auto movable = original; ++movable; *movable = 3;
            FixedRead frozen = input; auto view = frozen; ++view; auto *other_view = input;
            output[0] = *view + *other_view + *readable;
        }");
    for body in [
        "const Pointer fixed = output; ++fixed;",
        "Pointer const fixed = output; fixed = output + 1;",
        "Fixed fixed;",
        "FixedRead fixed;",
        "ReadPointer view = input; *view = 1;",
        "const ReadPointer view = input; ++view;",
        "const ReadPointer view = input; *view = 1;",
        "Pointer writable = input;",
        "FixedRead frozen = input; auto view = frozen; *view = 1;",
        "auto &reference = output;",
    ] {
        rejected(&format!(
            "using Pointer = int *; using ReadPointer = const int *;
            using Fixed = int *const; using FixedRead = const int *const;
            __global__ void kernel(Pointer output, ReadPointer input) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_pointer_alias_helper_and_intrinsic_signatures_match_explicit_pointers() {
    roundtrip(
        "using Pointer = int *; using Fixed = Pointer const; using ReadPointer = const int *;
        __device__ int read(ReadPointer);
        __device__ int read(const int *value) { return *value; }
        __device__ int change(Fixed);
        __device__ int change(int *value) { return ++*value; }
        __device__ int choose(Pointer value) { return 1; }
        __device__ int choose(ReadPointer value) { return 2; }
        __device__ int atomicAdd(Fixed, int);
        __device__ unsigned atomicCAS(unsigned *const, unsigned, unsigned);
        __global__ void kernel(Pointer output, ReadPointer input, unsigned *counter) {
            output[0] = read(input) + change(output + 8) + choose(output) + choose(input);
            output[1] = atomicAdd(output + 9, 2);
            output[2] = atomicCAS(counter, 0u, 1u);
        }",
    );
    for declarations in [
        "__device__ int read(Pointer); __device__ float read(int *);",
        "__device__ int read(Pointer value) { return 1; } __device__ int read(int *const value) { return 2; }",
        "__device__ float atomicAdd(Pointer, int);",
    ] {
        rejected(&format!("using Pointer = int *; {declarations} __global__ void kernel() {{}}"));
    }
}

#[test]
fn cuda_pointer_aliases_reuse_captures_references_and_conditional_address_spaces() {
    roundtrip(FIXTURE);
    roundtrip("using Pointer = int *;
        __device__ int update(Pointer destination) { int previous = *destination; *destination += 10; return previous; }
        __device__ void copy(int &destination, const int &source) { destination = source; }
        __global__ void kernel(Pointer output) {
            __shared__ int shared[2]; shared[0] = 5; shared[1] = 7;
            int values[2]{2, 3}; int index = 0;
            Pointer captured = &values[index++]; index = 1; ++*captured;
            Pointer selected = values;
            selected = output[15] == 0 ? output + 24 : output[15] == 1 ? shared : values;
            Pointer saved = selected++; int previous = update(saved);
            int &live = *saved; ++live; *selected += 2;
            copy(output[0], live); output[1] = previous; output[2] = *captured;
        }");
    roundtrip(
        "using Pointer = int *; __global__ void kernel(Pointer output) {
        Pointer unused; return; Pointer dead; using Local = Pointer; Local still_dead;
    }",
    );
    for body in [
        "Pointer pointer = pointer;",
        "Pointer pointer; output[0] = *pointer;",
        "Pointer first, second; first = second; second = first; output[0] = *first;",
        "Pointer pointer; auto copy = pointer;",
    ] {
        rejected(&format!(
            "using Pointer = int *; __global__ void kernel(Pointer output) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_pointer_aliases_reject_hidden_unsupported_forms_and_malformed_source() {
    for source in [
        "using Pointer = int *; using Nested = Pointer *; __global__ void kernel() {}",
        "using Pointer = int *; typedef Pointer *Nested; __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel(Pointer *nested) {}",
        "using Pointer = int *; __global__ void kernel(Pointer values[2]) {}",
        "using Pointer = int *; __device__ void helper(Pointer &value) {} __global__ void kernel() {}",
        "using Pointer = int *; __device__ void helper(Pointer &&value) {} __global__ void kernel() {}",
        "using Pointer = int *; struct Record { Pointer field; }; __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel() { Pointer values[2]; }",
        "using Pointer = int *; __global__ void kernel() { __shared__ Pointer value; }",
        "using Pointer = int *; constexpr Pointer Global = 0; __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel() { constexpr Pointer value = 0; }",
        "using Pointer = int *; __device__ Pointer helper(); __global__ void kernel() {}",
        "using Pointer = int *; __device__ Pointer helper(int *value) { return value; } __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel(int *output) { Pointer &reference = output; }",
        "using Pointer = int *; __global__ void kernel(const int *input) { auto value = (Pointer)input; }",
        "using Pointer = int *; __global__ void kernel(float *input) { auto value = Pointer(input); }",
        "using Nothing = void *; __global__ void kernel() {}",
        "using Function = int (*)(int); __global__ void kernel() {}",
        "typedef int (*Function)(int); __global__ void kernel() {}",
        "using Pointer = Pointer; __global__ void kernel() {}",
        "using Pointer = Missing *; __global__ void kernel() {}",
        "typedef int *; __global__ void kernel() {}",
        "using = int *; __global__ void kernel() {}",
        "__global__ void kernel() { return; using Pointer = int **; }",
        "__global__ void kernel() { return; using Pointer = int *; Pointer values[2]; }",
    ] {
        rejected(source);
    }
    for source in [
        "using Array = int[2]; __global__ void kernel() {}",
        "using Pointer = int *; __global__ void kernel(int *output) { Pointer value = (Pointer)output; }",
        "using Pointer = int *; __global__ void kernel(int *output) { Pointer value = static_cast<Pointer>(output); }",
        "using Pointer = int *; __global__ void kernel(int *output) { Pointer(output + 1); }",
        "using Pointer = int *; __global__ void kernel(int *output) { auto value = Pointer(output); }",
        "using Pointer = int *; __global__ void kernel(int *output) { auto value = Pointer{output}; }",
    ] {
        roundtrip(source);
    }
}
