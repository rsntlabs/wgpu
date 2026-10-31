use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/pointer-aliases.cu");
const SENTINEL: u32 = 0xdead_beef;

fn kernel_case(name: &str, source: &str, initial: &[u32; 32], expected: &[u32; 32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            initial,
        )],
        0,
        [1, 1, 1],
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![values_and_aliases(), packed_vectors()];
    tests.extend(selected_origins());
    tests
}

fn values_and_aliases() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[20] = 7;
    let mut expected = initial;
    expected[..15].copy_from_slice(&[2, 3, 7, 3, 2, 7, 8, 13, 13, 17, 25, 3, 7, 7, 3]);
    expected[20] = 10;
    kernel_case(
        "pointer aliases preserve mixed typedefs, object const, auto copies, captured indices and helper signatures",
        FIXTURE,
        &initial,
        &expected,
    )
}

fn selected_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in 0..3 {
        let mut initial = [SENTINEL; 32];
        initial[15] = choose;
        initial[24] = 11;
        initial[25] = 13;
        let mut expected = initial;
        let values = match choose {
            0 => [11, 22, 15, 3, 3, 5, 7, 1, 3],
            1 => [5, 16, 9, 3, 3, 16, 9, 1, 3],
            2 => [3, 14, 5, 14, 5, 5, 7, 1, 14],
            _ => unreachable!(),
        };
        expected[..9].copy_from_slice(&values);
        if choose == 0 {
            expected[24] = 22;
            expected[25] = 15;
        }
        tests.push(kernel_case(
            &format!("pointer aliases keep captured coordinates and selected private, shared or storage origin {choose}"),
            "using Pointer = int *;
            __device__ int update(Pointer destination) {
                int previous = *destination; *destination += 10; return previous;
            }
            __global__ void kernel(Pointer output) {
                __shared__ int shared_values[2]; shared_values[0] = 5; shared_values[1] = 7;
                int private_values[2]{2, 3}; int index = 0;
                Pointer captured = &private_values[index++]; index = 1; ++*captured;
                Pointer selected = private_values;
                selected = output[15] == 0 ? output + 24 : output[15] == 1 ? shared_values : private_values;
                Pointer saved = selected++;
                int previous = update(saved); int &live = *saved; ++live; *selected += 2;
                output[0] = previous; output[1] = *saved; output[2] = *selected;
                output[3] = private_values[0]; output[4] = private_values[1];
                output[5] = shared_values[0]; output[6] = shared_values[1];
                output[7] = index; output[8] = *captured;
            }",
            &initial,
            &expected,
        ));
    }
    tests
}

fn packed_vectors() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..9].copy_from_slice(&[1, 2, 3, 5, 7, 11, 13, 17, 19]);
    let mut expected = initial;
    expected[..9].copy_from_slice(&[1, 2, 3, 5, 7, 21, 5, 7, 21]);
    kernel_case(
        "int3 pointer aliases preserve 12 byte storage stride, pointer updates and whole vector copies",
        "using PackedPointer = int3 *; using FixedPacked = PackedPointer const;
        __device__ void add(PackedPointer value) { (*value).z += 10; }
        __global__ void kernel(PackedPointer records) {
            PackedPointer cursor = records; ++cursor;
            FixedPacked saved = cursor++; add(saved);
            auto destination = cursor; *destination = *saved;
        }",
        &initial,
        &expected,
    )
}
