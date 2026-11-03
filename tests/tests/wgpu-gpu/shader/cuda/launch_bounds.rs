use super::{module_entry_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/launch-bounds.cu");
const SENTINEL: u32 = 0xdead_beef;
const COUNT: u32 = 23;
const LAUNCHED_RECORDS: usize = 24;
const RECORD_WORDS: usize = 4;
const GUARD_WORDS: usize = 16;

pub(super) fn cases() -> Vec<ShaderTest> {
    let input: Vec<_> = (0..32_u32).map(|index| index * 7 + 5).collect();
    let mut tests = Vec::new();
    for (workgroup_size, dispatch) in [([2, 3, 2], [2, 1, 1]), ([2, 2, 2], [3, 1, 1])] {
        let block_size = workgroup_size.into_iter().product::<u32>();
        let initial = vec![SENTINEL; LAUNCHED_RECORDS * RECORD_WORDS + GUARD_WORDS];
        let mut expected = initial.clone();
        for index in 0..COUNT {
            let offset = index as usize * RECORD_WORDS;
            expected[offset..offset + RECORD_WORDS].copy_from_slice(&[
                input[index as usize] * 3 + 7,
                block_size,
                index % block_size,
                index / block_size,
            ]);
        }
        for entry in ["bounded", "bounded_template<12u>"] {
            tests.push(
                module_entry_case(
                    &format!(
                        "launch bounds {entry} preserve configured workgroup {workgroup_size:?}"
                    ),
                    FIXTURE,
                    workgroup_size,
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
                            &[COUNT, 0x0123_4567, 0x89ab_cdef, 0x1357_9bdf],
                        ),
                    ],
                    0,
                    dispatch,
                ),
            );
        }
    }
    tests
}
