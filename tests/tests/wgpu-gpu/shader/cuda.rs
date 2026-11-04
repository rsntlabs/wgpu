use naga::front::cuda::{parse_str, Options};
use naga::valid::{Capabilities, ValidationFlags, Validator};
use wgpu::{DownlevelFlags, Limits};
use wgpu_test::{apply, gpu_test, GpuTestConfiguration, GpuTestInitializer, TestParameters};

use super::{
    shader_input_output_test, InputStorageType, ShaderBuffer, ShaderTest, MAX_BUFFER_SIZE,
};

mod arithmetic;
mod array_aliases;
mod arrow_members;
mod atomic_add;
mod atomic_cas;
mod atomic_operations;
mod atomic_wrap;
mod auto_declarations;
mod bitcasts;
mod cached_math;
mod ceilf;
mod class_values;
mod comma;
mod conditionals;
mod constant_expressions;
mod constant_memory;
mod control_flow;
mod declarations;
mod device_helper_barriers;
mod device_shared;
mod dim3;
mod direct_aggregate_initialization;
mod direct_borrowed_initialization;
mod direct_initialization;
mod dual_execution;
mod dynamic_shared;
mod empty_scalar_construction;
mod fabs;
mod float_division;
mod float_math;
mod float_separators;
mod float_truthiness;
mod floorf;
mod fmodf;
mod function_macros;
mod helper_builtins;
mod helper_parameters;
mod hex_float_literals;
mod immutable_pointers;
mod incomplete_array_aliases;
mod incomplete_array_pointers;
mod inferred_arrays;
mod inline;
mod integer16;
mod integer16_vectors;
mod integer64;
mod integer_intrinsics;
mod integer_math;
mod integral_templates;
mod kernels;
mod launch_bounds;
mod list_initialization;
mod literals;
mod local_arrays;
mod local_declarators;
mod local_pointers;
mod logical_operators;
mod multidimensional_arrays;
mod multiple_kernels;
mod multiply24;
mod nonfinite_constants;
mod null_pointers;
mod nullptr;
mod operator_addition;
mod operator_compound_assignments;
mod operator_functions;
mod operator_null_constants;
mod parenthesized_aggregates;
mod parenthesized_arrays;
mod particles;
mod pointer_aliases;
mod pointer_assignments;
mod pointer_parameters;
mod pointer_updates;
mod pointer_values;
mod pragma_unroll;
mod preprocessing;
mod preprocessing_conditions;
mod prototypes;
mod qualified_values;
mod reference_bindings;
mod reference_categories;
mod restrict;
mod roundf;
mod rsqrtf;
mod saturate;
mod scalar_braces;
mod scalar_promotion;
mod shared_vectors;
mod signed;
mod single_component_vectors;
mod specifiers;
mod sqrt;
mod sqrtf;
mod structures;
mod switches;
mod thread_block;
mod thread_block_dimensions;
mod thread_block_parameters;
mod token_pasting;
mod trigonometry;
mod type_aliases;
mod type_templates;
mod typedef_structures;
mod uniform_branch_barriers;
mod uniform_loop_barriers;
mod uninitialized;
mod uninitialized_pointers;
mod updates;
mod vector_resources;
mod vector_values;
mod volatile;

