use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 104];
    for lane in 0..4 {
        let state = lane as u32 + 1;
        expected[4 + lane * 24..28 + lane * 24].copy_from_slice(&[
            4,
            5,
            7,
            7,
            7,
            5,
            10,
            5,
            8,
            5,
            3,
            2,
            4,
            11,
            21,
            21,
            state,
            state + 2,
            state + 7,
            1,
            0,
            1,
            10,
            1,
        ]);
    }
    vec![module_case(
        "integral template defaults freeze declarations deduce supplied arguments and preserve skipped work and effects",
        include_str!("../../../../../naga/tests/in/cuda/integral-template-defaults.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 104]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
