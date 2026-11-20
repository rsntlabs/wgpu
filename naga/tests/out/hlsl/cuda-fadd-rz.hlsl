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

float truncate_value(float first, float second)
{
    const uint _e4 = _naga_fadd_rz(asuint(first), asuint(second));
    return asfloat(_e4);
}

int _fadd_rz(bool first_1, bool second_1)
{
    int local_32 = (int)0;

    if (first_1) {
        local_32 = int(7);
    } else {
        local_32 = int(9);
    }
    int _e6 = local_32;
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

uint _naga_fadd_rd(uint left_bits_2, uint right_bits_2)
{
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
    uint _e90 = min(((31u - firstbithigh(_e83)) - 5u), (_e85 - 1u));
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

uint _naga_fadd_ru(uint left_bits_3, uint right_bits_3)
{
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
    uint _e90 = min(((31u - firstbithigh(_e83)) - 5u), (_e85 - 1u));
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

[numthreads(32, 1, 1)]
void add_round_zero(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
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
    int directed_cursor = (int)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
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

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 18u));
    local = uint((index * 2u));
    uint _e17 = local;
    uint _e20 = asuint(input.Load(_e17*4));
    float first_2 = asfloat(_e20);
    local_1 = uint(((index * 2u) + 1u));
    uint _e28 = local_1;
    uint _e30 = asuint(input.Load(_e28*4));
    float second_2 = asfloat(_e30);
    const uint _e34 = _naga_fadd_rz(asuint(first_2), asuint(second_2));
    output.Store(base*4, asuint(asuint(asfloat(_e34))));
    const float _e39 = truncate_value(first_2, second_2);
    local_2 = uint((base + 1u));
    uint _e45 = local_2;
    output.Store(_e45*4, asuint(asuint(_e39)));
    cursor = int(0);
    int _e51 = cursor;
    cursor = asint(asuint(_e51) + asuint(int(1)));
    local_4 = uint(((index * 2u) + uint(_e51)));
    uint _e58 = local_4;
    uint _e60 = asuint(input.Load(_e58*4));
    int _e64 = cursor;
    cursor = asint(asuint(_e64) + asuint(int(1)));
    local_5 = uint(((index * 2u) + uint(_e64)));
    uint _e71 = local_5;
    uint _e73 = asuint(input.Load(_e71*4));
    const float _e75 = truncate_value(asfloat(_e60), asfloat(_e73));
    local_3 = uint((base + 2u));
    uint _e81 = local_3;
    output.Store(_e81*4, asuint(asuint(_e75)));
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = asint(asuint(_e85) + asuint(int(1)));
        const uint _e91 = _naga_fadd_rz(asuint(float(_e85)), asuint(first_2));
        const uint _e94 = _naga_fabsf(asuint(asfloat(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = asint(asuint(_e99) + asuint(int(1)));
        const uint _e105 = _naga_fadd_rz(asuint(first_2), asuint(float(_e99)));
        const uint _e108 = _naga_fabsf(asuint(asfloat(_e105)));
        local_7 = (_e108 != 0u);
    }
    int _e111 = cursor;
    local_8 = uint((base + 3u));
    uint _e117 = local_8;
    output.Store(_e117*4, asuint(uint(_e111)));
    const uint _e125 = _naga_fadd_rz(asuint(-(0.0)), asuint(-(0.0)));
    local_9 = uint((base + 4u));
    uint _e132 = local_9;
    output.Store(_e132*4, asuint(asuint(asfloat(_e125))));
    const uint _e139 = _naga_fadd_rz(asuint(-(0.0)), asuint(0.0));
    local_10 = uint((base + 5u));
    uint _e146 = local_10;
    output.Store(_e146*4, asuint(asuint(asfloat(_e139))));
    const float _e152 = truncate_value(float(int(1)), float(2u));
    local_11 = uint((base + 6u));
    uint _e158 = local_11;
    output.Store(_e158*4, asuint(asuint(_e152)));
    const int _e162 = _fadd_rz(true, false);
    local_12 = uint((base + 7u));
    uint _e168 = local_12;
    output.Store(_e168*4, asuint(uint(_e162)));
    if (true) {
        const uint _e173 = _naga_fadd_rz(asuint(first_2), asuint(second_2));
        local_14 = asfloat(_e173);
    } else {
        int _e176 = cursor;
        cursor = asint(asuint(_e176) + asuint(int(1)));
        const uint _e182 = _naga_fadd_rz(asuint(float(_e176)), asuint(first_2));
        local_14 = asfloat(_e182);
    }
    float _e186 = local_14;
    local_13 = uint((base + 8u));
    uint _e192 = local_13;
    output.Store(_e192*4, asuint(asuint(_e186)));
    const uint _e196 = _naga_fadd_rn(asuint(first_2), asuint(second_2));
    local_15 = uint((base + 9u));
    uint _e203 = local_15;
    output.Store(_e203*4, asuint(asuint(asfloat(_e196))));
    directed_cursor = int(0);
    int _e209 = directed_cursor;
    directed_cursor = asint(asuint(_e209) + asuint(int(1)));
    local_17 = uint(((index * 2u) + uint(_e209)));
    uint _e216 = local_17;
    uint _e218 = asuint(input.Load(_e216*4));
    int _e222 = directed_cursor;
    directed_cursor = asint(asuint(_e222) + asuint(int(1)));
    local_18 = uint(((index * 2u) + uint(_e222)));
    uint _e229 = local_18;
    uint _e231 = asuint(input.Load(_e229*4));
    const uint _e235 = _naga_fadd_rd(asuint(asfloat(_e218)), asuint(asfloat(_e231)));
    local_16 = uint((base + 10u));
    uint _e242 = local_16;
    output.Store(_e242*4, asuint(asuint(asfloat(_e235))));
    int _e244 = directed_cursor;
    local_19 = uint((base + 11u));
    uint _e250 = local_19;
    output.Store(_e250*4, asuint(uint(_e244)));
    directed_cursor = int(0);
    int _e255 = directed_cursor;
    directed_cursor = asint(asuint(_e255) + asuint(int(1)));
    local_21 = uint(((index * 2u) + uint(_e255)));
    uint _e262 = local_21;
    uint _e264 = asuint(input.Load(_e262*4));
    int _e268 = directed_cursor;
    directed_cursor = asint(asuint(_e268) + asuint(int(1)));
    local_22 = uint(((index * 2u) + uint(_e268)));
    uint _e275 = local_22;
    uint _e277 = asuint(input.Load(_e275*4));
    const uint _e281 = _naga_fadd_ru(asuint(asfloat(_e264)), asuint(asfloat(_e277)));
    local_20 = uint((base + 12u));
    uint _e288 = local_20;
    output.Store(_e288*4, asuint(asuint(asfloat(_e281))));
    int _e290 = directed_cursor;
    local_23 = uint((base + 13u));
    uint _e296 = local_23;
    output.Store(_e296*4, asuint(uint(_e290)));
    directed_cursor = int(0);
    int _e301 = directed_cursor;
    directed_cursor = asint(asuint(_e301) + asuint(int(1)));
    local_25 = uint(((index * 2u) + uint(_e301)));
    uint _e308 = local_25;
    uint _e310 = asuint(input.Load(_e308*4));
    int _e314 = directed_cursor;
    directed_cursor = asint(asuint(_e314) + asuint(int(1)));
    local_26 = uint(((index * 2u) + uint(_e314)));
    uint _e321 = local_26;
    uint _e323 = asuint(input.Load(_e321*4));
    const uint _e329 = _naga_fadd_rd(asuint(asfloat(_e310)), (asuint(asfloat(_e323)) ^ 2147483648u));
    local_24 = uint((base + 14u));
    uint _e336 = local_24;
    output.Store(_e336*4, asuint(asuint(asfloat(_e329))));
    int _e338 = directed_cursor;
    local_27 = uint((base + 15u));
    uint _e344 = local_27;
    output.Store(_e344*4, asuint(uint(_e338)));
    directed_cursor = int(0);
    int _e349 = directed_cursor;
    directed_cursor = asint(asuint(_e349) + asuint(int(1)));
    local_29 = uint(((index * 2u) + uint(_e349)));
    uint _e356 = local_29;
    uint _e358 = asuint(input.Load(_e356*4));
    int _e362 = directed_cursor;
    directed_cursor = asint(asuint(_e362) + asuint(int(1)));
    local_30 = uint(((index * 2u) + uint(_e362)));
    uint _e369 = local_30;
    uint _e371 = asuint(input.Load(_e369*4));
    const uint _e377 = _naga_fadd_ru(asuint(asfloat(_e358)), (asuint(asfloat(_e371)) ^ 2147483648u));
    local_28 = uint((base + 16u));
    uint _e384 = local_28;
    output.Store(_e384*4, asuint(asuint(asfloat(_e377))));
    int _e386 = directed_cursor;
    local_31 = uint((base + 17u));
    uint _e392 = local_31;
    output.Store(_e392*4, asuint(uint(_e386)));
}
