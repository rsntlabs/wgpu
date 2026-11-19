use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn toward_zero_bits(value: u32) -> u32 {
    let exact = f64::from(value);
    let nearest = exact as f32;
    nearest.to_bits() - u32::from(f64::from(nearest) > exact)
}

pub(super) fn unsigned_inputs() -> Vec<u32> {
    let mut input = vec![
        0u32,
        1,
        2,
        3,
        u32::MAX,
        16_777_217,
        16_777_219,
        2_147_483_649,
    ];
    for power in 0..=31 {
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
            if let Ok(value) = u32::try_from(center + offset) {
                input.push(value);
            }
        }
    }
    for offset in 0..=256 {
        input.push(u32::MAX - offset);
    }
    input.sort();
    input.dedup();
    let mut state = 0x6bad_f00du32;
    while input.len() < 4096 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        input.push(state);
    }
    input
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = unsigned_inputs();
    assert_eq!(toward_zero_bits(u32::MAX), 0x4f7f_ffff);
    assert_eq!(toward_zero_bits(2_147_483_648), 0x4f00_0000);
    assert_eq!(toward_zero_bits(2_147_483_649), 0x4f00_0000);
    assert_eq!(toward_zero_bits(16_777_219), 0x4b80_0001);
    let mut expected = vec![SENTINEL; input.len() * 8 + 8];
    for (index, &value) in input.iter().enumerate() {
        let bits = toward_zero_bits(value);
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            bits,
            bits,
            bits,
            1,
            bits,
            2,
            0x4f7f_ffff,
            0x4040_0000,
        ]);
    }
    let count = input.len() as u32;
    vec![module_case(
        "uint2float_rz encodes the full unsigned range toward zero after fixed argument conversion with once-only effects",
        include_str!("../../../../../naga/tests/in/cuda/uint2float-rz.cu"),
        [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &vec![SENTINEL;expected.len()]),
        ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count,777,888,999]),
    ], 1, [count.div_ceil(4)+1,1,1])]
}
