use super::{module_case, parse_module, ShaderBuffer, ShaderTest};

const FIXTURE: &str = include_str!("../../../../../naga/tests/in/cuda/atomic-wrap.cu");
const SENTINEL: u32 = 0xdead_beef;

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
    let mut tests = vec![thresholds(), projected_fields()];
    tests.extend(selected_origins());
    tests.extend(contention_cycles());
    tests.extend(forced_weak_failures());
    tests
}

fn thresholds() -> ShaderTest {
    let mut initial = [SENTINEL; 64];
    initial[..16].copy_from_slice(&[
        0,
        0,
        1,
        2,
        u32::MAX,
        0xffff_fffe,
        0x8000_0000,
        0x7fff_ffff,
        0,
        0,
        1,
        3,
        u32::MAX,
        0,
        u32::MAX,
        0x8000_0000,
    ]);
    let mut expected = initial;
    expected[..16].copy_from_slice(&[
        1,
        1,
        0,
        0,
        0,
        u32::MAX,
        0,
        0x8000_0000,
        1,
        1,
        0,
        1,
        0xffff_fffe,
        u32::MAX,
        1,
        0x7fff_ffff,
    ]);
    expected[16..32].copy_from_slice(&initial[..16]);
    expected[32..48].copy_from_slice(&[
        0,
        1,
        0,
        0,
        0,
        u32::MAX,
        0,
        0x8000_0000,
        0,
        1,
        0,
        1,
        0xffff_fffe,
        u32::MAX,
        1,
        0x7fff_ffff,
    ]);
    expected[48..50].copy_from_slice(&[1, 1]);
    expected[50..59].copy_from_slice(&[2, 3, 0, 1, 0, 3, 2, 1, 2]);
    kernel_case("unsigned atomicInc and atomicDec preserve threshold boundaries, conversions and old values", FIXTURE, &initial, &expected)
}

fn selected_origins() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for choose in [0, 1] {
        let mut initial = [SENTINEL; 32];
        initial[7] = choose;
        initial[8] = 2;
        let mut expected = initial;
        if choose == 0 {
            expected[..6].copy_from_slice(&[2, 3, 2, 1, 2, 1]);
            expected[8] = 1;
        } else {
            expected[..6].copy_from_slice(&[3, 3, 2, 1, 2, 3]);
            expected[8] = 3;
        }
        tests.push(kernel_case(
            &format!(
                "wrapping atomics forward helper origin {choose} and keep conditional calls lazy"
            ),
            "__device__ unsigned cycle(unsigned *destination, unsigned limit);
            __global__ void kernel(unsigned *output) {
                __shared__ unsigned shared;
                shared = 3u;
                __syncthreads();
                unsigned *selected = output[7] ? &shared : output + 8;
                output[0] = cycle(selected, 3u);
                __syncthreads();
                output[1] = shared;
                output[2] = output[8];
                bool skipped = false && atomicInc(output + 8, 0u);
                bool ready = true || atomicDec(output + 8, 0u);
                output[3] = int(skipped) + int(ready);
                output[4] = output[7] ? atomicInc(output + 8, 3u) : atomicDec(output + 8, 3u);
                output[5] = output[8];
            }
            __device__ unsigned cycle(unsigned *destination, unsigned limit) {
                unsigned previous = atomicInc(destination, limit);
                atomicDec(destination, limit);
                return previous;
            }",
            &initial,
            &expected,
        ));
    }
    tests
}

fn projected_fields() -> ShaderTest {
    let mut initial = [SENTINEL; 24];
    initial[0] = 3;
    initial[2] = 5;
    initial[3] = 0;
    let mut expected = initial;
    expected[0] = 0;
    expected[3] = 3;
    expected[4] = 0;
    expected[6..9].copy_from_slice(&[5, 3, 3]);
    expected[10..12].copy_from_slice(&[0, 0]);
    kernel_case(
        "wrapping atomic fields preserve uint2 components, whole copies and padding",
        "struct Counter { unsigned value; uint2 pair; };
        __global__ void kernel(Counter *records) {
            Counter before = records[0];
            unsigned previous = atomicInc(&records[0].value, 3u);
            unsigned previous_component = atomicDec(&records[0].pair.y, 3u);
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

fn contention_cycles() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for operation in ["atomicInc", "atomicDec"] {
        let mut initial = [SENTINEL; 48];
        initial[..5].fill(0);
        let mut expected = initial;
        expected[1..5].fill(8);
        let source = format!(
            "__global__ void kernel(unsigned *output) {{
                unsigned previous = {operation}(output, 3u);
                atomicAdd(output + previous + 1u, 1u);
            }}"
        );
        tests.push(
            module_case(
                &format!(
                    "{operation} contention completes eight cycles and records each returned value"
                ),
                &source,
                [8, 1, 1],
                &expected,
            )
            .module_buffers(vec![output_buffer(&initial)], 0, [4, 1, 1]),
        );
    }
    tests
}

fn forced_weak_failures() -> Vec<ShaderTest> {
    let mut tests = Vec::new();
    for (operation, changed_value, final_value) in [("atomicInc", 3, 0), ("atomicDec", 0, 3)] {
        let name = format!(
            "{operation} retries spurious failure and recomputes from a competing old value"
        );
        let mut initial = [SENTINEL; 32];
        initial[2..5].fill(0);
        initial[8] = changed_value;
        initial[9] = 1;
        let mut expected = initial;
        expected[..7].copy_from_slice(&[changed_value, final_value, 1, 1, 1, 1, 4]);
        let cuda = format!(
            "__global__ void kernel(unsigned *output) {{
                __shared__ unsigned counter;
                counter = output[9];
                unsigned index = 0;
                unsigned limit = 3;
                output[0] = {operation}(&counter + index++, limit++);
                output[1] = counter;
                output[5] = index;
                output[6] = limit;
            }}"
        );
        let module = parse_module(&name, &cuda, [1, 1, 1]);
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
                    .strip_suffix(": atomic<u32>;")
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
        let helper = FORCED_WEAK_HELPER.replace("__WRAP_COUNTER__", counter);
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
    old_value: u32,
    exchanged: bool,
}
fn forced_compare_exchange(compare: u32, replacement: u32) -> ForcedCompareResult {
    if (output[2] == 0u) {
        output[2] = 1u;
        return ForcedCompareResult(atomicLoad(&__WRAP_COUNTER__), false);
    }
    if (output[3] == 0u) {
        output[3] = 1u;
        atomicStore(&__WRAP_COUNTER__, output[8]);
        return ForcedCompareResult(atomicLoad(&__WRAP_COUNTER__), false);
    }
    output[4] = 1u;
    let result = atomicCompareExchangeWeak(&__WRAP_COUNTER__, compare, replacement);
    return ForcedCompareResult(result.old_value, result.exchanged);
}";
