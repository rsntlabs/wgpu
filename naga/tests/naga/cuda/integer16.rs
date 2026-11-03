use naga::front::cuda::{parse_str, Options};
use naga::valid::Capabilities;

use super::helpers::{source_binding_initializer, validate_with_options_and_capabilities};

fn roundtrip(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    let (module, info) = validate_with_options_and_capabilities(
        source,
        &Options::default(),
        Capabilities::SHADER_INT16,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        super::helpers::wgsl_roundtrip_with_capabilities(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
            Capabilities::SHADER_INT16,
        );
    }
    (module, info)
}

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty(), "{source}: {error}");
    assert!(source.get(range).is_some(), "{source}: {error}");
    error
}

fn calls(function: &naga::Function) -> Vec<naga::Handle<naga::Function>> {
    let mut targets = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = *statement {
            targets.push(function);
        }
        false
    });
    targets
}

#[test]
fn cuda_integer16_preserves_two_byte_storage_and_parameter_layouts() {
    let (module, _) = roundtrip(
        "typedef unsigned short int uint16;
        struct Record { short signed_value; uint16 unsigned_value; unsigned wide; short tail; };
        __global__ void copy(const short *signed_input, uint16 *unsigned_output,
                             Record *records, short parameter) {
            unsigned_output[0] = (uint16)signed_input[1];
            records[0].signed_value = parameter;
            records[0].unsigned_value = unsigned_output[0];
            records[0].wide = 1u;
            records[0].tail = signed_input[0];
        }",
    );
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for (index, global) in globals.iter().enumerate() {
        assert_eq!(
            global.binding,
            Some(naga::ResourceBinding {
                group: 0,
                binding: index as u32
            })
        );
    }
    for (index, scalar, access) in [
        (0, naga::Scalar::I16, naga::StorageAccess::LOAD),
        (
            1,
            naga::Scalar::U16,
            naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
        ),
    ] {
        assert_eq!(globals[index].space, naga::AddressSpace::Storage { access });
        let naga::TypeInner::Array {
            base,
            size: naga::ArraySize::Dynamic,
            stride,
        } = module.types[globals[index].ty].inner
        else {
            panic!("expected a runtime array for parameter {index}");
        };
        assert_eq!(stride, 2);
        assert_eq!(module.types[base].inner, naga::TypeInner::Scalar(scalar));
    }
    let naga::TypeInner::Array { base, stride, .. } = module.types[globals[2].ty].inner else {
        panic!("expected a record buffer");
    };
    assert_eq!(stride, 12);
    let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
        panic!("expected a record element");
    };
    assert_eq!(span, 12);
    assert_eq!(
        members
            .iter()
            .map(|member| member.offset)
            .collect::<Vec<_>>(),
        [0, 2, 4, 8]
    );
    for (member, scalar) in members.iter().zip([
        naga::Scalar::I16,
        naga::Scalar::U16,
        naga::Scalar::U32,
        naga::Scalar::I16,
    ]) {
        assert_eq!(
            module.types[member.ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    assert_eq!(globals[3].space, naga::AddressSpace::Uniform);
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[3].ty].inner else {
        panic!("expected a scalar parameter wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I16)
    );
}

#[test]
fn cuda_integer16_promotes_signed_and_unsigned_operands_to_int() {
    let (module, info) = roundtrip(
        "__global__ void promote(const short *signed_input, const unsigned short *unsigned_input,
                                int *output) {
            short signed_value = signed_input[0];
            unsigned short unsigned_value = unsigned_input[0];
            auto signed_sum = signed_value + signed_value;
            auto unsigned_sum = unsigned_value + unsigned_value;
            auto promoted_positive = +unsigned_value;
            auto promoted_negative = -unsigned_value;
            auto promoted_complement = ~unsigned_value;
            auto shifted = unsigned_value << 16;
            auto divided = signed_value / short(-1);
            output[0] = signed_sum;
            output[1] = unsigned_sum;
            output[2] = promoted_positive;
            output[3] = promoted_negative;
            output[4] = promoted_complement;
            output[5] = shifted;
            output[6] = divided;
        }",
    );
    let function = &module.entry_points[0].function;
    for name in [
        "signed_sum",
        "unsigned_sum",
        "promoted_positive",
        "promoted_negative",
        "promoted_complement",
        "shifted",
        "divided",
    ] {
        let value = source_binding_initializer(function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::I32),
            "source binding {name}"
        );
    }
}

