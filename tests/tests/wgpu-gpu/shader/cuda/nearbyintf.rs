use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = [
        0,
        0x8000_0000,
        1,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x3eff_ffff,
        0xbeff_ffff,
        0x3f00_0000,
        0xbf00_0000,
        0x3f00_0001,
        0xbf00_0001,
        0x3fc0_0000,
        0xbfc0_0000,
        0x4020_0000,
        0xc020_0000,
        0x4060_0000,
        0xc060_0000,
        0x4a80_0001,
        0xca80_0001,
        0x4b00_0000,
        0xcb00_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
        0xff80_0001,
        0x7fc1_2345,
        0xffc1_2345,
    ];
    let mut expected = vec![SENTINEL; 4];
    for bits in input.iter().copied() {
        let value = f32::from_bits(bits);
        let result = if value.is_nan() {
            0x7fc0_0000
        } else {
            value.round_ties_even().to_bits()
        };
        expected.extend_from_slice(&[
            result,
            result,
            result,
            result,
            1,
            0x8000_0000,
            0x4000_0000,
            0x4040_0000,
            0x4040_0000,
            7,
            result,
            1,
        ]);
    }
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "nearbyintf matches CPU nearest-even bits and rintf across ties classes and once effects",
        include_str!("../../../../../naga/tests/in/cuda/nearbyintf.cu"),
        [32, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
        ],
        1,
        [2, 1, 1],
    )]
}
