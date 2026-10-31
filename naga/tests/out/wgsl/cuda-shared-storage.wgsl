@group(0) @binding(0)
var<storage, read_write> out_1: array<u32>;
var<workgroup> values: array<u32, 64>;
var<workgroup> signed_value: i32;
var<workgroup> float_value: f32;

@compute @workgroup_size(64, 1, 1)
fn shared_storage(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let lane = threadIdx.x;
    let base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    let _e21 = values[lane];
    let _e23 = out;
    local = _e23;
    local_1 = u32((base + lane));
    let _e28 = local;
    local_6 = _e28;
    let _e30 = local_1;
    let _e32 = local_6[1];
    local_6[1] = (_e32 + _e30);
    let _e36 = local_6[0];
    local_7 = u32(_e36);
    let _e40 = local_6[1];
    local_8 = u32(_e40);
    let _e43 = local_8;
    out_1[_e43] = _e21;
    if (lane == 0u) {
        signed_value = -(7i);
        float_value = 3.5f;
        let _e53 = signed_value;
        let _e56 = out;
        local_2 = _e56;
        local_3 = u32((base + 64u));
        let _e63 = local_2;
        local_9 = _e63;
        let _e65 = local_3;
        let _e67 = local_9[1];
        local_9[1] = (_e67 + _e65);
        let _e71 = local_9[0];
        local_10 = u32(_e71);
        let _e75 = local_9[1];
        local_11 = u32(_e75);
        let _e78 = local_11;
        out_1[_e78] = u32((_e53 + 10i));
        let _e80 = float_value;
        let _e83 = out;
        local_4 = _e83;
        local_5 = u32((base + 65u));
        let _e90 = local_4;
        local_12 = _e90;
        let _e92 = local_5;
        let _e94 = local_12[1];
        local_12[1] = (_e94 + _e92);
        let _e98 = local_12[0];
        local_13 = u32(_e98);
        let _e102 = local_12[1];
        local_14 = u32(_e102);
        let _e105 = local_14;
        out_1[_e105] = u32((_e80 * 2f));
    }
}
