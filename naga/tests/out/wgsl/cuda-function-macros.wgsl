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
    var values: array<u32, 3>;
    var vector: vec2<u32>;
    var counter: u32;
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
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var declared: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let start = (lane * 24u);
    pair.first = 11u;
    pair.second = 13u;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector = vec2<u32>(17u, 19u);
    counter = 0u;
    out[start] = 7u;
    local = u32((start + 1u));
    let _e31 = local;
    out[_e31] = 11u;
    local_1 = u32((start + 2u));
    let _e41 = local_1;
    out[_e41] = (2u + 3u);
    local_2 = u32((start + 3u));
    let _e52 = local_2;
    out[_e52] = ((1u + 2u) * 3u);
    local_3 = u32((start + 4u));
    let _e61 = local_3;
    out[_e61] = (5u + 6u);
    local_4 = u32((start + 5u));
    let _e70 = local_4;
    out[_e70] = (7u + 8u);
    let _e73 = pair.first;
    local_5 = u32((start + 6u));
    let _e78 = local_5;
    out[_e78] = _e73;
    let _e81 = pair.second;
    local_6 = u32((start + 7u));
    let _e86 = local_6;
    out[_e86] = _e81;
    local_7 = u32((start + 8u));
    let _e94 = local_7;
    out[_e94] = u32(3i);
    let _e97 = values[lane];
    local_8 = u32((start + 9u));
    let _e102 = local_8;
    out[_e102] = _e97;
    let _e105 = vector.x;
    local_9 = u32((start + 10u));
    let _e110 = local_9;
    out[_e110] = _e105;
    let _e113 = vector.y;
    local_10 = u32((start + 11u));
    let _e118 = local_10;
    out[_e118] = _e113;
    let _e120 = counter;
    counter = (_e120 + u32(1i));
    let _e124 = counter;
    counter = (_e124 + u32(1i));
    local_11 = u32((start + 12u));
    let _e132 = local_11;
    out[_e132] = _e124;
    let _e134 = counter;
    local_12 = u32((start + 13u));
    let _e139 = local_12;
    out[_e139] = _e134;
    local_13 = u32((start + 14u));
    let _e145 = local_13;
    out[_e145] = 19u;
    let _e148 = counter;
    local_14 = u32((start + 15u));
    let _e153 = local_14;
    out[_e153] = _e148;
    values[0i] = 23u;
    let _e158 = values[0i];
    local_15 = u32((start + 16u));
    let _e163 = local_15;
    out[_e163] = _e158;
    let _e167 = values[0i];
    local_16 = u32((start + 17u));
    let _e172 = local_16;
    out[_e172] = _e167;
    if (lane == 0u) {
        local_18 = 29u;
    } else {
        local_18 = 31u;
    }
    let _e181 = local_18;
    local_17 = u32((start + 18u));
    let _e186 = local_17;
    out[_e186] = _e181;
    let _e188 = advance(lane);
    local_19 = u32((start + 19u));
    let _e193 = local_19;
    out[_e193] = _e188;
    declared = 37u;
    let _e197 = declared;
    local_20 = u32((start + 20u));
    let _e202 = local_20;
    out[_e202] = _e197;
    local_21 = u32((start + 21u));
    let _e211 = local_21;
    out[_e211] = bitcast<u32>(-(0f));
    local_22 = u32((start + 22u));
    let _e217 = local_22;
    out[_e217] = 4294967295u;
    local_23 = u32((start + 23u));
    let _e226 = local_23;
    out[_e226] = (41u + lane);
}
