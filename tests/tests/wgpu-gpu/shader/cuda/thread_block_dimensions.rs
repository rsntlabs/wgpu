use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/thread-block-dimensions.cu");
const SENTINEL: u32 = 0xdead_beef;

fn output_case(
    name: &str,
    source: &str,
    expected: &[u32],
    workgroup: [u32; 3],
    dispatch: [u32; 3],
) -> ShaderTest {
    module_case(name, source, workgroup, expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &vec![SENTINEL; expected.len()],
        )],
        0,
        dispatch,
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        three_dimensional_observations(),
        independent_copies_and_receivers(),
        forward_helper_observations(),
    ]
}

fn three_dimensional_observations() -> ShaderTest {
    let mut expected = vec![SENTINEL; 8 * 24 * 16 + 16];
    for block_z in 0..2 {
        for block_y in 0..2 {
            for block_x in 0..2 {
                let block = block_x + 2 * (block_y + 2 * block_z);
                for local_z in 0..2 {
                    for local_y in 0..3 {
                        for local_x in 0..4 {
                            let local = local_x + 4 * (local_y + 3 * local_z);
                            let offset = (block * 24 + local) * 16;
                            expected[offset..offset + 16].copy_from_slice(&[
                                local_x as u32,
                                local_y as u32,
                                local_z as u32,
                                block_x as u32,
                                block_y as u32,
                                block_z as u32,
                                4,
                                3,
                                2,
                                4,
                                3,
                                2,
                                33,
                                local_x as u32 + 1,
                                local_x as u32,
                                2,
                            ]);
                        }
                    }
                }
            }
        }
    }
    output_case("thread block dimension queries preserve nominal values and every local, block and extent axis across a three-dimensional dispatch",
        FIXTURE, &expected, [4, 3, 2], [2, 2, 2])
}

fn independent_copies_and_receivers() -> ShaderTest {
    let mut expected = [SENTINEL; 80];
    for block in 0..2 {
        for lane in 0..2 {
            let offset = (block * 2 + lane) * 16;
            expected[offset..offset + 16].copy_from_slice(&[
                lane as u32,
                lane as u32 + 100,
                lane as u32,
                block as u32,
                2,
                2,
                4,
                if lane == 0 { 0 } else { block as u32 },
                5,
                2,
                2,
                7,
                lane as u32,
                1,
                0,
                2,
            ]);
        }
    }
    output_case("thread block dimension snapshots stay independent and erased temporary receivers preserve effects once in branches and loops",
        "namespace cg = cooperative_groups; using Block = cg::thread_block;
        __device__ void bump(dim3 &value) { ++value.y; }
        __global__ void effects(unsigned *output) {
            unsigned counter = 0u; auto group = cg::this_thread_block();
            dim3 local = (++counter, group).thread_index();
            dim3 block = Block((++counter, group)).group_index();
            dim3 extent = (++counter, cg::this_thread_block()).dim_threads();
            dim3 legacy = Block((++counter, group)).group_dim();
            dim3 saved = local; local.x += 100u;
            const dim3 fixed = group.thread_index();
            unsigned offset = (blockIdx.x * 2u + threadIdx.x) * 16u;
            output[offset] = saved.x; output[offset + 1u] = local.x;
            output[offset + 2u] = group.thread_index().x; output[offset + 3u] = block.x;
            output[offset + 4u] = extent.x; output[offset + 5u] = legacy.x; output[offset + 6u] = counter;
            dim3 selected = threadIdx.x ? (++counter, group).group_index() : (++counter, group).thread_index();
            output[offset + 7u] = selected.x; output[offset + 8u] = counter;
            for (unsigned iteration = 0u; iteration < 2u; ++iteration) {
                dim3 observed = (++counter, group).dim_threads();
                output[offset + 9u + iteration] = observed.x;
            }
            output[offset + 11u] = counter; output[offset + 12u] = fixed.x;
            bump(saved); output[offset + 13u] = saved.y;
            output[offset + 14u] = group.thread_index().y; output[offset + 15u] = extent.z + legacy.z;
        }", &expected, [2, 1, 1], [2, 1, 1])
}

fn forward_helper_observations() -> ShaderTest {
    let mut expected = [SENTINEL; 528];
    for block_z in 0..2 {
        for block_y in 0..2 {
            for block_x in 0..2 {
                let block = block_x + 2 * (block_y + 2 * block_z);
                for local_z in 0..2 {
                    for local_y in 0..2 {
                        for local_x in 0..2 {
                            let local = local_x + 2 * (local_y + 2 * local_z);
                            let offset = (block * 8 + local) * 8;
                            expected[offset..offset + 8].copy_from_slice(&[
                                local_x as u32,
                                local_y as u32,
                                local_z as u32,
                                block_x as u32,
                                block_y as u32,
                                block_z as u32,
                                222,
                                if local_y == 1 { 1 } else { 2 },
                            ]);
                        }
                    }
                }
            }
        }
    }
    output_case("forward dimension helpers initialize builtin state before calls and return independent nominal values across control flow",
        "namespace cg = cooperative_groups;
        __device__ dim3 local_position(); __device__ dim3 block_position(); __device__ dim3 block_shape();
        __global__ void observations(unsigned *output) {
            dim3 local = local_position(); dim3 block = block_position(); dim3 shape = block_shape();
            unsigned local_index = local.x + 2u * (local.y + 2u * local.z);
            unsigned block_index = block.x + 2u * (block.y + 2u * block.z);
            unsigned offset = (block_index * 8u + local_index) * 8u;
            output[offset] = local.x; output[offset + 1u] = local.y; output[offset + 2u] = local.z;
            output[offset + 3u] = block.x; output[offset + 4u] = block.y; output[offset + 5u] = block.z;
            output[offset + 6u] = shape.x + 10u * shape.y + 100u * shape.z;
            if (local.y == 1u) { output[offset + 7u] = 1u; return; }
            output[offset + 7u] = 2u;
        }
        __device__ dim3 block_shape() { auto group = cg::this_thread_block(); return group.group_dim(); }
        __device__ dim3 block_position() { return cg::thread_block::group_index(); }
        __device__ dim3 local_position() { return cg::this_thread_block().thread_index(); }",
        &expected, [2, 2, 2], [2, 2, 2])
}
