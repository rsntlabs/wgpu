@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
var<workgroup> values: array<u32, 64>;
var<workgroup> broadcast: u32;

@compute @workgroup_size(64, 1, 1)
fn barriers(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;

    let lane = threadIdx.x;
    let base = (blockIdx.x * 256u);
    values[lane] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = u32((base + lane));
    let _e21 = local;
    local_6 = u32(_e21);
    let _e24 = local_6;
    out[_e24] = ((blockIdx.x * 1000u) + lane);
    if (lane == 0u) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    storageBarrier();
    workgroupBarrier();
    let _e38 = values[(63u - lane)];
    local_1 = u32(((base + 64u) + lane));
    let _e44 = local_1;
    local_7 = u32(_e44);
    let _e47 = local_7;
    out[_e47] = _e38;
    local_3 = u32((base + ((lane + 1u) % 64u)));
    let _e56 = local_3;
    local_8 = u32(_e56);
    let _e59 = local_8;
    let _e61 = out[_e59];
    local_9 = _e61;
    let _e63 = local_9;
    local_5 = _e63;
    let _e65 = local_5;
    local_2 = u32(((base + 128u) + lane));
    let _e71 = local_2;
    local_10 = u32(_e71);
    let _e74 = local_10;
    out[_e74] = _e65;
    let _e77 = broadcast;
    local_4 = u32(((base + 192u) + lane));
    let _e83 = local_4;
    local_11 = u32(_e83);
    let _e86 = local_11;
    out[_e86] = _e77;
}
