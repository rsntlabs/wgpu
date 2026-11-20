ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_fmaf_rz(uint left_bits, uint right_bits, uint addend_bits)
{
    uint stage = (uint)0;
    uint stage_1 = (uint)0;
    uint stage_2 = (uint)0;
    uint stage_3 = (uint)0;
    uint stage_4 = (uint)0;
    uint stage_5 = (uint)0;
    int stage_6 = (int)0;
    int stage_7 = (int)0;
    uint stage_8 = (uint)0;
    int stage_9 = (int)0;
    uint stage_10 = (uint)0;
    uint stage_11 = (uint)0;
    uint stage_12 = (uint)0;
    uint stage_13 = (uint)0;
    int stage_14 = (int)0;
    int stage_15 = (int)0;
    uint stage_16 = (uint)0;
    uint stage_17 = (uint)0;

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
    int _e107 = int(((_e94 != 0u) ? (63u - (31u - firstbithigh((_e94 | 1u)))) : (31u - (31u - firstbithigh((_e92 | 1u))))));
    int _e109 = asint(asuint(int(50)) - asuint(_e107));
    uint _e119 = (uint(min(max(_e109, int(0)), int(31))) & 31u);
    bool _e143 = (_e109 < int(32));
    stage_2 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_2;
    stage_3 = (_e143 ? ((_e94 << _e119) | ((_e109 > int(0)) ? (_e92 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e109)), int(0)), int(31))) & 31u)) : 0u)) : (_e92 << (uint(min(max(asint(asuint(_e109) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e149 = stage_3;
    int _e151 = asint(asuint(asint(asuint(asint(asuint(int((_e41 ? _e40 : 1u))) - asuint(int(150)))) + asuint(asint(asuint(int((_e50 ? _e49 : 1u))) - asuint(int(150)))))) + asuint(_e107));
    int _e164 = int(((0u != 0u) ? (63u - (31u - firstbithigh((0u | 1u)))) : (31u - (31u - firstbithigh((_e62 | 1u))))));
    int _e165 = asint(asuint(int(50)) - asuint(_e164));
    uint _e175 = (uint(min(max(_e165, int(0)), int(31))) & 31u);
    bool _e199 = (_e165 < int(32));
    stage_4 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_4;
    stage_5 = (_e199 ? ((0u << _e175) | ((_e165 > int(0)) ? (_e62 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e165)), int(0)), int(31))) & 31u)) : 0u)) : (_e62 << (uint(min(max(asint(asuint(_e165) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e205 = stage_5;
    int _e207 = (_e23 ? _e151 : asint(asuint(asint(asuint(int((_e59 ? _e58 : 1u))) - asuint(int(150)))) + asuint(_e164)));
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
    stage_9 = asint(asuint(_e225) - asuint(_e227));
    int _e232 = stage_9;
    uint _e244 = (uint(min(max(_e232, int(0)), int(31))) & 31u);
    uint _e272 = (uint(min(max(asint(asuint(_e232) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e281 = (_e232 < int(32));
    bool _e287 = (_e232 < int(64));
    int _e290 = asint(asuint(int(0)) - asuint(_e232));
    uint _e300 = (uint(min(max(_e290, int(0)), int(31))) & 31u);
    bool _e324 = (_e290 < int(32));
    bool _e327 = (_e232 <= int(0));
    stage_10 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > int(0)) ? (_e220 << (uint(min(max(asint(asuint(int(32)) - asuint(_e232)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_10;
    stage_11 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > int(0)) ? (_e219 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e290)), int(0)), int(31))) & 31u)) : 0u)) : (_e219 << (uint(min(max(asint(asuint(_e290) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_11;
    uint _e334 = (_e217 + _e331);
    stage_12 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_12;
    stage_13 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_13;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = asint(asuint(_e225) - asuint(int(50)));
    int _e370 = max(asint(asuint(asint(asuint(int(((_e349 != 0u) ? (63u - (31u - firstbithigh((_e349 | 1u)))) : (31u - (31u - firstbithigh((_e347 | 1u))))))) + asuint(_e365))) - asuint(int(23))), int(-149));
    stage_14 = _e370;
    int _e375 = stage_14;
    stage_15 = asint(asuint(asint(asuint(_e370) - asuint(_e365))) - asuint(int(3)));
    int _e377 = stage_15;
    uint _e389 = (uint(min(max(_e377, int(0)), int(31))) & 31u);
    uint _e417 = (uint(min(max(asint(asuint(_e377) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e426 = (_e377 < int(32));
    bool _e432 = (_e377 < int(64));
    int _e435 = asint(asuint(int(0)) - asuint(_e377));
    uint _e445 = (uint(min(max(_e435, int(0)), int(31))) & 31u);
    bool _e469 = (_e435 < int(32));
    bool _e472 = (_e377 <= int(0));
    stage_16 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > int(0)) ? (_e349 << (uint(min(max(asint(asuint(int(32)) - asuint(_e377)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_16;
    stage_17 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > int(0)) ? (_e347 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e435)), int(0)), int(31))) & 31u)) : 0u)) : (_e347 << (uint(min(max(asint(asuint(_e435) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    uint _e479 = (_e476 >> 3u);
    int _e481 = asint(asuint(_e375) + asuint(int(150)));
    if ((_e481 >= int(255))) {
        return (_e229 | 2139095039u);
    }
    return (_e229 | ((((_e479 >= 8388608u) ? uint(max(_e481, int(0))) : 0u) << 23u) | (_e479 & 8388607u)));
}

float truncate_fused(float first, float second, float third)
{
    const uint _e6 = _naga_fmaf_rz(asuint(first), asuint(second), asuint(third));
    return asfloat(_e6);
}

int _fmaf_rz(bool first_1, bool second_1, bool third_1)
{
    int local_75 = (int)0;

    if (first_1) {
        local_75 = int(7);
    } else {
        local_75 = int(9);
    }
    int _e6 = local_75;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_fmaf_rn(uint left_bits_1, uint right_bits_1, uint addend_bits_1)
{
    uint stage_18 = (uint)0;
    uint stage_19 = (uint)0;
    uint stage_20 = (uint)0;
    uint stage_21 = (uint)0;
    uint stage_22 = (uint)0;
    uint stage_23 = (uint)0;
    int stage_24 = (int)0;
    int stage_25 = (int)0;
    uint stage_26 = (uint)0;
    int stage_27 = (int)0;
    uint stage_28 = (uint)0;
    uint stage_29 = (uint)0;
    uint stage_30 = (uint)0;
    uint stage_31 = (uint)0;
    int stage_32 = (int)0;
    int stage_33 = (int)0;
    uint stage_34 = (uint)0;
    uint stage_35 = (uint)0;

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
    int _e107 = int(((_e94 != 0u) ? (63u - (31u - firstbithigh((_e94 | 1u)))) : (31u - (31u - firstbithigh((_e92 | 1u))))));
    int _e109 = asint(asuint(int(50)) - asuint(_e107));
    uint _e119 = (uint(min(max(_e109, int(0)), int(31))) & 31u);
    bool _e143 = (_e109 < int(32));
    stage_20 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_20;
    stage_21 = (_e143 ? ((_e94 << _e119) | ((_e109 > int(0)) ? (_e92 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e109)), int(0)), int(31))) & 31u)) : 0u)) : (_e92 << (uint(min(max(asint(asuint(_e109) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e149 = stage_21;
    int _e151 = asint(asuint(asint(asuint(asint(asuint(int((_e41 ? _e40 : 1u))) - asuint(int(150)))) + asuint(asint(asuint(int((_e50 ? _e49 : 1u))) - asuint(int(150)))))) + asuint(_e107));
    int _e164 = int(((0u != 0u) ? (63u - (31u - firstbithigh((0u | 1u)))) : (31u - (31u - firstbithigh((_e62 | 1u))))));
    int _e165 = asint(asuint(int(50)) - asuint(_e164));
    uint _e175 = (uint(min(max(_e165, int(0)), int(31))) & 31u);
    bool _e199 = (_e165 < int(32));
    stage_22 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_22;
    stage_23 = (_e199 ? ((0u << _e175) | ((_e165 > int(0)) ? (_e62 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e165)), int(0)), int(31))) & 31u)) : 0u)) : (_e62 << (uint(min(max(asint(asuint(_e165) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e205 = stage_23;
    int _e207 = (_e23 ? _e151 : asint(asuint(asint(asuint(int((_e59 ? _e58 : 1u))) - asuint(int(150)))) + asuint(_e164)));
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
    stage_27 = asint(asuint(_e225) - asuint(_e227));
    int _e232 = stage_27;
    uint _e244 = (uint(min(max(_e232, int(0)), int(31))) & 31u);
    uint _e272 = (uint(min(max(asint(asuint(_e232) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e281 = (_e232 < int(32));
    bool _e287 = (_e232 < int(64));
    int _e290 = asint(asuint(int(0)) - asuint(_e232));
    uint _e300 = (uint(min(max(_e290, int(0)), int(31))) & 31u);
    bool _e324 = (_e290 < int(32));
    bool _e327 = (_e232 <= int(0));
    stage_28 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > int(0)) ? (_e220 << (uint(min(max(asint(asuint(int(32)) - asuint(_e232)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_28;
    stage_29 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > int(0)) ? (_e219 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e290)), int(0)), int(31))) & 31u)) : 0u)) : (_e219 << (uint(min(max(asint(asuint(_e290) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_29;
    uint _e334 = (_e217 + _e331);
    stage_30 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_30;
    stage_31 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_31;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = asint(asuint(_e225) - asuint(int(50)));
    int _e370 = max(asint(asuint(asint(asuint(int(((_e349 != 0u) ? (63u - (31u - firstbithigh((_e349 | 1u)))) : (31u - (31u - firstbithigh((_e347 | 1u))))))) + asuint(_e365))) - asuint(int(23))), int(-149));
    stage_32 = _e370;
    int _e375 = stage_32;
    stage_33 = asint(asuint(asint(asuint(_e370) - asuint(_e365))) - asuint(int(3)));
    int _e377 = stage_33;
    uint _e389 = (uint(min(max(_e377, int(0)), int(31))) & 31u);
    uint _e417 = (uint(min(max(asint(asuint(_e377) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e426 = (_e377 < int(32));
    bool _e432 = (_e377 < int(64));
    int _e435 = asint(asuint(int(0)) - asuint(_e377));
    uint _e445 = (uint(min(max(_e435, int(0)), int(31))) & 31u);
    bool _e469 = (_e435 < int(32));
    bool _e472 = (_e377 <= int(0));
    stage_34 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > int(0)) ? (_e349 << (uint(min(max(asint(asuint(int(32)) - asuint(_e377)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_34;
    stage_35 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > int(0)) ? (_e347 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e435)), int(0)), int(31))) & 31u)) : 0u)) : (_e347 << (uint(min(max(asint(asuint(_e435) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    uint _e481 = (_e476 >> 3u);
    uint _e482 = (_e476 & 7u);
    uint _e490 = (_e481 + uint(((_e482 > 4u) || ((_e482 == 4u) && ((_e481 & 1u) != 0u)))));
    bool _e492 = (_e490 >= 16777216u);
    uint _e494 = (_e492 ? (_e490 >> 1u) : _e490);
    int _e498 = asint(asuint(asint(asuint(_e375) + asuint(int(_e492)))) + asuint(int(150)));
    if ((_e498 >= int(255))) {
        return (_e229 | 2139095040u);
    }
    return (_e229 | ((((_e494 >= 8388608u) ? uint(max(_e498, int(0))) : 0u) << 23u) | (_e494 & 8388607u)));
}

uint _naga_fmaf_rd(uint left_bits_2, uint right_bits_2, uint addend_bits_2)
{
    uint stage_36 = (uint)0;
    uint stage_37 = (uint)0;
    uint stage_38 = (uint)0;
    uint stage_39 = (uint)0;
    uint stage_40 = (uint)0;
    uint stage_41 = (uint)0;
    int stage_42 = (int)0;
    int stage_43 = (int)0;
    uint stage_44 = (uint)0;
    int stage_45 = (int)0;
    uint stage_46 = (uint)0;
    uint stage_47 = (uint)0;
    uint stage_48 = (uint)0;
    uint stage_49 = (uint)0;
    int stage_50 = (int)0;
    int stage_51 = (int)0;
    uint stage_52 = (uint)0;
    uint stage_53 = (uint)0;

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
    int _e107 = int(((_e94 != 0u) ? (63u - (31u - firstbithigh((_e94 | 1u)))) : (31u - (31u - firstbithigh((_e92 | 1u))))));
    int _e109 = asint(asuint(int(50)) - asuint(_e107));
    uint _e119 = (uint(min(max(_e109, int(0)), int(31))) & 31u);
    bool _e143 = (_e109 < int(32));
    stage_38 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_38;
    stage_39 = (_e143 ? ((_e94 << _e119) | ((_e109 > int(0)) ? (_e92 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e109)), int(0)), int(31))) & 31u)) : 0u)) : (_e92 << (uint(min(max(asint(asuint(_e109) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e149 = stage_39;
    int _e151 = asint(asuint(asint(asuint(asint(asuint(int((_e41 ? _e40 : 1u))) - asuint(int(150)))) + asuint(asint(asuint(int((_e50 ? _e49 : 1u))) - asuint(int(150)))))) + asuint(_e107));
    int _e164 = int(((0u != 0u) ? (63u - (31u - firstbithigh((0u | 1u)))) : (31u - (31u - firstbithigh((_e62 | 1u))))));
    int _e165 = asint(asuint(int(50)) - asuint(_e164));
    uint _e175 = (uint(min(max(_e165, int(0)), int(31))) & 31u);
    bool _e199 = (_e165 < int(32));
    stage_40 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_40;
    stage_41 = (_e199 ? ((0u << _e175) | ((_e165 > int(0)) ? (_e62 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e165)), int(0)), int(31))) & 31u)) : 0u)) : (_e62 << (uint(min(max(asint(asuint(_e165) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e205 = stage_41;
    int _e207 = (_e23 ? _e151 : asint(asuint(asint(asuint(int((_e59 ? _e58 : 1u))) - asuint(int(150)))) + asuint(_e164)));
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
    stage_45 = asint(asuint(_e225) - asuint(_e227));
    int _e232 = stage_45;
    uint _e244 = (uint(min(max(_e232, int(0)), int(31))) & 31u);
    uint _e272 = (uint(min(max(asint(asuint(_e232) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e281 = (_e232 < int(32));
    bool _e287 = (_e232 < int(64));
    int _e290 = asint(asuint(int(0)) - asuint(_e232));
    uint _e300 = (uint(min(max(_e290, int(0)), int(31))) & 31u);
    bool _e324 = (_e290 < int(32));
    bool _e327 = (_e232 <= int(0));
    stage_46 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > int(0)) ? (_e220 << (uint(min(max(asint(asuint(int(32)) - asuint(_e232)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_46;
    stage_47 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > int(0)) ? (_e219 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e290)), int(0)), int(31))) & 31u)) : 0u)) : (_e219 << (uint(min(max(asint(asuint(_e290) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_47;
    uint _e334 = (_e217 + _e331);
    stage_48 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_48;
    stage_49 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_49;
    if (((_e347 | _e349) == 0u)) {
        return 2147483648u;
    }
    int _e365 = asint(asuint(_e225) - asuint(int(50)));
    int _e370 = max(asint(asuint(asint(asuint(int(((_e349 != 0u) ? (63u - (31u - firstbithigh((_e349 | 1u)))) : (31u - (31u - firstbithigh((_e347 | 1u))))))) + asuint(_e365))) - asuint(int(23))), int(-149));
    stage_50 = _e370;
    int _e375 = stage_50;
    stage_51 = asint(asuint(asint(asuint(_e370) - asuint(_e365))) - asuint(int(3)));
    int _e377 = stage_51;
    uint _e389 = (uint(min(max(_e377, int(0)), int(31))) & 31u);
    uint _e417 = (uint(min(max(asint(asuint(_e377) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e426 = (_e377 < int(32));
    bool _e432 = (_e377 < int(64));
    int _e435 = asint(asuint(int(0)) - asuint(_e377));
    uint _e445 = (uint(min(max(_e435, int(0)), int(31))) & 31u);
    bool _e469 = (_e435 < int(32));
    bool _e472 = (_e377 <= int(0));
    stage_52 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > int(0)) ? (_e349 << (uint(min(max(asint(asuint(int(32)) - asuint(_e377)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_52;
    stage_53 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > int(0)) ? (_e347 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e435)), int(0)), int(31))) & 31u)) : 0u)) : (_e347 << (uint(min(max(asint(asuint(_e435) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    bool _e479 = (_e229 != 0u);
    uint _e486 = ((_e476 >> 3u) + uint((_e479 && ((_e476 & 7u) > 0u))));
    bool _e488 = (_e486 >= 16777216u);
    uint _e490 = (_e488 ? (_e486 >> 1u) : _e486);
    int _e494 = asint(asuint(asint(asuint(_e375) + asuint(int(_e488)))) + asuint(int(150)));
    if ((_e494 >= int(255))) {
        return (_e229 | (_e479 ? 2139095040u : 2139095039u));
    }
    return (_e229 | ((((_e490 >= 8388608u) ? uint(max(_e494, int(0))) : 0u) << 23u) | (_e490 & 8388607u)));
}

uint _naga_fmaf_ru(uint left_bits_3, uint right_bits_3, uint addend_bits_3)
{
    uint stage_54 = (uint)0;
    uint stage_55 = (uint)0;
    uint stage_56 = (uint)0;
    uint stage_57 = (uint)0;
    uint stage_58 = (uint)0;
    uint stage_59 = (uint)0;
    int stage_60 = (int)0;
    int stage_61 = (int)0;
    uint stage_62 = (uint)0;
    int stage_63 = (int)0;
    uint stage_64 = (uint)0;
    uint stage_65 = (uint)0;
    uint stage_66 = (uint)0;
    uint stage_67 = (uint)0;
    int stage_68 = (int)0;
    int stage_69 = (int)0;
    uint stage_70 = (uint)0;
    uint stage_71 = (uint)0;

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
    int _e107 = int(((_e94 != 0u) ? (63u - (31u - firstbithigh((_e94 | 1u)))) : (31u - (31u - firstbithigh((_e92 | 1u))))));
    int _e109 = asint(asuint(int(50)) - asuint(_e107));
    uint _e119 = (uint(min(max(_e109, int(0)), int(31))) & 31u);
    bool _e143 = (_e109 < int(32));
    stage_56 = (_e143 ? (_e92 << _e119) : 0u);
    uint _e147 = stage_56;
    stage_57 = (_e143 ? ((_e94 << _e119) | ((_e109 > int(0)) ? (_e92 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e109)), int(0)), int(31))) & 31u)) : 0u)) : (_e92 << (uint(min(max(asint(asuint(_e109) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e149 = stage_57;
    int _e151 = asint(asuint(asint(asuint(asint(asuint(int((_e41 ? _e40 : 1u))) - asuint(int(150)))) + asuint(asint(asuint(int((_e50 ? _e49 : 1u))) - asuint(int(150)))))) + asuint(_e107));
    int _e164 = int(((0u != 0u) ? (63u - (31u - firstbithigh((0u | 1u)))) : (31u - (31u - firstbithigh((_e62 | 1u))))));
    int _e165 = asint(asuint(int(50)) - asuint(_e164));
    uint _e175 = (uint(min(max(_e165, int(0)), int(31))) & 31u);
    bool _e199 = (_e165 < int(32));
    stage_58 = (_e199 ? (_e62 << _e175) : 0u);
    uint _e203 = stage_58;
    stage_59 = (_e199 ? ((0u << _e175) | ((_e165 > int(0)) ? (_e62 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e165)), int(0)), int(31))) & 31u)) : 0u)) : (_e62 << (uint(min(max(asint(asuint(_e165) - asuint(int(32))), int(0)), int(31))) & 31u)));
    uint _e205 = stage_59;
    int _e207 = (_e23 ? _e151 : asint(asuint(asint(asuint(int((_e59 ? _e58 : 1u))) - asuint(int(150)))) + asuint(_e164)));
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
    stage_63 = asint(asuint(_e225) - asuint(_e227));
    int _e232 = stage_63;
    uint _e244 = (uint(min(max(_e232, int(0)), int(31))) & 31u);
    uint _e272 = (uint(min(max(asint(asuint(_e232) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e281 = (_e232 < int(32));
    bool _e287 = (_e232 < int(64));
    int _e290 = asint(asuint(int(0)) - asuint(_e232));
    uint _e300 = (uint(min(max(_e290, int(0)), int(31))) & 31u);
    bool _e324 = (_e290 < int(32));
    bool _e327 = (_e232 <= int(0));
    stage_64 = (_e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > int(0)) ? (_e220 << (uint(min(max(asint(asuint(int(32)) - asuint(_e232)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e219 & ((1u << _e244) - 1u)) != 0u))) : ((_e220 >> _e272) | uint((((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u)))) : uint(((_e220 | _e219) != 0u))));
    uint _e331 = stage_64;
    stage_65 = (_e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > int(0)) ? (_e219 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e290)), int(0)), int(31))) & 31u)) : 0u)) : (_e219 << (uint(min(max(asint(asuint(_e290) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u));
    uint _e333 = stage_65;
    uint _e334 = (_e217 + _e331);
    stage_66 = (_e32 ? (_e217 - _e331) : _e334);
    uint _e347 = stage_66;
    stage_67 = (_e32 ? ((_e218 - _e333) - uint((_e217 < _e331))) : ((_e218 + _e333) + uint((_e334 < _e217))));
    uint _e349 = stage_67;
    if (((_e347 | _e349) == 0u)) {
        return 0u;
    }
    int _e365 = asint(asuint(_e225) - asuint(int(50)));
    int _e370 = max(asint(asuint(asint(asuint(int(((_e349 != 0u) ? (63u - (31u - firstbithigh((_e349 | 1u)))) : (31u - (31u - firstbithigh((_e347 | 1u))))))) + asuint(_e365))) - asuint(int(23))), int(-149));
    stage_68 = _e370;
    int _e375 = stage_68;
    stage_69 = asint(asuint(asint(asuint(_e370) - asuint(_e365))) - asuint(int(3)));
    int _e377 = stage_69;
    uint _e389 = (uint(min(max(_e377, int(0)), int(31))) & 31u);
    uint _e417 = (uint(min(max(asint(asuint(_e377) - asuint(int(32))), int(0)), int(31))) & 31u);
    bool _e426 = (_e377 < int(32));
    bool _e432 = (_e377 < int(64));
    int _e435 = asint(asuint(int(0)) - asuint(_e377));
    uint _e445 = (uint(min(max(_e435, int(0)), int(31))) & 31u);
    bool _e469 = (_e435 < int(32));
    bool _e472 = (_e377 <= int(0));
    stage_70 = (_e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > int(0)) ? (_e349 << (uint(min(max(asint(asuint(int(32)) - asuint(_e377)), int(0)), int(31))) & 31u)) : 0u)) | uint(((_e347 & ((1u << _e389) - 1u)) != 0u))) : ((_e349 >> _e417) | uint((((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u)))) : uint(((_e349 | _e347) != 0u))));
    uint _e476 = stage_70;
    stage_71 = (_e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > int(0)) ? (_e347 >> (uint(min(max(asint(asuint(int(32)) - asuint(_e435)), int(0)), int(31))) & 31u)) : 0u)) : (_e347 << (uint(min(max(asint(asuint(_e435) - asuint(int(32))), int(0)), int(31))) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u));
    bool _e479 = (_e229 == 0u);
    uint _e486 = ((_e476 >> 3u) + uint((_e479 && ((_e476 & 7u) > 0u))));
    bool _e488 = (_e486 >= 16777216u);
    uint _e490 = (_e488 ? (_e486 >> 1u) : _e486);
    int _e494 = asint(asuint(asint(asuint(_e375) + asuint(int(_e488)))) + asuint(int(150)));
    if ((_e494 >= int(255))) {
        return (_e229 | (_e479 ? 2139095040u : 2139095039u));
    }
    return (_e229 | ((((_e490 >= 8388608u) ? uint(max(_e494, int(0))) : 0u) << 23u) | (_e490 & 8388607u)));
}

float2 ZeroValuefloat2() {
    return (float2)0;
}

[numthreads(32, 1, 1)]
void fused_round_zero(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int cursor = (int)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    bool local_8 = (bool)0;
    bool local_9 = (bool)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    float local_16 = (float)0;
    uint local_17 = (uint)0;
    int directed_cursor = (int)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    float2 pair_first = (float2)0;
    uint local_48 = (uint)0;
    float2 pair_second = (float2)0;
    uint local_49 = (uint)0;
    float2 pair_third = (float2)0;
    uint local_50 = (uint)0;
    float2 pair_rn = (float2)0;
    float2 local_51 = (float2)0;
    float2 local_52 = (float2)0;
    float2 local_53 = (float2)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    float2 pair_rz = (float2)0;
    float2 local_57 = (float2)0;
    float2 local_58 = (float2)0;
    float2 local_59 = (float2)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    float2 pair_rd = (float2)0;
    float2 local_63 = (float2)0;
    float2 local_64 = (float2)0;
    float2 local_65 = (float2)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    float2 pair_ru = (float2)0;
    float2 local_69 = (float2)0;
    float2 local_70 = (float2)0;
    float2 local_71 = (float2)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    float2 value = (float2)0;
    float2 value_1 = (float2)0;
    float2 value_2 = (float2)0;
    float2 value_3 = (float2)0;
    float2 value_4 = (float2)0;
    float2 value_5 = (float2)0;
    float2 value_6 = (float2)0;
    float2 value_7 = (float2)0;
    float2 value_8 = (float2)0;
    float2 value_9 = (float2)0;
    float2 value_10 = (float2)0;
    float2 value_11 = (float2)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 34u));
    local = uint((index * 3u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float first_2 = asfloat(_e20);
    local_1 = uint(((index * 3u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float second_2 = asfloat(_e30);
    local_2 = uint(((index * 3u) + 2u));
    uint _e38 = local_2;
    uint _e40 = asuint(input.Load(_e38*4));
    float third_2 = asfloat(_e40);
    const uint _e45 = _naga_fmaf_rz(asuint(first_2), asuint(second_2), asuint(third_2));
    output.Store(base*4, asuint(asuint(asfloat(_e45))));
    const float _e50 = truncate_fused(first_2, second_2, third_2);
    local_3 = uint((base + 1u));
    uint _e56 = local_3;
    output.Store(_e56*4, asuint(asuint(_e50)));
    cursor = int(0);
    int _e62 = cursor;
    cursor = asint(asuint(_e62) + asuint(int(1)));
    local_5 = uint(((index * 3u) + uint(_e62)));
    uint _e69 = local_5;
    uint _e71 = asuint(input.Load(_e69*4));
    int _e75 = cursor;
    cursor = asint(asuint(_e75) + asuint(int(1)));
    local_6 = uint(((index * 3u) + uint(_e75)));
    uint _e82 = local_6;
    uint _e84 = asuint(input.Load(_e82*4));
    int _e88 = cursor;
    cursor = asint(asuint(_e88) + asuint(int(1)));
    local_7 = uint(((index * 3u) + uint(_e88)));
    uint _e95 = local_7;
    uint _e97 = asuint(input.Load(_e95*4));
    const float _e99 = truncate_fused(asfloat(_e71), asfloat(_e84), asfloat(_e97));
    local_4 = uint((base + 2u));
    uint _e105 = local_4;
    output.Store(_e105*4, asuint(asuint(_e99)));
    local_8 = false;
    if (false) {
        int _e109 = cursor;
        cursor = asint(asuint(_e109) + asuint(int(1)));
        const uint _e116 = _naga_fmaf_rz(asuint(float(_e109)), asuint(first_2), asuint(second_2));
        const uint _e119 = _naga_fabsf(asuint(asfloat(_e116)));
        local_8 = (_e119 != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        int _e124 = cursor;
        cursor = asint(asuint(_e124) + asuint(int(1)));
        const uint _e131 = _naga_fmaf_rz(asuint(first_2), asuint(float(_e124)), asuint(second_2));
        const uint _e134 = _naga_fabsf(asuint(asfloat(_e131)));
        local_9 = (_e134 != 0u);
    }
    int _e137 = cursor;
    local_10 = uint((base + 3u));
    uint _e143 = local_10;
    output.Store(_e143*4, asuint(uint(_e137)));
    const uint _e153 = _naga_fmaf_rz(asuint(-(0.0)), asuint(1.0), asuint(-(0.0)));
    local_11 = uint((base + 4u));
    uint _e160 = local_11;
    output.Store(_e160*4, asuint(asuint(asfloat(_e153))));
    const uint _e169 = _naga_fmaf_rz(asuint(-(0.0)), asuint(1.0), asuint(0.0));
    local_12 = uint((base + 5u));
    uint _e176 = local_12;
    output.Store(_e176*4, asuint(asuint(asfloat(_e169))));
    const float _e184 = truncate_fused(float(int(2)), float(3u), float(int(4)));
    local_13 = uint((base + 6u));
    uint _e190 = local_13;
    output.Store(_e190*4, asuint(asuint(_e184)));
    const int _e195 = _fmaf_rz(true, false, true);
    local_14 = uint((base + 7u));
    uint _e201 = local_14;
    output.Store(_e201*4, asuint(uint(_e195)));
    if (true) {
        const uint _e207 = _naga_fmaf_rz(asuint(first_2), asuint(second_2), asuint(third_2));
        local_16 = asfloat(_e207);
    } else {
        int _e210 = cursor;
        cursor = asint(asuint(_e210) + asuint(int(1)));
        const uint _e217 = _naga_fmaf_rz(asuint(float(_e210)), asuint(first_2), asuint(second_2));
        local_16 = asfloat(_e217);
    }
    float _e221 = local_16;
    local_15 = uint((base + 8u));
    uint _e227 = local_15;
    output.Store(_e227*4, asuint(asuint(_e221)));
    const uint _e232 = _naga_fmaf_rn(asuint(first_2), asuint(second_2), asuint(third_2));
    local_17 = uint((base + 9u));
    uint _e239 = local_17;
    output.Store(_e239*4, asuint(asuint(asfloat(_e232))));
    directed_cursor = int(0);
    int _e245 = directed_cursor;
    directed_cursor = asint(asuint(_e245) + asuint(int(1)));
    local_19 = uint(((index * 3u) + uint(_e245)));
    uint _e252 = local_19;
    uint _e254 = asuint(input.Load(_e252*4));
    int _e258 = directed_cursor;
    directed_cursor = asint(asuint(_e258) + asuint(int(1)));
    local_20 = uint(((index * 3u) + uint(_e258)));
    uint _e265 = local_20;
    uint _e267 = asuint(input.Load(_e265*4));
    int _e271 = directed_cursor;
    directed_cursor = asint(asuint(_e271) + asuint(int(1)));
    local_21 = uint(((index * 3u) + uint(_e271)));
    uint _e278 = local_21;
    uint _e280 = asuint(input.Load(_e278*4));
    const uint _e285 = _naga_fmaf_rd(asuint(asfloat(_e254)), asuint(asfloat(_e267)), asuint(asfloat(_e280)));
    local_18 = uint((base + 10u));
    uint _e292 = local_18;
    output.Store(_e292*4, asuint(asuint(asfloat(_e285))));
    int _e294 = directed_cursor;
    local_22 = uint((base + 11u));
    uint _e300 = local_22;
    output.Store(_e300*4, asuint(uint(_e294)));
    directed_cursor = int(0);
    int _e305 = directed_cursor;
    directed_cursor = asint(asuint(_e305) + asuint(int(1)));
    local_24 = uint(((index * 3u) + uint(_e305)));
    uint _e312 = local_24;
    uint _e314 = asuint(input.Load(_e312*4));
    int _e318 = directed_cursor;
    directed_cursor = asint(asuint(_e318) + asuint(int(1)));
    local_25 = uint(((index * 3u) + uint(_e318)));
    uint _e325 = local_25;
    uint _e327 = asuint(input.Load(_e325*4));
    int _e331 = directed_cursor;
    directed_cursor = asint(asuint(_e331) + asuint(int(1)));
    local_26 = uint(((index * 3u) + uint(_e331)));
    uint _e338 = local_26;
    uint _e340 = asuint(input.Load(_e338*4));
    const uint _e345 = _naga_fmaf_ru(asuint(asfloat(_e314)), asuint(asfloat(_e327)), asuint(asfloat(_e340)));
    local_23 = uint((base + 12u));
    uint _e352 = local_23;
    output.Store(_e352*4, asuint(asuint(asfloat(_e345))));
    int _e354 = directed_cursor;
    local_27 = uint((base + 13u));
    uint _e360 = local_27;
    output.Store(_e360*4, asuint(uint(_e354)));
    directed_cursor = int(0);
    int _e365 = directed_cursor;
    directed_cursor = asint(asuint(_e365) + asuint(int(1)));
    local_29 = uint(((index * 3u) + uint(_e365)));
    uint _e372 = local_29;
    uint _e374 = asuint(input.Load(_e372*4));
    int _e378 = directed_cursor;
    directed_cursor = asint(asuint(_e378) + asuint(int(1)));
    local_30 = uint(((index * 3u) + uint(_e378)));
    uint _e385 = local_30;
    uint _e387 = asuint(input.Load(_e385*4));
    int _e391 = directed_cursor;
    directed_cursor = asint(asuint(_e391) + asuint(int(1)));
    local_31 = uint(((index * 3u) + uint(_e391)));
    uint _e398 = local_31;
    uint _e400 = asuint(input.Load(_e398*4));
    const uint _e405 = _naga_fmaf_rn(asuint(asfloat(_e374)), asuint(asfloat(_e387)), asuint(asfloat(_e400)));
    local_28 = uint((base + 14u));
    uint _e412 = local_28;
    output.Store(_e412*4, asuint(asuint(asfloat(_e405))));
    int _e414 = directed_cursor;
    local_32 = uint((base + 15u));
    uint _e420 = local_32;
    output.Store(_e420*4, asuint(uint(_e414)));
    directed_cursor = int(0);
    int _e425 = directed_cursor;
    directed_cursor = asint(asuint(_e425) + asuint(int(1)));
    local_34 = uint(((index * 3u) + uint(_e425)));
    uint _e432 = local_34;
    uint _e434 = asuint(input.Load(_e432*4));
    int _e438 = directed_cursor;
    directed_cursor = asint(asuint(_e438) + asuint(int(1)));
    local_35 = uint(((index * 3u) + uint(_e438)));
    uint _e445 = local_35;
    uint _e447 = asuint(input.Load(_e445*4));
    int _e451 = directed_cursor;
    directed_cursor = asint(asuint(_e451) + asuint(int(1)));
    local_36 = uint(((index * 3u) + uint(_e451)));
    uint _e458 = local_36;
    uint _e460 = asuint(input.Load(_e458*4));
    const uint _e465 = _naga_fmaf_rz(asuint(asfloat(_e434)), asuint(asfloat(_e447)), asuint(asfloat(_e460)));
    local_33 = uint((base + 16u));
    uint _e472 = local_33;
    output.Store(_e472*4, asuint(asuint(asfloat(_e465))));
    int _e474 = directed_cursor;
    local_37 = uint((base + 17u));
    uint _e480 = local_37;
    output.Store(_e480*4, asuint(uint(_e474)));
    directed_cursor = int(0);
    int _e485 = directed_cursor;
    directed_cursor = asint(asuint(_e485) + asuint(int(1)));
    local_39 = uint(((index * 3u) + uint(_e485)));
    uint _e492 = local_39;
    uint _e494 = asuint(input.Load(_e492*4));
    int _e498 = directed_cursor;
    directed_cursor = asint(asuint(_e498) + asuint(int(1)));
    local_40 = uint(((index * 3u) + uint(_e498)));
    uint _e505 = local_40;
    uint _e507 = asuint(input.Load(_e505*4));
    int _e511 = directed_cursor;
    directed_cursor = asint(asuint(_e511) + asuint(int(1)));
    local_41 = uint(((index * 3u) + uint(_e511)));
    uint _e518 = local_41;
    uint _e520 = asuint(input.Load(_e518*4));
    const uint _e525 = _naga_fmaf_rd(asuint(asfloat(_e494)), asuint(asfloat(_e507)), asuint(asfloat(_e520)));
    local_38 = uint((base + 18u));
    uint _e532 = local_38;
    output.Store(_e532*4, asuint(asuint(asfloat(_e525))));
    int _e534 = directed_cursor;
    local_42 = uint((base + 19u));
    uint _e540 = local_42;
    output.Store(_e540*4, asuint(uint(_e534)));
    directed_cursor = int(0);
    int _e545 = directed_cursor;
    directed_cursor = asint(asuint(_e545) + asuint(int(1)));
    local_44 = uint(((index * 3u) + uint(_e545)));
    uint _e552 = local_44;
    uint _e554 = asuint(input.Load(_e552*4));
    int _e558 = directed_cursor;
    directed_cursor = asint(asuint(_e558) + asuint(int(1)));
    local_45 = uint(((index * 3u) + uint(_e558)));
    uint _e565 = local_45;
    uint _e567 = asuint(input.Load(_e565*4));
    int _e571 = directed_cursor;
    directed_cursor = asint(asuint(_e571) + asuint(int(1)));
    local_46 = uint(((index * 3u) + uint(_e571)));
    uint _e578 = local_46;
    uint _e580 = asuint(input.Load(_e578*4));
    const uint _e585 = _naga_fmaf_ru(asuint(asfloat(_e554)), asuint(asfloat(_e567)), asuint(asfloat(_e580)));
    local_43 = uint((base + 20u));
    uint _e592 = local_43;
    output.Store(_e592*4, asuint(asuint(asfloat(_e585))));
    int _e594 = directed_cursor;
    local_47 = uint((base + 21u));
    uint _e600 = local_47;
    output.Store(_e600*4, asuint(uint(_e594)));
    uint other = (index ^ 1u);
    local_48 = uint((other * 3u));
    uint _e608 = local_48;
    uint _e610 = asuint(input.Load(_e608*4));
    pair_first = float2(first_2, asfloat(_e610));
    local_49 = uint(((other * 3u) + 1u));
    uint _e620 = local_49;
    uint _e622 = asuint(input.Load(_e620*4));
    pair_second = float2(second_2, asfloat(_e622));
    local_50 = uint(((other * 3u) + 2u));
    uint _e632 = local_50;
    uint _e634 = asuint(input.Load(_e632*4));
    pair_third = float2(third_2, asfloat(_e634));
    directed_cursor = int(0);
    float2 _e639 = pair_first;
    value = ZeroValuefloat2();
    value = _e639;
    int _e643 = directed_cursor;
    directed_cursor = asint(asuint(_e643) + asuint(int(1)));
    float2 _e646 = value;
    local_51 = _e646;
    float2 _e648 = local_51;
    float2 _e649 = pair_second;
    value_1 = ZeroValuefloat2();
    value_1 = _e649;
    int _e653 = directed_cursor;
    directed_cursor = asint(asuint(_e653) + asuint(int(1)));
    float2 _e656 = value_1;
    local_52 = _e656;
    float2 _e658 = local_52;
    float2 _e659 = pair_third;
    value_2 = ZeroValuefloat2();
    value_2 = _e659;
    int _e663 = directed_cursor;
    directed_cursor = asint(asuint(_e663) + asuint(int(1)));
    float2 _e666 = value_2;
    local_53 = _e666;
    float2 _e668 = local_53;
    const uint _e675 = _naga_fmaf_rn(asuint(_e648.x), asuint(_e658.x), asuint(_e668.x));
    const uint _e683 = _naga_fmaf_rn(asuint(_e648.y), asuint(_e658.y), asuint(_e668.y));
    pair_rn = float2(asfloat(_e675), asfloat(_e683));
    float _e688 = pair_rn.x;
    local_54 = uint((base + 22u));
    uint _e694 = local_54;
    output.Store(_e694*4, asuint(asuint(_e688)));
    float _e697 = pair_rn.y;
    local_55 = uint((base + 23u));
    uint _e703 = local_55;
    output.Store(_e703*4, asuint(asuint(_e697)));
    int _e705 = directed_cursor;
    local_56 = uint((base + 24u));
    uint _e711 = local_56;
    output.Store(_e711*4, asuint(uint(_e705)));
    directed_cursor = int(0);
    float2 _e714 = pair_first;
    value_3 = ZeroValuefloat2();
    value_3 = _e714;
    int _e718 = directed_cursor;
    directed_cursor = asint(asuint(_e718) + asuint(int(1)));
    float2 _e721 = value_3;
    local_57 = _e721;
    float2 _e723 = local_57;
    float2 _e724 = pair_second;
    value_4 = ZeroValuefloat2();
    value_4 = _e724;
    int _e728 = directed_cursor;
    directed_cursor = asint(asuint(_e728) + asuint(int(1)));
    float2 _e731 = value_4;
    local_58 = _e731;
    float2 _e733 = local_58;
    float2 _e734 = pair_third;
    value_5 = ZeroValuefloat2();
    value_5 = _e734;
    int _e738 = directed_cursor;
    directed_cursor = asint(asuint(_e738) + asuint(int(1)));
    float2 _e741 = value_5;
    local_59 = _e741;
    float2 _e743 = local_59;
    const uint _e750 = _naga_fmaf_rz(asuint(_e723.x), asuint(_e733.x), asuint(_e743.x));
    const uint _e758 = _naga_fmaf_rz(asuint(_e723.y), asuint(_e733.y), asuint(_e743.y));
    pair_rz = float2(asfloat(_e750), asfloat(_e758));
    float _e763 = pair_rz.x;
    local_60 = uint((base + 25u));
    uint _e769 = local_60;
    output.Store(_e769*4, asuint(asuint(_e763)));
    float _e772 = pair_rz.y;
    local_61 = uint((base + 26u));
    uint _e778 = local_61;
    output.Store(_e778*4, asuint(asuint(_e772)));
    int _e780 = directed_cursor;
    local_62 = uint((base + 27u));
    uint _e786 = local_62;
    output.Store(_e786*4, asuint(uint(_e780)));
    directed_cursor = int(0);
    float2 _e789 = pair_first;
    value_6 = ZeroValuefloat2();
    value_6 = _e789;
    int _e793 = directed_cursor;
    directed_cursor = asint(asuint(_e793) + asuint(int(1)));
    float2 _e796 = value_6;
    local_63 = _e796;
    float2 _e798 = local_63;
    float2 _e799 = pair_second;
    value_7 = ZeroValuefloat2();
    value_7 = _e799;
    int _e803 = directed_cursor;
    directed_cursor = asint(asuint(_e803) + asuint(int(1)));
    float2 _e806 = value_7;
    local_64 = _e806;
    float2 _e808 = local_64;
    float2 _e809 = pair_third;
    value_8 = ZeroValuefloat2();
    value_8 = _e809;
    int _e813 = directed_cursor;
    directed_cursor = asint(asuint(_e813) + asuint(int(1)));
    float2 _e816 = value_8;
    local_65 = _e816;
    float2 _e818 = local_65;
    const uint _e825 = _naga_fmaf_rd(asuint(_e798.x), asuint(_e808.x), asuint(_e818.x));
    const uint _e833 = _naga_fmaf_rd(asuint(_e798.y), asuint(_e808.y), asuint(_e818.y));
    pair_rd = float2(asfloat(_e825), asfloat(_e833));
    float _e838 = pair_rd.x;
    local_66 = uint((base + 28u));
    uint _e844 = local_66;
    output.Store(_e844*4, asuint(asuint(_e838)));
    float _e847 = pair_rd.y;
    local_67 = uint((base + 29u));
    uint _e853 = local_67;
    output.Store(_e853*4, asuint(asuint(_e847)));
    int _e855 = directed_cursor;
    local_68 = uint((base + 30u));
    uint _e861 = local_68;
    output.Store(_e861*4, asuint(uint(_e855)));
    directed_cursor = int(0);
    float2 _e864 = pair_first;
    value_9 = ZeroValuefloat2();
    value_9 = _e864;
    int _e868 = directed_cursor;
    directed_cursor = asint(asuint(_e868) + asuint(int(1)));
    float2 _e871 = value_9;
    local_69 = _e871;
    float2 _e873 = local_69;
    float2 _e874 = pair_second;
    value_10 = ZeroValuefloat2();
    value_10 = _e874;
    int _e878 = directed_cursor;
    directed_cursor = asint(asuint(_e878) + asuint(int(1)));
    float2 _e881 = value_10;
    local_70 = _e881;
    float2 _e883 = local_70;
    float2 _e884 = pair_third;
    value_11 = ZeroValuefloat2();
    value_11 = _e884;
    int _e888 = directed_cursor;
    directed_cursor = asint(asuint(_e888) + asuint(int(1)));
    float2 _e891 = value_11;
    local_71 = _e891;
    float2 _e893 = local_71;
    const uint _e900 = _naga_fmaf_ru(asuint(_e873.x), asuint(_e883.x), asuint(_e893.x));
    const uint _e908 = _naga_fmaf_ru(asuint(_e873.y), asuint(_e883.y), asuint(_e893.y));
    pair_ru = float2(asfloat(_e900), asfloat(_e908));
    float _e913 = pair_ru.x;
    local_72 = uint((base + 31u));
    uint _e919 = local_72;
    output.Store(_e919*4, asuint(asuint(_e913)));
    float _e922 = pair_ru.y;
    local_73 = uint((base + 32u));
    uint _e928 = local_73;
    output.Store(_e928*4, asuint(asuint(_e922)));
    int _e930 = directed_cursor;
    local_74 = uint((base + 33u));
    uint _e936 = local_74;
    output.Store(_e936*4, asuint(uint(_e930)));
}
