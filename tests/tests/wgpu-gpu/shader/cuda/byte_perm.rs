use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(x: u32, y: u32, selector: u32) -> u32 {
    let mut bytes = [0u8; 8];
    bytes[..4].copy_from_slice(&x.to_le_bytes());
    bytes[4..].copy_from_slice(&y.to_le_bytes());
    let selected = core::array::from_fn(|index| bytes[((selector >> (4 * index)) & 7) as usize]);
    u32::from_le_bytes(selected)
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut words: Vec<_> = (0..=u16::MAX)
        .map(|selector| (0x80ff017f, 0xfe028100, u32::from(selector)))
        .collect();
    for (x, y) in [
        (0, u32::MAX),
        (u32::MAX, 0),
        (0x01234567, 0x89abcdef),
        (0x80808080, 0x7f7f7f7f),
    ] {
        for selector in [
            0,
            0x3210,
            0xba98,
            0x7654,
            0xfedc,
            0x8888,
            0xffff,
            0xffff0000,
            0x98765432,
            u32::MAX,
        ] {
            words.push((x, y, selector));
        }
    }
    let mut random = 0x1234_5678u32;
    for _ in 0..256 {
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
    let mut expected = vec![SENTINEL; 4 + count + 640 + 4];
    for (row, (x, y, selector)) in words.into_iter().enumerate() {
        input.extend([x, y, selector]);
        expected[4 + row] = oracle(x, y, selector);
    }
    for lane in 0..64 {
        let base = 4 + count + lane * 10;
        let selected = 4 + if lane & 1 == 0 { 3 } else { 0 };
        expected[base..base + 10].copy_from_slice(&[
            oracle(
                0x01020304 ^ 0x80ff017f,
                (2 * 0x03050709) ^ 0xfe028100,
                (3 * 0x102) ^ 0x7536,
            ),
            selected,
            selected + 3,
            oracle(input[1], input[2], input[3]),
            4,
            oracle(0x80ff017f, 0xfe028100, 0xffff),
            0,
            0xfe028100,
            0xfefefefe,
            u32::MAX,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/byte-perm.cu");
    let captured = format!(
        "__device__ unsigned __byte_perm(bool x, bool y, bool selector) {{ return 7u; }}\n{direct}"
    );
    [
        (
            "direct byte permutation covers every selector and ordered effects",
            direct,
        ),
        (
            "captured byte permutation covers every selector and ordered effects",
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
