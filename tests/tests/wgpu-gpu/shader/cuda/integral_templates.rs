use super::{module_case, module_entry_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/integral-templates.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        reduction("reduce<4>", 4),
        reduction("reduce<8>", 8),
        helper_arguments(),
    ]
}

fn reduction(entry: &str, bias: u32) -> ShaderTest {
    let mut expected = [SENTINEL; 16];
    for block in 0..2 {
        let sum = if block == 0 { 10 } else { 26 };
        expected[block * 4..block * 4 + 4].fill(sum + bias);
    }
    module_entry_case(
        &format!("integral template {entry} keeps its shared extent and selected interface"),
        FIXTURE,
        [4, 1, 1],
        entry,
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 16],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[1u32, 2, 3, 4, 5, 6, 7, 8],
            ),
        ],
        0,
        [2, 1, 1],
    )
}

fn helper_arguments() -> ShaderTest {
    let source = "__device__ unsigned choose(unsigned value) { return value + 100u; }
        template<int Bias> __device__ unsigned choose(unsigned value) { return value + unsigned(Bias); }
        template<bool Enabled, int Scale> __device__ unsigned weighted(unsigned value) {
            return Enabled ? value * unsigned(Scale) : value;
        }
        template<unsigned Scale> __device__ unsigned pack(unsigned first, unsigned second) {
            return first * Scale + second;
        }
        __device__ unsigned selected(float value) { return unsigned(value) + 10u; }
        template<int Count> __device__ unsigned earlier(unsigned value) { return selected(Count) + value; }
        __device__ unsigned selected(int value) { return unsigned(value) + 20u; }
        __global__ void arguments(unsigned *output) {
            unsigned counter = 2u;
            output[0] = choose(7u);
            output[1] = choose<3>(counter++);
            output[2] = choose<4>(choose<5>(counter++));
            output[3] = counter;
            output[4] = weighted<true, 3>(5u);
            output[5] = weighted<false, 7>(9u);
            bool skipped = false && bool(choose<9>(counter++));
            output[6] = counter;
            output[7] = pack<10u>(counter++, counter++);
            output[8] = counter;
            output[9] = earlier<4>(7u);
        }";
    let mut expected = [SENTINEL; 32];
    expected[..10].copy_from_slice(&[107, 5, 12, 4, 15, 9, 4, 45, 6, 21]);
    module_case(
        "integral helpers keep overloads, argument snapshots, lazy calls and definition lookup",
        source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [1, 1, 1],
    )
}
