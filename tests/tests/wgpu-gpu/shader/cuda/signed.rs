use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/signed.cu");
const SENTINEL: i32 = -101;

fn kernel_case(name: &str, source: &str, leading: &[i32], input: Option<&[i32]>) -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..leading.len()].copy_from_slice(leading);
    let mut buffers = vec![ShaderBuffer::new(
        0,
        wgpu::BufferBindingType::Storage { read_only: false },
        &initial,
    )];
    if let Some(input) = input {
        buffers.push(ShaderBuffer::new(
            1,
            wgpu::BufferBindingType::Storage { read_only: true },
            input,
        ));
    }
    module_case(name, source, [1, 1, 1], &expected).module_buffers(buffers, 0, [1, 1, 1])
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        kernel_case(
            "signed spellings preserve aliases fields restricted buffers and scalar casts",
            FIXTURE,
            &[-4, 3, -3, 0, -2, 3],
            Some(&[-7, 5, 11, 13]),
        ),
        kernel_case(
            "signed arithmetic and comparison retain int promotion and unsigned overload selection",
            "__device__ signed rank(signed value) { return 3; }
            __device__ signed rank(unsigned value) { return 7; }
            __global__ void kernel(int signed *output) {
                signed negative = -7;
                unsigned positive = 3u;
                output[0] = negative + 2;
                output[1] = negative / 2;
                output[2] = negative % 3;
                output[3] = negative < positive;
                output[4] = negative < signed(positive);
                output[5] = signed(negative + positive);
                output[6] = negative >> 1;
                output[7] = rank(signed(-1));
                output[8] = rank(1u);
            }",
            &[-5, -3, -1, 0, 1, -4, -4, 3, 7],
            None,
        ),
        kernel_case(
            "signed spellings preserve existing 32-bit integer boundaries",
            "__global__ void kernel(signed int *output) {
                signed maximum = 2147483647;
                int signed minimum = -2147483647 - 1;
                signed int bits = 0xffffffff;
                output[0] = maximum;
                output[1] = minimum;
                output[2] = bits;
            }",
            &[i32::MAX, i32::MIN, -1],
            None,
        ),
    ]
}
