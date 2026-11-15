use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = vec![
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
        0x7fbf_ffff,
        0xffbf_ffff,
        0x7fc0_0000,
        0xffc0_0000,
        0x7fff_ffff,
        0xffff_ffff,
        0x7fc1_2345,
        0xffc1_2345,
        0x3f00_0000,
        0xbf00_0000,
        0x7f00_0000,
        0xff00_0000,
        0x0000_0100,
        0x8000_0100,
        0x7f80_0100,
        0xff80_0100,
    ];
    let mut state = 0x1234_5678u32;
    for _ in 0..512 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        input.push(state);
    }
    assert_eq!(input.len(), 544);
    let mut expected = vec![SENTINEL; 4 + input.len() * 23 + 4];
    for (index, bits) in input.iter().copied().enumerate() {
        let magnitude = bits & 0x7fff_ffff;
        let finite = u32::from(magnitude < 0x7f80_0000);
        let infinite = u32::from(magnitude == 0x7f80_0000);
        let nan = u32::from(magnitude > 0x7f80_0000);
        let sign = bits >> 31;
        let host = f32::from_bits(bits);
        assert_eq!(finite, u32::from(host.is_finite()));
        assert_eq!(infinite, u32::from(host.is_infinite()));
        assert_eq!(nan, u32::from(host.is_nan()));
        assert_eq!(sign, u32::from(host.is_sign_negative()));
        expected[4 + index * 23..27 + index * 23].copy_from_slice(&[
            finite,
            infinite,
            nan,
            sign,
            finite,
            infinite,
            nan,
            sign,
            10 + nan,
            sign,
            1,
            7,
            if finite != 0 {
                2
            } else if infinite != 0 {
                3
            } else {
                4
            },
            0,
            1,
            1,
            0,
            1,
            1,
            0,
            1,
            1,
            1,
        ]);
    }
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "F32 classification returns exact int predicates for raw classes payloads wrappers and sequenced calls",
        include_str!("../../../../../naga/tests/in/cuda/float-classification.cu"),
        [32, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &initial),
    ], 1, [18, 1, 1])]
}
