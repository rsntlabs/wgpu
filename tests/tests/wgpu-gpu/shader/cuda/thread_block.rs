use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/thread-block.cu");
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        shared_and_storage_exchange(),
        edge_tile_transpose(),
        scalar_queries(),
        erased_handle_effects(),
    ]
}

fn shared_and_storage_exchange() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..12].copy_from_slice(&[2, 3, 4, 1, 1, 2, 3, 4, 2, 3, 4, 1]);
    expected[12..24].copy_from_slice(&[12, 13, 14, 11, 11, 12, 13, 14, 12, 13, 14, 11]);
    module_case(
        "thread block free, member and static synchronization preserve cross-lane shared and storage dependencies",
        FIXTURE,
        [4, 1, 1],
        &expected,
    ).module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial)],
        0,
        [2, 1, 1],
    )
}

fn edge_tile_transpose() -> ShaderTest {
    let mut input = [0x1234_5678_u32; 32];
    input[..6].copy_from_slice(&[1, 2, 3, 4, 5, 6]);
    let mut expected = [SENTINEL; 32];
    expected[..6].copy_from_slice(&[1, 4, 2, 5, 3, 6]);
    module_case(
        "thread block synchronization preserves a tiled transpose with a partially populated edge tile",
        "namespace tiles = cooperative_groups;
        __global__ void transpose(const unsigned *input, unsigned *output) {
            auto group = tiles::this_thread_block();
            __shared__ unsigned tile[2][3];
            unsigned x = blockIdx.x * 2u + threadIdx.x;
            unsigned y = blockIdx.y * 2u + threadIdx.y;
            if (x < 3u && y < 2u) tile[threadIdx.y][threadIdx.x] = input[y * 3u + x];
            group.sync();
            x = blockIdx.y * 2u + threadIdx.x;
            y = blockIdx.x * 2u + threadIdx.y;
            if (x < 2u && y < 3u) output[y * 2u + x] = tile[threadIdx.x][threadIdx.y];
        }",
        [2, 2, 1],
        &expected,
    ).module_buffers(
        vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &input),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 32]),
        ],
        1,
        [2, 1, 1],
    )
}

fn scalar_queries() -> ShaderTest {
    let initial = [SENTINEL; 400];
    let mut expected = initial;
    for group in 0..2 {
        for rank in 0..24 {
            let offset = (group * 24 + rank) * 8;
            expected[offset..offset + 7].copy_from_slice(&[
                rank as u32,
                24,
                24,
                rank as u32,
                rank as u32,
                24,
                24,
            ]);
        }
    }
    module_case(
        "thread block unsigned queries use CUDA three-dimensional rank and the complete workgroup size",
        "namespace cg = cooperative_groups;
        using Block = cg::thread_block;
        __global__ void observations(unsigned *output) {
            const auto group = cg::this_thread_block();
            unsigned coordinate_index = threadIdx.x + 4u * (threadIdx.y + 3u * threadIdx.z);
            unsigned offset = (blockIdx.x * 24u + coordinate_index) * 8u;
            output[offset] = group.thread_rank();
            output[offset + 1u] = group.size();
            output[offset + 2u] = group.num_threads();
            output[offset + 3u] = cg::this_thread_block().thread_rank();
            output[offset + 4u] = cg::thread_block::thread_rank();
            output[offset + 5u] = ::cg::thread_block::size();
            output[offset + 6u] = Block::num_threads();
        }",
        [4, 3, 2],
        &expected,
    ).module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial)],
        0,
        [2, 1, 1],
    )
}

fn erased_handle_effects() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..11].copy_from_slice(&[1, 2, 3, 4, 5, 0, 6, 1, 7, 1, 8]);
    module_case(
        "erased thread block handles preserve initializer, copy, synchronization and query side effects exactly once",
        "namespace cg = cooperative_groups;
        __global__ void effects(unsigned *output) {
            unsigned counter = 0u;
            auto original = (++counter, cg::this_thread_block());
            output[0] = counter;
            auto copied = cg::thread_block((++counter, original));
            output[1] = counter;
            cg::sync((++counter, copied)); output[2] = counter;
            cg::thread_block((++counter, copied)).sync(); output[3] = counter;
            (++counter, original).sync(); output[4] = counter;
            output[5] = (++counter, copied).thread_rank(); output[6] = counter;
            output[7] = cg::thread_block((++counter, original)).size(); output[8] = counter;
            output[9] = (++counter, cg::this_thread_block()).num_threads(); output[10] = counter;
        }",
        [1, 1, 1],
        &expected,
    ).module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &initial)],
        0,
        [1, 1, 1],
    )
}
