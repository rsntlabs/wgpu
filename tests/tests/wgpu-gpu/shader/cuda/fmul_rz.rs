use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

fn directed_product(first: u32, second: u32, upward: bool) -> u32 {
    let exact = f64::from(f32::from_bits(first)) * f64::from(f32::from_bits(second));
    if exact.is_nan() {
        return 0x7fc0_0000;
    }
    let nearest = exact as f32;
    if upward && f64::from(nearest) < exact {
        nearest.next_up().to_bits()
    } else if !upward && f64::from(nearest) > exact {
        nearest.next_down().to_bits()
    } else {
        nearest.to_bits()
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    let rows: Vec<Vec<u32>> = include_str!("fmul-rz-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
        .map(|line| {
            line.split(',')
                .map(|word| u32::from_str_radix(word, 16).unwrap())
                .collect()
        })
        .collect();
    assert!(rows
        .iter()
        .enumerate()
        .any(|(index, row)| row[3] != rows[index ^ 1][3]));
    for (index, words) in rows.iter().enumerate() {
        let [first, second, toward_zero, nearest] = words[..] else {
            panic!("expected input,input,exact bigint oracle");
        };
        let host = (f32::from_bits(first) * f32::from_bits(second)).to_bits();
        assert_eq!(
            nearest,
            if host & 0x7fff_ffff > 0x7f80_0000 {
                0x7fc0_0000
            } else {
                host
            }
        );
        input.extend_from_slice(&[first, second]);
        expected.extend_from_slice(&[
            toward_zero,
            toward_zero,
            toward_zero,
            2,
            0,
            0x8000_0000,
            0x40c0_0000,
            7,
            toward_zero,
            nearest,
            directed_product(first, second, false),
            2,
            directed_product(first, second, true),
            2,
            nearest,
            rows[index ^ 1][3],
            2,
            toward_zero,
            rows[index ^ 1][2],
            2,
            directed_product(first, second, false),
            directed_product(rows[index ^ 1][0], rows[index ^ 1][1], false),
            2,
            directed_product(first, second, true),
            directed_product(rows[index ^ 1][0], rows[index ^ 1][1], true),
            2,
        ]);
    }
    assert_eq!(input.len(), 8192);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "directed multiply exact bigint references preserve zero signs truncation overflow and order and sequenced wrappers",
        include_str!("../../../../../naga/tests/in/cuda/fmul-rz.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
