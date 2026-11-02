use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str =
    include_str!("../../../../../naga/tests/in/cuda/direct-pointer-reference-initialization.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        backend_fixture(),
        pointer_snapshots(0),
        pointer_snapshots(1),
        reference_bindings(0),
        reference_bindings(1),
        source_null_references(),
    ]
}

fn output_case(name: &str, source: &str, initial: &[u32; 32], expected: &[u32; 32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            initial,
        )],
        0,
        [1, 1, 1],
    )
}

fn backend_fixture() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..16].copy_from_slice(&[3, 11, 3, 12, 12, 12, 8, 2, 1, 0, 1, 1, 1, 1, 1, 26]);
    output_case(
        "direct pointer and reference initializers preserve aliases const views temporaries and nullptr helper calls",
        FIXTURE,
        &initial,
        &expected,
    )
}

fn pointer_snapshots(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 53;
    initial[25] = 59;
    initial[28] = choice;
    let mut expected = initial;
    let leading = if choice == 0 {
        [
            3, 7, 7, 14, 7, 14, 1, 2, 14, 0, 22, 1, 1, 13, 61, 59, 61, 7, 22, 61,
        ]
    } else {
        [
            7, 8, 8, 14, 7, 14, 1, 2, 7, 1, 22, 1, 1, 13, 60, 59, 8, 7, 22, 60,
        ]
    };
    expected[..20].copy_from_slice(&leading);
    expected[24] = if choice == 0 { 61 } else { 60 };
    output_case(
        &format!("direct pointer initialization captures array decay offsets addresses nullable copies and selected origins {choice}"),
        r#"__global__ void kernel(unsigned *output) {
    using Pointer = unsigned *;
    unsigned first[3]{3u, 5u, 7u};
    unsigned second[3]{11u, 13u, 17u};
    unsigned index = 0u, counter = 0u;
    Pointer base(first), offset(base + index++), copy((++counter, base + index++));
    const unsigned *view(copy);
    base = second;
    index = 0u;
    *copy += 2u;
    Pointer address(&second[index++]);
    const Pointer fixed(address);
    address = first + 2;
    *fixed += 3u;
    Pointer selected(output[28] ? first : second);
    Pointer nullable(output[28] ? selected : nullptr);
    Pointer preserved(nullable);
    nullable = second + 2;
    if (preserved) *preserved += 4u;
    if (nullable) *nullable += 5u;
    unsigned *from_zero(0), *from_null(nullptr);
    unsigned *from_address((++counter, &second[1]));
    Pointer storage(output + 24), storage_copy(storage);
    storage = output + 25;
    *storage_copy += 7u;
    Pointer selected_storage(output[28] ? copy : storage_copy);
    *selected_storage += 1u;
    output[0] = *offset;
    output[1] = *copy;
    output[2] = *view;
    output[3] = *base;
    output[4] = *address;
    output[5] = *fixed;
    output[6] = index;
    output[7] = counter;
    output[8] = *selected;
    output[9] = unsigned(bool(preserved));
    output[10] = *nullable;
    output[11] = unsigned(from_zero == nullptr);
    output[12] = unsigned(from_null == nullptr);
    output[13] = *from_address;
    output[14] = *storage_copy;
    output[15] = *storage;
    output[16] = *selected_storage;
    output[17] = first[2];
    output[18] = second[2];
    output[19] = output[24];
}
"#,
        &initial,
        &expected,
    )
}

