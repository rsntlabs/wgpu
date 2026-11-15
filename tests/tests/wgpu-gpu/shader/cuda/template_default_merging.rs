use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 72];
    for lane in 0..4 {
        let state = lane as u32 + 1;
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&[
            5,
            5,
            5,
            5,
            9,
            2,
            4,
            26,
            8,
            5,
            state,
            state + 3,
            state + 10,
            state + 10,
            state + 19,
            1,
        ]);
    }
    vec![module_case(
        "template defaults merge per slot freeze each declaration and preserve normalized calls and effects",
        include_str!("../../../../../naga/tests/in/cuda/template-default-merging.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 72]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
