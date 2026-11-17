#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_rintf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits & _e14);
    uint _e18 = (input_bits & ~(_e14));
    uint _e20 = (_e13 >> 1u);
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((input_bits & 2147483648u) | (((_e5 > 1056964608u) ? 1u : 0u) * 1065353216u))) : ((((_e15 > _e20) || ((_e15 == _e20) && ((_e18 & _e13) != 0u))) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

float rounded_even(float value) {
    uint _e2 = _naga_rintf(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

int rintf(bool value_1) {
    int local_17 = 0;
    if (value_1) {
        local_17 = 7;
    } else {
        local_17 = 9;
    }
    int _e6 = local_17;
    return _e6;
}

uint _naga_fabsf(uint input_bits_1) {
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_roundf(uint input_bits_2) {
    uint _e5 = (input_bits_2 & 2147483647u);
    uint _e6 = (input_bits_2 & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits_2 & _e14);
    uint _e18 = (input_bits_2 & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_2 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_2 : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    int cursor = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    bool local_3 = false;
    bool local_4 = false;
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
    float local_15 = 0.0;
    uint local_16 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e18 = _naga_rintf(floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e18));
    float _e23 = rounded_even(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    _group_0_binding_1_cs[_e29] = floatBitsToUint(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = (_e33 + 1);
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = _group_0_binding_0_cs[_e40];
    float _e44 = rounded_even(uintBitsToFloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = floatBitsToUint(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = (_e54 + 1);
        uint _e59 = _naga_rintf(floatBitsToUint(float(_e54)));
        uint _e62 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = (_e67 + 1);
        uint _e72 = _naga_rintf(floatBitsToUint(float(_e67)));
        uint _e75 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    _group_0_binding_1_cs[_e84] = uint(_e78);
    uint _e89 = _naga_rintf(floatBitsToUint(-(0.5)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    _group_0_binding_1_cs[_e96] = floatBitsToUint(uintBitsToFloat(_e89));
    uint _e100 = _naga_rintf(floatBitsToUint(0.5));
    local_7 = uint((base + 5u));
    uint _e107 = local_7;
    _group_0_binding_1_cs[_e107] = floatBitsToUint(uintBitsToFloat(_e100));
    uint _e111 = _naga_rintf(floatBitsToUint(2.5));
    local_8 = uint((base + 6u));
    uint _e118 = local_8;
    _group_0_binding_1_cs[_e118] = floatBitsToUint(uintBitsToFloat(_e111));
    uint _e122 = _naga_roundf(floatBitsToUint(2.5));
    local_9 = uint((base + 7u));
    uint _e129 = local_9;
    _group_0_binding_1_cs[_e129] = floatBitsToUint(uintBitsToFloat(_e122));
    uint _e134 = _naga_rintf(floatBitsToUint(-(2.5)));
    local_10 = uint((base + 8u));
    uint _e141 = local_10;
    _group_0_binding_1_cs[_e141] = floatBitsToUint(uintBitsToFloat(_e134));
    uint _e146 = _naga_roundf(floatBitsToUint(-(2.5)));
    local_11 = uint((base + 9u));
    uint _e153 = local_11;
    _group_0_binding_1_cs[_e153] = floatBitsToUint(uintBitsToFloat(_e146));
    float _e157 = rounded_even(float(3u));
    local_12 = uint((base + 10u));
    uint _e163 = local_12;
    _group_0_binding_1_cs[_e163] = floatBitsToUint(_e157);
    int _e166 = rintf(true);
    local_13 = uint((base + 11u));
    uint _e172 = local_13;
    _group_0_binding_1_cs[_e172] = uint(_e166);
    if (true) {
        uint _e176 = _naga_rintf(floatBitsToUint(value_2));
        uint _e179 = _naga_rintf(floatBitsToUint(uintBitsToFloat(_e176)));
        local_15 = uintBitsToFloat(_e179);
    } else {
        int _e182 = cursor;
        cursor = (_e182 + 1);
        uint _e187 = _naga_rintf(floatBitsToUint(float(_e182)));
        local_15 = uintBitsToFloat(_e187);
    }
    float _e191 = local_15;
    local_14 = uint((base + 12u));
    uint _e197 = local_14;
    _group_0_binding_1_cs[_e197] = floatBitsToUint(_e191);
    int _e199 = cursor;
    local_16 = uint((base + 13u));
    uint _e205 = local_16;
    _group_0_binding_1_cs[_e205] = uint(_e199);
}

