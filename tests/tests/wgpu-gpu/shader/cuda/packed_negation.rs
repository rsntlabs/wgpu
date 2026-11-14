use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(value: u32) -> [u32; 4] {
    let bytes = value.to_le_bytes();
    let mut negated2 = [0u8; 4];
    let mut saturated2 = [0u8; 4];
    for lane in 0..2 {
        let offset = lane * 2;
        let signed = i16::from_le_bytes([bytes[offset], bytes[offset + 1]]);
        let negated = -i64::from(signed);
        negated2[offset..offset + 2].copy_from_slice(&(negated as u16).to_le_bytes());
        saturated2[offset..offset + 2].copy_from_slice(
            &(negated.clamp(i64::from(i16::MIN), i64::from(i16::MAX)) as i16).to_le_bytes(),
        );
    }
    let negated4 = core::array::from_fn(|lane| (-i64::from(bytes[lane] as i8)) as u8);
    let saturated4 = core::array::from_fn(|lane| {
        (-i64::from(bytes[lane] as i8)).clamp(i64::from(i8::MIN), i64::from(i8::MAX)) as i8 as u8
    });
    [
        u32::from_le_bytes(negated2),
        u32::from_le_bytes(negated4),
        u32::from_le_bytes(saturated2),
        u32::from_le_bytes(saturated4),
    ]
}

fn effect(value: u32) -> [u32; 4] {
    oracle((value * 0x01020304) ^ 0x80ff017f)
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut words = Vec::new();
    for value in 0u16..=u16::MAX {
        let neighbor = value.wrapping_mul(40503).wrapping_add(0x9e37);
        let low = value.to_le_bytes();
        let high = neighbor.to_le_bytes();
        words.push(u32::from_le_bytes([low[0], low[1], high[0], high[1]]));
    }
    for value in 0u8..=u8::MAX {
        words.push(u32::from_le_bytes([
            value,
            value.rotate_left(1),
            value.wrapping_mul(17).wrapping_add(0x81),
            !value,
        ]));
    }
    words.extend([
        0,
        u32::MAX,
        0x80008000,
        0x80808080,
        0x7fff7fff,
        0x7f7f7f7f,
        0x7fff8001,
        0x7f80ff01,
    ]);
    for bit in 0..32 {
        let word = 1u32 << bit;
        words.extend([word, !word]);
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..128 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        words.push(random);
    }
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 4 + 64 * 17 + 4];
    for (row, value) in words.into_iter().enumerate() {
        input.push(value);
        expected[4 + row * 4..8 + row * 4].copy_from_slice(&oracle(value));
    }
    for lane in 0..64 {
        let base = 4 + count * 4 + lane * 17;
        let selected = 6 + if lane & 1 == 0 { 1 } else { 0 };
        expected[base..base + 17].copy_from_slice(&[
            effect(1)[0],
            effect(2)[1],
            effect(3)[2],
            effect(4)[3],
            5,
            selected,
            selected + 1,
            oracle(input[1])[2],
            2,
            0x80008000,
            0x7fff7fff,
            0x80808080,
            0x7f7f7f7f,
            0x80008000,
            0x80808080,
            0x80018001,
            0x81818181,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/packed-negation.cu");
    let captured = format!(
        "__device__ unsigned __vneg2(bool value) {{ return 7u; }}
         __device__ unsigned __vneg4(bool value) {{ return 7u; }}
         __device__ unsigned __vnegss2(bool value) {{ return 7u; }}
         __device__ unsigned __vnegss4(bool value) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct packed negation covers every signed halfword and minimum saturation",
            direct,
        ),
        (
            "captured packed negation covers every signed halfword and minimum saturation",
            captured.as_str(),
        ),
    ]
    .into_iter()
    .map(|(name, source)| {
        module_case(name, source, [64, 1, 1], &expected).module_buffers(
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
