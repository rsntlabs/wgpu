use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 56];
    for lane in 0..4u32 {
        expected[4 + lane as usize * 12..16 + lane as usize * 12].copy_from_slice(&[
            7 + lane,
            11 + lane,
            (1.5f32 + lane as f32).to_bits(),
            8 + lane,
            4,
            9 + lane,
            4.0f32.to_bits(),
            7,
            7,
            1.5f32.to_bits(),
            (3.0f32 + 3.0 * lane as f32).to_bits(),
            (1.5f32 + 3.0 * lane as f32).to_bits(),
        ]);
    }
    vec![module_case(
        "named one and three component launch vectors retain nominal layouts and invocation-private values",
        include_str!("../../../../../naga/tests/in/cuda/kernel-named-vector-values.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;56]),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Uniform, &[-3i32,777,888,999]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[11u32,777,888,999]),
        ShaderBuffer::new(3, wgpu::BufferBindingType::Uniform, &[1.5f32,777.0,888.0,999.0]),
        ShaderBuffer::new(4, wgpu::BufferBindingType::Uniform, &[-5i32,9,-2,999]),
        ShaderBuffer::new(5, wgpu::BufferBindingType::Uniform, &[2u32,3,5,999]),
        ShaderBuffer::new(6, wgpu::BufferBindingType::Uniform, &[0.5f32,1.5,2.0,999.0]),
        ShaderBuffer::new(7, wgpu::BufferBindingType::Storage { read_only: true }, &[1.0f32,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0]),
    ], 0, [2, 1, 1])]
}
