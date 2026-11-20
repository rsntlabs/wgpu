use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const OUTPUT_WORDS: usize = 48;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; OUTPUT_WORDS];
    for lane in 0..4 {
        expected[4 + lane * 10..14 + lane * 10].copy_from_slice(&[
            56,
            52,
            28,
            8,
            48,
            56,
            16,
            32,
            7,
            lane as u32,
        ]);
    }
    vec![module_case(
        "offsetof named integral indices use global local and template constants without runtime reads",
        include_str!("../../../../../naga/tests/in/cuda/offsetof-named-indices.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL; OUTPUT_WORDS]),
    ],0,[1,1,1])]
}
