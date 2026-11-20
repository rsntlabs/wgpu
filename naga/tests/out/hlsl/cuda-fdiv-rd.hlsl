struct type_6 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_6 count; }

uint kind(float value_6)
{
    return 1u;
}

uint _naga_divide_f32_rd(uint numerator_bits, uint denominator_bits)
{
    uint numerator_significand = (uint)0;
    int numerator_exponent = (int)0;
    uint denominator_significand = (uint)0;
    int denominator_exponent = (int)0;
    uint quotient = (uint)0;
    uint remainder = (uint)0;
    uint iteration = (uint)0;

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
    numerator_exponent = asint(asuint(int(_e31)) - asuint(int(127)));
    if ((_e31 == 0u)) {
        uint _e41 = ((31u - firstbithigh(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = asint(asuint(int(-126)) - asuint(int(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = asint(asuint(int(_e53)) - asuint(int(127)));
    if ((_e53 == 0u)) {
        uint _e63 = ((31u - firstbithigh(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = asint(asuint(int(-126)) - asuint(int(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = asint(asuint(asint(asuint(_e47) - asuint(_e69))) - asuint(int(_e70)));
    bool _e78 = (_e11 != 0u);
    if ((_e75 < int(-150))) {
        return (_e11 | uint(_e78));
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e97 = iteration;
            iteration = (_e97 + 1u);
        }
        loop_init = false;
        uint _e86 = iteration;
        if ((_e86 >= 23u)) {
            break;
        }
        uint _e88 = remainder;
        uint _e89 = quotient;
        uint _e90 = (_e88 << 1u);
        bool _e91 = (_e90 >= _e68);
        remainder = (_e91 ? (_e90 - _e68) : _e90);
        quotient = ((_e89 << 1u) | (_e91 ? 1u : 0u));
    }
    uint _e99 = quotient;
    uint _e100 = remainder;
    if ((_e75 < int(-126))) {
        uint _e106 = (uint(asint(asuint(int(-126)) - asuint(_e75))) & 31u);
        return (_e11 | ((_e99 >> _e106) + uint((_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)))));
    }
    uint _e120 = (_e99 + ((_e78 && (_e100 != 0u)) ? 1u : 0u));
    uint _e122 = (_e120 >> 24u);
    int _e125 = asint(asuint(_e75) + asuint(int(_e122)));
    if ((_e125 > int(127))) {
        return (_e78 ? _e12 : 2139095039u);
    }
    return (_e11 | ((uint(asint(asuint(_e125) + asuint(int(127)))) << 23u) | ((_e120 >> _e122) & 8388607u)));
}

uint _naga_divide_f32_ru(uint numerator_bits_1, uint denominator_bits_1)
{
    uint numerator_significand_1 = (uint)0;
    int numerator_exponent_1 = (int)0;
    uint denominator_significand_1 = (uint)0;
    int denominator_exponent_1 = (int)0;
    uint quotient_1 = (uint)0;
    uint remainder_1 = (uint)0;
    uint iteration_1 = (uint)0;

    uint _e8 = (numerator_bits_1 & 2147483647u);
    uint _e9 = (denominator_bits_1 & 2147483647u);
    uint _e11 = ((numerator_bits_1 ^ denominator_bits_1) & 2147483648u);
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
    numerator_significand_1 = (_e30 | 8388608u);
    numerator_exponent_1 = asint(asuint(int(_e31)) - asuint(int(127)));
    if ((_e31 == 0u)) {
        uint _e41 = ((31u - firstbithigh(_e30)) - 8u);
        numerator_significand_1 = (_e30 << _e41);
        numerator_exponent_1 = asint(asuint(int(-126)) - asuint(int(_e41)));
    }
    uint _e46 = numerator_significand_1;
    int _e47 = numerator_exponent_1;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand_1 = (_e52 | 8388608u);
    denominator_exponent_1 = asint(asuint(int(_e53)) - asuint(int(127)));
    if ((_e53 == 0u)) {
        uint _e63 = ((31u - firstbithigh(_e52)) - 8u);
        denominator_significand_1 = (_e52 << _e63);
        denominator_exponent_1 = asint(asuint(int(-126)) - asuint(int(_e63)));
    }
    uint _e68 = denominator_significand_1;
    int _e69 = denominator_exponent_1;
    bool _e70 = (_e46 < _e68);
    int _e75 = asint(asuint(asint(asuint(_e47) - asuint(_e69))) - asuint(int(_e70)));
    bool _e78 = (_e11 == 0u);
    if ((_e75 < int(-150))) {
        return (_e11 | uint(_e78));
    }
    quotient_1 = 1u;
    remainder_1 = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration_1 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e97 = iteration_1;
            iteration_1 = (_e97 + 1u);
        }
        loop_init_1 = false;
        uint _e86 = iteration_1;
        if ((_e86 >= 23u)) {
            break;
        }
        uint _e88 = remainder_1;
        uint _e89 = quotient_1;
        uint _e90 = (_e88 << 1u);
        bool _e91 = (_e90 >= _e68);
        remainder_1 = (_e91 ? (_e90 - _e68) : _e90);
        quotient_1 = ((_e89 << 1u) | (_e91 ? 1u : 0u));
    }
    uint _e99 = quotient_1;
    uint _e100 = remainder_1;
    if ((_e75 < int(-126))) {
        uint _e106 = (uint(asint(asuint(int(-126)) - asuint(_e75))) & 31u);
        return (_e11 | ((_e99 >> _e106) + uint((_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)))));
    }
    uint _e120 = (_e99 + ((_e78 && (_e100 != 0u)) ? 1u : 0u));
    uint _e122 = (_e120 >> 24u);
    int _e125 = asint(asuint(_e75) + asuint(int(_e122)));
    if ((_e125 > int(127))) {
        return (_e78 ? _e12 : 4286578687u);
    }
    return (_e11 | ((uint(asint(asuint(_e125) + asuint(int(127)))) << 23u) | ((_e120 >> _e122) & 8388607u)));
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(4, 1, 1)]
void divide_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float value = (float)0;
    float value_1 = (float)0;
    float value_2 = (float)0;
    float value_3 = (float)0;
    float value_4 = (float)0;
    float value_5 = (float)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 16u));
    uint _e18 = asuint(input.Load(0+index*8));
    float x = asfloat(_e18);
    uint _e22 = asuint(input.Load(4+index*8));
    float y = asfloat(_e22);
    counter = 0u;
    const uint _e28 = _naga_divide_f32_rd(asuint(x), asuint(y));
    output.Store(base*4, asuint(asuint(asfloat(_e28))));
    value = ZeroValuefloat();
    value = x;
    uint _e36 = counter;
    counter = (_e36 + uint(int(1)));
    float _e40 = value;
    value_1 = ZeroValuefloat();
    value_1 = y;
    uint _e44 = counter;
    counter = (_e44 + uint(int(1)));
    float _e48 = value_1;
    const uint _e51 = _naga_divide_f32_rd(asuint(_e40), asuint(_e48));
    local = uint((base + 1u));
    uint _e58 = local;
    output.Store(_e58*4, asuint(asuint(asfloat(_e51))));
    uint _e60 = counter;
    local_1 = uint((base + 2u));
    uint _e65 = local_1;
    output.Store(_e65*4, asuint(_e60));
    const uint _e70 = _naga_divide_f32_rd(asuint(1.0), asuint(y));
    local_2 = uint((base + 3u));
    uint _e77 = local_2;
    output.Store(_e77*4, asuint(asuint(asfloat(_e70))));
    value_2 = ZeroValuefloat();
    value_2 = y;
    uint _e82 = counter;
    counter = (_e82 + uint(int(1)));
    float _e86 = value_2;
    const uint _e90 = _naga_divide_f32_rd(asuint(1.0), asuint(_e86));
    local_3 = uint((base + 4u));
    uint _e97 = local_3;
    output.Store(_e97*4, asuint(asuint(asfloat(_e90))));
    uint _e99 = counter;
    local_4 = uint((base + 5u));
    uint _e104 = local_4;
    output.Store(_e104*4, asuint(_e99));
    const uint _e108 = _naga_divide_f32_rd(asuint(x), asuint(y));
    const uint _e110 = kind(asfloat(_e108));
    local_5 = uint((base + 6u));
    uint _e115 = local_5;
    output.Store(_e115*4, asuint(_e110));
    const uint _e120 = _naga_divide_f32_rd(asuint(1.0), asuint(y));
    const uint _e122 = kind(asfloat(_e120));
    local_6 = uint((base + 7u));
    uint _e127 = local_6;
    output.Store(_e127*4, asuint(_e122));
    const uint _e131 = _naga_divide_f32_ru(asuint(x), asuint(y));
    local_7 = uint((base + 8u));
    uint _e138 = local_7;
    output.Store(_e138*4, asuint(asuint(asfloat(_e131))));
    value_3 = ZeroValuefloat();
    value_3 = x;
    uint _e143 = counter;
    counter = (_e143 + uint(int(1)));
    float _e147 = value_3;
    value_4 = ZeroValuefloat();
    value_4 = y;
    uint _e151 = counter;
    counter = (_e151 + uint(int(1)));
    float _e155 = value_4;
    const uint _e158 = _naga_divide_f32_ru(asuint(_e147), asuint(_e155));
    local_8 = uint((base + 9u));
    uint _e165 = local_8;
    output.Store(_e165*4, asuint(asuint(asfloat(_e158))));
    uint _e167 = counter;
    local_9 = uint((base + 10u));
    uint _e172 = local_9;
    output.Store(_e172*4, asuint(_e167));
    const uint _e177 = _naga_divide_f32_ru(asuint(1.0), asuint(y));
    local_10 = uint((base + 11u));
    uint _e184 = local_10;
    output.Store(_e184*4, asuint(asuint(asfloat(_e177))));
    value_5 = ZeroValuefloat();
    value_5 = y;
    uint _e189 = counter;
    counter = (_e189 + uint(int(1)));
    float _e193 = value_5;
    const uint _e197 = _naga_divide_f32_ru(asuint(1.0), asuint(_e193));
    local_11 = uint((base + 12u));
    uint _e204 = local_11;
    output.Store(_e204*4, asuint(asuint(asfloat(_e197))));
    uint _e206 = counter;
    local_12 = uint((base + 13u));
    uint _e211 = local_12;
    output.Store(_e211*4, asuint(_e206));
    const uint _e215 = _naga_divide_f32_ru(asuint(x), asuint(y));
    const uint _e217 = kind(asfloat(_e215));
    local_13 = uint((base + 14u));
    uint _e222 = local_13;
    output.Store(_e222*4, asuint(_e217));
    const uint _e227 = _naga_divide_f32_ru(asuint(1.0), asuint(y));
    const uint _e229 = kind(asfloat(_e227));
    local_14 = uint((base + 15u));
    uint _e234 = local_14;
    output.Store(_e234*4, asuint(_e229));
}
