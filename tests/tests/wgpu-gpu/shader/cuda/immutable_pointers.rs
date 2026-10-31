use super::{case, ShaderTest};

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut initial = [-101; 32];
    initial[1] = 20;
    initial[2] = 30;
    initial[8] = 80;
    initial[9] = 90;
    initial[10] = 100;
    let mut tests = Vec::new();
    for (name, source, leading) in [
        (
            "immutable kernel pointer accesses its resource directly",
            "__global__ void kernel(int *out) { out[0] = out[8] + out[9]; }",
            &[170][..],
        ),
        (
            "immutable pointer copies preserve the same resource origin",
            "__global__ void kernel(int *out) {
                int *const fixed = out;
                const int *view = fixed;
                out[0] = view[8]; out[1] = fixed[9];
            }",
            &[80, 90][..],
        ),
        (
            "immutable helper pointer preserves its captured actual origin",
            "__device__ int read_at(const int *input, unsigned index) {
                return input[index];
            }
            __global__ void kernel(int *out) { out[0] = read_at(out, 8); }",
            &[80][..],
        ),
        (
            "immutable resource bases preserve reference helper index captures",
            "__device__ void copy(int &destination, const int &source) {
                destination = source;
            }
            __global__ void kernel(int *out) {
                unsigned destination_index = 1;
                unsigned source_index = 8;
                copy(out[destination_index++], out[source_index++]);
                out[0] = destination_index * 100 + source_index;
            }",
            &[209, 80][..],
        ),
        (
            "immutable resource bases preserve references across later index writes",
            "__global__ void kernel(int *out) {
                unsigned index = 1;
                int &destination = out[index++];
                const int &source = out[index++];
                ++index;
                destination = source;
                out[0] = index;
            }",
            &[4, 30][..],
        ),
        (
            "immutable pointer bases retain right-before-left index snapshots",
            "__global__ void kernel(int *out) {
                unsigned index = 1;
                out[index++] = out[index] + 10;
                out[0] = index;
            }",
            &[2, 30][..],
        ),
        (
            "pointer initializer captures a mutable scalar offset once",
            "__global__ void kernel(int *out) {
                unsigned start = 8;
                const int *tail = out + start;
                start = 9;
                out[0] = *tail; out[1] = start;
            }",
            &[80, 9][..],
        ),
        (
            "postincrement retains a saved pointer value",
            "__global__ void kernel(int *out) {
                const int *cursor = out + 8;
                const int *saved = cursor++;
                out[0] = *saved; out[1] = *cursor;
            }",
            &[80, 90][..],
        ),
        (
            "mutable helper pointer aliases retain independent saved values",
            "__device__ int read_next(const int *cursor) {
                const int *saved = cursor++;
                return *saved + *cursor;
            }
            __global__ void kernel(int *out) { out[0] = read_next(out + 8); }",
            &[170][..],
        ),
        (
            "loop-carried pointer position remains mutable",
            "__global__ void kernel(int *out) {
                int total = 0;
                const int *cursor = out + 8;
                for (unsigned iteration = 0; iteration < 3; ++iteration) total += *cursor++;
                out[0] = total;
            }",
            &[270][..],
        ),
        (
            "pointer reassignment preserves earlier captured pointer copies",
            "__global__ void kernel(int *out) {
                const int *cursor = out + 8;
                const int *saved = cursor;
                cursor = out + 10;
                out[0] = *saved; out[1] = *cursor;
            }",
            &[80, 100][..],
        ),
    ] {
        let mut expected = initial;
        expected[..leading.len()].copy_from_slice(leading);
        tests.push(case(name, source, &initial, &expected));
    }
    for choose in [0, 1] {
        let mut select_initial = initial;
        select_initial[3] = choose;
        let mut expected = select_initial;
        expected[0] = if choose == 0 { 90 } else { 80 };
        tests.push(case(
            &format!("immutable access-level pointer selection chooses arm {choose}"),
            "__global__ void kernel(int *out) {
                out[0] = *(out[3] ? (out + 8) : (out + 9));
            }",
            &select_initial,
            &expected,
        ));
    }
    let mut live_expected = initial;
    live_expected[0] = 80;
    live_expected[1] = 7;
    live_expected[8] = 7;
    tests.push(case(
        "immutable pointer base preserves live pointee reads around a write",
        "__global__ void kernel(int *out) {
            int &live = out[8];
            int first = live;
            live = 7;
            out[0] = first;
            out[1] = live;
        }",
        &initial,
        &live_expected,
    ));
    tests
}
