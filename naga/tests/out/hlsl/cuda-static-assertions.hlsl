static const uint Count = 4u;

RWByteAddressBuffer output : register(u0);

uint verified_unsigned_4u(uint value)
{
    return value;
}

[numthreads(4, 1, 1)]
void assertions(uint3 threadIdx : SV_GroupThreadID)
{
    uint VectorBytes = (uint)0;
    uint local = (uint)0;

    VectorBytes = 12u;
    const uint _e6 = verified_unsigned_4u((threadIdx.x + 7u));
    local = uint(threadIdx.x);
    uint _e10 = local;
    output.Store(_e10*4, asuint(_e6));
}
