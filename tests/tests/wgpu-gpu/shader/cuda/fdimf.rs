use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input: [[u32; 2]; 26] = [
        [0, 0x8000_0000],
        [0x8000_0000, 0],
        [0, 0],
        [0x8000_0000, 0x8000_0000],
        [0x7f80_0000, 0x7f80_0000],
        [0xff80_0000, 0xff80_0000],
        [0x7f80_0000, 0xff80_0000],
        [0xff80_0000, 0x7f80_0000],
        [0x3f80_0000, 0xff80_0000],
        [0x7f80_0000, 0x3f80_0000],
        [0xff80_0000, 0x3f80_0000],
        [0x3f80_0000, 0x7f80_0000],
        [1, 0],
        [0x0080_0000, 0x007f_ffff],
        [1, 0x8000_0001],
        [0x007f_ffff, 0x8000_0001],
        [0x7f7f_ffff, 0xff7f_ffff],
        [0x3f80_0000, 0xb380_0000],
        [0x3f80_0001, 0xb380_0000],
        [0xbf80_0000, 0xbf80_0001],
        [0xbf80_0001, 0xbf80_0000],
        [0x7fc0_1234, 0],
        [0x3f80_0000, 0xff80_0001],
        [0x4000_0000, 0x3f80_0000],
        [0x7fc0_1234, 0x7fc0_1234],
        [0xffc0_1234, 0xffc0_1234],
    ];
    let mut expected = vec![SENTINEL; 4 + 4 * input.len() + 4];
    for (index, &[left, right]) in input.iter().enumerate() {
        let x = f32::from_bits(left);
        let y = f32::from_bits(right);
        let bits = if x.is_nan() || y.is_nan() {
            0x7fc0_0000
        } else if x <= y {
            0
        } else {
            ((f64::from(x) - f64::from(y)) as f32).to_bits()
        };
        expected[4 + index * 4..8 + index * 4].copy_from_slice(&[bits, bits, 2, 1]);
    }
    let initial = vec![SENTINEL; expected.len()];
    let test = module_case(
        "fdimf returns positive differences with canonical zeros NaNs and exact single rounding",
        include_str!("../../../../../naga/tests/in/cuda/fdimf.cu"),
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
        ],
        1,
        [8, 1, 1],
    );
    vec![test]
}
