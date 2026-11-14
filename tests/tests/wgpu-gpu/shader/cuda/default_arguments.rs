use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 88];
    for lane in 0..4 {
        let lane_word = lane as u32;
        let final_value = lane_word + 8 + if lane & 1 == 0 { 2 } else { 3 } + 2;
        expected[4 + lane * 20..24 + lane * 20].copy_from_slice(&[
            lane_word + 4,
            lane_word + 10,
            21,
            41,
            45,
            6,
            u32::MAX,
            102,
            203,
            304,
            lane_word + 1,
            lane_word + 3,
            11,
            7,
            11,
            final_value,
            1,
            3,
            403,
            501,
        ]);
    }
    vec![module_case(
        "constant default arguments preserve declaration binding conversions overloads and supplied side effects",
        include_str!("../../../../../naga/tests/in/cuda/default-arguments.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 88]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[7i32, 11, 13]),
    ], 0, [1, 1, 1])]
}
