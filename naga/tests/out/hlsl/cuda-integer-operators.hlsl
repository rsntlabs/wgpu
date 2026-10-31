struct type_3 {
    int value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct type_4 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer value : register(b1) { type_3 value; }
cbuffer amount : register(b2) { type_4 amount; }

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_mod(int lhs, int rhs) {
    int divisor = ((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void integer_ops(uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    uint bits = (uint)0;
    uint local = (uint)0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    int value_1 = value.value;
    uint amount_1 = amount.value;
    int remainder = naga_mod(value_1, naga_neg(int(3)));
    bits = (uint(remainder) & 15u);
    uint _e20 = bits;
    bits = (_e20 | 8u);
    uint _e23 = bits;
    bits = (_e23 ^ 1u);
    uint _e26 = bits;
    local = amount_1;
    uint _e28 = local;
    bits = (_e26 << _e28);
    uint _e30 = bits;
    bits = (_e30 >> 1u);
    uint _e33 = bits;
    bits = naga_mod(_e33, 97u);
    uint _e36 = bits;
    bits = (_e36 & 255u);
    uint _e39 = bits;
    uint _e42[2] = out_;
    local_1 = _e42;
    local_2 = uint(threadIdx.x);
    uint _e47[2] = local_1;
    local_3 = _e47;
    uint _e49 = local_2;
    uint _e51 = local_3[1];
    local_3[1] = (_e51 + _e49);
    uint _e55 = local_3[0];
    local_4 = uint(_e55);
    uint _e59 = local_3[1];
    local_5 = uint(_e59);
    uint _e62 = local_5;
    out_1.Store(_e62*4, asuint(~(_e39)));
}
