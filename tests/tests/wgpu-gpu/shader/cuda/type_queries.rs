use super::{
    integer16::compare_words, module_case_with_options_and_capabilities, ShaderBuffer, ShaderTest,
};

const SENTINEL: u32 = 0xdead_beef;
const CAPACITY: usize = 80;

fn query_case(name: &str, source: &str, workgroup_size: [u32; 3], expected: &[u32]) -> ShaderTest {
    let mut test = module_case_with_options_and_capabilities(
        name,
        source,
        &naga::front::cuda::Options {
            workgroup_size,
            ..Default::default()
        },
        expected,
        naga::valid::Capabilities::SHADER_INT64,
    );
    test.output_comparison_fn = compare_words;
    test
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![layouts(), constant_types()];
    for byte_count in [0, 1, 3, 4, 7, 8, 255, 256, 257, 320, 323] {
        tests.push(copy_bytes(byte_count));
    }
    tests
}

fn layouts() -> ShaderTest {
    let mut source = String::from(
        "struct Record { float3 point; long tag; float2 offset; };
        struct AlignedRecord { float first; float4 vector; int last; };
        using Rows = int[2][3];
        __global__ void kernel(unsigned *output) {",
    );
    let mut values = Vec::new();
    for (ty, size, alignment) in [
        ("bool", 1, 1),
        ("int", 4, 4),
        ("unsigned", 4, 4),
        ("float", 4, 4),
        ("long", 8, 8),
        ("unsigned long", 8, 8),
        ("long long", 8, 8),
        ("unsigned long long", 8, 8),
        ("float1", 4, 4),
        ("float2", 8, 8),
        ("float3", 12, 4),
        ("float4", 16, 16),
        ("dim3", 12, 4),
        ("Record", 32, 8),
        ("AlignedRecord", 48, 16),
        ("Rows", 24, 4),
        ("float3[2]", 24, 4),
        ("float4[2]", 32, 16),
        ("const int * const &", 8, 8),
        ("void *", 8, 8),
        ("decltype(nullptr)", 8, 8),
        ("Rows &", 24, 4),
        ("float3 &&", 12, 4),
    ] {
        let output = values.len() + 4;
        source.push_str(&format!(
            "output[{output}] = unsigned(sizeof({ty}));
             output[{}] = unsigned(alignof({ty}));",
            output + 1,
        ));
        values.extend([size, alignment]);
    }
    source.push_str("}");
    let mut expected = vec![SENTINEL; values.len() + 8];
    expected[4..4 + values.len()].copy_from_slice(&values);
    query_case(
        "type queries preserve CUDA scalar, packed vector, record and reference layouts",
        &source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &vec![SENTINEL; expected.len()],
        )],
        0,
        [1, 1, 1],
    )
}

fn constant_types() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[4..17].copy_from_slice(&[2, 2, 3, 1, 2, 1, 2, 12, 16, 4, 11, 16, 8]);
    query_case(
        "type query constants retain size_t identity through templates, aliases and bounds",
        "constexpr size_t length = sizeof(float4) / sizeof(float);
        __device__ unsigned kind(unsigned value) { return 1u; }
        __device__ unsigned kind(unsigned long value) { return 2u; }
        __device__ unsigned kind(unsigned long long value) { return 3u; }
        template<class Value> __device__ unsigned deduced(Value value) { return kind(Value()); }
        template<class Value> __device__ size_t bytes() { return sizeof(Value); }
        template<class Value> __device__ size_t alignment() { return alignof(Value); }
        __global__ void kernel(unsigned *output) {
            unsigned values[length] = {3u, 5u, 7u, 11u};
            output[4] = kind(sizeof(int));
            output[5] = kind(alignof(float4));
            output[6] = kind(4ULL);
            output[7] = kind(4u);
            output[8] = deduced(sizeof(float3));
            using size_t = unsigned;
            output[9] = kind(size_t());
            output[10] = kind(sizeof(int));
            output[11] = unsigned(bytes<float3>());
            output[12] = unsigned(alignment<float4>());
            output[13] = unsigned(length);
            output[14] = values[length - 1UL];
            output[15] = unsigned(sizeof(int[sizeof(int)]));
            output[16] = unsigned(alignof(float2[]));
        }",
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 24],
        )],
        0,
        [1, 1, 1],
    )
}

fn copy_bytes(byte_count: u64) -> ShaderTest {
    let input: Vec<u32> = (0..CAPACITY)
        .map(|index| (index as u32).wrapping_mul(0x9e37_79b9) ^ 0x8765_4321)
        .collect();
    let mut expected = [SENTINEL; CAPACITY + 8];
    let copied = (byte_count / 4) as usize;
    expected[4..4 + copied].copy_from_slice(&input[..copied]);
    query_case(
        &format!(
            "sizeof controls byte-counted copies and preserves remainder bytes, count {byte_count}"
        ),
        "__global__ void copy(const int *input, int *output, size_t bytes) {
            unsigned step = gridDim.x * blockDim.x;
            unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
            for (; index < bytes / sizeof(int); index += step) {
                output[index + 4u] = input[index];
            }
        }",
        [64, 1, 1],
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
                &[SENTINEL; CAPACITY + 8],
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[
                    byte_count as u32,
                    (byte_count >> 32) as u32,
                    0xa55a_a55a,
                    0x5aa5_5aa5,
                ],
            ),
        ],
        1,
        [4, 1, 1],
    )
}
