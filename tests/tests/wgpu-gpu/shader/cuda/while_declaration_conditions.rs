use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 16] = [2, 1, 0, 99, 1, 0, 99, 99, 3, 2, 1, 0, 0, 99, 99, 99];
    let mut expected = [SENTINEL; 56];
    for lane in 0..4 {
        let stream = &INPUT[lane * 4..lane * 4 + 4];
        let end = stream.iter().position(|value| *value == 0).unwrap();
        let total: u32 = stream[..end]
            .iter()
            .filter(|value| **value != 1)
            .map(|value| *value as u32)
            .sum();
        let reads = end as u32 + 1;
        let first = stream[0] as u32;
        expected[4 + lane * 12..16 + lane * 12].copy_from_slice(&[
            total,
            reads,
            total,
            reads,
            first,
            1,
            2,
            if first != 0 { first + 9 } else { 0 },
            50,
            1,
            total + 1,
            reads * 2 + 2,
        ]);
    }
    vec![module_case(
        "while scalar declarations reinitialize on continue and final false test but not after break",
        include_str!("../../../../../naga/tests/in/cuda/while-declaration-conditions.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;56]),
    ], 1, [2, 1, 1])]
}
