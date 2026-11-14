use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(mask: u32, base: u32, offset: i32) -> u32 {
    assert!(base < 32);
    let positions: Vec<u32> = (0..32).filter(|&bit| mask & (1u32 << bit) != 0).collect();
    if offset == 0 {
        return if positions.contains(&base) {
            base
        } else {
            u32::MAX
        };
    }
    if offset > 0 {
        positions
            .into_iter()
            .filter(|&bit| bit >= base)
            .nth(offset as usize - 1)
    } else {
        positions
            .into_iter()
            .rev()
            .filter(|&bit| bit <= base)
            .nth((-i64::from(offset) - 1) as usize)
    }
    .unwrap_or(u32::MAX)
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let masks = [
        0,
        u32::MAX,
        0xaaaaaaaa,
        0x55555555,
        0x80000000,
        1,
        0x80000001,
        0x01010101,
    ];
    let offsets = [
        0,
        1,
        -1,
        2,
        -2,
        31,
        -31,
        32,
        -32,
        33,
        -33,
        i32::MIN,
        i32::MAX,
    ];
    let mut words = Vec::new();
    for mask in masks {
        for base in 0..32 {
            for offset in offsets {
                words.push((mask, base, offset));
            }
        }
    }
    for bit in 0..32 {
        for base in 0..32 {
            for offset in [0, 1, -1] {
                words.push((1u32 << bit, base, offset));
            }
        }
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..256 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        let offset = (random.rotate_left(23) % 71) as i32 - 35;
        words.push((random, random.rotate_left(11) & 31, offset));
    }
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count + 44 + 4];
    for (row, (mask, base, offset)) in words.into_iter().enumerate() {
        input.extend([mask, base, offset as u32]);
        expected[4 + row] = oracle(mask, base, offset);
    }
    for lane in 0..4 {
        let base = 4 + count + lane * 11;
        let selected = 4 + if lane & 1 == 0 { 1 } else { 0 };
        expected[base..base + 11].copy_from_slice(&[
            oracle(0x01020304 ^ 0x80ff017f, 10, -1),
            4,
            selected,
            selected + 1,
            oracle(input[1], input[2], input[3] as i32),
            4,
            u32::MAX,
            3,
            1,
            u32::MAX,
            ((lane + 1) & 3) as u32 + 1,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/fns.cu");
    let captured = format!(
        "__device__ unsigned __fns(bool mask, bool base, bool offset) {{ return 7u; }}\n{direct}"
    );
    [
        (
            "direct FNS searches inclusive set-bit ranks and preserves ordered effects",
            direct,
        ),
        (
            "captured FNS searches inclusive set-bit ranks and preserves ordered effects",
            captured.as_str(),
        ),
    ]
    .into_iter()
    .map(|(name, source)| {
        module_case(name, source, [4, 1, 1], &expected).module_buffers(
            vec![
                ShaderBuffer::new(
                    0,
                    wgpu::BufferBindingType::Storage { read_only: false },
                    &vec![SENTINEL; expected.len()],
                ),
                ShaderBuffer::new(
                    1,
                    wgpu::BufferBindingType::Storage { read_only: true },
                    &input,
                ),
            ],
            0,
            [1, 1, 1],
        )
    })
    .collect()
}
