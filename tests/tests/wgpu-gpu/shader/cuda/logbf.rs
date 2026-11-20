use super::ilogbf::{exponent, exponent_inputs};
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input = exponent_inputs();
    let mut expected = vec![SENTINEL; input.len() * 4 + 8];
    for (index, &bits) in input.iter().enumerate() {
        let value = f32::from_bits(bits);
        let result = if value.is_nan() {
            0x7fc0_0000
        } else if value == 0.0 {
            0xff80_0000
        } else if value.is_infinite() {
            0x7f80_0000
        } else {
            (exponent(bits) as f32).to_bits()
        };
        expected[4 + index * 4..8 + index * 4].copy_from_slice(&[result, result, 1, 1]);
    }
    let count = input.len() as u32;
    let initial = vec![SENTINEL; expected.len()];
    let test = module_case(
        "logbf returns exact floating exponents and evaluates its argument once",
        include_str!("../../../../../naga/tests/in/cuda/logbf.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[count, 777, 888, 999]),
        ],
        1,
        [count.div_ceil(4) + 1, 1, 1],
    );
    vec![test]
}
