use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/direct-aggregate-copy.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..24].copy_from_slice(&[
        3, 5, 8, 7, 11, 13, 17, 11, 23, 19, 1, 31, 41, 34, 43, 59, 53, 47, 61, 62, 2, 67, 71, 79,
    ]);
    vec![module_case(
        "same-type parenthesized record and vector copies capture arrays values and helper effects once",
        FIXTURE,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    )]
}
