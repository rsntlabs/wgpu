ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint kind(float value_2)
{
    return 1u;
}

uint _naga_nextafterf(uint from_bits, uint toward_bits)
{
    uint _e8 = (from_bits & 2147483647u);
    uint _e9 = (toward_bits & 2147483647u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e13 = (_e8 == 0u);
    if (((_e13 && (_e9 == 0u)) || (from_bits == toward_bits))) {
        return toward_bits;
    }
    if (_e13) {
        return ((toward_bits & 2147483648u) | 1u);
    }
    return ((((from_bits ^ toward_bits) < 2147483648u) && (_e9 > _e8)) ? (from_bits + 1u) : (from_bits - 1u));
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(4, 1, 1)]
void next_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    float value = (float)0;
    float value_1 = (float)0;

    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= 24u)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e16 = asuint(input.Load(0+index*8));
    float x = asfloat(_e16);
    uint _e20 = asuint(input.Load(4+index*8));
    float y = asfloat(_e20);
    counter = 0u;
    const uint _e26 = _naga_nextafterf(asuint(x), asuint(y));
    output.Store(base*4, asuint(asuint(asfloat(_e26))));
    value = ZeroValuefloat();
    value = x;
    uint _e34 = counter;
    counter = (_e34 + uint(int(1)));
    float _e38 = value;
    value_1 = ZeroValuefloat();
    value_1 = y;
    uint _e42 = counter;
    counter = (_e42 + uint(int(1)));
    float _e46 = value_1;
    const uint _e49 = _naga_nextafterf(asuint(_e38), asuint(_e46));
    local = uint((base + 1u));
    uint _e56 = local;
    output.Store(_e56*4, asuint(asuint(asfloat(_e49))));
    uint _e58 = counter;
    local_1 = uint((base + 2u));
    uint _e63 = local_1;
    output.Store(_e63*4, asuint(_e58));
    const uint _e67 = _naga_nextafterf(asuint(x), asuint(y));
    const uint _e69 = kind(asfloat(_e67));
    local_2 = uint((base + 3u));
    uint _e74 = local_2;
    output.Store(_e74*4, asuint(_e69));
}
