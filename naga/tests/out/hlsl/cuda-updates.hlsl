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
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;

    int _e3 = value_1.value;
    value = _e3;
    int previous = value;
    value = asint(asuint(previous) + asuint(int(1)));
    local = uint(threadIdx.x);
    uint _e11 = local;
    local_2 = uint(_e11);
    uint _e14 = local_2;
    int _e17 = asint(out_.Load(_e14*4));
    uint _e19 = local_2;
    out_.Store(_e19*4, asuint(asint(asuint(_e17) + asuint(previous))));
    int _e21 = value;
    value = asint(asuint(_e21) + asuint(int(1)));
    int _e24 = value;
    local_1 = uint(threadIdx.x);
    uint _e28 = local_1;
    local_3 = uint(_e28);
    uint _e31 = local_3;
    out_.Store(_e31*4, asuint(_e24));
}
