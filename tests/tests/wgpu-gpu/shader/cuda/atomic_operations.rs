use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/atomic-operations.cu");
const SENTINEL: u32 = 0xdead_beef;

fn kernel_case(name: &str, source: &str, initial: &[u32], expected: &[u32]) -> ShaderTest {
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
    let mut tests = vec![signed(), unsigned(), projected_fields()];
    tests.extend(selected_origins());
    tests
}

fn signed() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..7].copy_from_slice(&[
        10,
        (-5_i32) as u32,
        (-5_i32) as u32,
        0x8000_000f,
        0x8000_00f0,
        u32::MAX,
        (-7_i32) as u32,
    ]);
    let mut expected = initial;
    expected[..7].copy_from_slice(&[
        11,
        (-5_i32) as u32,
        3,
        0x8000_0003,
        0x8000_00ff,
        0x7fff_ffff,
        4,
    ]);
    expected[8..15].copy_from_slice(&initial[..7]);
    expected[16..23].copy_from_slice(&[
        13,
        (-5_i32) as u32,
        3,
        0x8000_0003,
        0x8000_00ff,
        0x7fff_ffff,
        4,
    ]);
    expected[23] = 11;
    kernel_case("signed binary atomics preserve old values, negative ordering, bit patterns and scalar conversion", FIXTURE, &initial, &expected)
}

fn unsigned() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..7].copy_from_slice(&[
        1,
        0x8000_0005,
        0x8000_0005,
        0xffff_fffe,
        7,
        0x8000_0003,
        0xffff_fffe,
    ]);
    let mut expected = initial;
    expected[..7].copy_from_slice(&[
        0xffff_fffe,
        3,
        0x8000_0005,
        0x8000_0002,
        0x8000_0007,
        0x7fff_fffc,
        3,
    ]);
    expected[8..15].copy_from_slice(&initial[..7]);
    expected[16..23].copy_from_slice(&[
        0xffff_fffe,
        7,
        0x8000_0005,
        0x8000_0002,
        0x8000_0007,
        0x7fff_fffc,
        3,
    ]);
    expected[23] = 3;
    kernel_case(
        "unsigned binary atomics preserve wrapping subtraction, high-bit ordering and old values",
        "__global__ void kernel(unsigned *output) {
            output[8] = atomicSub(output, 3u);
            output[9] = atomicMin(output + 1, 7u);
            output[10] = atomicMax(output + 2, 7u);
            output[11] = atomicAnd(output + 3, 0x80000003u);
            output[12] = atomicOr(output + 4, 0x80000000u);
            output[13] = atomicXor(output + 5, 0xffffffffu);
            output[14] = atomicExch(output + 6, 3u);
            output[16] = output[0]; output[17] = output[1]; output[18] = output[2];
            output[19] = output[3]; output[20] = output[4]; output[21] = output[5];
            output[22] = output[6];
            atomicMin(output + 1, 3u);
            output[23] = output[1];
        }",
        &initial,
        &expected,
    )
}

fn selected_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[7] = choose;
        initial[8] = 20;
        initial[9] = 30;
        let mut expected = initial;
        if choose == 0 {
            expected[..3].copy_from_slice(&[20, 10, 25]);
            expected[8] = 25;
            expected[9] = 40;
            expected[11] = 40;
        } else {
            expected[..3].copy_from_slice(&[10, 15, 20]);
            expected[9] = 10;
            expected[11] = 10;
        }
        expected[3..7].copy_from_slice(&[30, 10, 4, 1]);
        expected[10] = 27;
        tests.push(kernel_case(
            &format!("binary atomics forward helper origin {choose} and preserve lazy argument evaluation"),
            "__device__ int combine(int *destination, int amount);
            __global__ void kernel(int *output) {
                __shared__ int shared;
                shared = 10;
                __syncthreads();
                int *selected = output[7] ? &shared : output + 8;
                int previous = combine(selected, 3);
                __syncthreads();
                output[0] = previous;
                output[1] = shared;
                output[2] = output[8];
                unsigned index = 9;
                int amount = 3;
                output[3] = atomicSub(output + index++, amount++);
                output[4] = index;
                output[5] = amount;
                bool skipped = false && atomicAnd(output + 9, 0);
                bool ready = true || atomicXor(output + 9, 255);
                output[6] = int(skipped) + int(ready);
                output[10] = output[7] ? atomicMin(output + 9, 10) : atomicMax(output + 9, 40);
                output[11] = output[9];
            }
            __device__ int combine(int *destination, int amount) {
                int previous = atomicSub(destination, amount);
                atomicOr(destination, 8);
                return previous;
            }",
            &initial, &expected,
        ));
    }
    tests
}

fn projected_fields() -> ShaderTest {
    let mut initial = [SENTINEL; 24];
    initial[0] = 2;
    initial[2] = 5;
    initial[3] = 10;
    let mut expected = initial;
    expected[0] = 7;
    expected[3] = 9;
    expected[4] = 7;
    expected[6..9].copy_from_slice(&[5, 9, 2]);
    expected[10..12].copy_from_slice(&[10, 10]);
    kernel_case(
        "binary atomic struct and vector fields preserve whole values and padded storage layout",
        "struct Counter { int value; int2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            int previous = atomicMax(&records[0].value, 7);
            int previous_component = atomicXor(&records[0].pair.y, 3);
            Counter after = records[0];
            records[1] = after;
            records[2].value = previous;
            records[2].pair.x = previous_component;
            records[2].pair.y = before.pair.y;
        }",
        &initial,
        &expected,
    )
}