pub fn all_tests(tests: &mut Vec<GpuTestInitializer>) {
    kernels::all_tests(tests);
    tests.extend([
        CUDA_ARITHMETIC,
        CUDA_ARRAY_ALIASES,
        CUDA_INTEGER16_ARRAY_ALIASES,
        CUDA_ARROW_MEMBERS,
        CUDA_ATOMIC_ADD,
        CUDA_ATOMIC_CAS,
        CUDA_ATOMIC_OPERATIONS,
        CUDA_ATOMIC_WRAP,
        CUDA_AUTO_DECLARATIONS,
        CUDA_BITCASTS,
        CUDA_CACHED_MATH,
        CUDA_CEILF,
        CUDA_CLASS_VALUES,
        CUDA_COMMA,
        CUDA_CONDITIONALS,
        CUDA_CONSTANT_EXPRESSIONS,
        CUDA_CONSTANT_MEMORY,
        CUDA_CONTROL_FLOW,
        CUDA_DECLARATIONS,
        CUDA_DEVICE_HELPER_BARRIERS,
        CUDA_DEVICE_SHARED,
        CUDA_DIM3,
        CUDA_DIRECT_AGGREGATE_INITIALIZATION,
        CUDA_DIRECT_BORROWED_INITIALIZATION,
        CUDA_DIRECT_INITIALIZATION,
        CUDA_DUAL_EXECUTION,
        CUDA_DYNAMIC_SHARED,
        CUDA_EMPTY_SCALAR_CONSTRUCTION,
        CUDA_FABS,
        CUDA_FLOAT_DIVISION,
        CUDA_FLOAT_MATH,
        CUDA_FLOAT_SEPARATORS,
        CUDA_FLOAT_TRUTHINESS,
        CUDA_FLOORF,
        CUDA_FMODF,
        CUDA_ROUNDF,
        CUDA_RSQRTF,
        CUDA_FUNCTION_MACROS,
        CUDA_HELPER_BUILTINS,
        CUDA_HELPER_PARAMETERS,
        CUDA_HEX_FLOAT_LITERALS,
        CUDA_IMMUTABLE_POINTERS,
        CUDA_INCOMPLETE_ARRAY_ALIASES,
        CUDA_INTEGER16_INCOMPLETE_ARRAY_ALIASES,
        CUDA_INCOMPLETE_ARRAY_POINTERS,
        CUDA_INTEGER16_INCOMPLETE_ARRAY_POINTERS,
        CUDA_INFERRED_ARRAYS,
        CUDA_INLINE,
        CUDA_INTEGER16,
        CUDA_INTEGER16_VECTORS,
        CUDA_INTEGER64,
        CUDA_INTEGER64_STORAGE,
        CUDA_INTEGER_INTRINSICS,
        CUDA_INTEGER_MATH,
        CUDA_INTEGRAL_TEMPLATES,
        CUDA_LAUNCH_BOUNDS,
        CUDA_LIST_INITIALIZATION,
        CUDA_LITERALS,
        CUDA_LOGICAL_OPERATORS,
        CUDA_LOCAL_ARRAYS,
        CUDA_LOCAL_DECLARATORS,
        CUDA_LOCAL_POINTERS,
        CUDA_MULTIDIMENSIONAL_ARRAYS,
        CUDA_MULTIPLE_KERNELS,
        CUDA_MULTIPLY24,
        CUDA_NONFINITE_CONSTANTS,
        CUDA_NULL_POINTERS,
        CUDA_NULLPTR,
        CUDA_NULLPTR_ASSIGNMENT_ORDER,
        CUDA_OPERATOR_ADDITION,
        CUDA_OPERATOR_COMPOUND_ASSIGNMENTS,
        CUDA_OPERATOR_FUNCTIONS,
        CUDA_OPERATOR_NULL_CONSTANTS,
        CUDA_PARENTHESIZED_AGGREGATES,
        CUDA_PARENTHESIZED_INTEGER16_AGGREGATES,
        CUDA_PARENTHESIZED_ARRAYS,
        CUDA_PARENTHESIZED_INTEGER16_ARRAYS,
        CUDA_PARTICLES,
        CUDA_POINTER_ALIASES,
        CUDA_POINTER_ASSIGNMENTS,
        CUDA_POINTER_PARAMETERS,
        CUDA_POINTER_UPDATES,
        CUDA_POINTER_VALUES,
        CUDA_PRAGMA_UNROLL,
        CUDA_PREPROCESSING,
        CUDA_PREPROCESSING_CONDITIONS,
        CUDA_PROTOTYPES,
        CUDA_QUALIFIED_VALUES,
        CUDA_REFERENCE_BINDINGS,
        CUDA_REFERENCE_CATEGORIES,
        CUDA_RESTRICT,
        CUDA_SATURATE,
        CUDA_SCALAR_BRACES,
        CUDA_SCALAR_PROMOTION,
        CUDA_SHARED_VECTORS,
        CUDA_SINGLE_COMPONENT_VECTORS,
        CUDA_SINGLE_COMPONENT_INTEGER16_VECTORS,
        CUDA_SIGNED,
        CUDA_SPECIFIERS,
        CUDA_SQRT,
        CUDA_SQRTF,
        CUDA_STRUCTURES,
        CUDA_SWITCHES,
        CUDA_THREAD_BLOCK,
        CUDA_THREAD_BLOCK_DIMENSIONS,
        CUDA_THREAD_BLOCK_PARAMETERS,
        CUDA_TOKEN_PASTING,
        CUDA_TRIGONOMETRY,
        CUDA_TYPE_ALIASES,
        CUDA_TYPE_TEMPLATES,
        CUDA_TYPEDEF_STRUCTURES,
        CUDA_UNINITIALIZED,
        CUDA_UNINITIALIZED_POINTERS,
        CUDA_UNIFORM_BRANCH_BARRIERS,
        CUDA_UNIFORM_LOOP_BARRIERS,
        CUDA_UPDATES,
        CUDA_VECTOR_RESOURCES,
        CUDA_VECTOR_VALUES,
        CUDA_VOLATILE_STORAGE,
        CUDA_VOLATILE_WORKGROUP,
    ]);
}

