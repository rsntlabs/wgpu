struct type_1 {
    float value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

cbuffer factor_1 : register(b0) { type_1 factor_1; }
ByteAddressBuffer input : register(t1);
RWByteAddressBuffer output : register(u2);

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void scale(uint3 threadIdx : SV_GroupThreadID)
{
    float factor = (float)0;
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
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

    float _e3 = factor_1.value;
    factor = _e3;
    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = ZeroValuearray2_uint_();
    local_1[0] = 1u;
    local_1[1] = 0u;
    float _e19 = factor;
    factor = (_e19 * 2.0);
    uint _e24[2] = local;
    local_4 = _e24;
    local_5 = uint(threadIdx.x);
    uint _e29[2] = local_4;
    local_7 = _e29;
    uint _e30 = local_5;
    uint _e32 = local_7[1];
    local_7[1] = (_e32 + _e30);
    uint _e36 = local_7[0];
    local_8 = uint(_e36);
    uint _e40 = local_7[1];
    local_9 = uint(_e40);
    uint _e44 = local_9;
    float _e46 = asfloat(input.Load(_e44*4));
    local_10 = _e46;
    float _e47 = local_10;
    local_6 = _e47;
    float _e49 = local_6;
    float _e50 = factor;
    uint _e54[2] = local_1;
    local_2 = _e54;
    local_3 = uint(threadIdx.x);
    uint _e59[2] = local_2;
    local_11 = _e59;
    uint _e60 = local_3;
    uint _e62 = local_11[1];
    local_11[1] = (_e62 + _e60);
    uint _e66 = local_11[0];
    local_12 = uint(_e66);
    uint _e70 = local_11[1];
    local_13 = uint(_e70);
    uint _e73 = local_13;
    output.Store(_e73*4, asuint((_e49 * _e50)));
}
