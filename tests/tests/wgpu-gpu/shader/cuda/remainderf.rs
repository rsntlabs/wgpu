use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let triples = [
        (0x4040_0000u32, 0x4000_0000u32, 0xbf80_0000u32),
        (0x40a0_0000, 0x4000_0000, 0x3f80_0000),
        (0x40e0_0000, 0x4000_0000, 0xbf80_0000),
        (0x3f40_0000, 0x4000_0000, 0x3f40_0000),
        (0x3fa0_0000, 0x4000_0000, 0xbf40_0000),
        (0x3f80_0000, 0x4000_0000, 0x3f80_0000),
        (0x7180_0000, 0x4040_0000, 0x3f80_0000),
        (0x7200_0000, 0x4040_0000, 0xbf80_0000),
        (0x7f7f_ffff, 0x3f80_0000, 0),
        (0x3f80_0000, 1, 0),
        (1, 2, 1),
        (3, 2, 0x8000_0001),
        (0x007f_ffff, 0x0080_0000, 0x8000_0001),
        (0x0080_0000, 0x007f_ffff, 1),
        (0x3fa0_0000, 0x7f80_0000, 0x3fa0_0000),
        (0, 0x4000_0000, 0),
        (0x7f80_0000, 0x3f80_0000, 0x7fc0_0000),
        (0x3f80_0000, 0, 0x7fc0_0000),
        (0x7fc0_1234, 0x4000_0000, 0x7fc0_0000),
        (0x3f80_0000, 0x7f80_0001, 0x7fc0_0000),
    ];
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; triples.len() * 4 * 4 + 8];
    for (x, y, result) in triples {
        for sign_x in [0, 0x8000_0000] {
            for sign_y in [0, 0x8000_0000] {
                let index = input.len();
                input.push([x ^ sign_x, y ^ sign_y]);
                let bits = if result == 0x7fc0_0000 {
                    result
                } else {
                    result ^ sign_x
                };
                expected[4 + index * 4..8 + index * 4].copy_from_slice(&[bits, bits, 2, 1]);
            }
        }
    }
    let initial = vec![SENTINEL; expected.len()];
    let count = input.len() as u32;
    let test = module_case(
        "remainderf selects a ties-to-even quotient and evaluates both arguments once",
        include_str!("../../../../../naga/tests/in/cuda/remainderf.cu"),
        [4, 1, 1],
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
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count, 777, 888, 999]),
        ],
        1,
        [count.div_ceil(4) + 1, 1, 1],
    );
    vec![test]
}
