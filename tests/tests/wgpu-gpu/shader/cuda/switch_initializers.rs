use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 4] = [0, 1, 2, 3];
    let rows: [[u32; 16]; 4] = [
        [2, 13, 5, 16, 23, 10, 99, 30, 32, 34, 52, 1, 57, 58, 0, 1],
        [4, 55, 6, 59, 66, 21, 99, 31, 75, 76, 94, 1, 99, 103, 1, 1],
        [5, 36, 7, 40, 47, 22, 99, 32, 56, 58, 76, 1, 81, 85, 2, 1],
        [6, 47, 8, 51, 58, 23, 99, 33, 67, 69, 87, 1, 92, 96, 3, 1],
    ];
    let mut expected = [SENTINEL; 72];
    for (lane, row) in rows.into_iter().enumerate() {
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&row);
    }
    vec![module_case(
        "C++17 switch initializers preserve declaration scope once effects fallthrough ref aliases and loop exits",
        include_str!("../../../../../naga/tests/in/cuda/switch-initializers.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&INPUT),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;72]),
    ],1,[1,1,1])]
}
