use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 8] = [3, -2, 0, 7, 5, -4, 2, 1];
    let mut expected = [SENTINEL; 72];
    for lane in 0..4 {
        let seed = INPUT[lane];
        let other = INPUT[lane + 4];
        let first = lane as u32 + 1 + if seed > 0 { 10 } else { 20 };
        let second = first + 1;
        let expression = second + 2 + if seed < other { 3 } else { 5 };
        let referenced = expression + 7;
        let selected = if seed > 0 {
            seed + 400
        } else if other > 0 {
            other + 500
        } else {
            other + 600
        };
        let nested = referenced + 9;
        let after_loop = nested + 4;
        let final_state = after_loop + 1;
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&[
            first,
            second,
            1,
            expression,
            if seed < other {
                (seed + 100) as u32
            } else {
                (other + 200) as u32
            },
            (seed + 300) as u32,
            referenced,
            selected as u32,
            50,
            (seed + 20) as u32,
            nested,
            after_loop,
            final_state,
            if seed > 0 { 101 } else { 201 },
            final_state,
            1,
        ]);
    }
    vec![module_case(
        "C++17 if initializers sequence once scope both branches and preserve references shadowing and loop exits",
        include_str!("../../../../../naga/tests/in/cuda/if-initializers.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&INPUT),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;72]),
    ],1,[1,1,1])]
}
