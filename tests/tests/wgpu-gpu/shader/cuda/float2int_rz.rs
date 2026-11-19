use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = 0x5a5a_5a5a;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [u32; 32] = [
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
        0x3f7f_ffff,
        0xbf7f_ffff,
        0x3f80_0000,
        0xbf80_0000,
        0x3f80_0001,
        0xbf80_0001,
        0x3fff_ffff,
        0xbfff_ffff,
        0x4020_0000,
        0xc020_0000,
        0x4b7f_ffff,
        0xcb7f_ffff,
        0x4b80_0000,
        0xcb80_0000,
        0x4b80_0001,
        0xcb80_0001,
        0x4eff_ffff,
        0xcf00_0000,
        0x4e80_0000,
        0xce80_0000,
        0x3f00_0000,
        0xbf00_0000,
    ];
    let mut expected = [SENTINEL; 264];
    for (index, bits) in INPUT.into_iter().enumerate() {
        let value = f32::from_bits(bits);
        assert!(
            value.is_finite()
                && f64::from(value) >= f64::from(i32::MIN)
                && f64::from(value) <= f64::from(i32::MAX)
        );
        let converted = value.trunc() as i32;
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            converted, converted, converted, 1, converted, 2, 16_777_216, 10,
        ]);
    }
    vec![module_case(
        "float2int_rz truncates only valid finite float inputs and rounds integral actuals through float32 once",
        include_str!("../../../../../naga/tests/in/cuda/float2int-rz.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;264]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[32u32,777,888,999]),
    ], 1, [9,1,1])]
}
