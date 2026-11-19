use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn expected_bits(value: i32) -> u32 {
    let exact = f64::from(value);
    let nearest = exact as f32;
    nearest.to_bits() - u32::from(f64::from(nearest).abs() > exact.abs())
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = vec![
        0,
        1,
        -1,
        2,
        -2,
        i32::MIN,
        i32::MAX,
        16_777_217,
        -16_777_217,
        16_777_219,
        -16_777_219,
    ];
    for power in 0..=30 {
        let center = 1i64 << power;
        let half = if power >= 24 { 1i64 << (power - 24) } else { 1 };
        for offset in [
            -3,
            -2,
            -1,
            0,
            1,
            2,
            3,
            half - 1,
            half,
            half + 1,
            2 * half,
            3 * half - 1,
            3 * half,
            3 * half + 1,
        ] {
            let value = center + offset;
            for signed in [value, -value] {
                if let Ok(value) = i32::try_from(signed) {
                    input.push(value);
                }
            }
        }
    }
    for offset in 0..=256 {
        input.push(i32::MIN + offset);
        input.push(i32::MAX - offset);
    }
    input.sort();
    input.dedup();
    let mut state = 0x8bad_f00du32;
    while input.len() < 4096 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        input.push(state as i32);
    }
    assert_eq!(expected_bits(i32::MAX), 0x4eff_ffff);
    assert_eq!(expected_bits(i32::MIN), 0xcf00_0000);
    assert_eq!(expected_bits(i32::MIN + 1), 0xceff_ffff);
    assert_eq!(expected_bits(16_777_219), 0x4b80_0001);
    let mut expected = vec![SENTINEL; input.len() * 8 + 8];
    for (index, &value) in input.iter().enumerate() {
        let bits = expected_bits(value);
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            bits,
            bits,
            bits,
            1,
            bits,
            2,
            0xbf80_0000,
            0xc040_0000,
        ]);
    }
    let count = input.len() as u32;
    vec![module_case(
        "int2float_rz encodes every signed word toward zero with fixed argument narrowing and once-only effects",
        include_str!("../../../../../naga/tests/in/cuda/int2float-rz.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL;expected.len()]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count,777,888,999]),
    ], 1, [count.div_ceil(4)+1,1,1])]
}
