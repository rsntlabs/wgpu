use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn divide_down(x: u32, y: u32) -> u32 {
    let exact = f64::from(f32::from_bits(x)) / f64::from(f32::from_bits(y));
    if exact.is_nan() {
        return 0x7fc0_0000;
    }
    let nearest = exact as f32;
    if f64::from(nearest) > exact {
        nearest.next_down().to_bits()
    } else {
        nearest.to_bits()
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    for pair in [
        [0x3f80_0000u32, 0x4040_0000u32],
        [0x40a0_0000, 0x4000_0000],
        [0x7f7f_ffff, 0x3f00_0000],
        [1, 0x4000_0000],
        [0x0080_0000, 0x4040_0000],
        [0x007f_ffff, 0x0080_0000],
        [0x3f80_0001, 0x3f80_0000],
        [0, 0x4000_0000],
        [0x3f80_0000, 0],
        [0x7f80_0000, 0x4000_0000],
        [0x3f80_0000, 0x7f7f_ffff],
        [0x3f80_0000, 1],
        [0x3f80_0000, 0x7f80_0000],
        [0x7f80_0000, 0x7f80_0000],
        [0, 0],
        [0x7fc0_1234, 0x3f80_0000],
        [0x3f80_0000, 0x7f80_0001],
    ] {
        for sx in [0, 0x8000_0000] {
            for sy in [0, 0x8000_0000] {
                input.push([pair[0] ^ sx, pair[1] ^ sy]);
            }
        }
    }
    assert_eq!(divide_down(0x7f7f_ffff, 0x3f00_0000), 0x7f7f_ffff);
    assert_eq!(divide_down(0xff7f_ffff, 0x3f00_0000), 0xff80_0000);
    assert_eq!(divide_down(1, 0x4000_0000), 0);
    assert_eq!(divide_down(0x8000_0001, 0x4000_0000), 0x8000_0001);
    let mut expected = vec![SENTINEL; input.len() * 8 + 8];
    for (index, &[x, y]) in input.iter().enumerate() {
        let quotient = divide_down(x, y);
        let reciprocal = divide_down(0x3f80_0000, y);
        expected[4 + index * 8..12 + index * 8]
            .copy_from_slice(&[quotient, quotient, 2, reciprocal, reciprocal, 3, 1, 1]);
    }
    let initial = vec![SENTINEL; expected.len()];
    let count = input.len() as u32;
    let test = module_case(
        "downward division and reciprocal share exact directed rounding with once-only arguments",
        include_str!("../../../../../naga/tests/in/cuda/fdiv-rd.cu"),
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
