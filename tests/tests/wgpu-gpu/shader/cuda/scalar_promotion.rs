use super::{case, module_case, ShaderBuffer, ShaderTest};

const SENTINEL: i32 = -101;
const COPY_SNAPSHOTS: &str =
    include_str!("../../../../../naga/tests/in/cuda/scalar-copy-snapshots.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut snapshot_initial = [SENTINEL; 32];
    snapshot_initial[3] = 4;
    let mut snapshot_expected = snapshot_initial;
    snapshot_expected[..3].copy_from_slice(&[4, 9, 4]);
    let wrap_initial = [SENTINEL; 32];
    let mut wrap_expected = wrap_initial;
    wrap_expected[..2].copy_from_slice(&[0, 1]);
    let mut tests = vec![
        case(
            "promoted scalar load snapshots once before later mutation",
            "__global__ void kernel(int *out) {
                int source = out[3];
                int captured = source;
                source = 9;
                out[0] = captured;
                out[1] = source;
                out[2] = captured;
            }",
            &snapshot_initial,
            &snapshot_expected,
        ),
        case(
            "promoted scalar arithmetic preserves runtime unsigned wrapping",
            "__global__ void kernel(int *out) {
                unsigned seed = 4294967295u;
                unsigned wrapped = seed + 1u;
                out[0] = int(wrapped);
                out[1] = int(seed == 4294967295u);
            }",
            &wrap_initial,
            &wrap_expected,
        ),
    ];
    let mut chain = String::from("__global__ void kernel(int *out) { int value0 = out[0];");
    for index in 1..80 {
        chain.push_str(&format!("int value{index} = value{} + out[0];", index - 1));
    }
    chain.push_str("out[1] = value79; }");
    let mut chain_initial = [SENTINEL; 32];
    chain_initial[0] = 2;
    let mut chain_expected = chain_initial;
    chain_expected[1] = 160;
    tests.push(case(
        "deep merged scalar chain preserves valid original storage and result",
        &chain,
        &chain_initial,
        &chain_expected,
    ));
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[0] = 4;
        initial[3] = choose;
        let mut expected = initial;
        expected[..3].copy_from_slice(&[5, if choose == 0 { 15 } else { 5 }, 5]);
        tests.push(case(
            &format!("promoted call result captures its argument once before branch {choose}"),
            "__device__ int advance(int value) { return value + 1; }
            __global__ void kernel(int *out) {
                int source = out[0];
                int captured = advance(source++);
                if (out[3]) out[1] = captured;
                else out[1] = captured + 10;
                out[2] = captured;
                out[0] = source;
            }",
            &initial,
            &expected,
        ));
    }
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[7] = choose;
        initial[8] = 4;
        let mut expected = initial;
        let branch_value = if choose == 0 { 17 } else { 13 };
        let loop_value = branch_value + 6;
        expected[..15].copy_from_slice(&[
            4,
            9,
            9,
            11,
            11,
            branch_value,
            branch_value,
            choose,
            19,
            loop_value,
            loop_value,
            loop_value,
            19,
            19,
            20,
        ]);
        tests.push(module_case(
            &format!("scalar copies keep snapshots before storage, helper, branch, loop and atomic mutation {choose}"),
            COPY_SNAPSHOTS, [1, 1, 1], &expected,
        ).module_buffers(vec![ShaderBuffer::new(
            0, wgpu::BufferBindingType::Storage { read_only: false }, &initial,
        )], 0, [1, 1, 1]));
    }
    tests
}
