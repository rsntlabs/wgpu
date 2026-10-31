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

[numthreads(1, 1, 1)]
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
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    if ((i < n_1)) {
        local_1 = i;
        local_2 = i;
        uint _e13 = local_1;
        local_5 = _e13;
        uint _e15 = local_5;
        float _e18 = asfloat(a.Load(_e15*4));
        local_6 = _e18;
        float _e20 = local_6;
        local_3 = _e20;
        float _e22 = local_3;
        uint _e23 = local_2;
        local_7 = _e23;
        uint _e25 = local_7;
        float _e28 = asfloat(b.Load(_e25*4));
        local_8 = _e28;
        float _e30 = local_8;
        local_4 = _e30;
        float _e32 = local_4;
        local = i;
        uint _e35 = local;
        local_9 = _e35;
        uint _e37 = local_9;
        out_.Store(_e37*4, asuint((_e22 + _e32)));
    }
}
