struct type_1 {
    uint64_t value;
    int _end_pad_0;
    int _end_pad_1;
};

RWByteAddressBuffer output : register(u0);
cbuffer base : register(b1) { type_1 base; }

uint64_t byte_count_float3_()
{
    return 12uL;
}

[numthreads(64, 1, 1)]
void type_queries(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint64_t base_1 = base.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    const uint64_t _e10 = byte_count_float3_();
    output.Store(index*8, ((((base_1 + _e10) + 24uL) * 8uL) + 8uL));
}
