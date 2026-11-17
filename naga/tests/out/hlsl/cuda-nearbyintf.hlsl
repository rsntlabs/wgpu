ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_rintf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits & _e14);
    uint _e18 = (input_bits & ~(_e14));
    uint _e20 = (_e13 >> 1u);
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((input_bits & 2147483648u) | (((_e5 > 1056964608u) ? 1u : 0u) * 1065353216u))) : ((((_e15 > _e20) || ((_e15 == _e20) && ((_e18 & _e13) != 0u))) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

float nearby_value(float value)
{
    const uint _e2 = _naga_rintf(asuint(value));
    return asfloat(_e2);
}

int nearbyintf(bool value_1)
{
    int local_15 = (int)0;

    if (value_1) {
        local_15 = int(7);
    } else {
        local_15 = int(9);
    }
    int _e6 = local_15;
    return _e6;
}

uint _naga_fabsf(uint input_bits_1)
{
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_roundf(uint input_bits_2)
{
    uint _e5 = (input_bits_2 & 2147483647u);
    uint _e6 = (input_bits_2 & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits_2 & _e14);
    uint _e18 = (input_bits_2 & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_2 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_2 : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

[numthreads(32, 1, 1)]
void nearby_integers(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    int cursor = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    bool local_4 = (bool)0;
    bool local_5 = (bool)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    float local_13 = (float)0;
    uint local_14 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 32u)) {
        return;
    }
    uint base = (4u + (index * 12u));
    uint _e15 = asuint(input.Load(index*4));
    float value_2 = asfloat(_e15);
    const uint _e18 = _naga_rintf(asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e18))));
    const uint _e24 = _naga_rintf(asuint(value_2));
    local = uint((base + 1u));
    uint _e31 = local;
    output.Store(_e31*4, asuint(asuint(asfloat(_e24))));
    const float _e33 = nearby_value(value_2);
    local_1 = uint((base + 2u));
    uint _e39 = local_1;
    output.Store(_e39*4, asuint(asuint(_e33)));
    cursor = int(0);
    int _e43 = cursor;
    cursor = asint(asuint(_e43) + asuint(int(1)));
    local_3 = uint((index + uint(_e43)));
    uint _e50 = local_3;
    uint _e52 = asuint(input.Load(_e50*4));
    const float _e54 = nearby_value(asfloat(_e52));
    local_2 = uint((base + 3u));
    uint _e60 = local_2;
    output.Store(_e60*4, asuint(asuint(_e54)));
    local_4 = false;
    if (false) {
        int _e64 = cursor;
        cursor = asint(asuint(_e64) + asuint(int(1)));
        const uint _e69 = _naga_rintf(asuint(float(_e64)));
        const uint _e72 = _naga_fabsf(asuint(asfloat(_e69)));
        local_4 = (_e72 != 0u);
    }
    local_5 = true;
    if (true) {
    } else {
        int _e77 = cursor;
        cursor = asint(asuint(_e77) + asuint(int(1)));
        const uint _e82 = _naga_rintf(asuint(float(_e77)));
        const uint _e85 = _naga_fabsf(asuint(asfloat(_e82)));
        local_5 = (_e85 != 0u);
    }
    int _e88 = cursor;
    local_6 = uint((base + 4u));
    uint _e94 = local_6;
    output.Store(_e94*4, asuint(uint(_e88)));
    const uint _e99 = _naga_rintf(asuint(-(0.5)));
    local_7 = uint((base + 5u));
    uint _e106 = local_7;
    output.Store(_e106*4, asuint(asuint(asfloat(_e99))));
    const uint _e110 = _naga_rintf(asuint(2.5));
    local_8 = uint((base + 6u));
    uint _e117 = local_8;
    output.Store(_e117*4, asuint(asuint(asfloat(_e110))));
    const uint _e121 = _naga_roundf(asuint(2.5));
    local_9 = uint((base + 7u));
    uint _e128 = local_9;
    output.Store(_e128*4, asuint(asuint(asfloat(_e121))));
    const float _e132 = nearby_value(float(3u));
    local_10 = uint((base + 8u));
    uint _e138 = local_10;
    output.Store(_e138*4, asuint(asuint(_e132)));
    const int _e141 = nearbyintf(true);
    local_11 = uint((base + 9u));
    uint _e147 = local_11;
    output.Store(_e147*4, asuint(uint(_e141)));
    if (true) {
        const uint _e151 = _naga_rintf(asuint(value_2));
        const uint _e154 = _naga_rintf(asuint(asfloat(_e151)));
        local_13 = asfloat(_e154);
    } else {
        int _e157 = cursor;
        cursor = asint(asuint(_e157) + asuint(int(1)));
        const uint _e162 = _naga_rintf(asuint(float(_e157)));
        local_13 = asfloat(_e162);
    }
    float _e166 = local_13;
    local_12 = uint((base + 10u));
    uint _e172 = local_12;
    output.Store(_e172*4, asuint(asuint(_e166)));
    int _e174 = cursor;
    local_14 = uint((base + 11u));
    uint _e180 = local_14;
    output.Store(_e180*4, asuint(uint(_e174)));
}
