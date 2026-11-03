use super::{module_entry_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/constant-memory.cu");
const SENTINEL: u32 = 0xdead_beef;
const COUNT: usize = 7;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut cases = Vec::new();
    for (addend, weights, settings) in [
        (3u32, [2u32, 5, 11, 23], [3u32, 7]),
        (17u32, [29u32, 13, 7, 3], [5u32, 19]),
    ] {
        for entry in ["constant_memory", "constant_references"] {
            let input: Vec<u32> = (0..12_u32)
                .map(|index| index.wrapping_mul(0x1020_4081) ^ 0x8040_2010)
                .collect();
            let initial = [SENTINEL; 24];
            let mut expected = initial;
            for index in 0..COUNT {
                expected[index] = if entry == "constant_memory" {
                    input[index]
                        .wrapping_mul(settings[0])
                        .wrapping_add(weights[index % 4])
                        .wrapping_add(addend)
                        .wrapping_add(settings[1])
                        .wrapping_add(72)
                } else {
                    input[index]
                        .wrapping_add(weights[(index + 1) % 4])
                        .wrapping_add(addend)
                        .wrapping_add(settings[0])
                        .wrapping_add(settings[1])
                        .wrapping_add(80)
                };
            }
            cases.push(
                module_entry_case(
                    &format!(
                        "uploaded scalar, array, and record constants in {entry}, addend {addend}"
                    ),
                    FIXTURE,
                    [4, 1, 1],
                    entry,
                    &expected,
                )
                .module_buffers(
                    vec![
                        ShaderBuffer::new(
                            0,
                            wgpu::BufferBindingType::Storage { read_only: false },
                            &initial,
                        ),
                        ShaderBuffer::new(
                            1,
                            wgpu::BufferBindingType::Storage { read_only: true },
                            &input,
                        ),
                        ShaderBuffer::new(
                            2,
                            wgpu::BufferBindingType::Uniform,
                            &[COUNT as u32, 0x1357_9bdf, 0x2468_ace0, 0x55aa_cc33],
                        ),
                        ShaderBuffer::new(
                            0,
                            wgpu::BufferBindingType::Storage { read_only: true },
                            &[addend],
                        )
                        .binding_group(1),
                        ShaderBuffer::new(
                            1,
                            wgpu::BufferBindingType::Storage { read_only: true },
                            &weights,
                        )
                        .binding_group(1),
                        ShaderBuffer::new(
                            2,
                            wgpu::BufferBindingType::Storage { read_only: true },
                            &settings,
                        )
                        .binding_group(1),
                    ],
                    0,
                    [3, 1, 1],
                ),
            );
        }
    }
    cases
}
