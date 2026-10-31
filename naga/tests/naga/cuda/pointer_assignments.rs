use naga::front::cuda::{parse_str, Options};

use super::helpers::{root_expression, validate};

const FIXTURE: &str = include_str!("../../in/cuda/pointer-assignments.cu");

fn rejected(source: &str) -> naga::front::cuda::ParseError {
    let error = parse_str(source, &Options::default()).unwrap_err();
    let range = error.span.to_range().unwrap();
    assert!(!range.is_empty() || range.start == source.len(), "{source}");
    assert!(source.get(range).is_some(), "{source}");
    assert!(!error.message.is_empty(), "{source}");
    error
}

fn expect_limit(source: &str) {
    let error = rejected(source);
    assert!(
        error.message.contains("limit") || error.message.contains("depth"),
        "{error}"
    );
}

#[test]
fn cuda_pointer_assignments_validate_runtime_state_fixture() {
    validate(FIXTURE);
}

#[test]
fn cuda_pointer_assignments_materialize_shared_reference_in_each_select_arm() {
    validate(
        "__global__ void kernel(int *out) {
            int matrix[3][2]{{2, 3}, {5, 7}, {11, 13}};
            int *pointer = matrix[1];
            int &reference = pointer[1];
            int *selected = matrix[0];
            bool choose = bool(out[7]);
            selected = choose ? &reference : &reference;
            out[0] = *selected;
            *selected += 10;
            out[1] = matrix[1][1];
            out[2] = matrix[0][0];
            out[3] = *pointer;
        }",
    );
}

#[test]
fn cuda_pointer_assignments_promote_previously_rejected_local_and_formal_assignments() {
    validate(
        "__global__ void kernel() {
            int values[2]{2, 3};
            int *pointer = values;
            pointer = values + 1;
        }",
    );
    validate(
        "__device__ void change(int *value) { value = value + 1; }
        __global__ void kernel() {}",
    );
}

#[test]
fn cuda_pointer_assignments_accept_supported_pointees_aliases_and_array_decay() {
    for pointee in [
        "bool", "int", "unsigned", "float", "int2", "int3", "int4", "uint2", "uint3", "uint4",
        "float2", "float3", "float4", "Record",
    ] {
        validate(&format!(
            "struct Record {{ int value; float2 point; }};
            using Element = {pointee};
            __global__ void kernel() {{
                Element first[2]{{}}, second[2]{{}};
                Element *pointer = first;
                pointer = second + 1;
                const Element *view = first;
                view = pointer;
                Element *const fixed = first;
                pointer = fixed;
                pointer = &second[0];
            }}"
        ));
    }
    validate(
        "using ReadOnly = const int;
        __global__ void kernel(int *out) {
            int values[2]{2, 3}; ReadOnly *view = values;
            view = values + 1; out[0] = *view;
        }",
    );
}

#[test]
fn cuda_pointer_assignments_accept_individual_and_projected_objects() {
    validate(
        "struct Record { int value; int samples[2]; int3 point; };
        __global__ void kernel(int *out) {
            int value = 2;
            Record records[2]{{3, {5, 7}, {11, 13, 17}}, {19, {23, 29}, {31, 37, 41}}};
            int *pointer = &value;
            pointer = &records[0].value; *pointer += 1;
            pointer = records[1].samples; *pointer += 2;
            pointer = &records[0].point.y; *pointer += 3;
            pointer = &value; out[0] = *pointer;
            int3 *vector = &records[0].point;
            vector = &records[1].point; out[1] = vector->z;
            Record *record = &records[0];
            record = records + 1; out[2] = record->samples[0];
        }",
    );
}

#[test]
fn cuda_pointer_assignments_preserve_returned_lvalue_type_and_identity() {
    for source in [
        "__global__ void kernel(int *out) { int first[2]{2,3}, second[2]{5,7}; int *pointer=first; ++(pointer=second); out[0]=*pointer; }",
        "__global__ void kernel(int *out) { int first[2]{2,3}, second[2]{5,7}; const int *view=first; int *pointer=second; (view=pointer)+=1; out[0]=*view; }",
        "__global__ void kernel(int *out) { int first[2]{2,3}, second[2]{5,7}; int *const fixed=second; int *pointer=first; (pointer=fixed)++; out[0]=*pointer; }",
        "__global__ void kernel(int *out) { int first[3]{2,3,5}, second[3]{7,11,13}; int *left=first, *right=second; (left=right)=first+1; left=right=second+1; out[0]=*left+*right; }",
        "__global__ void kernel(int *out) { int first[3]{2,3,5}, second[3]{7,11,13}; int *left=first, *right=second; ((out[0] ? left : right)=first+1)+=1; (out[0],left)=second; out[1]=*left; }",
    ] {
        validate(source);
    }
}