fn reference_bindings(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 53;
    initial[28] = choice;
    let mut expected = initial;
    let leading = if choice == 0 {
        [
            100, 53, 100, 53, 53, 53, 33, 9, 61, 15, 0, 30, 40, 77, 77, 1, 0, 77, 223,
        ]
    } else {
        [
            100, 25, 100, 100, 38, 100, 33, 9, 53, 15, 0, 38, 40, 77, 77, 1, 0, 77, 203,
        ]
    };
    expected[..19].copy_from_slice(&leading);
    expected[24] = 77;
    output_case(
        &format!("direct reference initialization freezes indices and chosen addresses while const views stay live {choice}"),
        r#"__global__ void kernel(unsigned *output) {
    unsigned values[4]{10u, 20u, 30u, 40u};
    unsigned index = 0u, counter = 0u;
    unsigned &first((++counter, values[index++])), &second((counter += 2u, values[index++]));
    const unsigned &view(first);
    const unsigned &temporary((counter += 4u, values[2] + 3u));
    const int &converted(9u);
    unsigned &selected(output[28] ? first : second);
    unsigned &indexed(output[28] ? values[index++] : values[--index]);
    index = 0u;
    first += 1u;
    second += 2u;
    selected += 4u;
    indexed += 8u;
    const unsigned &still_live(selected);
    selected += 16u;
    unsigned &storage(output[24]);
    const unsigned &storage_view(storage);
    storage += 5u;
    const bool &present(&values[0]);
    const bool &absent(bool(nullptr));
    const unsigned &copy_temporary((counter += 8u, first + second));
    first = 99u;
    second += 1u;
    storage = 77u;
    for (unsigned iteration = 0u; iteration < 2u; ++iteration) {
        unsigned &current(values[iteration]);
        current += iteration + 1u;
    }
    output[0] = first;
    output[1] = second;
    output[2] = view;
    output[3] = selected;
    output[4] = indexed;
    output[5] = still_live;
    output[6] = temporary;
    output[7] = converted;
    output[8] = copy_temporary;
    output[9] = counter;
    output[10] = index;
    output[11] = values[2];
    output[12] = values[3];
    output[13] = storage;
    output[14] = storage_view;
    output[15] = unsigned(present);
    output[16] = unsigned(absent);
    output[17] = output[24];
    output[18] = values[0] + values[1] + values[2] + values[3];
}
"#,
        &initial,
        &expected,
    )
}

fn source_null_references() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..18].copy_from_slice(&[1, 3, 7, 15, 31, 7, 1, 1, 1, 1, 1, 1, 1, 1, 0, 7, 31, 1]);
    output_case(
        "direct nullptr_t references preserve lvalue and temporary bindings and ordered helper effects",
        r#"using Null = decltype(nullptr);

__device__ Null observe(unsigned &counter, unsigned amount) {
    counter += amount;
    return nullptr;
}
__device__ Null replace(Null &target, unsigned &counter) {
    counter += 8u;
    target = nullptr;
    return target;
}
__device__ unsigned inspect(const Null &value) { return value == nullptr ? 7u : 9u; }

__global__ void kernel(unsigned *output) {
    unsigned counter = 0u;
    Null source(nullptr);
    Null &alias((counter += 1u, source));
    output[0] = counter;
    const Null &frozen(source), &literal(nullptr), &zero(0), &converted(Null(observe(counter, 2u)));
    output[1] = counter;
    const Null &wrapped((observe(counter, 4u), nullptr));
    output[2] = counter;
    const Null &selected((replace(alias, counter)));
    output[3] = counter;
    Null &copy(alias);
    copy = 0;
    const Null &frozen_effect((counter += 16u, source));
    output[4] = counter;
    unsigned *pointer(literal);
    bool absent((bool(converted)));
    output[5] = inspect(alias);
    output[6] = unsigned(literal == nullptr);
    output[7] = unsigned(zero == nullptr);
    output[8] = unsigned(converted == nullptr);
    output[9] = unsigned(wrapped == nullptr);
    output[10] = unsigned(selected == nullptr);
    output[11] = unsigned(frozen == nullptr);
    output[12] = unsigned(frozen_effect == nullptr);
    output[13] = unsigned(pointer == nullptr);
    output[14] = unsigned(absent);
    output[15] = inspect(copy);
    output[16] = counter;
    output[17] = unsigned(source == nullptr);
}
"#,
        &initial,
        &expected,
    )
}
