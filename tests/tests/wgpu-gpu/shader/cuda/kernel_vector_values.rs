use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4u32 {
        expected[4 + lane as usize * 12..16 + lane as usize * 12].copy_from_slice(&[
            7 + lane,
            7 - lane,
            26 + lane,
            (1.5f32 + lane as f32).to_bits(),
            (-4.0f32).to_bits(),
            8 + lane,
            4,
            11 + lane,
            8.0f32.to_bits(),
            7,
            1.5f32.to_bits(),
            9,
        ]);
    }
    vec![module_case(
        "six native kernel vector value families use private mutable copies and sixteen-byte launch uniforms",
        include_str!("../../../../../naga/tests/in/cuda/kernel-vector-values.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;56]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Uniform, &[-3i32,7,777,888]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[11u32,13,777,888]),
        ShaderBuffer::new(3, wgpu::BufferBindingType::Uniform, &[1.5f32,-2.0,777.0,888.0]),
        ShaderBuffer::new(4, wgpu::BufferBindingType::Uniform, &[-5i32,9,-2,8]),
        ShaderBuffer::new(5, wgpu::BufferBindingType::Uniform, &[2u32,3,5,7]),
        ShaderBuffer::new(6, wgpu::BufferBindingType::Uniform, &[0.5f32,1.5,2.0,4.0]),
    ], 0, [2, 1, 1])]
}
