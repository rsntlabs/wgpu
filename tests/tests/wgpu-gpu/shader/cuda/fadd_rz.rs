use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

fn directed_sum(first: u32, second: u32, upward: bool) -> u32 {
    let x = f64::from(f32::from_bits(first));
    let y = f64::from(f32::from_bits(second));
    let sum = x + y;
    if sum.is_nan() {
        return 0x7fc0_0000;
    }
    if sum.is_infinite() {
        return (sum as f32).to_bits();
    }
    let recovered_y = sum - x;
    let error = (x - (sum - recovered_y)) + (y - recovered_y);
    if sum == 0.0 && error == 0.0 {
        if first & 0x7fff_ffff == 0 && second & 0x7fff_ffff == 0 && (first ^ second) >> 31 == 0 {
            return first;
        }
        return if upward { 0 } else { 0x8000_0000 };
    }
    let nearest = sum as f32;
    let difference = f64::from(nearest) - sum;
    let above = difference > 0.0 || (difference == 0.0 && error < 0.0);
    let below = difference < 0.0 || (difference == 0.0 && error > 0.0);
    if upward && below {
        nearest.next_up().to_bits()
    } else if !upward && above {
        nearest.next_down().to_bits()
    } else {
        nearest.to_bits()
    }
}

pub(super) fn cases() -> Vec<ShaderTest> {
    assert_eq!(directed_sum(0x3f80_0000, 0x8000_0001, false), 0x3f7f_ffff);
    assert_eq!(directed_sum(0x3f80_0000, 1, true), 0x3f80_0001);
    assert_eq!(directed_sum(0x3f80_0000, 0xbf80_0000, false), 0x8000_0000);
    assert_eq!(directed_sum(0x3f80_0000, 0xbf80_0000, true), 0);
    assert_eq!(directed_sum(0, 0, false), 0);
    let mut input = Vec::new();
    let mut expected = vec![SENTINEL; 4];
    for line in include_str!("fadd-rz-values.csv")
        .lines()
        .filter(|line| !line.starts_with('#'))
    {
        let words: Vec<_> = line
            .split(',')
            .map(|word| u32::from_str_radix(word, 16).unwrap())
            .collect();
        let [first, second, toward_zero, nearest] = words[..] else {
            panic!("expected input,input,exact RZ,exact RN");
        };
        // RZ uses the bigint oracle; host RN would lose tiny subtraction bits.
        let host = (f32::from_bits(first) + f32::from_bits(second)).to_bits();
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
            0x8000_0000,
            0,
            0x4040_0000,
            7,
            toward_zero,
            nearest,
            directed_sum(first, second, false),
            2,
            directed_sum(first, second, true),
            2,
            directed_sum(first, second ^ 0x8000_0000, false),
            2,
            directed_sum(first, second ^ 0x8000_0000, true),
            2,
        ]);
    }
    assert_eq!(input.len(), 8192);
    expected.extend_from_slice(&[SENTINEL; 4]);
    let initial = vec![SENTINEL; expected.len()];
    vec![module_case(
        "directed add and subtract preserve exact tiny tails signed cancellation zeros and finite overflow",
        include_str!("../../../../../naga/tests/in/cuda/fadd-rz.cu"), [32,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&input),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&initial),
    ],1,[129,1,1])]
}
