use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn truncate_defined(bits: u32) -> u32 {
    let exponent = (bits >> 23) & 255;
    assert_ne!(exponent, 255);
    if exponent < 127 {
        return 0;
    }
    assert_eq!(
        bits >> 31,
        0,
        "negative input must be strictly greater than -1"
    );
    let power = exponent - 127;
    assert!(power < 32, "input must be strictly less than 2^32");
    let significand = 0x0080_0000 | (bits & 0x007f_ffff);
    if power >= 23 {
        significand << (power - 23)
    } else {
        significand >> (23 - power)
    }
}

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
        0x3f00_0000,
        0xbf00_0000,
        0x3f40_0000,
        0xbf40_0000,
        0xbf7f_ffff,
        0x3f7f_ffff,
        0x3f80_0000,
        0x3f80_0001,
        0x3fc0_0000,
        0x3fff_ffff,
        0x4020_0000,
        0x4aff_ffff,
        0x4b00_0000,
        0x4b7f_ffff,
        0x4b80_0000,
        0x4b80_0001,
        0x4eff_ffff,
        0x4f00_0000,
        0x4f00_0001,
        0x4f40_0000,
        0x4f7f_fffe,
        0x4f7f_ffff,
    ];
    let mut expected = [SENTINEL; 328];
    for (index, bits) in INPUT.into_iter().enumerate() {
        let converted = truncate_defined(bits);
        expected[4 + index * 10..14 + index * 10].copy_from_slice(&[
            converted,
            converted,
            converted,
            1,
            converted,
            2,
            16_777_216,
            2_147_483_648,
            1,
            10,
        ]);
    }
    vec![module_case(
        "float2uint_rz truncates negative fractions to zero and supports the full defined unsigned range after float32 conversion",
        include_str!("../../../../../naga/tests/in/cuda/float2uint-rz.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;328]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[32u32,777,888,999]),
    ], 1, [9,1,1])]
}
