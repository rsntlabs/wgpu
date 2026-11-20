use super::float2int_rd::INPUT;
use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input: Vec<_> = INPUT
        .into_iter()
        .filter(|bits| bits >> 31 == 0 || *bits == 0x8000_0000)
        .collect();
    input.extend([
        0x3fc0_0000,
        0x4f00_0000,
        0x4f00_0001,
        0x4f7f_fffe,
        0x4f7f_ffff,
    ]);
    input.extend([
        0x8000_0001,
        0x807f_ffff,
        0x8080_0000,
        0xbe80_0000,
        0xbf00_0000,
        0xbf7f_ffff,
    ]);
    let initial = vec![SENTINEL; input.len() * 8 + 8];
    let mut expected = initial.clone();
    for (index, bits) in input.iter().copied().enumerate() {
        let value = f32::from_bits(bits);
        assert!(
            value.is_finite() && f64::from(value) > -1.0 && f64::from(value) <= f64::from(u32::MAX)
        );
        let converted = f64::from(value).ceil() as u32;
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            converted, converted, converted, 1, converted, 2, 16_777_216, 10,
        ]);
    }
    let count = input.len() as u32;
    let test = module_case(
        "float2uint_ru ceils defined float inputs and evaluates arguments once",
        include_str!("../../../../../naga/tests/in/cuda/float2uint-ru.cu"),
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
