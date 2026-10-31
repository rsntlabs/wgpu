ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);

[numthreads(1, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    float _e9 = asfloat(b.Load(i*4));
    float _e14 = asfloat(a.Load(i*4));
    out_.Store(i*4, asuint((_e14 + (_e9 * 2.0))));
}
