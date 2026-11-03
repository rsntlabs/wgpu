use super::{module_entry_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str =
    include_str!("../../../../../naga/tests/in/cuda/operator-compound-assignments.cu");
const SENTINEL: u32 = 0xdead_beef;
const RECORD_WORDS: usize = 40;
const LANES: usize = 4;
const GUARD_WORDS: usize = 16;

fn operator_values(lane: u32) -> Vec<u32> {
    let product = 204 + 2 * lane;
    let quotient = product / 4;
    let remainder = quotient % 7;
    let masked = remainder & 3;
    let combined = masked | 8;
    let toggled = combined ^ 5;
    let shifted = toggled << 2;
    let final_value = shifted >> 1;
    vec![
        105 + lane,
        102 + lane,
        202 + lane,
        product,
        product + 200,
        quotient,
        remainder,
        remainder + 400,
        masked,
        masked + 700,
        combined,
        toggled,
        toggled + 500,
        shifted,
        shifted + 600,
        final_value,
        103 + lane,
        403 + lane,
        (16 + lane) | 3,
        final_value + 2,
        final_value + 5,
        (9 + lane) | 2,
        9 + lane,
    ]
}

fn ordered_values(lane: u32) -> Vec<u32> {
    vec![
        10 + lane,
        25 + lane,
        30 + lane,
        2,
        17 + lane,
        1,
        35 + lane,
        35 + lane,
        1 + lane,
        23,
        323,
        11,
        11,
        23 + lane,
        23 + lane,
        12,
        212,
        1,
        4,
        7,
        11 + lane,
        10 + lane,
        21 + lane,
        21 + lane,
        37 + lane,
        537 + lane,
        35 + lane,
        635 + lane,
        6 + lane,
        6 + lane,
        7 + lane,
        1,
        6 + lane,
        7 + lane,
        7 + lane,
        1,
        43 + lane,
        40 + lane,
        42 + lane,
        40 + lane,
    ]
}

pub(super) fn cases() -> Vec<ShaderTest> {
    ["compound_operators", "compound_order"]
        .into_iter()
        .map(|entry| {
            let initial = vec![SENTINEL; LANES * RECORD_WORDS + GUARD_WORDS];
            let mut expected = initial.clone();
            for lane in 0..LANES {
                let values = if entry == "compound_operators" {
                    operator_values(lane as u32)
                } else {
                    ordered_values(lane as u32)
                };
                let offset = lane * RECORD_WORDS;
                expected[offset..offset + values.len()].copy_from_slice(&values);
            }
            module_entry_case(
                &format!("compound operator results, operand order, and aliases in {entry}"),
                FIXTURE,
                [2, 1, 1],
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
