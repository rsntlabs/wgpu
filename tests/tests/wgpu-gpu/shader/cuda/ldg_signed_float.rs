use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INTEGERS: [i32; 4] = [i32::MIN, -1, 0, i32::MAX];
    let mut tests = Vec::new();
    for float_bits in [
        [0, 0x8000_0000, 0x3f80_0000, 0xc020_0000],
        [0x7f80_0000, 0xff80_0000, 0x7fc0_0000, 0x0080_0000],
    ] {
        let reals = float_bits.map(f32::from_bits);
        let mut expected = [SENTINEL; 48];
        for lane in 0..4 {
            let integer = INTEGERS[lane] as u32;
            let bits = float_bits[lane];
            expected[4 + lane * 10..14 + lane * 10].copy_from_slice(&[
                integer,
                integer,
                1,
                bits,
                bits,
                3,
                integer,
                lane as u32 + 1,
                bits,
                lane as u32 + 1,
            ]);
        }
        tests.push(module_case(
            "ldg preserves signed and floating storage bits and overload types with once-only indices",
            include_str!("../../../../../naga/tests/in/cuda/ldg-signed-float.cu"),
            [4, 1, 1],
            &expected,
        ).module_buffers(vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INTEGERS),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &reals),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 48]),
        ], 2, [1, 1, 1]));
    }
    tests
}