#[test]
fn cuda_integer16_accepts_standard_specifier_orders_aliases_and_function_headers() {
    for (spelling, scalar) in [
        ("short", naga::Scalar::I16),
        ("short int", naga::Scalar::I16),
        ("int short", naga::Scalar::I16),
        ("signed short", naga::Scalar::I16),
        ("short signed", naga::Scalar::I16),
        ("signed short int", naga::Scalar::I16),
        ("signed int short", naga::Scalar::I16),
        ("short signed int", naga::Scalar::I16),
        ("short int signed", naga::Scalar::I16),
        ("int signed short", naga::Scalar::I16),
        ("int short signed", naga::Scalar::I16),
        ("unsigned short", naga::Scalar::U16),
        ("short unsigned", naga::Scalar::U16),
        ("unsigned short int", naga::Scalar::U16),
        ("unsigned int short", naga::Scalar::U16),
        ("short unsigned int", naga::Scalar::U16),
        ("short int unsigned", naga::Scalar::U16),
        ("int unsigned short", naga::Scalar::U16),
        ("int short unsigned", naga::Scalar::U16),
    ] {
        let source = format!(
            "using Element = {spelling}; typedef {spelling} Alias;
            __device__ {spelling} echo(const Element);
            __global__ void kernel(Alias *output, const Element *input) {{ output[0] = echo(input[0]); }}
            __device__ {spelling} echo(Element value) {{ return value; }}"
        );
        let (module, _) = roundtrip(&source);
        let targets = calls(&module.entry_points[0].function);
        assert_eq!(targets.len(), 1, "{spelling}");
        let function = &module.functions[targets[0]];
        assert_eq!(
            module.types[function.arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
        assert_eq!(
            module.types[function.result.as_ref().unwrap().ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    for spelling in [
        "short short",
        "short int int",
        "signed unsigned short",
        "short float",
        "unsigned unsigned short",
    ] {
        rejected(&format!("__global__ void kernel() {{ {spelling} value; }}"));
    }
}

#[test]
fn cuda_integer16_constant_casts_wrap_integers_and_check_truncated_float_ranges() {
    let (module, _) = roundtrip(
        "using Half = unsigned short;
        constexpr short Minimum = short(32768);
        constexpr short Negative = short(65535);
        constexpr Half Maximum = Half(-1);
        constexpr short Wrapped = short(65536);
        __global__ void kernel(int *output, float input) {
            constexpr short upper = short(32767.75f);
            constexpr short lower = short(-32768.75f);
            constexpr Half unsigned_upper = Half(65535.75f);
            short signed_runtime = short(input);
            Half unsigned_runtime = Half(input);
            output[0] = Minimum; output[1] = Negative; output[2] = Maximum;
            output[3] = Wrapped; output[4] = upper; output[5] = lower;
            output[6] = unsigned_upper; output[7] = signed_runtime + unsigned_runtime;
        }",
    );
    for (name, expected) in [
        ("Minimum", naga::Literal::I16(-32768)),
        ("Negative", naga::Literal::I16(-1)),
        ("Maximum", naga::Literal::U16(65535)),
        ("Wrapped", naga::Literal::I16(0)),
    ] {
        let constant = module
            .constants
            .iter()
            .find_map(|(_, constant)| (constant.name.as_deref() == Some(name)).then_some(constant))
            .unwrap();
        assert_eq!(
            module.global_expressions[constant.init],
            naga::Expression::Literal(expected),
            "{name}"
        );
    }
    for (target, value) in [
        ("short", "32768.0f"),
        ("short", "-32769.0f"),
        ("unsigned short", "65536.0f"),
        ("unsigned short", "-1.0f"),
        ("short", "1.0f / 0.0f"),
        ("unsigned short", "0.0f / 0.0f"),
    ] {
        rejected(&format!("using Target = {target}; __global__ void kernel(int *output) {{ constexpr Target value = Target({value}); output[0] = value; }}"));
    }
}

#[test]
fn cuda_integer16_list_initialization_uses_source_ranges_and_constant_representability() {
    roundtrip(
        "using Half = unsigned short;
        __global__ void kernel(const short *signed_input, const Half *unsigned_input, int *output) {
            short minimum{-32768}; Half maximum{65535}; Half one{true};
            short copied{signed_input[0]}; Half unsigned_copy{unsigned_input[0]};
            int widened{unsigned_copy}; unsigned unsigned_widened{unsigned_copy};
            float signed_float = copied; float unsigned_float = unsigned_copy;
            constexpr short signed_constant = -32768; constexpr Half unsigned_constant = 65535;
            float exact_signed{signed_constant}; float exact_unsigned{unsigned_constant};
            bool enabled{short(1)};
            output[0] = minimum + maximum + one + widened + int(unsigned_widened);
            output[1] = int(signed_float + unsigned_float + exact_signed + exact_unsigned) + int(enabled);
        }",
    );
    for declaration in [
        "short value{32768};",
        "short value{-32769};",
        "Half value{-1};",
        "Half value{65536};",
        "short value{wide};",
        "short value{unsigned_input[0]};",
        "Half value{signed_input[0]};",
        "short value{1.0f};",
        "bool value{short(2)};",
        "float value{signed_input[0]};",
        "float value{unsigned_input[0]};",
    ] {
        rejected(&format!("using Half = unsigned short; __global__ void kernel(const short *signed_input, const Half *unsigned_input, int wide) {{ {declaration} }}"));
    }
}

#[test]
fn cuda_integer16_overloads_distinguish_exact_types_from_integral_promotions() {
    let (module, _) = roundtrip(
        "using Half = unsigned short;
        __device__ int exact(short value) { return value; }
        __device__ int exact(Half value) { return value; }
        __device__ int promoted(int value) { return value; }
        __device__ int promoted(unsigned value) { return int(value); }
        __device__ int promoted(float value) { return int(value); }
        __global__ void kernel(const short *signed_input, const Half *unsigned_input, int *output) {
            short signed_value = signed_input[0]; Half unsigned_value = unsigned_input[0];
            output[0] = exact(signed_value); output[1] = exact(unsigned_value);
            output[2] = promoted(signed_value); output[3] = promoted(unsigned_value);
            output[4] = promoted(+unsigned_value);
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 5);
    for (target, scalar) in targets.into_iter().zip([
        naga::Scalar::I16,
        naga::Scalar::U16,
        naga::Scalar::I32,
        naga::Scalar::I32,
        naga::Scalar::I32,
    ]) {
        assert_eq!(
            module.types[module.functions[target].arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    rejected("__device__ int choose(short value) { return value; } __device__ int choose(unsigned value) { return int(value); } __global__ void kernel(unsigned short value, int *output) { output[0] = choose(value); }");
    rejected("__device__ short value(unsigned short); __device__ unsigned short value(unsigned short); __global__ void kernel() {}");
}

#[test]
fn cuda_integer16_templates_preserve_parameter_types_canonical_names_and_instance_keys() {
    let (module, _) = roundtrip(
        "using Signed = short; using Half = unsigned short;
        __device__ int choose(short value) { return value; }
        __device__ int choose(Half value) { return value; }
        __device__ int choose(int value) { return value; }
        template<short Value> __device__ int signed_value() { return choose(Value); }
        template<Half Value> __device__ int unsigned_value() { return choose(Value); }
        template<class Value> __device__ Value identity(Value value) { return value; }
        __global__ void kernel(int *output) {
            output[0] = signed_value<-1>(); output[1] = signed_value<short(65535)>();
            output[2] = unsigned_value<65535>(); output[3] = unsigned_value<Half(-1)>();
            output[4] = identity<Signed>(short(3)); output[5] = identity<short>(short(4));
            output[6] = identity<Half>(Half(5));
        }",
    );
    let targets = calls(&module.entry_points[0].function);
    assert_eq!(targets.len(), 7);
    assert_eq!(targets[0], targets[1]);
    assert_eq!(targets[2], targets[3]);
    assert_eq!(targets[4], targets[5]);
    assert_ne!(targets[4], targets[6]);
    for (target, scalar) in [
        (targets[0], naga::Scalar::I16),
        (targets[2], naga::Scalar::U16),
    ] {
        let nested = calls(&module.functions[target]);
        assert_eq!(nested.len(), 1);
        assert_eq!(
            module.types[module.functions[nested[0]].arguments[0].ty].inner,
            naga::TypeInner::Scalar(scalar)
        );
    }
    let (module, _) = roundtrip(
        "using Half = unsigned short;
        template<class Value> __global__ void copy(Value *output, const Value *input) { output[0] = input[0]; }
        template __global__ void copy<short>(short *, const short *);
        template __global__ void copy<Half>(Half *, const Half *);",
    );
    assert_eq!(
        module
            .entry_points
            .iter()
            .map(|entry| entry.name.as_str())
            .collect::<Vec<_>>(),
        ["copy<short>", "copy<unsigned short>"]
    );
    for (target, value) in [
        ("short", "32768"),
        ("short", "-32769"),
        ("unsigned short", "-1"),
        ("unsigned short", "65536"),
        ("short", "1.0f"),
    ] {
        rejected(&format!("using Target = {target}; template<Target Value> __device__ int selected() {{ return int(Value); }} __global__ void kernel(int *output) {{ output[0] = selected<{value}>(); }}"));
    }
}

#[test]
fn cuda_integer16_constant_metadata_reaches_bounds_cases_launch_bounds_and_unroll() {
    let (module, _) = roundtrip(
        "using Half = unsigned short;
        constexpr Half Count = 4; constexpr short Offset = 1;
        __global__ __launch_bounds__(Count) void kernel(short *output, short selector) {
            const Half extent = Count; short values[extent]{};
            constexpr Half chosen = true ? Count : Half(0);
            short more[chosen]{};
            switch (selector) { case short(-1): values[Offset] = 7; break; default: break; }
            #pragma unroll Count
            for (Half index = 0; index < Count; ++index) more[index] = values[index];
            output[0] = more[Offset];
        }",
    );
    let function = &module.entry_points[0].function;
    for name in ["values", "more"] {
        let local = function
            .local_variables
            .iter()
            .find_map(|(_, local)| (local.name.as_deref() == Some(name)).then_some(local))
            .unwrap();
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[local.ty].inner
        else {
            panic!("expected a fixed short array");
        };
        assert_eq!((count.get(), stride), (4, 2));
    }
    for bound in ["short(0)", "short(-1)", "Half(0)"] {
        rejected(&format!(
            "using Half = unsigned short; __global__ void kernel() {{ short values[{bound}]; }}"
        ));
    }
    rejected("__global__ void kernel(unsigned short count) { short values[count]; }");
}

#[test]
fn cuda_integer16_updates_and_compound_assignments_keep_the_left_operand_type() {
    for spelling in ["short", "unsigned short"] {
        for operator in ["+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>="] {
            roundtrip(&format!(
                "using Element = {spelling};
                __global__ void kernel(Element *output) {{
                    Element value = output[0]; Element &result = (value {operator} 2);
                    output[0] = result;
                }}"
            ));
        }
    }
    let (module, info) = roundtrip(
        "__global__ void kernel(short *output, int condition) {
            short value = output[0]; short &prefix = ++value;
            auto previous = value++; const short &old = previous;
            auto selected = condition ? value : prefix;
            auto comma = (value += 1, value);
            short &assigned = (value *= 2);
            output[0] = old; output[1] = selected; output[2] = comma; output[3] = assigned;
        }",
    );
    for name in ["previous", "selected", "comma"] {
        let value = source_binding_initializer(&module.entry_points[0].function, name);
        assert_eq!(
            info.get_entry_point(0)[value].ty.inner_with(&module.types),
            &naga::TypeInner::Scalar(naga::Scalar::I16),
            "{name}"
        );
    }
    rejected("__global__ void kernel() { const short value = 1; value += 2; }");
    rejected("__global__ void kernel() { short &value = short(1)++; }");
}

#[test]
fn cuda_integer16_pointers_references_and_read_only_resources_preserve_source_qualifiers() {
    let (module, _) = roundtrip(
        "using Element = short; using View = Element *;
        __constant__ Element Coefficients[3]; extern __constant__ const Element Frozen[2];
        __device__ int read(View values, short index) { return values[index]; }
        __device__ short observe(const Element &value) { return value; }
        __global__ void kernel(short *output, short index) {
            View target = output; short &reference = target[0];
            reference = short(read(Coefficients, index) + observe(Frozen[0]));
            const Element *input = target + short(1); target[1] = observe(*input);
        }",
    );
    let constants: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| {
            global
                .binding
                .filter(|binding| binding.group == 1)
                .map(|binding| (binding, global))
        })
        .collect();
    assert_eq!(constants.len(), 2);
    for (index, &(binding, global)) in constants.iter().enumerate() {
        assert_eq!(binding.binding, index as u32);
        assert_eq!(
            global.space,
            naga::AddressSpace::Storage {
                access: naga::StorageAccess::LOAD
            }
        );
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("constant array");
        };
        assert_eq!(stride, 2);
        assert_eq!(
            module.types[base].inner,
            naga::TypeInner::Scalar(naga::Scalar::I16)
        );
    }
    for body in [
        "Values[0] = 1;",
        "short *pointer = Values; *pointer = 1;",
        "short &reference = Values[0]; reference += 1;",
        "short *pointer = condition ? Values : output; pointer[0] = 1;",
    ] {
        rejected(&format!("__constant__ short Values[2]; __global__ void kernel(short *output, int condition) {{ {body} }}"));
    }
    for body in [
        "short *pointer = input;",
        "short &value = input[0];",
        "input[0] = 1;",
        "unsigned short *pointer = (unsigned short *)output;",
    ] {
        rejected(&format!(
            "__global__ void kernel(short *output, const short *input) {{ {body} }}"
        ));
    }
}

#[test]
fn cuda_integer16_shared_storage_and_volatile_accesses_keep_two_byte_elements() {
    let capabilities = Capabilities::SHADER_INT16
        | Capabilities::MEMORY_DECORATION_VOLATILE
        | Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP;
    let options = Options {
        workgroup_size: [4, 1, 1],
        dynamic_shared_memory_size: 8,
    };
    let source =
        "__global__ void kernel(volatile short *output, const volatile unsigned short *input) {
        __shared__ volatile short fixed[4];
        extern __shared__ volatile unsigned short dynamic[];
        unsigned index = threadIdx.x;
        fixed[index] = short(input[index]); dynamic[index] = input[index];
        __syncthreads(); output[index] = short(fixed[index] + dynamic[index]);
    }";
    let (module, info) = validate_with_options_and_capabilities(source, &options, capabilities);
    let shared: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, global)| (global.space == naga::AddressSpace::WorkGroup).then_some(global))
        .collect();
    assert_eq!(shared.len(), 2);
    for global in shared {
        assert!(global
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
        let naga::TypeInner::Array {
            size: naga::ArraySize::Constant(count),
            stride,
            ..
        } = module.types[global.ty].inner
        else {
            panic!("shared array");
        };
        assert_eq!((count.get(), stride), (4, 2));
    }
    for (_, global) in module
        .global_variables
        .iter()
        .filter(|(_, global)| global.binding.is_some())
    {
        assert!(global
            .memory_decorations
            .contains(naga::MemoryDecorations::VOLATILE));
    }
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        capabilities,
    );
    let _ = info;
    let source = "__global__ void kernel(unsigned *output) {
        extern __shared__ short halves[]; extern __shared__ unsigned words[];
        halves[0] = -1; output[0] = unsigned(halves[0]);
        words[0] = 7u; output[1] = words[0];
    }";
    let error = parse_str(source, &options).unwrap_err();
    assert!(
        error.message.contains("heterogeneous dynamic shared"),
        "{error}"
    );
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty());
    assert!(source.get(range).is_some());
}

#[test]
fn cuda_integer16_requires_the_native_integer16_validation_capability() {
    let source = "__global__ void kernel(short *output, const unsigned short *input) { output[0] = short(input[0]); }";
    let module = parse_str(source, &Options::default()).unwrap();
    let error =
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), Capabilities::empty())
            .validate(&module)
            .unwrap_err();
    assert!(format!("{error:?}").contains("SHADER_INT16"), "{error:?}");
    let (module, info) = roundtrip(source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (output, _) = super::helpers::wgsl_roundtrip_with_capabilities(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
            Capabilities::SHADER_INT16,
        );
        assert!(output.contains("enable wgpu_int16;"), "{output}");
    }
    let _ = (module, info);
}

