struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_5 count; }

float forward(float value)
{
    return value;
}

int ZeroValueint() {
    return (int)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
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
    int local_6 = (int)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int local_9 = (int)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
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
    output.Store(base*4, asuint(naga_f2i32(value_1)));
    const float _e24 = forward(value_1);
    local = uint((base + 1u));
    uint _e30 = local;
    output.Store(_e30*4, asuint(naga_f2i32(_e24)));
    uint _e32 = counter;
    counter = (_e32 + uint(int(1)));
    local_1 = uint((base + 2u));
    uint _e41 = local_1;
    output.Store(_e41*4, asuint(naga_f2i32(value_1)));
    uint _e43 = counter;
    local_2 = uint((base + 3u));
    uint _e49 = local_2;
    output.Store(_e49*4, asuint(int(_e43)));
    if (((index & 1u) != 0u)) {
        uint _e55 = counter;
        local_12 = _e55;
        uint _e57 = local_12;
        counter = (_e57 + uint(int(1)));
        local_13 = value_1;
        float _e62 = local_13;
        local_4 = _e62;
        float _e64 = local_4;
        local_6 = naga_f2i32(_e64);
    } else {
        uint _e67 = counter;
        local_14 = _e67;
        uint _e69 = local_14;
        counter = (_e69 + uint(int(1)));
        local_15 = value_1;
        float _e74 = local_15;
        local_5 = _e74;
        float _e76 = local_5;
        local_6 = naga_f2i32(_e76);
    }
    int _e80 = local_6;
    local_3 = uint((base + 4u));
    uint _e85 = local_3;
    output.Store(_e85*4, asuint(_e80));
    uint _e87 = counter;
    local_7 = uint((base + 5u));
    uint _e93 = local_7;
    output.Store(_e93*4, asuint(int(_e87)));
    local_8 = uint((base + 6u));
    uint _e102 = local_8;
    output.Store(_e102*4, asuint(naga_f2i32(float(int(16777217)))));
    local_9 = int(7);
    extra = ZeroValueint();
    extra = int(3);
    int _e110 = local_9;
    int _e111 = extra;
    local_11 = asint(asuint(_e110) + asuint(_e111));
    int _e114 = local_11;
    local_10 = uint((base + 7u));
    uint _e119 = local_10;
    output.Store(_e119*4, asuint(_e114));
}