#[test]
fn cuda_pointer_assignments_do_not_load_uninitialized_pointees() {
    let (module, _) = validate(
        "__global__ void kernel(int *out) {
            int first; int second;
            int *pointer = &first;
            pointer = &second;
            *pointer = 7;
            out[0] = second;
        }",
    );
    let function = &module.entry_points[0].function;
    let local = |name| {
        function
            .local_variables
            .iter()
            .find(|(_, variable)| variable.name.as_deref() == Some(name))
            .unwrap()
            .0
    };
    let first = local("first");
    let second = local("second");
    let rooted_at = |pointer, variable| {
        function.expressions[root_expression(function, pointer)]
            == naga::Expression::LocalVariable(variable)
    };
    assert!(!function.expressions.iter().any(|(_, expression)| {
        matches!(*expression, naga::Expression::Load { pointer } if rooted_at(pointer, first))
    }));
    let mut stored_second = false;
    let mut loaded_second = false;
    naga::proc::any_statement(&function.body, &mut |statement| {
        match statement {
            naga::Statement::Store { pointer, .. } if rooted_at(*pointer, second) => {
                stored_second = true;
            }
            naga::Statement::Emit(expressions) => {
                for expression in expressions.clone() {
                    if matches!(function.expressions[expression], naga::Expression::Load { pointer } if rooted_at(pointer, second))
                    {
                        assert!(
                            stored_second,
                            "second must be initialized before its source load"
                        );
                        loaded_second = true;
                    }
                }
            }
            _ => {}
        }
        false
    });
    assert!(stored_second && loaded_second);
}

#[test]
fn cuda_pointer_assignments_preserve_buffer_and_uniform_abi() {
    let (module, _) = validate(
        "__global__ void kernel(const int *input, int scale, int *out) {
            __shared__ int shared[2];
            int local[2]{2, 3};
            int *pointer = out;
            const int *view = input;
            pointer = local; *pointer = scale;
            view = pointer; out[0] = *view;
            pointer = shared; *pointer = scale;
            view = input + 1; out[1] = *view;
            out = local; out[1] = scale;
        }",
    );
    let resources: Vec<_> = module
        .global_variables
        .iter()
        .filter_map(|(_, variable)| variable.binding.map(|binding| (binding, variable)))
        .collect();
    assert_eq!(resources.len(), 3);
    for (index, (binding, _)) in resources.iter().enumerate() {
        assert_eq!(
            *binding,
            naga::ResourceBinding {
                group: 0,
                binding: index as u32
            }
        );
    }
    assert_eq!(
        resources[0].1.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD
        }
    );
    assert_eq!(resources[1].1.space, naga::AddressSpace::Uniform);
    assert_eq!(
        resources[2].1.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
        }
    );
    let naga::TypeInner::Struct { ref members, span } = module.types[resources[1].1.ty].inner
    else {
        panic!("scalar parameter must retain its uniform structure");
    };
    assert_eq!(span, 16);
    assert_eq!(members.len(), 1);
    assert_eq!(members[0].offset, 0);
    assert_eq!(
        module.types[members[0].ty].inner,
        naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    assert_eq!(
        module
            .global_variables
            .iter()
            .filter(|(_, variable)| variable.space == naga::AddressSpace::WorkGroup)
            .count(),
        1
    );
}

#[test]
fn cuda_pointer_assignments_validate_unused_helpers_and_unreachable_source() {
    for source in [
        "__device__ void unused(int *first,int *second) { first=second; first=first+1; } __global__ void kernel() {}",
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *pointer=first;return;pointer=second; }",
        "__global__ void kernel() { int values[3]{};return;int *dead=values; }",
        "__global__ void kernel() { int values[3]{};int *pointer=values;return;int *dead=pointer; }",
    ] {
        validate(source);
    }
}

