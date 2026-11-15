ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_floorf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value)
{
    const uint _e2 = _naga_floorf(asuint(value));
    return asfloat(_e2);
}

uint _naga_ceilf(uint input_bits_1)
{
    uint _e5 = (input_bits_1 & 2147483647u);
    uint _e6 = (input_bits_1 & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e18 = (input_bits_1 & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_1 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_1 : (_e6 | ((1u - (_e6 >> 31u)) * 1065353216u))) : (((_e6 == 0u) && ((input_bits_1 & _e14) != 0u)) ? (_e18 + _e13) : _e18))));
}

float ceil_value(float value_1)
{
    const uint _e2 = _naga_ceilf(asuint(value_1));
    return asfloat(_e2);
}

[numthreads(12, 1, 1)]
void rounding_zero_signs(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int cursor = (int)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;

    uint index = threadIdx.x;
    uint bits = asuint(input.Load(index*4));
    uint base = (4u + (index * 14u));
    const uint _e11 = _naga_floorf(asuint(asfloat(bits)));
    output.Store(base*4, asuint(asuint(asfloat(_e11))));
    const uint _e18 = _naga_ceilf(asuint(asfloat(bits)));
    local = uint((base + 1u));
    uint _e25 = local;
    output.Store(_e25*4, asuint(asuint(asfloat(_e18))));
    const float _e28 = floor_value(asfloat(bits));
    local_1 = uint((base + 2u));
    uint _e34 = local_1;
    output.Store(_e34*4, asuint(asuint(_e28)));
    const float _e37 = ceil_value(asfloat(bits));
    local_2 = uint((base + 3u));
    uint _e43 = local_2;
    output.Store(_e43*4, asuint(asuint(_e37)));
    const uint _e47 = _naga_floorf(asuint(0.0));
    local_3 = uint((base + 4u));
    uint _e54 = local_3;
    output.Store(_e54*4, asuint(asuint(asfloat(_e47))));
    const uint _e59 = _naga_floorf(asuint(-(0.0)));
    local_4 = uint((base + 5u));
    uint _e66 = local_4;
    output.Store(_e66*4, asuint(asuint(asfloat(_e59))));
    const uint _e70 = _naga_ceilf(asuint(0.0));
    local_5 = uint((base + 6u));
    uint _e77 = local_5;
    output.Store(_e77*4, asuint(asuint(asfloat(_e70))));
    const uint _e82 = _naga_ceilf(asuint(-(0.0)));
    local_6 = uint((base + 7u));
    uint _e89 = local_6;
    output.Store(_e89*4, asuint(asuint(asfloat(_e82))));
    const uint _e93 = _naga_floorf(asuint(0.25));
    local_7 = uint((base + 8u));
    uint _e100 = local_7;
    output.Store(_e100*4, asuint(asuint(asfloat(_e93))));
    const uint _e105 = _naga_ceilf(asuint(-(0.25)));
    local_8 = uint((base + 9u));
    uint _e112 = local_8;
    output.Store(_e112*4, asuint(asuint(asfloat(_e105))));
    cursor = int(0);
    int _e116 = cursor;
    cursor = asint(asuint(_e116) + asuint(int(1)));
    local_10 = uint((index + uint(_e116)));
    uint _e123 = local_10;
    uint _e125 = asuint(input.Load(_e123*4));
    const float _e127 = floor_value(asfloat(_e125));
    local_9 = uint((base + 10u));
    uint _e133 = local_9;
    output.Store(_e133*4, asuint(asuint(_e127)));
    int _e135 = cursor;
    cursor = asint(asuint(_e135) + asuint(int(1)));
    const float _e139 = ceil_value(float(_e135));
    local_11 = uint((base + 11u));
    uint _e145 = local_11;
    output.Store(_e145*4, asuint(asuint(_e139)));
    int _e147 = cursor;
    local_12 = uint((base + 12u));
    uint _e155 = local_12;
    output.Store(_e155*4, asuint(uint(asint(asuint(_e147) - asuint(int(1))))));
    int _e157 = cursor;
    local_13 = uint((base + 13u));
    uint _e163 = local_13;
    output.Store(_e163*4, asuint(uint(_e157)));
}
