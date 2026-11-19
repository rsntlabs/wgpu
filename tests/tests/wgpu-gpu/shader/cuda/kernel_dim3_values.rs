use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    [
        ("dim3 launch zeros remain zero while local construction defaults to ones", [0u32, 0, 0, 0xabcd_1234], [0u32, 0, 0, 0x1234_abcd]),
        ("dim3 launch values preserve nominal identity and private mutations at unsigned boundaries", [u32::MAX, 0, 5, 0xabcd_1234], [0u32, 17, u32::MAX, 0x1234_abcd]),
    ].into_iter().map(|(name, shape, fixed)| {
        let mut expected = [SENTINEL; 64];
        for lane in 0..4u32 {
            expected[4 + lane as usize * 14..18 + lane as usize * 14].copy_from_slice(&[
                shape[0], shape[1], shape[2], shape[0].wrapping_add(lane), shape[1].wrapping_add(2), 1, 3,
                fixed[0], fixed[1], fixed[2], 33, shape[0] ^ shape[1] ^ shape[2], 4, 2,
            ]);
        }
        module_case(name,
            include_str!("../../../../../naga/tests/in/cuda/kernel-dim3-values.cu"),
            [4, 1, 1], &expected,
        ).module_buffers(vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;64]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Uniform, &shape),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &fixed),
        ], 0, [2, 1, 1])
    }).collect()
}
