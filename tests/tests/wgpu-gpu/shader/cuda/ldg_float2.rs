use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input: Vec<[u32; 2]> = (0..32u32)
        .map(|index| {
            [
                (index as f32 + 0.5).to_bits(),
                (-(index as f32) - 100.25).to_bits(),
            ]
        })
        .collect();
    input[0] = [0, 0x8000_0000];
    input[1] = [0x7f80_0000, 0xff80_0000];
    input[2] = [0x7fc0_0000, 0x0080_0000];
    let mut expected = vec![SENTINEL; 264];
    for (index, pair) in input.iter().enumerate() {
        let reverse = input[31 - index];
        expected[4 + index * 8..12 + index * 8].copy_from_slice(&[
            pair[0],
            pair[1],
            pair[0],
            pair[1],
            reverse[0],
            reverse[1],
            index as u32 + 1,
            2,
        ]);
    }
    vec![module_case(
        "float2 ldg preserves asymmetric components vector strides aliases and once-only indices",
        include_str!("../../../../../naga/tests/in/cuda/ldg-float2.cu"),
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
                &vec![SENTINEL; 264],
            ),
        ],
        1,
        [9, 1, 1],
    )]
}
