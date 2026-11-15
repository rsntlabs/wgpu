use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    for line in include_str!("frcp-rz-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [bits, toward_zero, nearest] = words[..] else {
            panic!("expected input,exact rational oracle");
        };
        let host = (1.0f32 / f32::from_bits(bits)).to_bits();
        assert_eq!(
            nearest,
            if host & 0x7fff_ffff > 0x7f80_0000 {
                0x7fc0_0000
            } else {
                host
            }
        );
        input.push(bits);
        expected.extend_from_slice(&[
            toward_zero,
            toward_zero,
            toward_zero,
            1,
            0xff80_0000,
            0x8000_0000,
            0x3f00_0000,
            7,
            toward_zero,
            nearest,
        ]);
    }
    assert_eq!(input.len(), 4096);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "__frcp_rz exact rational references preserve reciprocal classes rounding and one argument snapshots",
        include_str!("../../../../../naga/tests/in/cuda/frcp-rz.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
