#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_4 {
    uint value;
};
layout(std430) readonly buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };


float forward(float value) {
    return value;
}

uint _naga_ceilf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e18 = (input_bits & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((1u - (_e6 >> 31u)) * 1065353216u))) : (((_e6 == 0u) && ((input_bits & _e14) != 0u)) ? (_e18 + _e13) : _e18))));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    float local_4 = 0.0;
    float local_5 = 0.0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    int local_9 = 0;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    float local_13 = 0.0;
    uint local_14 = 0u;
    float local_15 = 0.0;
    int extra = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e17 = _group_0_binding_0_cs[index];
    float value_1 = uintBitsToFloat(_e17);
    counter = 0u;
    uint _e22 = _naga_ceilf(floatBitsToUint(value_1));
    _group_0_binding_1_cs[base] = uint(uintBitsToFloat(_e22));
    float _e27 = forward(value_1);
    uint _e29 = _naga_ceilf(floatBitsToUint(_e27));
    local = uint((base + 1u));
    uint _e36 = local;
    _group_0_binding_1_cs[_e36] = uint(uintBitsToFloat(_e29));
    uint _e38 = counter;
    counter = (_e38 + uint(1));
    uint _e43 = _naga_ceilf(floatBitsToUint(value_1));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = uint(uintBitsToFloat(_e43));
    uint _e52 = counter;
    local_2 = uint((base + 3u));
    uint _e59 = local_2;
    _group_0_binding_1_cs[_e59] = uint(int(_e52));
    if (((index & 1u) != 0u)) {
        uint _e65 = counter;
        local_12 = _e65;
        uint _e67 = local_12;
        counter = (_e67 + uint(1));
        local_13 = value_1;
        float _e72 = local_13;
        local_4 = _e72;
        float _e74 = local_4;
        uint _e76 = _naga_ceilf(floatBitsToUint(_e74));
        local_6 = uint(uintBitsToFloat(_e76));
    } else {
        uint _e80 = counter;
        local_14 = _e80;
        uint _e82 = local_14;
        counter = (_e82 + uint(1));
        local_15 = value_1;
        float _e87 = local_15;
        local_5 = _e87;
        float _e89 = local_5;
        uint _e91 = _naga_ceilf(floatBitsToUint(_e89));
        local_6 = uint(uintBitsToFloat(_e91));
    }
    uint _e96 = local_6;
    local_3 = uint((base + 4u));
    uint _e101 = local_3;
    _group_0_binding_1_cs[_e101] = _e96;
    uint _e103 = counter;
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    _group_0_binding_1_cs[_e110] = uint(int(_e103));
    uint _e115 = _naga_ceilf(floatBitsToUint(float(16777217u)));
    local_8 = uint((base + 6u));
    uint _e122 = local_8;
    _group_0_binding_1_cs[_e122] = uint(uintBitsToFloat(_e115));
    local_9 = 7;
    extra = 0;
    extra = 3;
    int _e130 = local_9;
    int _e131 = extra;
    local_11 = uint((_e130 + _e131));
    uint _e135 = local_11;
    local_10 = uint((base + 7u));
    uint _e140 = local_10;
    _group_0_binding_1_cs[_e140] = _e135;
}

