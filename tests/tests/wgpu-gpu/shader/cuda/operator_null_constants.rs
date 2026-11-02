use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![converted_zeros(), logical_effects()]
}

fn converted_zeros() -> ShaderTest {
    guarded_case(
        "converted and computed zero values select dimension overloads in ordinary, explicit and infix calls",
        r#"
#define ZERO (1u - 1u)
struct Box { unsigned value; };
using Zero = const unsigned;
__device__ unsigned selected(unsigned *value) { return 901u; }
__device__ unsigned selected(float *value) { return 903u; }
__device__ unsigned selected(dim3 value) { return 17u + value.x; }
__device__ unsigned operator+(Box left, unsigned *right) { return 901u; }
__device__ unsigned operator+(Box left, float *right) { return 903u; }
__device__ unsigned operator+(Box left, dim3 right) { return 20u + left.value + right.x; }
__device__ unsigned operator+(unsigned *left, Box right) { return 901u; }
__device__ unsigned operator+(float *left, Box right) { return 903u; }
__device__ unsigned operator+(dim3 left, Box right) { return 30u + left.x + right.value; }
__device__ unsigned operator<<(Box left, unsigned *right) { return 901u; }
__device__ unsigned operator<<(Box left, float *right) { return 903u; }
__device__ unsigned operator<<(Box left, dim3 right) { return 40u + left.value + right.x; }
__device__ unsigned operator<<(unsigned *left, Box right) { return 901u; }
__device__ unsigned operator<<(float *left, Box right) { return 903u; }
__device__ unsigned operator<<(dim3 left, Box right) { return 50u + left.x + right.value; }
__global__ void kernel(unsigned *output) {
    constexpr unsigned named_zero = 0u;
    unsigned stored_zero = 0u;
    const unsigned &reference_zero = stored_zero;
    output[0] = selected(unsigned(0u));
    output[1] = selected(static_cast<unsigned>(0u));
    output[2] = selected((unsigned)0u);
    output[3] = selected(1u - 1u);
    output[4] = selected(+0);
    output[5] = selected(-0);
    output[6] = selected(false);
    output[7] = selected(0.0f);
    output[8] = selected(named_zero);
    output[9] = selected(reference_zero);
    output[10] = selected(dim3(0));
    output[11] = selected((1u, 0u));
    output[12] = selected(true ? 0u : 0u);
    output[13] = Box{3u} + unsigned(0u);
    output[14] = static_cast<unsigned>(0u) + Box{3u};
    output[15] = operator+(Box{3u}, (unsigned)0u);
    output[16] = operator+(1u - 1u, Box{3u});
    output[17] = Box{3u} << +0;
    output[18] = false << Box{3u};
    output[19] = Box{3u} + named_zero;
    output[20] = reference_zero + Box{3u};
    output[21] = selected(ZERO);
    output[22] = selected(Zero(0u));
    output[23] = Box{3u} + (true ? 0u : 0u);
}
"#,
        &[
            17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 23, 33, 23, 33, 43, 53,
            23, 33, 17, 17, 23,
        ],
    )
}

fn logical_effects() -> ShaderTest {
    guarded_case(
        "overloaded logical calls evaluate both operands once while scalar logical operations short circuit",
        r#"
struct Box { unsigned value; };
__device__ unsigned operator&&(Box left, unsigned *right) { return 901u; }
__device__ unsigned operator&&(Box left, float *right) { return 903u; }
__device__ unsigned operator&&(Box left, dim3 right) { return 100u + left.value * 10u + right.x; }
__device__ unsigned operator||(unsigned *left, Box right) { return 901u; }
__device__ unsigned operator||(float *left, Box right) { return 903u; }
__device__ unsigned operator||(dim3 left, Box right) { return 200u + left.x * 10u + right.value; }
__device__ unsigned operator||(Box left, unsigned *right) { return 901u; }
__device__ unsigned operator||(Box left, float *right) { return 903u; }
__device__ unsigned operator||(Box left, dim3 right) { return 300u + left.value * 10u + right.x; }
__device__ unsigned operator&&(unsigned *left, Box right) { return 901u; }
__device__ unsigned operator&&(float *left, Box right) { return 903u; }
__device__ unsigned operator&&(dim3 left, Box right) { return 400u + left.x * 10u + right.value; }
__global__ void kernel(unsigned *output) {
    unsigned counter = 0u;
    output[0] = Box{counter++} && (counter++, 0u);
    output[1] = counter;
    output[2] = (counter++, 0u) || Box{counter++};
    output[3] = counter;
    output[4] = Box{counter++} || unsigned(0u);
    output[5] = counter;
    output[6] = static_cast<unsigned>(0u) && Box{counter++};
    output[7] = counter;
    output[8] = unsigned(false && ++counter);
    output[9] = unsigned(true || ++counter);
    output[10] = counter;
    output[11] = Box{counter++} && (true ? (++counter, 0u) : (counter += 100u, 0u));
    output[12] = counter;
    output[13] = (counter++, 0u) || Box{counter++};
    output[14] = counter;
}
"#,
        &[100, 2, 203, 4, 340, 5, 405, 6, 0, 1, 6, 160, 8, 209, 10],
    )
}

fn guarded_case(name: &str, source: &str, values: &[u32]) -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..values.len()].copy_from_slice(values);
    module_case(name, source, [1, 1, 1], &expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [1, 1, 1],
    )
}