#[test]
fn cuda_pointer_assignments_preserve_skipped_constant_expression_branches() {
    for source in [
        "__global__ void kernel(int *out) { int first[2]{2,3},second[2]{5,7};int *pointer=first;constexpr int Count=true?4:(pointer=second,3);int values[Count]{};out[0]=values[3]; }",
        "__global__ void kernel(int *out) { int first[2]{2,3},second[2]{5,7};int *pointer=first;constexpr bool Skip=false&&(pointer=second,1);out[0]=int(Skip); }",
    ] {
        validate(source);
    }
}

#[test]
fn cuda_pointer_assignments_reject_const_pointer_objects() {
    for source in [
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *const pointer=first;pointer=second; }",
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};const int *const pointer=first;pointer=second; }",
        "__global__ void kernel(int *const pointer,int *replacement) { pointer=replacement; }",
        "__device__ void unused(int *const pointer,int *replacement) { pointer=replacement; } __global__ void kernel() {}",
        "__device__ void change(int *const pointer,int *replacement) { pointer=replacement; } __global__ void kernel() { int first[2]{2,3},second[2]{5,7};change(first,second); }",
        "__global__ void kernel() { int values[2]{2,3};int *const pointer=values;return;pointer=values+1; }",
    ] {
        let error = rejected(source);
        assert!(error.message.contains("const"), "{error}");
    }
}

#[test]
fn cuda_pointer_assignments_reject_const_loss_and_incompatible_pointees() {
    for source in [
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *pointer=first;const int *readonly=second;pointer=readonly; }",
        "__global__ void kernel() { int first[2]{2,3};int *pointer=first;float value=1.0f;pointer=&value; }",
        "struct First { int value; };struct Second { int value; };__global__ void kernel() { First first{};First *pointer=&first;Second other{};pointer=&other; }",
        "__device__ void unused(int *pointer,const int *view) { pointer=view; } __global__ void kernel() {}",
    ] {
        let error = rejected(source);
        assert!(error.message.contains("incompatible"), "{error}");
    }
}

#[test]
fn cuda_pointer_assignments_return_the_destination_pointee_qualification() {
    for statement in [
        "*(view=pointer)=3;",
        "(view=pointer)[0]+=3;",
        "++(view=pointer)[0];",
    ] {
        rejected(&format!(
            "__global__ void kernel() {{ int first[2]{{2,3}},second[2]{{5,7}};
            const int *view=first;int *pointer=second;{statement} }}"
        ));
    }
}

#[test]
fn cuda_pointer_assignments_require_modifiable_pointer_object_lvalues() {
    for statement in [
        "(pointer+0)=second;",
        "(+pointer)=second;",
        "(pointer++)=second;",
        "first=second;",
        "(choose?pointer:readonly)=second;",
        "(choose?pointer:fixed)=second;",
    ] {
        rejected(&format!(
            "__global__ void kernel(int *out) {{
                int first[3]{{2,3,5}},second[3]{{7,11,13}};
                int *pointer=first;const int *readonly=first;int *const fixed=first;
                bool choose=bool(out[0]);{statement}
            }}"
        ));
    }
}

#[test]
fn cuda_pointer_assignments_reject_invalid_rhs_and_unsupported_compounds() {
    for right in [
        "1",
        "1.5f",
        "int2{1,2}",
        "nothing()",
        "nullptr",
        "0",
        "{}",
        "{first}",
    ] {
        rejected(&format!(
            "__device__ void nothing() {{}} __global__ void kernel() {{
                int first[2]{{2,3}};int *pointer=first;pointer={right};
            }}"
        ));
    }
    for operator in ["*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>="] {
        rejected(&format!(
            "__global__ void kernel() {{ int values[2]{{2,3}};
            int *pointer=values;pointer{operator}1; }}"
        ));
    }
}

#[test]
fn cuda_pointer_assignments_are_not_evaluated_constant_expressions() {
    for source in [
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *pointer=first;constexpr int Count=(pointer=second,4);int values[Count]{}; }",
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *pointer=first;const int Count=(pointer=second,4);int values[Count]{}; }",
        "__device__ void unused(int *pointer,int *other) { constexpr int Count=(pointer=other,4);int values[Count]{}; } __global__ void kernel() {}",
        "__global__ void kernel() { int first[2]{2,3},second[2]{5,7};int *pointer=first;return;constexpr int Count=(pointer=second,4);int values[Count]{}; }",
        "__device__ int check(int *pointer,int *other) { const int Count=(pointer=other,3);int values[Count]{};return values[0]; } __global__ void kernel(int *out) { __shared__ int first[3],second[3];out[0]=check(first,second); }",
    ] {
        let error = rejected(source);
        assert!(error.message.contains("constant"), "{error}");
    }
}

