use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

fn oracle(a: u32, b: u32) -> [u32; 8] {
    let a = a.to_le_bytes();
    let b = b.to_le_bytes();
    let mut cmp_eq2 = [0u8; 4];
    let mut cmp_ne2 = [0u8; 4];
    let mut set_eq2 = [0u8; 4];
    let mut set_ne2 = [0u8; 4];
    for lane in 0..2 {
        let offset = lane * 2;
        let equal = u16::from_le_bytes([a[offset], a[offset + 1]])
            == u16::from_le_bytes([b[offset], b[offset + 1]]);
        cmp_eq2[offset..offset + 2]
            .copy_from_slice(&(if equal { u16::MAX } else { 0 }).to_le_bytes());
        cmp_ne2[offset..offset + 2]
            .copy_from_slice(&(if equal { 0 } else { u16::MAX }).to_le_bytes());
        set_eq2[offset..offset + 2].copy_from_slice(&u16::from(equal).to_le_bytes());
        set_ne2[offset..offset + 2].copy_from_slice(&u16::from(!equal).to_le_bytes());
    }
    let cmp_eq4 = core::array::from_fn(|lane| if a[lane] == b[lane] { u8::MAX } else { 0 });
    let cmp_ne4 = core::array::from_fn(|lane| if a[lane] != b[lane] { u8::MAX } else { 0 });
    let set_eq4 = core::array::from_fn(|lane| u8::from(a[lane] == b[lane]));
    let set_ne4 = core::array::from_fn(|lane| u8::from(a[lane] != b[lane]));
    [
        u32::from_le_bytes(cmp_eq2),
        u32::from_le_bytes(cmp_eq4),
        u32::from_le_bytes(cmp_ne2),
        u32::from_le_bytes(cmp_ne4),
        u32::from_le_bytes(set_eq2),
        u32::from_le_bytes(set_eq4),
        u32::from_le_bytes(set_ne2),
        u32::from_le_bytes(set_ne4),
    ]
}

fn effect(start: u32) -> [u32; 8] {
    let word = start * 0x01010101;
    oracle(word, word)
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
    let original = 0x80ff017fu32;
    for lane in 0..4 {
        let mut only_match = (!original).to_le_bytes();
        only_match[lane] = original.to_le_bytes()[lane];
        let mut only_mismatch = original.to_le_bytes();
        only_mismatch[lane] ^= 1;
        for other in [
            u32::from_le_bytes(only_match),
            u32::from_le_bytes(only_mismatch),
        ] {
            words.extend([(original, other), (other, original)]);
        }
    }
    for lane in 0..2 {
        let offset = lane * 2;
        let mut only_match = (!original).to_le_bytes();
        only_match[offset..offset + 2].copy_from_slice(&original.to_le_bytes()[offset..offset + 2]);
        let mut only_mismatch = original.to_le_bytes();
        only_mismatch[offset] ^= 1;
        for other in [
            u32::from_le_bytes(only_match),
            u32::from_le_bytes(only_mismatch),
        ] {
            words.extend([(original, other), (other, original)]);
        }
    }
    words.extend([
        (0, 0),
        (u32::MAX, u32::MAX),
        (0, u32::MAX),
        (u32::MAX, 0),
        (0x12345678, 0x1234abcd),
        (0x1234abcd, 0x12345678),
        (0x807f3302, 0x7f803301),
        (0x7f803301, 0x807f3302),
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
            0,
            selected,
            selected + 2,
            oracle(input[1], input[2])[5],
            3,
            u32::MAX,
            u32::MAX,
            0,
            0,
            0x00010001,
            0x01010101,
            0,
            0,
            0xffff0000,
            0x0000ffff,
            0x00010000,
            0x00000001,
            0x00000100,
            0x01010001,
        ]);
    }
    let direct = include_str!("../../../../../naga/tests/in/cuda/packed-equality.cu");
    let captured = format!(
        "__device__ unsigned __vcmpeq2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vcmpeq4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vcmpne2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vcmpne4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vseteq2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vseteq4(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vsetne2(bool a, bool b) {{ return 7u; }}
         __device__ unsigned __vsetne4(bool a, bool b) {{ return 7u; }}
         {direct}"
    );
    [
        (
            "direct packed equality preserves per-lane masks and one-bit Boolean results",
            direct,
        ),
        (
            "captured packed equality preserves per-lane masks and one-bit Boolean results",
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
