ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);

[numthreads(1, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    local_1 = uint(i);
    local_2 = uint(i);
    uint _e11 = local_2;
    local_3 = uint(_e11);
    uint _e14 = local_3;
    float _e17 = asfloat(b.Load(_e14*4));
    uint _e20 = local_1;
    local_4 = uint(_e20);
    uint _e23 = local_4;
    float _e26 = asfloat(a.Load(_e23*4));
    local = uint(i);
    uint _e30 = local;
    local_5 = uint(_e30);
    uint _e33 = local_5;
    out_.Store(_e33*4, asuint((_e26 + (_e17 * 2.0))));
}
