use super::helpers::{root_expression, validate, validate_with_options};

const PARTICLES: &str = include_str!("../../in/cuda/particles.cu");
const COPY_SNAPSHOTS: &str = include_str!("../../in/cuda/scalar-copy-snapshots.cu");

fn local(function: &naga::Function, name: &str) -> naga::Handle<naga::LocalVariable> {
    function
        .local_variables
        .iter()
        .find_map(|(handle, variable)| (variable.name.as_deref() == Some(name)).then_some(handle))
        .unwrap_or_else(|| panic!("missing required storage for {name}"))
}

fn assert_no_local(function: &naga::Function, name: &str) {
    assert!(
        function
            .local_variables
            .iter()
            .all(|(_, variable)| variable.name.as_deref() != Some(name)),
        "redundant storage remains for {name}"
    );
}

fn assert_no_unsigned_index_storage(module: &naga::Module, function: &naga::Function) {
    assert!(
        function
            .local_variables
            .iter()
            .all(|(_, local)| module.types[local.ty].inner
                != naga::TypeInner::Scalar(naga::Scalar::U32)),
        "constant resource indices retain unsigned capture storage"
    );
}

fn named_scalar(
    module: &naga::Module,
    function: &naga::Function,
    info: &naga::valid::FunctionInfo,
    name: &str,
    scalar: naga::Scalar,
) -> naga::Handle<naga::Expression> {
    let expression = function
        .named_expressions
        .iter()
        .find_map(|(&handle, actual)| (actual == name).then_some(handle))
        .unwrap_or_else(|| panic!("missing named value {name}"));
    assert_eq!(
        info[expression].ty.inner_with(&module.types),
        &naga::TypeInner::Scalar(scalar),
        "named value {name}"
    );
    assert_no_local(function, name);
    expression
}

