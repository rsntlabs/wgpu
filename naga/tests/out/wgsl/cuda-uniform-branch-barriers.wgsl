struct type_2 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> mode: type_2;
var<workgroup> values: array<u32, 4>;

@compute @workgroup_size(4, 1, 1)
fn exchange(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var transformed: u32;
    var local_1: u32;

    let mode_1 = mode.value;
    let lane = threadIdx.x;
    let base = (blockIdx.x * 4u);
    local = u32((base + lane));
    let _e12 = local;
    let _e15 = input[_e12];
    values[lane] = _e15;
    if (mode_1 != 0u) {
        storageBarrier();
        workgroupBarrier();
        let _e25 = values[((lane + 1u) % 4u)];
        transformed = (_e25 + 10u);
    } else {
        storageBarrier();
        workgroupBarrier();
        let _e34 = values[((lane + 2u) % 4u)];
        transformed = (_e34 + 20u);
    }
    storageBarrier();
    workgroupBarrier();
    let _e39 = transformed;
    values[lane] = _e39;
    switch ((blockIdx.x + mode_1) % 3u) {
        case 0u: {
            storageBarrier();
            workgroupBarrier();
            let _e46 = values[lane];
            values[lane] = (_e46 + 1u);
            break;
        }
        case 1u: {
            storageBarrier();
            workgroupBarrier();
            let _e50 = values[lane];
            values[lane] = (_e50 * 2u);
            storageBarrier();
            workgroupBarrier();
            let _e54 = values[lane];
            values[lane] = (_e54 + 3u);
        }
        default: {
            storageBarrier();
            workgroupBarrier();
            let _e58 = values[lane];
            values[lane] = (_e58 + 3u);
        }
    }
    storageBarrier();
    workgroupBarrier();
    let _e66 = values[((lane + 3u) % 4u)];
    local_1 = u32((base + lane));
    let _e70 = local_1;
    output[_e70] = _e66;
}
