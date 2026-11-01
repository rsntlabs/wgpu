use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/uniform-branch-barriers.cu");
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    [0, 1, 2].into_iter().map(exchange).collect()
}

fn exchange(mode: u32) -> ShaderTest {
    let input = [
        2,
        5,
        11,
        17,
        100,
        300,
        7,
        90,
        u32::MAX,
        0,
        1,
        20,
        31,
        37,
        41,
        43,
    ];
    let mut expected = [SENTINEL; 32];
    for block in 0..4 {
        for lane in 0..4 {
            let source_lane = (lane + usize::from(mode == 0)) % 4;
            let value =
                input[block * 4 + source_lane].wrapping_add(if mode == 0 { 20 } else { 10 });
            expected[block * 4 + lane] = match (block as u32 + mode) % 3 {
                0 => value.wrapping_add(1),
                1 => value.wrapping_mul(2).wrapping_add(3),
                _ => value.wrapping_add(3),
            };
        }
    }
    module_case(
        &format!("uniform branches exchange shared values with mode {mode}"),
        FIXTURE,
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 32],
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[mode, SENTINEL, SENTINEL, SENTINEL],
            ),
        ],
        1,
        [4, 1, 1],
    )
}