fn assert_particle_values(module: &naga::Module, info: &naga::valid::ModuleInfo) {
    let entry = &module.entry_points[0];
    assert_eq!(entry.name, "particles");
    for name in ["i", "count", "side"] {
        named_scalar(
            module,
            &entry.function,
            info.get_entry_point(0),
            name,
            naga::Scalar::U32,
        );
    }
    for name in ["time", "x", "y", "distance", "ripple"] {
        named_scalar(
            module,
            &entry.function,
            info.get_entry_point(0),
            name,
            naga::Scalar::F32,
        );
    }
    let (handle, wave) = module
        .functions
        .iter()
        .find(|&(_, function)| function.name.as_deref() == Some("wave"))
        .unwrap();
    for name in ["x", "y"] {
        named_scalar(module, wave, &info[handle], name, naga::Scalar::F32);
    }
    assert_no_local(wave, "angle");
    assert!(wave.arguments.iter().any(|argument| {
        argument.name.as_deref() == Some("angle")
            && module.types[argument.ty].inner == naga::TypeInner::Scalar(naga::Scalar::F32)
    }));
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
fn emitted_name(actual: &str, expected: &str) -> bool {
    actual == expected
        || actual
            .strip_prefix(expected)
            .is_some_and(|suffix| suffix.starts_with('_'))
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
fn assert_emitted_values(function: &naga::Function, expected: &[&str]) {
    for &name in expected {
        assert!(
            function
                .named_expressions
                .values()
                .any(|actual| emitted_name(actual, name)),
            "missing emitted named value {name}"
        );
        assert!(
            function.local_variables.iter().all(|(_, local)| {
                local
                    .name
                    .as_deref()
                    .is_none_or(|actual| !emitted_name(actual, name))
            }),
            "emitted redundant storage for {name}"
        );
    }
}

fn assert_particle_point_indices(module: &naga::Module) {
    let function = &module.entry_points[0].function;
    let particle_index = function
        .named_expressions
        .iter()
        .find_map(|(&handle, name)| (name == "i").then_some(handle))
        .expect("missing particle index");
    let points = module
        .global_variables
        .iter()
        .find_map(|(handle, global)| {
            (global.binding
                == Some(naga::ResourceBinding {
                    group: 0,
                    binding: 0,
                }))
            .then_some(handle)
        })
        .expect("missing particle buffer");
    let indices: Vec<_> = function
        .expressions
        .iter()
        .filter_map(|(_, expression)| match *expression {
            naga::Expression::Access { base, index }
                if matches!(function.expressions[base], naga::Expression::GlobalVariable(global) if global == points) =>
            {
                Some(index)
            }
            _ => None,
        })
        .collect();
    assert!(!indices.is_empty(), "missing particle buffer access");
    assert!(
        indices.iter().all(|&index| index == particle_index),
        "particle writes retain redundant index snapshots instead of reusing i"
    );
}

#[test]
fn cuda_scalar_promotion_names_the_complete_particles_shader() {
    let (module, info) = validate_with_options(
        PARTICLES,
        &naga::front::cuda::Options {
            workgroup_size: [64, 1, 1],
            ..naga::front::cuda::Options::default()
        },
    );
    assert_particle_values(&module, &info);
    assert_particle_point_indices(&module);
    assert_no_unsigned_index_storage(&module, &module.entry_points[0].function);
    assert!(
        module.entry_points[0]
            .function
            .local_variables
            .iter()
            .all(|(_, local)| {
                local.name.is_some()
                    || module.types[local.ty].inner != naga::TypeInner::Scalar(naga::Scalar::F32)
            }),
        "particle buffer reads retain redundant float copy storage"
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_emitted_values(
            &reparsed.entry_points[0].function,
            &["i", "count", "time", "side", "x", "y", "distance", "ripple"],
        );
        assert_particle_point_indices(&reparsed);
        assert_no_unsigned_index_storage(&reparsed, &reparsed.entry_points[0].function);
        let (_, wave) = reparsed
            .functions
            .iter()
            .find(|&(_, function)| function.name.as_deref() == Some("wave"))
            .unwrap();
        assert_emitted_values(wave, &["x", "y"]);
        assert_no_local(wave, "angle");
        assert!(wave
            .arguments
            .iter()
            .any(|argument| argument.name.as_deref() == Some("angle")));
    }
}

#[test]
fn cuda_scalar_promotion_avoids_storage_for_nonnegative_literal_and_cast_indices() {
    for index in [
        "0",
        "1u",
        "unsigned(0)",
        "static_cast<int>(1u)",
        "int(unsigned(0))",
        "(unsigned)1",
    ] {
        for source in [
            format!("__global__ void kernel(int *output, const int *input) {{ int value = input[{index}]; output[0] = value; }}"),
            format!("__global__ void kernel(int *output) {{ int values[2]{{3, 5}}; const int &value = values[{index}]; output[0] = value; }}"),
        ] {
            let (module, info) = validate(&source);
            assert_no_unsigned_index_storage(&module, &module.entry_points[0].function);
            #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
            {
                let (_, reparsed) = super::helpers::wgsl_roundtrip(
                    &module, &info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
                );
                assert_no_unsigned_index_storage(&reparsed, &reparsed.entry_points[0].function);
            }
            let _ = info;
        }
    }
}

#[test]
fn cuda_scalar_promotion_preserves_mutable_index_views_and_runtime_offset_arithmetic() {
    let (module, info) = validate(
        "__device__ int advance(int &index) { int previous = index; ++index; return previous; }
        __global__ void kernel(int *output) {
            int index = 8; const int &view = index;
            int &saved = output[view]; ++index;
            int &from_call = output[advance(index)]; ++index;
            int &selected = output[output[7] ? index++ : advance(index) + 1];
            ++index; saved = 3; from_call = 5; selected = 7;
            for (int iteration = 0; iteration < 2; ++iteration) {
                int &captured = output[index++]; captured += iteration;
            }
            int *cursor = output + 18; cursor[-1] = 23;
            unsigned seed = 4294967295u; unsigned wrapped = seed + 1u;
            int *origin = output + wrapped; origin[18] = 9;
            output[0] = index;
        }",
    );
    local(&module.entry_points[0].function, "index");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
    for source in [
        "__global__ void kernel(int *output) { int values[2]{3, 5}; int &saved = values[7]; output[0] = saved; }",
        "__global__ void kernel(int *output) { int values[2]{3, 5}; int &saved = values[-1]; output[0] = saved; }",
        "__global__ void kernel(int *output) { int &saved = output[-1]; output[0] = saved; }",
        "__global__ void kernel(int *output) { int *cursor = output + 0xffffffffu; cursor += 1u; cursor[0] = 7; }",
    ] {
        let (module, info) = validate(source);
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(&module, &info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES);
        let _ = (module, info);
    }
}

#[test]
fn cuda_scalar_promotion_keeps_required_mutable_and_aliased_storage() {
    for (source, expected) in [
        (
            "__global__ void kernel(int *out) { int changed = out[0]; changed += 1; out[1] = changed; }",
            "changed",
        ),
        (
            "__global__ void kernel(int *out) { int addressed = out[0]; int *pointer = &addressed; *pointer += 2; out[1] = addressed; }",
            "addressed",
        ),
        (
            "__device__ void change(int &value) { value += 3; } __global__ void kernel(int *out) { int referenced = out[0]; change(referenced); out[1] = referenced; }",
            "referenced",
        ),
        (
            "__global__ void kernel(int *out) { int changed = out[0]; if (out[1]) changed = 11; out[2] = changed; }",
            "changed",
        ),
    ] {
        let (module, info) = validate(source);
        local(&module.entry_points[0].function, expected);
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(&module, &info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES);
        let _ = info;
    }
}

#[test]
fn cuda_scalar_promotion_keeps_reads_before_the_only_store() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int pending;
            out[0] = pending;
            pending = out[1];
            out[2] = pending;
        }",
    );
    let function = &module.entry_points[0].function;
    let pending = local(function, "pending");
    let mut saw_load = false;
    assert!(naga::proc::any_statement(
        &function.body,
        &mut |statement| {
            match *statement {
                naga::Statement::Emit(ref range) => {
                    saw_load |= range.clone().any(|handle| {
                        matches!(function.expressions[handle], naga::Expression::Load { pointer }
                        if matches!(function.expressions[root_expression(function, pointer)],
                            naga::Expression::LocalVariable(local) if local == pending))
                    });
                    false
                }
                naga::Statement::Store { pointer, .. } => {
                    saw_load
                        && matches!(function.expressions[root_expression(function, pointer)],
                    naga::Expression::LocalVariable(local) if local == pending)
                }
                _ => false,
            }
        }
    ));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_scalar_promotion_keeps_branch_joins_and_loop_carried_storage() {
    for (source, expected) in [
        (
            "__global__ void kernel(int *out) { int joined; if (out[0]) joined = 3; else joined = 7; out[1] = joined; }",
            "joined",
        ),
        (
            "__global__ void kernel(int *out) { int total = out[0]; for (int iteration = 0; iteration < 3; ++iteration) total += iteration; out[1] = total; }",
            "total",
        ),
        (
            "__global__ void kernel(int *out) { int repeated; for (int iteration = 0; iteration < 3; ++iteration) { repeated = iteration + out[3]; out[iteration] = repeated; } }",
            "repeated",
        ),
    ] {
        let (module, info) = validate(source);
        local(&module.entry_points[0].function, expected);
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(&module, &info, naga::back::wgsl::WriterFlags::EXPLICIT_TYPES);
        let _ = info;
    }
}

