use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 16];
    for lane in 0..4 {
        expected[4 + lane * 2..6 + lane * 2]
            .copy_from_slice(&[(((lane + 1) & 3) + 1) as u32, 0x3ff]);
    }
    vec![module_case(
        "uniform cached scalar math controls all ten shared-memory barriers",
        include_str!("../../../../../naga/tests/in/cuda/uniform-math-barriers.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Uniform,
                &[1.25f32.to_bits(), SENTINEL, SENTINEL, SENTINEL],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 16],
            ),
        ],
        1,
        [1, 1, 1],
    )]
}
