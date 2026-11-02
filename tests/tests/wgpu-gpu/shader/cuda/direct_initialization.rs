use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const FIXTURE: &str =
    include_str!("../../../../../naga/tests/in/cuda/direct-scalar-initialization.cu");

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        scalar_values(),
        ordered_initializers(0),
        ordered_initializers(1),
        finite_float_conversions(),
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

fn scalar_values() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 53;
    let mut expected = initial;
    expected[..21].copy_from_slice(&[
        3,
        8,
        u32::MAX,
        7,
        1,
        0,
        11,
        7,
        13,
        0,
        0,
        11,
        11,
        41,
        41,
        41,
        41,
        1,
        0,
        3,
        53,
    ]);
    output_case(
        "parenthesized scalar values keep conversions constant bounds snapshots and literal-zero overload rules",
        FIXTURE,
        &initial,
        &expected,
    )
}

fn ordered_initializers(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[24] = 17;
    initial[25] = 2;
    initial[28] = choice;
    let mut expected = initial;
    expected[..17].copy_from_slice(&[
        2,
        5,
        6,
        13,
        7,
        13,
        99,
        17,
        8,
        73,
        41,
        12,
        62,
        if choice == 0 { 13 } else { 7 },
        42,
        16,
        62,
    ]);
    expected[24] = 62;
    output_case(
        &format!("parenthesized declarators retain nested comma effects and snapshots before mutation for branch {choice}"),
        r#"__device__ int next(int &counter) { return counter++; }
__device__ int overwrite(unsigned *output, int &counter) {
    ++counter;
    output[24] = 41u;
    return counter;
}
__global__ void kernel(unsigned *output) {
    int counter(output[25]);
    int first(next(counter)), second((counter += 2, next(counter))), third = next(counter);
    int local(7);
    int local_snapshot(local), local_changed((local = 13));
    int stored_snapshot(output[24]), trigger(overwrite(output, counter));
    int after(output[24]);
    const int frozen_snapshot(after);
    after = 73;
    output[24] = 59u;
    int nested((output[24] += 3u, (counter += 4, next(counter))));
    int branch_snapshot(output[28] ? local_snapshot : local);
    local = 99;
    output[0] = first;
    output[1] = second;
    output[2] = third;
    output[3] = counter;
    output[4] = local_snapshot;
    output[5] = local_changed;
    output[6] = local;
    output[7] = stored_snapshot;
    output[8] = trigger;
    output[9] = after;
    output[10] = frozen_snapshot;
    output[11] = nested;
    output[12] = output[24];
    output[13] = branch_snapshot;
    int total(0);
    for (int iteration(0), limit(3); iteration < limit; ++iteration) {
        int value(next(counter));
        total += value;
    }
    output[14] = total;
    output[15] = counter;
    output[16] = output[24];
}"#,
        &initial,
        &expected,
    )
}

fn finite_float_conversions() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..18].copy_from_slice(&[
        3,
        8,
        6,
        15,
        1,
        1,
        0,
        0,
        0,
        0,
        8,
        1,
        6,
        0,
        4_294_967_294,
        16,
        37,
        37,
    ]);
    let samples = [3.75_f32, -2.75, 0.0, -0.0, 6.5, 16.0, -0.75, 0.75];
    module_case(
        "parenthesized finite runtime float conversions truncate toward zero and preserve float copies",
        r#"__global__ void kernel(unsigned *output, const float *samples) {
    int positive(samples[0]), negative(samples[1]);
    unsigned whole(samples[4]);
    float copied(samples[0]), snapshot(copied), changed((copied = 9.25f));
    bool positive_flag(samples[0]), negative_flag(samples[1]);
    bool zero(samples[2]), negative_zero(samples[3]);
    int small_negative(samples[6]);
    unsigned small_positive(samples[7]);
    float from_integer(negative), from_boolean(negative_flag);
    const int constant_truncation(samples[4]);
    int named_zero(samples[6]);
    bool named_zero_flag(named_zero);
    unsigned from_negative(negative);
    output[0] = positive;
    output[1] = unsigned(negative + 10);
    output[2] = whole;
    output[3] = unsigned(snapshot * 4.0f);
    output[4] = unsigned(positive_flag);
    output[5] = unsigned(negative_flag);
    output[6] = unsigned(zero);
    output[7] = unsigned(negative_zero);
    output[8] = small_negative;
    output[9] = small_positive;
    output[10] = unsigned(from_integer + 10.0f);
    output[11] = unsigned(from_boolean);
    output[12] = constant_truncation;
    output[13] = unsigned(named_zero_flag);
    output[14] = from_negative;
    output[15] = unsigned(samples[5]);
    output[16] = unsigned(copied * 4.0f);
    output[17] = unsigned(changed * 4.0f);
}"#,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: true },
                &samples,
            ),
        ],
        0,
        [1, 1, 1],
    )
}
