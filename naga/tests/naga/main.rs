#[cfg(feature = "cuda-in")]
mod cuda;
mod example_wgsl;
mod helpers;
mod snapshots;
mod spirv_capabilities;
mod spirv_debug_info;
mod spirv_roundtrip;
mod spirv_switch_fallthrough;
mod validation;
mod wgsl_errors;
mod wgsl_named_call_results;
mod wgsl_predeclared_result_types;
mod wgsl_switch_fallthrough;
