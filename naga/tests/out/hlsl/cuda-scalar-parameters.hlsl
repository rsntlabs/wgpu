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

    float _e3 = factor_1.value;
    factor = _e3;
    float _e5 = factor;
    factor = (_e5 * 2.0);
    local_1 = uint(threadIdx.x);
    uint _e11 = local_1;
    float _e14 = asfloat(input.Load(_e11*4));
    float _e15 = factor;
    local = uint(threadIdx.x);
    uint _e20 = local;
    output.Store(_e20*4, asuint((_e14 * _e15)));
}
