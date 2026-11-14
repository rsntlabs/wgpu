use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32) -> [u32; 4] {
    let signed_sum = i64::from(a as i32) + i64::from(b as i32);
    let unsigned_sum = u64::from(a) + u64::from(b);
    [
        (signed_sum >> 1) as u32,
        ((signed_sum + 1) >> 1) as u32,
        (unsigned_sum >> 1) as u32,
        ((unsigned_sum + 1) >> 1) as u32,
    ]
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let boundaries = [
        0,
        1,
        2,
        0xffff,
        0x10000,
        0x7ffffffe,
        0x7fffffff,
        0x80000000,
        0x80000001,
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
    let count = words.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 4 + 40 + 4];
    for (row, (a, b)) in words.into_iter().enumerate() {
        input.extend([a, b]);
        expected[4 + row * 4..8 + row * 4].copy_from_slice(&oracle(a, b));
    }
    for lane in 0..4 {
        let base = 4 + count * 4 + lane * 10;
        let selected = 9 + if lane & 1 == 0 { 2 } else { 0 };
        expected[base..base + 10].copy_from_slice(&[
            oracle(3, 10)[0],
            oracle(9, 20)[1],
            oracle(15, 30)[2],
            oracle(21, 40)[3],
            selected,
            selected + 2,
            oracle(input[1], input[2])[2],
            3,
            u32::MAX,
            0,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/half-add.cu");
    let captured = format!(
        "__device__ int __hadd(bool a, bool b) {{ return 7; }}
         __device__ int __rhadd(bool a, bool b) {{ return 7; }}
         __device__ unsigned __uhadd(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __urhadd(bool a, bool b) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct half-add rounds exact mathematical sums and preserves effects",
            direct,
        ),
        (
            "captured half-add rounds exact mathematical sums and preserves effects",
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
