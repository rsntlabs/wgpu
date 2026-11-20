#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fadd_rz(uint left_bits, uint right_bits) {
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
    uint _e92 = (_e85 - _e90);
    uint _e93 = ((_e83 << _e90) >> 3u);
    if ((_e92 >= 255u)) {
        return (_e25 | 2139095039u);
    }
    return (_e25 | ((((_e93 >= 8388608u) ? _e92 : 0u) << 23u) | (_e93 & 8388607u)));
}

float truncate_value(float first, float second) {
    uint _e4 = _naga_fadd_rz(floatBitsToUint(first), floatBitsToUint(second));
    return uintBitsToFloat(_e4);
}

int _fadd_rz(bool first_1, bool second_1) {
    int local_32 = 0;
    if (first_1) {
        local_32 = 7;
    } else {
        local_32 = 9;
    }
    int _e6 = local_32;
    return _e6;
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_fadd_rn(uint left_bits_1, uint right_bits_1) {
    uint _e9 = (left_bits_1 & 2147483647u);
    uint _e10 = (right_bits_1 & 2147483647u);
    uint _e11 = (left_bits_1 & 2147483648u);
    uint _e12 = (right_bits_1 & 2147483648u);
    if (((_e9 > 2139095040u) || (_e10 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e16 = (_e9 == 2139095040u);
    bool _e17 = (_e10 == 2139095040u);
    if (((_e16 && _e17) && (_e11 != _e12))) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_1;
    }
    if (_e17) {
        return right_bits_1;
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

uint _naga_fadd_rd(uint left_bits_2, uint right_bits_2) {
    uint _e9 = (left_bits_2 & 2147483647u);
    uint _e10 = (right_bits_2 & 2147483647u);
    uint _e11 = (left_bits_2 & 2147483648u);
    uint _e12 = (right_bits_2 & 2147483648u);
    if (((_e9 > 2139095040u) || (_e10 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e16 = (_e9 == 2139095040u);
    bool _e17 = (_e10 == 2139095040u);
    if (((_e16 && _e17) && (_e11 != _e12))) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_2;
    }
    if (_e17) {
        return right_bits_2;
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
        return (_e11 | _e12);
    }
    bool _e66 = (_e62 >= 134217728u);
    uint _e71 = (1u & 31u);
    uint _e83 = (_e66 ? ((1u < 32u) ? ((_e62 >> _e71) | uint(((_e62 & ((1u << _e71) - 1u)) != 0u))) : uint((_e62 != 0u))) : _e62);
    uint _e85 = (_e41 + uint(_e66));
    uint _e90 = min((uint(31 - findMSB(_e83)) - 5u), (_e85 - 1u));
    uint _e91 = (_e83 << _e90);
    bool _e93 = (_e25 != 0u);
    uint _e100 = ((_e91 >> 3u) + uint((_e93 && ((_e91 & 7u) > 0u))));
    bool _e102 = (_e100 >= 16777216u);
    uint _e104 = (_e102 ? (_e100 >> 1u) : _e100);
    uint _e106 = ((_e85 - _e90) + uint(_e102));
    if ((_e106 >= 255u)) {
        return (_e25 | (_e93 ? 2139095040u : 2139095039u));
    }
    return (_e25 | ((((_e104 >= 8388608u) ? _e106 : 0u) << 23u) | (_e104 & 8388607u)));
}

uint _naga_fadd_ru(uint left_bits_3, uint right_bits_3) {
    uint _e9 = (left_bits_3 & 2147483647u);
    uint _e10 = (right_bits_3 & 2147483647u);
    uint _e11 = (left_bits_3 & 2147483648u);
    uint _e12 = (right_bits_3 & 2147483648u);
    if (((_e9 > 2139095040u) || (_e10 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e16 = (_e9 == 2139095040u);
    bool _e17 = (_e10 == 2139095040u);
    if (((_e16 && _e17) && (_e11 != _e12))) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_3;
    }
    if (_e17) {
        return right_bits_3;
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
    bool _e93 = (_e25 == 0u);
    uint _e100 = ((_e91 >> 3u) + uint((_e93 && ((_e91 & 7u) > 0u))));
    bool _e102 = (_e100 >= 16777216u);
    uint _e104 = (_e102 ? (_e100 >> 1u) : _e100);
    uint _e106 = ((_e85 - _e90) + uint(_e102));
    if ((_e106 >= 255u)) {
        return (_e25 | (_e93 ? 2139095040u : 2139095039u));
    }
    return (_e25 | ((((_e104 >= 8388608u) ? _e106 : 0u) << 23u) | (_e104 & 8388607u)));
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
    float local_14 = 0.0;
    uint local_15 = 0u;
    int directed_cursor = 0;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 18u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float first_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float second_2 = uintBitsToFloat(_e30);
    uint _e34 = _naga_fadd_rz(floatBitsToUint(first_2), floatBitsToUint(second_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e34));
    float _e39 = truncate_value(first_2, second_2);
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
    float _e75 = truncate_value(uintBitsToFloat(_e60), uintBitsToFloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    _group_0_binding_1_cs[_e81] = floatBitsToUint(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = (_e85 + 1);
        uint _e91 = _naga_fadd_rz(floatBitsToUint(float(_e85)), floatBitsToUint(first_2));
        uint _e94 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = (_e99 + 1);
        uint _e105 = _naga_fadd_rz(floatBitsToUint(first_2), floatBitsToUint(float(_e99)));
        uint _e108 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    _group_0_binding_1_cs[_e117] = uint(_e111);
    uint _e125 = _naga_fadd_rz(floatBitsToUint(-(0.0)), floatBitsToUint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    _group_0_binding_1_cs[_e132] = floatBitsToUint(uintBitsToFloat(_e125));
    uint _e139 = _naga_fadd_rz(floatBitsToUint(-(0.0)), floatBitsToUint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    _group_0_binding_1_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e139));
    float _e152 = truncate_value(float(1), float(2u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    _group_0_binding_1_cs[_e158] = floatBitsToUint(_e152);
    int _e162 = _fadd_rz(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    _group_0_binding_1_cs[_e168] = uint(_e162);
    if (true) {
        uint _e173 = _naga_fadd_rz(floatBitsToUint(first_2), floatBitsToUint(second_2));
        local_14 = uintBitsToFloat(_e173);
    } else {
        int _e176 = cursor;
        cursor = (_e176 + 1);
        uint _e182 = _naga_fadd_rz(floatBitsToUint(float(_e176)), floatBitsToUint(first_2));
        local_14 = uintBitsToFloat(_e182);
    }
    float _e186 = local_14;
    local_13 = uint((base + 8u));
    uint _e192 = local_13;
    _group_0_binding_1_cs[_e192] = floatBitsToUint(_e186);
    uint _e196 = _naga_fadd_rn(floatBitsToUint(first_2), floatBitsToUint(second_2));
    local_15 = uint((base + 9u));
    uint _e203 = local_15;
    _group_0_binding_1_cs[_e203] = floatBitsToUint(uintBitsToFloat(_e196));
    directed_cursor = 0;
    int _e209 = directed_cursor;
    directed_cursor = (_e209 + 1);
    local_17 = uint(((index * 2u) + uint(_e209)));
    uint _e216 = local_17;
    uint _e218 = _group_0_binding_0_cs[_e216];
    int _e222 = directed_cursor;
    directed_cursor = (_e222 + 1);
    local_18 = uint(((index * 2u) + uint(_e222)));
    uint _e229 = local_18;
    uint _e231 = _group_0_binding_0_cs[_e229];
    uint _e235 = _naga_fadd_rd(floatBitsToUint(uintBitsToFloat(_e218)), floatBitsToUint(uintBitsToFloat(_e231)));
    local_16 = uint((base + 10u));
    uint _e242 = local_16;
    _group_0_binding_1_cs[_e242] = floatBitsToUint(uintBitsToFloat(_e235));
    int _e244 = directed_cursor;
    local_19 = uint((base + 11u));
    uint _e250 = local_19;
    _group_0_binding_1_cs[_e250] = uint(_e244);
    directed_cursor = 0;
    int _e255 = directed_cursor;
    directed_cursor = (_e255 + 1);
    local_21 = uint(((index * 2u) + uint(_e255)));
    uint _e262 = local_21;
    uint _e264 = _group_0_binding_0_cs[_e262];
    int _e268 = directed_cursor;
    directed_cursor = (_e268 + 1);
    local_22 = uint(((index * 2u) + uint(_e268)));
    uint _e275 = local_22;
    uint _e277 = _group_0_binding_0_cs[_e275];
    uint _e281 = _naga_fadd_ru(floatBitsToUint(uintBitsToFloat(_e264)), floatBitsToUint(uintBitsToFloat(_e277)));
    local_20 = uint((base + 12u));
    uint _e288 = local_20;
    _group_0_binding_1_cs[_e288] = floatBitsToUint(uintBitsToFloat(_e281));
    int _e290 = directed_cursor;
    local_23 = uint((base + 13u));
    uint _e296 = local_23;
    _group_0_binding_1_cs[_e296] = uint(_e290);
    directed_cursor = 0;
    int _e301 = directed_cursor;
    directed_cursor = (_e301 + 1);
    local_25 = uint(((index * 2u) + uint(_e301)));
    uint _e308 = local_25;
    uint _e310 = _group_0_binding_0_cs[_e308];
    int _e314 = directed_cursor;
    directed_cursor = (_e314 + 1);
    local_26 = uint(((index * 2u) + uint(_e314)));
    uint _e321 = local_26;
    uint _e323 = _group_0_binding_0_cs[_e321];
    uint _e329 = _naga_fadd_rd(floatBitsToUint(uintBitsToFloat(_e310)), (floatBitsToUint(uintBitsToFloat(_e323)) ^ 2147483648u));
    local_24 = uint((base + 14u));
    uint _e336 = local_24;
    _group_0_binding_1_cs[_e336] = floatBitsToUint(uintBitsToFloat(_e329));
    int _e338 = directed_cursor;
    local_27 = uint((base + 15u));
    uint _e344 = local_27;
    _group_0_binding_1_cs[_e344] = uint(_e338);
    directed_cursor = 0;
    int _e349 = directed_cursor;
    directed_cursor = (_e349 + 1);
    local_29 = uint(((index * 2u) + uint(_e349)));
    uint _e356 = local_29;
    uint _e358 = _group_0_binding_0_cs[_e356];
    int _e362 = directed_cursor;
    directed_cursor = (_e362 + 1);
    local_30 = uint(((index * 2u) + uint(_e362)));
    uint _e369 = local_30;
    uint _e371 = _group_0_binding_0_cs[_e369];
    uint _e377 = _naga_fadd_ru(floatBitsToUint(uintBitsToFloat(_e358)), (floatBitsToUint(uintBitsToFloat(_e371)) ^ 2147483648u));
    local_28 = uint((base + 16u));
    uint _e384 = local_28;
    _group_0_binding_1_cs[_e384] = floatBitsToUint(uintBitsToFloat(_e377));
    int _e386 = directed_cursor;
    local_31 = uint((base + 17u));
    uint _e392 = local_31;
    _group_0_binding_1_cs[_e392] = uint(_e386);
}

