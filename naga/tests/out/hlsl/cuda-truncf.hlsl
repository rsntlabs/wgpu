ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_truncf(uint input_bits)
{
    uint _e4 = (input_bits & 2147483647u);
    return ((_e4 > 2139095040u) ? 2143289344u : ((_e4 >= 1258291200u) ? input_bits : ((_e4 < 1065353216u) ? (input_bits & 2147483648u) : (input_bits & ~(((1u << ((150u - (_e4 >> 23u)) & 31u)) - 1u))))));
}

float truncated(float value)
{
    const uint _e2 = _naga_truncf(asuint(value));
    return asfloat(_e2);
}

int truncf(bool value_1)
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

[numthreads(32, 1, 1)]
void truncations(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
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
    float local_12 = (float)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;

    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 12u));
    uint _e15 = asuint(input.Load(index*4));
    float value_2 = asfloat(_e15);
    const uint _e18 = _naga_truncf(asuint(value_2));
    output.Store(base*4, asuint(asuint(asfloat(_e18))));
    const float _e23 = truncated(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    output.Store(_e29*4, asuint(asuint(_e23)));
    cursor = int(0);
    int _e33 = cursor;
    cursor = asint(asuint(_e33) + asuint(int(1)));
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = asuint(input.Load(_e40*4));
    const float _e44 = truncated(asfloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(asuint(_e44)));
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = asint(asuint(_e54) + asuint(int(1)));
        const uint _e59 = _naga_truncf(asuint(float(_e54)));
        const uint _e62 = _naga_fabsf(asuint(asfloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = asint(asuint(_e67) + asuint(int(1)));
        const uint _e72 = _naga_truncf(asuint(float(_e67)));
        const uint _e75 = _naga_fabsf(asuint(asfloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    output.Store(_e84*4, asuint(uint(_e78)));
    const uint _e89 = _naga_truncf(asuint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    output.Store(_e96*4, asuint(asuint(asfloat(_e89))));
    const uint _e101 = _naga_truncf(asuint(-(0.25)));
    local_7 = uint((base + 5u));
    uint _e108 = local_7;
    output.Store(_e108*4, asuint(asuint(asfloat(_e101))));
    const uint _e113 = _naga_truncf(asuint(-(1.75)));
    local_8 = uint((base + 6u));
    uint _e120 = local_8;
    output.Store(_e120*4, asuint(asuint(asfloat(_e113))));
    const float _e124 = truncated(float(3u));
    local_9 = uint((base + 7u));
    uint _e130 = local_9;
    output.Store(_e130*4, asuint(asuint(_e124)));
    const int _e133 = truncf(true);
    local_10 = uint((base + 8u));
    uint _e139 = local_10;
    output.Store(_e139*4, asuint(uint(_e133)));
    if (true) {
        const uint _e143 = _naga_truncf(asuint(value_2));
        local_12 = asfloat(_e143);
    } else {
        int _e146 = cursor;
        cursor = asint(asuint(_e146) + asuint(int(1)));
        const uint _e151 = _naga_truncf(asuint(float(_e146)));
        local_12 = asfloat(_e151);
    }
    float _e155 = local_12;
    local_11 = uint((base + 9u));
    uint _e161 = local_11;
    output.Store(_e161*4, asuint(asuint(_e155)));
    const uint _e164 = _naga_truncf(asuint(value_2));
    const uint _e167 = _naga_truncf(asuint(asfloat(_e164)));
    local_13 = uint((base + 10u));
    uint _e174 = local_13;
    output.Store(_e174*4, asuint(asuint(asfloat(_e167))));
    int _e176 = cursor;
    local_14 = uint((base + 11u));
    uint _e182 = local_14;
    output.Store(_e182*4, asuint(uint(_e176)));
}
