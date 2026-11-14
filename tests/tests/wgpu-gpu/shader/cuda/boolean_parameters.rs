use super::{module_case, ShaderBuffer, ShaderTest};

const SOURCE: &str = include_str!("../../../../../naga/tests/in/cuda/boolean-parameters.cu");
const SENTINEL: u32 = 0xdead_beef;
const CAPACITY: usize = 40;

pub(super) fn cases() -> Vec<ShaderTest> {
    let words = [0, 1, 2, 0xff, 0x100, 0xffff_ff00, 0xffff_ff01];
    words
        .iter()
        .enumerate()
        .map(|(index, &word)| {
            let frozen_word = words[words.len() - index - 1];
            let enabled = word & 0xff != 0;
            let frozen = frozen_word & 0xff != 0;
            let result = [
                u32::from(enabled),
                if enabled { 31 } else { 17 },
                u32::from(!enabled),
                if enabled { 17 } else { 31 },
                u32::from(frozen),
                if frozen { 7 } else { 9 },
                if enabled { 31 } else { 17 },
                u32::from(enabled == frozen),
            ];
            let mut expected = [SENTINEL; CAPACITY];
            for lane in 0..4 {
                expected[4 + lane * 8..12 + lane * 8].copy_from_slice(&result);
            }
            module_case(
                &format!("Boolean parameters decode low bytes and preserve local types: {word:08x}/{frozen_word:08x}"),
                SOURCE,
                [4, 1, 1],
                &expected,
            )
            .module_buffers(
                vec![
                    ShaderBuffer::new(
                        0,
                        wgpu::BufferBindingType::Uniform,
                        &[word, SENTINEL, SENTINEL, SENTINEL],
                    ),
                    ShaderBuffer::new(
                        1,
                        wgpu::BufferBindingType::Uniform,
                        &[frozen_word, SENTINEL, SENTINEL, SENTINEL],
                    ),
                    ShaderBuffer::new(
                        2,
                        wgpu::BufferBindingType::Storage { read_only: false },
                        &[SENTINEL; CAPACITY],
                    ),
                ],
                2,
                [1, 1, 1],
            )
        })
        .collect()
}
