use super::{floorf::input_bits, module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = input_bits();
    assert_eq!(input.len(), 3037);
    for integer in -128..=128 {
        let bits = (integer as f32 + 0.5).to_bits();
        input.extend_from_slice(&[bits - 1, bits, bits + 1]);
    }
    let mut state = 0x21a7_f123u32;
    while input.len() < 4096 {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        input.push(state);
    }
    assert_eq!(input.len(), 4096);
    let mut expected = vec![SENTINEL; 4];
    for bits in input.iter().copied() {
        let value = f32::from_bits(bits);
        let result = if value.is_nan() {
            0x7fc0_0000
        } else {
            value.round_ties_even().to_bits()
        };
        if bits & 0x7fff_ffff <= 0x3f00_0000 {
            assert_eq!(result, bits & 0x8000_0000);
        }
        if bits & 0x7fff_ffff >= 0x4b00_0000 && !value.is_nan() {
            assert_eq!(result, bits);
        }
        expected.extend_from_slice(&[
            result,
            result,
            result,
            1,
            0x8000_0000,
            0,
            0x4000_0000,
            0x4040_0000,
            0xc000_0000,
            0xc040_0000,
            0x4040_0000,
            7,
            result,
            1,
        ]);
    }
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "rintf exact CPU nearest-even oracle covers halfway parity signed zeros all exponent bands and once effects",
        include_str!("../../../../../naga/tests/in/cuda/rintf.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
