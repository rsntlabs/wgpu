use super::{floorf::input_bits, module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = input_bits();
    assert_eq!(input.len(), 3037);
    let mut state = 0x72f0_13a5u32;
    while input.len() < 4096 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        input.push(state);
    }
    let mut expected = vec![SENTINEL; 4];
    for bits in input.iter().copied() {
        let source = f32::from_bits(bits);
        let result = if source.is_nan() {
            0x7fc0_0000
        } else {
            source.trunc().to_bits()
        };
        if bits & 0x7fff_ffff < 0x3f80_0000 {
            assert_eq!(result, bits & 0x8000_0000);
        }
        if bits & 0x7fff_ffff >= 0x4b00_0000 && !source.is_nan() {
            assert_eq!(result, bits);
        }
        expected.extend_from_slice(&[
            result,
            result,
            result,
            1,
            0x8000_0000,
            0x8000_0000,
            0xbf80_0000,
            0x4040_0000,
            7,
            result,
            result,
            1,
        ]);
    }
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "truncf exact CPU oracle covers all exponent bands signed zeros subnormals classes wrappers and once effects",
        include_str!("../../../../../naga/tests/in/cuda/truncf.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
