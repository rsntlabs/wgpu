@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
var<workgroup> scratch: array<u32, 4>;

@compute @workgroup_size(4, 1, 1)
fn exchange(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;

    let lane = threadIdx.x;
    let base = (blockIdx.x * 12u);
    scratch[lane] = (((blockIdx.x * 10u) + lane) + 1u);
    storageBarrier();
    workgroupBarrier();
    let _e19 = scratch[((lane + 1u) % 4u)];
    local = u32((base + lane));
    let _e23 = local;
    output[_e23] = _e19;
    storageBarrier();
    workgroupBarrier();
    local_2 = u32((base + ((lane + 3u) % 4u)));
    let _e33 = local_2;
    let _e35 = output[_e33];
    local_1 = u32(((base + 4u) + lane));
    let _e41 = local_1;
    output[_e41] = _e35;
    storageBarrier();
    workgroupBarrier();
    local_4 = u32(((base + 4u) + ((lane + 1u) % 4u)));
    let _e52 = local_4;
    let _e54 = output[_e52];
    local_3 = u32(((base + 8u) + lane));
    let _e60 = local_3;
    output[_e60] = _e54;
}
