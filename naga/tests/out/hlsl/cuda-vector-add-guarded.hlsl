struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer a_1 : register(t0);
ByteAddressBuffer b_1 : register(t1);
RWByteAddressBuffer out_1 : register(u2);
cbuffer n_1 : register(b3) { type_3 n_1; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint a[2] = (uint[2])0;
    uint b[2] = (uint[2])0;
    uint out_[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    float local_6 = (float)0;
    float local_7 = (float)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    float local_11 = (float)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;

    a = ZeroValuearray2_uint_();
    a[0] = 0u;
    a[1] = 0u;
    b = ZeroValuearray2_uint_();
    b[0] = 1u;
    b[1] = 0u;
    out_ = ZeroValuearray2_uint_();
    out_[0] = 2u;
    out_[1] = 0u;
    uint _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e33 = i;
    uint _e34 = n;
    if ((_e33 < _e34)) {
        uint _e38[2] = a;
        local_2 = _e38;
        uint _e39 = i;
        local_3 = uint(_e39);
        uint _e44[2] = b;
        local_4 = _e44;
        uint _e45 = i;
        local_5 = uint(_e45);
        uint _e49[2] = local_4;
        local_8 = _e49;
        uint _e50 = local_5;
        uint _e52 = local_8[1];
        local_8[1] = (_e52 + _e50);
        uint _e56 = local_8[0];
        local_9 = uint(_e56);
        uint _e60 = local_8[1];
        local_10 = uint(_e60);
        uint _e64 = local_10;
        float _e66 = asfloat(b_1.Load(_e64*4));
        local_11 = _e66;
        float _e67 = local_11;
        local_6 = _e67;
        float _e69 = local_6;
        uint _e73[2] = local_2;
        local_12 = _e73;
        uint _e74 = local_3;
        uint _e76 = local_12[1];
        local_12[1] = (_e76 + _e74);
        uint _e80 = local_12[0];
        local_13 = uint(_e80);
        uint _e84 = local_12[1];
        local_14 = uint(_e84);
        uint _e88 = local_14;
        float _e90 = asfloat(a_1.Load(_e88*4));
        local_15 = _e90;
        float _e91 = local_15;
        local_7 = _e91;
        float _e93 = local_7;
        uint _e97[2] = out_;
        local = _e97;
        uint _e98 = i;
        local_1 = uint(_e98);
        uint _e102[2] = local;
        local_16 = _e102;
        uint _e103 = local_1;
        uint _e105 = local_16[1];
        local_16[1] = (_e105 + _e103);
        uint _e109 = local_16[0];
        local_17 = uint(_e109);
        uint _e113 = local_16[1];
        local_18 = uint(_e113);
        uint _e116 = local_18;
        out_1.Store(_e116*4, asuint((_e93 + (_e69 * 2.0))));
    }
}
