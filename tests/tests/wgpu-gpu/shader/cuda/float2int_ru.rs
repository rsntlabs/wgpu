use super::float2int_rd::INPUT;
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = 0x5a5a_5a5a;

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; INPUT.len() * 8 + 8];
    let mut expected = initial;
    for (index, bits) in INPUT.into_iter().enumerate() {
        let value = f32::from_bits(bits);
        assert!(
            value.is_finite()
                && f64::from(value) >= f64::from(i32::MIN)
                && f64::from(value) <= f64::from(i32::MAX)
        );
        let converted = f64::from(value).ceil() as i32;
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            converted, converted, converted, 1, converted, 2, 16_777_216, 10,
        ]);
    }
    let count = INPUT.len() as u32;
    let test = module_case(
        "float2int_ru ceils float inputs and evaluates arguments once",
        include_str!("../../../../../naga/tests/in/cuda/float2int-ru.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &INPUT,
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
