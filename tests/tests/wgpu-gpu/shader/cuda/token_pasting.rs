use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/token-pasting.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..24].copy_from_slice(&[
        7,
        11,
        13,
        17,
        23,
        42,
        0x3fc0_0000,
        0x4080_0000,
        1,
        8,
        14,
        63,
        29,
        8,
        19,
        21,
        9,
        23,
        15,
        5,
        7,
        2,
        9,
        4,
    ]);
    vec![module_case(
        "token pasting preserves raw arguments types numbers operators rescanning empties and call effects",
        FIXTURE,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    )]
}
