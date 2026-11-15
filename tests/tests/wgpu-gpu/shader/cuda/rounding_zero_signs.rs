use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const INPUT: [u32; 12] = [
    0,
    0x8000_0000,
    1,
    0x8000_0001,
    0x007f_ffff,
    0x807f_ffff,
    0x0080_0000,
    0x8080_0000,
    0x3e80_0000,
    0xbe80_0000,
    0x3f40_0000,
    0xbf40_0000,
];

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 176];
    for (index, bits) in INPUT.into_iter().enumerate() {
        let (floor, ceil) = if bits & 0x7fff_ffff == 0 {
            (bits, bits)
        } else if bits & 0x8000_0000 != 0 {
            (0xbf80_0000, 0x8000_0000)
        } else {
            (0, 0x3f80_0000)
        };
        expected[4 + index * 14..18 + index * 14].copy_from_slice(&[
            floor,
            ceil,
            floor,
            ceil,
            0,
            0x8000_0000,
            0,
            0x8000_0000,
            0,
            0x8000_0000,
            floor,
            0x3f80_0000,
            1,
            2,
        ]);
    }
    vec![module_case(
        "floorf and ceilf preserve zero signs for subnormal normal fractional literal and wrapper paths",
        include_str!("../../../../../naga/tests/in/cuda/rounding-zero-signs.cu"),
        [12, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 176]),
    ], 1, [1, 1, 1])]
}
