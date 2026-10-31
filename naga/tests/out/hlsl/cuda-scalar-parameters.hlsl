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

    float _e3 = factor_1.value;
    factor = _e3;
    float _e5 = factor;
    factor = (_e5 * 2.0);
    local_1 = uint(threadIdx.x);
    uint _e11 = local_1;
    local_2 = uint(_e11);
    uint _e14 = local_2;
    float _e17 = asfloat(input.Load(_e14*4));
    float _e18 = factor;
    local = uint(threadIdx.x);
    uint _e23 = local;
    local_3 = uint(_e23);
    uint _e26 = local_3;
    output.Store(_e26*4, asuint((_e17 * _e18)));
}