fn configuration(cases: fn() -> Vec<ShaderTest>) -> GpuTestConfiguration {
    configuration_with_features(cases, wgpu::Features::empty())
}

fn configuration_with_features(
    cases: fn() -> Vec<ShaderTest>,
    features: wgpu::Features,
) -> GpuTestConfiguration {
    GpuTestConfiguration::new()
        .parameters(
            TestParameters::default()
                .features(features)
                .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
                .limits(Limits::downlevel_defaults()),
        )
        .run_async(move |ctx| shader_input_output_test(ctx, InputStorageType::Storage, cases()))
}

fn case(name: &str, source: &str, initial: &[i32], expected: &[i32]) -> ShaderTest {
    scalar_case(name, source, initial, expected, naga::Scalar::I32)
}

fn float_case(name: &str, source: &str, initial: &[u32], expected: &[u32]) -> ShaderTest {
    let initial: Vec<i32> = initial.iter().map(|&bits| bits as i32).collect();
    let expected: Vec<i32> = expected.iter().map(|&bits| bits as i32).collect();
    scalar_case(name, source, &initial, &expected, naga::Scalar::F32)
}

fn scalar_case(
    name: &str,
    source: &str,
    initial: &[i32],
    expected: &[i32],
    scalar: naga::Scalar,
) -> ShaderTest {
    assert_eq!(initial.len(), expected.len(), "{name}");
    let mut full_expected = vec![-1_i32; MAX_BUFFER_SIZE as usize / 4];
    assert!(expected.len() <= full_expected.len(), "{name}");
    full_expected[..expected.len()].copy_from_slice(expected);

    let mut module = parse_module(name, source, [1, 1, 1]);
    assert_eq!(module.entry_points.len(), 1, "{name}");
    assert_eq!(module.entry_points[0].workgroup_size, [1, 1, 1], "{name}");
    assert!(
        module.entry_points[0].function.arguments.is_empty(),
        "{name}"
    );
    assert_eq!(module.global_variables.len(), 1, "{name}");
    let (_, output) = module.global_variables.iter_mut().next().unwrap();
    assert_eq!(
        output.binding,
        Some(naga::ResourceBinding {
            group: 0,
            binding: 0,
        }),
        "{name}"
    );
    assert_eq!(
        output.space,
        naga::AddressSpace::Storage {
            access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE,
        },
        "{name}"
    );
    let naga::TypeInner::Array {
        base,
        size: naga::ArraySize::Dynamic,
        stride: 4,
    } = module.types[output.ty].inner
    else {
        panic!("{name}: expected a scalar output array");
    };
    assert_eq!(
        module.types[base].inner,
        naga::TypeInner::Scalar(scalar),
        "{name}"
    );
    output.binding.as_mut().unwrap().binding = 1;
    let (wgsl, entry_point) = write_module(name, &module);

    ShaderTest::new(
        name.into(),
        String::new(),
        String::new(),
        &[0_u32],
        &full_expected,
    )
    .module_source(wgsl, entry_point)
    .output_initial_values(initial)
}

fn parse_module(name: &str, source: &str, workgroup_size: [u32; 3]) -> naga::Module {
    let module = parse_str(
        source,
        &Options {
            workgroup_size,
            ..Options::default()
        },
    )
    .unwrap_or_else(|error| panic!("{name}: {error}"));
    Validator::new(ValidationFlags::all(), Capabilities::empty())
        .validate(&module)
        .unwrap_or_else(|error| panic!("{name}: {error}"));
    assert_eq!(module.entry_points.len(), 1, "{name}");
    module
}

fn write_module(name: &str, module: &naga::Module) -> (String, String) {
    assert_eq!(module.entry_points.len(), 1, "{name}");
    let (wgsl, entries) = write_module_entries(name, module);
    (wgsl, entries[0].clone())
}

fn write_module_entries(name: &str, module: &naga::Module) -> (String, Vec<String>) {
    write_module_entries_with_capabilities(name, module, Capabilities::empty())
}

