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
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    uint local_16 = (uint)0;
    float local_17 = (float)0;
    int extra = (int)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint _e17 = asuint(input.Load(index*4));
    float value_1 = asfloat(_e17);
    counter = 0u;
    output.Store(base*4, asuint(naga_f2u32(value_1)));
    const float _e24 = forward(value_1);
    local = uint((base + 1u));
    uint _e30 = local;
    output.Store(_e30*4, asuint(naga_f2u32(_e24)));
    uint _e32 = counter;
    counter = (_e32 + uint(int(1)));
    local_1 = uint((base + 2u));
    uint _e41 = local_1;
    output.Store(_e41*4, asuint(naga_f2u32(value_1)));
    uint _e43 = counter;
    local_2 = uint((base + 3u));
    uint _e48 = local_2;
    output.Store(_e48*4, asuint(_e43));
    if (((index & 1u) != 0u)) {
        uint _e54 = counter;
        local_14 = _e54;
        uint _e56 = local_14;
        counter = (_e56 + uint(int(1)));
        local_15 = value_1;
        float _e61 = local_15;
        local_4 = _e61;
        float _e63 = local_4;
        local_6 = naga_f2u32(_e63);
    } else {
        uint _e66 = counter;
        local_16 = _e66;
        uint _e68 = local_16;
        counter = (_e68 + uint(int(1)));
        local_17 = value_1;
        float _e73 = local_17;
        local_5 = _e73;
        float _e75 = local_5;
        local_6 = naga_f2u32(_e75);
    }
    uint _e79 = local_6;
    local_3 = uint((base + 4u));
    uint _e84 = local_3;
    output.Store(_e84*4, asuint(_e79));
    uint _e86 = counter;
    local_7 = uint((base + 5u));
    uint _e91 = local_7;
    output.Store(_e91*4, asuint(_e86));
    local_8 = uint((base + 6u));
    uint _e100 = local_8;
    output.Store(_e100*4, asuint(naga_f2u32(float(16777217u))));
    local_9 = uint((base + 7u));
    uint _e109 = local_9;
    output.Store(_e109*4, asuint(naga_f2u32(float(2147483649u))));
    local_10 = uint((base + 8u));
    uint _e118 = local_10;
    output.Store(_e118*4, asuint(naga_f2u32(float(true))));
    local_11 = int(7);
    extra = ZeroValueint();
    extra = int(3);
    int _e126 = local_11;
    int _e127 = extra;
    local_13 = uint(asint(asuint(_e126) + asuint(_e127)));
    uint _e131 = local_13;
    local_12 = uint((base + 9u));
    uint _e136 = local_12;
    output.Store(_e136*4, asuint(_e131));
}
