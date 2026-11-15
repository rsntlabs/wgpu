#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits) {
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
    if ((_e75 < -150)) {
        return _e11;
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e94 = iteration;
            iteration = (_e94 + 1u);
        }
        loop_init = false;
        uint _e83 = iteration;
        if ((_e83 >= 23u)) {
            break;
        }
        uint _e85 = remainder;
        uint _e86 = quotient;
        uint _e87 = (_e85 << 1u);
        bool _e88 = (_e87 >= _e68);
        remainder = (_e88 ? (_e87 - _e68) : _e87);
        quotient = ((_e86 << 1u) | (_e88 ? 1u : 0u));
    }
    uint _e96 = quotient;
    uint _e97 = remainder;
    if ((_e75 < -126)) {
        uint _e103 = (uint((-126 - _e75)) & 31u);
        uint _e104 = (1u << _e103);
        uint _e106 = (_e96 & (_e104 - 1u));
        uint _e107 = (_e104 >> 1u);
        uint _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u)));
    }
    uint _e120 = (_e97 << 1u);
    uint _e128 = (_e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u));
    uint _e130 = (_e128 >> 24u);
    int _e133 = (_e75 + int(_e130));
    if ((_e133 > 127)) {
        return _e12;
    }
    return (_e11 | ((uint((_e133 + 127)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

float reciprocal_value(float value) {
    uint _e4 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(value));
    return uintBitsToFloat(_e4);
}

int _frcp_rn(bool value_1) {
    int local_14 = 0;
    if (value_1) {
        local_14 = 7;
    } else {
        local_14 = 9;
    }
    int _e6 = local_14;
    return _e6;
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
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
    float local_12 = 0.0;
    uint local_13 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e20 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e20));
    float _e25 = reciprocal_value(value_2);
    local = uint((base + 1u));
    uint _e31 = local;
    _group_0_binding_1_cs[_e31] = floatBitsToUint(_e25);
    cursor = 0;
    int _e35 = cursor;
    cursor = (_e35 + 1);
    local_2 = uint((index + uint(_e35)));
    uint _e42 = local_2;
    uint _e44 = _group_0_binding_0_cs[_e42];
    float _e46 = reciprocal_value(uintBitsToFloat(_e44));
    local_1 = uint((base + 2u));
    uint _e52 = local_1;
    _group_0_binding_1_cs[_e52] = floatBitsToUint(_e46);
    local_3 = false;
    if (false) {
        int _e56 = cursor;
        cursor = (_e56 + 1);
        uint _e63 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(float(_e56)));
        uint _e66 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e63)));
        local_3 = (_e66 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e71 = cursor;
        cursor = (_e71 + 1);
        uint _e78 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(float(_e71)));
        uint _e81 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e78)));
        local_4 = (_e81 != 0u);
    }
    int _e84 = cursor;
    local_5 = uint((base + 3u));
    uint _e90 = local_5;
    _group_0_binding_1_cs[_e90] = uint(_e84);
    uint _e97 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e104 = local_6;
    _group_0_binding_1_cs[_e104] = floatBitsToUint(uintBitsToFloat(_e97));
    local_8 = 4286578688u;
    uint _e108 = local_8;
    uint _e113 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_e108)));
    local_7 = uint((base + 5u));
    uint _e120 = local_7;
    _group_0_binding_1_cs[_e120] = floatBitsToUint(uintBitsToFloat(_e113));
    float _e124 = reciprocal_value(float(2u));
    local_9 = uint((base + 6u));
    uint _e130 = local_9;
    _group_0_binding_1_cs[_e130] = floatBitsToUint(_e124);
    int _e133 = _frcp_rn(true);
    local_10 = uint((base + 7u));
    uint _e139 = local_10;
    _group_0_binding_1_cs[_e139] = uint(_e133);
    if (true) {
        uint _e145 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(value_2));
        local_12 = uintBitsToFloat(_e145);
    } else {
        int _e148 = cursor;
        cursor = (_e148 + 1);
        uint _e155 = _naga_divide_f32_(floatBitsToUint(1.0), floatBitsToUint(float(_e148)));
        local_12 = uintBitsToFloat(_e155);
    }
    float _e159 = local_12;
    local_11 = uint((base + 8u));
    uint _e165 = local_11;
    _group_0_binding_1_cs[_e165] = floatBitsToUint(_e159);
    int _e167 = cursor;
    local_13 = uint((base + 9u));
    uint _e173 = local_13;
    _group_0_binding_1_cs[_e173] = uint(_e167);
}

