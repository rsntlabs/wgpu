struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer value_1 : register(b1) { type_3 value_1; }

[numthreads(1, 1, 1)]
void updates(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    int value = (int)0;
    int previous = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int local_8 = (int)0;
    uint local_9 = (uint)0;

    local = 0u;
    int _e5 = value_1.value;
    value = _e5;
    int _e7 = value;
    value = asint(asuint(_e7) + asuint(int(1)));
    previous = _e7;
    int _e11 = previous;
    uint _e12 = local;
    local_1 = _e12;
    uint _e14 = local_1;
    local_2 = uint(_e14);
    local_3 = uint(threadIdx.x);
    uint _e21 = local_2;
    uint _e22 = local_3;
    local_7 = uint((_e21 + _e22));
    uint _e27 = local_7;
    int _e29 = asint(out_.Load(_e27*4));
    local_8 = _e29;
    int _e30 = local_8;
    uint _e32 = local_7;
    out_.Store(_e32*4, asuint(asint(asuint(_e30) + asuint(_e11))));
    int _e34 = value;
    value = asint(asuint(_e34) + asuint(int(1)));
    int _e37 = value;
    uint _e38 = local;
    local_4 = _e38;
    uint _e40 = local_4;
    local_5 = uint(_e40);
    local_6 = uint(threadIdx.x);
    uint _e46 = local_5;
    uint _e47 = local_6;
    local_9 = uint((_e46 + _e47));
    uint _e51 = local_9;
    out_.Store(_e51*4, asuint(_e37));
}
