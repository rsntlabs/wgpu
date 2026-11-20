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


uint kind(float value_3) {
    return 1u;
}

uint _naga_divide_f32_rd(uint numerator_bits, uint denominator_bits) {
    uint numerator_significand = 0u;
    int numerator_exponent = 0;
    uint denominator_significand = 0u;
    int denominator_exponent = 0;
    uint quotient = 0u;
    uint remainder = 0u;
    uint iteration = 0u;
    uint _e8 = (numerator_bits & 2147483647u);
    uint _e9 = (denominator_bits & 2147483647u);
    uint _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    uint _e12 = (_e11 | 2139095040u);
    bool _e16 = (_e8 == 0u);
    bool _e17 = (_e9 == 0u);
    bool _e19 = (_e8 == 2139095040u);
    bool _e20 = (_e9 == 2139095040u);
    if (((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20))) {
        return 2143289344u;
    }
    if ((_e19 || _e17)) {
        return _e12;
    }
    if ((_e16 || _e20)) {
        return _e11;
    }
    uint _e30 = (_e8 & 8388607u);
    uint _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = (int(_e31) - 127);
    if ((_e31 == 0u)) {
        uint _e41 = (uint(31 - findMSB(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126 - int(_e41));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (int(_e53) - 127);
    if ((_e53 == 0u)) {
        uint _e63 = (uint(31 - findMSB(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126 - int(_e63));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = ((_e47 - _e69) - int(_e70));
    bool _e78 = (_e11 != 0u);
    if ((_e75 < -150)) {
        return (_e11 | uint(_e78));
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e97 = iteration;
            iteration = (_e97 + 1u);
        }
        loop_init = false;
        uint _e86 = iteration;
        if ((_e86 >= 23u)) {
            break;
        }
        uint _e88 = remainder;
        uint _e89 = quotient;
        uint _e90 = (_e88 << 1u);
        bool _e91 = (_e90 >= _e68);
        remainder = (_e91 ? (_e90 - _e68) : _e90);
        quotient = ((_e89 << 1u) | (_e91 ? 1u : 0u));
    }
    uint _e99 = quotient;
    uint _e100 = remainder;
    if ((_e75 < -126)) {
        uint _e106 = (uint((-126 - _e75)) & 31u);
        return (_e11 | ((_e99 >> _e106) + uint((_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)))));
    }
    uint _e120 = (_e99 + ((_e78 && (_e100 != 0u)) ? 1u : 0u));
    uint _e122 = (_e120 >> 24u);
    int _e125 = (_e75 + int(_e122));
    if ((_e125 > 127)) {
        return (_e78 ? _e12 : 2139095039u);
    }
    return (_e11 | ((uint((_e125 + 127)) << 23u) | ((_e120 >> _e122) & 8388607u)));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    float value = 0.0;
    float value_1 = 0.0;
    float value_2 = 0.0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e18 = _group_0_binding_0_cs[index].x;
    float x = uintBitsToFloat(_e18);
    uint _e22 = _group_0_binding_0_cs[index].y;
    float y = uintBitsToFloat(_e22);
    counter = 0u;
    uint _e28 = _naga_divide_f32_rd(floatBitsToUint(x), floatBitsToUint(y));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e28));
    value = 0.0;
    value = x;
    uint _e36 = counter;
    counter = (_e36 + uint(1));
    float _e40 = value;
    value_1 = 0.0;
    value_1 = y;
    uint _e44 = counter;
    counter = (_e44 + uint(1));
    float _e48 = value_1;
    uint _e51 = _naga_divide_f32_rd(floatBitsToUint(_e40), floatBitsToUint(_e48));
    local = uint((base + 1u));
    uint _e58 = local;
    _group_0_binding_1_cs[_e58] = floatBitsToUint(uintBitsToFloat(_e51));
    uint _e60 = counter;
    local_1 = uint((base + 2u));
    uint _e65 = local_1;
    _group_0_binding_1_cs[_e65] = _e60;
    uint _e70 = _naga_divide_f32_rd(floatBitsToUint(1.0), floatBitsToUint(y));
    local_2 = uint((base + 3u));
    uint _e77 = local_2;
    _group_0_binding_1_cs[_e77] = floatBitsToUint(uintBitsToFloat(_e70));
    value_2 = 0.0;
    value_2 = y;
    uint _e82 = counter;
    counter = (_e82 + uint(1));
    float _e86 = value_2;
    uint _e90 = _naga_divide_f32_rd(floatBitsToUint(1.0), floatBitsToUint(_e86));
    local_3 = uint((base + 4u));
    uint _e97 = local_3;
    _group_0_binding_1_cs[_e97] = floatBitsToUint(uintBitsToFloat(_e90));
    uint _e99 = counter;
    local_4 = uint((base + 5u));
    uint _e104 = local_4;
    _group_0_binding_1_cs[_e104] = _e99;
    uint _e108 = _naga_divide_f32_rd(floatBitsToUint(x), floatBitsToUint(y));
    uint _e110 = kind(uintBitsToFloat(_e108));
    local_5 = uint((base + 6u));
    uint _e115 = local_5;
    _group_0_binding_1_cs[_e115] = _e110;
    uint _e120 = _naga_divide_f32_rd(floatBitsToUint(1.0), floatBitsToUint(y));
    uint _e122 = kind(uintBitsToFloat(_e120));
    local_6 = uint((base + 7u));
    uint _e127 = local_6;
    _group_0_binding_1_cs[_e127] = _e122;
}

