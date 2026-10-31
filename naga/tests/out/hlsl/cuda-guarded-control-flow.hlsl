struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer a_1 : register(t0);
ByteAddressBuffer b_1 : register(t1);
RWByteAddressBuffer out_1 : register(u2);
cbuffer n : register(b3) { type_3 n; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint a[2] = (uint[2])0;
    uint b[2] = (uint[2])0;
    uint out_[2] = (uint[2])0;
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
    uint n_1 = n.value;
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    if ((i < n_1)) {
        uint _e30[2] = a;
        local_2 = _e30;
        local_3 = uint(i);
        uint _e35[2] = b;
        local_4 = _e35;
        local_5 = uint(i);
        uint _e39[2] = local_2;
        local_8 = _e39;
        uint _e41 = local_3;
        uint _e43 = local_8[1];
        local_8[1] = (_e43 + _e41);
        uint _e47 = local_8[0];
        local_9 = uint(_e47);
        uint _e51 = local_8[1];
        local_10 = uint(_e51);
        uint _e54 = local_10;
        float _e57 = asfloat(a_1.Load(_e54*4));
        local_11 = _e57;
        float _e59 = local_11;
        local_6 = _e59;
        float _e61 = local_6;
        uint _e62[2] = local_4;
        local_12 = _e62;
        uint _e64 = local_5;
        uint _e66 = local_12[1];
        local_12[1] = (_e66 + _e64);
        uint _e70 = local_12[0];
        local_13 = uint(_e70);
        uint _e74 = local_12[1];
        local_14 = uint(_e74);
        uint _e77 = local_14;
        float _e80 = asfloat(b_1.Load(_e77*4));
        local_15 = _e80;
        float _e82 = local_15;
        local_7 = _e82;
        float _e84 = local_7;
        uint _e87[2] = out_;
        local = _e87;
        local_1 = uint(i);
        uint _e91[2] = local;
        local_16 = _e91;
        uint _e93 = local_1;
        uint _e95 = local_16[1];
        local_16[1] = (_e95 + _e93);
        uint _e99 = local_16[0];
        local_17 = uint(_e99);
        uint _e103 = local_16[1];
        local_18 = uint(_e103);
        uint _e106 = local_18;
        out_1.Store(_e106*4, asuint((_e61 + _e84)));
    }
}
