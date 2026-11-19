use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4u32 {
        expected[4 + lane as usize * 12..16 + lane as usize * 12].copy_from_slice(&[
            25,
            25 + lane,
            21,
            23,
            (0.5f32 + lane as f32).to_bits(),
            0.5f32.to_bits(),
            53 + lane,
            47,
            1.5f32.to_bits(),
            11,
            59,
            15 + 25 * lane,
        ]);
    }
    vec![module_case(
        "five through eight word launch records preserve second-register fields source stride and old sixteen-byte values",
        include_str!("../../../../../naga/tests/in/cuda/kernel-record32-values.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;56]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Uniform, &[(-3i32) as u32,11,1.5f32.to_bits(),17,(-5i32) as u32,0xaabb_ccdd,0x1122_3344,0x5566_7788]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[(-7i32) as u32,13,2.0f32.to_bits(),19,(-9i32) as u32,23,0x1122_3344,0x5566_7788]),
        ShaderBuffer::new(3, wgpu::BufferBindingType::Uniform, &[(-11i32) as u32,29,(-2.0f32).to_bits(),31,(-13i32) as u32,37,0.5f32.to_bits(),0x5566_7788]),
        ShaderBuffer::new(4, wgpu::BufferBindingType::Uniform, &[(-17i32) as u32,41,3.0f32.to_bits(),43,(-19i32) as u32,47,1.5f32.to_bits(),53]),
        ShaderBuffer::new(5, wgpu::BufferBindingType::Uniform, &[59u32,0xaabb_ccdd,0x1122_3344,0x5566_7788]),
        ShaderBuffer::new(6, wgpu::BufferBindingType::Storage { read_only: true }, &[1u32,2,3.0f32.to_bits(),4,5,6,7,8.0f32.to_bits(),9,10,11,12,13.0f32.to_bits(),14,15,16,17,18.0f32.to_bits(),19,20]),
    ], 0, [2,1,1])]
}
