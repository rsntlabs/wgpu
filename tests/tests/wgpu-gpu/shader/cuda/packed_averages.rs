use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn signed_average(a: i32, b: i32) -> i32 {
    let sum = i64::from(a) + i64::from(b);
    let quotient = sum / 2;
    let remainder = sum % 2;
    (quotient + if remainder == 0 { 0 } else { sum.signum() }) as i32
}

fn unsigned_average(a: u32, b: u32) -> u32 {
    let sum = u64::from(a) + u64::from(b);
    (sum / 2 + sum % 2) as u32
}

fn oracle(a: u32, b: u32) -> [u32; 4] {
    let a = a.to_le_bytes();
    let b = b.to_le_bytes();
    let mut signed2 = [0u8; 4];
    let mut unsigned2 = [0u8; 4];
    for lane in 0..2 {
        let offset = lane * 2;
        let signed_a = i16::from_le_bytes([a[offset], a[offset + 1]]);
        let signed_b = i16::from_le_bytes([b[offset], b[offset + 1]]);
        let unsigned_a = u16::from_le_bytes([a[offset], a[offset + 1]]);
        let unsigned_b = u16::from_le_bytes([b[offset], b[offset + 1]]);
        signed2[offset..offset + 2].copy_from_slice(
            &(signed_average(i32::from(signed_a), i32::from(signed_b)) as i16).to_le_bytes(),
        );
        unsigned2[offset..offset + 2].copy_from_slice(
            &(unsigned_average(u32::from(unsigned_a), u32::from(unsigned_b)) as u16).to_le_bytes(),
        );
    }
    let signed4 = core::array::from_fn(|lane| {
        signed_average(i32::from(a[lane] as i8), i32::from(b[lane] as i8)) as i8 as u8
    });
    let unsigned4 =
        core::array::from_fn(|lane| unsigned_average(u32::from(a[lane]), u32::from(b[lane])) as u8);
    [
        u32::from_le_bytes(signed2),
        u32::from_le_bytes(signed4),
        u32::from_le_bytes(unsigned2),
        u32::from_le_bytes(unsigned4),
    ]
}

fn effect(start: u32) -> [u32; 4] {
    oracle(
        (start * 0x01020304) ^ 0x80ff017f,
        ((start + 1) * 0x03050709) ^ 0xfe028100,
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut words = Vec::new();
    for a in 0u8..=255 {
        for b in 0u8..=255 {
            words.push((
                u32::from_le_bytes([
                    a,
                    a.wrapping_mul(17).wrapping_add(b),
                    a ^ 0xa5,
                    b.wrapping_add(0x81),
                ]),
                u32::from_le_bytes([
                    b,
                    b.wrapping_mul(29).wrapping_add(a),
                    b ^ 0x5a,
                    a.wrapping_sub(0x37),
                ]),
            ));
        }
    }
    let boundaries = [
        0,
        1,
        0xffff,
        0x10000,
        0x7fff7fff,
        0x80008000,
        u32::MAX,
        0xffff0000,
        0x00010001,
        0x7fff8000,
        0x80007fff,
        0x7fff0001,
        0xffff8000,
    ];
    words.extend(
        boundaries
            .into_iter()
            .flat_map(|a| boundaries.map(|b| (a, b))),
    );
    words.extend([
        (0x7fff7fff, 0x00010001),
        (0x7f7f7f7f, 0x01010101),
        (0x80008000, 0x00010001),
        (0x80808080, 0x01010101),
        (0x80008000, u32::MAX),
        (0x80808080, u32::MAX),
        (0x80008000, 0x80008000),
        (0x80808080, 0x80808080),
        (0x7fff7fff, u32::MAX),
        (0x7f7f7f7f, u32::MAX),
        (0x7fff8000, 0x0001ffff),
        (0x7f8001ff, 0xff01ff01),
    ]);
    words.extend([
        (u32::MAX, 0),
        (0xfffdfffd, 0),
        (0xfdfdfdfd, 0),
        (0xfffffffe, 0xfffffffe),
        (0xfffefdfc, 0xfffefdfc),
        (0x80008000, 0x7fff7fff),
        (0x80808080, 0x7f7f7f7f),
        (u32::MAX, u32::MAX),
        (0, 0),
        (0x7f7f7f7f, 0x7f7f7f7f),
    ]);
    for bit in 0..32 {
        let word = 1u32 << bit;
        words.extend([(word, word), (!word, word), (word, !word), (!word, !word)]);
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..256 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        words.push((random, random.rotate_left(11) ^ 0xa5a5_5a5a));
    }
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 4 + 64 * 12 + 4];
    for (row, (a, b)) in words.into_iter().enumerate() {
        input.extend([a, b]);
        expected[4 + row * 4..8 + row * 4].copy_from_slice(&oracle(a, b));
    }
    for lane in 0..64 {
        let base = 4 + count * 4 + lane * 12;
        let selected = 9 + if lane & 1 == 0 { 2 } else { 0 };
        expected[base..base + 12].copy_from_slice(&[
            effect(1)[0],
            effect(3)[1],
            effect(5)[2],
            effect(7)[3],
            selected,
            selected + 2,
            oracle(input[1], input[2])[3],
            3,
            u32::MAX,
            0xfefefefe,
            0x80008000,
            u32::MAX,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/packed-averages.cu");
    let captured = format!(
        "__device__ unsigned __vavgs2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vavgs4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vavgu2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vavgu4(bool a, bool b) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct packed averages round signed ties away and unsigned ties upward",
            direct,
        ),
        (
            "captured packed averages round signed ties away and unsigned ties upward",
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
