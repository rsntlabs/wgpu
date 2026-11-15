use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 80];
    for lane in 0..4 {
        let initial = lane as u32 + 1;
        let selected = initial + 9 + if lane & 1 == 0 { 2 } else { 3 };
        let final_value = selected + 2;
        expected[4 + lane * 18..22 + lane * 18].copy_from_slice(&[
            initial,
            initial + 2,
            initial + 7,
            11,
            21,
            8 * initial + 61,
            initial + 9,
            selected,
            final_value,
            final_value + 1,
            final_value + 2,
            final_value + 3,
            7,
            9,
            13,
            14,
            7,
            15,
        ]);
    }
    vec![module_case(
        "noexcept declarations preserve default arguments reference updates overloads and captured builtin ordering",
        include_str!("../../../../../naga/tests/in/cuda/noexcept.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 80]),
    ], 0, [1, 1, 1])]
}
