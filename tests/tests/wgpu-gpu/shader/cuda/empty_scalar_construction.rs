use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str =
    include_str!("../../../../../naga/tests/in/cuda/empty-scalar-construction.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    let observed: [f32; 40] = [
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 11.0, 17.0,
        23.0, 3.0, 3.0, 5.0, 7.0, 11.0, 13.0, 0.0, 0.0, 3.0, 0.0, 29.0, 0.0, 4.0, 0.0, 1.0, 0.0,
        7.0, 0.0, 0.0, 0.0, 7.0,
    ];
    expected[..observed.len()].copy_from_slice(&observed.map(f32::to_bits));
    vec![module_case(
        "empty scalar constructors preserve types positive zero constant bounds and call effects",
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
