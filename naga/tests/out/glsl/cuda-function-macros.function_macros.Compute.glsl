#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct Pair_cuda_record_0_ {
    uint first;
    uint second;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };


uint advance(uint value) {
    return (value + 3u);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    Pair_cuda_record_0_ pair = Pair_cuda_record_0_(0u, 0u);
    Pair_cuda_record_0_ local = Pair_cuda_record_0_(0u, 0u);
    uint values[3] = uint[3](0u, 0u, 0u);
    uvec2 vector = uvec2(0u);
    uint counter = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint declared = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    local.first = 11u;
    local.second = 13u;
    Pair_cuda_record_0_ _e11 = local;
    pair = _e11;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector = uvec2(17u, 19u);
    counter = 0u;
    _group_0_binding_0_cs[start] = 7u;
    local_1 = uint((start + 1u));
    uint _e33 = local_1;
    _group_0_binding_0_cs[_e33] = 11u;
    local_2 = uint((start + 2u));
    uint _e43 = local_2;
    _group_0_binding_0_cs[_e43] = (2u + 3u);
    local_3 = uint((start + 3u));
    uint _e54 = local_3;
    _group_0_binding_0_cs[_e54] = ((1u + 2u) * 3u);
    local_4 = uint((start + 4u));
    uint _e63 = local_4;
    _group_0_binding_0_cs[_e63] = (5u + 6u);
    local_5 = uint((start + 5u));
    uint _e72 = local_5;
    _group_0_binding_0_cs[_e72] = (7u + 8u);
    uint _e75 = pair.first;
    local_6 = uint((start + 6u));
    uint _e80 = local_6;
    _group_0_binding_0_cs[_e80] = _e75;
    uint _e83 = pair.second;
    local_7 = uint((start + 7u));
    uint _e88 = local_7;
    _group_0_binding_0_cs[_e88] = _e83;
    local_8 = uint((start + 8u));
    uint _e96 = local_8;
    _group_0_binding_0_cs[_e96] = uint(3);
    uint _e99 = values[lane];
    local_9 = uint((start + 9u));
    uint _e104 = local_9;
    _group_0_binding_0_cs[_e104] = _e99;
    uint _e107 = vector.x;
    local_10 = uint((start + 10u));
    uint _e112 = local_10;
    _group_0_binding_0_cs[_e112] = _e107;
    uint _e115 = vector.y;
    local_11 = uint((start + 11u));
    uint _e120 = local_11;
    _group_0_binding_0_cs[_e120] = _e115;
    uint _e122 = counter;
    counter = (_e122 + uint(1));
    uint _e126 = counter;
    counter = (_e126 + uint(1));
    local_12 = uint((start + 12u));
    uint _e134 = local_12;
    _group_0_binding_0_cs[_e134] = _e126;
    uint _e136 = counter;
    local_13 = uint((start + 13u));
    uint _e141 = local_13;
    _group_0_binding_0_cs[_e141] = _e136;
    local_14 = uint((start + 14u));
    uint _e147 = local_14;
    _group_0_binding_0_cs[_e147] = 19u;
    uint _e150 = counter;
    local_15 = uint((start + 15u));
    uint _e155 = local_15;
    _group_0_binding_0_cs[_e155] = _e150;
    values[0] = 23u;
    uint _e160 = values[0];
    local_16 = uint((start + 16u));
    uint _e165 = local_16;
    _group_0_binding_0_cs[_e165] = _e160;
    uint _e169 = values[0];
    local_17 = uint((start + 17u));
    uint _e174 = local_17;
    _group_0_binding_0_cs[_e174] = _e169;
    if ((lane == 0u)) {
        local_19 = 29u;
    } else {
        local_19 = 31u;
    }
    uint _e183 = local_19;
    local_18 = uint((start + 18u));
    uint _e188 = local_18;
    _group_0_binding_0_cs[_e188] = _e183;
    uint _e190 = advance(lane);
    local_20 = uint((start + 19u));
    uint _e195 = local_20;
    _group_0_binding_0_cs[_e195] = _e190;
    declared = 37u;
    uint _e199 = declared;
    local_21 = uint((start + 20u));
    uint _e204 = local_21;
    _group_0_binding_0_cs[_e204] = _e199;
    local_22 = uint((start + 21u));
    uint _e213 = local_22;
    _group_0_binding_0_cs[_e213] = floatBitsToUint(-(0.0));
    local_23 = uint((start + 22u));
    uint _e219 = local_23;
    _group_0_binding_0_cs[_e219] = 4294967295u;
    local_24 = uint((start + 23u));
    uint _e228 = local_24;
    _group_0_binding_0_cs[_e228] = (41u + lane);
}

