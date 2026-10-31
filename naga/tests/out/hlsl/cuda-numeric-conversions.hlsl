struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer n : register(b2) { type_3 n; }

[numthreads(1, 1, 1)]
void convert(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    float offset = (float)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    float local_2 = (float)0;
    uint local_3 = (uint)0;
    float local_4 = (float)0;
    uint local_5 = (uint)0;

    uint n_1 = n.value;
    int i = int(((blockIdx.x * 1u) + threadIdx.x));
    if ((uint(i) < n_1)) {
        offset = float(i);
        local_1 = uint(i);
        uint _e17 = local_1;
        local_3 = _e17;
        uint _e19 = local_3;
        float _e22 = asfloat(input.Load(_e19*4));
        local_4 = _e22;
        float _e24 = local_4;
        local_2 = _e24;
        float _e26 = local_2;
        float _e27 = offset;
        local = uint(i);
        uint _e31 = local;
        local_5 = _e31;
        uint _e33 = local_5;
        output.Store(_e33*4, asuint((_e26 + _e27)));
    }
}
