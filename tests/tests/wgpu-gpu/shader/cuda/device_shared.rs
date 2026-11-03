use super::{module_entry_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/device-shared.cu");
const SENTINEL: u32 = 0xdead_beef;
const RECORD_WORDS: usize = 8;
const GUARD_WORDS: usize = 16;

fn expected_phase(block: u32, lane: u32, bias: u32, phase: u32) -> u32 {
    let base = block * 16 + bias;
    let first = base + (lane + phase) % 4 + phase * (phase + 1) / 2;
    let second = base + 20 + (lane + 4 - phase) % 4 + phase * (phase + 1);
    let counter = base + 40 + 3 * phase * (phase + 1) / 2;
    first | (second << 8) | (counter << 16)
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = vec![SENTINEL; 2 * 4 * RECORD_WORDS + GUARD_WORDS];
    let mut expected = initial.clone();
    for block in 0..2_u32 {
        for lane in 0..4_u32 {
            let offset = (block * 4 + lane) as usize * RECORD_WORDS;
            expected[offset..offset + RECORD_WORDS].copy_from_slice(&[
                expected_phase(block, lane, 10, 0),
                expected_phase(block, lane, 100, 0),
                expected_phase(block, lane, 10, 1),
                expected_phase(block, lane, 100, 1),
                expected_phase(block, lane, 10, 2),
                expected_phase(block, lane, 100, 2),
                700 + block * 16 + lane,
                700 + block * 16 + (lane + 1) % 4 + 1,
            ]);
        }
    }
    ["device_shared", "forwarded_shared"]
        .into_iter()
        .map(|entry| {
            module_entry_case(
                &format!(
                    "helper shared storage in {entry} persists across calls and specializations"
                ),
                FIXTURE,
                [4, 1, 1],
                entry,
                &expected,
            )
            .module_buffers(
                vec![ShaderBuffer::new(
                    0,
                    wgpu::BufferBindingType::Storage { read_only: false },
                    &initial,
                )],
                0,
                [2, 1, 1],
            )
        })
        .collect()
}
