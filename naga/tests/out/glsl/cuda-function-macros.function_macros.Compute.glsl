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
    uint values[3] = uint[3](0u, 0u, 0u);
    uvec2 vector = uvec2(0u);
    uint counter = 0u;
    uint local = 0u;
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
    uint declared = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    pair.first = 11u;
    pair.second = 13u;
    values[0] = 2u;
    values[1] = 3u;
    values[2] = 5u;
    vector = uvec2(17u, 19u);
    counter = 0u;
    _group_0_binding_0_cs[start] = 7u;
    local = uint((start + 1u));
    uint _e31 = local;
    _group_0_binding_0_cs[_e31] = 11u;
    local_1 = uint((start + 2u));
    uint _e41 = local_1;
    _group_0_binding_0_cs[_e41] = (2u + 3u);
    local_2 = uint((start + 3u));
    uint _e52 = local_2;
    _group_0_binding_0_cs[_e52] = ((1u + 2u) * 3u);
    local_3 = uint((start + 4u));
    uint _e61 = local_3;
    _group_0_binding_0_cs[_e61] = (5u + 6u);
    local_4 = uint((start + 5u));
    uint _e70 = local_4;
    _group_0_binding_0_cs[_e70] = (7u + 8u);
    uint _e73 = pair.first;
    local_5 = uint((start + 6u));
    uint _e78 = local_5;
    _group_0_binding_0_cs[_e78] = _e73;
    uint _e81 = pair.second;
    local_6 = uint((start + 7u));
    uint _e86 = local_6;
    _group_0_binding_0_cs[_e86] = _e81;
    local_7 = uint((start + 8u));
    uint _e94 = local_7;
    _group_0_binding_0_cs[_e94] = uint(3);
    uint _e97 = values[lane];
    local_8 = uint((start + 9u));
    uint _e102 = local_8;
    _group_0_binding_0_cs[_e102] = _e97;
    uint _e105 = vector.x;
    local_9 = uint((start + 10u));
    uint _e110 = local_9;
    _group_0_binding_0_cs[_e110] = _e105;
    uint _e113 = vector.y;
    local_10 = uint((start + 11u));
    uint _e118 = local_10;
    _group_0_binding_0_cs[_e118] = _e113;
    uint _e120 = counter;
    counter = (_e120 + uint(1));
    uint _e124 = counter;
    counter = (_e124 + uint(1));
    local_11 = uint((start + 12u));
    uint _e132 = local_11;
    _group_0_binding_0_cs[_e132] = _e124;
    uint _e134 = counter;
    local_12 = uint((start + 13u));
    uint _e139 = local_12;
    _group_0_binding_0_cs[_e139] = _e134;
    local_13 = uint((start + 14u));
    uint _e145 = local_13;
    _group_0_binding_0_cs[_e145] = 19u;
    uint _e148 = counter;
    local_14 = uint((start + 15u));
    uint _e153 = local_14;
    _group_0_binding_0_cs[_e153] = _e148;
    values[0] = 23u;
    uint _e158 = values[0];
    local_15 = uint((start + 16u));
    uint _e163 = local_15;
    _group_0_binding_0_cs[_e163] = _e158;
    uint _e167 = values[0];
    local_16 = uint((start + 17u));
    uint _e172 = local_16;
    _group_0_binding_0_cs[_e172] = _e167;
    if ((lane == 0u)) {
        local_18 = 29u;
    } else {
        local_18 = 31u;
    }
    uint _e181 = local_18;
    local_17 = uint((start + 18u));
    uint _e186 = local_17;
    _group_0_binding_0_cs[_e186] = _e181;
    uint _e188 = advance(lane);
    local_19 = uint((start + 19u));
    uint _e193 = local_19;
    _group_0_binding_0_cs[_e193] = _e188;
    declared = 37u;
    uint _e197 = declared;
    local_20 = uint((start + 20u));
    uint _e202 = local_20;
    _group_0_binding_0_cs[_e202] = _e197;
    local_21 = uint((start + 21u));
    uint _e211 = local_21;
    _group_0_binding_0_cs[_e211] = floatBitsToUint(-(0.0));
    local_22 = uint((start + 22u));
    uint _e217 = local_22;
    _group_0_binding_0_cs[_e217] = 4294967295u;
    local_23 = uint((start + 23u));
    uint _e226 = local_23;
    _group_0_binding_0_cs[_e226] = (41u + lane);
}

