use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/pragma-unroll.cu");
const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![loop_control_flow(), macros_scopes_and_helper_returns()]
}

fn loop_control_flow() -> ShaderTest {
    let mut expected = [SENTINEL; 64];
    expected[..48].copy_from_slice(&[
        3, 4, 3, 6, 3, 3, 2, 4, 36, 13, 4, 3, 12, 6, 5, 6, 3, 3, 2, 12, 36, 13, 4, 7, 0, 1, 0, 6,
        3, 3, 2, 20, 36, 13, 4, 0, 3, 3, 2, 6, 3, 3, 2, 28, 36, 13, 4, 2,
    ]);
    module_case("unroll hints preserve dynamic trip counts, break, continue, loop tests, increments and helper values", FIXTURE, [4, 1, 1], &expected)
        .module_buffers(vec![
            ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: true }, &[3u32, 7, 0, 2, SENTINEL, SENTINEL, SENTINEL, SENTINEL]),
            ShaderBuffer::new(1, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 64]),
        ], 1, [2, 1, 1])
}

fn macros_scopes_and_helper_returns() -> ShaderTest {
    let mut expected = [SENTINEL; 48];
    expected[..32].copy_from_slice(&[
        0, 0, 7, 0, 0, 14, 3, 0, 1, 1, 12, 4, 12, 14, 3, 1, 12, 2, 7, 2, 0, 14, 3, 2, 12, 3, 12, 6,
        12, 14, 3, 3,
    ]);
    module_case("raw unroll factors preserve lexical constants while loop macros, lazy helper calls and early returns retain their effects",
        "constexpr int Factor = 4;
        #define DOUBLE(value) ((value) + (value))
        #define LIMIT 3u
        #define LOOP for
        #if 0
        #pragma unroll missing(
        #endif
        __device__ unsigned visit(unsigned &seen, unsigned &total, unsigned bound) {
            const int Count = 4;
        #pragma unroll Count
            for (unsigned index = 0u; index < bound; ++index) {
                ++seen; if (index == 2u) return total;
                total = total * 10u + index + DOUBLE(1u) - 1u;
            }
            return total;
        }
        __global__ void scoped(unsigned *output) {
            unsigned lane = threadIdx.x, offset = lane * 8u;
            unsigned seen = 0u, total = 0u;
            output[offset] = visit(seen, total, lane); output[offset + 1u] = seen;
            unsigned value = 0u;
            output[offset + 2u] = lane % 2u ? visit(seen, value, 4u) : 7u;
            output[offset + 3u] = seen; output[offset + 4u] = value;
            unsigned product = 1u;
            { const int Count = 2;
            #pragma unroll Count + 1
                LOOP (unsigned Count = 0u; Count < LIMIT; ++Count) product *= 2u;
            }
            { constexpr unsigned Count = 1u;
            #pragma unroll Count + 1u
                for (unsigned index = 0u; index < 2u; ++index) product += 3u;
            }
            unsigned repeated = 0u;
            #define Factor 1
            #pragma unroll Factor
            #pragma unroll 2 COUNT(missing)
            for (unsigned index = 0u; index < LIMIT; ++index) repeated += index;
            output[offset + 5u] = product; output[offset + 6u] = repeated; output[offset + 7u] = lane;
        }", [4, 1, 1], &expected)
        .module_buffers(vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 48])], 0, [1, 1, 1])
}
