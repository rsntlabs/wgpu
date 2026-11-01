use naga::front::cuda::Options;

use super::{module_case_with_options, module_entry_case_with_options, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/dynamic-shared.cu");

fn options(bytes: u32, lanes: u32) -> Options {
    Options {
        workgroup_size: [lanes, 1, 1],
        dynamic_shared_memory_size: bytes,
    }
}

fn output_case(
    name: &str,
    source: &str,
    options: &Options,
    expected: &[u32],
    groups: u32,
) -> ShaderTest {
    module_case_with_options(name, source, options, expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &vec![SENTINEL; expected.len()],
        )],
        0,
        [groups, 1, 1],
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        external_aliases(),
        packed_vectors(),
        padded_records(),
        inner_arrays(),
        signed_atomics(),
        unsigned_atomics(),
        unused_zero(),
        entry_case("integers"),
        entry_case("floats"),
    ]
}

fn external_aliases() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..16].copy_from_slice(&[
        102, 104, 106, 104, 2, 3, 4, 5, 112, 114, 116, 114, 12, 13, 14, 15,
    ]);
    output_case(
        "external shared aliases retain cross-lane values and separate static storage",
        FIXTURE,
        &options(16, 4),
        &expected,
        2,
    )
}

fn packed_vectors() -> ShaderTest {
    let source = "using Triple = int3;
    __device__ Triple copied(Triple value) { value.y += 2; return value; }
    __global__ void vectors(int *output) {
        extern __shared__ int3 values[];
        extern __shared__ Triple aliases[];
        unsigned lane = threadIdx.x;
        int base = int(blockIdx.x) * 10;
        values[lane] = make_int3(base + int(lane) + 1, int(lane) + 20, int(lane) + 100);
        int &saved = aliases[lane].z;
        saved += 5;
        __syncthreads();
        Triple neighbor = copied(aliases[(lane + 1u) % 4u]);
        unsigned row = (blockIdx.x * 4u + lane) * 4u;
        output[row] = neighbor.x; output[row + 1u] = neighbor.y;
        output[row + 2u] = neighbor.z; output[row + 3u] = values[lane].z;
    }";
    let mut expected = [SENTINEL; 48];
    for group in 0..2 {
        for lane in 0..4 {
            let next = (lane + 1) % 4;
            let row = (group * 4 + lane) * 4;
            expected[row..row + 4].copy_from_slice(&[
                (group * 10 + next + 1) as u32,
                (next + 22) as u32,
                (next + 105) as u32,
                (lane + 105) as u32,
            ]);
        }
    }
    output_case(
        "packed int3 shared arrays retain twelve-byte stride through aliases and copies",
        source,
        &options(48, 4),
        &expected,
        2,
    )
}

fn padded_records() -> ShaderTest {
    let source = "struct Record { unsigned marker; int2 pair; int values[2]; };
    __device__ Record copied(Record value) { value.pair.y += 2; return value; }
    __global__ void records(unsigned *output) {
        extern __shared__ Record values[];
        unsigned lane = threadIdx.x;
        values[lane] = Record{blockIdx.x * 10u + lane + 1u, {int(lane) + 20, int(lane) + 30}, {int(lane) + 40, int(lane) + 50}};
        if (lane == 0u) values[4].marker = 77u;
        __syncthreads();
        Record neighbor = copied(values[(lane + 1u) % 4u]);
        unsigned row = (blockIdx.x * 4u + lane) * 6u;
        output[row] = neighbor.marker;
        output[row + 1u] = neighbor.pair.x; output[row + 2u] = neighbor.pair.y;
        output[row + 3u] = neighbor.values[0]; output[row + 4u] = neighbor.values[1];
        output[row + 5u] = values[4].marker;
    }";
    let mut expected = [SENTINEL; 64];
    for group in 0..2 {
        for lane in 0..4 {
            let next = (lane + 1) % 4;
            let row = (group * 4 + lane) * 6;
            expected[row..row + 6].copy_from_slice(&[
                (group * 10 + next + 1) as u32,
                (next + 20) as u32,
                (next + 32) as u32,
                (next + 40) as u32,
                (next + 50) as u32,
                77,
            ]);
        }
    }
    output_case(
        "padded records preserve layout and a partial final record's in-range field",
        source,
        &options(100, 4),
        &expected,
        2,
    )
}

