struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);
cbuffer n : register(b3) { type_3 n; }

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

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        local_1 = uint(i);
        local_2 = uint(i);
        uint _e15 = local_2;
        local_5 = uint(_e15);
        uint _e18 = local_5;
        float _e21 = asfloat(b.Load(_e18*4));
        local_6 = _e21;
        float _e23 = local_6;
        local_3 = _e23;
        float _e25 = local_3;
        uint _e28 = local_1;
        local_7 = uint(_e28);
        uint _e31 = local_7;
        float _e34 = asfloat(a.Load(_e31*4));
        local_8 = _e34;
        float _e36 = local_8;
        local_4 = _e36;
        float _e38 = local_4;
        local = uint(i);
        uint _e42 = local;
        local_9 = uint(_e42);
        uint _e45 = local_9;
        out_.Store(_e45*4, asuint((_e38 + (_e25 * 2.0))));
    }
}
