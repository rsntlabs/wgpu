use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 104];
    for lane in 0..4 {
        let value = lane as u32 + 1;
        expected[4 + lane * 24..28 + lane * 24].copy_from_slice(&[
            7,
            7,
            7,
            9,
            1,
            2,
            2,
            1,
            11,
            21,
            21,
            4,
            3,
            3,
            9,
            111,
            1,
            11,
            value,
            value + 2,
            value + 7,
            2,
            value + 7,
            value + 14,
        ]);
    }
    vec![module_case(
        "nondependent type template defaults freeze bindings complete after deduction and preserve effects",
        include_str!("../../../../../naga/tests/in/cuda/default-template-arguments.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 104]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
