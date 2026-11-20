struct type_4 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_4 count; }

float forward(float value)
{
    return value;
}

uint _naga_ceilf(uint input_bits)
{
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e18 = (input_bits & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((1u - (_e6 >> 31u)) * 1065353216u))) : (((_e6 == 0u) && ((input_bits & _e14) != 0u)) ? (_e18 + _e13) : _e18))));
}

int ZeroValueint() {
    return (int)0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(4, 1, 1)]
void convert_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    float local_4 = (float)0;
    float local_5 = (float)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int local_9 = (int)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    float local_13 = (float)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    int extra = (int)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e17 = asuint(input.Load(index*4));
    float value_1 = asfloat(_e17);
    counter = 0u;
    const uint _e22 = _naga_ceilf(asuint(value_1));
    output.Store(base*4, asuint(naga_f2u32(asfloat(_e22))));
    const float _e27 = forward(value_1);
    const uint _e29 = _naga_ceilf(asuint(_e27));
    local = uint((base + 1u));
    uint _e36 = local;
    output.Store(_e36*4, asuint(naga_f2u32(asfloat(_e29))));
    uint _e38 = counter;
    counter = (_e38 + uint(int(1)));
    const uint _e43 = _naga_ceilf(asuint(value_1));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    output.Store(_e50*4, asuint(naga_f2u32(asfloat(_e43))));
    uint _e52 = counter;
    local_2 = uint((base + 3u));
    uint _e59 = local_2;
    output.Store(_e59*4, asuint(uint(int(_e52))));
    if (((index & 1u) != 0u)) {
        uint _e65 = counter;
        local_12 = _e65;
        uint _e67 = local_12;
        counter = (_e67 + uint(int(1)));
        local_13 = value_1;
        float _e72 = local_13;
        local_4 = _e72;
        float _e74 = local_4;
        const uint _e76 = _naga_ceilf(asuint(_e74));
        local_6 = naga_f2u32(asfloat(_e76));
    } else {
        uint _e80 = counter;
        local_14 = _e80;
        uint _e82 = local_14;
        counter = (_e82 + uint(int(1)));
        local_15 = value_1;
        float _e87 = local_15;
        local_5 = _e87;
        float _e89 = local_5;
        const uint _e91 = _naga_ceilf(asuint(_e89));
        local_6 = naga_f2u32(asfloat(_e91));
    }
    uint _e96 = local_6;
    local_3 = uint((base + 4u));
    uint _e101 = local_3;
    output.Store(_e101*4, asuint(_e96));
    uint _e103 = counter;
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    output.Store(_e110*4, asuint(uint(int(_e103))));
    const uint _e115 = _naga_ceilf(asuint(float(16777217u)));
    local_8 = uint((base + 6u));
    uint _e122 = local_8;
    output.Store(_e122*4, asuint(naga_f2u32(asfloat(_e115))));
    local_9 = int(7);
    extra = ZeroValueint();
    extra = int(3);
    int _e130 = local_9;
    int _e131 = extra;
    local_11 = uint(asint(asuint(_e130) + asuint(_e131)));
    uint _e135 = local_11;
    local_10 = uint((base + 7u));
    uint _e140 = local_10;
    output.Store(_e140*4, asuint(_e135));
}