#[test]
fn cuda_scalar_promotion_preserves_initializer_snapshot_sequence() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int source = out[3];
            int captured = source;
            source = 9;
            out[0] = captured;
            out[1] = source;
            out[2] = captured;
        }",
    );
    let function = &module.entry_points[0].function;
    let source = local(function, "source");
    let captured = named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "captured",
        naga::Scalar::I32,
    );
    assert!(
        matches!(function.expressions[captured], naga::Expression::Load { pointer }
        if matches!(function.expressions[root_expression(function, pointer)],
            naga::Expression::LocalVariable(local) if local == source))
    );
    let mut event = 0;
    let mut emitted = Vec::new();
    let mut stores = Vec::new();
    let mut captured_stores = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        match *statement {
            naga::Statement::Emit(ref range) if range.clone().any(|handle| handle == captured) => {
                emitted.push(event);
            }
            naga::Statement::Store { pointer, value } => {
                if matches!(function.expressions[root_expression(function, pointer)],
                    naga::Expression::LocalVariable(local) if local == source)
                {
                    stores.push(event);
                }
                captured_stores += usize::from(value == captured);
            }
            _ => {}
        }
        event += 1;
        false
    });
    assert_eq!(emitted.len(), 1);
    assert_eq!(stores.len(), 2);
    assert!(stores[0] < emitted[0] && emitted[0] < stores[1]);
    assert_eq!(captured_stores, 2);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_scalar_promotion_keeps_root_values_visible_after_nested_branches() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int base = out[0] + 1;
            if (out[1]) {
                int branch = out[2];
                out[3] = base + branch;
            } else {
                out[3] = base;
            }
            out[4] = base;
        }",
    );
    named_scalar(
        &module,
        &module.entry_points[0].function,
        info.get_entry_point(0),
        "base",
        naga::Scalar::I32,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_emitted_values(&reparsed.entry_points[0].function, &["base"]);
    }
}

