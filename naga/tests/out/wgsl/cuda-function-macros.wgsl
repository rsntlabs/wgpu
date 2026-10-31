struct Pair_cuda_record_0_ {
    first: u32,
    second: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn advance(value: u32) -> u32 {
    return (value + 3u);
}

@compute @workgroup_size(2, 1, 1)
fn function_macros(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var pair: Pair_cuda_record_0_;
    var local: Pair_cuda_record_0_;
    var values: array<u32, 3>;
    var vector: vec2<u32>;
    var counter: u32;
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
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var declared: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let start = (lane * 24u);
    local.first = 11u;
    local.second = 13u;
    let _e11 = local;
    pair = _e11;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector = vec2<u32>(17u, 19u);
    counter = 0u;
    out[start] = 7u;
    local_1 = u32((start + 1u));
    let _e33 = local_1;
    out[_e33] = 11u;
    local_2 = u32((start + 2u));
    let _e43 = local_2;
    out[_e43] = (2u + 3u);
    local_3 = u32((start + 3u));
    let _e54 = local_3;
    out[_e54] = ((1u + 2u) * 3u);
    local_4 = u32((start + 4u));
    let _e63 = local_4;
    out[_e63] = (5u + 6u);
    local_5 = u32((start + 5u));
    let _e72 = local_5;
    out[_e72] = (7u + 8u);
    let _e75 = pair.first;
    local_6 = u32((start + 6u));
    let _e80 = local_6;
    out[_e80] = _e75;
    let _e83 = pair.second;
    local_7 = u32((start + 7u));
    let _e88 = local_7;
    out[_e88] = _e83;
    local_8 = u32((start + 8u));
    let _e96 = local_8;
    out[_e96] = u32(3i);
    let _e99 = values[lane];
    local_9 = u32((start + 9u));
    let _e104 = local_9;
    out[_e104] = _e99;
    let _e107 = vector.x;
    local_10 = u32((start + 10u));
    let _e112 = local_10;
    out[_e112] = _e107;
    let _e115 = vector.y;
    local_11 = u32((start + 11u));
    let _e120 = local_11;
    out[_e120] = _e115;
    let _e122 = counter;
    counter = (_e122 + u32(1i));
    let _e126 = counter;
    counter = (_e126 + u32(1i));
    local_12 = u32((start + 12u));
    let _e134 = local_12;
    out[_e134] = _e126;
    let _e136 = counter;
    local_13 = u32((start + 13u));
    let _e141 = local_13;
    out[_e141] = _e136;
    local_14 = u32((start + 14u));
    let _e147 = local_14;
    out[_e147] = 19u;
    let _e150 = counter;
    local_15 = u32((start + 15u));
    let _e155 = local_15;
    out[_e155] = _e150;
    values[0i] = 23u;
    let _e160 = values[0i];
    local_16 = u32((start + 16u));
    let _e165 = local_16;
    out[_e165] = _e160;
    let _e169 = values[0i];
    local_17 = u32((start + 17u));
    let _e174 = local_17;
    out[_e174] = _e169;
    if (lane == 0u) {
        local_19 = 29u;
    } else {
        local_19 = 31u;
    }
    let _e183 = local_19;
    local_18 = u32((start + 18u));
    let _e188 = local_18;
    out[_e188] = _e183;
    let _e190 = advance(lane);
    local_20 = u32((start + 19u));
    let _e195 = local_20;
    out[_e195] = _e190;
    declared = 37u;
    let _e199 = declared;
    local_21 = u32((start + 20u));
    let _e204 = local_21;
    out[_e204] = _e199;
    local_22 = u32((start + 21u));
    let _e213 = local_22;
    out[_e213] = bitcast<u32>(-(0f));
    local_23 = u32((start + 22u));
    let _e219 = local_23;
    out[_e219] = 4294967295u;
    local_24 = u32((start + 23u));
    let _e228 = local_24;
    out[_e228] = (41u + lane);
}
