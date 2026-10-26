struct type_1 {
    float value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

cbuffer factor_1 : register(b0) { type_1 factor_1; }
ByteAddressBuffer input : register(t1);
RWByteAddressBuffer output : register(u2);

[numthreads(1, 1, 1)]
void scale(uint3 threadIdx : SV_GroupThreadID)
{
    float factor = (float)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    float local_9 = (float)0;
    uint local_10 = (uint)0;

    float _e3 = factor_1.value;
    factor = _e3;
    local = 0u;
    local_1 = 0u;
    float _e9 = factor;
    factor = (_e9 * 2.0);
    uint _e12 = local;
    local_5 = _e12;
    uint _e14 = local_5;
    local_6 = uint(_e14);
    local_7 = uint(threadIdx.x);
    uint _e21 = local_6;
    uint _e22 = local_7;
    local_8 = uint((_e21 + _e22));
    uint _e27 = local_8;
    float _e29 = asfloat(input.Load(_e27*4));
    local_9 = _e29;
    float _e30 = local_9;
    float _e31 = factor;
    uint _e33 = local_1;
    local_2 = _e33;
    uint _e35 = local_2;
    local_3 = uint(_e35);
    local_4 = uint(threadIdx.x);
    uint _e42 = local_3;
    uint _e43 = local_4;
    local_10 = uint((_e42 + _e43));
    uint _e47 = local_10;
    output.Store(_e47*4, asuint((_e30 * _e31)));
}
