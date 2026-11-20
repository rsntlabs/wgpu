use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4 {
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            16,
            32,
            32,
            40,
            48,
            64,
            80,
            56,
            8,
            40,
            7,
            lane as u32,
        ]);
    }
    vec![module_case(
        "nested offsetof sums padded record offsets with macro and builtin paths through qualified aliases",
        include_str!("../../../../../naga/tests/in/cuda/offsetof-member-paths.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;56]),
    ],0,[1,1,1])]
}
