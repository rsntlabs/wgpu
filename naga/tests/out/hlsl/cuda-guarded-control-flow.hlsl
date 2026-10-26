struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer a : register(t0);
ByteAddressBuffer b : register(t1);
RWByteAddressBuffer out_ : register(u2);
cbuffer n_1 : register(b3) { type_3 n_1; }

[numthreads(1, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint n = (uint)0;
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
    uint _e10 = n_1.value;
    n = _e10;
    i = ((blockIdx.x * 1u) + threadIdx.x);
    uint _e18 = i;
    uint _e19 = n;
    if ((_e18 < _e19)) {
        uint _e21 = local;
        local_6 = _e21;
        uint _e23 = local_6;
        local_7 = uint(_e23);
        uint _e26 = i;
        local_8 = uint(_e26);
        uint _e29 = local_1;
        local_9 = _e29;
        uint _e31 = local_9;
        local_10 = uint(_e31);
        uint _e34 = i;
        local_11 = uint(_e34);
        uint _e38 = local_7;
        uint _e39 = local_8;
        local_12 = uint((_e38 + _e39));
        uint _e44 = local_12;
        float _e46 = asfloat(a.Load(_e44*4));
        local_13 = _e46;
        float _e47 = local_13;
        uint _e49 = local_10;
        uint _e50 = local_11;
        local_14 = uint((_e49 + _e50));
        uint _e55 = local_14;
        float _e57 = asfloat(b.Load(_e55*4));
        local_15 = _e57;
        float _e58 = local_15;
        uint _e60 = local_2;
        local_3 = _e60;
        uint _e62 = local_3;
        local_4 = uint(_e62);
        uint _e65 = i;
        local_5 = uint(_e65);
        uint _e69 = local_4;
        uint _e70 = local_5;
        local_16 = uint((_e69 + _e70));
        uint _e74 = local_16;
        out_.Store(_e74*4, asuint((_e47 + _e58)));
    }
}
