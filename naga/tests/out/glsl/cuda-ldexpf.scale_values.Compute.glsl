#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_6 {
    uint value;
};
layout(std430) readonly buffer type_4_block_0Compute { uvec2 _group_0_binding_0_cs[]; };

layout(std430) buffer type_5_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_6_block_2Compute { type_6 _group_0_binding_2_cs; };


uint kind(float value_2) {
    return 1u;
}

uint _naga_ldexpf(uint bits, int exponent) {
    uint _e12 = (bits & 2147483647u);
    uint _e13 = (bits & 2147483648u);
    if ((_e12 > 2139095040u)) {
        return 2143289344u;
    }
    if (((_e12 == 0u) || (_e12 == 2139095040u))) {
        return bits;
    }
    uint _e21 = (max(uint(31 - findMSB(_e12)), 8u) - 8u);
    uint _e23 = ((_e12 << _e21) & 8388607u);
    uint _e24 = (_e23 | 8388608u);
    int _e33 = ((max(int((_e12 >> 23u)), 1) - int(_e21)) + min(max(exponent, -512), 512));
    if ((_e33 >= 255)) {
        return (2139095040u | _e13);
    }
    if ((_e33 >= 1)) {
        return (((uint(_e33) << 23u) | _e23) | _e13);
    }
    uint _e45 = uint(min(max((1 - _e33), 1), 25));
    uint _e46 = (_e24 >> _e45);
    uint _e47 = (1u << _e45);
    uint _e49 = (_e24 & (_e47 - 1u));
    uint _e50 = (_e47 >> 1u);
    return ((_e46 + (((_e49 > _e50) || ((_e49 == _e50) && ((_e46 & 1u) != 0u))) ? 1u : 0u)) | _e13);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    float value = 0.0;
    int value_1 = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e18 = _group_0_binding_0_cs[index].x;
    float value_3 = uintBitsToFloat(_e18);
    uint _e22 = _group_0_binding_0_cs[index].y;
    int power = int(_e22);
    counter = 0u;
    uint _e27 = _naga_ldexpf(floatBitsToUint(value_3), power);
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e27));
    value = 0.0;
    value = value_3;
    uint _e35 = counter;
    counter = (_e35 + uint(1));
    float _e39 = value;
    value_1 = 0;
    value_1 = power;
    uint _e43 = counter;
    counter = (_e43 + uint(1));
    int _e47 = value_1;
    uint _e49 = _naga_ldexpf(floatBitsToUint(_e39), _e47);
    local = uint((base + 1u));
    uint _e56 = local;
    _group_0_binding_1_cs[_e56] = floatBitsToUint(uintBitsToFloat(_e49));
    uint _e58 = counter;
    local_1 = uint((base + 2u));
    uint _e63 = local_1;
    _group_0_binding_1_cs[_e63] = _e58;
    uint _e66 = _naga_ldexpf(floatBitsToUint(value_3), power);
    uint _e68 = kind(uintBitsToFloat(_e66));
    local_2 = uint((base + 3u));
    uint _e73 = local_2;
    _group_0_binding_1_cs[_e73] = _e68;
}

