struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer count : register(b2) { type_3 count; }

uint64_t reverse_word(uint64_t value)
{
    return ((uint64_t(reversebits(uint(value))) << 32u) | uint64_t(reversebits(uint((value >> 32u)))));
}

[numthreads(64, 1, 1)]
void reverse_words(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;

    uint count_1 = count.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    uint64_t _e13 = input.Load<uint64_t>(index*8);
    const uint64_t _e14 = reverse_word(_e13);
    local = uint((index + 4u));
    uint _e19 = local;
    output.Store(_e19*8, _e14);
}
