struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer n_1 : register(b2) { type_3 n_1; }

[numthreads(1, 1, 1)]
void convert(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint n = (uint)0;
    int i = (int)0;
    float offset = (float)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    float local_9 = (float)0;
    uint local_10 = (uint)0;

    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e17 = i;
    uint _e19 = n;
    if ((uint(_e17) < _e19)) {
        int _e21 = i;
        offset = float(_e21);
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        local_6 = uint(_e26);
        int _e29 = i;
        local_7 = uint(_e29);
        uint _e33 = local_6;
        uint _e34 = local_7;
        local_8 = uint((_e33 + _e34));
        uint _e39 = local_8;
        float _e41 = asfloat(input.Load(_e39*4));
        local_9 = _e41;
        float _e42 = local_9;
        float _e43 = offset;
        uint _e45 = local_1;
        local_2 = _e45;
        uint _e47 = local_2;
        local_3 = uint(_e47);
        int _e50 = i;
        local_4 = uint(_e50);
        uint _e54 = local_3;
        uint _e55 = local_4;
        local_10 = uint((_e54 + _e55));
        uint _e59 = local_10;
        output.Store(_e59*4, asuint((_e42 + _e43)));
    }
}
