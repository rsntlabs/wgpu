struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer count : register(b2) { type_3 count; }
RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer count_1 : register(b2) { type_3 count_1; }

uint copied_unsigned(uint value)
{
    return value;
}

float copied_float(float value_1)
{
    return value_1;
}

[numthreads(4, 1, 1)]
void copy_typed_unsigned(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    uint count_2 = count.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index < count_2)) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        uint _e17 = asuint(input.Load(_e14*4));
        local_4 = _e17;
        uint _e19 = local_4;
        local_2 = _e19;
        uint _e21 = local_2;
        const uint _e22 = copied_unsigned(_e21);
        local = index;
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        output.Store(_e26*4, asuint(_e22));
    }
}

[numthreads(4, 1, 1)]
void copy_typed_float(uint3 blockIdx_1 : SV_GroupID, uint3 threadIdx_1 : SV_GroupThreadID)
{
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    float local_8 = (float)0;
    uint local_9 = (uint)0;
    float local_10 = (float)0;
    uint local_11 = (uint)0;

    uint count_3 = count_1.value;
    uint index_1 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if ((index_1 < count_3)) {
        local_7 = index_1;
        uint _e12 = local_7;
        local_9 = _e12;
        uint _e14 = local_9;
        float _e17 = asfloat(input_1.Load(_e14*4));
        local_10 = _e17;
        float _e19 = local_10;
        local_8 = _e19;
        float _e21 = local_8;
        const float _e22 = copied_float(_e21);
        local_6 = index_1;
        uint _e24 = local_6;
        local_11 = _e24;
        uint _e26 = local_11;
        output_1.Store(_e26*4, asuint(_e22));
    }
}
