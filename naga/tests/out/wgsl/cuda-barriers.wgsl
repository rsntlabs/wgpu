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

    let lane = threadIdx.x;
    let base = (blockIdx.x * 256u);
    values[lane] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = u32((base + lane));
    let _e21 = local;
    local_5 = u32(_e21);
    let _e24 = local_5;
    out[_e24] = ((blockIdx.x * 1000u) + lane);
    if (lane == 0u) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    storageBarrier();
    workgroupBarrier();
    let _e38 = values[(63u - lane)];
    local_1 = u32(((base + 64u) + lane));
    let _e44 = local_1;
    local_6 = u32(_e44);
    let _e47 = local_6;
    out[_e47] = _e38;
    local_3 = u32((base + ((lane + 1u) % 64u)));
    let _e56 = local_3;
    local_7 = u32(_e56);
    let _e59 = local_7;
    let _e61 = out[_e59];
    local_2 = u32(((base + 128u) + lane));
    let _e67 = local_2;
    local_8 = u32(_e67);
    let _e70 = local_8;
    out[_e70] = _e61;
    let _e73 = broadcast;
    local_4 = u32(((base + 192u) + lane));
    let _e79 = local_4;
    local_9 = u32(_e79);
    let _e82 = local_9;
    out[_e82] = _e73;
}
