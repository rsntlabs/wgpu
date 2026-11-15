ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_fmaf_rn(uint left_bits, uint right_bits, uint addend_bits)
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

float fused_value(float first, float second, float third)
{
    const uint _e6 = _naga_fmaf_rn(asuint(first), asuint(second), asuint(third));
    return asfloat(_e6);
}

int _fmaf_rn(bool first_1, bool second_1, bool third_1)
{
    int local_18 = (int)0;

    if (first_1) {
        local_18 = int(7);
    } else {
        local_18 = int(9);
    }
    int _e6 = local_18;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

[numthreads(32, 1, 1)]
void fused_round_nearest(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
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

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
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
    const uint _e45 = _naga_fmaf_rn(asuint(first_2), asuint(second_2), asuint(third_2));
    output.Store(base*4, asuint(asuint(asfloat(_e45))));
    const float _e50 = fused_value(first_2, second_2, third_2);
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
    const float _e99 = fused_value(asfloat(_e71), asfloat(_e84), asfloat(_e97));
    local_4 = uint((base + 2u));
    uint _e105 = local_4;
    output.Store(_e105*4, asuint(asuint(_e99)));
    local_8 = false;
    if (false) {
        int _e109 = cursor;
        cursor = asint(asuint(_e109) + asuint(int(1)));
        const uint _e116 = _naga_fmaf_rn(asuint(float(_e109)), asuint(first_2), asuint(second_2));
        const uint _e119 = _naga_fabsf(asuint(asfloat(_e116)));
        local_8 = (_e119 != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        int _e124 = cursor;
        cursor = asint(asuint(_e124) + asuint(int(1)));
        const uint _e131 = _naga_fmaf_rn(asuint(first_2), asuint(float(_e124)), asuint(second_2));
        const uint _e134 = _naga_fabsf(asuint(asfloat(_e131)));
        local_9 = (_e134 != 0u);
    }
    int _e137 = cursor;
    local_10 = uint((base + 3u));
    uint _e143 = local_10;
    output.Store(_e143*4, asuint(uint(_e137)));
    const uint _e153 = _naga_fmaf_rn(asuint(-(0.0)), asuint(1.0), asuint(-(0.0)));
    local_11 = uint((base + 4u));
    uint _e160 = local_11;
    output.Store(_e160*4, asuint(asuint(asfloat(_e153))));
    const uint _e169 = _naga_fmaf_rn(asuint(-(0.0)), asuint(1.0), asuint(0.0));
    local_12 = uint((base + 5u));
    uint _e176 = local_12;
    output.Store(_e176*4, asuint(asuint(asfloat(_e169))));
    const float _e184 = fused_value(float(int(2)), float(3u), float(int(4)));
    local_13 = uint((base + 6u));
    uint _e190 = local_13;
    output.Store(_e190*4, asuint(asuint(_e184)));
    const int _e195 = _fmaf_rn(true, false, true);
    local_14 = uint((base + 7u));
    uint _e201 = local_14;
    output.Store(_e201*4, asuint(uint(_e195)));
    if (true) {
        const uint _e207 = _naga_fmaf_rn(asuint(first_2), asuint(second_2), asuint(third_2));
        local_16 = asfloat(_e207);
    } else {
        int _e210 = cursor;
        cursor = asint(asuint(_e210) + asuint(int(1)));
        const uint _e217 = _naga_fmaf_rn(asuint(float(_e210)), asuint(first_2), asuint(second_2));
        local_16 = asfloat(_e217);
    }
    float _e221 = local_16;
    local_15 = uint((base + 8u));
    uint _e227 = local_15;
    output.Store(_e227*4, asuint(asuint(_e221)));
    int _e229 = cursor;
    local_17 = uint((base + 9u));
    uint _e235 = local_17;
    output.Store(_e235*4, asuint(uint(_e229)));
}
