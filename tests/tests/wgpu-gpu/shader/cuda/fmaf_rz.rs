use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    for line in include_str!("fmaf-rz-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [first, second, third, toward_zero, nearest, downward, upward] = words[..] else {
            panic!("expected three inputs,exact bigint oracle");
        };
        let host = f32::from_bits(first)
            .mul_add(f32::from_bits(second), f32::from_bits(third))
            .to_bits();
        assert_eq!(
            nearest,
            if host & 0x7fff_ffff > 0x7f80_0000 {
                0x7fc0_0000
            } else {
                host
            }
        );
        input.extend_from_slice(&[first, second, third]);
        expected.extend_from_slice(&[
            toward_zero,
            toward_zero,
            toward_zero,
            3,
            0x8000_0000,
            0,
            0x4120_0000,
            7,
            toward_zero,
            nearest,
            downward,
            3,
            upward,
            3,
        ]);
    }
    assert_eq!(input.len(), 12288);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "directed fused multiply-add exact bigint references truncate once through cancellation rescued overflow underflow and sequenced wrappers",
        include_str!("../../../../../naga/tests/in/cuda/fmaf-rz.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
