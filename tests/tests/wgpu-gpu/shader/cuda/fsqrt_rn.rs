use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    for line in include_str!("fsqrt-rn-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [bits, result] = words[..] else {
            panic!("expected input,exact squared-midpoint oracle");
        };
        let host = (f32::from_bits(bits).sqrt()).to_bits();
        assert_eq!(
            result,
            if host & 0x7fff_ffff > 0x7f80_0000 {
                0x7fc0_0000
            } else {
                host
            }
        );
        input.push(bits);
        expected.extend_from_slice(&[
            result,
            result,
            result,
            1,
            0x8000_0000,
            0x7f80_0000,
            0x4000_0000,
            7,
            result,
            1,
        ]);
    }
    assert_eq!(input.len(), 4096);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "__fsqrt_rn exact squared-midpoint references preserve sqrt classes rounding and one argument snapshots",
        include_str!("../../../../../naga/tests/in/cuda/fsqrt-rn.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
