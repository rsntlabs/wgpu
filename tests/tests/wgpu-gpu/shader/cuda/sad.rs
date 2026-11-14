use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32, accumulator: u32) -> [u32; 2] {
    let signed_difference = (i64::from(a as i32) - i64::from(b as i32)).unsigned_abs();
    let unsigned_difference = u64::from(a).abs_diff(u64::from(b));
    [
        (signed_difference + u64::from(accumulator)) as u32,
        (unsigned_difference + u64::from(accumulator)) as u32,
    ]
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let boundaries = [
        0,
        1,
        2,
        0xffff,
        0x10000,
        0x7fffffff,
        0x80000000,
        0x80000001,
        0xfffffffe,
        u32::MAX,
    ];
    let accumulators = [0, 1, 2, 0xffff, 0x10000, 0x7fffffff, 0x80000000, u32::MAX];
    let mut words: Vec<_> = boundaries
        .into_iter()
        .flat_map(|a| {
            boundaries
                .into_iter()
                .flat_map(move |b| accumulators.map(|z| (a, b, z)))
        })
        .collect();
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
    let mut expected = vec![SENTINEL; 4 + count * 2 + 40 + 4];
    for (row, (a, b, accumulator)) in words.into_iter().enumerate() {
        input.extend([a, b, accumulator]);
        expected[4 + row * 2..6 + row * 2].copy_from_slice(&oracle(a, b, accumulator));
    }
    for lane in 0..4 {
        let base = 4 + count * 2 + lane * 10;
        let selected = 7 + if lane & 1 == 0 { 3 } else { 0 };
        expected[base..base + 10].copy_from_slice(&[
            oracle(3, 10, 0u32.wrapping_sub(21))[0],
            oracle(12, 25, 0u32.wrapping_sub(42))[1],
            selected,
            selected + 3,
            oracle(input[1], input[2], input[3])[1],
            4,
            0,
            0,
            0xfffffffe,
            1,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/sad.cu");
    let captured = format!(
        "__device__ unsigned __sad(bool a, bool b, bool c) {{ return 7u; }}
         __device__ unsigned __usad(bool a, bool b, bool c) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct SAD computes exact differences and wrapping accumulators with ordered effects",
            direct,
        ),
        (
            "captured SAD computes exact differences and wrapping accumulators with ordered effects",
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
