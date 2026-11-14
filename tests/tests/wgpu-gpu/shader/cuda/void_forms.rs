use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 32];
    for lane in 0..4 {
        let initial = lane as u32 + 2;
        let selected = initial + 2 + if lane & 1 == 0 { 3 } else { 7 };
        expected[4 + lane * 6..10 + lane * 6].copy_from_slice(&[
            initial,
            initial + 2,
            selected,
            selected + 2,
            2,
            0,
        ]);
    }
    vec![module_case(
        "qualified and functional void forms preserve counters, lazy arms, discarded indices, and guards",
        include_str!("../../../../../naga/tests/in/cuda/void-forms.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 32]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: true }, &[11i32, 7]),
        ],
        0,
        [1, 1, 1],
    )]
}
