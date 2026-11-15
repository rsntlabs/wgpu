#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_floorf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value) {
    uint _e2 = _naga_floorf(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

uint _naga_ceilf(uint input_bits_1) {
    uint _e5 = (input_bits_1 & 2147483647u);
    uint _e6 = (input_bits_1 & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e18 = (input_bits_1 & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_1 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_1 : (_e6 | ((1u - (_e6 >> 31u)) * 1065353216u))) : (((_e6 == 0u) && ((input_bits_1 & _e14) != 0u)) ? (_e18 + _e13) : _e18))));
}

float ceil_value(float value_1) {
    uint _e2 = _naga_ceilf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
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
    int cursor = 0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint index = threadIdx.x;
    uint bits = _group_0_binding_0_cs[index];
    uint base = (4u + (index * 14u));
    uint _e11 = _naga_floorf(floatBitsToUint(uintBitsToFloat(bits)));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e11));
    uint _e18 = _naga_ceilf(floatBitsToUint(uintBitsToFloat(bits)));
    local = uint((base + 1u));
    uint _e25 = local;
    _group_0_binding_1_cs[_e25] = floatBitsToUint(uintBitsToFloat(_e18));
    float _e28 = floor_value(uintBitsToFloat(bits));
    local_1 = uint((base + 2u));
    uint _e34 = local_1;
    _group_0_binding_1_cs[_e34] = floatBitsToUint(_e28);
    float _e37 = ceil_value(uintBitsToFloat(bits));
    local_2 = uint((base + 3u));
    uint _e43 = local_2;
    _group_0_binding_1_cs[_e43] = floatBitsToUint(_e37);
    uint _e47 = _naga_floorf(floatBitsToUint(0.0));
    local_3 = uint((base + 4u));
    uint _e54 = local_3;
    _group_0_binding_1_cs[_e54] = floatBitsToUint(uintBitsToFloat(_e47));
    uint _e59 = _naga_floorf(floatBitsToUint(-(0.0)));
    local_4 = uint((base + 5u));
    uint _e66 = local_4;
    _group_0_binding_1_cs[_e66] = floatBitsToUint(uintBitsToFloat(_e59));
    uint _e70 = _naga_ceilf(floatBitsToUint(0.0));
    local_5 = uint((base + 6u));
    uint _e77 = local_5;
    _group_0_binding_1_cs[_e77] = floatBitsToUint(uintBitsToFloat(_e70));
    uint _e82 = _naga_ceilf(floatBitsToUint(-(0.0)));
    local_6 = uint((base + 7u));
    uint _e89 = local_6;
    _group_0_binding_1_cs[_e89] = floatBitsToUint(uintBitsToFloat(_e82));
    uint _e93 = _naga_floorf(floatBitsToUint(0.25));
    local_7 = uint((base + 8u));
    uint _e100 = local_7;
    _group_0_binding_1_cs[_e100] = floatBitsToUint(uintBitsToFloat(_e93));
    uint _e105 = _naga_ceilf(floatBitsToUint(-(0.25)));
    local_8 = uint((base + 9u));
    uint _e112 = local_8;
    _group_0_binding_1_cs[_e112] = floatBitsToUint(uintBitsToFloat(_e105));
    cursor = 0;
    int _e116 = cursor;
    cursor = (_e116 + 1);
    local_10 = uint((index + uint(_e116)));
    uint _e123 = local_10;
    uint _e125 = _group_0_binding_0_cs[_e123];
    float _e127 = floor_value(uintBitsToFloat(_e125));
    local_9 = uint((base + 10u));
    uint _e133 = local_9;
    _group_0_binding_1_cs[_e133] = floatBitsToUint(_e127);
    int _e135 = cursor;
    cursor = (_e135 + 1);
    float _e139 = ceil_value(float(_e135));
    local_11 = uint((base + 11u));
    uint _e145 = local_11;
    _group_0_binding_1_cs[_e145] = floatBitsToUint(_e139);
    int _e147 = cursor;
    local_12 = uint((base + 12u));
    uint _e155 = local_12;
    _group_0_binding_1_cs[_e155] = uint((_e147 - 1));
    int _e157 = cursor;
    local_13 = uint((base + 13u));
    uint _e163 = local_13;
    _group_0_binding_1_cs[_e163] = uint(_e157);
}

