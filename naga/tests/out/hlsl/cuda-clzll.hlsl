struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer count : register(b2) { type_5 count; }

int leading_word(int64_t value)
{
    uint _e4 = uint((value >> 32u));
    return int(((_e4 != 0u) ? (31u - firstbithigh(_e4)) : (32u + (31u - firstbithigh(uint(value))))));
}

[numthreads(64, 1, 1)]
void leading_zero_counts(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;

    uint count_1 = count.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    int64_t _e13 = input.Load<int64_t>(index*8);
    const int _e14 = leading_word(_e13);
    local = uint((index + 4u));
    uint _e19 = local;
    output.Store(_e19*4, asuint(_e14));
}