fn write_module_entries_with_capabilities(
    name: &str,
    module: &naga::Module,
    capabilities: Capabilities,
) -> (String, Vec<String>) {
    let info = Validator::new(ValidationFlags::all(), capabilities)
        .validate(module)
        .unwrap_or_else(|error| panic!("{name}: {error}"));
    let wgsl = naga::back::wgsl::write_string(
        module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    )
    .unwrap_or_else(|error| panic!("{name}: {error}"));
    let roundtrip =
        naga::front::wgsl::parse_str(&wgsl).unwrap_or_else(|error| panic!("{name}: {error}"));
    Validator::new(ValidationFlags::all(), capabilities)
        .validate(&roundtrip)
        .unwrap_or_else(|error| panic!("{name}: {error}"));
    assert_eq!(
        roundtrip.entry_points.len(),
        module.entry_points.len(),
        "{name}"
    );
    for (original, emitted) in module.entry_points.iter().zip(&roundtrip.entry_points) {
        assert_eq!(original.stage, emitted.stage, "{name}");
        assert_eq!(original.workgroup_size, emitted.workgroup_size, "{name}");
    }
    (
        wgsl,
        roundtrip
            .entry_points
            .iter()
            .map(|entry| entry.name.clone())
            .collect(),
    )
}

fn module_entry_case<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    workgroup_size: [u32; 3],
    entry_name: &str,
    expected: &[O],
) -> ShaderTest {
    module_entry_case_with_options(
        name,
        source,
        &Options {
            workgroup_size,
            ..Options::default()
        },
        entry_name,
        expected,
    )
}

fn module_entry_case_with_options<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    options: &Options,
    entry_name: &str,
    expected: &[O],
) -> ShaderTest {
    let module = parse_str(source, options).unwrap_or_else(|error| panic!("{name}: {error}"));
    assert!(module.entry_points.len() > 1, "{name}");
    let selected = module
        .entry_points
        .iter()
        .position(|entry| entry.name == entry_name)
        .unwrap_or_else(|| panic!("{name}: missing entry {entry_name}"));
    let (wgsl, entries) = write_module_entries(name, &module);
    ShaderTest::new(
        name.into(),
        String::new(),
        String::new(),
        &[0_u32],
        expected,
    )
    .module_source(wgsl, entries[selected].clone())
}

fn module_case<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    workgroup_size: [u32; 3],
    expected: &[O],
) -> ShaderTest {
    module_case_with_options(
        name,
        source,
        &Options {
            workgroup_size,
            ..Options::default()
        },
        expected,
    )
}

fn module_case_with_options<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    options: &Options,
    expected: &[O],
) -> ShaderTest {
    module_case_with_options_and_capabilities(
        name,
        source,
        options,
        expected,
        Capabilities::empty(),
    )
}

fn module_case_with_options_and_capabilities<O: bytemuck::Pod + std::fmt::Debug + PartialEq>(
    name: &str,
    source: &str,
    options: &Options,
    expected: &[O],
    capabilities: Capabilities,
) -> ShaderTest {
    let module = parse_str(source, options).unwrap_or_else(|error| panic!("{name}: {error}"));
    assert_eq!(module.entry_points.len(), 1, "{name}");
    let (wgsl, entries) = write_module_entries_with_capabilities(name, &module, capabilities);
    ShaderTest::new(
        name.into(),
        String::new(),
        String::new(),
        &[0_u32],
        expected,
    )
    .module_source(wgsl, entries[0].clone())
}

#[apply(gpu_test!)]
static CUDA_VOLATILE_STORAGE: GpuTestConfiguration = configuration_with_features(
    volatile::storage_cases,
    wgpu::Features::MEMORY_DECORATION_VOLATILE,
);

#[apply(gpu_test!)]
static CUDA_VOLATILE_WORKGROUP: GpuTestConfiguration = configuration_with_features(
    volatile::workgroup_cases,
    wgpu::Features::MEMORY_DECORATION_VOLATILE_WORKGROUP,
);

#[apply(gpu_test!)]
static CUDA_ARITHMETIC: GpuTestConfiguration = configuration(arithmetic::cases);
#[apply(gpu_test!)]
static CUDA_ARRAY_ALIASES: GpuTestConfiguration = configuration(array_aliases::cases);
#[apply(gpu_test!)]
static CUDA_INTEGER16_ARRAY_ALIASES: GpuTestConfiguration =
    configuration_with_features(array_aliases::integer16_cases, wgpu::Features::SHADER_I16);
