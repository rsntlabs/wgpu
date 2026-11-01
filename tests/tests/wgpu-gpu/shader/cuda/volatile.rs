use naga::{front::cuda::Options, valid::Capabilities};

use super::{module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn storage_cases() -> Vec<ShaderTest> {
    let source = "__device__ void put(volatile unsigned &value, unsigned replacement) {
            value = replacement;
        }
        __device__ unsigned pair(unsigned first, unsigned second) {
            return first * 100u + second;
        }
        __device__ unsigned replace(volatile unsigned *values) {
            values[0] = 999u; return values[0];
        }
        __global__ void observe(unsigned *values, unsigned *output) {
            volatile unsigned *watched = values;
            const volatile unsigned &view = watched[0];
            unsigned saved = view;
            put(watched[0], 9u);
            output[0] = saved + saved;
            output[1] = pair(view, (put(watched[0], 7u), view));
            unsigned index = 0u;
            watched[index++];
            output[2] = index;
            (watched[0] = 11u);
            ++watched[0]; watched[0]++;
            output[3] = watched[0];
            unsigned *ordinary = values;
            output[4] = *ordinary;
            bool skipped = false && bool(replace(watched));
            output[5] = view;
            output[6] = watched[1];
        }";
    let expected = [6u32, 907, 1, 13, 13, 13, 17, SENTINEL];
    let case = module_case_with_options_and_capabilities(
        "volatile storage snapshots, aliases, discarded reads and helper argument order",
        source,
        &Options::default(),
        &expected,
        Capabilities::MEMORY_DECORATION_VOLATILE,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[3u32, 17, SENTINEL, SENTINEL],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 8],
            ),
        ],
        1,
        [1, 1, 1],
    );
    vec![case]
}

pub(super) fn workgroup_cases() -> Vec<ShaderTest> {
    let mut sources = vec![(
        String::from("volatile shared snapshot fixture"),
        include_str!("../../../../../naga/tests/in/cuda/volatile-shared.cu").into(),
    )];
    for declaration in [
        "__shared__ unsigned values[4];",
        "__shared__ volatile unsigned values[4];",
        "extern __shared__ unsigned values[];",
    ] {
        let source = format!(
            "namespace cg = cooperative_groups;
            __device__ unsigned exchange(unsigned value, volatile unsigned *values,
                                         cg::thread_block group) {{
                unsigned lane = group.thread_rank();
                values[lane] = value;
                group.sync();
                const volatile unsigned &neighbor = values[(lane + 1u) % 4u];
                unsigned saved = neighbor;
                group.sync();
                values[lane] = saved + 17u;
                group.sync();
                return values[(lane + 3u) % 4u];
            }}
            __global__ void neighbors(unsigned *output) {{
                {declaration}
                auto group = cg::this_thread_block();
                unsigned lane = threadIdx.x;
                unsigned block = blockIdx.x;
                output[block * 4u + lane] = exchange(block * 1000u + lane, values, group);
            }}"
        );
        sources.push((
            format!("volatile shared pointer exchange through helpers: {declaration}"),
            source,
        ));
    }
    let mut cases = Vec::new();
    for (name, source) in sources {
        let mut expected = [SENTINEL; 16];
        for block in 0..3 {
            for lane in 0..4 {
                expected[block * 4 + lane] = block as u32 * 1000 + lane as u32 + 17;
            }
        }
        cases.push(
            module_case_with_options_and_capabilities(
                &name,
                &source,
                &Options {
                    workgroup_size: [4, 1, 1],
                    dynamic_shared_memory_size: 16,
                },
                &expected,
                Capabilities::MEMORY_DECORATION_VOLATILE_WORKGROUP,
            )
            .module_buffers(
                vec![ShaderBuffer::new(
                    0,
                    wgpu::BufferBindingType::Storage { read_only: false },
                    &[SENTINEL; 16],
                )],
                0,
                [3, 1, 1],
            ),
        );
    }
    cases
}
