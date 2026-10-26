ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);

[numthreads(64, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint i = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    float local_13 = (float)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    uint local_16 = (uint)0;

    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e14 = local;
    local_6 = _e14;
    uint _e16 = local_6;
    local_7 = uint(_e16);
    uint _e19 = i;
    local_8 = uint(_e19);
    uint _e22 = local_1;
    local_9 = _e22;
    uint _e24 = local_9;
    local_10 = uint(_e24);
    uint _e27 = i;
    local_11 = uint(_e27);
    uint _e31 = local_10;
    uint _e32 = local_11;
    local_12 = uint((_e31 + _e32));
    uint _e37 = local_12;
    float _e39 = asfloat(b.Load(_e37*4));
    local_13 = _e39;
    float _e40 = local_13;
    uint _e44 = local_7;
    uint _e45 = local_8;
    local_14 = uint((_e44 + _e45));
    uint _e50 = local_14;
    float _e52 = asfloat(a.Load(_e50*4));
    local_15 = _e52;
    float _e53 = local_15;
    uint _e55 = local_2;
    local_3 = _e55;
    uint _e57 = local_3;
    local_4 = uint(_e57);
    uint _e60 = i;
    local_5 = uint(_e60);
    uint _e64 = local_4;
    uint _e65 = local_5;
    local_16 = uint((_e64 + _e65));
    uint _e69 = local_16;
    out_.Store(_e69*4, asuint((_e53 + (_e40 * 2.0))));
}