#[apply(gpu_test!)]
static CUDA_INCOMPLETE_ARRAY_ALIASES: GpuTestConfiguration =
    configuration(incomplete_array_aliases::cases);
#[apply(gpu_test!)]
static CUDA_INTEGER16_INCOMPLETE_ARRAY_ALIASES: GpuTestConfiguration = configuration_with_features(
    incomplete_array_aliases::integer16_cases,
    wgpu::Features::SHADER_I16,
);
#[apply(gpu_test!)]
static CUDA_INCOMPLETE_ARRAY_POINTERS: GpuTestConfiguration =
    configuration(incomplete_array_pointers::cases);
#[apply(gpu_test!)]
static CUDA_INTEGER16_INCOMPLETE_ARRAY_POINTERS: GpuTestConfiguration = configuration_with_features(
    incomplete_array_pointers::integer16_cases,
    wgpu::Features::SHADER_I16,
);
#[apply(gpu_test!)]
static CUDA_ARROW_MEMBERS: GpuTestConfiguration = configuration(arrow_members::cases);
#[apply(gpu_test!)]
static CUDA_ATOMIC_ADD: GpuTestConfiguration = configuration(atomic_add::cases);
#[apply(gpu_test!)]
static CUDA_ATOMIC_CAS: GpuTestConfiguration = configuration(atomic_cas::cases);
#[apply(gpu_test!)]
static CUDA_ATOMIC_OPERATIONS: GpuTestConfiguration = configuration(atomic_operations::cases);
#[apply(gpu_test!)]
static CUDA_ATOMIC_WRAP: GpuTestConfiguration = configuration(atomic_wrap::cases);
#[apply(gpu_test!)]
static CUDA_AUTO_DECLARATIONS: GpuTestConfiguration = configuration(auto_declarations::cases);
#[apply(gpu_test!)]
static CUDA_BITCASTS: GpuTestConfiguration = configuration(bitcasts::cases);
#[apply(gpu_test!)]
static CUDA_CACHED_MATH: GpuTestConfiguration = configuration(cached_math::cases);
#[apply(gpu_test!)]
static CUDA_CEILF: GpuTestConfiguration = configuration(ceilf::cases);
#[apply(gpu_test!)]
static CUDA_CLASS_VALUES: GpuTestConfiguration = configuration(class_values::cases);
#[apply(gpu_test!)]
static CUDA_COMMA: GpuTestConfiguration = configuration(comma::cases);
#[apply(gpu_test!)]
static CUDA_CONDITIONALS: GpuTestConfiguration = configuration(conditionals::cases);
#[apply(gpu_test!)]
static CUDA_CONSTANT_EXPRESSIONS: GpuTestConfiguration = configuration(constant_expressions::cases);
#[apply(gpu_test!)]
static CUDA_CONSTANT_MEMORY: GpuTestConfiguration = configuration(constant_memory::cases)
    .parameters(
        TestParameters::default()
            .downlevel_flags(DownlevelFlags::COMPUTE_SHADERS)
            .limits(Limits {
                max_storage_buffers_per_shader_stage: 5,
                ..Limits::downlevel_defaults()
            }),
    );
#[apply(gpu_test!)]
static CUDA_CONTROL_FLOW: GpuTestConfiguration = configuration(control_flow::cases);
#[apply(gpu_test!)]
static CUDA_DECLARATIONS: GpuTestConfiguration = configuration(declarations::cases);
#[apply(gpu_test!)]
static CUDA_DEVICE_HELPER_BARRIERS: GpuTestConfiguration =
    configuration(device_helper_barriers::cases);
#[apply(gpu_test!)]
static CUDA_DEVICE_SHARED: GpuTestConfiguration = configuration(device_shared::cases);
#[apply(gpu_test!)]
static CUDA_DIM3: GpuTestConfiguration = configuration(dim3::cases);
#[apply(gpu_test!)]
static CUDA_DIRECT_AGGREGATE_INITIALIZATION: GpuTestConfiguration =
    configuration(direct_aggregate_initialization::cases);
#[apply(gpu_test!)]
static CUDA_DIRECT_BORROWED_INITIALIZATION: GpuTestConfiguration =
    configuration(direct_borrowed_initialization::cases);
#[apply(gpu_test!)]
static CUDA_DIRECT_INITIALIZATION: GpuTestConfiguration =
    configuration(direct_initialization::cases);
