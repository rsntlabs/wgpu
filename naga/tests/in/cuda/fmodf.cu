using Sample = const float;
using Bits = unsigned;

__device__ float fmodf(float numerator, float denominator);

__device__ Sample sample_remainder(Sample numerator, Sample denominator) {
    return fmodf(numerator, denominator);
}

__device__ int fmodf(bool numerator, bool denominator) {
    return numerator ? 7 : 9;
}

__device__ float fmodf(float first, float second, float third) {
    return first + second + third;
}

__device__ float take_next(float &value) { return fmodf(value++, 3.0f); }

__global__ void remainders(Bits *output) {
    output[0] = __float_as_uint(fmodf(5.5f, 2.0f));
    output[1] = __float_as_uint(fmodf(-5.5f, 2.0f));
    output[2] = __float_as_uint(fmodf(5.5f, -2.0f));
    output[3] = __float_as_uint(fmodf(-5.5f, -2.0f));
    output[4] = __float_as_uint(fmodf(4.0f, 2.0f));
    output[5] = __float_as_uint(fmodf(-4.0f, 2.0f));
    output[6] = __float_as_uint(fmodf(0.0f, -2.0f));
    output[7] = __float_as_uint(fmodf(-0.0f, 2.0f));
    output[8] = __float_as_uint(fmodf(1.0f, 3.0f));
    output[9] = __float_as_uint(fmodf(3.0f, 1.0f));
    output[10] = __float_as_uint(fmodf(__uint_as_float(0x7f7fffffu), __uint_as_float(1u)));
    output[11] = __float_as_uint(fmodf(__uint_as_float(0xff7fffffu), __uint_as_float(1u)));
    output[12] = __float_as_uint(fmodf(__uint_as_float(0x00800000u), __uint_as_float(3u)));
    output[13] = __float_as_uint(fmodf(__uint_as_float(0x007fffffu), __uint_as_float(3u)));
    output[14] = __float_as_uint(fmodf(__uint_as_float(1u), __uint_as_float(0x00800000u)));
    output[15] = __float_as_uint(fmodf(__uint_as_float(0x3f800001u), 1.0f));
    output[16] = __float_as_uint(fmodf(1.0f, __uint_as_float(0x3f800001u)));
    output[17] = __float_as_uint(fmodf(__uint_as_float(0x7f800001u), 2.0f));
    output[18] = __float_as_uint(fmodf(1.0f, __uint_as_float(0x7fc12345u)));
    output[19] = __float_as_uint(fmodf(__uint_as_float(0x7f800000u), 2.0f));
    output[20] = __float_as_uint(fmodf(__uint_as_float(0xff800000u), __uint_as_float(0x7f800000u)));
    output[21] = __float_as_uint(fmodf(1.0f, 0.0f));
    output[22] = __float_as_uint(fmodf(0.0f, 0.0f));
    output[23] = __float_as_uint(fmodf(5.5f, __uint_as_float(0x7f800000u)));
    output[24] = __float_as_uint(fmodf(-5.5f, __uint_as_float(0xff800000u)));
    output[25] = __float_as_uint(sample_remainder(7, 3));
    output[26] = __float_as_uint(sample_remainder(7u, 3u));
    output[27] = __float_as_uint(sample_remainder(true, true));
    output[28] = __float_as_uint(sample_remainder(false, true));
    output[29] = unsigned(fmodf(true, false));
    output[30] = unsigned(fmodf(false, true));
    output[31] = __float_as_uint(fmodf(1.0f, 2.0f, 3.0f));
    float value = 5.5f;
    output[32] = __float_as_uint(fmodf(value++, 2.0f));
    output[33] = __float_as_uint(value);
    float denominator = 2.0f;
    output[34] = __float_as_uint(fmodf(7.0f, denominator++));
    output[35] = __float_as_uint(denominator);
    value = 5.5f;
    output[36] = __float_as_uint(fmodf(value++, value++));
    output[37] = __float_as_uint(value);
    bool choose = false;
    output[38] = __float_as_uint(choose ? fmodf(value++, 2.0f) : fmodf(value++, 3.0f));
    output[39] = __float_as_uint(value);
    output[40] = unsigned(false && fmodf(value++, 2.0f));
    output[41] = unsigned(true || fmodf(value++, 2.0f));
    output[42] = __float_as_uint(value);
    output[43] = __float_as_uint((fmodf(value++, 2.0f), fmodf(value++, 3.0f)));
    output[44] = __float_as_uint(value);
    output[45] = __float_as_uint(take_next(value));
    output[46] = __float_as_uint(value);
    for (int iteration = 0; iteration < 2; ++iteration) {
        if (iteration == 0) continue;
        output[47] = __float_as_uint(fmodf(value++, 2.0f));
    }
    output[48] = __float_as_uint(value);
    output[49] = unsigned(true && fmodf(value++, 2.0f));
    output[50] = __float_as_uint(value);
    output[51] = __float_as_uint(sample_remainder(0xffffffffu, 3u));
    output[52] = __float_as_uint(sample_remainder(-2147483647 - 1, 3));
    output[53] = __float_as_uint(fmodf(0.5f, 0.25f));
    output[54] = __float_as_uint(fmodf(-0.5f, 0.25f));
    output[55] = __float_as_uint(fmodf(__uint_as_float(0x7fffffffu), 1.0f));
    output[56] = __float_as_uint(sample_remainder(3.25f, 2.0f));
    output[57] = __float_as_uint(fmodf(1.5f, fmodf(5.5f, 2.0f)));
    output[58] = __float_as_uint(fmodf(fmodf(8.5f, 3.0f), 2.0f));
    output[59] = __float_as_uint(fmodf(-0.0f, __uint_as_float(0x7f800000u)));
    output[60] = __float_as_uint(fmodf(__uint_as_float(1u), __uint_as_float(0xff800000u)));
    output[61] = __float_as_uint(fmodf(__uint_as_float(0x00800001u), __uint_as_float(0x007fffffu)));
}
