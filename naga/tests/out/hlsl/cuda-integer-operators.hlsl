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

RWByteAddressBuffer out_ : register(u0);
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

[numthreads(1, 1, 1)]
void integer_ops(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    int value = (int)0;
    uint amount = (uint)0;
    int remainder = (int)0;
    uint bits = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    local = 0u;
    int _e5 = value_1.value;
    value = _e5;
    uint _e9 = amount_1.value;
    amount = _e9;
    int _e13 = value;
    remainder = naga_mod(_e13, naga_neg(int(3)));
    int _e16 = remainder;
    bits = (uint(_e16) & 15u);
    uint _e21 = bits;
    bits = (_e21 | 8u);
    uint _e24 = bits;
    bits = (_e24 ^ 1u);
    uint _e27 = amount;
    uint _e28 = bits;
    local_1 = _e27;
    uint _e30 = local_1;
    bits = (_e28 << _e30);
    uint _e32 = bits;
    bits = (_e32 >> 1u);
    uint _e35 = bits;
    bits = naga_mod(_e35, 97u);
    uint _e38 = bits;
    bits = (_e38 & 255u);
    uint _e41 = bits;
    uint _e43 = local;
    local_2 = _e43;
    uint _e45 = local_2;
    local_3 = uint(_e45);
    local_4 = uint(threadIdx.x);
    uint _e52 = local_3;
    uint _e53 = local_4;
    local_5 = uint((_e52 + _e53));
    uint _e57 = local_5;
    out_.Store(_e57*4, asuint(~(_e41)));
}
