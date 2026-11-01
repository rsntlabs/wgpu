use naga::front::cuda::Options;

use super::{module_case, module_case_with_options, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/thread-block-parameters.cu");

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
        reduction(),
        erased_arguments(),
        pointer_reference_arguments(),
        dimension_queries(),
    ]
}

fn reduction() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..16].copy_from_slice(&[
        10, 10, 10, 10, 14, 25, 36, 47, 50, 50, 50, 50, 114, 125, 136, 147,
    ]);
    module_case_with_options(
        "erased group arguments retain synchronized shared reduction calls",
        FIXTURE,
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

fn erased_arguments() -> ShaderTest {
    let source = "namespace cg = cooperative_groups; using Block = cg::thread_block;
    __device__ unsigned pack(unsigned first, Block ignored, unsigned second, Block same, unsigned third) {
        return first * 100u + second * 10u + third + same.thread_rank();
    }
    __device__ unsigned only(Block) { return 7u; }
    __device__ unsigned only() { return 9u; }
    __device__ void synchronize(Block group) { group.sync(); }
    __global__ void arguments(unsigned *output) {
        auto group = cg::this_thread_block();
        unsigned lane = threadIdx.x;
        unsigned counter = 1u;
        unsigned other = 5u;
        unsigned value = pack(counter++, (++counter, Block(group)), counter++,
                              (++other, cg::this_thread_block()), other++);
        synchronize((++counter, group));
        bool skipped = false && bool(only((++counter, group)));
        unsigned row = (blockIdx.x * 4u + lane) * 4u;
        output[row] = value; output[row + 1u] = counter;
        output[row + 2u] = other; output[row + 3u] = only(group) * 10u + only();
    }";
    let mut expected = [SENTINEL; 48];
    for invocation in 0..8 {
        let lane = (invocation % 4) as u32;
        expected[invocation * 4..invocation * 4 + 4].copy_from_slice(&[136 + lane, 5, 7, 79]);
    }
    output_case(
        "erased and scalar arguments execute once in source order and lazy arguments stay skipped",
        source,
        &expected,
    )
}

fn pointer_reference_arguments() -> ShaderTest {
    let source = "namespace cg = cooperative_groups; using Block = cg::thread_block;
    __device__ void store(Block, unsigned &value, unsigned amount) { value = amount; }
    __device__ unsigned update(unsigned *values, Block first, unsigned &destination,
                               const Block second, unsigned amount) {
        unsigned lane = first.thread_rank();
        values[lane] += amount;
        store(first, destination, values[lane] + lane);
        second.sync();
        return values[(lane + 1u) % 4u];
    }
    __global__ void arguments(unsigned *output) {
        __shared__ unsigned values[4];
        auto group = cg::this_thread_block();
        unsigned lane = threadIdx.x;
        unsigned base = blockIdx.x * 16u;
        values[lane] = blockIdx.x * 10u + lane + 1u;
        unsigned index = lane;
        unsigned next = update(values, group, output[base + index++], (++index, group), 2u);
        output[base + 4u + lane] = next;
        output[base + 8u + lane] = index;
        output[base + 12u + lane] = values[lane];
    }";
    let mut expected = [SENTINEL; 48];
    expected[..32].copy_from_slice(&[
        3, 5, 7, 9, 4, 5, 6, 3, 2, 3, 4, 5, 3, 4, 5, 6, 13, 15, 17, 19, 14, 15, 16, 13, 2, 3, 4, 5,
        13, 14, 15, 16,
    ]);
    output_case(
        "erased groups preserve pointer and captured reference argument positions",
        source,
        &expected,
    )
}

fn dimension_queries() -> ShaderTest {
    let source = "namespace cg = cooperative_groups; using Block = cg::thread_block;
    __device__ unsigned kind(dim3 value) { return 17u; }
    __device__ unsigned kind(uint3 value) { return 29u; }
    __device__ unsigned encode(unsigned first, const Block group, unsigned second) {
        dim3 local = group.thread_index();
        dim3 block = group.group_index();
        unsigned lane = local.x + 2u * (local.y + 2u * local.z);
        unsigned block_code = block.x + 10u * block.y + 100u * block.z;
        return first * 1000u + second * 100u + block_code * 100u + lane;
    }
    __global__ void queries(unsigned *output) {
        const Block group = cg::this_thread_block();
        unsigned lane = threadIdx.x + 2u * (threadIdx.y + 2u * threadIdx.z);
        unsigned block = blockIdx.x + 2u * (blockIdx.y + 2u * blockIdx.z);
        unsigned row = (block * 8u + lane) * 6u;
        dim3 shape = group.dim_threads();
        output[row] = encode(3u, Block{group}, 5u);
        output[row + 1u] = group.thread_rank(); output[row + 2u] = group.size();
        output[row + 3u] = kind(group.group_dim());
        output[row + 4u] = shape.x + 10u * shape.y + 100u * shape.z;
        output[row + 5u] = blockIdx.x + 10u * blockIdx.y + 100u * blockIdx.z;
    }";
    let mut expected = [SENTINEL; 400];
    for block_z in 0..2 {
        for block_y in 0..2 {
            for block_x in 0..2 {
                let block = block_x + 2 * (block_y + 2 * block_z);
                let block_code = (block_x + 10 * block_y + 100 * block_z) as u32;
                for lane in 0..8 {
                    let row = (block * 8 + lane) * 6;
                    expected[row..row + 6].copy_from_slice(&[
                        3500 + block_code * 100 + lane as u32,
                        lane as u32,
                        8,
                        17,
                        222,
                        block_code,
                    ]);
                }
            }
        }
    }
    module_case(
        "group formals keep nominal dimension queries and all three coordinate axes",
        source,
        [2, 2, 2],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 400],
        )],
        0,
        [2, 2, 2],
    )
}
