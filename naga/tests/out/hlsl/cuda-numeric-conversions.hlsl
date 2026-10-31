struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer n_1 : register(b2) { type_3 n_1; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void convert(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint n = (uint)0;
    int i = (int)0;
    float offset = (float)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    float local_6 = (float)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    float local_10 = (float)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e27 = i;
    uint _e29 = n;
    if ((uint(_e27) < _e29)) {
        int _e31 = i;
        offset = float(_e31);
        uint _e36[2] = local;
        local_4 = _e36;
        int _e37 = i;
        local_5 = uint(_e37);
        uint _e41[2] = local_4;
        local_7 = _e41;
        uint _e42 = local_5;
        uint _e44 = local_7[1];
        local_7[1] = (_e44 + _e42);
        uint _e48 = local_7[0];
        local_8 = uint(_e48);
        uint _e52 = local_7[1];
        local_9 = uint(_e52);
        uint _e56 = local_9;
        float _e58 = asfloat(input.Load(_e56*4));
        local_10 = _e58;
        float _e59 = local_10;
        local_6 = _e59;
        float _e61 = local_6;
        float _e62 = offset;
        uint _e66[2] = local_1;
        local_2 = _e66;
        int _e67 = i;
        local_3 = uint(_e67);
        uint _e71[2] = local_2;
        local_11 = _e71;
        uint _e72 = local_3;
        uint _e74 = local_11[1];
        local_11[1] = (_e74 + _e72);
        uint _e78 = local_11[0];
        local_12 = uint(_e78);
        uint _e82 = local_11[1];
        local_13 = uint(_e82);
        uint _e85 = local_13;
        output.Store(_e85*4, asuint((_e61 + _e62)));
    }
}
