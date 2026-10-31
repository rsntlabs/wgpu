struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input_1 : register(t0);
RWByteAddressBuffer output_1 : register(u1);
cbuffer n : register(b2) { type_3 n; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void convert(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
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
    uint n_1 = n.value;
    int i = int(((blockIdx.x * 1u) + threadIdx.x));
    if ((uint(i) < n_1)) {
        offset = float(i);
        uint _e28[2] = input;
        local_2 = _e28;
        local_3 = uint(i);
        uint _e32[2] = local_2;
        local_5 = _e32;
        uint _e34 = local_3;
        uint _e36 = local_5[1];
        local_5[1] = (_e36 + _e34);
        uint _e40 = local_5[0];
        local_6 = uint(_e40);
        uint _e44 = local_5[1];
        local_7 = uint(_e44);
        uint _e47 = local_7;
        float _e50 = asfloat(input_1.Load(_e47*4));
        local_8 = _e50;
        float _e52 = local_8;
        local_4 = _e52;
        float _e54 = local_4;
        float _e55 = offset;
        uint _e58[2] = output;
        local = _e58;
        local_1 = uint(i);
        uint _e62[2] = local;
        local_9 = _e62;
        uint _e64 = local_1;
        uint _e66 = local_9[1];
        local_9[1] = (_e66 + _e64);
        uint _e70 = local_9[0];
        local_10 = uint(_e70);
        uint _e74 = local_9[1];
        local_11 = uint(_e74);
        uint _e77 = local_11;
        output_1.Store(_e77*4, asuint((_e54 + _e55)));
    }
}
