use super::{integer16::compare_words, module_case, ShaderBuffer, ShaderTest};

pub(super) const FLOAT_BITS: [u32; 24] = [
    0x0000_0000,
    0x8000_0000,
    0x0000_0001,
    0x8000_0001,
    0x007f_ffff,
    0x807f_ffff,
    0x0080_0000,
    0x8080_0000,
    0x7f7f_ffff,
    0xff7f_ffff,
    0x7f80_0000,
    0xff80_0000,
    0x7fc0_0000,
    0xffc0_0000,
    0x7fc1_2345,
    0xffc5_4321,
    0x7f80_0001,
    0xff80_0001,
    0x7fbf_ffff,
    0xffbf_ffff,
    0x3f80_0000,
    0xbf80_0000,
    0x4000_0000,
    0xc000_0000,
];

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut input = FLOAT_BITS.to_vec();
    input.extend((0..65536_u32).map(|index| {
        let exponent = 1 + index % 254;
        let sign = (index / 254) & 1;
        let fraction = index.wrapping_mul(123457) & 0x007f_ffff;
        (sign << 31) | (exponent << 23) | fraction
    }));
    let mut tests = vec![case(input.len() as u32, &input, input.len())];
    for count in [0, 1, 3, 4, 5, 7, 24] {
        tests.push(case(count, &input, FLOAT_BITS.len()));
    }
    tests.push(uniform_barrier_case());
    tests
}

fn case(count: u32, input: &[u32], record_count: usize) -> ShaderTest {
    let source =
        "__global__ void truthiness(const float *input, unsigned *output, unsigned count) {
        unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
        if (index >= count) return;
        float value = input[index];
        unsigned effects = 0;
        bool copied = (effects++, value);
        bool direct((effects++, value));
        bool functional = bool((effects++, value));
        bool named = static_cast<bool>(value);
        bool c_style = (bool)value;
        const bool &retained(value);
        unsigned branch = 17u;
        if (value) branch = 13u;
        unsigned base = (index + 1u) * 12u;
        output[base] = unsigned(copied);
        output[base + 1u] = unsigned(direct);
        output[base + 2u] = unsigned(functional);
        output[base + 3u] = unsigned(named);
        output[base + 4u] = unsigned(c_style);
        output[base + 5u] = unsigned(retained);
        output[base + 6u] = unsigned(!value);
        output[base + 7u] = value ? 7u : 11u;
        output[base + 8u] = unsigned(value && true);
        output[base + 9u] = unsigned(false || value);
        output[base + 10u] = effects;
        output[base + 11u] = branch;
    }";
    let initial = vec![0xdead_beef_u32; (record_count + 4) * 12];
    let mut expected = initial.clone();
    for (index, &bits) in input.iter().take(count as usize).enumerate() {
        let present = bits & 0x7fff_ffff != 0;
        let truth = u32::from(present);
        expected[(index + 1) * 12..(index + 2) * 12].copy_from_slice(&[
            truth,
            truth,
            truth,
            truth,
            truth,
            truth,
            1 - truth,
            if present { 7 } else { 11 },
            truth,
            truth,
            3,
            if present { 13 } else { 17 },
        ]);
    }
    let mut test = module_case(
        &format!("float truthiness count {count} preserves all conversion paths and guards"),
        source,
        [64, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &input[..record_count],
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[count, 0x0123_4567, 0x89ab_cdef, 0x1357_9bdf],
            ),
        ],
        1,
        [count.div_ceil(64) + 1, 1, 1],
    );
    test.output_comparison_fn = compare_words;
    test
}

fn uniform_barrier_case() -> ShaderTest {
    let source = "__device__ void synchronize(float value) { if (value) __syncthreads(); }
        __global__ void uniform_truth(const float *input, unsigned *output) {
            for (unsigned index = 0; index < 24u; ++index) {
                if (input[index]) __syncthreads();
                synchronize(input[index]);
                output[(index + 1u) * 4u + threadIdx.x] = unsigned(bool(input[index]));
            }
        }";
    let initial = [0xdead_beef_u32; 112];
    let mut expected = initial;
    for (index, &bits) in FLOAT_BITS.iter().enumerate() {
        expected[(index + 1) * 4..(index + 2) * 4].fill(u32::from(bits & 0x7fff_ffff != 0));
    }
    let mut test = module_case(
        "uniform float conditions preserve direct and device-helper barriers",
        source,
        [4, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: true },
                &FLOAT_BITS,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
        ],
        1,
        [1, 1, 1],
    );
    test.output_comparison_fn = compare_words;
    test
}
