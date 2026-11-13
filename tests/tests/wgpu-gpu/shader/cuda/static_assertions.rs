use super::{module_case_with_options_and_capabilities, Options, ShaderBuffer, ShaderTest};

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![module_case_with_options_and_capabilities(
        "global, local, and template static assertions leave only the verified kernel computation",
        include_str!("../../../../../naga/tests/in/cuda/static-assertions.cu"),
        &Options {
            workgroup_size: [4, 1, 1],
            ..Default::default()
        },
        &[7u32, 8, 9, 10],
        naga::valid::Capabilities::SHADER_INT64,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[0u32; 4],
        )],
        0,
        [1, 1, 1],
    )]
}
