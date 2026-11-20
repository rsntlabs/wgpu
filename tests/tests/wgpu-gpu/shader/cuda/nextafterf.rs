use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input: [[u32; 2]; 24] = [
        [0, 0x8000_0000],
        [0x8000_0000, 0],
        [0, 0x3f80_0000],
        [0, 0xbf80_0000],
        [1, 0],
        [0x8000_0001, 0],
        [0x007f_ffff, 0x3f80_0000],
        [0x0080_0000, 0],
        [0x807f_ffff, 0xbf80_0000],
        [0x8080_0000, 0],
        [0x3f80_0000, 0x4000_0000],
        [0x3f80_0000, 0],
        [0xbf80_0000, 0xc000_0000],
        [0xbf80_0000, 0],
        [0x7f80_0000, 0],
        [0xff80_0000, 0],
        [0x7f7f_ffff, 0x7f80_0000],
        [0xff7f_ffff, 0xff80_0000],
        [0x7fc0_1234, 0],
        [0x3f80_0000, 0xff80_0001],
        [0x3f80_0000, 0xc000_0000],
        [0xbf80_0000, 0x4000_0000],
        [0x3f80_0000, 0x3f80_0000],
        [0xff80_0000, 0xff80_0000],
    ];
    let mut expected = vec![SENTINEL; 4 + 4 * input.len() + 4];
    for (index, &[from, toward]) in input.iter().enumerate() {
        let x = f32::from_bits(from);
        let y = f32::from_bits(toward);
        let bits = if x.is_nan() || y.is_nan() {
            0x7fc0_0000
        } else if x == y {
            toward
        } else if x < y {
            x.next_up().to_bits()
        } else {
            x.next_down().to_bits()
        };
        expected[4 + index * 4..8 + index * 4].copy_from_slice(&[bits, bits, 2, 1]);
    }
    let initial = vec![SENTINEL; expected.len()];
    let test = module_case(
        "nextafterf steps through signed zeros, subnormals, and infinities",
        include_str!("../../../../../naga/tests/in/cuda/nextafterf.cu"),
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
        [7, 1, 1],
    );
    vec![test]
}
