use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/auto-declarations.cu");
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
    let mut tests = vec![values_and_aliases(), ordered_initializers(), atomic_alias()];
    tests.extend(pointer_origins());
    tests.extend(array_rows());
    tests
}

fn values_and_aliases() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..20].copy_from_slice(&[7, 4, 11, 2, 1, 5, 9, 3, 5, 13, 2, 3, 4, 3, 7, 5, 8, 5, 7, 1]);
    kernel_case("auto values keep vector and record copies, mutable references, constant bounds and pointer aliases", FIXTURE, &initial, &expected)
}

fn pointer_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[15] = choose;
        let mut expected = initial;
        let first_value = if choose == 0 { 12 } else { 13 };
        let second_value = if choose == 0 { 6 } else { 5 };
        expected[..6].copy_from_slice(&[first_value, 3, second_value, 11, first_value, 11]);
        tests.push(kernel_case(
            &format!("auto pointer decay, updates and reference aliases preserve selected origin {choose}"),
            "__global__ void kernel(int *output) {
                int first[2]{2, 3}; int second[2]{5, 7};
                auto *cursor = first;
                auto saved = cursor++;
                auto &alias = *saved; alias += 10;
                auto selected = output[15] ? first : second;
                *selected += 1;
                cursor = second; ++cursor; *cursor = 11;
                output[0] = first[0]; output[1] = first[1];
                output[2] = second[0]; output[3] = second[1];
                output[4] = *saved; output[5] = *cursor;
            }",
            &initial, &expected,
        ));
    }
    tests
}

fn ordered_initializers() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..12].copy_from_slice(&[2, 3, 4, 13, 4, 5, 6, 7, 8, 9, 9, 5]);
    kernel_case(
        "auto mixed declarators evaluate once before later declarators and preserve nested loop scopes",
        "__device__ int next(int &value) { return value++; }
        __global__ void kernel(int *output) {
            int counter = 2;
            auto first(next(counter)), second{next(counter)}, &reference(counter);
            output[0] = first; output[1] = second; output[2] = reference;
            { auto counter = first + 10; ++counter; output[3] = counter; }
            for (auto index = 0; index < 3; ++index) {
                auto value = next(counter); output[index + 4] = value;
            }
            while (counter < 9) { auto value = counter++; output[value] = value; }
            output[9] = counter; output[10] = reference;
            const auto &temporary = first + second; output[11] = temporary;
        }",
        &initial, &expected,
    )
}

fn atomic_alias() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[8] = 3;
    let mut expected = initial;
    expected[..3].copy_from_slice(&[3, 1, 1]);
    expected[8] = 1;
    kernel_case(
        "auto pointer and scalar atomic results retain a live mutable reference to storage",
        "__global__ void kernel(unsigned *output) {
            auto destination = output + 8;
            auto limit = 3u;
            auto previous = atomicInc(destination, limit);
            auto &live = *destination; live += 1u;
            output[0] = previous; output[1] = live; output[2] = output[8];
        }",
        &initial,
        &expected,
    )
}

fn array_rows() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[15] = choose;
        let mut expected = initial;
        let matrix_value = if choose == 0 { 11 } else { 12 };
        let other_value = if choose == 0 { 24 } else { 23 };
        let selected_value = if choose == 0 { 24 } else { 12 };
        expected[..9].copy_from_slice(&[
            5,
            17,
            matrix_value,
            other_value,
            2,
            2,
            selected_value,
            5,
            43,
        ]);
        tests.push(kernel_case(
            &format!("auto row pointers retain row stride, captured indices, readonly access and selected origin {choose}"),
            "__global__ void kernel(int *output) {
                int matrix[3][2]{{2, 3}, {5, 7}, {11, 13}};
                int other[2][2]{{17, 19}, {23, 29}};
                const int frozen[2][2]{{31, 37}, {41, 43}};
                auto rows = matrix; ++rows;
                rows[0][1] += 10;
                auto *selected = output[15] ? rows : other;
                ++selected; selected[0][0] += 1;
                int index = 0;
                auto saved = &matrix[index++]; index = 2;
                saved[0][1] += 2;
                output[0] = matrix[0][1]; output[1] = matrix[1][1];
                output[2] = matrix[2][0]; output[3] = other[1][0];
                output[4] = index; output[5] = saved[0][0]; output[6] = selected[0][0];
                selected = matrix; ++selected; output[7] = selected[0][0];
                auto readonly_rows = frozen; ++readonly_rows; output[8] = readonly_rows[0][1];
            }",
            &initial, &expected,
        ));
    }
    tests
}
