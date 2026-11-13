RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int count_word(uint64_t value)
{
    return int((countbits(uint(value)) + countbits(uint((value >> 32u)))));
}

[numthreads(4, 1, 1)]
void popcounts(uint3 threadIdx : SV_GroupThreadID)
{
    uint index = threadIdx.x;
    uint64_t _e4 = input.Load<uint64_t>(index*8);
    const int _e5 = count_word(_e4);
    output.Store(index*4, asuint(_e5));
}
