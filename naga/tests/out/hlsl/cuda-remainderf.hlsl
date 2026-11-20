struct type_6 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_6 count; }

uint kind(float value_2)
{
    return 1u;
}

uint _naga_remainderf(uint dividend_bits, uint divisor_bits)
{
    uint dividend_significand = (uint)0;
    int dividend_exponent = (int)0;
    uint divisor_significand = (uint)0;
    int divisor_exponent = (int)0;
    uint remainder = (uint)0;
    uint remaining_bits = (uint)0;

    uint _e8 = (dividend_bits & 2147483647u);
    uint _e9 = (divisor_bits & 2147483647u);
    uint _e10 = (dividend_bits & 2147483648u);
    if (((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u)))) {
        return 2143289344u;
    }
    if (((_e8 == 0u) || (_e9 == 2139095040u))) {
        return dividend_bits;
    }
    if ((_e8 == _e9)) {
        return _e10;
    }
    uint _e24 = (_e8 & 8388607u);
    uint _e25 = (_e8 >> 23u);
    dividend_significand = (_e24 | 8388608u);
    dividend_exponent = asint(asuint(int(_e25)) - asuint(int(127)));
    if ((_e25 == 0u)) {
        uint _e35 = ((31u - firstbithigh(_e24)) - 8u);
        dividend_significand = (_e24 << _e35);
        dividend_exponent = asint(asuint(int(-126)) - asuint(int(_e35)));
    }
    uint _e40 = dividend_significand;
    int _e41 = dividend_exponent;
    uint _e46 = (_e9 & 8388607u);
    uint _e47 = (_e9 >> 23u);
    divisor_significand = (_e46 | 8388608u);
    divisor_exponent = asint(asuint(int(_e47)) - asuint(int(127)));
    if ((_e47 == 0u)) {
        uint _e57 = ((31u - firstbithigh(_e46)) - 8u);
        divisor_significand = (_e46 << _e57);
        divisor_exponent = asint(asuint(int(-126)) - asuint(int(_e57)));
    }
    uint _e62 = divisor_significand;
    int _e63 = divisor_exponent;
    remainder = _e40;
    int _e66 = asint(asuint(_e41) - asuint(_e63));
    if ((_e66 < int(-1))) {
        return dividend_bits;
    }
    bool _e70 = (_e66 == int(-1));
    uint _e72 = (_e70 ? (_e62 << 1u) : _e62);
    remaining_bits = uint((_e70 ? int(0) : _e66));
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        uint _e76 = remaining_bits;
        if ((_e76 == 0u)) {
            break;
        }
        uint _e78 = remainder;
        remainder = (((_e78 >= _e72) ? (_e78 - _e72) : _e78) << 1u);
        remaining_bits = (_e76 - 1u);
    }
    uint _e84 = remainder;
    bool _e85 = (_e84 >= _e72);
    uint _e87 = (_e85 ? (_e84 - _e72) : _e84);
    uint _e88 = (_e87 + _e87);
    bool _e92 = ((_e88 > _e72) || ((_e88 == _e72) && _e85));
    uint _e96 = (_e92 ? (_e72 - _e87) : _e87);
    uint _e97 = (_e92 ? (_e10 ^ 2147483648u) : _e10);
    if ((_e96 == 0u)) {
        return _e97;
    }
    uint _e101 = ((31u - firstbithigh(_e96)) - 8u);
    uint _e102 = (_e96 << _e101);
    int _e104 = asint(asuint((_e70 ? _e41 : _e63)) - asuint(int(_e101)));
    return (_e97 | ((_e104 >= int(-126)) ? ((uint(asint(asuint(_e104) + asuint(int(127)))) << 23u) | (_e102 & 8388607u)) : (_e102 >> (uint(asint(asuint(int(-126)) - asuint(_e104))) & 31u))));
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(4, 1, 1)]
void nearest_remainders(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    float value = (float)0;
    float value_1 = (float)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e18 = asuint(input.Load(0+index*8));
    float x = asfloat(_e18);
    uint _e22 = asuint(input.Load(4+index*8));
    float y = asfloat(_e22);
    counter = 0u;
    const uint _e28 = _naga_remainderf(asuint(x), asuint(y));
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
    const uint _e51 = _naga_remainderf(asuint(_e40), asuint(_e48));
    local = uint((base + 1u));
    uint _e58 = local;
    output.Store(_e58*4, asuint(asuint(asfloat(_e51))));
    uint _e60 = counter;
    local_1 = uint((base + 2u));
    uint _e65 = local_1;
    output.Store(_e65*4, asuint(_e60));
    const uint _e69 = _naga_remainderf(asuint(x), asuint(y));
    const uint _e71 = kind(asfloat(_e69));
    local_2 = uint((base + 3u));
    uint _e76 = local_2;
    output.Store(_e76*4, asuint(_e71));
}
