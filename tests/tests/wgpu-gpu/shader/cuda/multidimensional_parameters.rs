use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 12] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    let mut expected = [SENTINEL; 80];
    for lane in 0..4 {
        let first = INPUT[lane * 3] as u32;
        let second = INPUT[lane * 3 + 1] as u32;
        let third = INPUT[lane * 3 + 2] as u32;
        expected[lane * 20 + 4..lane * 20 + 16].copy_from_slice(&[
            first,
            second,
            third,
            first + 6,
            first + 6 + second,
            7,
            1,
            13,
            13,
            7 + second,
            2,
            7 + second,
        ]);
    }
    vec![module_case(
        "ordinary multidimensional parameters preserve row ABI ignored outer bounds rank aliasing and supplied effects",
        include_str!("../../../../../naga/tests/in/cuda/multidimensional-parameters.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&INPUT),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;80]),
    ],1,[1,1,1])]
}
