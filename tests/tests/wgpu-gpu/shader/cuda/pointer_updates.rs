use super::{case, module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = -101;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        runtime_loop_branch_and_copy(true),
        runtime_loop_branch_and_copy(false),
        conditional_comma_and_value_categories(true),
        conditional_comma_and_value_categories(false),
        helper_parameter_and_kernel_pointer_objects(),
        workgroup_struct_and_vector_offsets(),
        subscript_assignment_and_argument_snapshots(),
    ]
}

fn runtime_loop_branch_and_copy(choose: bool) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[30] = i32::from(choose);
    let expected = if choose {
        [
            17, 11, 2, 11, 13, 11, 17, 7, 13, 7, 13, 17, 13, 23, 17, 7, 13, 17, 19, 19, 54, 9, 5,
            23, 19, 13, -101, -101, -101, -101, 1, 3,
        ]
    } else {
        [
            17, 11, 2, 11, 13, 11, 17, 7, 13, 7, 13, 17, 11, 23, 13, 7, 11, 13, 17, 17, 54, 9, 5,
            23, 19, 13, -101, -101, -101, -101, 0, 3,
        ]
    };
    let name = if choose {
        "cuda::pointer_updates::runtime_loop_branch_copy_and_reference/1"
    } else {
        "cuda::pointer_updates::runtime_loop_branch_copy_and_reference/0"
    };
    case(
        name,
        include_str!("../../../../../naga/tests/in/cuda/pointer-updates.cu"),
        &initial,
        &expected,
    )
}

fn conditional_comma_and_value_categories(choose: bool) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[30] = i32::from(choose);
    let expected = if choose {
        [
            5, 3, 6, 5, 7, 5, 29, 37, 47, 39, 37, 47, 37, 39, 47, 39, 3, 5, -101, -101, -101, -101,
            -101, -101, -101, -101, -101, -101, -101, -101, 1, -101,
        ]
    } else {
        [
            5, 3, 6, 5, 7, 5, 43, 31, 53, 59, 31, 53, 53, 31, 59, 31, 3, 5, -101, -101, -101, -101,
            -101, -101, -101, -101, -101, -101, -101, -101, 0, -101,
        ]
    };
    let name = if choose {
        "cuda::pointer_updates::conditional_comma_prefix_lvalue_and_captured_initializers/1"
    } else {
        "cuda::pointer_updates::conditional_comma_prefix_lvalue_and_captured_initializers/0"
    };
    case(
        name,
        r#"__global__ void kernel(int *out) {
    int values[8]{2, 3, 5, 7, 11, 13, 17, 19};
    int index = 1;
    int *pointer = values + index++;
    int *copy = pointer;
    ++pointer;
    index = 6;
    out[0] = *pointer;
    out[1] = *copy;
    out[2] = index;
    bool choose = true;
    int *selected = choose ? pointer : copy;
    choose = false;
    ++pointer;
    ++copy;
    out[3] = *selected;
    out[4] = *pointer;
    out[5] = *copy;
    int first[5]{23, 29, 31, 37, 39};
    int second[5]{41, 43, 47, 53, 59};
    choose = bool(out[30]);
    int *left = first + 1, *right = second + 1;
    int *original = choose ? left : right;
    ++(choose ? left : right);
    ++left;
    ++right;
    out[6] = *original;
    out[7] = *left;
    out[8] = *right;
    int counter = 0;
    (++counter, left) += -1;
    ++(++counter, left);
    int *prefix = ++(choose ? left : right);
    (choose ? left : right)--;
    out[9] = *prefix;
    out[10] = *left;
    out[11] = *right;
    (left += 1) -= 1;
    int *postfix = (choose ? left : right)++;
    out[12] = *postfix;
    out[13] = *left;
    out[14] = *right;
    int *same = (++counter, left);
    ++left;
    out[15] = *same;
    out[16] = counter;
    out[17] = *selected;
}
"#,
        &initial,
        &expected,
    )
}

