#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fmaf_rn(uint left_bits, uint right_bits, uint addend_bits) {
    uint stage = 0u;
    uint stage_1 = 0u;
    uint stage_2 = 0u;
    uint stage_3 = 0u;
    uint stage_4 = 0u;
    uint stage_5 = 0u;
    int stage_6 = 0;
    int stage_7 = 0;
    uint stage_8 = 0u;
    int stage_9 = 0;
    uint stage_10 = 0u;
    uint stage_11 = 0u;
    uint stage_12 = 0u;
    uint stage_13 = 0u;
    int stage_14 = 0;
    int stage_15 = 0;
    uint stage_16 = 0u;
    uint stage_17 = 0u;
    uint _e12 = (left_bits & 2147483647u);
    bool _e14 = (_e12 == 2139095040u);
    bool _e15 = (_e12 == 0u);
    uint _e16 = (right_bits & 2147483647u);
    bool _e18 = (_e16 == 2139095040u);
    bool _e19 = (_e16 == 0u);
    uint _e20 = (addend_bits & 2147483647u);
    bool _e22 = (_e20 == 2139095040u);
    bool _e23 = (_e20 == 0u);
    if ((((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u))) {
        return 2143289344u;
    }
    if (((_e15 && _e18) || (_e19 && _e14))) {
        return 2143289344u;
    }
    uint _e30 = ((left_bits ^ right_bits) & 2147483648u);
    uint _e31 = (addend_bits & 2147483648u);
    bool _e32 = (_e30 != _e31);
    bool _e33 = (_e14 || _e18);
    if ((_e33 && (_e22 && _e32))) {
        return 2143289344u;
    }
    if (_e33) {
        return (_e30 | 2139095040u);
    }
    if (_e22) {
        return addend_bits;
    }
    bool _e37 = (_e15 || _e19);
    if ((_e37 && _e23)) {
        return (_e30 & _e31);
    }
    if (_e37) {
        return addend_bits;
    }
    uint _e40 = (_e12 >> 23u);
    bool _e41 = (_e40 != 0u);
    uint _e44 = ((_e12 & 8388607u) | (_e41 ? 8388608u : 0u));
    uint _e49 = (_e16 >> 23u);
    bool _e50 = (_e49 != 0u);
    uint _e53 = ((_e16 & 8388607u) | (_e50 ? 8388608u : 0u));
    uint _e58 = (_e20 >> 23u);
    bool _e59 = (_e58 != 0u);
    uint _e62 = ((_e20 & 8388607u) | (_e59 ? 8388608u : 0u));
    uint _e69 = (_e44 & 4095u);
    uint _e70 = (_e44 >> 12u);
    uint _e71 = (_e53 & 4095u);
    uint _e72 = (_e53 >> 12u);
    uint _e73 = (_e69 * _e71);
    uint _e78 = (((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u));
    uint _e81 = ((_e70 * _e72) + (_e78 >> 12u));
    stage = (((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u));
    uint _e92 = stage;
    stage_1 = (_e81 >> 8u);
    uint _e94 = stage_1;
    int _e107 = int(((_e94 != 0u) ? (63u - uint(31 - findMSB((_e94 | 1u)))) : (31u - uint(31 - findMSB((_e92 | 1u))))));
    int _e109 = (50 - _e107);
    uint _e119 = (uint(min(max(_e109, 0), 31)) & 31u);
    bool _e143 = (_e109 < 32);
    stage_2 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_2;
    stage_3 = (_e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (uint(min(max((32 - _e109), 0), 31)) & 31u)) : 0u)) : (_e92 << (uint(min(max((_e109 - 32), 0), 31)) & 31u)));
    uint _e149 = stage_3;
    int _e151 = (((int((_e41 ? _e40 : 1u)) - 150) + (int((_e50 ? _e49 : 1u)) - 150)) + _e107);
    int _e164 = int(((0u != 0u) ? (63u - uint(31 - findMSB((0u | 1u)))) : (31u - uint(31 - findMSB((_e62 | 1u))))));
    int _e165 = (50 - _e164);
    uint _e175 = (uint(min(max(_e165, 0), 31)) & 31u);
    bool _e199 = (_e165 < 32);
    stage_4 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_4;
    stage_5 = (_e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (uint(min(max((32 - _e165), 0), 31)) & 31u)) : 0u)) : (_e62 << (uint(min(max((_e165 - 32), 0), 31)) & 31u)));
    uint _e205 = stage_5;
    int _e207 = (_e23 ? _e151 : ((int((_e59 ? _e58 : 1u)) - 150) + _e164));
    bool _e216 = ((_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203)))));
    uint _e217 = (_e216 ? _e203 : _e147);
    uint _e218 = (_e216 ? _e205 : _e149);
    uint _e219 = (_e216 ? _e147 : _e203);
    uint _e220 = (_e216 ? _e149 : _e205);
    stage_6 = (_e216 ? _e207 : _e151);
    int _e225 = stage_6;
    stage_7 = (_e216 ? _e151 : _e207);
    int _e227 = stage_7;
    stage_8 = (_e216 ? _e31 : _e30);
    uint _e229 = stage_8;
    stage_9 = (_e225 - _e227);
    int _e232 = stage_9;
    uint _e244 = (uint(min(max(_e232, 0), 31)) & 31u);
    uint _e272 = (uint(min(max((_e232 - 32), 0), 31)) & 31u);
    bool _e281 = (_e232 < 32);
    bool _e287 = (_e232 < 64);
    int _e290 = (0 - _e232);
    uint _e300 = (uint(min(max(_e290, 0), 31)) & 31u);
    bool _e324 = (_e290 < 32);
    bool _e327 = (_e232 <= 0);
    stage_10 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (uint(min(max((32 - _e232), 0), 31)) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_10;
    stage_11 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (uint(min(max((32 - _e290), 0), 31)) & 31u)) : 0u)) : (_e219 << (uint(min(max((_e290 - 32), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_11;
    uint _e334 = (_e217 + _e331);
    stage_12 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_12;
    stage_13 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_13;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = (_e225 - 50);
    int _e370 = max(((int(((_e349 != 0u) ? (63u - uint(31 - findMSB((_e349 | 1u)))) : (31u - uint(31 - findMSB((_e347 | 1u)))))) + _e365) - 23), -149);
    stage_14 = _e370;
    int _e375 = stage_14;
    stage_15 = ((_e370 - _e365) - 3);
    int _e377 = stage_15;
    uint _e389 = (uint(min(max(_e377, 0), 31)) & 31u);
    uint _e417 = (uint(min(max((_e377 - 32), 0), 31)) & 31u);
    bool _e426 = (_e377 < 32);
    bool _e432 = (_e377 < 64);
    int _e435 = (0 - _e377);
    uint _e445 = (uint(min(max(_e435, 0), 31)) & 31u);
    bool _e469 = (_e435 < 32);
    bool _e472 = (_e377 <= 0);
    stage_16 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (uint(min(max((32 - _e377), 0), 31)) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_16;
    stage_17 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (uint(min(max((32 - _e435), 0), 31)) & 31u)) : 0u)) : (_e347 << (uint(min(max((_e435 - 32), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    uint _e481 = (_e476 >> 3u);
    uint _e482 = (_e476 & 7u);
    uint _e490 = (_e481 + uint(((_e482 > 4u) || ((_e482 == 4u) && ((_e481 & 1u) != 0u)))));
    bool _e492 = (_e490 >= 16777216u);
    uint _e494 = (_e492 ? (_e490 >> 1u) : _e490);
    int _e498 = ((_e375 + int(_e492)) + 150);
    if ((_e498 >= 255)) {
        return (_e229 | 2139095040u);
    }
    return (_e229 | ((((_e494 >= 8388608u) ? uint(max(_e498, 0)) : 0u) << 23u) | (_e494 & 8388607u)));
}

float fused_value(float first, float second, float third) {
    uint _e6 = _naga_fmaf_rn(floatBitsToUint(first), floatBitsToUint(second), floatBitsToUint(third));
    return uintBitsToFloat(_e6);
}

int _fmaf_rn(bool first_1, bool second_1, bool third_1) {
    int local_18 = 0;
    if (first_1) {
        local_18 = 7;
    } else {
        local_18 = 9;
    }
    int _e6 = local_18;
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
    uint local_3 = 0u;
    int cursor = 0;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    bool local_8 = false;
    bool local_9 = false;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    float local_16 = 0.0;
    uint local_17 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    local = uint((index * 3u));
    uint _e17 = local;
    uint _e20 = _group_0_binding_0_cs[_e17];
    float first_2 = uintBitsToFloat(_e20);
    local_1 = uint(((index * 3u) + 1u));
    uint _e28 = local_1;
    uint _e30 = _group_0_binding_0_cs[_e28];
    float second_2 = uintBitsToFloat(_e30);
    local_2 = uint(((index * 3u) + 2u));
    uint _e38 = local_2;
    uint _e40 = _group_0_binding_0_cs[_e38];
    float third_2 = uintBitsToFloat(_e40);
    uint _e45 = _naga_fmaf_rn(floatBitsToUint(first_2), floatBitsToUint(second_2), floatBitsToUint(third_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e45));
    float _e50 = fused_value(first_2, second_2, third_2);
    local_3 = uint((base + 1u));
    uint _e56 = local_3;
    _group_0_binding_1_cs[_e56] = floatBitsToUint(_e50);
    cursor = 0;
    int _e62 = cursor;
    cursor = (_e62 + 1);
    local_5 = uint(((index * 3u) + uint(_e62)));
    uint _e69 = local_5;
    uint _e71 = _group_0_binding_0_cs[_e69];
    int _e75 = cursor;
    cursor = (_e75 + 1);
    local_6 = uint(((index * 3u) + uint(_e75)));
    uint _e82 = local_6;
    uint _e84 = _group_0_binding_0_cs[_e82];
    int _e88 = cursor;
    cursor = (_e88 + 1);
    local_7 = uint(((index * 3u) + uint(_e88)));
    uint _e95 = local_7;
    uint _e97 = _group_0_binding_0_cs[_e95];
    float _e99 = fused_value(uintBitsToFloat(_e71), uintBitsToFloat(_e84), uintBitsToFloat(_e97));
    local_4 = uint((base + 2u));
    uint _e105 = local_4;
    _group_0_binding_1_cs[_e105] = floatBitsToUint(_e99);
    local_8 = false;
    if (false) {
        int _e109 = cursor;
        cursor = (_e109 + 1);
        uint _e116 = _naga_fmaf_rn(floatBitsToUint(float(_e109)), floatBitsToUint(first_2), floatBitsToUint(second_2));
        uint _e119 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e116)));
        local_8 = (_e119 != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        int _e124 = cursor;
        cursor = (_e124 + 1);
        uint _e131 = _naga_fmaf_rn(floatBitsToUint(first_2), floatBitsToUint(float(_e124)), floatBitsToUint(second_2));
        uint _e134 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e131)));
        local_9 = (_e134 != 0u);
    }
    int _e137 = cursor;
    local_10 = uint((base + 3u));
    uint _e143 = local_10;
    _group_0_binding_1_cs[_e143] = uint(_e137);
    uint _e153 = _naga_fmaf_rn(floatBitsToUint(-(0.0)), floatBitsToUint(1.0), floatBitsToUint(-(0.0)));
    local_11 = uint((base + 4u));
    uint _e160 = local_11;
    _group_0_binding_1_cs[_e160] = floatBitsToUint(uintBitsToFloat(_e153));
    uint _e169 = _naga_fmaf_rn(floatBitsToUint(-(0.0)), floatBitsToUint(1.0), floatBitsToUint(0.0));
    local_12 = uint((base + 5u));
    uint _e176 = local_12;
    _group_0_binding_1_cs[_e176] = floatBitsToUint(uintBitsToFloat(_e169));
    float _e184 = fused_value(float(2), float(3u), float(4));
    local_13 = uint((base + 6u));
    uint _e190 = local_13;
    _group_0_binding_1_cs[_e190] = floatBitsToUint(_e184);
    int _e195 = _fmaf_rn(true, false, true);
    local_14 = uint((base + 7u));
    uint _e201 = local_14;
    _group_0_binding_1_cs[_e201] = uint(_e195);
    if (true) {
        uint _e207 = _naga_fmaf_rn(floatBitsToUint(first_2), floatBitsToUint(second_2), floatBitsToUint(third_2));
        local_16 = uintBitsToFloat(_e207);
    } else {
        int _e210 = cursor;
        cursor = (_e210 + 1);
        uint _e217 = _naga_fmaf_rn(floatBitsToUint(float(_e210)), floatBitsToUint(first_2), floatBitsToUint(second_2));
        local_16 = uintBitsToFloat(_e217);
    }
    float _e221 = local_16;
    local_15 = uint((base + 8u));
    uint _e227 = local_15;
    _group_0_binding_1_cs[_e227] = floatBitsToUint(_e221);
    int _e229 = cursor;
    local_17 = uint((base + 9u));
    uint _e235 = local_17;
    _group_0_binding_1_cs[_e235] = uint(_e229);
}