#[apply(gpu_test!)]
static CUDA_DUAL_EXECUTION: GpuTestConfiguration = configuration(dual_execution::cases);
#[apply(gpu_test!)]
static CUDA_DYNAMIC_SHARED: GpuTestConfiguration = configuration(dynamic_shared::cases);
#[apply(gpu_test!)]
static CUDA_EMPTY_SCALAR_CONSTRUCTION: GpuTestConfiguration =
    configuration(empty_scalar_construction::cases);
#[apply(gpu_test!)]
static CUDA_FABS: GpuTestConfiguration = configuration(fabs::cases);
#[apply(gpu_test!)]
static CUDA_FLOAT_DIVISION: GpuTestConfiguration = configuration(float_division::cases);
#[apply(gpu_test!)]
static CUDA_FLOAT_MATH: GpuTestConfiguration = configuration(float_math::cases);
#[apply(gpu_test!)]
static CUDA_FLOAT_SEPARATORS: GpuTestConfiguration = configuration(float_separators::cases);
#[apply(gpu_test!)]
static CUDA_FLOAT_TRUTHINESS: GpuTestConfiguration = configuration(float_truthiness::cases);
#[apply(gpu_test!)]
static CUDA_FLOORF: GpuTestConfiguration = configuration(floorf::cases);
#[apply(gpu_test!)]
static CUDA_FMODF: GpuTestConfiguration = configuration(fmodf::cases);
#[apply(gpu_test!)]
static CUDA_ROUNDF: GpuTestConfiguration = configuration(roundf::cases);
#[apply(gpu_test!)]
static CUDA_RSQRTF: GpuTestConfiguration = configuration(rsqrtf::cases);
#[apply(gpu_test!)]
static CUDA_FUNCTION_MACROS: GpuTestConfiguration = configuration(function_macros::cases);
#[apply(gpu_test!)]
static CUDA_HELPER_BUILTINS: GpuTestConfiguration = configuration(helper_builtins::cases);

#[apply(gpu_test!)]
static CUDA_HELPER_PARAMETERS: GpuTestConfiguration = configuration(helper_parameters::cases);
#[apply(gpu_test!)]
static CUDA_HEX_FLOAT_LITERALS: GpuTestConfiguration = configuration(hex_float_literals::cases);
#[apply(gpu_test!)]
static CUDA_IMMUTABLE_POINTERS: GpuTestConfiguration = configuration(immutable_pointers::cases);
#[apply(gpu_test!)]
static CUDA_INFERRED_ARRAYS: GpuTestConfiguration = configuration(inferred_arrays::cases);
#[apply(gpu_test!)]
static CUDA_INLINE: GpuTestConfiguration = configuration(inline::cases);
#[apply(gpu_test!)]
static CUDA_INTEGER_INTRINSICS: GpuTestConfiguration = configuration(integer_intrinsics::cases);
#[apply(gpu_test!)]
static CUDA_INTEGER_MATH: GpuTestConfiguration = configuration(integer_math::cases);
#[apply(gpu_test!)]
static CUDA_INTEGRAL_TEMPLATES: GpuTestConfiguration = configuration(integral_templates::cases);
#[apply(gpu_test!)]
static CUDA_LAUNCH_BOUNDS: GpuTestConfiguration = configuration(launch_bounds::cases);
#[apply(gpu_test!)]
static CUDA_LIST_INITIALIZATION: GpuTestConfiguration = configuration(list_initialization::cases);
#[apply(gpu_test!)]
static CUDA_LITERALS: GpuTestConfiguration = configuration(literals::cases);
#[apply(gpu_test!)]
static CUDA_LOGICAL_OPERATORS: GpuTestConfiguration = configuration(logical_operators::cases);
#[apply(gpu_test!)]
static CUDA_LOCAL_ARRAYS: GpuTestConfiguration = configuration(local_arrays::cases);
#[apply(gpu_test!)]
static CUDA_LOCAL_DECLARATORS: GpuTestConfiguration = configuration(local_declarators::cases);
#[apply(gpu_test!)]
static CUDA_LOCAL_POINTERS: GpuTestConfiguration = configuration(local_pointers::cases);
#[apply(gpu_test!)]
static CUDA_MULTIDIMENSIONAL_ARRAYS: GpuTestConfiguration =
    configuration(multidimensional_arrays::cases);
