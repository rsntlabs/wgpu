use super::{module_case, ShaderBuffer, ShaderTest};
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    const INPUT: [i32; 5] = [7, 11, 13, 17, 19];
    let mut expected = [SENTINEL; 72];
    for lane in 0..4 {
        let seed = INPUT[lane] as u32;
        expected[4 + lane * 16..20 + lane * 16].copy_from_slice(&[
            seed + 5,
            INPUT[lane + 1] as u32,
            1,
            seed + 7,
            5,
            12,
            seed + 5,
            20,
            24,
            9,
            8,
            3,
            24,
            9,
            16,
            6,
        ]);
    }
    vec![module_case(
        "named pointer and array decltype preserves cv aliasing source shapes and exactly once initializers",
        include_str!("../../../../../naga/tests/in/cuda/decltype-pointer-arrays.cu"), [4,1,1], &expected,
    ).module_buffers(vec![
        ShaderBuffer::new(0,wgpu::BufferBindingType::Storage { read_only:true },&INPUT),
        ShaderBuffer::new(1,wgpu::BufferBindingType::Storage { read_only:false },&[SENTINEL;72]),
    ],1,[1,1,1])]
}
