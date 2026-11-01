use naga::front::cuda::Options;

use super::{module_case, module_case_with_options, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/device-helper-barriers.cu");

fn output_case(name: &str, source: &str, expected: &[u32]) -> ShaderTest {
    module_case(name, source, [4, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &vec![SENTINEL; expected.len()],
        )],
        0,
        [2, 1, 1],
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        retained_calls(0, 1),
        retained_calls(1, 2),
        captured_arguments(),
        shared_pointer_helpers(),
        dynamic_helpers(),
    ]
}

fn retained_calls(mode: u32, count: u32) -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..24].copy_from_slice(&[
        12, 13, 14, 11, 13, 14, 11, 12, 200, 101, 202, 103, 22, 23, 24, 21, 23, 24, 21, 22, 200,
        101, 202, 103,
    ]);
    module_case(
        &format!("retained helper barriers with mode {mode} and {count} rounds"),
        FIXTURE,
        [4, 1, 1],
        &expected,
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
                wgpu::BufferBindingType::Uniform,
                &[mode, SENTINEL, SENTINEL, SENTINEL],
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[count, SENTINEL, SENTINEL, SENTINEL],
            ),
        ],
        0,
        [2, 1, 1],
    )
}

fn captured_arguments() -> ShaderTest {
    let source = "__device__ unsigned pair(unsigned first, unsigned second, unsigned lane) {
        __syncthreads();
        return first * 100u + second * 10u + lane;
    }
    __global__ void arguments(unsigned *output) {
        unsigned lane = threadIdx.x;
        unsigned base = blockIdx.x * 20u;
        output[base + lane] = blockIdx.x * 10u + lane + 1u;
        unsigned saved = pair(output[base + lane], output[base + lane] = 77u + lane, lane);
        unsigned left = lane + 2u;
        unsigned right = lane + 7u;
        unsigned combined = pair(left++, right++, lane);
        unsigned row = base + 4u + lane * 4u;
        output[row] = saved; output[row + 1u] = combined;
        output[row + 2u] = left; output[row + 3u] = right;
    }";
    let mut expected = [SENTINEL; 64];
    for group in 0..2 {
        let base = group * 20;
        for lane in 0..4 {
            expected[base + lane] = 77 + lane as u32;
            let row = base + 4 + lane * 4;
            expected[row..row + 4].copy_from_slice(&[
                (group * 1000 + 870 + lane * 111) as u32,
                (270 + lane * 111) as u32,
                (lane + 3) as u32,
                (lane + 8) as u32,
            ]);
        }
    }
    output_case(
        "helper barrier calls capture memory arguments and independent postfix values once",
        source,
        &expected,
    )
}

fn shared_pointer_helpers() -> ShaderTest {
    let source = "__device__ unsigned rotate(unsigned *values, unsigned lane, unsigned amount) {
        __syncthreads();
        unsigned next = values[(lane + 1u) % 4u];
        __syncthreads();
        values[lane] = next + amount;
        __syncthreads();
        return values[lane];
    }
    __device__ void increment(unsigned &value) { value += 2u; __syncthreads(); }
    __global__ void phases(unsigned *output) {
        __shared__ unsigned values[4];
        unsigned lane = threadIdx.x;
        unsigned base = blockIdx.x * 12u;
        values[lane] = blockIdx.x * 10u + lane + 1u;
        output[base + lane] = rotate(values, lane, 1u);
        output[base + 4u + lane] = rotate(values, lane, 2u);
        increment(values[lane]);
        output[base + 8u + lane] = values[lane];
    }";
    let mut expected = [SENTINEL; 32];
    expected[..24].copy_from_slice(&[
        3, 4, 5, 2, 6, 7, 4, 5, 8, 9, 6, 7, 13, 14, 15, 12, 16, 17, 14, 15, 18, 19, 16, 17,
    ]);
    output_case(
        "pointer and reference helper expansion keeps all shared read-write phases",
        source,
        &expected,
    )
}

fn dynamic_helpers() -> ShaderTest {
    let source = "extern __shared__ unsigned values[];
    __device__ void initialize(unsigned data) {
        values[threadIdx.x] = blockIdx.x * 10u + data;
        __syncthreads();
    }
    __device__ unsigned rotate(unsigned amount) {
        unsigned lane = threadIdx.x;
        unsigned next = values[(lane + 1u) % 4u];
        __syncthreads();
        values[lane] = next + amount;
        __syncthreads();
        return values[lane];
    }
    __global__ void phases(unsigned *output) {
        unsigned lane = threadIdx.x;
        unsigned base = blockIdx.x * 8u;
        initialize(lane + 1u);
        output[base + lane] = rotate(1u);
        __syncthreads();
        output[base + 4u + lane] = rotate(2u);
    }";
    let mut expected = [SENTINEL; 32];
    expected[..16].copy_from_slice(&[3, 4, 5, 2, 6, 7, 4, 5, 13, 14, 15, 12, 16, 17, 14, 15]);
    module_case_with_options(
        "ordinary helpers synchronize one dynamic shared allocation across phases",
        source,
        &Options {
            workgroup_size: [4, 1, 1],
            dynamic_shared_memory_size: 16,
        },
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [2, 1, 1],
    )
}
