use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 8] = [3, -2, 0, 7, 5, -4, 2, 0];
    let mut expected = [SENTINEL; 60];
    for lane in 0..4 {
        let seed = INPUT[lane];
        let other = INPUT[lane + 4];
        let switched = match lane % 3 {
            0 => 10,
            1 => 50,
            _ => 30,
        };
        let after_loop = switched + 11;
        let nested = after_loop + if seed != 0 { 9 } else { 0 };
        expected[4 + lane * 13..17 + lane * 13].copy_from_slice(&[
            (seed + if seed != 0 { 100 } else { 200 }) as u32,
            1,
            (seed + if seed != 0 { 300 } else { 400 }) as u32,
            50,
            (other + if other > 0 { 500 } else { 600 }) as u32,
            switched,
            after_loop,
            if seed != 0 { (seed + 700) as u32 } else { 800 },
            nested,
            nested + 1,
            nested + 1 + u32::from(seed != 0),
            2,
            (if seed != 0 { seed + 1 } else { 3 } + 900) as u32,
        ]);
    }
    vec![module_case(
        "inferred scalar conditions deduce once preserve const semantics and scope branches and switch cases",
        include_str!("../../../../../naga/tests/in/cuda/inferred-selection-conditions.cu"),
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &INPUT,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 60],
            ),
        ],
        1,
        [2, 1, 1],
    )]
}