#[apply(gpu_test!)]
static CUDA_MULTIPLE_KERNELS: GpuTestConfiguration = configuration(multiple_kernels::cases);
#[apply(gpu_test!)]
static CUDA_MULTIPLY24: GpuTestConfiguration = configuration(multiply24::cases);
#[apply(gpu_test!)]
static CUDA_NONFINITE_CONSTANTS: GpuTestConfiguration = configuration(nonfinite_constants::cases);
#[apply(gpu_test!)]
static CUDA_NULL_POINTERS: GpuTestConfiguration = configuration(null_pointers::cases);
#[apply(gpu_test!)]
static CUDA_NULLPTR: GpuTestConfiguration = configuration(nullptr::cases);
#[apply(gpu_test!)]
static CUDA_NULLPTR_ASSIGNMENT_ORDER: GpuTestConfiguration =
    configuration(nullptr::assignment_order_cases);
#[apply(gpu_test!)]
static CUDA_OPERATOR_ADDITION: GpuTestConfiguration = configuration(operator_addition::cases);
#[apply(gpu_test!)]
static CUDA_OPERATOR_COMPOUND_ASSIGNMENTS: GpuTestConfiguration =
    configuration(operator_compound_assignments::cases);
#[apply(gpu_test!)]
static CUDA_OPERATOR_FUNCTIONS: GpuTestConfiguration = configuration(operator_functions::cases);
#[apply(gpu_test!)]
static CUDA_OPERATOR_NULL_CONSTANTS: GpuTestConfiguration =
    configuration(operator_null_constants::cases);
#[apply(gpu_test!)]
static CUDA_PARTICLES: GpuTestConfiguration = configuration(particles::cases);
#[apply(gpu_test!)]
static CUDA_PREPROCESSING: GpuTestConfiguration = configuration(preprocessing::cases);
#[apply(gpu_test!)]
static CUDA_PREPROCESSING_CONDITIONS: GpuTestConfiguration =
    configuration(preprocessing_conditions::cases);
#[apply(gpu_test!)]
static CUDA_POINTER_ALIASES: GpuTestConfiguration = configuration(pointer_aliases::cases);
#[apply(gpu_test!)]
static CUDA_POINTER_ASSIGNMENTS: GpuTestConfiguration = configuration(pointer_assignments::cases);
#[apply(gpu_test!)]
static CUDA_POINTER_PARAMETERS: GpuTestConfiguration = configuration(pointer_parameters::cases);
#[apply(gpu_test!)]
static CUDA_POINTER_UPDATES: GpuTestConfiguration = configuration(pointer_updates::cases);
#[apply(gpu_test!)]
static CUDA_POINTER_VALUES: GpuTestConfiguration = configuration(pointer_values::cases);
#[apply(gpu_test!)]
static CUDA_PRAGMA_UNROLL: GpuTestConfiguration = configuration(pragma_unroll::cases);
#[apply(gpu_test!)]
static CUDA_PROTOTYPES: GpuTestConfiguration = configuration(prototypes::cases);
#[apply(gpu_test!)]
static CUDA_QUALIFIED_VALUES: GpuTestConfiguration = configuration(qualified_values::cases);
#[apply(gpu_test!)]
static CUDA_REFERENCE_BINDINGS: GpuTestConfiguration = configuration(reference_bindings::cases);
#[apply(gpu_test!)]
static CUDA_REFERENCE_CATEGORIES: GpuTestConfiguration = configuration(reference_categories::cases);
#[apply(gpu_test!)]
static CUDA_RESTRICT: GpuTestConfiguration = configuration(restrict::cases);
#[apply(gpu_test!)]
static CUDA_SATURATE: GpuTestConfiguration = configuration(saturate::cases);
#[apply(gpu_test!)]
static CUDA_SCALAR_BRACES: GpuTestConfiguration = configuration(scalar_braces::cases);
#[apply(gpu_test!)]
static CUDA_SCALAR_PROMOTION: GpuTestConfiguration = configuration(scalar_promotion::cases);
#[apply(gpu_test!)]
static CUDA_SHARED_VECTORS: GpuTestConfiguration = configuration(shared_vectors::cases);
#[apply(gpu_test!)]
static CUDA_SIGNED: GpuTestConfiguration = configuration(signed::cases);
#[apply(gpu_test!)]
static CUDA_SPECIFIERS: GpuTestConfiguration = configuration(specifiers::cases);
#[apply(gpu_test!)]
static CUDA_SQRT: GpuTestConfiguration = configuration(sqrt::cases);
#[apply(gpu_test!)]
static CUDA_SQRTF: GpuTestConfiguration = configuration(sqrtf::cases);
#[apply(gpu_test!)]
static CUDA_STRUCTURES: GpuTestConfiguration = configuration(structures::cases);
#[apply(gpu_test!)]
static CUDA_SWITCHES: GpuTestConfiguration = configuration(switches::cases);
#[apply(gpu_test!)]
static CUDA_THREAD_BLOCK: GpuTestConfiguration = configuration(thread_block::cases);
#[apply(gpu_test!)]
static CUDA_THREAD_BLOCK_DIMENSIONS: GpuTestConfiguration =
    configuration(thread_block_dimensions::cases);
