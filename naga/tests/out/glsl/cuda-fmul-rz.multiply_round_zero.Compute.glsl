#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fmul_rz(uint left_bits, uint right_bits) {
    uint _e8 = (left_bits & 2147483647u);
    uint _e9 = (right_bits & 2147483647u);
    uint _e11 = ((left_bits ^ right_bits) & 2147483648u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    bool _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if ((_e17 && _e20)) {
        return 2143289344u;
    }
    if (_e17) {
        return (_e11 | 2139095040u);
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = (_e8 >> 23u);
    uint _e27 = (_e9 >> 23u);
    bool _e28 = (_e26 != 0u);
    bool _e29 = (_e27 != 0u);
    uint _e34 = ((_e8 & 8388607u) | (_e28 ? 8388608u : 0u));
    uint _e35 = ((_e9 & 8388607u) | (_e29 ? 8388608u : 0u));
    uint _e38 = (_e34 & 4095u);
    uint _e39 = (_e35 & 4095u);
    uint _e40 = (_e34 >> 12u);
    uint _e41 = (_e35 >> 12u);
    uint _e42 = (_e38 * _e39);
    uint _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    uint _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    uint _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    int _e64 = int(((_e50 != 0u) ? (55u - uint(31 - findMSB(_e50))) : (31u - uint(31 - findMSB((_e54 | 1u))))));
    int _e69 = (int((_e28 ? _e26 : 1u)) + int((_e29 ? _e27 : 1u)));
    int _e72 = ((_e64 + _e69) - 173);
    int _e79 = (max((_e64 - 23), (151 - _e69)) - 3);
    uint _e103 = (uint(min(max(_e79, 0), 31)) & 31u);
    uint _e131 = (uint(min(max((_e79 - 24), 0), 31)) & 31u);
    uint _e153 = (((_e79 <= 0) ? (((_e50 << 24u) | _e54) << (uint(min(max((0 - _e79), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (uint(min(max((24 - _e79), 0), 31)) & 31u)) | (_e54 >> _e103)) | uint(((_e54 & ((1u << _e103) - 1u)) != 0u))) : ((_e79 == 24) ? (_e50 | uint((_e54 != 0u))) : ((_e79 < 48) ? ((_e50 >> _e131) | uint((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))) : uint(((_e50 | _e54) != 0u)))))) >> 3u);
    if ((_e72 >= 255)) {
        return (_e11 | 2139095039u);
    }
    return (_e11 | ((((_e153 >= 8388608u) ? uint(max(_e72, 1)) : 0u) << 23u) | (_e153 & 8388607u)));
}

float truncate_product(float first, float second) {
    uint _e4 = _naga_fmul_rz(floatBitsToUint(first), floatBitsToUint(second));
    return uintBitsToFloat(_e4);
}

int _fmul_rz(bool first_1, bool second_1) {
    int local_23 = 0;
    if (first_1) {
        local_23 = 7;
    } else {
        local_23 = 9;
    }
    int _e6 = local_23;
    return _e6;
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_fmul_rn(uint left_bits_1, uint right_bits_1) {
    uint _e8 = (left_bits_1 & 2147483647u);
    uint _e9 = (right_bits_1 & 2147483647u);
    uint _e11 = ((left_bits_1 ^ right_bits_1) & 2147483648u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    bool _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if ((_e17 && _e20)) {
        return 2143289344u;
    }
    uint _e22 = (_e11 | 2139095040u);
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = (_e8 >> 23u);
    uint _e27 = (_e9 >> 23u);
    bool _e28 = (_e26 != 0u);
    bool _e29 = (_e27 != 0u);
    uint _e34 = ((_e8 & 8388607u) | (_e28 ? 8388608u : 0u));
    uint _e35 = ((_e9 & 8388607u) | (_e29 ? 8388608u : 0u));
    uint _e38 = (_e34 & 4095u);
    uint _e39 = (_e35 & 4095u);
    uint _e40 = (_e34 >> 12u);
    uint _e41 = (_e35 >> 12u);
    uint _e42 = (_e38 * _e39);
    uint _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    uint _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    uint _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    int _e64 = int(((_e50 != 0u) ? (55u - uint(31 - findMSB(_e50))) : (31u - uint(31 - findMSB((_e54 | 1u))))));
    int _e69 = (int((_e28 ? _e26 : 1u)) + int((_e29 ? _e27 : 1u)));
    int _e79 = (max((_e64 - 23), (151 - _e69)) - 3);
    uint _e103 = (uint(min(max(_e79, 0), 31)) & 31u);
    uint _e131 = (uint(min(max((_e79 - 24), 0), 31)) & 31u);
    uint _e151 = ((_e79 <= 0) ? (((_e50 << 24u) | _e54) << (uint(min(max((0 - _e79), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (uint(min(max((24 - _e79), 0), 31)) & 31u)) | (_e54 >> _e103)) | uint(((_e54 & ((1u << _e103) - 1u)) != 0u))) : ((_e79 == 24) ? (_e50 | uint((_e54 != 0u))) : ((_e79 < 48) ? ((_e50 >> _e131) | uint((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))) : uint(((_e50 | _e54) != 0u))))));
    uint _e155 = (_e151 & 7u);
    uint _e156 = (_e151 >> 3u);
    uint _e164 = (_e156 + uint(((_e155 > 4u) || ((_e155 == 4u) && ((_e156 & 1u) != 0u)))));
    bool _e166 = (_e164 >= 16777216u);
    uint _e168 = (_e166 ? (_e164 >> 1u) : _e164);
    int _e170 = (((_e64 + _e69) - 173) + int(_e166));
    if ((_e170 >= 255)) {
        return _e22;
    }
    return (_e11 | ((((_e168 >= 8388608u) ? uint(max(_e170, 1)) : 0u) << 23u) | (_e168 & 8388607u)));
}

uint _naga_fmul_rd(uint left_bits_2, uint right_bits_2) {
    uint _e8 = (left_bits_2 & 2147483647u);
    uint _e9 = (right_bits_2 & 2147483647u);
    uint _e11 = ((left_bits_2 ^ right_bits_2) & 2147483648u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    bool _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if ((_e17 && _e20)) {
        return 2143289344u;
    }
    uint _e22 = (_e11 | 2139095040u);
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = (_e8 >> 23u);
    uint _e27 = (_e9 >> 23u);
    bool _e28 = (_e26 != 0u);
    bool _e29 = (_e27 != 0u);
    uint _e34 = ((_e8 & 8388607u) | (_e28 ? 8388608u : 0u));
    uint _e35 = ((_e9 & 8388607u) | (_e29 ? 8388608u : 0u));
    uint _e38 = (_e34 & 4095u);
    uint _e39 = (_e35 & 4095u);
    uint _e40 = (_e34 >> 12u);
    uint _e41 = (_e35 >> 12u);
    uint _e42 = (_e38 * _e39);
    uint _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    uint _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    uint _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    int _e64 = int(((_e50 != 0u) ? (55u - uint(31 - findMSB(_e50))) : (31u - uint(31 - findMSB((_e54 | 1u))))));
    int _e69 = (int((_e28 ? _e26 : 1u)) + int((_e29 ? _e27 : 1u)));
    int _e79 = (max((_e64 - 23), (151 - _e69)) - 3);
    uint _e103 = (uint(min(max(_e79, 0), 31)) & 31u);
    uint _e131 = (uint(min(max((_e79 - 24), 0), 31)) & 31u);
    uint _e151 = ((_e79 <= 0) ? (((_e50 << 24u) | _e54) << (uint(min(max((0 - _e79), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (uint(min(max((24 - _e79), 0), 31)) & 31u)) | (_e54 >> _e103)) | uint(((_e54 & ((1u << _e103) - 1u)) != 0u))) : ((_e79 == 24) ? (_e50 | uint((_e54 != 0u))) : ((_e79 < 48) ? ((_e50 >> _e131) | uint((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))) : uint(((_e50 | _e54) != 0u))))));
    bool _e152 = (_e11 != 0u);
    uint _e160 = ((_e151 >> 3u) + uint((_e152 && ((_e151 & 7u) > 0u))));
    bool _e162 = (_e160 >= 16777216u);
    uint _e164 = (_e162 ? (_e160 >> 1u) : _e160);
    int _e166 = (((_e64 + _e69) - 173) + int(_e162));
    if ((_e166 >= 255)) {
        return (_e152 ? _e22 : (_e11 | 2139095039u));
    }
    return (_e11 | ((((_e164 >= 8388608u) ? uint(max(_e166, 1)) : 0u) << 23u) | (_e164 & 8388607u)));
}

uint _naga_fmul_ru(uint left_bits_3, uint right_bits_3) {
    uint _e8 = (left_bits_3 & 2147483647u);
    uint _e9 = (right_bits_3 & 2147483647u);
    uint _e11 = ((left_bits_3 ^ right_bits_3) & 2147483648u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    bool _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if ((_e17 && _e20)) {
        return 2143289344u;
    }
    uint _e22 = (_e11 | 2139095040u);
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = (_e8 >> 23u);
    uint _e27 = (_e9 >> 23u);
    bool _e28 = (_e26 != 0u);
    bool _e29 = (_e27 != 0u);
    uint _e34 = ((_e8 & 8388607u) | (_e28 ? 8388608u : 0u));
    uint _e35 = ((_e9 & 8388607u) | (_e29 ? 8388608u : 0u));
    uint _e38 = (_e34 & 4095u);
    uint _e39 = (_e35 & 4095u);
    uint _e40 = (_e34 >> 12u);
    uint _e41 = (_e35 >> 12u);
    uint _e42 = (_e38 * _e39);
    uint _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    uint _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    uint _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    int _e64 = int(((_e50 != 0u) ? (55u - uint(31 - findMSB(_e50))) : (31u - uint(31 - findMSB((_e54 | 1u))))));
    int _e69 = (int((_e28 ? _e26 : 1u)) + int((_e29 ? _e27 : 1u)));
    int _e79 = (max((_e64 - 23), (151 - _e69)) - 3);
    uint _e103 = (uint(min(max(_e79, 0), 31)) & 31u);
    uint _e131 = (uint(min(max((_e79 - 24), 0), 31)) & 31u);
    uint _e151 = ((_e79 <= 0) ? (((_e50 << 24u) | _e54) << (uint(min(max((0 - _e79), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (uint(min(max((24 - _e79), 0), 31)) & 31u)) | (_e54 >> _e103)) | uint(((_e54 & ((1u << _e103) - 1u)) != 0u))) : ((_e79 == 24) ? (_e50 | uint((_e54 != 0u))) : ((_e79 < 48) ? ((_e50 >> _e131) | uint((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))) : uint(((_e50 | _e54) != 0u))))));
    bool _e152 = (_e11 == 0u);
    uint _e160 = ((_e151 >> 3u) + uint((_e152 && ((_e151 & 7u) > 0u))));
    bool _e162 = (_e160 >= 16777216u);
    uint _e164 = (_e162 ? (_e160 >> 1u) : _e160);
    int _e166 = (((_e64 + _e69) - 173) + int(_e162));
    if ((_e166 >= 255)) {
        return (_e152 ? _e22 : (_e11 | 2139095039u));
    }
    return (_e11 | ((((_e164 >= 8388608u) ? uint(max(_e166, 1)) : 0u) << 23u) | (_e164 & 8388607u)));
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
    int directed_cursor = 0;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float first_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float second_2 = uintBitsToFloat(_e30);
    uint _e34 = _naga_fmul_rz(floatBitsToUint(first_2), floatBitsToUint(second_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e34));
    float _e39 = truncate_product(first_2, second_2);
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
    float _e75 = truncate_product(uintBitsToFloat(_e60), uintBitsToFloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    _group_0_binding_1_cs[_e81] = floatBitsToUint(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = (_e85 + 1);
        uint _e91 = _naga_fmul_rz(floatBitsToUint(float(_e85)), floatBitsToUint(first_2));
        uint _e94 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = (_e99 + 1);
        uint _e105 = _naga_fmul_rz(floatBitsToUint(first_2), floatBitsToUint(float(_e99)));
        uint _e108 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    _group_0_binding_1_cs[_e117] = uint(_e111);
    uint _e125 = _naga_fmul_rz(floatBitsToUint(-(0.0)), floatBitsToUint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    _group_0_binding_1_cs[_e132] = floatBitsToUint(uintBitsToFloat(_e125));
    uint _e139 = _naga_fmul_rz(floatBitsToUint(-(0.0)), floatBitsToUint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    _group_0_binding_1_cs[_e146] = floatBitsToUint(uintBitsToFloat(_e139));
    float _e152 = truncate_product(float(2), float(3u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    _group_0_binding_1_cs[_e158] = floatBitsToUint(_e152);
    int _e162 = _fmul_rz(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    _group_0_binding_1_cs[_e168] = uint(_e162);
    uint _e172 = _naga_fmul_rz(floatBitsToUint(second_2), floatBitsToUint(first_2));
    local_13 = uint((base + 8u));
    uint _e179 = local_13;
    _group_0_binding_1_cs[_e179] = floatBitsToUint(uintBitsToFloat(_e172));
    uint _e183 = _naga_fmul_rn(floatBitsToUint(first_2), floatBitsToUint(second_2));
    local_14 = uint((base + 9u));
    uint _e190 = local_14;
    _group_0_binding_1_cs[_e190] = floatBitsToUint(uintBitsToFloat(_e183));
    directed_cursor = 0;
    int _e196 = directed_cursor;
    directed_cursor = (_e196 + 1);
    local_16 = uint(((index * 2u) + uint(_e196)));
    uint _e203 = local_16;
    uint _e205 = _group_0_binding_0_cs[_e203];
    int _e209 = directed_cursor;
    directed_cursor = (_e209 + 1);
    local_17 = uint(((index * 2u) + uint(_e209)));
    uint _e216 = local_17;
    uint _e218 = _group_0_binding_0_cs[_e216];
    uint _e222 = _naga_fmul_rd(floatBitsToUint(uintBitsToFloat(_e205)), floatBitsToUint(uintBitsToFloat(_e218)));
    local_15 = uint((base + 10u));
    uint _e229 = local_15;
    _group_0_binding_1_cs[_e229] = floatBitsToUint(uintBitsToFloat(_e222));
    int _e231 = directed_cursor;
    local_18 = uint((base + 11u));
    uint _e237 = local_18;
    _group_0_binding_1_cs[_e237] = uint(_e231);
    directed_cursor = 0;
    int _e242 = directed_cursor;
    directed_cursor = (_e242 + 1);
    local_20 = uint(((index * 2u) + uint(_e242)));
    uint _e249 = local_20;
    uint _e251 = _group_0_binding_0_cs[_e249];
    int _e255 = directed_cursor;
    directed_cursor = (_e255 + 1);
    local_21 = uint(((index * 2u) + uint(_e255)));
    uint _e262 = local_21;
    uint _e264 = _group_0_binding_0_cs[_e262];
    uint _e268 = _naga_fmul_ru(floatBitsToUint(uintBitsToFloat(_e251)), floatBitsToUint(uintBitsToFloat(_e264)));
    local_19 = uint((base + 12u));
    uint _e275 = local_19;
    _group_0_binding_1_cs[_e275] = floatBitsToUint(uintBitsToFloat(_e268));
    int _e277 = directed_cursor;
    local_22 = uint((base + 13u));
    uint _e283 = local_22;
    _group_0_binding_1_cs[_e283] = uint(_e277);
}

