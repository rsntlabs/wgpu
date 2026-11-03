use super::{module_entry_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/typedef-structures.cu");
const SENTINEL: u32 = 0xdead_beef;
const COUNT: usize = 7;

pub(super) fn cases() -> Vec<ShaderTest> {
    [
        ("copy_records<Pair>", 2, false),
        ("copy_records<PacketTag>", 4, false),
        ("transform_records", 4, true),
    ]
    .into_iter()
    .map(|(entry, record_words, transform)| {
        let input: Vec<u32> = (0..12 * record_words)
            .map(|index| (index as u32).wrapping_mul(0x1020_4081) ^ 0x8040_2010)
            .collect();
        let initial = vec![SENTINEL; 16 * record_words];
        let mut expected = initial.clone();
        expected[..COUNT * record_words].copy_from_slice(&input[..COUNT * record_words]);
        if transform {
            for (index, record) in expected[..COUNT * record_words]
                .chunks_exact_mut(record_words)
                .enumerate()
            {
                record.swap(0, 1);
                record[2] = record[2].wrapping_add(index as u32 + 1);
                record[3] ^= 0xa5a5_5a5a;
            }
        }
        module_entry_case(
            &format!("inline typedef records preserve layouts and values in {entry}"),
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
            ],
            0,
            [3, 1, 1],
        )
    })
    .collect()
}
