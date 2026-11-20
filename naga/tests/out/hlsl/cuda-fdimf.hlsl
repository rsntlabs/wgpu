ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint kind(float value_2)
{
    return 1u;
}

uint _naga_fadd_rn(uint left_bits, uint right_bits)
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

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(4, 1, 1)]
void positive_differences(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    float value = (float)0;
    float value_1 = (float)0;

    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= 26u)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e16 = asuint(input.Load(0+index*8));
    float x = asfloat(_e16);
    uint _e20 = asuint(input.Load(4+index*8));
    float y = asfloat(_e20);
    counter = 0u;
    uint _e24 = asuint(x);
    uint _e25 = asuint(y);
    const uint _e34 = _naga_fadd_rn(_e24, (_e25 ^ 2147483648u));
    output.Store(base*4, asuint(asuint(asfloat((((_e34 >= 2147483648u) || ((_e24 == _e25) && ((_e24 & 2147483647u) == 2139095040u))) ? 0u : _e34)))));
    value = ZeroValuefloat();
    value = x;
    uint _e46 = counter;
    counter = (_e46 + uint(int(1)));
    float _e50 = value;
    value_1 = ZeroValuefloat();
    value_1 = y;
    uint _e54 = counter;
    counter = (_e54 + uint(int(1)));
    float _e58 = value_1;
    uint _e59 = asuint(_e50);
    uint _e60 = asuint(_e58);
    const uint _e69 = _naga_fadd_rn(_e59, (_e60 ^ 2147483648u));
    local = uint((base + 1u));
    uint _e80 = local;
    output.Store(_e80*4, asuint(asuint(asfloat((((_e69 >= 2147483648u) || ((_e59 == _e60) && ((_e59 & 2147483647u) == 2139095040u))) ? 0u : _e69)))));
    uint _e82 = counter;
    local_1 = uint((base + 2u));
    uint _e87 = local_1;
    output.Store(_e87*4, asuint(_e82));
    uint _e89 = asuint(x);
    uint _e90 = asuint(y);
    const uint _e99 = _naga_fadd_rn(_e89, (_e90 ^ 2147483648u));
    const uint _e105 = kind(asfloat((((_e99 >= 2147483648u) || ((_e89 == _e90) && ((_e89 & 2147483647u) == 2139095040u))) ? 0u : _e99)));
    local_2 = uint((base + 3u));
    uint _e110 = local_2;
    output.Store(_e110*4, asuint(_e105));
}
