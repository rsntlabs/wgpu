use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 88];
    for lane in 0..4 {
        let state = lane as u32 + 1;
        expected[4 + lane * 20..24 + lane * 20].copy_from_slice(&[
            7,
            7,
            7,
            1,
            2,
            4,
            3,
            8,
            3,
            7,
            9,
            3,
            1,
            9,
            9,
            state,
            state + 2,
            state + 12,
            1,
            2,
        ]);
    }
    vec![module_case(
        "dependent type defaults preserve completed type identity cv shape and supplied argument effects",
        include_str!("../../../../../naga/tests/in/cuda/dependent-type-defaults.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 88]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
