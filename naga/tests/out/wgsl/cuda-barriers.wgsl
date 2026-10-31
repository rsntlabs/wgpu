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

    let lane = threadIdx.x;
    let base = (blockIdx.x * 256u);
    values[lane] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = u32((base + lane));
    let _e21 = local;
    out[_e21] = ((blockIdx.x * 1000u) + lane);
    if (lane == 0u) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    storageBarrier();
    workgroupBarrier();
    let _e35 = values[(63u - lane)];
    local_1 = u32(((base + 64u) + lane));
    let _e41 = local_1;
    out[_e41] = _e35;
    local_3 = u32((base + ((lane + 1u) % 64u)));
    let _e50 = local_3;
    let _e52 = out[_e50];
    local_2 = u32(((base + 128u) + lane));
    let _e58 = local_2;
    out[_e58] = _e52;
    let _e61 = broadcast;
    local_4 = u32(((base + 192u) + lane));
    let _e67 = local_4;
    out[_e67] = _e61;
}
