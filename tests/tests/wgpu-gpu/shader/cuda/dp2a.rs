use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32, accumulator: u32) -> [u32; 4] {
    let a = a.to_le_bytes();
    let a = [
        u16::from_le_bytes([a[0], a[1]]),
        u16::from_le_bytes([a[2], a[3]]),
    ];
    let b = b.to_le_bytes();
    let mut result = [0; 4];
    for (half, offset) in [0, 2].into_iter().enumerate() {
        let signed_dot: i64 = a
            .iter()
            .zip(&b[offset..offset + 2])
            .map(|(&a, &b)| i64::from(a as i16) * i64::from(b as i8))
            .sum();
        let unsigned_dot: u64 = a
            .iter()
            .zip(&b[offset..offset + 2])
            .map(|(&a, &b)| u64::from(a) * u64::from(b))
            .sum();
        result[half] = (signed_dot + i64::from(accumulator as i32)) as u32;
        result[half + 2] = (unsigned_dot + u64::from(accumulator)) as u32;
    }
    result
}

fn effect(start: u32) -> [u32; 4] {
    oracle(
        (start * 0x01020304) ^ 0x80ff017f,
        ((start + 1) * 0x03050709) ^ 0xfe028100,
        0u32.wrapping_sub((start + 2) * 17),
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let halves = [
        0,
        u32::MAX,
        0x80008000,
        0x7fff7fff,
        0x7fff8000,
        0xffff0001,
        0x00020001,
        0x80000000,
        0x8000,
        0x7fff,
    ];
    let bytes = [
        0,
        u32::MAX,
        0x80808080,
        0x7f7f7f7f,
        0x807f01ff,
        0x11223344,
        0x01010101,
        0xff00ff00,
        0x00ff00ff,
        0x01020304,
    ];
    let accumulators = [
        0,
        1,
        0xffff,
        0x10000,
        0x7fffffff,
        0x80000000,
        0xfffffffe,
        u32::MAX,
    ];
    let mut words: Vec<_> = halves
        .into_iter()
        .flat_map(|a| {
            bytes
                .into_iter()
                .flat_map(move |b| accumulators.map(|z| (a, b, z)))
        })
        .collect();
    for a in [0x00020001, 0x7fff8000, 0xffff0001] {
        for b in [0x807f01ff, 0x11223344] {
            let baseline = oracle(a, b, 123);
            let low_unchanged = oracle(a, b ^ 0xffff0000, 123);
            let high_unchanged = oracle(a, b ^ 0x0000ffff, 123);
            assert_eq!(
                [baseline[0], baseline[2]],
                [low_unchanged[0], low_unchanged[2]]
            );
            assert_eq!(
                [baseline[1], baseline[3]],
                [high_unchanged[1], high_unchanged[3]]
            );
            words.extend([
                (a, b, 123),
                (a, b ^ 0xffff0000, 123),
                (a, b ^ 0x0000ffff, 123),
            ]);
        }
    }
    for bit in 0..32 {
        let word = 1u32 << bit;
        words.extend([
            (word, !word, 0),
            (!word, word, u32::MAX),
            (word, word, !word),
            (!word, !word, word),
        ]);
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..128 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        words.push((
            random,
            random.rotate_left(11) ^ 0xa5a5_5a5a,
            random.rotate_left(23),
        ));
    }
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 4 + 48 + 4];
    for (row, (a, b, accumulator)) in words.into_iter().enumerate() {
        input.extend([a, b, accumulator]);
        expected[4 + row * 4..8 + row * 4].copy_from_slice(&oracle(a, b, accumulator));
    }
    for lane in 0..4 {
        let base = 4 + count * 4 + lane * 12;
        let selected = 13 + if lane & 1 == 0 { 3 } else { 0 };
        expected[base..base + 12].copy_from_slice(&[
            effect(1)[2],
            effect(4)[3],
            effect(7)[0],
            effect(10)[1],
            selected,
            selected + 3,
            oracle(input[1], input[2], input[3])[2],
            4,
            oracle(u32::MAX, u32::MAX, u32::MAX)[2],
            oracle(u32::MAX, u32::MAX, u32::MAX)[3],
            oracle(0x80008000, 0x80808080, 0x7fffffff)[0],
            oracle(0x80008000, 0x7f7f7f7f, 0x80000000)[1],
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/dp2a.cu");
    let captured = format!("__device__ unsigned __dp2a_lo(bool a, bool b, bool c) {{ return 7u; }}\n__device__ unsigned __dp2a_hi(bool a, bool b, bool c) {{ return 7u; }}\n{direct}");
    [
        (
            "direct DP2A selects matching halfword and byte lanes with wrapping accumulators",
            direct,
        ),
        (
            "captured DP2A selects matching halfword and byte lanes with wrapping accumulators",
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
