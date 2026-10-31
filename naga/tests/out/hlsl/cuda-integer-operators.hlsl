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
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;

    int value_1 = value.value;
    uint amount_1 = amount.value;
    int remainder = naga_mod(value_1, naga_neg(int(3)));
    bits = (uint(remainder) & 15u);
    uint _e14 = bits;
    bits = (_e14 | 8u);
    uint _e17 = bits;
    bits = (_e17 ^ 1u);
    uint _e20 = bits;
    local = amount_1;
    uint _e22 = local;
    bits = (_e20 << _e22);
    uint _e24 = bits;
    bits = (_e24 >> 1u);
    uint _e27 = bits;
    bits = naga_mod(_e27, 97u);
    uint _e30 = bits;
    bits = (_e30 & 255u);
    uint _e33 = bits;
    local_1 = uint(threadIdx.x);
    uint _e38 = local_1;
    local_2 = uint(_e38);
    uint _e41 = local_2;
    out_.Store(_e41*4, asuint(~(_e33)));
}
