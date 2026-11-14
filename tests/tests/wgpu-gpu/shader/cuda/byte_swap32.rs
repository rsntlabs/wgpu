use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut words = vec![
        0,
        u32::MAX,
        0x01020304,
        0x80ff017f,
        0x80000000,
        0x7fffffff,
        0xffff0000,
        0x0000ffff,
    ];
    for position in 0..4 {
        for byte in 0u32..=255 {
            words.push(byte << (position * 8));
        }
    }
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
    let mut expected = vec![SENTINEL; 4 + count * 2 + 40 + 4];
    for (row, value) in words.into_iter().enumerate() {
        input.push(value);
        expected[4 + row * 2..6 + row * 2].copy_from_slice(&[value.swap_bytes(), value]);
    }
    for lane in 0..4 {
        let base = 4 + count * 2 + lane * 10;
        let initial = 0x01020304 + lane as u32;
        let selected = initial + 2 + if lane & 1 == 0 { 1 } else { 0 };
        expected[base..base + 10].copy_from_slice(&[
            initial.swap_bytes(),
            (initial + 1).swap_bytes(),
            initial + 2,
            selected,
            selected + 1,
            input[1].swap_bytes(),
            2,
            1,
            u32::MAX,
            selected + 1,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/byte-swap32.cu");
    let captured =
        format!("__device__ unsigned __nv_bswap32(bool value) {{ return 7u; }}\n{direct}");
    [
        (
            "direct byte swap reverses every byte value and preserves single evaluation",
            direct,
        ),
        (
            "captured byte swap reverses every byte value and preserves single evaluation",
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
