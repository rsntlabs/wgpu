ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_fadd_rz(uint left_bits, uint right_bits)
{
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
    uint _e90 = min(((31u - firstbithigh(_e83)) - 5u), (_e85 - 1u));
    uint _e92 = (_e85 - _e90);
    uint _e93 = ((_e83 << _e90) >> 3u);
    if ((_e92 >= 255u)) {
        return (_e25 | 2139095039u);
    }
    return (_e25 | ((((_e93 >= 8388608u) ? _e92 : 0u) << 23u) | (_e93 & 8388607u)));
}

float subtract_value(float first, float second)
{
    const uint _e6 = _naga_fadd_rz(asuint(first), (asuint(second) ^ 2147483648u));
    return asfloat(_e6);
}

int _fsub_rz(bool first_1, bool second_1)
{
    int local_16 = (int)0;

    if (first_1) {
        local_16 = int(7);
    } else {
        local_16 = int(9);
    }
    int _e6 = local_16;
    return _e6;
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_fadd_rn(uint left_bits_1, uint right_bits_1)
{
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
    uint _e90 = min(((31u - firstbithigh(_e83)) - 5u), (_e85 - 1u));
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

[numthreads(32, 1, 1)]
void subtract_round_zero(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int cursor = (int)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    bool local_6 = (bool)0;
    bool local_7 = (bool)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    float local_14 = (float)0;
    uint local_15 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float first_2 = asfloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float second_2 = asfloat(_e30);
    const uint _e36 = _naga_fadd_rz(asuint(first_2), (asuint(second_2) ^ 2147483648u));
    output.Store(base*4, asuint(asuint(asfloat(_e36))));
    const float _e41 = subtract_value(first_2, second_2);
    local_2 = uint((base + 1u));
    uint _e47 = local_2;
    output.Store(_e47*4, asuint(asuint(_e41)));
    cursor = int(0);
    int _e53 = cursor;
    cursor = asint(asuint(_e53) + asuint(int(1)));
    local_4 = uint(((index * 2u) + uint(_e53)));
    uint _e60 = local_4;
    uint _e62 = asuint(input.Load(_e60*4));
    int _e66 = cursor;
    cursor = asint(asuint(_e66) + asuint(int(1)));
    local_5 = uint(((index * 2u) + uint(_e66)));
    uint _e73 = local_5;
    uint _e75 = asuint(input.Load(_e73*4));
    const float _e77 = subtract_value(asfloat(_e62), asfloat(_e75));
    local_3 = uint((base + 2u));
    uint _e83 = local_3;
    output.Store(_e83*4, asuint(asuint(_e77)));
    local_6 = false;
    if (false) {
        int _e87 = cursor;
        cursor = asint(asuint(_e87) + asuint(int(1)));
        const uint _e95 = _naga_fadd_rz(asuint(float(_e87)), (asuint(first_2) ^ 2147483648u));
        const uint _e98 = _naga_fabsf(asuint(asfloat(_e95)));
        local_6 = (_e98 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e103 = cursor;
        cursor = asint(asuint(_e103) + asuint(int(1)));
        const uint _e111 = _naga_fadd_rz(asuint(first_2), (asuint(float(_e103)) ^ 2147483648u));
        const uint _e114 = _naga_fabsf(asuint(asfloat(_e111)));
        local_7 = (_e114 != 0u);
    }
    int _e117 = cursor;
    local_8 = uint((base + 3u));
    uint _e123 = local_8;
    output.Store(_e123*4, asuint(uint(_e117)));
    const uint _e133 = _naga_fadd_rz(asuint(-(0.0)), (asuint(-(0.0)) ^ 2147483648u));
    local_9 = uint((base + 4u));
    uint _e140 = local_9;
    output.Store(_e140*4, asuint(asuint(asfloat(_e133))));
    const uint _e149 = _naga_fadd_rz(asuint(-(0.0)), (asuint(0.0) ^ 2147483648u));
    local_10 = uint((base + 5u));
    uint _e156 = local_10;
    output.Store(_e156*4, asuint(asuint(asfloat(_e149))));
    const float _e162 = subtract_value(float(int(1)), float(2u));
    local_11 = uint((base + 6u));
    uint _e168 = local_11;
    output.Store(_e168*4, asuint(asuint(_e162)));
    const int _e172 = _fsub_rz(true, false);
    local_12 = uint((base + 7u));
    uint _e178 = local_12;
    output.Store(_e178*4, asuint(uint(_e172)));
    if (true) {
        const uint _e185 = _naga_fadd_rz(asuint(first_2), (asuint(second_2) ^ 2147483648u));
        local_14 = asfloat(_e185);
    } else {
        int _e188 = cursor;
        cursor = asint(asuint(_e188) + asuint(int(1)));
        const uint _e196 = _naga_fadd_rz(asuint(float(_e188)), (asuint(first_2) ^ 2147483648u));
        local_14 = asfloat(_e196);
    }
    float _e200 = local_14;
    local_13 = uint((base + 8u));
    uint _e206 = local_13;
    output.Store(_e206*4, asuint(asuint(_e200)));
    const uint _e212 = _naga_fadd_rn(asuint(first_2), (asuint(second_2) ^ 2147483648u));
    local_15 = uint((base + 9u));
    uint _e219 = local_15;
    output.Store(_e219*4, asuint(asuint(asfloat(_e212))));
}