#[test]
fn cuda_pointer_assignments_preserve_macro_and_utf8_source_spans() {
    let source = "#define REBIND pointer = readonly\n/* λ 漢 */ __global__ void kernel() { int values[2]{2,3};int *pointer=values;const int *readonly=values;REBIND; }";
    let error = rejected(source);
    assert!(error.message.contains("incompatible"), "{error}");
    assert_eq!(&source[error.span.to_range().unwrap()], "REBIND");
}

#[test]
fn cuda_pointer_assignments_keep_flat_runtime_copy_cycles_bounded() {
    for statements in [
        "pointer=first;pointer=second;",
        "pointer=other;other=pointer;",
    ] {
        let source = format!(
            "__global__ void kernel(int *out) {{
                int first[2]{{2,3}},second[2]{{5,7}};
                int *pointer=first,*other=second;{}
                out[0]=*pointer;
            }}",
            statements.repeat(512),
        );
        let (module, info) = validate(&source);
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = (module, info);
    }
}

#[test]
fn cuda_pointer_assignments_keep_flat_copied_values_bounded() {
    let mut source = String::from(
        "__global__ void kernel(int *out) { int first[3]{2,3,5},second[3]{7,11,13};int *pointer0=first;",
    );
    for index in 1..128 {
        source.push_str(&format!(
            "int *pointer{index}=pointer{};pointer{}=second+1;pointer{index}=first+1;",
            index - 1,
            index - 1,
        ));
    }
    source.push_str("out[0]=*pointer127;out[1]=*pointer0;}");
    let (module, info) = validate(&source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_pointer_assignments_forward_linear_helper_chains() {
    let mut source =
        String::from("__device__ void step0(int *first,int *second) { first=second; }");
    for level in 1..48 {
        source.push_str(&format!(
            "__device__ void step{level}(int *first,int *second) {{ first=second;step{}(first,second); }}",
            level - 1,
        ));
    }
    source.push_str(
        "__global__ void kernel(int *out) { int first[2]{2,3},second[2]{5,7};int *pointer=first;step47(pointer,second);out[0]=*pointer; }",
    );
    let (module, info) = validate(&source);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_pointer_assignments_accept_wide_dynamic_origin_families() {
    let mut source = String::from(
        "struct Record { int samples[2]; };__global__ void kernel(int *out) { int index=out[31]&1;",
    );
    for index in 0..32 {
        source.push_str(&format!(
            "Record records{index}[2]{{{{{{2,3}}}},{{{{5,7}}}}}};"
        ));
    }
    source.push_str("int *pointer=&records0[index].samples[0];");
    for index in 1..32 {
        source.push_str(&format!("pointer=&records{index}[index].samples[1];"));
    }
    source.push_str(
        "float floating[2]{1.0f,2.0f};float *other=floating;other=floating+1;out[0]=*pointer+int(*other);}",
    );
    validate(&source);
}

#[test]
fn cuda_pointer_assignments_bound_cumulative_helper_expansion() {
    let mut source = String::from(
        "__device__ void step0(int *pointer,int *other) { int *copy=pointer;pointer=other;copy=&pointer[1]; }",
    );
    for level in 1..24 {
        source.push_str(&format!(
            "__device__ void step{level}(int *pointer,int *other) {{ step{}(pointer,other);step{}(pointer,other); }}",
            level - 1,
            level - 1,
        ));
    }
    source.push_str(
        "__global__ void kernel() { int first[3]{2,3,5},second[3]{7,11,13};step23(first,second); }",
    );
    expect_limit(&source);
}

#[test]
fn cuda_pointer_assignments_bound_nested_assignment_and_prefix_destinations() {
    let assignment = format!("{}second", "pointer=".repeat(128));
    let prefix = format!("{}pointer=second", "++".repeat(128));
    for expression in [assignment, prefix] {
        expect_limit(&format!(
            "__global__ void kernel() {{ int first[3]{{2,3,5}},second[3]{{7,11,13}};int *pointer=first;{expression}; }}"
        ));
    }
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[test]
fn cuda_pointer_assignments_roundtrip_through_shared_wgsl_validation() {
    let (module, info) = validate(FIXTURE);
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}
