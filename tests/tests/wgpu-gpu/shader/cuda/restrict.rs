use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/restrict.cu");
const SENTINEL: i32 = -101;

fn kernel_case(name: &str, source: &str, leading: &[i32], with_other_input: bool) -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..leading.len()].copy_from_slice(leading);
    let mut input = [SENTINEL; 32];
    input[..4].copy_from_slice(&[2, 3, 5, 7]);
    let mut other = [SENTINEL; 32];
    other[..3].copy_from_slice(&[11, 13, 17]);
    let mut buffers = vec![
        ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        ),
        ShaderBuffer::new(
            1,
            wgpu::BufferBindingType::Storage { read_only: true },
            &input,
        ),
    ];
    if with_other_input {
        buffers.push(ShaderBuffer::new(
            2,
            wgpu::BufferBindingType::Storage { read_only: true },
            &other,
        ));
    }
    module_case(name, source, [1, 1, 1], &expected).module_buffers(buffers, 0, [1, 1, 1])
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        kernel_case(
            "restrict kernel and helper parameters preserve distinct input and output buffers",
            FIXTURE,
            &[5, 5],
            false,
        ),
        kernel_case(
            "initialized restricted local pointer can change between readonly origins",
            "__global__ void kernel(int *output, const int *input, const int *other) {
                const int *__restrict__ selected = input;
                output[0] = selected[1];
                selected = other;
                output[1] = selected[0];
                output[2] = selected[1];
            }",
            &[3, 11, 13],
            true,
        ),
        kernel_case(
            "bare restricted local pointer is assigned before accessing distinct readonly origins",
            "__global__ void kernel(int *output, const int *input, const int *other) {
                const int *__restrict selected;
                selected = input + 2;
                output[0] = *selected;
                selected = other + 1;
                output[1] = *selected;
            }",
            &[5, 13],
            true,
        ),
    ]
}
