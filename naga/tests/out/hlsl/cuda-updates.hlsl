struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer value_1 : register(b1) { type_3 value_1; }

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void updates(uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    int local_4 = (int)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int local_8 = (int)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    int _e9 = value_1.value;
    value = _e9;
    int previous = value;
    value = asint(asuint(previous) + asuint(int(1)));
    uint _e15[2] = out_;
    local = _e15;
    local_1 = uint(threadIdx.x);
    uint _e20[2] = local;
    local_5 = _e20;
    uint _e22 = local_1;
    uint _e24 = local_5[1];
    local_5[1] = (_e24 + _e22);
    uint _e28 = local_5[0];
    local_6 = uint(_e28);
    uint _e32 = local_5[1];
    local_7 = uint(_e32);
    uint _e35 = local_7;
    int _e38 = asint(out_1.Load(_e35*4));
    local_8 = _e38;
    int _e40 = local_8;
    local_4 = _e40;
    int _e42 = local_4;
    uint _e44 = local_7;
    out_1.Store(_e44*4, asuint(asint(asuint(_e42) + asuint(previous))));
    int _e46 = value;
    value = asint(asuint(_e46) + asuint(int(1)));
    int _e49 = value;
    uint _e50[2] = out_;
    local_2 = _e50;
    local_3 = uint(threadIdx.x);
    uint _e55[2] = local_2;
    local_9 = _e55;
    uint _e57 = local_3;
    uint _e59 = local_9[1];
    local_9[1] = (_e59 + _e57);
    uint _e63 = local_9[0];
    local_10 = uint(_e63);
    uint _e67 = local_9[1];
    local_11 = uint(_e67);
    uint _e70 = local_11;
    out_1.Store(_e70*4, asuint(_e49));
}
