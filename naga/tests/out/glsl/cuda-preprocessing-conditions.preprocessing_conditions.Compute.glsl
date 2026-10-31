#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };


uint later(uint value) {
    return (value + 73u);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
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
    uint counter = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint start = (lane * 24u);
    _group_0_binding_0_cs[start] = 7u;
    local = uint((start + 1u));
    uint _e13 = local;
    _group_0_binding_0_cs[_e13] = 11u;
    local_1 = uint((start + 2u));
    uint _e20 = local_1;
    _group_0_binding_0_cs[_e20] = 13u;
    local_2 = uint((start + 3u));
    uint _e27 = local_2;
    _group_0_binding_0_cs[_e27] = 17u;
    local_3 = uint((start + 4u));
    uint _e34 = local_3;
    _group_0_binding_0_cs[_e34] = 19u;
    local_4 = uint((start + 5u));
    uint _e41 = local_4;
    _group_0_binding_0_cs[_e41] = 23u;
    local_5 = uint((start + 6u));
    uint _e48 = local_5;
    _group_0_binding_0_cs[_e48] = 29u;
    local_6 = uint((start + 7u));
    uint _e55 = local_6;
    _group_0_binding_0_cs[_e55] = 31u;
    local_7 = uint((start + 8u));
    uint _e62 = local_7;
    _group_0_binding_0_cs[_e62] = 37u;
    local_8 = uint((start + 9u));
    uint _e69 = local_8;
    _group_0_binding_0_cs[_e69] = 41u;
    local_9 = uint((start + 10u));
    uint _e76 = local_9;
    _group_0_binding_0_cs[_e76] = 43u;
    local_10 = uint((start + 11u));
    uint _e83 = local_10;
    _group_0_binding_0_cs[_e83] = 47u;
    local_11 = uint((start + 12u));
    uint _e90 = local_11;
    _group_0_binding_0_cs[_e90] = 53u;
    local_12 = uint((start + 13u));
    uint _e97 = local_12;
    _group_0_binding_0_cs[_e97] = 59u;
    local_13 = uint((start + 14u));
    uint _e104 = local_13;
    _group_0_binding_0_cs[_e104] = 61u;
    local_14 = uint((start + 15u));
    uint _e111 = local_14;
    _group_0_binding_0_cs[_e111] = 67u;
    local_15 = uint((start + 16u));
    uint _e118 = local_15;
    _group_0_binding_0_cs[_e118] = 71u;
    uint _e121 = later(lane);
    local_16 = uint((start + 17u));
    uint _e126 = local_16;
    _group_0_binding_0_cs[_e126] = _e121;
    counter = 0u;
    uint _e130 = counter;
    counter = (_e130 + uint(1));
    local_17 = uint((start + 18u));
    uint _e138 = local_17;
    _group_0_binding_0_cs[_e138] = _e130;
    uint _e140 = counter;
    local_18 = uint((start + 19u));
    uint _e145 = local_18;
    _group_0_binding_0_cs[_e145] = _e140;
    local_19 = uint((start + 20u));
    uint _e153 = local_19;
    _group_0_binding_0_cs[_e153] = uint(true);
    local_20 = uint((start + 21u));
    uint _e159 = local_20;
    _group_0_binding_0_cs[_e159] = lane;
    local_21 = uint((start + 22u));
    uint _e168 = local_21;
    _group_0_binding_0_cs[_e168] = floatBitsToUint(-(0.0));
    local_22 = uint((start + 23u));
    uint _e174 = local_22;
    _group_0_binding_0_cs[_e174] = 4294967295u;
}

