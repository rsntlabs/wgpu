use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut expected = [SENTINEL; 40];
    for lane in 0..4 {
        let initial = lane as u32 + 4;
        let selected = initial + if lane & 1 == 0 { 3 } else { 7 };
        expected[4 + lane * 8..12 + lane * 8].copy_from_slice(&[
            initial,
            selected,
            selected + 2,
            2,
            11,
            selected + 3,
            selected + 5,
            0,
        ]);
    }
    vec![module_case(
        "void casts preserve calls, reference updates, selected effects, comma order, and discarded indices",
        include_str!("../../../../../naga/tests/in/cuda/void-casts.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 40],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[11i32, 7],
            ),
        ],
        0,
        [1, 1, 1],
    )]
}
