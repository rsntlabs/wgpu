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
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 64];
        initial[31] = choose;
        initial[32..42].copy_from_slice(&[100, 110, 120, 130, 140, 150, 160, 170, 180, 190]);
        let mut expected = initial;
        expected[..15].copy_from_slice(&[
            7,
            100,
            35,
            35,
            350,
            37,
            if choose == 0 { 167 } else { 157 },
            38,
            101,
            170,
            41,
            180,
            191,
            101,
            35,
        ]);
        expected[17] = 23;
        expected[18] = 9;
        expected[32..41].copy_from_slice(&[
            101,
            35,
            120,
            350,
            140,
            if choose == 0 { 150 } else { 157 },
            380,
            180,
            191,
        ]);
        tests.push(module_case(
            &format!("constant indices stay compact while mutable signed indices, aliases, calls and branch {choose} preserve captured addresses"),
            "__device__ int advance(int &index) { int previous = index; ++index; return previous; }
            __device__ void assign(int &destination, int &index) { ++index; destination = index; }
            __global__ void kernel(int *output) {
                int index = 32; int &saved = output[index]; ++index;
                int first = saved; output[index] = 210;
                output[0] = first; output[1] = output[unsigned(32)];
                int &post = output[index++]; assign(post, index);
                output[2] = output[33u]; output[3] = index;
                int &from_call = output[advance(index)]; ++index; from_call = 350;
                output[4] = output[static_cast<int>(35u)]; output[5] = index;
                int &selected = output[output[31] ? index++ : advance(index) + 1];
                selected += 7; output[6] = selected; output[7] = index;
                const int &index_view = index;
                int &captured = output[index_view]; ++index; captured = 380;
                saved += 1; output[8] = saved; output[9] = output[index];
                for (int iteration = 0; iteration < 2; ++iteration) {
                    int &loop_saved = output[index++]; loop_saved += 10 + iteration;
                }
                output[10] = index; output[11] = output[39]; output[12] = output[40];
                output[13] = output[int(32u)]; output[14] = output[unsigned(33)];
                int *cursor = output + 18; cursor[-1] = 23;
                unsigned seed = 4294967295u; unsigned wrapped = seed + 1u;
                int *origin = output + wrapped; origin[18] = 9;
                int *wrapped_cursor = output + 0xffffffffu;
                wrapped_cursor += 1u; wrapped_cursor[0] = 7;
            }", [1, 1, 1], &expected,
        ).module_buffers(vec![ShaderBuffer::new(
            0, wgpu::BufferBindingType::Storage { read_only: false }, &initial,
        )], 0, [1, 1, 1]));
    }
    tests
}