fn helper_parameter_and_kernel_pointer_objects() -> ShaderTest {
    module_case(
        "cuda::pointer_updates::helper_parameter_copy_reentry_forwarding_and_kernel_pointer_objects",
        r#"__device__ int probe(int *pointer, int count) {
    int *saved = pointer;
    int sum = 0;
    for (int iteration = 0; iteration < count; ++iteration) {
        sum += *pointer;
        ++pointer;
    }
    *pointer += 1;
    return sum + 10 * saved[0] + 100 * pointer[0];
}
__device__ int fixed(int *const pointer) {
    *pointer += 3;
    return *pointer;
}
__device__ int forwarded(int *pointer) {
    ++pointer;
    int result = probe(pointer, 1);
    return result + *pointer * 1000;
}
__global__ void kernel(int *out, const int *input) {
    int values[8]{2, 3, 5, 7, 11, 13, 17, 19};
    int *pointer = values;
    out[0] = probe(pointer, 2);
    out[1] = *pointer;
    int total = 0;
    for (int iteration = 0; iteration < 2; ++iteration) {
        total += probe(pointer + iteration, 1);
    }
    out[2] = total;
    out[3] = values[1];
    out[4] = values[2];
    const int *kernel_copy = input;
    out[5] = *input++;
    out[6] = *input;
    out[7] = *kernel_copy;
    input += 2;
    out[8] = *input;
    --input;
    out[9] = *input;
    input -= 1;
    out[10] = *input;
    out[11] = fixed(values + 3);
    int *original = out;
    out += 12;
    *out = 61;
    ++out;
    *out = 67;
    out -= 1;
    *out += 2;
    original[14] = *out++;
    original[15] = *out;
    original[16] = forwarded(pointer);
    original[17] = *pointer;
    original[18] = values[2];
    int first_values[3]{101, 103, 107};
    int second_values[3]{109, 113, 127};
    int third_values[3]{131, 137, 139};
    int *first = first_values, *second = second_values, *third = third_values;
    int selections = 0;
    for (int route = 0; route < 4; ++route) {
        bool outer = route < 2;
        bool inner = route % 2 == 0;
        (outer ? (inner ? (++selections, first) : (++selections, second)) : (++selections, third))++;
    }
    original[19] = *first;
    original[20] = *second;
    original[21] = *third;
    original[22] = selections;
}
"#,
        [1, 1, 1],
        &[
            625, 2, 1166, 4, 7, 29, 31, 29,
            41, 37, 31, 10, 63, 67, 63, 67,
            4844, 2, 8, 103, 113, 139, 4, -101,
            -101, -101, -101, -101, -101, -101, -101, -101,
        ],
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 32],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[29, 31, 37, 41, 43, 47, 53, 59],
            ),
        ],
        0,
        [1, 1, 1],
    )
}

fn workgroup_struct_and_vector_offsets() -> ShaderTest {
    module_case(
        "cuda::pointer_updates::workgroup_struct_vector_element_offsets",
        r#"struct Record { int3 point; int samples[2]; };
__global__ void kernel(int *out) {
    unsigned lane = threadIdx.x;
    __shared__ int shared[8];
    shared[2u * lane] = int(lane) + 2;
    shared[2u * lane + 1u] = int(lane) + 11;
    __syncthreads();
    int *pointer = &shared[2u * lane];
    int *copy = pointer;
    ++pointer;
    *pointer += *copy;
    (--pointer)[0] += 1;
    unsigned slot = lane * 6u;
    out[slot] = pointer[0];
    out[slot + 1u] = (pointer++)[0];
    out[slot + 2u] = pointer[0];
    out[slot + 3u] = copy[0];
    Record records[3]{{{1, 2, 3}, {5, 7}}, {{11, 13, 17}, {19, 23}}, {{29, 31, 37}, {41, 43}}};
    Record *record = records;
    ++record;
    record->samples[1] += int(lane);
    Record *old = record++;
    out[slot + 4u] = old->samples[1];
    out[slot + 5u] = record->point.z;
    int3 points[3]{{1, 2, 3}, {11, 13, 17}, {29, 31, 37}};
    const int3 *point = points;
    point += 2;
    point -= 1;
    out[24u + lane] = point->y + int(lane);
}
"#,
        [4, 1, 1],
        &[
            3, 3, 13, 3, 23, 37, 4, 4, 15, 4, 24, 37, 5, 5, 17, 5, 25, 37, 6, 6, 19, 6, 26, 37, 13,
            14, 15, 16, -101, -101, -101, -101,
        ],
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [1, 1, 1],
    )
}

fn subscript_assignment_and_argument_snapshots() -> ShaderTest {
    case(
        "cuda::pointer_updates::subscript_assignment_and_helper_argument_snapshots",
        r#"__device__ int read(const int *pointer, int ignored) { return *pointer; }
__device__ void bump(int *pointer) { *pointer += 10; }
__global__ void kernel(int *out) {
    int values[8]{2, 3, 5, 7, 11, 13, 17, 19};
    {
        int *pointer = values;
        out[0] = pointer[(++pointer, 1)];
        out[1] = *pointer;
    }
    {
        int index = 1;
        int *pointer = values;
        out[2] = index[(index = 0, ++pointer)];
        out[3] = index;
        out[4] = *pointer;
    }
    {
        int *pointer = values;
        *pointer++ += *++pointer;
        out[5] = values[1];
        out[6] = *pointer;
    }
    {
        int *pointer = values;
        *(pointer += 1) += *pointer;
        out[7] = values[1];
        out[8] = *pointer;
    }
    {
        int *pointer = values;
        out[9] = read(pointer++, 0);
        out[10] = *pointer;
        out[11] = read(++pointer, 0);
        out[12] = *pointer;
        bump(pointer++);
        out[13] = values[2];
        out[14] = *pointer;
    }
    {
        int *pointer = values;
        out[15] = read((pointer += 2), 0);
        ++pointer;
        out[16] = *pointer;
    }
}
"#,
        &[SENTINEL; 32],
        &[
            3, 3, 5, 0, 3, 6, 5, 8, 8, 2, 8, 5, 5, 15, 7, 15, 7, -101, -101, -101, -101, -101,
            -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
        ],
    )
}
