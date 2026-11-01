use super::{module_entry_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        neighbor("next_neighbor", &[11, 13, 15, 13, 31, 33, 35, 33]),
        neighbor("previous_neighbor", &[7, 5, 7, 9, 27, 25, 27, 29]),
        integer_parameters(),
        float_parameters(),
        atomic_records(),
        copied_records(),
    ]
}

fn neighbor(entry: &str, values: &[u32]) -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[..values.len()].copy_from_slice(values);
    module_entry_case(
        entry,
        include_str!("../../../../../naga/tests/in/cuda/multiple-kernels.cu"),
        [4, 1, 1],
        entry,
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 24],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[1_i32, 2, 3, 4, 11, 12, 13, 14],
            ),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[3_i32, 0, 0, 0]),
        ],
        0,
        [2, 1, 1],
    )
}

fn mixed_parameters() -> &'static str {
    "__global__ void add_integers(int *values, const int *input, int amount) {
        unsigned lane = threadIdx.x;
        int *cursor = values + lane;
        *cursor = input[lane] + amount;
    }
    __global__ void scale_floats(const float *values, float *input, float amount) {
        unsigned lane = threadIdx.x;
        input[lane] = values[lane] * amount;
    }"
}

fn integer_parameters() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[..4].copy_from_slice(&[13, 14, 16, 18]);
    module_entry_case(
        "integer entry restarts bindings with writable binding zero",
        mixed_parameters(),
        [4, 1, 1],
        "add_integers",
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 24],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[2_i32, 3, 5, 7],
            ),
            ShaderBuffer::new(2, wgpu::BufferBindingType::Uniform, &[11_i32, 0, 0, 0]),
        ],
        0,
        [1, 1, 1],
    )
}

fn float_parameters() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[..4].copy_from_slice(&[
        3.0_f32.to_bits(),
        (-4.0_f32).to_bits(),
        0.5_f32.to_bits(),
        8.0_f32.to_bits(),
    ]);
    module_entry_case(
        "float entry reuses ordinals with reversed pointer access",
        mixed_parameters(),
        [4, 1, 1],
        "scale_floats",
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[1.5_f32, -2.0, 0.25, 4.0],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 24],
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[2.0_f32.to_bits(), 0, 0, 0],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn record_operations() -> &'static str {
    "struct Record { unsigned value; unsigned untouched; };
    __device__ unsigned change(unsigned *value, unsigned amount) { return atomicAdd(value, amount); }
    __device__ Record copy_record(Record value) { value.untouched += 1u; return value; }
    __global__ void atomic_records(Record *records, unsigned *output) {
        unsigned lane = threadIdx.x;
        unsigned *selected = &records[lane].value;
        unsigned previous = change(selected, 2u);
        output[lane * 3u] = previous;
        output[lane * 3u + 1u] = records[lane].value;
        output[lane * 3u + 2u] = records[lane].untouched;
    }
    __global__ void copy_records(const Record *records, Record *output) {
        unsigned lane = threadIdx.x;
        output[lane] = copy_record(records[lane]);
    }"
}

fn atomic_records() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[..12].copy_from_slice(&[10, 12, 100, 20, 22, 200, 30, 32, 300, 40, 42, 400]);
    module_entry_case(
        "atomic record view belongs only to its entry",
        record_operations(),
        [4, 1, 1],
        "atomic_records",
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[10_u32, 100, 20, 200, 30, 300, 40, 400],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 24],
            ),
        ],
        1,
        [1, 1, 1],
    )
}

fn copied_records() -> ShaderTest {
    let mut expected = [SENTINEL; 24];
    expected[..8].copy_from_slice(&[10, 101, 20, 201, 30, 301, 40, 401]);
    module_entry_case(
        "readonly record copies retain ordinary values in another entry",
        record_operations(),
        [4, 1, 1],
        "copy_records",
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &[10_u32, 100, 20, 200, 30, 300, 40, 400],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[SENTINEL; 24],
            ),
        ],
        1,
        [1, 1, 1],
    )
}