#[test]
fn cuda_scalar_promotion_keeps_existing_names_for_shared_values() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int first = out[0];
            int second = first;
            out[1] = first + second;
        }",
    );
    let function = &module.entry_points[0].function;
    named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "first",
        naga::Scalar::I32,
    );
    assert_no_local(function, "second");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_scalar_promotion_preserves_runtime_unsigned_wraparound() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            unsigned seed = 4294967295u;
            unsigned wrapped = seed + 1u;
            out[0] = int(wrapped);
            out[1] = int(seed == 4294967295u);
        }",
    );
    let function = &module.entry_points[0].function;
    local(function, "seed");
    named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "wrapped",
        naga::Scalar::U32,
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_scalar_promotion_keeps_valid_shallow_storage_when_merged_depth_would_grow() {
    let mut source = String::from("__global__ void kernel(int *out) { int value0 = out[0];");
    for index in 1..80 {
        source.push_str(&format!("int value{index} = value{} + out[0];", index - 1));
    }
    source.push_str("out[1] = value79; }");
    let (module, info) = validate(&source);
    local(&module.entry_points[0].function, "value40");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_scalar_promotion_keeps_nonfinite_math_at_runtime() {
    let (module, info) = validate(
        "__global__ void kernel(unsigned *output) {
            float nan_value = __uint_as_float(0x7f800000u + 1u);
            float infinity = __uint_as_float(0x7f800000u);
            output[0] = __float_as_uint(fabsf(nan_value));
            output[1] = __float_as_uint(floorf(nan_value));
            output[2] = __float_as_uint(sqrtf(nan_value));
            output[3] = __float_as_uint(floorf(infinity));
            output[4] = __float_as_uint(fabsf(infinity));
        }",
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = (module, info);
}

#[test]
fn cuda_scalar_promotion_removes_runtime_copy_chains_and_keeps_named_values() {
    for scalar_type in ["int", "unsigned", "float"] {
        let (module, info) = validate(&format!(
            "__global__ void kernel({scalar_type} *output) {{ output[1] = output[0]; }}"
        ));
        let function = &module.entry_points[0].function;
        let values: Vec<_> = function
            .body
            .iter()
            .filter_map(|statement| {
                let naga::Statement::Store { pointer, value } = *statement else {
                    return None;
                };
                matches!(
                    function.expressions[root_expression(function, pointer)],
                    naga::Expression::GlobalVariable(_)
                )
                .then_some(value)
            })
            .collect();
        assert_eq!(values.len(), 1, "{scalar_type}");
        assert!(
            matches!(function.expressions[values[0]], naga::Expression::Load { pointer }
            if matches!(function.expressions[root_expression(function, pointer)],
                naga::Expression::GlobalVariable(_))),
            "{scalar_type}: redundant scalar copy remains"
        );
        #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
        super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        let _ = info;
    }
    let (module, info) = validate(
        "__global__ void kernel(int *output) {
            int captured = output[0];
            int copied = captured;
            int result = copied + 1;
            output[1] = result;
            output[2] = captured;
        }",
    );
    let function = &module.entry_points[0].function;
    let captured = named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "captured",
        naga::Scalar::I32,
    );
    named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "result",
        naga::Scalar::I32,
    );
    assert!(
        matches!(function.expressions[captured], naga::Expression::Load { pointer }
        if matches!(function.expressions[root_expression(function, pointer)], naga::Expression::GlobalVariable(_)))
    );
    assert!(function.local_variables.iter().all(|(_, local)| {
        local.name.is_some()
            || module.types[local.ty].inner != naga::TypeInner::Scalar(naga::Scalar::I32)
    }));
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_emitted_values(&reparsed.entry_points[0].function, &["captured", "result"]);
    }
}

