struct type_2 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> mode_1: type_2;
@group(0) @binding(2)
var<uniform> count_1: type_2;

fn synchronize() {
    storageBarrier();
    workgroupBarrier();
    return;
}

fn rounds(count: u32, mode: u32) {
    var iteration: u32;

    {
        iteration = 0u;
        loop {
            let _e4 = iteration;
            if (_e4 < count) {
            } else {
                break;
            }
            if (mode != 0u) {
                storageBarrier();
                workgroupBarrier();
            } else {
                storageBarrier();
                workgroupBarrier();
            }
            continuing {
                let _e8 = iteration;
                iteration = (_e8 + u32(1i));
            }
        }
        return;
    }
}

fn finish(lane: u32) -> u32 {
    storageBarrier();
    workgroupBarrier();
    if ((lane & 1u) != 0u) {
        return (lane + 100u);
    }
    return (lane + 200u);
}

@compute @workgroup_size(4, 1, 1)
fn exchange(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    let mode_2 = mode_1.value;
    let count_2 = count_1.value;
    let lane_1 = threadIdx.x;
    let base = (blockIdx.x * 12u);
    local = u32((base + lane_1));
    let _e21 = local;
    output[_e21] = (((blockIdx.x * 10u) + lane_1) + 1u);
    synchronize();
    local_1 = u32((base + ((lane_1 + 1u) % 4u)));
    let _e31 = local_1;
    let next = output[_e31];
    synchronize();
    local_2 = u32((base + lane_1));
    let _e39 = local_2;
    output[_e39] = (next + 10u);
    rounds(count_2, mode_2);
    local_4 = u32((base + ((lane_1 + 1u) % 4u)));
    let _e48 = local_4;
    let _e50 = output[_e48];
    local_3 = u32(((base + 4u) + lane_1));
    let _e56 = local_3;
    output[_e56] = _e50;
    let _e58 = finish(lane_1);
    local_5 = u32(((base + 8u) + lane_1));
    let _e64 = local_5;
    output[_e64] = _e58;
    synchronize();
}
