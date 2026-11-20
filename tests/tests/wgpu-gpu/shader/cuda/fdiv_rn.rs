use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    for line in include_str!("fdiv-rn-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [first, second, result] = words[..] else {
            panic!("expected input,input,exact bigint oracle");
        };
        let host = (f32::from_bits(first) / f32::from_bits(second)).to_bits();
        assert_eq!(
            result,
            if host & 0x7fff_ffff > 0x7f80_0000 {
                0x7fc0_0000
            } else {
                host
            }
        );
        let denominator = second & 0x7fff_ffff;
        let fast = if (0x7e80_0001..0x7f80_0000).contains(&denominator) {
            if first & 0x7fff_ffff >= 0x7f80_0000 {
                0x7fc0_0000
            } else {
                (first ^ second) & 0x8000_0000
            }
        } else {
            result
        };
        input.extend_from_slice(&[first, second]);
        expected.extend_from_slice(&[
            result,
            result,
            result,
            2,
            0x7fc0_0000,
            0x7fc0_0000,
            0x3f2a_aaab,
            7,
            host_result(second, first),
            0x3eaa_aaab,
            fast,
            fast,
            2,
            0x3f80_0001,
            0x3f80_0000,
            0,
        ]);
    }
    assert_eq!(input.len(), 8192);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "RN and fast divide exact bigint references preserve zero signs rounded operand order and sequenced wrappers",
        include_str!("../../../../../naga/tests/in/cuda/fdiv-rn.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}

fn host_result(first: u32, second: u32) -> u32 {
    let bits = (f32::from_bits(first) / f32::from_bits(second)).to_bits();
    if bits & 0x7fff_ffff > 0x7f80_0000 {
        0x7fc0_0000
    } else {
        bits
    }
}
