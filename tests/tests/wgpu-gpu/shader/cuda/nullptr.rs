use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        literal_and_named_values(),
        helper_effects(0),
        helper_effects(1),
        reference_aliases(),
        synchronization_result(),
        backend_fixture(),
        direct_boolean_initializers(),
    ]
}

fn literal_and_named_values() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 53;
    let mut expected = initial;
    expected[..19].copy_from_slice(&[
        11, 11, 11, 100, 100, 1, 1, 0, 1, 1, 1, 11, 11, 1, 0, 11, 11, 17, 53,
    ]);
    output_case(
        "literal and named auto nullptr values convert to pointers without becoming integer zero",
        "__device__ unsigned selected(unsigned *value) { return value ? 19u : 11u; }
        __device__ unsigned selected(int value) { return 100u + unsigned(value); }
        __global__ void kernel(unsigned *output) {
            auto empty = nullptr;
            const auto frozen = nullptr;
            unsigned *pointer = nullptr;
            output[0] = selected(nullptr);
            output[1] = selected(empty);
            output[2] = selected(frozen);
            output[3] = selected(0);
            output[4] = selected(unsigned(0));
            output[5] = unsigned(pointer == nullptr);
            output[6] = unsigned(nullptr == pointer);
            output[7] = unsigned(bool(empty));
            pointer = output + 24;
            output[8] = unsigned(pointer != nullptr);
            const unsigned *view = frozen;
            output[9] = unsigned(view == 0);
            pointer = empty;
            output[10] = unsigned(pointer == nullptr);
            auto copied = empty;
            output[11] = selected(copied);
            output[12] = selected(true ? copied : nullptr);
            output[13] = unsigned(nullptr == nullptr);
            output[14] = unsigned(empty != nullptr);
            empty = nullptr;
            output[15] = selected(empty);
            output[16] = selected(empty = nullptr);
            output[17] = (nullptr, 17u);
            output[18] = output[24];
        }",
        [1, 1, 1],
        &initial,
        &expected,
    )
}

fn helper_effects(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 0;
    initial[28] = choice;
    let mut expected = initial;
    let branch_total = if choice == 0 { 95 } else { 63 };
    expected[..14].copy_from_slice(&[
        1,
        3,
        1,
        7,
        15,
        31,
        31,
        branch_total,
        branch_total,
        branch_total + 3,
        31,
        0,
        branch_total + 7,
        31,
    ]);
    expected[24] = branch_total + 7;
    output_case(
        &format!("nullptr_t arguments results assignments and selected branches retain helper effects for choice {choice}"),
        "using Null = decltype(nullptr);
        __device__ Null produce(unsigned *counter, unsigned amount) {
            counter[0] += amount;
            return nullptr;
        }
        __device__ Null relay(unsigned *counter, unsigned amount) { return produce(counter, amount); }
        __device__ Null pass(Null value, unsigned *counter, unsigned amount) {
            counter[0] += amount;
            return value;
        }
        __device__ unsigned selected(Null value) { return value == nullptr ? 31u : 901u; }
        __device__ unsigned selected(unsigned *value) { return 41u; }
        __device__ unsigned selected(int value) { return 51u; }
        __global__ void kernel(unsigned *output) {
            auto first = produce(output + 24, 1u);
            output[0] = output[24];
            Null second = relay(output + 24, 2u);
            output[1] = output[24];
            unsigned *empty = relay(output + 24, 4u);
            output[2] = unsigned(empty == nullptr);
            output[3] = output[24];
            Null target = nullptr;
            target = produce(output + 24, 8u);
            output[4] = output[24];
            auto copied = target;
            output[5] = selected(copied);
            auto sequenced = (produce(output + 24, 16u), nullptr);
            output[6] = output[24];
            bool choose = output[28] != 0u;
            Null selected_branch = choose ? produce(output + 24, 32u) : produce(output + 24, 64u);
            output[7] = output[24];
            copied && (produce(output + 24, 128u), true);
            !copied || (produce(output + 24, 256u), true);
            output[8] = output[24];
            Null forwarded = pass(produce(output + 24, 1u), output + 24, 2u);
            output[9] = output[24];
            output[10] = selected(forwarded);
            output[11] = unsigned(bool(pass(nullptr, output + 24, 4u)));
            output[12] = output[24];
            output[13] = selected(selected_branch);
        }",
        [1, 1, 1],
        &initial,
        &expected,
    )
}

