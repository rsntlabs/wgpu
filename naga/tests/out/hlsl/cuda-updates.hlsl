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
    int previous = (int)0;
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
    int _e10 = value_1.value;
    value = _e10;
    int _e12 = value;
    value = asint(asuint(_e12) + asuint(int(1)));
    previous = _e12;
    int _e16 = previous;
    uint _e19[2] = out_;
    local = _e19;
    local_1 = uint(threadIdx.x);
    uint _e24[2] = local;
    local_5 = _e24;
    uint _e25 = local_1;
    uint _e27 = local_5[1];
    local_5[1] = (_e27 + _e25);
    uint _e31 = local_5[0];
    local_6 = uint(_e31);
    uint _e35 = local_5[1];
    local_7 = uint(_e35);
    uint _e39 = local_7;
    int _e41 = asint(out_1.Load(_e39*4));
    local_8 = _e41;
    int _e42 = local_8;
    local_4 = _e42;
    int _e44 = local_4;
    uint _e46 = local_7;
    out_1.Store(_e46*4, asuint(asint(asuint(_e44) + asuint(_e16))));
    int _e48 = value;
    value = asint(asuint(_e48) + asuint(int(1)));
    int _e51 = value;
    uint _e53[2] = out_;
    local_2 = _e53;
    local_3 = uint(threadIdx.x);
    uint _e58[2] = local_2;
    local_9 = _e58;
    uint _e59 = local_3;
    uint _e61 = local_9[1];
    local_9[1] = (_e61 + _e59);
    uint _e65 = local_9[0];
    local_10 = uint(_e65);
    uint _e69 = local_9[1];
    local_11 = uint(_e69);
    uint _e72 = local_11;
    out_1.Store(_e72*4, asuint(_e51));
}
