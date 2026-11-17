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

float rounded_even(float value)
{
    const uint _e2 = _naga_rintf(asuint(value));
    return asfloat(_e2);
}

int rintf(bool value_1)
{
    int local_17 = (int)0;

    if (value_1) {
        local_17 = int(7);
    } else {
        local_17 = int(9);
    }
    int _e6 = local_17;
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
void nearest_even(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    int cursor = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    bool local_3 = (bool)0;
    bool local_4 = (bool)0;
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
    float local_15 = (float)0;
    uint local_16 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    uint _e15 = asuint(input.Load(index*4));
    float value_2 = asfloat(_e15);
    const uint _e18 = _naga_rintf(asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e18))));
    const float _e23 = rounded_even(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    output.Store(_e29*4, asuint(asuint(_e23)));
    cursor = int(0);
    int _e33 = cursor;
    cursor = asint(asuint(_e33) + asuint(int(1)));
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = asuint(input.Load(_e40*4));
    const float _e44 = rounded_even(asfloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(asuint(_e44)));
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = asint(asuint(_e54) + asuint(int(1)));
        const uint _e59 = _naga_rintf(asuint(float(_e54)));
        const uint _e62 = _naga_fabsf(asuint(asfloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = asint(asuint(_e67) + asuint(int(1)));
        const uint _e72 = _naga_rintf(asuint(float(_e67)));
        const uint _e75 = _naga_fabsf(asuint(asfloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    output.Store(_e84*4, asuint(uint(_e78)));
    const uint _e89 = _naga_rintf(asuint(-(0.5)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    output.Store(_e96*4, asuint(asuint(asfloat(_e89))));
    const uint _e100 = _naga_rintf(asuint(0.5));
    local_7 = uint((base + 5u));
    uint _e107 = local_7;
    output.Store(_e107*4, asuint(asuint(asfloat(_e100))));
    const uint _e111 = _naga_rintf(asuint(2.5));
    local_8 = uint((base + 6u));
    uint _e118 = local_8;
    output.Store(_e118*4, asuint(asuint(asfloat(_e111))));
    const uint _e122 = _naga_roundf(asuint(2.5));
    local_9 = uint((base + 7u));
    uint _e129 = local_9;
    output.Store(_e129*4, asuint(asuint(asfloat(_e122))));
    const uint _e134 = _naga_rintf(asuint(-(2.5)));
    local_10 = uint((base + 8u));
    uint _e141 = local_10;
    output.Store(_e141*4, asuint(asuint(asfloat(_e134))));
    const uint _e146 = _naga_roundf(asuint(-(2.5)));
    local_11 = uint((base + 9u));
    uint _e153 = local_11;
    output.Store(_e153*4, asuint(asuint(asfloat(_e146))));
    const float _e157 = rounded_even(float(3u));
    local_12 = uint((base + 10u));
    uint _e163 = local_12;
    output.Store(_e163*4, asuint(asuint(_e157)));
    const int _e166 = rintf(true);
    local_13 = uint((base + 11u));
    uint _e172 = local_13;
    output.Store(_e172*4, asuint(uint(_e166)));
    if (true) {
        const uint _e176 = _naga_rintf(asuint(value_2));
        const uint _e179 = _naga_rintf(asuint(asfloat(_e176)));
        local_15 = asfloat(_e179);
    } else {
        int _e182 = cursor;
        cursor = asint(asuint(_e182) + asuint(int(1)));
        const uint _e187 = _naga_rintf(asuint(float(_e182)));
        local_15 = asfloat(_e187);
    }
    float _e191 = local_15;
    local_14 = uint((base + 12u));
    uint _e197 = local_14;
    output.Store(_e197*4, asuint(asuint(_e191)));
    int _e199 = cursor;
    local_16 = uint((base + 13u));
    uint _e205 = local_16;
    output.Store(_e205*4, asuint(uint(_e199)));
}
