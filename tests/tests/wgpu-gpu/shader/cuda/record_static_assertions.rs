use super::{module_case_with_options_and_capabilities, Options, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 40];
    for lane in 0..4 {
        let value = lane as u32;
        expected[4 + lane * 8..12 + lane * 8].copy_from_slice(&[
            value + 3,
            value + 5,
            value + 9,
            value + 15,
            64,
            24,
            12,
            value + 21,
        ]);
    }
    vec![module_case_with_options_and_capabilities(
        "record-scope assertions preserve layouts, fields, and ordinary kernel execution",
        include_str!("../../../../../naga/tests/in/cuda/record-static-assertions.cu"),
        &Options {
            workgroup_size: [4, 1, 1],
            ..Default::default()
        },
        &expected,
        naga::valid::Capabilities::SHADER_INT64,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 40],
        )],
        0,
        [1, 1, 1],
    )]
}