#[apply(gpu_test!)]
static CUDA_THREAD_BLOCK_PARAMETERS: GpuTestConfiguration =
    configuration(thread_block_parameters::cases);
#[apply(gpu_test!)]
static CUDA_TOKEN_PASTING: GpuTestConfiguration = configuration(token_pasting::cases);
#[apply(gpu_test!)]
static CUDA_TRIGONOMETRY: GpuTestConfiguration = configuration(trigonometry::cases);
#[apply(gpu_test!)]
static CUDA_TYPE_ALIASES: GpuTestConfiguration = configuration(type_aliases::cases);
#[apply(gpu_test!)]
static CUDA_TYPE_TEMPLATES: GpuTestConfiguration = configuration(type_templates::cases);
#[apply(gpu_test!)]
static CUDA_TYPEDEF_STRUCTURES: GpuTestConfiguration = configuration(typedef_structures::cases);
#[apply(gpu_test!)]
static CUDA_UNINITIALIZED: GpuTestConfiguration = configuration(uninitialized::cases);
#[apply(gpu_test!)]
static CUDA_UNINITIALIZED_POINTERS: GpuTestConfiguration =
    configuration(uninitialized_pointers::cases);
#[apply(gpu_test!)]
static CUDA_UNIFORM_BRANCH_BARRIERS: GpuTestConfiguration =
    configuration(uniform_branch_barriers::cases);
#[apply(gpu_test!)]
static CUDA_UNIFORM_LOOP_BARRIERS: GpuTestConfiguration =
    configuration(uniform_loop_barriers::cases);
#[apply(gpu_test!)]
static CUDA_UPDATES: GpuTestConfiguration = configuration(updates::cases);

#[apply(gpu_test!)]
static CUDA_VECTOR_RESOURCES: GpuTestConfiguration = configuration(vector_resources::cases);

#[apply(gpu_test!)]
static CUDA_VECTOR_VALUES: GpuTestConfiguration = configuration(vector_values::cases);

#[apply(gpu_test!)]
static CUDA_INTEGER16: GpuTestConfiguration =
    configuration_with_features(integer16::cases, wgpu::Features::SHADER_I16);

#[apply(gpu_test!)]
static CUDA_INTEGER16_VECTORS: GpuTestConfiguration =
    configuration_with_features(integer16_vectors::cases, wgpu::Features::SHADER_I16);

#[apply(gpu_test!)]
static CUDA_INTEGER64: GpuTestConfiguration =
    configuration_with_features(integer64::cases, wgpu::Features::SHADER_INT64);

#[apply(gpu_test!)]
static CUDA_INTEGER64_STORAGE: GpuTestConfiguration =
    configuration_with_features(integer64::storage_cases, wgpu::Features::SHADER_INT64);

#[apply(gpu_test!)]
static CUDA_SINGLE_COMPONENT_VECTORS: GpuTestConfiguration =
    configuration(single_component_vectors::cases);

#[apply(gpu_test!)]
static CUDA_SINGLE_COMPONENT_INTEGER16_VECTORS: GpuTestConfiguration = configuration_with_features(
    single_component_vectors::integer16_cases,
    wgpu::Features::SHADER_I16,
);

#[apply(gpu_test!)]
static CUDA_PARENTHESIZED_AGGREGATES: GpuTestConfiguration =
    configuration(parenthesized_aggregates::cases);

#[apply(gpu_test!)]
static CUDA_PARENTHESIZED_INTEGER16_AGGREGATES: GpuTestConfiguration = configuration_with_features(
    parenthesized_aggregates::integer16_cases,
    wgpu::Features::SHADER_I16,
);

#[apply(gpu_test!)]
static CUDA_PARENTHESIZED_ARRAYS: GpuTestConfiguration = configuration(parenthesized_arrays::cases);

#[apply(gpu_test!)]
static CUDA_PARENTHESIZED_INTEGER16_ARRAYS: GpuTestConfiguration = configuration_with_features(
    parenthesized_arrays::integer16_cases,
    wgpu::Features::SHADER_I16,
);