fn reference_aliases() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 0;
    let mut expected = initial;
    expected[..9].copy_from_slice(&[7, 7, 7, 1, 3, 7, 7, 11, 7]);
    expected[24] = 3;
    output_case(
        "nullptr_t mutable and const reference aliases keep assignment effects and pointer conversion",
        "using Null = decltype(nullptr);
        __device__ Null produce(unsigned *counter, unsigned amount) {
            counter[0] += amount;
            return nullptr;
        }
        __device__ Null replace(Null &target, unsigned *counter) {
            ++counter[0];
            target = nullptr;
            return target;
        }
        __device__ unsigned inspect(const Null &value) { return value == nullptr ? 7u : 9u; }
        __device__ unsigned selected(unsigned *value) { return value ? 19u : 11u; }
        __global__ void kernel(unsigned *output) {
            auto value = nullptr;
            Null &alias = value;
            const Null &view = alias;
            output[0] = inspect(view);
            output[1] = inspect(nullptr);
            output[2] = inspect(replace(alias, output + 24));
            output[3] = output[24];
            alias = produce(output + 24, 2u);
            output[4] = output[24];
            const auto frozen = nullptr;
            output[5] = inspect(frozen);
            output[6] = inspect(alias = nullptr);
            output[7] = selected(alias);
            auto &deduced = value;
            deduced = nullptr;
            output[8] = inspect(deduced);
        }",
        [1, 1, 1],
        &initial,
        &expected,
    )
}

fn synchronization_result() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..8].copy_from_slice(&[10, 9, 8, 7, 11, 12, 13, 14]);
    output_case(
        "nullptr_t results preserve an ordinary synchronization helper call",
        "using Null = decltype(nullptr);
        __device__ Null synchronize() {
            __syncthreads();
            return nullptr;
        }
        __global__ void kernel(unsigned *output) {
            __shared__ unsigned values[4];
            unsigned lane = threadIdx.x;
            values[lane] = lane + 7u;
            auto synchronized = synchronize();
            output[lane] = values[3u - lane];
            if (synchronized == nullptr) output[4u + lane] = 11u + lane;
        }",
        [4, 1, 1],
        &initial,
        &expected,
    )
}

fn output_case(
    name: &str,
    source: &str,
    workgroup: [u32; 3],
    initial: &[u32],
    expected: &[u32],
) -> ShaderTest {
    module_case(name, source, workgroup, expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            initial,
        )],
        0,
        [1, 1, 1],
    )
}

pub(super) fn assignment_order_cases() -> Vec<ShaderTest> {
    vec![assignment_order(0), assignment_order(1)]
}

fn assignment_order(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 12];
    initial[4] = choice;
    initial[6] = 0;
    let mut expected = initial;
    let digits = if choice == 0 { 23 } else { 21 };
    expected[0] = digits;
    expected[1] = 1;
    expected[6] = digits;
    output_case(
        &format!(
            "nullptr_t assignment evaluates RHS before selected LHS effects for choice {choice}"
        ),
        "using Null = decltype(nullptr);
        __device__ void touch(unsigned *counter, unsigned digit) {
            counter[0] = counter[0] * 10u + digit;
        }
        __device__ Null produce(unsigned *counter, unsigned digit) {
            touch(counter, digit);
            return nullptr;
        }
        __global__ void kernel(unsigned *output) {
            Null first = nullptr;
            Null second = nullptr;
            bool condition = output[4] != 0u;
            (condition ? (touch(output + 6, 1u), first) : (touch(output + 6, 3u), second))
                = produce(output + 6, 2u);
            output[0] = output[6];
            output[1] = unsigned(first == nullptr && second == nullptr);
        }",
        [1, 1, 1],
        &initial,
        &expected,
    )
}

fn backend_fixture() -> ShaderTest {
    let initial = [SENTINEL; 40];
    let mut expected = initial;
    for lane in 0..4 {
        let base = lane * 8;
        expected[base..base + 8].copy_from_slice(&[6 - lane as u32, 7, 13, 1, 1, 7, 7, 0]);
    }
    output_case(
        "all-backend nullptr fixture keeps erased calls and shared synchronization",
        include_str!("../../../../../naga/tests/in/cuda/nullptr.cu"),
        [4, 1, 1],
        &initial,
        &expected,
    )
}

fn direct_boolean_initializers() -> ShaderTest {
    let mut initial = [SENTINEL; 12];
    initial[6] = 0;
    let mut expected = initial;
    expected[..6].copy_from_slice(&[0, 0, 0, 1, 1, 3]);
    expected[6] = 3;
    output_case(
        "direct Boolean initialization from nullptr keeps helper effects",
        "using Null = decltype(nullptr);
        using Flag = bool;
        __device__ Null produce(unsigned &counter) { ++counter; return nullptr; }
        __global__ void kernel(unsigned *output) {
            bool literal(nullptr);
            auto empty = nullptr;
            Flag named(empty);
            const bool returned(produce(output[6]));
            output[0] = unsigned(literal);
            output[1] = unsigned(named);
            output[2] = unsigned(returned);
            output[3] = output[6];
            Null nested(Null(produce(output[6])));
            bool forced((Null(produce(output[6]))));
            output[4] = unsigned(nested == nullptr && !forced);
            output[5] = output[6];
        }",
        [1, 1, 1],
        &initial,
        &expected,
    )
}
