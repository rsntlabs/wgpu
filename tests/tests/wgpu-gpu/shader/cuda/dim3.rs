use super::{module_case, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/dim3.cu");
const SENTINEL: u32 = 0xdead_beef;

fn output_case(
    name: &str,
    source: &str,
    initial: &[u32],
    expected: &[u32],
    workgroup_size: [u32; 3],
    dispatch: [u32; 3],
) -> ShaderTest {
    module_case(name, source, workgroup_size, expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            initial,
        )],
        0,
        dispatch,
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        constructors_and_values(),
        genuine_constructor_expressions(),
        nested_defaults(),
        three_dimensions(),
    ]
}

fn constructors_and_values() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..27].copy_from_slice(&[
        1, 1, 1, 111, 112, 143, 765, 766, 766, 911, 0, 7, 6, 11, 22, 118, 121, 6, 7, 766, 2, 3, 6,
        7, 8, 8, 111,
    ]);
    output_case("dim3 defaults, partial and scalar construction, nominal overloads, conversions and independent value copies",
        FIXTURE, &initial, &expected, [1, 1, 1], [1, 1, 1])
}

fn nested_defaults() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..26].copy_from_slice(&[
        111, 111, 112, 143, 111, 0, 111, 111, 111, 111, 111, 111, 0, 0, 7, 111, 111, 0, 112, 109,
        108, 109, 7, 108, 9, 111,
    ]);
    output_case("dim3 recursive default construction reaches bare arrays, omitted tails and nested records while numeric fields retain zero initialization",
        "struct Leaf { dim3 shape; uint3 raw; };
        struct Packet { unsigned tag; Leaf leaves[2]; dim3 grid[2][2]; unsigned tail; };
        struct Wrapper { dim3 shape; unsigned tail; }; struct Only { dim3 shape; }; struct Nested { Only values[2]; };
        __device__ unsigned encode(dim3 value) { return value.x + 10u * value.y + 100u * value.z; }
        __global__ void defaults(unsigned *output) {
            dim3 bare[2]; dim3 partial[3]{dim3(2u), dim3(3u, 4u)};
            Packet empty{}; Packet partial_record{7u};
            output[0] = encode(bare[0]); output[1] = encode(bare[1]);
            output[2] = encode(partial[0]); output[3] = encode(partial[1]); output[4] = encode(partial[2]);
            output[5] = empty.tag;
            output[6] = encode(empty.leaves[0].shape); output[7] = encode(empty.leaves[1].shape);
            output[8] = encode(empty.grid[0][0]); output[9] = encode(empty.grid[0][1]);
            output[10] = encode(empty.grid[1][0]); output[11] = encode(empty.grid[1][1]);
            output[12] = empty.leaves[0].raw.x + empty.leaves[1].raw.z; output[13] = empty.tail;
            output[14] = partial_record.tag; output[15] = encode(partial_record.leaves[1].shape);
            output[16] = encode(partial_record.grid[1][1]); output[17] = partial_record.tail;
            int runtime = -2; dim3 scalar_values[3]{2u, -1, runtime};
            Wrapper first{-1, 7u}, second{runtime, 9u}; const Nested fixed;
            output[18] = encode(scalar_values[0]); output[19] = encode(scalar_values[1]); output[20] = encode(scalar_values[2]);
            output[21] = encode(first.shape); output[22] = first.tail;
            output[23] = encode(second.shape); output[24] = second.tail; output[25] = encode(fixed.values[1].shape);
        }", &initial, &expected, [1, 1, 1], [1, 1, 1])
}

fn three_dimensions() -> ShaderTest {
    let initial = [SENTINEL; 496];
    let mut expected = initial;
    for group in 0..2 {
        for rank in 0..24 {
            let offset = (group * 24 + rank) * 10;
            expected[offset..offset + 10].copy_from_slice(&[
                rank as u32,
                111,
                rank as u32 + 111,
                24,
                5,
                4,
                111,
                111,
                0,
                33,
            ]);
        }
    }
    output_case("dim3 data values preserve three-dimensional coordinates, packed conversions, default subobjects and copy identity",
        "struct Config { dim3 shape; uint3 raw; };
        __device__ unsigned encode(dim3 value) { return value.x + 10u * value.y + 100u * value.z; }
        __device__ unsigned kind(dim3 value) { return 11u; }
        __device__ unsigned kind(uint3 value) { return 22u; }
        __global__ void coordinates(unsigned *output) {
            unsigned coordinate_index = threadIdx.x + 4u * (threadIdx.y + 3u * threadIdx.z);
            unsigned offset = (blockIdx.x * 24u + coordinate_index) * 10u;
            const dim3 fixed; dim3 shape = make_uint3(4u, 3u, 2u);
            uint3 packed = shape; dim3 copied = packed; ++copied.x;
            dim3 partial(coordinate_index + 1u); dim3 values[2]{dim3(2u, 3u)}; Config config{};
            output[offset] = threadIdx.x + shape.x * (threadIdx.y + shape.y * threadIdx.z);
            output[offset + 1u] = encode(fixed); output[offset + 2u] = encode(partial);
            output[offset + 3u] = shape.x * shape.y * shape.z;
            output[offset + 4u] = copied.x; output[offset + 5u] = shape.x;
            output[offset + 6u] = encode(values[1]); output[offset + 7u] = encode(config.shape);
            output[offset + 8u] = config.raw.x + config.raw.y + config.raw.z;
            output[offset + 9u] = kind(shape) + kind(packed);
        }", &initial, &expected, [4, 3, 2], [2, 1, 1])
}

fn genuine_constructor_expressions() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..7].copy_from_slice(&[4, 3, 30, 41, 8, 71, 3]);
    output_case(
        "dim3 constructors preserve copies, nested calls and comma effects",
        "using Shape = dim3; using Count = unsigned;
        __device__ unsigned observe(unsigned &counter) { ++counter; return counter + 2u; }
        __device__ dim3 produce(unsigned &counter) { ++counter; return dim3(counter, 5u, 7u); }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 0u;
            dim3 defaulted;
            dim3 one(2u), two(3u, 4u), three(5u, 6u, 7u);
            dim3 source(11u, 13u, 17u);
            Shape copied((source));
            Shape forced((Shape(source)));
            Shape scalar(Count(observe(counter)));
            Shape returned(produce(counter));
            Shape typed(Shape(produce(counter)));
            Shape comma((++counter, source));
            uint3 packed{19u, 23u, 29u};
            Shape converted(packed);
            dim3 forced_empty((dim3()));
            output[0] = counter;
            output[1] = defaulted.x + defaulted.y + defaulted.z;
            output[2] = one.x + one.y + one.z + two.x + two.y + two.z + three.x + three.y + three.z;
            output[3] = copied.x + forced.y + comma.z;
            output[4] = scalar.x + returned.x + typed.x;
            output[5] = converted.x + converted.y + converted.z;
            output[6] = forced_empty.x + forced_empty.y + forced_empty.z;
        }",
        &initial,
        &expected,
        [1, 1, 1],
        [1, 1, 1],
    )
}
