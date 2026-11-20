use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = 0x5a5a_5a5a;

pub(super) const INPUT: [u32; 32] = [
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

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; INPUT.len() * 8 + 8];
    let mut expected = initial;
    for (index, bits) in INPUT.into_iter().enumerate() {
        let value = f32::from_bits(bits);
        assert!(
            value.is_finite()
                && f64::from(value) >= f64::from(i32::MIN)
                && f64::from(value) <= f64::from(i32::MAX)
        );
        let converted = f64::from(value).floor() as i32;
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            converted, converted, converted, 1, converted, 2, 16_777_216, 10,
        ]);
    }
    let count = INPUT.len() as u32;
    let test = module_case(
        "float2int_rd floors float inputs and evaluates arguments once",
        include_str!("../../../../../naga/tests/in/cuda/float2int-rd.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &INPUT,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count, 777, 888, 999]),
        ],
        1,
        [count.div_ceil(4) + 1, 1, 1],
    );
    vec![test]
}
