use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 84];
    for lane in 0..4 {
        expected[4 + lane * 19..23 + lane * 19].copy_from_slice(&[
            4,
            9,
            lane as u32 + 3,
            7,
            4,
            804,
            804,
            1284,
            84,
            8,
            8,
            8,
            8,
            4,
            804,
            8,
            12,
            20,
            20,
        ]);
    }
    vec![module_case(
        "template default sizeof queries use parameter types without evaluating or capturing their values",
        include_str!("../../../../../naga/tests/in/cuda/template-default-type-queries.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 84]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
