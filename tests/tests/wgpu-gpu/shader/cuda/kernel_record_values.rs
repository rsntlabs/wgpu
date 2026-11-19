use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    [false, true].into_iter().map(|zero| {
        let one = if zero { [0u32,777,888,999] } else { [(-3i32) as u32,777,888,999] };
        let two = if zero { [0u32,0,888,999] } else { [11,1.5f32.to_bits(),888,999] };
        let three = if zero { [0u32,0,0,999] } else { [(-5i32) as u32,7,2.0f32.to_bits(),999] };
        let four = if zero { [0u32;4] } else { [(-7i32) as u32,13,(-2.0f32).to_bits(),17] };
        let mut expected = [SENTINEL;56];
        for lane in 0..4u32 {
            expected[4 + lane as usize * 12..16 + lane as usize * 12].copy_from_slice(&[
                (one[0] as i32 + lane as i32 + 10) as u32,
                two[0], two[1], (three[0] as i32 - lane as i32 + 20) as u32,
                three[1] + lane, three[2], (four[0] as i32 + lane as i32 + 20) as u32,
                four[1] + 1, (f32::from_bits(four[2]) * 2.0).to_bits(), four[3], three[1], 39 + 9 * lane,
            ]);
        }
        module_case(if zero { "flat record launch zeros remain data with poisoned padding" } else { "flat record launch fields preserve source layout nominal identity and private copies" },
            include_str!("../../../../../naga/tests/in/cuda/kernel-record-values.cu"),
            [4, 1, 1], &expected,
        ).module_buffers(vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;56]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Uniform, &one),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &two),
            ShaderBuffer::new(3, wgpu::BufferBindingType::Uniform, &three),
            ShaderBuffer::new(4, wgpu::BufferBindingType::Uniform, &four),
            ShaderBuffer::new(5, wgpu::BufferBindingType::Storage { read_only: true }, &[1u32,2,3.0f32.to_bits(),4,5,6.0f32.to_bits(),7,8,9.0f32.to_bits(),10,11,12.0f32.to_bits()]),
        ], 0, [2,1,1])
    }).collect()
}
