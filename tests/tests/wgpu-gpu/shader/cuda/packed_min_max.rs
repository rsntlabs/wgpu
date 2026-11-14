use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32) -> [u32; 8] {
    let a = a.to_le_bytes();
    let b = b.to_le_bytes();
    let mut min_s2 = [0u8; 4];
    let mut min_u2 = [0u8; 4];
    let mut max_s2 = [0u8; 4];
    let mut max_u2 = [0u8; 4];
    for lane in 0..2 {
        let offset = lane * 2;
        let sa = i64::from(i16::from_le_bytes([a[offset], a[offset + 1]]));
        let sb = i64::from(i16::from_le_bytes([b[offset], b[offset + 1]]));
        let ua = u64::from(u16::from_le_bytes([a[offset], a[offset + 1]]));
        let ub = u64::from(u16::from_le_bytes([b[offset], b[offset + 1]]));
        min_s2[offset..offset + 2].copy_from_slice(&(sa.min(sb) as i16).to_le_bytes());
        min_u2[offset..offset + 2].copy_from_slice(&(ua.min(ub) as u16).to_le_bytes());
        max_s2[offset..offset + 2].copy_from_slice(&(sa.max(sb) as i16).to_le_bytes());
        max_u2[offset..offset + 2].copy_from_slice(&(ua.max(ub) as u16).to_le_bytes());
    }
    let min_s4 = core::array::from_fn(|lane| {
        i64::from(a[lane] as i8).min(i64::from(b[lane] as i8)) as i8 as u8
    });
    let min_u4 = core::array::from_fn(|lane| u64::from(a[lane]).min(u64::from(b[lane])) as u8);
    let max_s4 = core::array::from_fn(|lane| {
        i64::from(a[lane] as i8).max(i64::from(b[lane] as i8)) as i8 as u8
    });
    let max_u4 = core::array::from_fn(|lane| u64::from(a[lane]).max(u64::from(b[lane])) as u8);
    [
        u32::from_le_bytes(min_s2),
        u32::from_le_bytes(min_s4),
        u32::from_le_bytes(min_u2),
        u32::from_le_bytes(min_u4),
        u32::from_le_bytes(max_s2),
        u32::from_le_bytes(max_s4),
        u32::from_le_bytes(max_u2),
        u32::from_le_bytes(max_u4),
    ]
}

fn effect(start: u32) -> [u32; 8] {
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
        (0x80008000, 0x7fff7fff),
        (0x7fff7fff, 0x80008000),
        (0x80808080, 0x7f7f7f7f),
        (0x7f7f7f7f, 0x80808080),
        (u32::MAX, 0),
        (0, u32::MAX),
        (0x80ff017f, 0x80ff017f),
        (0x7fff8001, 0x7fff8001),
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
        let other = random.rotate_left(11) ^ 0xa5a5_5a5a;
        words.extend([(random, other), (other, random)]);
    }
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 8 + 64 * 27 + 4];
    for (row, (a, b)) in words.into_iter().enumerate() {
        input.extend([a, b]);
        expected[4 + row * 8..12 + row * 8].copy_from_slice(&oracle(a, b));
    }
    for lane in 0..64 {
        let base = 4 + count * 8 + lane * 27;
        let selected = 18 + if lane & 1 == 0 { 2 } else { 0 };
        expected[base..base + 27].copy_from_slice(&[
            effect(1)[0],
            effect(3)[1],
            effect(5)[2],
            effect(7)[3],
            effect(9)[4],
            effect(11)[5],
            effect(13)[6],
            effect(15)[7],
            u32::MAX,
            selected,
            selected + 2,
            oracle(input[1], input[2])[5],
            3,
            0x80008000,
            0x80808080,
            0x7fff7fff,
            0x7f7f7f7f,
            0x7fff7fff,
            0x7f7f7f7f,
            0x80008000,
            0x80808080,
            u32::MAX,
            0x01010101,
            0x00010001,
            u32::MAX,
            0x80ff017f,
            0x80ff017f,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/packed-min-max.cu");
    let captured = format!(
        "__device__ unsigned __vmins2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vmins4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vminu2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vminu4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vmaxs2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vmaxs4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vmaxu2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vmaxu4(bool a, bool b) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct packed min/max preserve original bits under signed and unsigned ordering",
            direct,
        ),
        (
            "captured packed min/max preserve original bits under signed and unsigned ordering",
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
