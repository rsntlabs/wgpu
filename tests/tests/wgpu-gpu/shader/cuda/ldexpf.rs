use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn scaled(bits: u32, power: i32) -> u32 {
    let value = f32::from_bits(bits);
    if value.is_nan() {
        0x7fc0_0000
    } else if value == 0.0 || value.is_infinite() {
        bits
    } else {
        ((f64::from(value) * 2f64.powi(power.clamp(-512, 512))) as f32).to_bits()
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    for (bits, power) in [
        (0, i32::MAX),
        (0x8000_0000, i32::MIN),
        (0x7f80_0000, i32::MIN),
        (0xff80_0000, i32::MAX),
        (0x7fc0_1234, 3),
        (0xff80_0001, -3),
        (1, 149),
        (0x007f_ffff, 1),
        (0x0080_0000, -1),
        (0x0080_0001, -1),
        (0x0080_0003, -1),
        (0x00ff_ffff, -1),
        (0x3f80_0000, -149),
        (0x3f80_0000, -150),
        (0x3f80_0001, -150),
        (0x7f7f_ffff, 1),
        (0x3f80_0000, i32::MAX),
        (0x3f80_0000, i32::MIN),
        (0x3fc0_0000, 10),
        (0x4b80_0001, -20),
    ] {
        input.push([bits, power as u32]);
        input.push([bits ^ 0x8000_0000, power as u32]);
    }
    assert_eq!(scaled(0x00ff_ffff, -1), 0x0080_0000);
    assert_eq!(scaled(0x3f80_0000, -150), 0);
    assert_eq!(scaled(0xbf80_0000, -150), 0x8000_0000);
    let mut expected = vec![SENTINEL; input.len() * 8 + 8];
    for (index, &[bits, power]) in input.iter().enumerate() {
        let result = scaled(bits, power as i32);
        expected[4 + index * 8..12 + index * 8]
            .copy_from_slice(&[result, result, 2, 1, result, result, 4, 1]);
    }
    let initial = vec![SENTINEL; expected.len()];
    let count = input.len() as u32;
    let test = module_case(
        "ldexpf scales by powers of two and evaluates both arguments once",
        include_str!("../../../../../naga/tests/in/cuda/ldexpf.cu"),
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
