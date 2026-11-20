struct type_4 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_4 count; }

uint kind(int value_1)
{
    return 2u;
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
    output.Store(base*4, asuint(uint((((_e23 == 0u) || (_e23 > 2139095040u)) ? int(-2147483647 - 1) : ((_e23 == 2139095040u) ? int(2147483647) : ((_e25 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e23))))) : asint(asuint(int(_e25)) - asuint(int(127)))))))));
    value = ZeroValuefloat();
    value = value_2;
    uint _e51 = counter;
    counter = (_e51 + uint(int(1)));
    float _e55 = value;
    uint _e58 = (asuint(_e55) & 2147483647u);
    uint _e60 = (_e58 >> 23u);
    local = uint((base + 1u));
    uint _e85 = local;
    output.Store(_e85*4, asuint(uint((((_e58 == 0u) || (_e58 > 2139095040u)) ? int(-2147483647 - 1) : ((_e58 == 2139095040u) ? int(2147483647) : ((_e60 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e58))))) : asint(asuint(int(_e60)) - asuint(int(127)))))))));
    uint _e87 = counter;
    local_1 = uint((base + 2u));
    uint _e92 = local_1;
    output.Store(_e92*4, asuint(_e87));
    uint _e96 = (asuint(value_2) & 2147483647u);
    uint _e98 = (_e96 >> 23u);
    const uint _e118 = kind((((_e96 == 0u) || (_e96 > 2139095040u)) ? int(-2147483647 - 1) : ((_e96 == 2139095040u) ? int(2147483647) : ((_e98 == 0u) ? asint(asuint(int(-118)) - asuint(int((31u - firstbithigh(_e96))))) : asint(asuint(int(_e98)) - asuint(int(127)))))));
    local_2 = uint((base + 3u));
    uint _e123 = local_2;
    output.Store(_e123*4, asuint(_e118));
}
