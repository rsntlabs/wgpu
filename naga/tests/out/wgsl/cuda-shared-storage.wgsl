@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
var<workgroup> values: array<u32, 64>;
var<workgroup> signed_value: i32;
var<workgroup> float_value: f32;

@compute @workgroup_size(64, 1, 1)
fn shared_storage(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var lane: u32;
    var base: u32;
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
    var local_12: u32;

    local = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 128u);
    let _e13 = lane;
    let _e17 = lane;
    values[_e17] = (((blockIdx.x * 1000u) + _e13) + 10u);
    let _e20 = lane;
    let _e22 = values[_e20];
    let _e23 = local;
    local_1 = _e23;
    let _e25 = local_1;
    local_2 = u32(_e25);
    let _e28 = base;
    let _e29 = lane;
    local_3 = u32((_e28 + _e29));
    let _e34 = local_2;
    let _e35 = local_3;
    local_10 = u32((_e34 + _e35));
    let _e39 = local_10;
    out[_e39] = _e22;
    let _e41 = lane;
    if (_e41 == 0u) {
        signed_value = -(7i);
        float_value = 3.5f;
        let _e49 = signed_value;
        let _e52 = local;
        local_4 = _e52;
        let _e54 = local_4;
        local_5 = u32(_e54);
        let _e57 = base;
        local_6 = u32((_e57 + 64u));
        let _e63 = local_5;
        let _e64 = local_6;
        local_11 = u32((_e63 + _e64));
        let _e68 = local_11;
        out[_e68] = u32((_e49 + 10i));
        let _e70 = float_value;
        let _e73 = local;
        local_7 = _e73;
        let _e75 = local_7;
        local_8 = u32(_e75);
        let _e78 = base;
        local_9 = u32((_e78 + 65u));
        let _e84 = local_8;
        let _e85 = local_9;
        local_12 = u32((_e84 + _e85));
        let _e89 = local_12;
        out[_e89] = u32((_e70 * 2f));
    }
}
