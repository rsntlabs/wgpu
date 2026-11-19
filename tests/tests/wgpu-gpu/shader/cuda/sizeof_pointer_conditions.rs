use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 4] = [0, 1, -7, 100];
    let mut expected = [SENTINEL; 72];
    for (lane, seed) in INPUT.into_iter().enumerate() {
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&[
            4,
            4,
            4,
            1,
            4,
            4,
            1,
            4,
            4,
            12,
            4,
            4,
            1,
            4,
            7,
            seed as u32,
        ]);
    }
    vec![module_case(
        "sizeof pointer array and nullptr conditions never read their conditions or scalar arms",
        include_str!("../../../../../naga/tests/in/cuda/sizeof-pointer-conditions.cu"),
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
                &[SENTINEL; 72],
            ),
        ],
        1,
        [1, 1, 1],
    )]
}
