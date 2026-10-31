@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
var<workgroup> values: array<u32, 64>;
var<workgroup> signed_value: i32;
var<workgroup> float_value: f32;

@compute @workgroup_size(64, 1, 1)
fn shared_storage(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    let lane = threadIdx.x;
    let base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    let _e15 = values[lane];
    local = u32((base + lane));
    let _e19 = local;
    local_3 = u32(_e19);
    let _e22 = local_3;
    out[_e22] = _e15;
    if (lane == 0u) {
        signed_value = -(7i);
        float_value = 3.5f;
        let _e32 = signed_value;
        local_1 = u32((base + 64u));
        let _e40 = local_1;
        local_4 = u32(_e40);
        let _e43 = local_4;
        out[_e43] = u32((_e32 + 10i));
        let _e45 = float_value;
        local_2 = u32((base + 65u));
        let _e53 = local_2;
        local_5 = u32(_e53);
        let _e56 = local_5;
        out[_e56] = u32((_e45 * 2f));
    }
}
