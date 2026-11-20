use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn exponent(bits: u32) -> i32 {
    let value = f32::from_bits(bits);
    if value == 0.0 || value.is_nan() {
        i32::MIN
    } else if value.is_infinite() {
        i32::MAX
    } else {
        let widened = f64::from(value);
        ((widened.to_bits() >> 52) & 0x7ff) as i32 - 1023
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = vec![
        0u32,
        0x8000_0000,
        0x7f80_0000,
        0xff80_0000,
        0x7fc0_1234,
        0xffc0_1234,
        0x7f80_0001,
        0xff80_0001,
        0x7f7f_ffff,
        0xff7f_ffff,
    ];
    for field in 1..255u32 {
        for sign in [0, 0x8000_0000] {
            input.push(sign | (field << 23));
            input.push(sign | (field << 23) | 0x7f_ffff);
        }
    }
    for bit in 0..23 {
        for sign in [0, 0x8000_0000] {
            input.push(sign | (1 << bit));
            if bit > 0 {
                input.push(sign | ((1 << bit) - 1));
            }
        }
    }
    assert_eq!(exponent(1), -149);
    assert_eq!(exponent(0x007f_ffff), -127);
    assert_eq!(exponent(0x0080_0000), -126);
    assert_eq!(exponent(0x7f7f_ffff), 127);
    let mut expected = vec![SENTINEL; input.len() * 4 + 8];
    for (index, &bits) in input.iter().enumerate() {
        let result = exponent(bits) as u32;
        expected[4 + index * 4..8 + index * 4].copy_from_slice(&[result, result, 1, 2]);
    }
    let count = input.len() as u32;
    let initial = vec![SENTINEL; expected.len()];
    let test = module_case(
        "ilogbf returns exact signed exponents and evaluates its argument once",
        include_str!("../../../../../naga/tests/in/cuda/ilogbf.cu"),
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
