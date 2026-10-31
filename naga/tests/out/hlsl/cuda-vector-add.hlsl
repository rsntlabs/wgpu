ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);

[numthreads(64, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    float local_3 = (float)0;
    float local_4 = (float)0;
    uint local_5 = (uint)0;
    float local_6 = (float)0;
    uint local_7 = (uint)0;
    float local_8 = (float)0;
    uint local_9 = (uint)0;

    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    local_1 = uint(i);
    local_2 = uint(i);
    uint _e11 = local_2;
    local_5 = uint(_e11);
    uint _e14 = local_5;
    float _e17 = asfloat(b.Load(_e14*4));
    local_6 = _e17;
    float _e19 = local_6;
    local_3 = _e19;
    float _e21 = local_3;
    uint _e24 = local_1;
    local_7 = uint(_e24);
    uint _e27 = local_7;
    float _e30 = asfloat(a.Load(_e27*4));
    local_8 = _e30;
    float _e32 = local_8;
    local_4 = _e32;
    float _e34 = local_4;
    local = uint(i);
    uint _e38 = local;
    local_9 = uint(_e38);
    uint _e41 = local_9;
    out_.Store(_e41*4, asuint((_e34 + (_e21 * 2.0))));
}
