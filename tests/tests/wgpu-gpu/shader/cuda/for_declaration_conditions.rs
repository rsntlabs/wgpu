use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 16] = [2, 1, 0, 99, 1, 0, 99, 99, 3, 2, 1, 0, 0, 99, 99, 99];
    let mut expected = [SENTINEL; 40];
    for lane in 0..4 {
        let stream = &INPUT[lane * 4..lane * 4 + 4];
        let iterations = stream.iter().position(|value| *value == 0).unwrap();
        let total: i32 = stream[..iterations].iter().sum();
        let observed: u32 = (0..iterations).map(|index| 10 + index as u32).sum();
        expected[4 + lane * 8..12 + lane * 8].copy_from_slice(&[
            total as u32,
            iterations as u32 + 1,
            iterations as u32,
            observed,
            total as u32,
            iterations as u32 + 1,
            1,
            stream[0] as u32,
        ]);
    }
    vec![module_case(
        "for declaration conditions reinitialize after continuing and observe body mutations while break skips continuing",
        include_str!("../../../../../naga/tests/in/cuda/for-declaration-conditions.cu"),
        [4, 1, 1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &INPUT),
        ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL;40]),
    ], 1, [2, 1, 1])]
}
