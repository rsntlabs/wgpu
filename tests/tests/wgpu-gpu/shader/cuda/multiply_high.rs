use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32) -> [u32; 2] {
    [
        ((u64::from(a) * u64::from(b)) >> 32) as u32,
        ((i64::from(a as i32) * i64::from(b as i32)) >> 32) as u32,
    ]
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let boundaries = [
        0,
        1,
        2,
        0xffff,
        0x10000,
        0xffff0000,
        0x7fff0001,
        0x7fffffff,
        0x80000000,
        0xfffffffe,
        u32::MAX,
    ];
    let mut words: Vec<_> = boundaries
        .into_iter()
        .flat_map(|a| boundaries.map(|b| (a, b)))
        .collect();
    for bit in 0..32 {
        let word = 1u32 << bit;
        words.extend([(word, word), (!word, word), (word, !word), (!word, !word)]);
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..128 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        words.push((random, random.rotate_left(11) ^ 0xa5a5_5a5a));
    }
    words.push((u32::MAX, 2147418113));
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 2 + 40 + 4];
    for (row, (a, b)) in words.into_iter().enumerate() {
        input.extend([a, b]);
        expected[4 + row * 2..6 + row * 2].copy_from_slice(&oracle(a, b));
    }
    for lane in 0..4 {
        let base = 4 + count * 2 + lane * 10;
        let selected = 5 + if lane & 1 == 0 { 2 } else { 0 };
        expected[base..base + 10].copy_from_slice(&[
            oracle(0x40000001, 2u32.wrapping_mul(0x20000003))[0],
            oracle(3u32.wrapping_mul(0x40000001), 4u32.wrapping_mul(0x20000003))[1],
            selected,
            selected + 2,
            oracle(input[1], input[2])[0],
            3,
            u32::MAX,
            0x40000000,
            0xfffffffe,
            1,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/multiply-high.cu");
    let captured = format!(
        "__device__ int __mulhi(bool a, bool b) {{ return 7; }}
         __device__ unsigned __umulhi(bool a, bool b) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct multiply-high preserves arithmetic boundaries and ordered effects",
            direct,
        ),
        (
            "captured multiply-high preserves arithmetic boundaries and ordered effects",
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
