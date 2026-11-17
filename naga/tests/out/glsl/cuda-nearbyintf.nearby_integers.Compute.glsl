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

float nearby_value(float value) {
    uint _e2 = _naga_rintf(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

int nearbyintf(bool value_1) {
    int local_15 = 0;
    if (value_1) {
        local_15 = 7;
    } else {
        local_15 = 9;
    }
    int _e6 = local_15;
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
    uint local_1 = 0u;
    int cursor = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    bool local_4 = false;
    bool local_5 = false;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    float local_13 = 0.0;
    uint local_14 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 32u)) {
        return;
    }
    uint base = (4u + (index * 12u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e18 = _naga_rintf(floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e18));
    uint _e24 = _naga_rintf(floatBitsToUint(value_2));
    local = uint((base + 1u));
    uint _e31 = local;
    _group_0_binding_1_cs[_e31] = floatBitsToUint(uintBitsToFloat(_e24));
    float _e33 = nearby_value(value_2);
    local_1 = uint((base + 2u));
    uint _e39 = local_1;
    _group_0_binding_1_cs[_e39] = floatBitsToUint(_e33);
    cursor = 0;
    int _e43 = cursor;
    cursor = (_e43 + 1);
    local_3 = uint((index + uint(_e43)));
    uint _e50 = local_3;
    uint _e52 = _group_0_binding_0_cs[_e50];
    float _e54 = nearby_value(uintBitsToFloat(_e52));
    local_2 = uint((base + 3u));
    uint _e60 = local_2;
    _group_0_binding_1_cs[_e60] = floatBitsToUint(_e54);
    local_4 = false;
    if (false) {
        int _e64 = cursor;
        cursor = (_e64 + 1);
        uint _e69 = _naga_rintf(floatBitsToUint(float(_e64)));
        uint _e72 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e69)));
        local_4 = (_e72 != 0u);
    }
    local_5 = true;
    if (true) {
    } else {
        int _e77 = cursor;
        cursor = (_e77 + 1);
        uint _e82 = _naga_rintf(floatBitsToUint(float(_e77)));
        uint _e85 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e82)));
        local_5 = (_e85 != 0u);
    }
    int _e88 = cursor;
    local_6 = uint((base + 4u));
    uint _e94 = local_6;
    _group_0_binding_1_cs[_e94] = uint(_e88);
    uint _e99 = _naga_rintf(floatBitsToUint(-(0.5)));
    local_7 = uint((base + 5u));
    uint _e106 = local_7;
    _group_0_binding_1_cs[_e106] = floatBitsToUint(uintBitsToFloat(_e99));
    uint _e110 = _naga_rintf(floatBitsToUint(2.5));
    local_8 = uint((base + 6u));
    uint _e117 = local_8;
    _group_0_binding_1_cs[_e117] = floatBitsToUint(uintBitsToFloat(_e110));
    uint _e121 = _naga_roundf(floatBitsToUint(2.5));
    local_9 = uint((base + 7u));
    uint _e128 = local_9;
    _group_0_binding_1_cs[_e128] = floatBitsToUint(uintBitsToFloat(_e121));
    float _e132 = nearby_value(float(3u));
    local_10 = uint((base + 8u));
    uint _e138 = local_10;
    _group_0_binding_1_cs[_e138] = floatBitsToUint(_e132);
    int _e141 = nearbyintf(true);
    local_11 = uint((base + 9u));
    uint _e147 = local_11;
    _group_0_binding_1_cs[_e147] = uint(_e141);
    if (true) {
        uint _e151 = _naga_rintf(floatBitsToUint(value_2));
        uint _e154 = _naga_rintf(floatBitsToUint(uintBitsToFloat(_e151)));
        local_13 = uintBitsToFloat(_e154);
    } else {
        int _e157 = cursor;
        cursor = (_e157 + 1);
        uint _e162 = _naga_rintf(floatBitsToUint(float(_e157)));
        local_13 = uintBitsToFloat(_e162);
    }
    float _e166 = local_13;
    local_12 = uint((base + 10u));
    uint _e172 = local_12;
    _group_0_binding_1_cs[_e172] = floatBitsToUint(_e166);
    int _e174 = cursor;
    local_14 = uint((base + 11u));
    uint _e180 = local_14;
    _group_0_binding_1_cs[_e180] = uint(_e174);
}

