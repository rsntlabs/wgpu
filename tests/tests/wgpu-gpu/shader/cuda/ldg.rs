use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [u32; 4] = [0, 0x8000_0000, 0x7f80_0001, u32::MAX];
    let mut expected = [SENTINEL; 32];
    for (lane, value) in INPUT.into_iter().enumerate() {
        expected[4 + lane * 6..10 + lane * 6].copy_from_slice(&[
            value,
            value,
            value,
            lane as u32 + 1,
            INPUT[3 - lane],
            value,
        ]);
    }
    vec![module_case(
        "ldg reads unsigned global storage through helpers and aliases with one index evaluation",
        include_str!("../../../../../naga/tests/in/cuda/ldg.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &INPUT,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 32],
            ),
        ],
        1,
        [1, 1, 1],
    )]
}
