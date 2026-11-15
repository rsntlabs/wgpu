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

float quotient_value(float first, float second) {
    uint _e4 = _naga_divide_f32_(floatBitsToUint(first), floatBitsToUint(second));
    return uintBitsToFloat(_e4);
}

int _fdiv_rn(bool first_1, bool second_1) {
    int local_15 = 0;
    if (first_1) {
        local_15 = 7;
    } else {
        local_15 = 9;
    }
    int _e6 = local_15;
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
    uint local_1 = 0u;
    uint local_2 = 0u;
    int cursor = 0;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    bool local_6 = false;
    bool local_7 = false;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float first_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float second_2 = uintBitsToFloat(_e30);
    uint _e34 = _naga_divide_f32_(floatBitsToUint(first_2), floatBitsToUint(second_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e34));
    float _e39 = quotient_value(first_2, second_2);
    local_2 = uint((base + 1u));
    uint _e45 = local_2;
    _group_0_binding_1_cs[_e45] = floatBitsToUint(_e39);
    cursor = 0;
    int _e51 = cursor;
    cursor = (_e51 + 1);
    local_4 = uint(((index * 2u) + uint(_e51)));
    uint _e58 = local_4;
    uint _e60 = _group_0_binding_0_cs[_e58];
    int _e64 = cursor;
    cursor = (_e64 + 1);
    local_5 = uint(((index * 2u) + uint(_e64)));
    uint _e71 = local_5;
    uint _e73 = _group_0_binding_0_cs[_e71];
    float _e75 = quotient_value(uintBitsToFloat(_e60), uintBitsToFloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    _group_0_binding_1_cs[_e81] = floatBitsToUint(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = (_e85 + 1);
        uint _e91 = _naga_divide_f32_(floatBitsToUint(float(_e85)), floatBitsToUint(first_2));
        uint _e94 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = (_e99 + 1);
        uint _e105 = _naga_divide_f32_(floatBitsToUint(first_2), floatBitsToUint(float(_e99)));
        uint _e108 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    _group_0_binding_1_cs[_e117] = uint(_e111);
    uint _e125 = _naga_divide_f32_(floatBitsToUint(-(0.0)), floatBitsToUint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    _group_0_binding_1_cs[_e132] = floatBitsToUint(uintBitsToFloat(_e125));
    uint _e139 = _naga_divide_f32_(floatBitsToUint(-(0.0)), floatBitsToUint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    _group_0_binding_1_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e139));
    float _e152 = quotient_value(float(2), float(3u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    _group_0_binding_1_cs[_e158] = floatBitsToUint(_e152);
    int _e162 = _fdiv_rn(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    _group_0_binding_1_cs[_e168] = uint(_e162);
    uint _e172 = _naga_divide_f32_(floatBitsToUint(second_2), floatBitsToUint(first_2));
    local_13 = uint((base + 8u));
    uint _e179 = local_13;
    _group_0_binding_1_cs[_e179] = floatBitsToUint(uintBitsToFloat(_e172));
    float _e183 = quotient_value(1.0, 3.0);
    local_14 = uint((base + 9u));
    uint _e189 = local_14;
    _group_0_binding_1_cs[_e189] = floatBitsToUint(_e183);
}

