use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4 {
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            0,
            4,
            8,
            8,
            16,
            32,
            48,
            4,
            16,
            4,
            7,
            lane as u32,
        ]);
    }
    vec![module_case(
        "builtin offsetof uses source scalar vector array and local record layout through qualified aliases",
        include_str!("../../../../../naga/tests/in/cuda/builtin-offsetof.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;56]),
    ],0,[1,1,1])]
}
