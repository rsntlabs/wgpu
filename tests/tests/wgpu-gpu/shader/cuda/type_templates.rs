use super::{module_case, module_entry_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/type-templates.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        copy_unsigned(),
        copy_float_bits(),
        helper_values_and_aliases(),
        rank_before_lowering(),
        nonliteral_zero_overload_selection(),
        deduction_and_overload_selection(),
    ]
}

fn copy_unsigned() -> ShaderTest {
    let input = [
        1u32,
        3,
        7,
        u32::MAX,
        0,
        0x8000_0000,
        29,
        0x1234_5678,
        0x0bad_f00d,
    ];
    let mut expected = [SENTINEL; 24];
    expected[..7].copy_from_slice(&input[..7]);
    copy_case("copy_typed<unsigned>", &input, &expected)
}

fn copy_float_bits() -> ShaderTest {
    let input = [
        -0.0f32,
        0.0,
        1.25,
        -3.5,
        1234.5,
        -1_048_576.0,
        1.0e-20,
        99.25,
        77.5,
    ];
    let mut expected = [SENTINEL; 24];
    for (target, value) in expected[..7].iter_mut().zip(&input) {
        *target = value.to_bits();
    }
    copy_case("copy_typed<float>", &input, &expected)
}

fn copy_case<Value: bytemuck::Pod>(entry: &str, input: &[Value], expected: &[u32]) -> ShaderTest {
    module_entry_case(
        &format!("type instance {entry} copies seven values and keeps guarded output words"),
        FIXTURE,
        [4, 1, 1],
        entry,
        expected,
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
                input,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Uniform,
                &[7u32, 0x1357_9bdf, 0x2468_ace0, 0x55aa_cc33],
            ),
        ],
        0,
        [3, 1, 1],
    )
}

fn helper_values_and_aliases() -> ShaderTest {
    let source = "struct Record { unsigned value; unsigned tag; };
        template<class Value> __device__ Value identity(Value value) { return value; }
        template<class Value> __device__ Value next(Value value) { return value + Value(1); }
        template<class Result, class Input> __device__ Result converted(Input value) { return Result(value); }
        template<class Value> __device__ void change(Value &value, Value ignored) { value += Value(2); }
        template<class Value> __device__ Value observed(const Value &value, Value ignored) { return value; }
        template<class Value> __device__ Value snapshot(Value value, Value ignored) { return value; }
        __device__ unsigned category(unsigned &value) { return 1u; }
        __device__ unsigned category(const unsigned &value) { return 2u; }
        template<class Value> __device__ unsigned classified(Value value) { return category(value); }
        template<class Pointer> __device__ unsigned pointed(Pointer value) { return *value; }
        template<class Value> __device__ unsigned selected(Value *value) { return 1u; }
        template<class Value> __device__ unsigned selected(Value value) { return 2u; }
        __global__ void helpers(unsigned *output) {
            unsigned counter = 2u;
            output[0] = next<unsigned>(counter++);
            output[1] = next<unsigned>(next<unsigned>(counter++));
            output[2] = counter;
            output[3] = unsigned(converted<int, float>(2.75f));
            change<unsigned>(counter, (counter = 9u));
            output[4] = counter;
            output[5] = observed<unsigned>(counter, (counter = 17u));
            output[6] = counter;
            output[7] = snapshot<unsigned>(counter, (counter = 23u));
            output[8] = counter;
            Record record{5u, 9u}; Record copied = identity<Record>(record);
            output[9] = copied.value + copied.tag;
            float2 pair = identity<float2>(make_float2(1.25f, -2.0f));
            output[10] = __float_as_uint(pair.x);
            output[11] = classified<unsigned>(0u);
            output[12] = classified<const unsigned>(0u);
            output[13] = pointed<const unsigned *>(output + 11u);
            output[14] = selected<unsigned *>(output);
        }";
    let mut expected = [SENTINEL; 32];
    expected[..15].copy_from_slice(&[
        3,
        5,
        4,
        2,
        11,
        17,
        17,
        17,
        23,
        14,
        1.25f32.to_bits(),
        1,
        2,
        1,
        2,
    ]);
    module_case(
        "typed helpers preserve snapshots, live aliases, aggregate values and explicit const type identity",
        source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 32])],
        0,
        [1, 1, 1],
    )
}

