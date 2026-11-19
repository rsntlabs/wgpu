use super::int2float_rz::{signed_inputs, toward_zero_bits};
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = signed_inputs();
    assert_eq!((16_777_217i32 as f32).to_bits(), 0x4b80_0000);
    assert_eq!((16_777_219i32 as f32).to_bits(), 0x4b80_0002);
    assert_eq!((-16_777_217i32 as f32).to_bits(), 0xcb80_0000);
    assert_eq!((-16_777_219i32 as f32).to_bits(), 0xcb80_0002);
    assert_eq!((i32::MAX as f32).to_bits(), 0x4f00_0000);
    let mut expected = vec![SENTINEL; input.len() * 9 + 8];
    for (index, &value) in input.iter().enumerate() {
        let bits = (value as f32).to_bits();
        let toward_zero = toward_zero_bits(value);
        expected[4 + index * 9..13 + index * 9].copy_from_slice(&[
            bits,
            bits,
            bits,
            1,
            bits,
            2,
            0xbf80_0000,
            0xc040_0000,
            toward_zero,
        ]);
    }
    let count = input.len() as u32;
    vec![module_case(
        "int2float_rn rounds signed words to nearest even with independent toward-zero witnesses and once-only effects",
        include_str!("../../../../../naga/tests/in/cuda/int2float-rn.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL;expected.len()]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count,777,888,999]),
    ], 1, [count.div_ceil(4)+1,1,1])]
}
