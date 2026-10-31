@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn later(value: u32) -> u32 {
    return (value + 73u);
}

@compute @workgroup_size(2, 1, 1)
fn preprocessing_conditions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
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
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var counter: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let start = (lane * 24u);
    out[start] = 7u;
    local = u32((start + 1u));
    let _e13 = local;
    out[_e13] = 11u;
    local_1 = u32((start + 2u));
    let _e20 = local_1;
    out[_e20] = 13u;
    local_2 = u32((start + 3u));
    let _e27 = local_2;
    out[_e27] = 17u;
    local_3 = u32((start + 4u));
    let _e34 = local_3;
    out[_e34] = 19u;
    local_4 = u32((start + 5u));
    let _e41 = local_4;
    out[_e41] = 23u;
    local_5 = u32((start + 6u));
    let _e48 = local_5;
    out[_e48] = 29u;
    local_6 = u32((start + 7u));
    let _e55 = local_6;
    out[_e55] = 31u;
    local_7 = u32((start + 8u));
    let _e62 = local_7;
    out[_e62] = 37u;
    local_8 = u32((start + 9u));
    let _e69 = local_8;
    out[_e69] = 41u;
    local_9 = u32((start + 10u));
    let _e76 = local_9;
    out[_e76] = 43u;
    local_10 = u32((start + 11u));
    let _e83 = local_10;
    out[_e83] = 47u;
    local_11 = u32((start + 12u));
    let _e90 = local_11;
    out[_e90] = 53u;
    local_12 = u32((start + 13u));
    let _e97 = local_12;
    out[_e97] = 59u;
    local_13 = u32((start + 14u));
    let _e104 = local_13;
    out[_e104] = 61u;
    local_14 = u32((start + 15u));
    let _e111 = local_14;
    out[_e111] = 67u;
    local_15 = u32((start + 16u));
    let _e118 = local_15;
    out[_e118] = 71u;
    let _e121 = later(lane);
    local_16 = u32((start + 17u));
    let _e126 = local_16;
    out[_e126] = _e121;
    counter = 0u;
    let _e130 = counter;
    counter = (_e130 + u32(1i));
    local_17 = u32((start + 18u));
    let _e138 = local_17;
    out[_e138] = _e130;
    let _e140 = counter;
    local_18 = u32((start + 19u));
    let _e145 = local_18;
    out[_e145] = _e140;
    local_19 = u32((start + 20u));
    let _e153 = local_19;
    out[_e153] = u32(true);
    local_20 = u32((start + 21u));
    let _e159 = local_20;
    out[_e159] = lane;
    local_21 = u32((start + 22u));
    let _e168 = local_21;
    out[_e168] = bitcast<u32>(-(0f));
    local_22 = u32((start + 23u));
    let _e174 = local_22;
    out[_e174] = 4294967295u;
}