fn rank_before_lowering() -> ShaderTest {
    let source = "template<class Value> __device__ unsigned scalar_argument(Value &) { return 1u; }
        template<class Value> __device__ unsigned scalar_argument(unsigned value) { return 2u; }
        template<class Value> __device__ unsigned pointer_temporary(Value &) { return 1u; }
        template<class Value> __device__ unsigned pointer_temporary(Value value) { return 2u; }
        template<class Value> __device__ Value return_type(float value) { return Value(0); }
        template<class Value> __device__ unsigned return_type(unsigned value) { return 2u; }
        __global__ void kernel(unsigned *output) {
            output[0] = scalar_argument<unsigned *>(3u);
            output[1] = pointer_temporary<unsigned *>(output + 1u);
            output[2] = return_type<unsigned *>(3u);
        }";
    let mut expected = [SENTINEL; 32];
    expected[..3].copy_from_slice(&[2, 2, 2]);
    module_case(
        "template candidates rank before unsupported signatures or return types are lowered",
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

fn nonliteral_zero_overload_selection() -> ShaderTest {
    let source =
        "template<class Pointer> __device__ unsigned selected(const Pointer &) { return 1u; }
        template<class Pointer> __device__ unsigned selected(dim3 value) { return 2u; }
        __global__ void kernel(unsigned *output) {
            constexpr unsigned zero = 0u;
            output[0] = selected<unsigned *>(zero);
            output[1] = selected<unsigned *>(int(0));
            output[2] = selected<unsigned *>(1 - 1);
            output[3] = selected<unsigned *>(+0);
            output[4] = selected<unsigned *>(false);
            unsigned counter = 0u;
            output[5] = selected<unsigned *>(++counter - 1u);
            output[6] = counter;
        }";
    let mut expected = [SENTINEL; 32];
    expected[..7].copy_from_slice(&[2, 2, 2, 2, 2, 2, 1]);
    module_case(
        "nonliteral zero selects dim3 conversion and evaluates arguments once",
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

fn deduction_and_overload_selection() -> ShaderTest {
    let source = "__device__ unsigned selected(unsigned value) { return value + 100u; }
        template<class Value> __device__ unsigned selected(Value value) { return unsigned(value) + 200u; }
        template<class Value> __device__ unsigned pattern(Value value) { return 1u; }
        template<class Value> __device__ unsigned pattern(Value *value) { return 2u; }
        template<class Value> __device__ unsigned pattern(const Value *value) { return 3u; }
        template<class Value> __device__ Value identity(Value value) { return value; }
        template<class Result, class Input> __device__ Result converted(Input value) { return Result(value); }
        template<class Pointer> __device__ unsigned first(Pointer pointer) { return *pointer; }
        template<class Value> __device__ unsigned changed(Value &value) { value += Value(2); return unsigned(value); }
        template<class Value> __device__ unsigned observed(const Value &value, Value ignored) { return unsigned(value); }
        template<class Value> __device__ unsigned snapshot(Value value, Value ignored) { return unsigned(value); }
        __device__ unsigned category(unsigned &value) { return 1u; }
        __device__ unsigned category(const unsigned &value) { return 2u; }
        template<class Value> __device__ unsigned classified(Value &value) { return category(value); }
        __global__ void kernel(unsigned *output) {
            unsigned counter = 2u;
            output[0] = identity(counter++);
            output[1] = identity<>(counter++);
            output[2] = unsigned(converted<int>(2.75f));
            output[3] = selected(5u);
            output[4] = selected(5);
            output[5] = selected<>(5u);
            output[6] = pattern(output);
            const unsigned *input = output;
            output[7] = pattern(input);
            output[8] = pattern(counter);
            unsigned local[2]{11u, 13u};
            output[9] = first(local);
            output[10] = changed(counter);
            output[11] = observed(counter, (counter = 17u));
            output[12] = snapshot(counter, (counter = 23u));
            output[13] = counter;
            const unsigned immutable = 29u;
            output[14] = identity(immutable);
            output[15] = classified(immutable);
        }";
    let mut expected = [SENTINEL; 32];
    expected[..16].copy_from_slice(&[2, 3, 2, 105, 205, 205, 2, 3, 1, 11, 6, 17, 17, 23, 29, 2]);
    module_case(
        "deduced helpers preserve conversion ranking, pointer patterns, qualifiers and argument effects",
        source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(0, wgpu::BufferBindingType::Storage { read_only: false }, &[SENTINEL; 32])],
        0,
        [1, 1, 1],
    )
}
