use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 4] = [0, 1, -7, 100];
    let mut expected = [SENTINEL; 56];
    for (lane, seed) in INPUT.into_iter().enumerate() {
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            12,
            7,
            seed as u32,
        ]);
    }
    vec![module_case(
        "sizeof bool casts of pointers arrays and nullptr do not read or decay runtime objects",
        include_str!("../../../../../naga/tests/in/cuda/sizeof-bool-casts.cu"),
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
                &[SENTINEL; 56],
            ),
        ],
        1,
        [1, 1, 1],
    )]
}