fn inner_arrays() -> ShaderTest {
    let source = "__device__ void increment(int &value) { value += 5; }
    __global__ void rows(int *output) {
        extern __shared__ int values[][3];
        unsigned lane = threadIdx.x;
        int base = int(blockIdx.x) * 10 + int(lane) * 3;
        values[lane][0] = base + 1; values[lane][1] = base + 2; values[lane][2] = base + 3;
        auto pointer = values;
        increment(pointer[lane][1]);
        __syncthreads();
        unsigned next = (lane + 1u) % 2u;
        unsigned row = (blockIdx.x * 2u + lane) * 3u;
        output[row] = pointer[next][0]; output[row + 1u] = pointer[next][1]; output[row + 2u] = pointer[next][2];
    }";
    let mut expected = [SENTINEL; 32];
    expected[..12].copy_from_slice(&[4, 10, 6, 1, 7, 3, 14, 20, 16, 11, 17, 13]);
    output_case(
        "fixed inner arrays preserve row strides and reference writes",
        source,
        &options(24, 2),
        &expected,
        2,
    )
}

fn signed_atomics() -> ShaderTest {
    let source = "__device__ int take(int *value) { return atomicAdd(value, -1); }
    __global__ void tickets(int *output) {
        extern __shared__ int counters[];
        unsigned lane = threadIdx.x;
        if (lane == 0u) counters[0] = 20;
        __syncthreads();
        auto pointer = counters;
        int previous = take(pointer);
        unsigned base = blockIdx.x * 5u;
        output[base + 1u + unsigned(previous - 17)] = previous;
        __syncthreads();
        if (lane == 0u) output[base] = counters[0];
    }";
    let mut expected = [SENTINEL; 32];
    expected[..10].copy_from_slice(&[16, 17, 18, 19, 20, 16, 17, 18, 19, 20]);
    output_case(
        "signed dynamic shared atomics return distinct old values through helper aliases",
        source,
        &options(4, 4),
        &expected,
        2,
    )
}

fn unsigned_atomics() -> ShaderTest {
    let source = "__device__ unsigned take(unsigned &value) { return atomicAdd(&value, 1u); }
    __global__ void tickets(unsigned *output) {
        extern __shared__ unsigned counters[];
        unsigned lane = threadIdx.x;
        if (lane == 0u) counters[0] = 0xfffffffcu;
        __syncthreads();
        unsigned previous = take(counters[0]);
        unsigned base = blockIdx.x * 5u;
        output[base + 1u + previous - 0xfffffffcu] = previous;
        __syncthreads();
        if (lane == 0u) output[base] = counters[0];
    }";
    let mut expected = [SENTINEL; 32];
    expected[..10].copy_from_slice(&[
        0,
        0xffff_fffc,
        0xffff_fffd,
        0xffff_fffe,
        0xffff_ffff,
        0,
        0xffff_fffc,
        0xffff_fffd,
        0xffff_fffe,
        0xffff_ffff,
    ]);
    output_case(
        "unsigned dynamic shared atomics wrap and preserve returned tickets",
        source,
        &options(4, 4),
        &expected,
        2,
    )
}

fn unused_zero() -> ShaderTest {
    let source = "__global__ void empty(unsigned *output) { extern __shared__ float unused[]; output[0] = 7u; }";
    let mut expected = [SENTINEL; 16];
    expected[0] = 7;
    output_case(
        "zero dynamic bytes leave unused declarations untouched",
        source,
        &options(0, 1),
        &expected,
        1,
    )
}

fn entry_case(entry: &str) -> ShaderTest {
    let source = "__device__ int integer_value(unsigned index) { extern __shared__ int integer_values[]; return integer_values[index]; }
    __device__ float float_value(unsigned index) { extern __shared__ float float_values[]; return float_values[index]; }
    __global__ void integers(int *output) {
        extern __shared__ int integer_values[];
        unsigned lane = threadIdx.x;
        integer_values[lane] = int(blockIdx.x) * 10 + int(lane) + 1;
        __syncthreads();
        output[blockIdx.x * 4u + lane] = integer_value((lane + 1u) % 4u);
    }
    __global__ void floats(float *output) {
        extern __shared__ float float_values[];
        unsigned lane = threadIdx.x;
        float_values[lane] = float(blockIdx.x) * 10.0f + float(lane) + 0.5f;
        __syncthreads();
        output[blockIdx.x * 4u + lane] = float_value((lane + 1u) % 4u);
    }";
    let mut expected = [SENTINEL; 24];
    match entry {
        "integers" => expected[..8].copy_from_slice(&[2, 3, 4, 1, 12, 13, 14, 11]),
        "floats" => expected[..8]
            .copy_from_slice(&[1.5_f32, 2.5, 3.5, 0.5, 11.5, 12.5, 13.5, 10.5].map(f32::to_bits)),
        _ => unreachable!(),
    }
    module_entry_case_with_options(
        &format!("dynamic shared {entry} entry keeps its own element type and helpers"),
        source,
        &options(16, 4),
        entry,
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 24],
        )],
        0,
        [2, 1, 1],
    )
}
