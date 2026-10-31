use super::{case, module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = -101;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/pointer-assignments.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = runtime_state();
    tests.push(dynamic_projections());
    tests.extend(reference_select_arms());
    tests.extend(selected_objects());
    tests.push(sequencing());
    tests.extend(private_formals());
    tests.push(mixed_address_spaces());
    tests.extend(aggregate_storage());
    tests.push(loop_clauses());
    tests
}

fn scalar_case(name: &str, source: &str, leading: &[i32]) -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..leading.len()].copy_from_slice(leading);
    case(name, source, &initial, &expected)
}

fn choice_case(name: &str, source: &str, choose: i32, leading: &[i32]) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[30] = choose;
    let mut expected = initial;
    expected[..leading.len()].copy_from_slice(leading);
    case(name, source, &initial, &expected)
}

fn runtime_state() -> Vec<ShaderTest> {
    vec![
        choice_case(
            "pointer assignment selects first array and preserves earlier copies",
            FIXTURE,
            1,
            &[13, 2, 2, 5, 3, 25, 2, 25, 17, 2, 13, 7, 7, 3, 2, 7, 13, 2],
        ),
        choice_case(
            "pointer assignment selects second array and preserves earlier copies",
            FIXTURE,
            0,
            &[13, 2, 2, 17, 3, 37, 2, 5, 37, 2, 13, 7, 7, 3, 2, 7, 13, 2],
        ),
    ]
}

fn dynamic_projections() -> ShaderTest {
    scalar_case(
        "pointer assignment copies dynamic ancestor coordinates across loop iterations",
        r#"struct Record { int samples[2]; int marker; };
__global__ void kernel(int *out) {
    Record records[3]{{{2, 3}, 5}, {{11, 13}, 17}, {{17, 19}, 23}};
    int *pointer = &records[0].samples[0];
    int *saved = &records[2].samples[0];
    for (int iteration = 0; iteration < 3; ++iteration) {
        pointer = &records[iteration].samples[iteration % 2];
        if (iteration == 0) saved = pointer;
        *pointer += iteration + 1;
        out[iteration] = *saved;
    }
    int &reference = *pointer;
    pointer = &records[0].samples[1];
    reference += 5;
    out[3] = *saved;
    out[4] = *pointer;
    out[5] = reference;
    out[6] = records[0].samples[0];
    out[7] = records[1].samples[1];
    out[8] = records[2].samples[0];
    int matrix[2][3]{{23, 29, 31}, {37, 41, 43}};
    pointer = matrix[0] + 1;
    saved = pointer;
    for (int row = 0; row < 2; ++row) {
        pointer = matrix[row] + row;
        out[9 + row] = *pointer;
    }
    out[11] = *saved;
}"#,
        &[3, 3, 3, 3, 3, 25, 3, 15, 25, 23, 41, 29],
    )
}

fn selected_objects() -> Vec<ShaderTest> {
    let source = r#"__global__ void kernel(int *out) {
    int first[5]{2, 3, 5, 7, 11};
    int second[5]{13, 17, 19, 23, 29};
    int third[5]{31, 37, 41, 43, 47};
    int *left = first, *right = second;
    bool choose = bool(out[30]);
    int count = 0;
    (choose ? left : right) = third + 1;
    out[0] = *left;
    out[1] = *right;
    (++count, left) = second + 2;
    out[2] = *left;
    ++(left = first + 1);
    out[3] = *left;
    (++left) = second + 3;
    out[4] = *left;
    out[5] = count;
    (left = right) = third + 2;
    out[6] = *left;
    out[7] = *right;
    (left = right) += 1;
    out[8] = *left;
    out[9] = *right;
    (choose ? (++count, left) : (++count, right)) = third;
    out[10] = *left;
    out[11] = *right;
    out[12] = count;
    left = right = first + 4;
    out[13] = *left;
    out[14] = *right;
    (left = third + 1)--;
    out[15] = *left;
}"#;
    vec![
        choice_case(
            "conditional comma prefix and assignment lvalues select the left pointer object",
            source,
            1,
            &[37, 13, 19, 5, 23, 1, 41, 13, 17, 13, 31, 13, 2, 11, 11, 31],
        ),
        choice_case(
            "conditional comma prefix and assignment lvalues select the right pointer object",
            source,
            0,
            &[2, 37, 19, 5, 23, 1, 41, 37, 41, 37, 41, 31, 2, 11, 11, 31],
        ),
    ]
}

