use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const WORDS: [u32; 20] = [
        0,
        0x8000_0000,
        1,
        0x8000_0001,
        0x007f_ffff,
        0x807f_ffff,
        0x0080_0000,
        0x8080_0000,
        0x3f80_0000,
        0xbf80_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f80_0000,
        0xff80_0000,
        0x7f80_0001,
        0xff80_0001,
        0x7fc0_0000,
        0xffc0_0000,
        0x7fc1_2345,
        0xffc1_2345,
    ];
    let mut pairs = Vec::new();
    for first in WORDS {
        for second in WORDS {
            pairs.push((first, second));
        }
    }
    let mut state = 0x1234_5678u32;
    for _ in 0..512 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        let first = state;
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        pairs.push((first, state));
    }
    assert_eq!(pairs.len(), 912);
    let input: Vec<_> = pairs
        .iter()
        .flat_map(|&(first, second)| [first, second])
        .collect();
    let mut expected = vec![SENTINEL; 4 + pairs.len() * 14 + 4];
    for (index, (first, second)) in pairs.into_iter().enumerate() {
        let result = (first & 0x7fff_ffff) | (second & 0x8000_0000);
        assert_eq!(
            result,
            f32::from_bits(first)
                .copysign(f32::from_bits(second))
                .to_bits()
        );
        expected[4 + index * 14..18 + index * 14].copy_from_slice(&[
            result,
            result,
            0x8000_0000,
            0,
            0x7f80_0001,
            0xffc1_2345,
            0x4040_0000,
            0xc0a0_0000,
            7,
            result,
            2,
            result,
            0xbf80_0000,
            2,
        ]);
    }
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "copysignf preserves payload and magnitude bits across classes wrappers conversions and sequenced arguments",
        include_str!("../../../../../naga/tests/in/cuda/copysignf.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &initial),
    ], 1, [30,1,1])]
}
