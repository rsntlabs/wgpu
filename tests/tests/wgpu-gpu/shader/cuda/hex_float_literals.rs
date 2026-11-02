use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/hex-float-literals.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let initial = [SENTINEL; 48];
    let mut expected = initial;
    expected[..40].copy_from_slice(&[
        0x0000_0000,
        0x8000_0000,
        0x3f80_0000,
        0x4000_0000,
        0x3f80_0000,
        0x3f00_0000,
        0x4040_0000,
        0xc0a0_0000,
        0x0080_0000,
        0x0000_0001,
        0x007f_ffff,
        0x0080_0000,
        0x0000_0000,
        0x8000_0000,
        0x0000_0001,
        0x0000_0000,
        0x0000_0002,
        0x0000_0002,
        0x0000_0004,
        0x3f80_0000,
        0x3f80_0002,
        0x3f80_0001,
        0x3f80_0000,
        0x7f7f_ffff,
        0xff7f_ffff,
        0x7f7f_fffe,
        0x7f7f_ffff,
        0x0000_0001,
        0x8000_0001,
        0x0000_0000,
        0x4291_a000,
        0x3e80_0000,
        0x40c0_0000,
        0x4080_0000,
        0x3f40_0000,
        0x4110_0000,
        0x4040_0000,
        0x3f40_0000,
        0x0000_0000,
        0x0000_0001,
    ]);
    vec![module_case(
        "hexadecimal float literals preserve exact rounded bits subnormals signed zeros macros and effects",
        FIXTURE,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    )]
}
