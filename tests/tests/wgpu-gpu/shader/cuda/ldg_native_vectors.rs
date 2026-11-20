use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    let signed_words: Vec<[u32; 4]> = (0..32u32)
        .map(|index| {
            [
                0x7fff_ffff + index,
                0xffff_ffff - index,
                0x5555_0000 | index,
                0x8000_0001 - index,
            ]
        })
        .collect();
    let unsigned_words: Vec<[u32; 4]> = signed_words
        .iter()
        .map(|words| words.map(|word| word ^ 0x00ff_00ff))
        .collect();
    let signed_pairs: Vec<[u32; 2]> = signed_words.iter().map(|word| [word[0], word[1]]).collect();
    let unsigned_pairs: Vec<[u32; 2]> = unsigned_words
        .iter()
        .map(|word| [word[0], word[1]])
        .collect();
    let mut floats: Vec<[u32; 4]> = (0..32u32)
        .map(|index| {
            [
                (index as f32 + 0.5).to_bits(),
                (-(index as f32) - 10.25).to_bits(),
                (index as f32 + 100.75).to_bits(),
                (-(index as f32) - 1000.5).to_bits(),
            ]
        })
        .collect();
    floats[0] = [0, 0x8000_0000, 0x7f80_0000, 0xff80_0000];
    floats[1] = [0x7fc0_0000, 0x0080_0000, 0x3f80_0000, 0xbf80_0000];
    let mut expected = vec![SENTINEL; 32 * 44 + 8];
    for index in 0..32 {
        let reverse = 31 - index;
        let mut values = Vec::new();
        for (tag, direct, reversed) in [
            (
                1,
                signed_pairs[index].as_slice(),
                signed_pairs[reverse].as_slice(),
            ),
            (
                2,
                unsigned_pairs[index].as_slice(),
                unsigned_pairs[reverse].as_slice(),
            ),
            (
                3,
                signed_words[index].as_slice(),
                signed_words[reverse].as_slice(),
            ),
            (
                4,
                unsigned_words[index].as_slice(),
                unsigned_words[reverse].as_slice(),
            ),
            (5, floats[index].as_slice(), floats[reverse].as_slice()),
        ] {
            values.extend_from_slice(direct);
            values.extend_from_slice(reversed);
            values.extend([tag, index as u32 + 1]);
        }
        values.extend([
            u32::from((signed_words[index][0] as i32) < 0),
            u32::from((signed_words[index][3] as i32) < 0),
        ]);
        expected[4 + index * 44..48 + index * 44].copy_from_slice(&values);
    }
    vec![module_case(
        "native vector ldg preserves every component stride result type and once-only index",
        include_str!("../../../../../naga/tests/in/cuda/ldg-native-vectors.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &signed_pairs,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &unsigned_pairs,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Storage { read_only: true },
                &signed_words,
            ),
            ShaderBuffer::new(
                3,
                wgpu::BufferBindingType::Storage { read_only: true },
                &unsigned_words,
            ),
            ShaderBuffer::new(
                4,
                wgpu::BufferBindingType::Storage { read_only: true },
                &floats,
            ),
            ShaderBuffer::new(
                5,
                wgpu::BufferBindingType::Storage { read_only: false },
                &vec![SENTINEL; expected.len()],
            ),
        ],
        5,
        [9, 1, 1],
    )]
}
