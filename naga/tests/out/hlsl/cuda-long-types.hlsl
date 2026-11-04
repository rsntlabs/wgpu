struct type_4 {
    uint64_t value;
    int _end_pad_0;
    int _end_pad_1;
};

struct type_5 {
    int64_t value;
    int _end_pad_0;
    int _end_pad_1;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_4 count; }
cbuffer bias : register(b3) { type_5 bias; }

uint kind(int64_t value)
{
    return 3u;
}

uint kind_1(int64_t value_1)
{
    return 5u;
}

int64_t identity_long(int64_t value_2)
{
    return value_2;
}

[numthreads(64, 1, 1)]
void long_types(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint64_t count_1 = count.value;
    int64_t bias_1 = bias.value;
    uint index = ((blockIdx.x * 64u) + threadIdx.x);
    if ((uint64_t(index) >= count_1)) {
        return;
    }
    int64_t _e17 = input.Load<int64_t>(index*8);
    const int64_t _e19 = identity_long((_e17 + bias_1));
    const uint _e20 = kind(_e19);
    const uint _e23 = kind_1(_e19);
    uint tags = ((_e20 * 10u) + _e23);
    output.Store(index*8, (uint64_t((_e19 + 1L)) + uint64_t(tags)));
}
