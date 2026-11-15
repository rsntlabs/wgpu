#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fadd_rn(uint left_bits, uint right_bits) {
    uint _e9 = (left_bits & 2147483647u);
    uint _e10 = (right_bits & 2147483647u);
    uint _e11 = (left_bits & 2147483648u);
    uint _e12 = (right_bits & 2147483648u);
    if (((_e9 > 2139095040u) || (_e10 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e16 = (_e9 == 2139095040u);
    bool _e17 = (_e10 == 2139095040u);
    if (((_e16 && _e17) && (_e11 != _e12))) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits;
    }
    if (_e17) {
        return right_bits;
    }
    bool _e22 = (_e9 >= _e10);
    uint _e23 = (_e22 ? _e9 : _e10);
    uint _e24 = (_e22 ? _e10 : _e9);
    uint _e25 = (_e22 ? _e11 : _e12);
    uint _e29 = (_e23 >> 23u);
    uint _e30 = (_e24 >> 23u);
    bool _e31 = (_e29 != 0u);
    bool _e32 = (_e30 != 0u);
    uint _e39 = (((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u);
    uint _e40 = (((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u);
    uint _e41 = (_e31 ? _e29 : 1u);
    uint _e43 = (_e41 - (_e32 ? _e30 : 1u));
    uint _e48 = (_e43 & 31u);
    uint _e59 = ((_e43 < 32u) ? ((_e40 >> _e48) | uint(((_e40 & ((1u << _e48) - 1u)) != 0u))) : uint((_e40 != 0u)));
    uint _e62 = ((_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59));
    if ((_e62 == 0u)) {
        return (_e11 & _e12);
    }
    bool _e66 = (_e62 >= 134217728u);
    uint _e71 = (1u & 31u);
    uint _e83 = (_e66 ? ((1u < 32u) ? ((_e62 >> _e71) | uint(((_e62 & ((1u << _e71) - 1u)) != 0u))) : uint((_e62 != 0u))) : _e62);
    uint _e85 = (_e41 + uint(_e66));
    uint _e90 = min((uint(31 - findMSB(_e83)) - 5u), (_e85 - 1u));
    uint _e91 = (_e83 << _e90);
    uint _e95 = (_e91 & 7u);
    uint _e96 = (_e91 >> 3u);
    uint _e104 = (_e96 + uint(((_e95 > 4u) || ((_e95 == 4u) && ((_e96 & 1u) != 0u)))));
    bool _e106 = (_e104 >= 16777216u);
    uint _e108 = (_e106 ? (_e104 >> 1u) : _e104);
    uint _e110 = ((_e85 - _e90) + uint(_e106));
    if ((_e110 >= 255u)) {
        return (_e25 | 2139095040u);
    }
    return (_e25 | ((((_e108 >= 8388608u) ? _e110 : 0u) << 23u) | (_e108 & 8388607u)));
}

float add_value(float first, float second) {
    uint _e4 = _naga_fadd_rn(floatBitsToUint(first), floatBitsToUint(second));
    return uintBitsToFloat(_e4);
}

int _fadd_rn(bool first_1, bool second_1) {
    int local_13 = 0;
    if (first_1) {
        local_13 = 7;
    } else {
        local_13 = 9;
    }
    int _e6 = local_13;
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
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 8u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float first_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float second_2 = uintBitsToFloat(_e30);
    uint _e34 = _naga_fadd_rn(floatBitsToUint(first_2), floatBitsToUint(second_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e34));
    float _e39 = add_value(first_2, second_2);
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
    float _e75 = add_value(uintBitsToFloat(_e60), uintBitsToFloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    _group_0_binding_1_cs[_e81] = floatBitsToUint(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = (_e85 + 1);
        uint _e91 = _naga_fadd_rn(floatBitsToUint(float(_e85)), floatBitsToUint(first_2));
        uint _e94 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = (_e99 + 1);
        uint _e105 = _naga_fadd_rn(floatBitsToUint(first_2), floatBitsToUint(float(_e99)));
        uint _e108 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    _group_0_binding_1_cs[_e117] = uint(_e111);
    uint _e125 = _naga_fadd_rn(floatBitsToUint(-(0.0)), floatBitsToUint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    _group_0_binding_1_cs[_e132] = floatBitsToUint(uintBitsToFloat(_e125));
    uint _e139 = _naga_fadd_rn(floatBitsToUint(-(0.0)), floatBitsToUint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    _group_0_binding_1_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e139));
    float _e152 = add_value(float(1), float(2u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    _group_0_binding_1_cs[_e158] = floatBitsToUint(_e152);
    int _e162 = _fadd_rn(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    _group_0_binding_1_cs[_e168] = uint(_e162);
}

