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
    int value = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;

    int _e3 = value_1.value;
    value = _e3;
    int previous = value;
    value = asint(asuint(previous) + asuint(int(1)));
    local = uint(threadIdx.x);
    uint _e11 = local;
    int _e14 = asint(out_.Load(_e11*4));
    out_.Store(_e11*4, asuint(asint(asuint(_e14) + asuint(previous))));
    int _e17 = value;
    value = asint(asuint(_e17) + asuint(int(1)));
    int _e20 = value;
    local_1 = uint(threadIdx.x);
    uint _e24 = local_1;
    out_.Store(_e24*4, asuint(_e20));
}
