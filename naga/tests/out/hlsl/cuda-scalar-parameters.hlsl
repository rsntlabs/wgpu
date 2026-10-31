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
    float local_2 = (float)0;
    uint local_3 = (uint)0;
    float local_4 = (float)0;
    uint local_5 = (uint)0;

    float _e3 = factor_1.value;
    factor = _e3;
    float _e5 = factor;
    factor = (_e5 * 2.0);
    local_1 = uint(threadIdx.x);
    uint _e12 = local_1;
    local_3 = uint(_e12);
    uint _e16 = local_3;
    float _e18 = asfloat(input.Load(_e16*4));
    local_4 = _e18;
    float _e19 = local_4;
    local_2 = _e19;
    float _e21 = local_2;
    float _e22 = factor;
    local = uint(threadIdx.x);
    uint _e28 = local;
    local_5 = uint(_e28);
    uint _e31 = local_5;
    output.Store(_e31*4, asuint((_e21 * _e22)));
}
