use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

fn host_subtract(first: u32, second: u32) -> u32 {
    let result = (f32::from_bits(first) - f32::from_bits(second)).to_bits();
    if result & 0x7fff_ffff > 0x7f80_0000 {
        0x7fc0_0000
    } else {
        result
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    // Exact subtraction(a, signflip(b)) equals exact addition(a,b), including
    // zero signs. Reuse the independently generated arbitrary-integer oracle.
    for line in include_str!("fadd-rn-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [first, original_second, result] = words[..] else {
            panic!("expected input,input,exact bigint oracle");
        };
        let second = original_second ^ 0x8000_0000;
        assert_eq!(result, host_subtract(first, second));
        input.extend_from_slice(&[first, second]);
        expected.extend_from_slice(&[
            result,
            result,
            result,
            2,
            0,
            0x8000_0000,
            0xbf80_0000,
            7,
            host_subtract(second, first),
            0,
        ]);
    }
    assert_eq!(input.len(), 8192);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "__fsub_rn exact bigint references preserve zero signs nonfusion order and sequenced wrappers",
        include_str!("../../../../../naga/tests/in/cuda/fsub-rn.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
