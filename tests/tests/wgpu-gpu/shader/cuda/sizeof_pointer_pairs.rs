use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 4] = [0, 1, -7, 100];
    let mut expected = [SENTINEL; 56];
    for (lane, seed) in INPUT.into_iter().enumerate() {
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            8,
            8,
            4,
            8,
            8,
            12,
            4,
            4,
            8,
            4,
            7,
            seed as u32,
        ]);
    }
    vec![module_case(
        "sizeof same-pointee pointer pairs preserve source pointer targets without reading either branch",
        include_str!("../../../../../naga/tests/in/cuda/sizeof-pointer-pairs.cu"),
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
