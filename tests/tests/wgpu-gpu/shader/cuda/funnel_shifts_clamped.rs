use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(lo: u32, hi: u32, count: u32) -> [u32; 2] {
    let pair = (u64::from(hi) << 32) | u64::from(lo);
    let shift = count.min(32);
    [((pair << shift) >> 32) as u32, (pair >> shift) as u32]
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let counts = [0, 1, 31, 32, 33, 63, 64, u32::MAX];
    let mut words = vec![(0x89ab_cdef, 0x1234_5678), (0, 0), (u32::MAX, u32::MAX)];
    for bit in 0..32 {
        let word = 1u32 << bit;
        words.extend([(word, 0), (0, word), (!word, word), (word, !word)]);
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..32 {
        random ^= random << 13;
        random ^= random >> 17;
        random ^= random << 5;
        words.push((random, random.rotate_left(11) ^ 0xa5a5_5a5a));
    }
    let count = words.len() * counts.len();
    let mut input = vec![count as u32];
    let mut expected = vec![SENTINEL; 4 + count * 2 + 24 + 4];
    for ((lo, hi), shifts) in words
        .into_iter()
        .flat_map(|words| counts.map(|shift| (words, shift)))
    {
        let row = (input.len() - 1) / 3;
        input.extend([lo, hi, shifts]);
        expected[4 + row * 2..6 + row * 2].copy_from_slice(&oracle(lo, hi, shifts));
    }
    for lane in 0..4 {
        let base = 4 + count * 2 + lane * 6;
        let selected = 7 + if lane & 1 == 0 { 3 } else { 0 };
        expected[base..base + 6].copy_from_slice(&[
            oracle(1, 2, 3)[0],
            oracle(4, 5, 6)[1],
            selected,
            selected + 3,
            oracle(input[1], input[2], input[3])[0],
            4,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/funnel-shifts-clamped.cu");
    let captured = format!(
        "__device__ unsigned __funnelshift_lc(bool a, bool b, bool c) {{ return 99u; }}
         __device__ unsigned __funnelshift_rc(bool a, bool b, bool c) {{ return 99u; }}
         {direct}"
    );
    [
        (
            "direct clamped funnel shifts preserve boundary counts and ordered effects",
            direct,
        ),
        (
            "captured clamped funnel shifts preserve boundary counts and ordered effects",
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
