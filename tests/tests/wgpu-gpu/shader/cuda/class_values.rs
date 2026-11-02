use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/class-value-construction.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    expected[..40].copy_from_slice(&[
        61, 71, 73, 79, 67, 0, 89, 101, 103, 107, 97, 0, 5, 47, 53, 59, 31, 41, 0, 6, 1, 3, 5, 7,
        9, 11, 109, 113, 9, 10, 39, 57, 87, 51, 1, 1, 3, 0, 1, 0,
    ]);
    vec![module_case(
        "class construction and casts preserve copies defaults target constness and single evaluation",
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
