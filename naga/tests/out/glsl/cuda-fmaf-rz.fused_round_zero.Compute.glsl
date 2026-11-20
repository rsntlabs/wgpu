#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_fmaf_rz(uint left_bits, uint right_bits, uint addend_bits) {
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
    uint _e479 = (_e476 >> 3u);
    int _e481 = (_e375 + 150);
    if ((_e481 >= 255)) {
        return (_e229 | 2139095039u);
    }
    return (_e229 | ((((_e479 >= 8388608u) ? uint(max(_e481, 0)) : 0u) << 23u) | (_e479 & 8388607u)));
}

float truncate_fused(float first, float second, float third) {
    uint _e6 = _naga_fmaf_rz(floatBitsToUint(first), floatBitsToUint(second), floatBitsToUint(third));
    return uintBitsToFloat(_e6);
}

int _fmaf_rz(bool first_1, bool second_1, bool third_1) {
    int local_48 = 0;
    if (first_1) {
        local_48 = 7;
    } else {
        local_48 = 9;
    }
    int _e6 = local_48;
    return _e6;
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_fmaf_rn(uint left_bits_1, uint right_bits_1, uint addend_bits_1) {
    uint stage_18 = 0u;
    uint stage_19 = 0u;
    uint stage_20 = 0u;
    uint stage_21 = 0u;
    uint stage_22 = 0u;
    uint stage_23 = 0u;
    int stage_24 = 0;
    int stage_25 = 0;
    uint stage_26 = 0u;
    int stage_27 = 0;
    uint stage_28 = 0u;
    uint stage_29 = 0u;
    uint stage_30 = 0u;
    uint stage_31 = 0u;
    int stage_32 = 0;
    int stage_33 = 0;
    uint stage_34 = 0u;
    uint stage_35 = 0u;
    uint _e12 = (left_bits_1 & 2147483647u);
    bool _e14 = (_e12 == 2139095040u);
    bool _e15 = (_e12 == 0u);
    uint _e16 = (right_bits_1 & 2147483647u);
    bool _e18 = (_e16 == 2139095040u);
    bool _e19 = (_e16 == 0u);
    uint _e20 = (addend_bits_1 & 2147483647u);
    bool _e22 = (_e20 == 2139095040u);
    bool _e23 = (_e20 == 0u);
    if ((((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u))) {
        return 2143289344u;
    }
    if (((_e15 && _e18) || (_e19 && _e14))) {
        return 2143289344u;
    }
    uint _e30 = ((left_bits_1 ^ right_bits_1) & 2147483648u);
    uint _e31 = (addend_bits_1 & 2147483648u);
    bool _e32 = (_e30 != _e31);
    bool _e33 = (_e14 || _e18);
    if ((_e33 && (_e22 && _e32))) {
        return 2143289344u;
    }
    if (_e33) {
        return (_e30 | 2139095040u);
    }
    if (_e22) {
        return addend_bits_1;
    }
    bool _e37 = (_e15 || _e19);
    if ((_e37 && _e23)) {
        return (_e30 & _e31);
    }
    if (_e37) {
        return addend_bits_1;
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
    stage_18 = (((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u));
    uint _e92 = stage_18;
    stage_19 = (_e81 >> 8u);
    uint _e94 = stage_19;
    int _e107 = int(((_e94 != 0u) ? (63u - uint(31 - findMSB((_e94 | 1u)))) : (31u - uint(31 - findMSB((_e92 | 1u))))));
    int _e109 = (50 - _e107);
    uint _e119 = (uint(min(max(_e109, 0), 31)) & 31u);
    bool _e143 = (_e109 < 32);
    stage_20 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_20;
    stage_21 = (_e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (uint(min(max((32 - _e109), 0), 31)) & 31u)) : 0u)) : (_e92 << (uint(min(max((_e109 - 32), 0), 31)) & 31u)));
    uint _e149 = stage_21;
    int _e151 = (((int((_e41 ? _e40 : 1u)) - 150) + (int((_e50 ? _e49 : 1u)) - 150)) + _e107);
    int _e164 = int(((0u != 0u) ? (63u - uint(31 - findMSB((0u | 1u)))) : (31u - uint(31 - findMSB((_e62 | 1u))))));
    int _e165 = (50 - _e164);
    uint _e175 = (uint(min(max(_e165, 0), 31)) & 31u);
    bool _e199 = (_e165 < 32);
    stage_22 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_22;
    stage_23 = (_e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (uint(min(max((32 - _e165), 0), 31)) & 31u)) : 0u)) : (_e62 << (uint(min(max((_e165 - 32), 0), 31)) & 31u)));
    uint _e205 = stage_23;
    int _e207 = (_e23 ? _e151 : ((int((_e59 ? _e58 : 1u)) - 150) + _e164));
    bool _e216 = ((_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203)))));
    uint _e217 = (_e216 ? _e203 : _e147);
    uint _e218 = (_e216 ? _e205 : _e149);
    uint _e219 = (_e216 ? _e147 : _e203);
    uint _e220 = (_e216 ? _e149 : _e205);
    stage_24 = (_e216 ? _e207 : _e151);
    int _e225 = stage_24;
    stage_25 = (_e216 ? _e151 : _e207);
    int _e227 = stage_25;
    stage_26 = (_e216 ? _e31 : _e30);
    uint _e229 = stage_26;
    stage_27 = (_e225 - _e227);
    int _e232 = stage_27;
    uint _e244 = (uint(min(max(_e232, 0), 31)) & 31u);
    uint _e272 = (uint(min(max((_e232 - 32), 0), 31)) & 31u);
    bool _e281 = (_e232 < 32);
    bool _e287 = (_e232 < 64);
    int _e290 = (0 - _e232);
    uint _e300 = (uint(min(max(_e290, 0), 31)) & 31u);
    bool _e324 = (_e290 < 32);
    bool _e327 = (_e232 <= 0);
    stage_28 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (uint(min(max((32 - _e232), 0), 31)) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_28;
    stage_29 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (uint(min(max((32 - _e290), 0), 31)) & 31u)) : 0u)) : (_e219 << (uint(min(max((_e290 - 32), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_29;
    uint _e334 = (_e217 + _e331);
    stage_30 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_30;
    stage_31 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_31;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = (_e225 - 50);
    int _e370 = max(((int(((_e349 != 0u) ? (63u - uint(31 - findMSB((_e349 | 1u)))) : (31u - uint(31 - findMSB((_e347 | 1u)))))) + _e365) - 23), -149);
    stage_32 = _e370;
    int _e375 = stage_32;
    stage_33 = ((_e370 - _e365) - 3);
    int _e377 = stage_33;
    uint _e389 = (uint(min(max(_e377, 0), 31)) & 31u);
    uint _e417 = (uint(min(max((_e377 - 32), 0), 31)) & 31u);
    bool _e426 = (_e377 < 32);
    bool _e432 = (_e377 < 64);
    int _e435 = (0 - _e377);
    uint _e445 = (uint(min(max(_e435, 0), 31)) & 31u);
    bool _e469 = (_e435 < 32);
    bool _e472 = (_e377 <= 0);
    stage_34 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (uint(min(max((32 - _e377), 0), 31)) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_34;
    stage_35 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (uint(min(max((32 - _e435), 0), 31)) & 31u)) : 0u)) : (_e347 << (uint(min(max((_e435 - 32), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
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

uint _naga_fmaf_rd(uint left_bits_2, uint right_bits_2, uint addend_bits_2) {
    uint stage_36 = 0u;
    uint stage_37 = 0u;
    uint stage_38 = 0u;
    uint stage_39 = 0u;
    uint stage_40 = 0u;
    uint stage_41 = 0u;
    int stage_42 = 0;
    int stage_43 = 0;
    uint stage_44 = 0u;
    int stage_45 = 0;
    uint stage_46 = 0u;
    uint stage_47 = 0u;
    uint stage_48 = 0u;
    uint stage_49 = 0u;
    int stage_50 = 0;
    int stage_51 = 0;
    uint stage_52 = 0u;
    uint stage_53 = 0u;
    uint _e12 = (left_bits_2 & 2147483647u);
    bool _e14 = (_e12 == 2139095040u);
    bool _e15 = (_e12 == 0u);
    uint _e16 = (right_bits_2 & 2147483647u);
    bool _e18 = (_e16 == 2139095040u);
    bool _e19 = (_e16 == 0u);
    uint _e20 = (addend_bits_2 & 2147483647u);
    bool _e22 = (_e20 == 2139095040u);
    bool _e23 = (_e20 == 0u);
    if ((((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u))) {
        return 2143289344u;
    }
    if (((_e15 && _e18) || (_e19 && _e14))) {
        return 2143289344u;
    }
    uint _e30 = ((left_bits_2 ^ right_bits_2) & 2147483648u);
    uint _e31 = (addend_bits_2 & 2147483648u);
    bool _e32 = (_e30 != _e31);
    bool _e33 = (_e14 || _e18);
    if ((_e33 && (_e22 && _e32))) {
        return 2143289344u;
    }
    if (_e33) {
        return (_e30 | 2139095040u);
    }
    if (_e22) {
        return addend_bits_2;
    }
    bool _e37 = (_e15 || _e19);
    if ((_e37 && _e23)) {
        return (_e30 | _e31);
    }
    if (_e37) {
        return addend_bits_2;
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
    stage_36 = (((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u));
    uint _e92 = stage_36;
    stage_37 = (_e81 >> 8u);
    uint _e94 = stage_37;
    int _e107 = int(((_e94 != 0u) ? (63u - uint(31 - findMSB((_e94 | 1u)))) : (31u - uint(31 - findMSB((_e92 | 1u))))));
    int _e109 = (50 - _e107);
    uint _e119 = (uint(min(max(_e109, 0), 31)) & 31u);
    bool _e143 = (_e109 < 32);
    stage_38 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_38;
    stage_39 = (_e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (uint(min(max((32 - _e109), 0), 31)) & 31u)) : 0u)) : (_e92 << (uint(min(max((_e109 - 32), 0), 31)) & 31u)));
    uint _e149 = stage_39;
    int _e151 = (((int((_e41 ? _e40 : 1u)) - 150) + (int((_e50 ? _e49 : 1u)) - 150)) + _e107);
    int _e164 = int(((0u != 0u) ? (63u - uint(31 - findMSB((0u | 1u)))) : (31u - uint(31 - findMSB((_e62 | 1u))))));
    int _e165 = (50 - _e164);
    uint _e175 = (uint(min(max(_e165, 0), 31)) & 31u);
    bool _e199 = (_e165 < 32);
    stage_40 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_40;
    stage_41 = (_e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (uint(min(max((32 - _e165), 0), 31)) & 31u)) : 0u)) : (_e62 << (uint(min(max((_e165 - 32), 0), 31)) & 31u)));
    uint _e205 = stage_41;
    int _e207 = (_e23 ? _e151 : ((int((_e59 ? _e58 : 1u)) - 150) + _e164));
    bool _e216 = ((_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203)))));
    uint _e217 = (_e216 ? _e203 : _e147);
    uint _e218 = (_e216 ? _e205 : _e149);
    uint _e219 = (_e216 ? _e147 : _e203);
    uint _e220 = (_e216 ? _e149 : _e205);
    stage_42 = (_e216 ? _e207 : _e151);
    int _e225 = stage_42;
    stage_43 = (_e216 ? _e151 : _e207);
    int _e227 = stage_43;
    stage_44 = (_e216 ? _e31 : _e30);
    uint _e229 = stage_44;
    stage_45 = (_e225 - _e227);
    int _e232 = stage_45;
    uint _e244 = (uint(min(max(_e232, 0), 31)) & 31u);
    uint _e272 = (uint(min(max((_e232 - 32), 0), 31)) & 31u);
    bool _e281 = (_e232 < 32);
    bool _e287 = (_e232 < 64);
    int _e290 = (0 - _e232);
    uint _e300 = (uint(min(max(_e290, 0), 31)) & 31u);
    bool _e324 = (_e290 < 32);
    bool _e327 = (_e232 <= 0);
    stage_46 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (uint(min(max((32 - _e232), 0), 31)) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_46;
    stage_47 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (uint(min(max((32 - _e290), 0), 31)) & 31u)) : 0u)) : (_e219 << (uint(min(max((_e290 - 32), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_47;
    uint _e334 = (_e217 + _e331);
    stage_48 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_48;
    stage_49 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_49;
    if (((_e347 | _e349) == 0u)) {
        return 2147483648u;
    }
    int _e365 = (_e225 - 50);
    int _e370 = max(((int(((_e349 != 0u) ? (63u - uint(31 - findMSB((_e349 | 1u)))) : (31u - uint(31 - findMSB((_e347 | 1u)))))) + _e365) - 23), -149);
    stage_50 = _e370;
    int _e375 = stage_50;
    stage_51 = ((_e370 - _e365) - 3);
    int _e377 = stage_51;
    uint _e389 = (uint(min(max(_e377, 0), 31)) & 31u);
    uint _e417 = (uint(min(max((_e377 - 32), 0), 31)) & 31u);
    bool _e426 = (_e377 < 32);
    bool _e432 = (_e377 < 64);
    int _e435 = (0 - _e377);
    uint _e445 = (uint(min(max(_e435, 0), 31)) & 31u);
    bool _e469 = (_e435 < 32);
    bool _e472 = (_e377 <= 0);
    stage_52 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (uint(min(max((32 - _e377), 0), 31)) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_52;
    stage_53 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (uint(min(max((32 - _e435), 0), 31)) & 31u)) : 0u)) : (_e347 << (uint(min(max((_e435 - 32), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    bool _e479 = (_e229 != 0u);
    uint _e486 = ((_e476 >> 3u) + uint((_e479 && ((_e476 & 7u) > 0u))));
    bool _e488 = (_e486 >= 16777216u);
    uint _e490 = (_e488 ? (_e486 >> 1u) : _e486);
    int _e494 = ((_e375 + int(_e488)) + 150);
    if ((_e494 >= 255)) {
        return (_e229 | (_e479 ? 2139095040u : 2139095039u));
    }
    return (_e229 | ((((_e490 >= 8388608u) ? uint(max(_e494, 0)) : 0u) << 23u) | (_e490 & 8388607u)));
}

uint _naga_fmaf_ru(uint left_bits_3, uint right_bits_3, uint addend_bits_3) {
    uint stage_54 = 0u;
    uint stage_55 = 0u;
    uint stage_56 = 0u;
    uint stage_57 = 0u;
    uint stage_58 = 0u;
    uint stage_59 = 0u;
    int stage_60 = 0;
    int stage_61 = 0;
    uint stage_62 = 0u;
    int stage_63 = 0;
    uint stage_64 = 0u;
    uint stage_65 = 0u;
    uint stage_66 = 0u;
    uint stage_67 = 0u;
    int stage_68 = 0;
    int stage_69 = 0;
    uint stage_70 = 0u;
    uint stage_71 = 0u;
    uint _e12 = (left_bits_3 & 2147483647u);
    bool _e14 = (_e12 == 2139095040u);
    bool _e15 = (_e12 == 0u);
    uint _e16 = (right_bits_3 & 2147483647u);
    bool _e18 = (_e16 == 2139095040u);
    bool _e19 = (_e16 == 0u);
    uint _e20 = (addend_bits_3 & 2147483647u);
    bool _e22 = (_e20 == 2139095040u);
    bool _e23 = (_e20 == 0u);
    if ((((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u))) {
        return 2143289344u;
    }
    if (((_e15 && _e18) || (_e19 && _e14))) {
        return 2143289344u;
    }
    uint _e30 = ((left_bits_3 ^ right_bits_3) & 2147483648u);
    uint _e31 = (addend_bits_3 & 2147483648u);
    bool _e32 = (_e30 != _e31);
    bool _e33 = (_e14 || _e18);
    if ((_e33 && (_e22 && _e32))) {
        return 2143289344u;
    }
    if (_e33) {
        return (_e30 | 2139095040u);
    }
    if (_e22) {
        return addend_bits_3;
    }
    bool _e37 = (_e15 || _e19);
    if ((_e37 && _e23)) {
        return (_e30 & _e31);
    }
    if (_e37) {
        return addend_bits_3;
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
    stage_54 = (((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u));
    uint _e92 = stage_54;
    stage_55 = (_e81 >> 8u);
    uint _e94 = stage_55;
    int _e107 = int(((_e94 != 0u) ? (63u - uint(31 - findMSB((_e94 | 1u)))) : (31u - uint(31 - findMSB((_e92 | 1u))))));
    int _e109 = (50 - _e107);
    uint _e119 = (uint(min(max(_e109, 0), 31)) & 31u);
    bool _e143 = (_e109 < 32);
    stage_56 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_56;
    stage_57 = (_e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (uint(min(max((32 - _e109), 0), 31)) & 31u)) : 0u)) : (_e92 << (uint(min(max((_e109 - 32), 0), 31)) & 31u)));
    uint _e149 = stage_57;
    int _e151 = (((int((_e41 ? _e40 : 1u)) - 150) + (int((_e50 ? _e49 : 1u)) - 150)) + _e107);
    int _e164 = int(((0u != 0u) ? (63u - uint(31 - findMSB((0u | 1u)))) : (31u - uint(31 - findMSB((_e62 | 1u))))));
    int _e165 = (50 - _e164);
    uint _e175 = (uint(min(max(_e165, 0), 31)) & 31u);
    bool _e199 = (_e165 < 32);
    stage_58 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_58;
    stage_59 = (_e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (uint(min(max((32 - _e165), 0), 31)) & 31u)) : 0u)) : (_e62 << (uint(min(max((_e165 - 32), 0), 31)) & 31u)));
    uint _e205 = stage_59;
    int _e207 = (_e23 ? _e151 : ((int((_e59 ? _e58 : 1u)) - 150) + _e164));
    bool _e216 = ((_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203)))));
    uint _e217 = (_e216 ? _e203 : _e147);
    uint _e218 = (_e216 ? _e205 : _e149);
    uint _e219 = (_e216 ? _e147 : _e203);
    uint _e220 = (_e216 ? _e149 : _e205);
    stage_60 = (_e216 ? _e207 : _e151);
    int _e225 = stage_60;
    stage_61 = (_e216 ? _e151 : _e207);
    int _e227 = stage_61;
    stage_62 = (_e216 ? _e31 : _e30);
    uint _e229 = stage_62;
    stage_63 = (_e225 - _e227);
    int _e232 = stage_63;
    uint _e244 = (uint(min(max(_e232, 0), 31)) & 31u);
    uint _e272 = (uint(min(max((_e232 - 32), 0), 31)) & 31u);
    bool _e281 = (_e232 < 32);
    bool _e287 = (_e232 < 64);
    int _e290 = (0 - _e232);
    uint _e300 = (uint(min(max(_e290, 0), 31)) & 31u);
    bool _e324 = (_e290 < 32);
    bool _e327 = (_e232 <= 0);
    stage_64 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (uint(min(max((32 - _e232), 0), 31)) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_64;
    stage_65 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (uint(min(max((32 - _e290), 0), 31)) & 31u)) : 0u)) : (_e219 << (uint(min(max((_e290 - 32), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_65;
    uint _e334 = (_e217 + _e331);
    stage_66 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_66;
    stage_67 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_67;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = (_e225 - 50);
    int _e370 = max(((int(((_e349 != 0u) ? (63u - uint(31 - findMSB((_e349 | 1u)))) : (31u - uint(31 - findMSB((_e347 | 1u)))))) + _e365) - 23), -149);
    stage_68 = _e370;
    int _e375 = stage_68;
    stage_69 = ((_e370 - _e365) - 3);
    int _e377 = stage_69;
    uint _e389 = (uint(min(max(_e377, 0), 31)) & 31u);
    uint _e417 = (uint(min(max((_e377 - 32), 0), 31)) & 31u);
    bool _e426 = (_e377 < 32);
    bool _e432 = (_e377 < 64);
    int _e435 = (0 - _e377);
    uint _e445 = (uint(min(max(_e435, 0), 31)) & 31u);
    bool _e469 = (_e435 < 32);
    bool _e472 = (_e377 <= 0);
    stage_70 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (uint(min(max((32 - _e377), 0), 31)) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_70;
    stage_71 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (uint(min(max((32 - _e435), 0), 31)) & 31u)) : 0u)) : (_e347 << (uint(min(max((_e435 - 32), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    bool _e479 = (_e229 == 0u);
    uint _e486 = ((_e476 >> 3u) + uint((_e479 && ((_e476 & 7u) > 0u))));
    bool _e488 = (_e486 >= 16777216u);
    uint _e490 = (_e488 ? (_e486 >> 1u) : _e486);
    int _e494 = ((_e375 + int(_e488)) + 150);
    if ((_e494 >= 255)) {
        return (_e229 | (_e479 ? 2139095040u : 2139095039u));
    }
    return (_e229 | ((((_e490 >= 8388608u) ? uint(max(_e494, 0)) : 0u) << 23u) | (_e490 & 8388607u)));
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
    int directed_cursor = 0;
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
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 22u));
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
    uint _e45 = _naga_fmaf_rz(floatBitsToUint(first_2), floatBitsToUint(second_2), floatBitsToUint(third_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e45));
    float _e50 = truncate_fused(first_2, second_2, third_2);
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
    float _e99 = truncate_fused(uintBitsToFloat(_e71), uintBitsToFloat(_e84), uintBitsToFloat(_e97));
    local_4 = uint((base + 2u));
    uint _e105 = local_4;
    _group_0_binding_1_cs[_e105] = floatBitsToUint(_e99);
    local_8 = false;
    if (false) {
        int _e109 = cursor;
        cursor = (_e109 + 1);
        uint _e116 = _naga_fmaf_rz(floatBitsToUint(float(_e109)), floatBitsToUint(first_2), floatBitsToUint(second_2));
        uint _e119 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e116)));
        local_8 = (_e119 != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        int _e124 = cursor;
        cursor = (_e124 + 1);
        uint _e131 = _naga_fmaf_rz(floatBitsToUint(first_2), floatBitsToUint(float(_e124)), floatBitsToUint(second_2));
        uint _e134 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e131)));
        local_9 = (_e134 != 0u);
    }
    int _e137 = cursor;
    local_10 = uint((base + 3u));
    uint _e143 = local_10;
    _group_0_binding_1_cs[_e143] = uint(_e137);
    uint _e153 = _naga_fmaf_rz(floatBitsToUint(-(0.0)), floatBitsToUint(1.0), floatBitsToUint(-(0.0)));
    local_11 = uint((base + 4u));
    uint _e160 = local_11;
    _group_0_binding_1_cs[_e160] = floatBitsToUint(uintBitsToFloat(_e153));
    uint _e169 = _naga_fmaf_rz(floatBitsToUint(-(0.0)), floatBitsToUint(1.0), floatBitsToUint(0.0));
    local_12 = uint((base + 5u));
    uint _e176 = local_12;
    _group_0_binding_1_cs[_e176] = floatBitsToUint(uintBitsToFloat(_e169));
    float _e184 = truncate_fused(float(2), float(3u), float(4));
    local_13 = uint((base + 6u));
    uint _e190 = local_13;
    _group_0_binding_1_cs[_e190] = floatBitsToUint(_e184);
    int _e195 = _fmaf_rz(true, false, true);
    local_14 = uint((base + 7u));
    uint _e201 = local_14;
    _group_0_binding_1_cs[_e201] = uint(_e195);
    if (true) {
        uint _e207 = _naga_fmaf_rz(floatBitsToUint(first_2), floatBitsToUint(second_2), floatBitsToUint(third_2));
        local_16 = uintBitsToFloat(_e207);
    } else {
        int _e210 = cursor;
        cursor = (_e210 + 1);
        uint _e217 = _naga_fmaf_rz(floatBitsToUint(float(_e210)), floatBitsToUint(first_2), floatBitsToUint(second_2));
        local_16 = uintBitsToFloat(_e217);
    }
    float _e221 = local_16;
    local_15 = uint((base + 8u));
    uint _e227 = local_15;
    _group_0_binding_1_cs[_e227] = floatBitsToUint(_e221);
    uint _e232 = _naga_fmaf_rn(floatBitsToUint(first_2), floatBitsToUint(second_2), floatBitsToUint(third_2));
    local_17 = uint((base + 9u));
    uint _e239 = local_17;
    _group_0_binding_1_cs[_e239] = floatBitsToUint(uintBitsToFloat(_e232));
    directed_cursor = 0;
    int _e245 = directed_cursor;
    directed_cursor = (_e245 + 1);
    local_19 = uint(((index * 3u) + uint(_e245)));
    uint _e252 = local_19;
    uint _e254 = _group_0_binding_0_cs[_e252];
    int _e258 = directed_cursor;
    directed_cursor = (_e258 + 1);
    local_20 = uint(((index * 3u) + uint(_e258)));
    uint _e265 = local_20;
    uint _e267 = _group_0_binding_0_cs[_e265];
    int _e271 = directed_cursor;
    directed_cursor = (_e271 + 1);
    local_21 = uint(((index * 3u) + uint(_e271)));
    uint _e278 = local_21;
    uint _e280 = _group_0_binding_0_cs[_e278];
    uint _e285 = _naga_fmaf_rd(floatBitsToUint(uintBitsToFloat(_e254)), floatBitsToUint(uintBitsToFloat(_e267)), floatBitsToUint(uintBitsToFloat(_e280)));
    local_18 = uint((base + 10u));
    uint _e292 = local_18;
    _group_0_binding_1_cs[_e292] = floatBitsToUint(uintBitsToFloat(_e285));
    int _e294 = directed_cursor;
    local_22 = uint((base + 11u));
    uint _e300 = local_22;
    _group_0_binding_1_cs[_e300] = uint(_e294);
    directed_cursor = 0;
    int _e305 = directed_cursor;
    directed_cursor = (_e305 + 1);
    local_24 = uint(((index * 3u) + uint(_e305)));
    uint _e312 = local_24;
    uint _e314 = _group_0_binding_0_cs[_e312];
    int _e318 = directed_cursor;
    directed_cursor = (_e318 + 1);
    local_25 = uint(((index * 3u) + uint(_e318)));
    uint _e325 = local_25;
    uint _e327 = _group_0_binding_0_cs[_e325];
    int _e331 = directed_cursor;
    directed_cursor = (_e331 + 1);
    local_26 = uint(((index * 3u) + uint(_e331)));
    uint _e338 = local_26;
    uint _e340 = _group_0_binding_0_cs[_e338];
    uint _e345 = _naga_fmaf_ru(floatBitsToUint(uintBitsToFloat(_e314)), floatBitsToUint(uintBitsToFloat(_e327)), floatBitsToUint(uintBitsToFloat(_e340)));
    local_23 = uint((base + 12u));
    uint _e352 = local_23;
    _group_0_binding_1_cs[_e352] = floatBitsToUint(uintBitsToFloat(_e345));
    int _e354 = directed_cursor;
    local_27 = uint((base + 13u));
    uint _e360 = local_27;
    _group_0_binding_1_cs[_e360] = uint(_e354);
    directed_cursor = 0;
    int _e365 = directed_cursor;
    directed_cursor = (_e365 + 1);
    local_29 = uint(((index * 3u) + uint(_e365)));
    uint _e372 = local_29;
    uint _e374 = _group_0_binding_0_cs[_e372];
    int _e378 = directed_cursor;
    directed_cursor = (_e378 + 1);
    local_30 = uint(((index * 3u) + uint(_e378)));
    uint _e385 = local_30;
    uint _e387 = _group_0_binding_0_cs[_e385];
    int _e391 = directed_cursor;
    directed_cursor = (_e391 + 1);
    local_31 = uint(((index * 3u) + uint(_e391)));
    uint _e398 = local_31;
    uint _e400 = _group_0_binding_0_cs[_e398];
    uint _e405 = _naga_fmaf_rn(floatBitsToUint(uintBitsToFloat(_e374)), floatBitsToUint(uintBitsToFloat(_e387)), floatBitsToUint(uintBitsToFloat(_e400)));
    local_28 = uint((base + 14u));
    uint _e412 = local_28;
    _group_0_binding_1_cs[_e412] = floatBitsToUint(uintBitsToFloat(_e405));
    int _e414 = directed_cursor;
    local_32 = uint((base + 15u));
    uint _e420 = local_32;
    _group_0_binding_1_cs[_e420] = uint(_e414);
    directed_cursor = 0;
    int _e425 = directed_cursor;
    directed_cursor = (_e425 + 1);
    local_34 = uint(((index * 3u) + uint(_e425)));
    uint _e432 = local_34;
    uint _e434 = _group_0_binding_0_cs[_e432];
    int _e438 = directed_cursor;
    directed_cursor = (_e438 + 1);
    local_35 = uint(((index * 3u) + uint(_e438)));
    uint _e445 = local_35;
    uint _e447 = _group_0_binding_0_cs[_e445];
    int _e451 = directed_cursor;
    directed_cursor = (_e451 + 1);
    local_36 = uint(((index * 3u) + uint(_e451)));
    uint _e458 = local_36;
    uint _e460 = _group_0_binding_0_cs[_e458];
    uint _e465 = _naga_fmaf_rz(floatBitsToUint(uintBitsToFloat(_e434)), floatBitsToUint(uintBitsToFloat(_e447)), floatBitsToUint(uintBitsToFloat(_e460)));
    local_33 = uint((base + 16u));
    uint _e472 = local_33;
    _group_0_binding_1_cs[_e472] = floatBitsToUint(uintBitsToFloat(_e465));
    int _e474 = directed_cursor;
    local_37 = uint((base + 17u));
    uint _e480 = local_37;
    _group_0_binding_1_cs[_e480] = uint(_e474);
    directed_cursor = 0;
    int _e485 = directed_cursor;
    directed_cursor = (_e485 + 1);
    local_39 = uint(((index * 3u) + uint(_e485)));
    uint _e492 = local_39;
    uint _e494 = _group_0_binding_0_cs[_e492];
    int _e498 = directed_cursor;
    directed_cursor = (_e498 + 1);
    local_40 = uint(((index * 3u) + uint(_e498)));
    uint _e505 = local_40;
    uint _e507 = _group_0_binding_0_cs[_e505];
    int _e511 = directed_cursor;
    directed_cursor = (_e511 + 1);
    local_41 = uint(((index * 3u) + uint(_e511)));
    uint _e518 = local_41;
    uint _e520 = _group_0_binding_0_cs[_e518];
    uint _e525 = _naga_fmaf_rd(floatBitsToUint(uintBitsToFloat(_e494)), floatBitsToUint(uintBitsToFloat(_e507)), floatBitsToUint(uintBitsToFloat(_e520)));
    local_38 = uint((base + 18u));
    uint _e532 = local_38;
    _group_0_binding_1_cs[_e532] = floatBitsToUint(uintBitsToFloat(_e525));
    int _e534 = directed_cursor;
    local_42 = uint((base + 19u));
    uint _e540 = local_42;
    _group_0_binding_1_cs[_e540] = uint(_e534);
    directed_cursor = 0;
    int _e545 = directed_cursor;
    directed_cursor = (_e545 + 1);
    local_44 = uint(((index * 3u) + uint(_e545)));
    uint _e552 = local_44;
    uint _e554 = _group_0_binding_0_cs[_e552];
    int _e558 = directed_cursor;
    directed_cursor = (_e558 + 1);
    local_45 = uint(((index * 3u) + uint(_e558)));
    uint _e565 = local_45;
    uint _e567 = _group_0_binding_0_cs[_e565];
    int _e571 = directed_cursor;
    directed_cursor = (_e571 + 1);
    local_46 = uint(((index * 3u) + uint(_e571)));
    uint _e578 = local_46;
    uint _e580 = _group_0_binding_0_cs[_e578];
    uint _e585 = _naga_fmaf_ru(floatBitsToUint(uintBitsToFloat(_e554)), floatBitsToUint(uintBitsToFloat(_e567)), floatBitsToUint(uintBitsToFloat(_e580)));
    local_43 = uint((base + 20u));
    uint _e592 = local_43;
    _group_0_binding_1_cs[_e592] = floatBitsToUint(uintBitsToFloat(_e585));
    int _e594 = directed_cursor;
    local_47 = uint((base + 21u));
    uint _e600 = local_47;
    _group_0_binding_1_cs[_e600] = uint(_e594);
}

