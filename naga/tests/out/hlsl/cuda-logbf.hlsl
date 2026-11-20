struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_3 count; }

uint kind(float value_1)
{
    return 1u;
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(4, 1, 1)]
void exponent_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    float value = (float)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e17 = asuint(input.Load(index*4));
    float value_2 = asfloat(_e17);
    counter = 0u;
    uint _e23 = (asuint(value_2) & 2147483647u);
    uint _e25 = (_e23 >> 23u);
    bool _e38 = (_e23 > 2139095040u);
    local = (((_e23 == 0u) || _e38) ? (_e38 ? 2143289344u : 4286578688u) : ((_e23 == 2139095040u) ? 2139095040u : asuint(float(((_e25 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e23))))) : asint(asuint(int(_e25)) - asuint(int(127))))))));
    uint _e50 = local;
    output.Store(base*4, asuint(asuint(asfloat(_e50))));
    value = ZeroValuefloat();
    value = value_2;
    uint _e58 = counter;
    counter = (_e58 + uint(int(1)));
    float _e62 = value;
    uint _e65 = (asuint(_e62) & 2147483647u);
    uint _e67 = (_e65 >> 23u);
    bool _e80 = (_e65 > 2139095040u);
    local_2 = (((_e65 == 0u) || _e80) ? (_e80 ? 2143289344u : 4286578688u) : ((_e65 == 2139095040u) ? 2139095040u : asuint(float(((_e67 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e65))))) : asint(asuint(int(_e67)) - asuint(int(127))))))));
    uint _e92 = local_2;
    local_1 = uint((base + 1u));
    uint _e99 = local_1;
    output.Store(_e99*4, asuint(asuint(asfloat(_e92))));
    uint _e101 = counter;
    local_3 = uint((base + 2u));
    uint _e106 = local_3;
    output.Store(_e106*4, asuint(_e101));
    uint _e110 = (asuint(value_2) & 2147483647u);
    uint _e112 = (_e110 >> 23u);
    bool _e125 = (_e110 > 2139095040u);
    local_5 = (((_e110 == 0u) || _e125) ? (_e125 ? 2143289344u : 4286578688u) : ((_e110 == 2139095040u) ? 2139095040u : asuint(float(((_e112 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e110))))) : asint(asuint(int(_e112)) - asuint(int(127))))))));
    uint _e137 = local_5;
    const uint _e139 = kind(asfloat(_e137));
    local_4 = uint((base + 3u));
    uint _e144 = local_4;
    output.Store(_e144*4, asuint(_e139));
}