#[test]
fn cuda_scalar_promotion_keeps_resource_snapshot_emission_before_mutation() {
    let (module, info) = validate(COPY_SNAPSHOTS);
    let function = &module.entry_points[0].function;
    let mut snapshots = Vec::new();
    for name in [
        "direct_snapshot",
        "helper_snapshot",
        "branch_snapshot",
        "loop_snapshot",
        "atomic_snapshot",
    ] {
        let snapshot = named_scalar(
            &module,
            function,
            info.get_entry_point(0),
            name,
            naga::Scalar::I32,
        );
        assert!(
            matches!(function.expressions[snapshot], naga::Expression::Load { pointer }
            if matches!(function.expressions[root_expression(function, pointer)], naga::Expression::GlobalVariable(_))),
            "{name}"
        );
        snapshots.push(snapshot);
    }
    local(function, "changed");
    let mut event = 0;
    let mut direct_emits = Vec::new();
    let mut first_mutation = None;
    naga::proc::any_statement(&function.body, &mut |statement| {
        match *statement {
            naga::Statement::Emit(ref range)
                if range.clone().any(|handle| handle == snapshots[0]) =>
            {
                direct_emits.push(event)
            }
            naga::Statement::Store { pointer, .. } | naga::Statement::Atomic { pointer, .. }
                if matches!(
                    function.expressions[root_expression(function, pointer)],
                    naga::Expression::GlobalVariable(_)
                ) =>
            {
                first_mutation.get_or_insert(event);
            }
            _ => {}
        }
        event += 1;
        false
    });
    assert_eq!(direct_emits.len(), 1);
    assert!(direct_emits[0] < first_mutation.unwrap());
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_emitted_values(&reparsed.entry_points[0].function, &["previous"]);
    }
}

#[test]
fn cuda_scalar_promotion_keeps_multiple_stores_even_when_values_share_an_argument() {
    let (module, info) = validate(
        "__device__ int repeat(int input) {
            int repeated = input;
            repeated = input;
            return repeated;
        }
        __global__ void kernel(int *out) { out[1] = repeat(out[0]); }",
    );
    let (handle, function) = module
        .functions
        .iter()
        .find(|&(_, function)| function.name.as_deref() == Some("repeat"))
        .unwrap();
    let repeated = local(function, "repeated");
    assert_no_local(function, "input");
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            if matches!(function.expressions[root_expression(function, pointer)],
                naga::Expression::LocalVariable(local) if local == repeated)
            {
                values.push(value);
            }
        }
        false
    });
    assert_eq!(values.len(), 2);
    assert_eq!(values[0], values[1]);
    assert_eq!(
        info[handle][values[0]].ty.inner_with(&module.types),
        &naga::TypeInner::Scalar(naga::Scalar::I32)
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
}

#[test]
fn cuda_scalar_promotion_names_one_call_result_used_in_both_branches_and_afterward() {
    let (module, info) = validate(
        "__device__ int advance(int value) { return value + 1; }
        __global__ void kernel(int *out) {
            int source = out[0];
            int captured = advance(source++);
            if (out[3]) out[1] = captured;
            else out[1] = captured + 10;
            out[2] = captured;
            out[0] = source;
        }",
    );
    let function = &module.entry_points[0].function;
    let captured = named_scalar(
        &module,
        function,
        info.get_entry_point(0),
        "captured",
        naga::Scalar::I32,
    );
    assert!(matches!(
        function.expressions[captured],
        naga::Expression::CallResult(_)
    ));
    let mut calls = 0;
    naga::proc::any_statement(&function.body, &mut |statement| {
        calls += usize::from(
            matches!(*statement, naga::Statement::Call { result: Some(result), .. } if result == captured),
        );
        false
    });
    assert_eq!(calls, 1);
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    {
        let (_, reparsed) = super::helpers::wgsl_roundtrip(
            &module,
            &info,
            naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
        );
        assert_emitted_values(&reparsed.entry_points[0].function, &["captured"]);
    }
}

#[test]
fn cuda_scalar_promotion_keeps_nested_reads_before_the_only_root_store() {
    let (module, info) = validate(
        "__global__ void kernel(int *out) {
            int pending;
            if (out[0]) out[1] = pending;
            pending = out[2];
            out[3] = pending;
        }",
    );
    local(&module.entry_points[0].function, "pending");
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}
