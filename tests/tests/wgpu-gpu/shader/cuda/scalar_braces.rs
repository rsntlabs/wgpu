use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/scalar-brace-expressions.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    let observed: [f32; 40] = [
        0.0,
        0.0,
        0.0,
        0.0,
        1.0,
        -7.0,
        11.0,
        1.5,
        17.0,
        19.0,
        2.5,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        23.0,
        -0.0,
        3.0,
        29.0,
        31.0,
        37.0,
        5.0,
        3.0,
        7.0,
        11.0,
        13.0,
        10.0,
        59.0,
        30.0,
        40.0,
        7.0,
        4.0,
        0.0,
        16_777_218.0,
        1.0,
        0.0,
        0.0,
        -0.0,
        4.0,
    ];
    expected[..observed.len()].copy_from_slice(&observed.map(f32::to_bits));
    vec![module_case(
        "scalar brace expressions preserve narrowing rules signed zeros templates and call effects",
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
