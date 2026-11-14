use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 108];
    for lane in 0..4 {
        let first = lane as u32 + 1;
        expected[4 + lane * 25..29 + lane * 25].copy_from_slice(&[
            7 * first + 21,
            first + 7,
            1,
            2,
            2,
            7,
            3,
            2,
            4,
            6,
            8,
            15,
            9,
            111,
            132,
            154,
            7,
            9,
            4,
            3,
            5,
            1,
            5,
            6,
            23,
        ]);
    }
    vec![module_case(
        "decltype object types preserve qualifiers constructors layouts scope and single evaluation",
        include_str!("../../../../../naga/tests/in/cuda/decltype-objects.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 108]),
    ], 0, [1, 1, 1])]
}
