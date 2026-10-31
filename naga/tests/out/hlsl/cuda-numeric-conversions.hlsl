struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input_1 : register(t0);
RWByteAddressBuffer output_1 : register(u1);
cbuffer n_1 : register(b2) { type_3 n_1; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void convert(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
    uint n = (uint)0;
    int i = (int)0;
    float offset = (float)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    float local_4 = (float)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    float local_8 = (float)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;

    input = ZeroValuearray2_uint_();
    input[0] = 0u;
    input[1] = 0u;
    output = ZeroValuearray2_uint_();
    output[0] = 1u;
    output[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e27 = i;
    uint _e29 = n;
    if ((uint(_e27) < _e29)) {
        int _e31 = i;
        offset = float(_e31);
        uint _e36[2] = input;
        local_2 = _e36;
        int _e37 = i;
        local_3 = uint(_e37);
        uint _e41[2] = local_2;
        local_5 = _e41;
        uint _e42 = local_3;
        uint _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        uint _e48 = local_5[0];
        local_6 = uint(_e48);
        uint _e52 = local_5[1];
        local_7 = uint(_e52);
        uint _e56 = local_7;
        float _e58 = asfloat(input_1.Load(_e56*4));
        local_8 = _e58;
        float _e59 = local_8;
        local_4 = _e59;
        float _e61 = local_4;
        float _e62 = offset;
        uint _e66[2] = output;
        local = _e66;
        int _e67 = i;
        local_1 = uint(_e67);
        uint _e71[2] = local;
        local_9 = _e71;
        uint _e72 = local_1;
        uint _e74 = local_9[1];
        local_9[1] = (_e74 + _e72);
        uint _e78 = local_9[0];
        local_10 = uint(_e78);
        uint _e82 = local_9[1];
        local_11 = uint(_e82);
        uint _e85 = local_11;
        output_1.Store(_e85*4, asuint((_e61 + _e62)));
    }
}
