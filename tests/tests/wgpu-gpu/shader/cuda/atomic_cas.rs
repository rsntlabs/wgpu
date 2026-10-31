use super::{module_case, parse_module, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/atomic-cas.cu");
const SENTINEL: u32 = 0xdead_beef;
const CAPTURED_OPERANDS: &str = "__global__ void kernel(int *output) {
    __shared__ int counter;
    counter = output[7];
    unsigned index = 0;
    int compare = 0;
    int replacement = 7;
    output[0] = atomicCAS(&counter + index++, compare++, replacement++);
    output[1] = counter;
    output[4] = compare;
    output[5] = replacement;
    output[6] = index;
}";

fn output_buffer(initial: &[u32]) -> ShaderBuffer {
    ShaderBuffer::new(
        0,
        wgpu::BufferBindingType::Storage { read_only: false },
        initial,
    )
}

fn kernel_case(name: &str, source: &str, initial: &[u32], expected: &[u32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![output_buffer(initial)],
        0,
        [1, 1, 1],
    )
}

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![
        signed(),
        unsigned(),
        projected_fields(),
        contended_tickets(),
    ];
    tests.extend(selected_origins());
    tests.extend(forced_weak_failure());
    tests
}

fn signed() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..3].copy_from_slice(&[(-3_i32) as u32, 0x8000_0000, 5]);
    let mut expected = initial;
    expected[..3].copy_from_slice(&[7, (-7_i32) as u32, 9]);
    expected[8..15].copy_from_slice(&[
        (-3_i32) as u32,
        7,
        0x8000_0000,
        (-4_i32) as u32,
        7,
        (-7_i32) as u32,
        9,
    ]);
    kernel_case(
        "signed atomicCAS matches, mismatches, discards and converts both scalar operands",
        FIXTURE,
        &initial,
        &expected,
    )
}

fn unsigned() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[..3].copy_from_slice(&[0xffff_ffff, 0x8000_0005, 7]);
    let mut expected = initial;
    expected[..3].copy_from_slice(&[0x8000_0000, 1, 0xffff_fffe]);
    expected[8..14].copy_from_slice(&[
        0xffff_ffff,
        0x8000_0000,
        0x8000_0005,
        0x8000_0000,
        1,
        0xffff_fffe,
    ]);
    kernel_case(
        "unsigned atomicCAS preserves high-bit comparisons and returned old values",
        "__global__ void kernel(unsigned *output) {
            output[8] = atomicCAS(output, 0xffffffffu, 0x80000000u);
            output[9] = atomicCAS(output, 0xffffffffu, 3u);
            output[10] = atomicCAS(output + 1, 0x80000005u, 1u);
            atomicCAS(output + 2, 7u, 0xfffffffeu);
            output[11] = output[0]; output[12] = output[1]; output[13] = output[2];
        }",
        &initial,
        &expected,
    )
}

fn selected_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[7] = choose;
        initial[8] = 20;
        let mut expected = initial;
        if choose == 0 {
            expected[..6].copy_from_slice(&[20, 10, 20, 1, 20, 20]);
        } else {
            expected[..6].copy_from_slice(&[10, 30, 20, 1, 20, 40]);
            expected[8] = 40;
        }
        tests.push(kernel_case(
            &format!("atomicCAS forwards origin {choose} through a helper and keeps conditional calls lazy"),
            "__device__ int compare_exchange(int *destination, int compare, int replacement);
            __global__ void kernel(int *output) {
                __shared__ int shared;
                shared = 10;
                __syncthreads();
                int *selected = output[7] ? &shared : output + 8;
                int previous = compare_exchange(selected, 10, 30);
                __syncthreads();
                output[0] = previous;
                output[1] = shared;
                output[2] = output[8];
                bool skipped = false && atomicCAS(output + 8, 20, 0);
                bool ready = true || atomicCAS(output + 8, 20, 0);
                output[3] = int(skipped) + int(ready);
                output[4] = output[7] ? atomicCAS(output + 8, 20, 40) : atomicCAS(output + 8, 999, 0);
                output[5] = output[8];
            }
            __device__ int compare_exchange(int *destination, int compare, int replacement) {
                return atomicCAS(destination, compare, replacement);
            }",
            &initial, &expected,
        ));
    }
    tests
}

