struct type_1 {
    float value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

cbuffer factor_1 : register(b0) { type_1 factor_1; }
ByteAddressBuffer input_1 : register(t1);
RWByteAddressBuffer output_1 : register(u2);

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void scale(uint3 threadIdx : SV_GroupThreadID)
{
    float factor = (float)0;
    uint input[2] = (uint[2])0;
    uint output[2] = (uint[2])0;
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

    float _e3 = factor_1.value;
    factor = _e3;
    input = ZeroValuearray2_uint_();
    input[0] = 0u;
    input[1] = 0u;
    output = ZeroValuearray2_uint_();
    output[0] = 1u;
    output[1] = 0u;
    float _e19 = factor;
    factor = (_e19 * 2.0);
    uint _e24[2] = input;
    local_2 = _e24;
    local_3 = uint(threadIdx.x);
    uint _e29[2] = local_2;
    local_5 = _e29;
    uint _e30 = local_3;
    uint _e32 = local_5[1];
    local_5[1] = (_e32 + _e30);
    uint _e36 = local_5[0];
    local_6 = uint(_e36);
    uint _e40 = local_5[1];
    local_7 = uint(_e40);
    uint _e44 = local_7;
    float _e46 = asfloat(input_1.Load(_e44*4));
    local_8 = _e46;
    float _e47 = local_8;
    local_4 = _e47;
    float _e49 = local_4;
    float _e50 = factor;
    uint _e54[2] = output;
    local = _e54;
    local_1 = uint(threadIdx.x);
    uint _e59[2] = local;
    local_9 = _e59;
    uint _e60 = local_1;
    uint _e62 = local_9[1];
    local_9[1] = (_e62 + _e60);
    uint _e66 = local_9[0];
    local_10 = uint(_e66);
    uint _e70 = local_9[1];
    local_11 = uint(_e70);
    uint _e73 = local_11;
    output_1.Store(_e73*4, asuint((_e49 * _e50)));
}
