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

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint local_2[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    float local_9 = (float)0;
    float local_10 = (float)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    float local_14 = (float)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    float local_18 = (float)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    local_2 = ZeroValuearray2_uint_();
    local_2[0] = 2u;
    local_2[1] = 0u;
    uint _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e33 = i;
    uint _e34 = n;
    if ((_e33 < _e34)) {
        uint _e38[2] = local;
        local_5 = _e38;
        uint _e39 = i;
        local_6 = uint(_e39);
        uint _e44[2] = local_1;
        local_7 = _e44;
        uint _e45 = i;
        local_8 = uint(_e45);
        uint _e49[2] = local_7;
        local_11 = _e49;
        uint _e50 = local_8;
        uint _e52 = local_11[1];
        local_11[1] = (_e52 + _e50);
        uint _e56 = local_11[0];
        local_12 = uint(_e56);
        uint _e60 = local_11[1];
        local_13 = uint(_e60);
        uint _e64 = local_13;
        float _e66 = asfloat(b.Load(_e64*4));
        local_14 = _e66;
        float _e67 = local_14;
        local_9 = _e67;
        float _e69 = local_9;
        uint _e73[2] = local_5;
        local_15 = _e73;
        uint _e74 = local_6;
        uint _e76 = local_15[1];
        local_15[1] = (_e76 + _e74);
        uint _e80 = local_15[0];
        local_16 = uint(_e80);
        uint _e84 = local_15[1];
        local_17 = uint(_e84);
        uint _e88 = local_17;
        float _e90 = asfloat(a.Load(_e88*4));
        local_18 = _e90;
        float _e91 = local_18;
        local_10 = _e91;
        float _e93 = local_10;
        uint _e97[2] = local_2;
        local_3 = _e97;
        uint _e98 = i;
        local_4 = uint(_e98);
        uint _e102[2] = local_3;
        local_19 = _e102;
        uint _e103 = local_4;
        uint _e105 = local_19[1];
        local_19[1] = (_e105 + _e103);
        uint _e109 = local_19[0];
        local_20 = uint(_e109);
        uint _e113 = local_19[1];
        local_21 = uint(_e113);
        uint _e116 = local_21;
        out_.Store(_e116*4, asuint((_e93 + (_e69 * 2.0))));
    }
}
