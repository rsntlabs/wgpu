use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 4] = [0, 1, -7, 100];
    let mut expected = [SENTINEL; 88];
    for (lane, seed) in INPUT.into_iter().enumerate() {
        expected[4 + lane * 20..24 + lane * 20].copy_from_slice(&[
            4,
            1,
            4,
            4,
            4,
            4,
            4,
            4,
            4,
            12,
            4,
            4,
            4,
            4,
            4,
            7,
            5,
            7,
            seed as u32,
            u32::from(seed != 0),
        ]);
    }
    vec![module_case(
        "conditional sizeof preserves same scalar and bool types without evaluating conditions arms or indices",
        include_str!("../../../../../naga/tests/in/cuda/sizeof-conditionals.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&INPUT),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;88]),
    ],1,[1,1,1])]
}
