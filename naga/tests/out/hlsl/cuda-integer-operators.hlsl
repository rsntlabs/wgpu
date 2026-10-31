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
cbuffer value_1 : register(b1) { type_3 value_1; }
cbuffer amount_1 : register(b2) { type_4 amount_1; }

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
    int value = (int)0;
    uint amount = (uint)0;
    int remainder = (int)0;
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
    int _e10 = value_1.value;
    value = _e10;
    uint _e14 = amount_1.value;
    amount = _e14;
    int _e18 = value;
    remainder = naga_mod(_e18, naga_neg(int(3)));
    int _e21 = remainder;
    bits = (uint(_e21) & 15u);
    uint _e26 = bits;
    bits = (_e26 | 8u);
    uint _e29 = bits;
    bits = (_e29 ^ 1u);
    uint _e32 = amount;
    uint _e33 = bits;
    local = _e32;
    uint _e35 = local;
    bits = (_e33 << _e35);
    uint _e37 = bits;
    bits = (_e37 >> 1u);
    uint _e40 = bits;
    bits = naga_mod(_e40, 97u);
    uint _e43 = bits;
    bits = (_e43 & 255u);
    uint _e46 = bits;
    uint _e50[2] = out_;
    local_1 = _e50;
    local_2 = uint(threadIdx.x);
    uint _e55[2] = local_1;
    local_3 = _e55;
    uint _e56 = local_2;
    uint _e58 = local_3[1];
    local_3[1] = (_e58 + _e56);
    uint _e62 = local_3[0];
    local_4 = uint(_e62);
    uint _e66 = local_3[1];
    local_5 = uint(_e66);
    uint _e69 = local_5;
    out_1.Store(_e69*4, asuint(~(_e46)));
}
