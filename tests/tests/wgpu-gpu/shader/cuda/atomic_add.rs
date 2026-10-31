use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/atomic-add.cu");
const SENTINEL: u32 = 0xdead_beef;

fn kernel_case(
    name: &str,
    source: &str,
    workgroup: [u32; 3],
    dispatch: [u32; 3],
    initial: &[u32],
    expected: &[u32],
    input: Option<&[u32]>,
) -> ShaderTest {
    let mut buffers = vec![ShaderBuffer::new(
        0,
        wgpu::BufferBindingType::Storage { read_only: false },
        initial,
    )];
    if let Some(input) = input {
        buffers.push(ShaderBuffer::new(
            1,
            wgpu::BufferBindingType::Storage { read_only: true },
            input,
        ));
    }
    module_case(name, source, workgroup, expected).module_buffers(buffers, 0, dispatch)
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![
        sequential(),
        unsigned_wrap(),
        storage_tickets(),
        shared_tickets(),
        struct_copies(),
        vector_components(),
    ];
    tests.extend(selected_origins());
    tests
}

fn sequential() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[0] = 7;
    initial[8] = 20;
    let mut expected = initial;
    expected[..15].copy_from_slice(&[
        (-5_i32) as u32,
        7,
        7,
        6,
        11,
        15,
        20,
        9,
        25,
        4,
        1,
        15,
        (-5_i32) as u32,
        23,
        25,
    ]);
    kernel_case(
        "atomicAdd old values, discarded results, scalar conversions and argument-once updates",
        FIXTURE,
        [1, 1, 1],
        [1, 1, 1],
        &initial,
        &expected,
        None,
    )
}

fn unsigned_wrap() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[0] = 0xffff_fffe;
    let mut expected = initial;
    expected[..4].copy_from_slice(&[0, 0xffff_fffe, 1, 0]);
    kernel_case(
        "unsigned atomicAdd wraps modulo 32 bits and returns the previous value",
        "__global__ void kernel(unsigned *output) {
            unsigned previous = atomicAdd(output, 3u);
            output[1] = previous;
            output[2] = output[0];
            atomicAdd(output, 0xffffffffu);
            output[3] = output[0];
        }",
        [1, 1, 1],
        [1, 1, 1],
        &initial,
        &expected,
        None,
    )
}

fn storage_tickets() -> ShaderTest {
    let mut initial = [SENTINEL; 48];
    initial[0] = 0;
    let mut expected = initial;
    expected[0] = 32;
    for ticket in 0..32 {
        expected[ticket + 1] = ticket as u32;
    }
    kernel_case(
        "device-wide atomicAdd allocates every ticket across four workgroups",
        "__global__ void kernel(unsigned *output) {
            unsigned ticket = atomicAdd(&output[0], 1u);
            output[ticket + 1u] = ticket;
        }",
        [8, 1, 1],
        [4, 1, 1],
        &initial,
        &expected,
        None,
    )
}

fn shared_tickets() -> ShaderTest {
    let mut initial = [SENTINEL; 40];
    initial[30] = 0;
    let mut expected = initial;
    for group in 0..2 {
        expected[group * 9] = 8;
        for ticket in 0..8 {
            expected[group * 9 + ticket + 1] = ticket as u32;
        }
    }
    kernel_case(
        "shared atomicAdd counters preserve initialized and readback phases in each workgroup",
        "__global__ void kernel(unsigned *output) {
            __shared__ unsigned counter;
            unsigned lane = threadIdx.x;
            if (lane == 0u) counter = output[30];
            __syncthreads();
            unsigned ticket = atomicAdd(&counter, 1u);
            unsigned base = blockIdx.x * 9u;
            output[base + ticket + 1u] = ticket;
            __syncthreads();
            if (lane == 0u) output[base] = counter;
        }",
        [8, 1, 1],
        [2, 1, 1],
        &initial,
        &expected,
        None,
    )
}

fn selected_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[7] = choose;
        initial[8] = 20;
        let mut expected = initial;
        if choose == 0 {
            expected[..4].copy_from_slice(&[20, 10, 23, 17]);
            expected[8] = 23;
        } else {
            expected[..4].copy_from_slice(&[10, 13, 20, 17]);
        }
        tests.push(kernel_case(
            &format!("atomicAdd helper selects storage or shared origin {choose} and merges its old result"),
            "__device__ int add(int *destination, int amount) { return atomicAdd(destination, amount); }
            __global__ void kernel(int *output) {
                __shared__ int shared;
                shared = 10;
                __syncthreads();
                int private_local = 17;
                int *selected = &private_local;
                selected = output[7] ? &shared : output + 8;
                int previous = add(selected, 3);
                __syncthreads();
                output[0] = previous;
                output[1] = shared;
                output[2] = output[8];
                output[3] = private_local;
            }",
            [1, 1, 1], [1, 1, 1], &initial, &expected, None,
        ));
    }
    tests
}

fn struct_copies() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..3].copy_from_slice(&[2, 3, 5]);
    let mut expected = initial;
    expected[..12].copy_from_slice(&[6, 3, 5, 6, 3, 6, 2, 2, 6, 6, 11, 17]);
    kernel_case(
        "atomic struct fields preserve value helpers, whole copies and an untouched readonly source type",
        "struct Counter { int value; int samples[2]; };
        __device__ Counter copied(Counter value) { value.samples[1] += 1; return value; }
        __global__ void kernel(Counter *records, const Counter *input) {
            Counter before = records[0];
            int previous = atomicAdd(&records[0].value, 4);
            Counter after = copied(records[0]);
            records[1] = after;
            Counter untouched = input[0];
            records[2].value = previous;
            records[2].samples[0] = before.value;
            records[2].samples[1] = after.value;
            records[3].value = after.samples[1];
            records[3].samples[0] = untouched.value;
            records[3].samples[1] = untouched.samples[1];
        }",
        [1, 1, 1], [1, 1, 1], &initial, &expected, Some(&[11, 13, 17]),
    )
}

fn vector_components() -> ShaderTest {
    let mut initial = [SENTINEL; 48];
    initial[0] = 11;
    initial[2..9].copy_from_slice(&[2, 3, 5, 7, 11, 13, 17]);
    let mut expected = initial;
    expected[3] = 8;
    expected[6] = 18;
    expected[12] = 3;
    expected[14..20].copy_from_slice(&[2, 8, 5, 7, 18, 13]);
    expected[20] = 11;
    expected[24] = 11;
    expected[26..33].copy_from_slice(&[2, 8, 5, 7, 18, 13, 17]);
    kernel_case(
        "atomic int2 and int4 components retain padded storage layout and whole parent copies",
        "struct Block { int marker; int2 pair; int4 quad; int tail; };
        __global__ void kernel(Block *records) {
            int previous_pair = atomicAdd(&records[0].pair.y, 5);
            int previous_quad = atomicAdd(&records[0].quad.z, 7);
            int2 pair = records[0].pair;
            int4 quad = records[0].quad;
            records[1].pair = pair; records[1].quad = quad;
            records[1].marker = previous_pair; records[1].tail = previous_quad;
            Block copied = records[0];
            records[2] = copied;
        }",
        [1, 1, 1],
        [1, 1, 1],
        &initial,
        &expected,
        None,
    )
}
