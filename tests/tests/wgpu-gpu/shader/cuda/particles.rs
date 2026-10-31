use super::{module_case, ShaderBuffer, ShaderTest};

const SOURCE: &str = include_str!("../../../../../naga/tests/in/cuda/particles.cu");
const SENTINEL: u32 = 0xdead_beef;
const WORKGROUP_WIDTH: u32 = 64;
// Allow f32 rounding through range reduction and the polynomial; guards stay exact.
const ABSOLUTE_TOLERANCE: f32 = 2.0e-5;

fn reference_point(index: u32, count: u32, time: f32) -> [f32; 4] {
    let grid_side = (count as f32).sqrt() as u32;
    let horizontal = (index % grid_side) as f32 / grid_side as f32 * 2.0 - 1.0;
    let vertical = (index / grid_side) as f32 / grid_side as f32 * 2.0 - 1.0;
    let radius = (horizontal * horizontal + vertical * vertical).sqrt();
    let phase = radius * 14.0 - time * 2.0;
    let period = core::f32::consts::TAU;
    let reduced = phase - (phase / period + 0.5).floor() * period;
    let parabola = 1.2732395_f32 * reduced - 0.4052847_f32 * reduced * reduced.abs();
    let wave = parabola + 0.225 * (parabola * parabola.abs() - parabola);
    [
        horizontal * 0.84,
        vertical * 0.72 + wave * 0.13,
        radius * 0.65,
        0.3 + (wave + 1.0) * 0.25,
    ]
}

fn compare_points(name: &str, actual: &[u32], expected: &[Vec<u32>]) -> bool {
    let [expected] = expected else {
        panic!("{name}: expected one reference buffer")
    };
    if actual.len() != expected.len() {
        eprintln!(
            "{name}: output length {}, expected {}",
            actual.len(),
            expected.len()
        );
        return false;
    }
    for (index, (&actual_bits, &expected_bits)) in actual.iter().zip(expected).enumerate() {
        let actual = f32::from_bits(actual_bits);
        let expected = f32::from_bits(expected_bits);
        let valid = if expected_bits == SENTINEL {
            actual_bits == SENTINEL
        } else {
            actual.is_finite()
                && expected.is_finite()
                && (actual - expected).abs() <= ABSOLUTE_TOLERANCE
        };
        if !valid {
            eprintln!("{name}: word {index}: received {actual_bits:08x} ({actual}), expected {expected_bits:08x} ({expected}), absolute tolerance {ABSOLUTE_TOLERANCE}");
            return false;
        }
    }
    true
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for count in [64_u32, 65] {
        for time in [0.0_f32, -0.75, 1.25] {
            let workgroups = count.div_ceil(WORKGROUP_WIDTH) + 1;
            let point_count = (workgroups * WORKGROUP_WIDTH + 3) as usize;
            let initial = vec![SENTINEL; point_count * 4];
            let mut expected = initial.clone();
            for index in 0..count {
                let offset = index as usize * 4;
                expected[offset..offset + 4]
                    .copy_from_slice(&reference_point(index, count, time).map(f32::to_bits));
            }
            let parameters = [
                time.to_bits(),
                (count as f32).to_bits(),
                0x0123_4567,
                0x89ab_cdef,
                0x1357_9bdf,
                0x2468_ace0,
                0x55aa_cc33,
                0xa55a_33cc,
            ];
            let mut test = module_case(
                &format!("unchanged particles count {count} time {time}"),
                SOURCE,
                [WORKGROUP_WIDTH, 1, 1],
                &expected,
            )
            .module_buffers(
                vec![
                    ShaderBuffer::new(
                        0,
                        wgpu::BufferBindingType::Storage { read_only: false },
                        &initial,
                    ),
                    ShaderBuffer::new(
                        1,
                        wgpu::BufferBindingType::Storage { read_only: true },
                        &parameters,
                    ),
                ],
                0,
                [workgroups, 1, 1],
            );
            test.output_comparison_fn = compare_points;
            tests.push(test);
        }
    }
    tests
}
