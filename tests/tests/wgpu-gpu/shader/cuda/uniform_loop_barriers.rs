use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/uniform-loop-barriers.cu");
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![reduction(0), reduction(13), neighbor_phases()]
}

fn reduction(count: u32) -> ShaderTest {
    let input: Vec<u32> = if count == 0 {
        vec![SENTINEL]
    } else {
        (1..=count).chain(101..101 + count).collect()
    };
    let mut expected = [SENTINEL; 32];
    expected[..2].copy_from_slice(match count {
        0 => &[0, 0],
        13 => &[91, 1391],
        _ => unreachable!(),
    });
    module_case(
        &format!("uniform reduction barriers follow reconverged gathers with count {count}"),
        FIXTURE,
        [8, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 32],
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[count, SENTINEL, SENTINEL, SENTINEL],
            ),
        ],
        1,
        [2, 1, 1],
    )
}

fn neighbor_phases() -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..8].copy_from_slice(&[7, 4, 5, 6, 17, 14, 15, 16]);
    module_case(
        "two uniform barriers per phase preserve cross-lane read snapshots before shared writes",
        "namespace cg = cooperative_groups;
        __global__ void phases(unsigned *output) {
            auto group = cg::this_thread_block();
            __shared__ unsigned values[4];
            unsigned lane = threadIdx.x;
            values[lane] = blockIdx.x * 10u + lane + 1u;
            for (unsigned phase = 0u; phase < 3u; ++phase) {
                group.sync();
                unsigned next = values[(lane + 1u) % 4u];
                cg::thread_block::sync();
                values[lane] = next + phase;
            }
            group.sync();
            output[blockIdx.x * 4u + lane] = values[lane];
        }",
        [4, 1, 1],
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
