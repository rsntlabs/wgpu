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

[numthreads(1, 1, 1)]
void integer_ops(uint3 threadIdx : SV_GroupThreadID)
{
    uint bits = (uint)0;
    uint local = (uint)0;

    int value_1 = value.value;
    uint amount_1 = amount.value;
    int remainder = naga_mod(value_1, naga_neg(int(3)));
    bits = (uint(remainder) & 15u);
    uint _e14 = bits;
    bits = (_e14 | 8u);
    uint _e17 = bits;
    bits = (_e17 ^ 1u);
    uint _e20 = bits;
    bits = (_e20 << amount_1);
    uint _e22 = bits;
    bits = (_e22 >> 1u);
    uint _e25 = bits;
    bits = naga_mod(_e25, 97u);
    uint _e28 = bits;
    bits = (_e28 & 255u);
    uint _e31 = bits;
    local = uint(threadIdx.x);
    uint _e36 = local;
    out_.Store(_e36*4, asuint(~(_e31)));
}