#[test]
fn cuda_integer16_keeps_null_pointer_constants_and_atomic_type_boundaries() {
    roundtrip("#define NULL 0
        __global__ void kernel(short *output) {
            short *first = 0; short *second = 0u; short *third = nullptr; short *fourth = NULL;
            if (first == nullptr && second == nullptr && third == nullptr && fourth == nullptr) output[0] = 1;
        }");
    for value in ["short(0)", "Half(0)", "Zero", "(short)0"] {
        rejected(&format!("using Half = unsigned short; constexpr short Zero = 0; __global__ void kernel() {{ short *pointer = {value}; }}"));
    }
    for source in [
        "__global__ void kernel(short *output) { atomicAdd(output, short(1)); }",
        "__global__ void kernel(unsigned short *output) { atomicCAS(output, (unsigned short)0, (unsigned short)1); }",
        "__global__ void kernel(short5 *output) {}",
        "__global__ void kernel(ushort5 *output) {}",
        "__global__ void kernel(char *output) {}",
        "__global__ void kernel(long *output) {}",
        "__device__ short missing(short); __global__ void kernel(short *output) { output[0] = missing(short(1)); }",
        "__device__ short recurse(short value) { return recurse(value); } __global__ void kernel(short *output) { output[0] = recurse(short(1)); }",
    ] {
        rejected(source);
    }
}

#[test]
fn cuda_integer16_canonical_fixture_retains_packed_records_and_unsigned_short_parameters() {
    let options = Options {
        workgroup_size: [4, 1, 1],
        ..Options::default()
    };
    let (module, info) = validate_with_options_and_capabilities(
        include_str!("../../in/cuda/integer16.cu"),
        &options,
        Capabilities::SHADER_INT16,
    );
    assert_eq!(module.entry_points[0].name, "integer16");
    assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
    let globals: Vec<_> = module
        .global_variables
        .iter()
        .map(|(_, global)| global)
        .collect();
    assert_eq!(globals.len(), 4);
    for global in &globals[..2] {
        let naga::TypeInner::Array { base, stride, .. } = module.types[global.ty].inner else {
            panic!("record array");
        };
        assert_eq!(stride, 12);
        let naga::TypeInner::Struct { ref members, span } = module.types[base].inner else {
            panic!("record");
        };
        assert_eq!(span, 12);
        assert_eq!(
            members
                .iter()
                .map(|member| member.offset)
                .collect::<Vec<_>>(),
            [0, 2, 4, 8, 10]
        );
    }
    let naga::TypeInner::Struct { ref members, span } = module.types[globals[3].ty].inner else {
        panic!("count wrapper");
    };
    assert_eq!(span, 16);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::U16)
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip_with_capabilities(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        Capabilities::SHADER_INT16,
    );
    let _ = info;
}
