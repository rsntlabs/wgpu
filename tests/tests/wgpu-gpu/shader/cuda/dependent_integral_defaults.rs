use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 72];
    for lane in 0..4 {
        let state = lane as u32 + 1;
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&[
            6,
            6,
            6,
            7,
            8,
            0,
            1,
            7,
            65535,
            4,
            9,
            5,
            state,
            state + 5,
            10,
            1,
        ]);
    }
    vec![module_case(
        "dependent integral defaults complete chains convert omitted values and preserve merged names and effects",
        include_str!("../../../../../naga/tests/in/cuda/dependent-integral-defaults.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 72]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
