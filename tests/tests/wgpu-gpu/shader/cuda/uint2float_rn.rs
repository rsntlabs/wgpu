use super::uint2float_rz::{toward_zero_bits, unsigned_inputs};
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = unsigned_inputs();
    assert!(input.contains(&0xffff_ff7f));
    assert!(input.contains(&0xffff_ff80));
    assert_eq!((u32::MAX as f32).to_bits(), 0x4f80_0000);
    assert_eq!((0xffff_ff7fu32 as f32).to_bits(), 0x4f7f_ffff);
    assert_eq!((0xffff_ff80u32 as f32).to_bits(), 0x4f80_0000);
    assert_eq!((16_777_217u32 as f32).to_bits(), 0x4b80_0000);
    assert_eq!((16_777_219u32 as f32).to_bits(), 0x4b80_0002);
    let mut expected = vec![SENTINEL; input.len() * 9 + 8];
    for (index, &value) in input.iter().enumerate() {
        let bits = (value as f32).to_bits();
        expected[4 + index * 9..13 + index * 9].copy_from_slice(&[
            bits,
            bits,
            bits,
            1,
            bits,
            2,
            0x4f80_0000,
            0x4040_0000,
            toward_zero_bits(value),
        ]);
    }
    let count = input.len() as u32;
    vec![module_case(
        "uint2float_rn rounds the full unsigned range to nearest even with parity carry and prior toward-zero witnesses",
        include_str!("../../../../../naga/tests/in/cuda/uint2float-rn.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL;expected.len()]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count,777,888,999]),
    ], 1, [count.div_ceil(4)+1,1,1])]
}