fn reference_select_arms() -> Vec<ShaderTest> {
    let source = r#"__global__ void kernel(int *out) {
    int matrix[3][2]{{2, 3}, {5, 7}, {11, 13}};
    int *pointer = matrix[1];
    int &reference = pointer[1];
    int *selected = matrix[0];
    bool choose = bool(out[7]);
    selected = choose ? &reference : &reference;
    out[0] = *selected;
    *selected += 10;
    out[1] = matrix[1][1];
    out[2] = matrix[0][0];
    out[3] = *pointer;
}"#;
    [0, 1]
        .into_iter()
        .map(|choose| {
            let mut initial = [SENTINEL; 32];
            initial[7] = choose;
            let mut expected = initial;
            expected[..4].copy_from_slice(&[7, 17, 2, 5]);
            case(
                &format!("shared deferred reference is materialized in select arm {choose}"),
                source,
                &initial,
                &expected,
            )
        })
        .collect()
}

fn sequencing() -> ShaderTest {
    scalar_case(
        "assignment snapshots precede destination selection and later call arguments",
        r#"__device__ int pair(const int *first, const int *second) {
    return *first * 10 + *second;
}
__global__ void kernel(int *out) {
    int first[5]{2, 3, 5, 7, 11};
    int second[5]{13, 17, 19, 23, 29};
    int third[5]{31, 37, 41, 43, 47};
    bool choose = true;
    int *left = first, *right = second;
    (choose ? left : right) = (choose = false, third + 1);
    out[0] = *left;
    out[1] = *right;
    out[2] = int(choose);
    left = first;
    *left = *(left = second + 1);
    out[3] = first[0];
    out[4] = second[1];
    left = first;
    left[(left = second, 1)] = 101;
    out[5] = first[1];
    out[6] = *left;
    left = first;
    left = (left = second + 1, left + 1);
    out[7] = *left;
    left = first + 1;
    right = third + 2;
    (++left) = right;
    out[8] = *left;
    out[9] = *right;
    left = first + 1;
    (++left) = left + 1;
    out[10] = *left;
    left = first + 1;
    out[11] = pair(left, (left = second + 1));
    out[12] = *left;
}"#,
        &[2, 37, 0, 2, 17, 101, 13, 19, 41, 41, 5, 1027, 17],
    )
}

fn private_formals() -> Vec<ShaderTest> {
    let source = r#"__device__ int change(int *pointer, int *replacement) {
    int *saved = pointer;
    pointer = replacement + 1;
    ++pointer;
    *pointer += 5;
    return *saved * 100 + *pointer;
}
__device__ int relay(int *first, int *second) {
    return change(first, second);
}
__global__ void kernel(int *out, int *input) {
    int *result = out;
    int first[3]{2, 3, 5};
    int second[3]{7, 11, 13};
    int *pointer = first;
    result[0] = change(pointer, second);
    result[1] = *pointer;
    result[2] = second[2];
    result[3] = relay(pointer + 1, second);
    result[4] = *pointer;
    result[5] = second[2];
    for (int iteration = 0; iteration < 2; ++iteration) {
        result[6 + iteration] = change(pointer, second);
    }
    result[8] = second[2];
    out = input + 1;
    out[0] += 3;
    result[9] = *out;
    out = first + 2;
    *out += 7;
    result[10] = first[2];
    result[11] = result[0];
}"#;
    let initial_output = [SENTINEL; 32];
    let mut expected_output = initial_output;
    expected_output[..12].copy_from_slice(&[218, 2, 18, 323, 2, 23, 228, 233, 33, 44, 12, 218]);
    let initial_input = [37, 41, 43, 47, SENTINEL, SENTINEL, SENTINEL, SENTINEL];
    let expected_input = [37, 44, 43, 47, SENTINEL, SENTINEL, SENTINEL, SENTINEL];
    let mut tests = Vec::new();
    for (output_binding, expected) in [(0, &expected_output[..]), (1, &expected_input[..])] {
        tests.push(
            module_case(
                &format!("private pointer formals, repeated helpers and kernel reassignment, binding {output_binding}"),
                source,
                [1, 1, 1],
                expected,
            )
            .module_buffers(
                vec![
                    ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial_output),
                    ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &initial_input),
                ],
                output_binding,
                [1, 1, 1],
            ),
        );
    }
    tests
}

