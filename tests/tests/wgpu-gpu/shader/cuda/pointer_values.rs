use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str =
    include_str!("../../../../../naga/tests/in/cuda/pointer-value-construction.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    expected[..40].copy_from_slice(&[
        6, 82, 5, 8, 12, 18, 13, 43, 17, 30, 30, 8, 30, 29, 5, 13, 20, 18, 18, 0, 2, 33, 1, 3, 3,
        43, 2, 34, 3, 5, 12, 2, 25, 34, 38, 20, 8, 18, 30, 3,
    ]);
    vec![module_case(
        "pointer constructors and casts preserve nulls qualifiers snapshots and local shared storage origins",
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