fn projected_fields() -> ShaderTest {
    let mut initial = [SENTINEL; 24];
    initial[0] = 2;
    initial[2] = 5;
    initial[3] = 10;
    let mut expected = initial;
    expected[0] = 7;
    expected[3] = 3;
    expected[4] = 7;
    expected[6..9].copy_from_slice(&[5, 3, 2]);
    expected[10..12].copy_from_slice(&[10, 10]);
    kernel_case(
        "atomicCAS preserves struct and vector field projections, copies and padding",
        "struct Counter { int value; int2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            int previous = atomicCAS(&records[0].value, 2, 7);
            int previous_component = atomicCAS(&records[0].pair.y, 10, 3);
            Counter after = records[0];
            records[1] = after;
            records[2].value = previous;
            records[2].pair.x = previous_component;
            records[2].pair.y = before.pair.y;
        }",
        &initial,
        &expected,
    )
}

fn contended_tickets() -> ShaderTest {
    let mut initial = [SENTINEL; 48];
    initial[0] = 0;
    let mut expected = initial;
    expected[0] = 32;
    for ticket in 0..32 {
        expected[ticket + 1] = ticket as u32;
    }
    module_case(
        "unsigned atomicCAS retry loops allocate every ticket across four workgroups",
        "__global__ void kernel(unsigned *output) {
            unsigned observed = atomicCAS(output, 0u, 0u);
            while (true) {
                unsigned previous = atomicCAS(output, observed, observed + 1u);
                if (previous == observed) { output[observed + 1u] = observed; break; }
                observed = previous;
            }
        }",
        [8, 1, 1],
        &expected,
    )
    .module_buffers(vec![output_buffer(&initial)], 0, [4, 1, 1])
}

fn forced_weak_failure() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for initial_counter in [0, 4] {
        let name = format!("strong atomicCAS retries a forced weak failure only when comparison matches {initial_counter}");
        let mut initial = [SENTINEL; 32];
        initial[2] = 0;
        initial[3] = 0;
        initial[7] = initial_counter;
        let mut expected = initial;
        expected[0] = initial_counter;
        expected[1] = if initial_counter == 0 { 7 } else { 4 };
        expected[2] = 1;
        expected[3] = u32::from(initial_counter == 0);
        expected[4..7].copy_from_slice(&[1, 8, 1]);
        let module = parse_module(&name, CAPTURED_OPERANDS, [1, 1, 1]);
        let info = naga::valid::Validator::new(
            naga::valid::ValidationFlags::all(),
            naga::valid::Capabilities::empty(),
        )
        .validate(&module)
        .unwrap();
        let wgsl =
            naga::back::wgsl::write_string(&module, &info, naga::back::wgsl::WriterFlags::empty())
                .unwrap();
        let counters: Vec<_> = wgsl
            .lines()
            .filter_map(|line| {
                line.trim()
                    .strip_prefix("var<workgroup> ")?
                    .strip_suffix(": atomic<i32>;")
            })
            .collect();
        assert_eq!(counters.len(), 1, "{name}");
        let counter = counters[0];
        let call_prefix = format!("atomicCompareExchangeWeak((&{counter}),");
        assert!(wgsl.contains(&call_prefix), "{name}");
        let instrumented = wgsl.replace(&call_prefix, "forced_compare_exchange(");
        assert!(
            !instrumented.contains("atomicCompareExchangeWeak("),
            "{name}"
        );
        let helper = FORCED_WEAK_HELPER.replace("__CAS_COUNTER__", counter);
        let source = format!("{helper}\n{instrumented}");
        let instrumented_module = naga::front::wgsl::parse_str(&source).unwrap();
        naga::valid::Validator::new(
            naga::valid::ValidationFlags::all(),
            naga::valid::Capabilities::empty(),
        )
        .validate(&instrumented_module)
        .unwrap();
        let entry_point = instrumented_module.entry_points[0].name.clone();
        tests.push(
            ShaderTest::new(name, String::new(), String::new(), &[0_u32], &expected)
                .module_source(source, entry_point)
                .module_buffers(vec![output_buffer(&initial)], 0, [1, 1, 1]),
        );
    }
    tests
}

const FORCED_WEAK_HELPER: &str = "struct ForcedCompareResult {
    old_value: i32,
    exchanged: bool,
}
fn forced_compare_exchange(compare: i32, replacement: i32) -> ForcedCompareResult {
    if (output[2] == 0) {
        output[2] = 1;
        return ForcedCompareResult(atomicLoad(&__CAS_COUNTER__), false);
    }
    output[3] = 1;
    let result = atomicCompareExchangeWeak(&__CAS_COUNTER__, compare, replacement);
    return ForcedCompareResult(result.old_value, result.exchanged);
}";
