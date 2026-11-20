struct type_6 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_6 count; }

uint kind(float value_4)
{
    return 1u;
}

uint _naga_ldexpf(uint bits, int exponent)
{
    uint _e12 = (bits & 2147483647u);
    uint _e13 = (bits & 2147483648u);
    if ((_e12 > 2139095040u)) {
        return 2143289344u;
    }
    if (((_e12 == 0u) || (_e12 == 2139095040u))) {
        return bits;
    }
    uint _e21 = (max((31u - firstbithigh(_e12)), 8u) - 8u);
    uint _e23 = ((_e12 << _e21) & 8388607u);
    uint _e24 = (_e23 | 8388608u);
    int _e33 = asint(asuint(asint(asuint(max(int((_e12 >> 23u)), int(1))) - asuint(int(_e21)))) + asuint(clamp(exponent, int(-512), int(512))));
    if ((_e33 >= int(255))) {
        return (2139095040u | _e13);
    }
    if ((_e33 >= int(1))) {
        return (((uint(_e33) << 23u) | _e23) | _e13);
    }
    uint _e45 = uint(clamp(asint(asuint(int(1)) - asuint(_e33)), int(1), int(25)));
    uint _e46 = (_e24 >> _e45);
    uint _e47 = (1u << _e45);
    uint _e49 = (_e24 & (_e47 - 1u));
    uint _e50 = (_e47 >> 1u);
    return ((_e46 + (((_e49 > _e50) || ((_e49 == _e50) && ((_e46 & 1u) != 0u))) ? 1u : 0u)) | _e13);
}

float ZeroValuefloat() {
    return (float)0;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void scale_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    float value = (float)0;
    int value_1 = (int)0;
    float value_2 = (float)0;
    int value_3 = (int)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e18 = asuint(input.Load(0+index*8));
    float value_5 = asfloat(_e18);
    uint _e22 = asuint(input.Load(4+index*8));
    int power = int(_e22);
    counter = 0u;
    const uint _e27 = _naga_ldexpf(asuint(value_5), power);
    output.Store(base*4, asuint(asuint(asfloat(_e27))));
    value = ZeroValuefloat();
    value = value_5;
    uint _e35 = counter;
    counter = (_e35 + uint(int(1)));
    float _e39 = value;
    value_1 = ZeroValueint();
    value_1 = power;
    uint _e43 = counter;
    counter = (_e43 + uint(int(1)));
    int _e47 = value_1;
    const uint _e49 = _naga_ldexpf(asuint(_e39), _e47);
    local = uint((base + 1u));
    uint _e56 = local;
    output.Store(_e56*4, asuint(asuint(asfloat(_e49))));
    uint _e58 = counter;
    local_1 = uint((base + 2u));
    uint _e63 = local_1;
    output.Store(_e63*4, asuint(_e58));
    const uint _e66 = _naga_ldexpf(asuint(value_5), power);
    const uint _e68 = kind(asfloat(_e66));
    local_2 = uint((base + 3u));
    uint _e73 = local_2;
    output.Store(_e73*4, asuint(_e68));
    const uint _e76 = _naga_ldexpf(asuint(value_5), power);
    local_3 = uint((base + 4u));
    uint _e83 = local_3;
    output.Store(_e83*4, asuint(asuint(asfloat(_e76))));
    value_2 = ZeroValuefloat();
    value_2 = value_5;
    uint _e88 = counter;
    counter = (_e88 + uint(int(1)));
    float _e92 = value_2;
    value_3 = ZeroValueint();
    value_3 = power;
    uint _e96 = counter;
    counter = (_e96 + uint(int(1)));
    int _e100 = value_3;
    const uint _e102 = _naga_ldexpf(asuint(_e92), _e100);
    local_4 = uint((base + 5u));
    uint _e109 = local_4;
    output.Store(_e109*4, asuint(asuint(asfloat(_e102))));
    uint _e111 = counter;
    local_5 = uint((base + 6u));
    uint _e116 = local_5;
    output.Store(_e116*4, asuint(_e111));
    const uint _e119 = _naga_ldexpf(asuint(value_5), power);
    const uint _e121 = kind(asfloat(_e119));
    local_6 = uint((base + 7u));
    uint _e126 = local_6;
    output.Store(_e126*4, asuint(_e121));
}
