use super::float2int_rd::INPUT;
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = 0x5a5a_5a5a;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = INPUT.to_vec();
    for tie in [0.5f32, 1.5, 2.5, 3.5, -0.5, -1.5, -2.5, -3.5] {
        input.extend([
            tie.next_down().to_bits(),
            tie.to_bits(),
            tie.next_up().to_bits(),
        ]);
    }
    let initial = vec![SENTINEL; input.len() * 8 + 8];
    let mut expected = initial.clone();
    for (index, bits) in input.iter().copied().enumerate() {
        let value = f32::from_bits(bits);
        assert!(
            value.is_finite()
                && f64::from(value) >= f64::from(i32::MIN)
                && f64::from(value) <= f64::from(i32::MAX)
        );
        let converted = f64::from(value).round_ties_even() as i32;
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            converted, converted, converted, 1, converted, 2, 16_777_216, 10,
        ]);
    }
    let count = input.len() as u32;
    let test = module_case(
        "float2int_rn rounds float inputs to nearest even and evaluates arguments once",
        include_str!("../../../../../naga/tests/in/cuda/float2int-rn.cu"),
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
