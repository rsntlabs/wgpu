use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/uninitialized-pointers.cu");
const SENTINEL: i32 = -101;

fn kernel_case(name: &str, source: &str, initial: &[i32], expected: &[i32]) -> ShaderTest {
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
    let mut initial = [SENTINEL; 32];
    initial[8] = 80;
    let mut tests = Vec::new();
    for (name, source, leading) in [
        (
            "uninitialized pointer objects receive values before use",
            FIXTURE,
            &[3, 13, 13][..],
        ),
        (
            "uninitialized pointer assignment selects function workgroup and storage origins",
            "__global__ void kernel(int *out) {
                int value = 17;
                int local[2]{2, 3};
                __shared__ int shared[2];
                shared[0] = 11; shared[1] = 13;
                int *selected;
                selected = &value; out[0] = *selected;
                selected = local + 1; out[1] = *selected;
                selected = shared + 1; out[2] = *selected;
                selected = out + 8; out[3] = *selected;
                const int *view;
                view = selected; out[4] = *view;
            }",
            &[17, 3, 13, 80, 80][..],
        ),
        (
            "uninitialized pointer assignments capture dynamic ancestors and saved copies",
            "struct Record { int samples[2]; int marker; };
            __global__ void kernel(int *out) {
                Record records[2]{{{2, 3}, 5}, {{7, 11}, 13}};
                unsigned row = 0, column = 1;
                int *selected;
                selected = &records[row].samples[column];
                int *saved;
                saved = selected;
                row = 1; column = 0;
                selected = &records[row].samples[column];
                *selected += 10;
                out[0] = *saved; out[1] = *selected;
                out[2] = records[0].samples[1]; out[3] = records[1].samples[0];
            }",
            &[3, 17, 3, 17][..],
        ),
        (
            "uninitialized pointer objects are assigned during every loop iteration",
            "__global__ void kernel(int *out) {
                int first[3]{2, 3, 5}, second[3]{7, 11, 13};
                for (int iteration = 0; iteration < 3; ++iteration) {
                    int *selected;
                    if (iteration % 2 == 0) selected = first + iteration;
                    else selected = second + iteration;
                    out[iteration] = *selected;
                }
                int slot = 0;
                for (int *cursor; slot < 3; ++slot) {
                    cursor = first + slot;
                    out[3 + slot] = *cursor;
                }
            }",
            &[2, 11, 5, 2, 3, 5][..],
        ),
        (
            "uninitialized helper pointers receive fresh values on reentry",
            "__device__ int read(const int *values, unsigned index, bool advance) {
                const int *selected;
                selected = values + index;
                if (advance) ++selected;
                return *selected;
            }
            __global__ void kernel(int *out) {
                int first[3]{2, 3, 5}, second[3]{7, 11, 13};
                out[0] = read(first, 0, true);
                out[1] = read(second, 1, true);
                out[2] = read(first, 2, false);
            }",
            &[3, 13, 5][..],
        ),
        (
            "uninitialized pointer names bind mixed declarators and shadowed scopes",
            "__global__ void kernel(int *out) {
                int values[3]{2, 3, 5};
                int *selected, scalar = 7, *saved = (selected = values + 1);
                out[0] = *selected; out[1] = *saved;
                { int *selected; selected = values; out[2] = *selected; }
                selected = values + 2;
                out[3] = *selected; out[4] = scalar;
            }",
            &[3, 3, 2, 5, 7][..],
        ),
    ] {
        let mut expected = initial;
        expected[..leading.len()].copy_from_slice(leading);
        tests.push(kernel_case(name, source, &initial, &expected));
    }
    for choose in [0, 1] {
        let mut branch_initial = initial;
        branch_initial[7] = choose;
        let mut expected = branch_initial;
        expected[..3].copy_from_slice(if choose == 0 {
            &[5, 3, 15]
        } else {
            &[3, 13, 5]
        });
        tests.push(kernel_case(
            &format!("uninitialized pointer is assigned by selected branch {choose}"),
            "__global__ void kernel(int *out) {
                int first[2]{2, 3}, second[2]{5, 7};
                int *selected;
                if (out[7]) selected = first + 1;
                else selected = second;
                out[0] = *selected;
                *selected += 10;
                out[1] = first[1]; out[2] = second[0];
            }",
            &branch_initial,
            &expected,
        ));
    }
    for selector in [0, 1, 2] {
        let mut switch_initial = initial;
        switch_initial[0] = selector;
        let mut expected = switch_initial;
        expected[1] = if selector == 2 { -1 } else { 80 };
        tests.push(kernel_case(
            &format!("switch selector {selector} may cross a bare pointer declaration"),
            "__global__ void kernel(int *out) {
                switch (out[0]) {
                    case 0: int *cursor;
                    case 1: cursor = out + 8; out[1] = *cursor; break;
                    default: out[1] = -1;
                }
            }",
            &switch_initial,
            &expected,
        ));
    }
    tests
}
