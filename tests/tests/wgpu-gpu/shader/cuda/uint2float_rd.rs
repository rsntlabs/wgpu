use super::uint2float_rz::{toward_zero_bits, unsigned_inputs};
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn upward_bits(value: u32) -> u32 {
    let nearest = value as f32;
    if f64::from(nearest) < f64::from(value) {
        nearest.next_up().to_bits()
    } else {
        nearest.to_bits()
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = unsigned_inputs();
    assert!(input.contains(&0xffff_ff00));
    assert!(input.contains(&0xffff_ff01));
    assert_eq!(toward_zero_bits(0), 0);
    assert_eq!(toward_zero_bits(16_777_217), 0x4b80_0000);
    assert_eq!(toward_zero_bits(16_777_219), 0x4b80_0001);
    assert_eq!(toward_zero_bits(0xffff_ff00), 0x4f7f_ffff);
    assert_eq!(toward_zero_bits(0xffff_ff01), 0x4f7f_ffff);
    assert_eq!((0xffff_ff01u32 as f32).to_bits(), 0x4f7f_ffff);
    assert_eq!(toward_zero_bits(u32::MAX), 0x4f7f_ffff);
    assert_eq!((u32::MAX as f32).to_bits(), 0x4f80_0000);
    assert_eq!(upward_bits(0xffff_ff01), 0x4f80_0000);
    let mut expected = vec![SENTINEL; input.len() * 10 + 8];
    for (index, &value) in input.iter().enumerate() {
        let bits = toward_zero_bits(value);
        expected[4 + index * 10..14 + index * 10].copy_from_slice(&[
            bits,
            bits,
            bits,
            1,
            bits,
            2,
            0x4f7f_ffff,
            0x4040_0000,
            upward_bits(value),
            (value as f32).to_bits(),
        ]);
    }
    let count = input.len() as u32;
    vec![module_case(
        "uint2float_rd rounds unsigned words toward negative infinity with RN and RU witnesses and once-only effects",
        include_str!("../../../../../naga/tests/in/cuda/uint2float-rd.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL;expected.len()]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count,777,888,999]),
    ], 1, [count.div_ceil(4)+1,1,1])]
}
