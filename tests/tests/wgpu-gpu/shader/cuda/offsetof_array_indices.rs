use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4 {
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            32,
            40,
            56,
            48,
            20,
            32,
            56,
            8,
            16,
            48,
            76,
            7 + lane as u32,
        ]);
    }
    vec![module_case(
        "offsetof literal array indices use declared row record and native vector strides",
        include_str!("../../../../../naga/tests/in/cuda/offsetof-array-indices.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 56],
        )],
        0,
        [1, 1, 1],
    )]
}