fn mixed_address_spaces() -> ShaderTest {
    let source = r#"__global__ void kernel(int *out) {
    unsigned lane = threadIdx.x;
    __shared__ int shared[8];
    shared[2u * lane] = int(lane) + 10;
    shared[2u * lane + 1u] = int(lane) + 20;
    __syncthreads();
    int local[2]{int(lane) + 30, int(lane) + 40};
    int *pointer = local;
    int *copy = pointer;
    pointer = &shared[2u * lane];
    *pointer += 1;
    unsigned slot = lane * 6u;
    out[slot] = *pointer;
    pointer = local + 1;
    *pointer += 2;
    out[slot + 1u] = *pointer;
    out[slot + 2u] = *copy;
    pointer = out + 24u + lane;
    *pointer += 3;
    pointer = &shared[2u * lane + 1u];
    *pointer += 4;
    out[slot + 3u] = *pointer;
    out[slot + 4u] = shared[2u * lane];
    out[slot + 5u] = local[1];
}"#;
    let mut initial = [SENTINEL; 32];
    initial[24..28].copy_from_slice(&[100, 101, 102, 103]);
    let mut expected = initial;
    expected[..28].copy_from_slice(&[
        11, 42, 30, 24, 11, 42, 12, 43, 31, 25, 12, 43, 13, 44, 32, 26, 13, 44, 14, 45, 33, 27, 14,
        45, 103, 104, 105, 106,
    ]);
    module_case(
        "pointer assignment selects function, workgroup and storage origins per invocation",
        source,
        [4, 1, 1],
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
    )
}

fn aggregate_storage() -> Vec<ShaderTest> {
    let source = r#"struct Record { int3 point; int samples[2]; };
__global__ void kernel(int *out, Record *storage) {
    Record first[2]{{{2, 3, 5}, {7, 11}}, {{13, 17, 19}, {23, 29}}};
    Record second[2]{{{31, 37, 41}, {43, 47}}, {{53, 59, 61}, {67, 71}}};
    Record *pointer = first;
    Record *copy = pointer;
    pointer = second + 1;
    pointer->point.y += 3;
    int *field = &pointer->samples[1];
    int *saved = field;
    field = &copy->point.z;
    *field += 5;
    pointer = first + 1;
    pointer->samples[0] += *saved;
    out[0] = second[1].point.y;
    out[1] = first[0].point.z;
    out[2] = pointer->samples[0];
    out[3] = *saved;
    int3 *vector = &copy->point;
    const int3 *view = vector;
    vector = &second[0].point;
    vector->x += 2;
    out[4] = view->z;
    out[5] = vector->x;
    Record object{{73, 79, 83}, {89, 97}};
    pointer = &object;
    pointer->samples[1] += 1;
    out[6] = pointer->samples[1];
    pointer = storage + 1;
    pointer->samples[1] += 3;
    out[7] = pointer->samples[1];
    field = &pointer->point.y;
    *field += 4;
    out[8] = *field;
    out[9] = *saved;
    vector = &pointer->point;
    out[10] = vector->z;
    vector = &first[1].point;
    vector->z += 1;
    out[11] = vector->z;
    out[12] = *field;
}"#;
    let initial_output = [SENTINEL; 32];
    let mut expected_output = initial_output;
    expected_output[..13]
        .copy_from_slice(&[62, 10, 94, 71, 10, 33, 98, 152, 135, 71, 137, 20, 135]);
    let initial_storage = [
        101, 103, 107, 109, 113, 127, 131, 137, 139, 149, SENTINEL, SENTINEL, SENTINEL, SENTINEL,
        SENTINEL, SENTINEL,
    ];
    let expected_storage = [
        101, 103, 107, 109, 113, 127, 135, 137, 139, 152, SENTINEL, SENTINEL, SENTINEL, SENTINEL,
        SENTINEL, SENTINEL,
    ];
    let mut tests = Vec::new();
    for (output_binding, expected) in [(0, &expected_output[..]), (1, &expected_storage[..])] {
        tests.push(
            module_case(
                &format!("struct and packed vector pointer assignments retain field addresses, binding {output_binding}"),
                source,
                [1, 1, 1],
                expected,
            )
            .module_buffers(
                vec![
                    ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial_output),
                    ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &initial_storage),
                ],
                output_binding,
                [1, 1, 1],
            ),
        );
    }
    tests
}

fn loop_clauses() -> ShaderTest {
    scalar_case(
        "pointer assignment runs in loop conditions, updates, continue and break paths",
        r#"__global__ void kernel(int *out) {
    int first[4]{2, 3, 5, 7};
    int second[4]{11, 13, 17, 19};
    int *pointer = first;
    int iteration = 0;
    for (int *cursor = first;
         (cursor = iteration % 2 ? second : first, iteration < 4);
         ++iteration, cursor = first) {
        if (iteration == 1) {
            pointer = cursor + 1;
            continue;
        }
        out[iteration] = *cursor;
        if (iteration == 2) {
            pointer = second + 2;
            break;
        }
    }
    out[4] = iteration;
    out[5] = *pointer;
    do {
        pointer = first + iteration;
        --iteration;
    } while ((pointer = second + iteration, iteration > 0));
    out[6] = *pointer;
    while ((pointer = first + iteration, iteration < 2)) {
        out[7 + iteration] = *pointer;
        ++iteration;
    }
    out[9] = *pointer;
    out[10] = iteration;
}"#,
        &[2, SENTINEL, 2, SENTINEL, 2, 17, 11, 2, 3, 5, 2],
    )
}
