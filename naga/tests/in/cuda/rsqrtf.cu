using Sample = const float;
using Bits = unsigned;

__device__ Sample inverse_root(Sample value) {
    return rsqrtf(value);
}

__device__ float inverse_root(int value) {
    return rsqrtf(value);
}

__device__ float inverse_root(unsigned value) {
    return rsqrtf(value);
}

__device__ float inverse_root(bool value) {
    return rsqrtf(value);
}

__device__ int rsqrtf(bool value) {
    return value ? 7 : 9;
}

__device__ float rsqrtf(float first, float second) {
    return first + second;
}

__device__ float take_next(float &value) { return rsqrtf(value++); }
__device__ float pair(float first, float second) { return first * 10.0f + second; }

__global__ void inverse_roots(Bits *out) {
    out[0] = __float_as_uint(rsqrtf(0.0f));
    out[1] = __float_as_uint(rsqrtf(-0.0f));
    out[2] = __float_as_uint(rsqrtf(1.0f));
    out[3] = __float_as_uint(inverse_root(4));
    out[4] = __float_as_uint(inverse_root(9u));
    out[5] = __float_as_uint(rsqrtf(6.25f));
    out[6] = __float_as_uint(rsqrtf(2.0f));
    out[7] = __float_as_uint(rsqrtf(__uint_as_float(1u)));
    out[8] = __float_as_uint(rsqrtf(__uint_as_float(0x007fffffu)));
    out[9] = __float_as_uint(rsqrtf(__uint_as_float(0x00800000u)));
    out[10] = __float_as_uint(rsqrtf(__uint_as_float(0x7f7fffffu)));
    out[11] = __float_as_uint(rsqrtf(__uint_as_float(0x7f800000u)));
    out[12] = __float_as_uint(rsqrtf(-1.0f));
    out[13] = __float_as_uint(rsqrtf(__uint_as_float(0x7f800001u)));
    float value = 4.0f;
    out[14] = __float_as_uint(inverse_root(value++));
    out[15] = __float_as_uint(value);
    out[16] = unsigned(rsqrtf(true));
    out[17] = unsigned(rsqrtf(false));
    out[18] = __float_as_uint(rsqrtf(2.0f, 3.0f));
    out[19] = __float_as_uint(rsqrtf(__uint_as_float(0x3f800001u)));
    out[20] = __float_as_uint(rsqrtf(__uint_as_float(0x3f800002u)));
    out[21] = __float_as_uint(rsqrtf(__uint_as_float(0x3f7fffffu)));
    out[22] = __float_as_uint(inverse_root(0xffffffffu));
    out[23] = __float_as_uint(inverse_root(-4));
    out[24] = __float_as_uint(inverse_root(16.0f));
    out[25] = __float_as_uint(rsqrtf(0.25f));
    out[26] = __float_as_uint(rsqrtf(__uint_as_float(0x80000001u)));
    out[27] = __float_as_uint(inverse_root(false));
    out[28] = __float_as_uint(inverse_root(true));
    out[29] = __float_as_uint(inverse_root(0.5f));
    out[30] = __float_as_uint(sqrtf(2.0f));
    out[31] = __float_as_uint(1.0f / sqrtf(2.0f));
    out[32] = __float_as_uint(rsqrtf(2.0f));
    value = 4.0f;
    bool choose = false;
    out[33] = __float_as_uint(choose ? rsqrtf(value++) : rsqrtf(value++));
    out[34] = __float_as_uint(value);
    out[35] = unsigned(false && rsqrtf(value++));
    out[36] = unsigned(true || rsqrtf(value++));
    out[37] = __float_as_uint(value);
    float left = 4.0f;
    float right = 9.0f;
    out[38] = __float_as_uint(pair(rsqrtf(left++), rsqrtf(right++)));
    out[39] = __float_as_uint(left);
    out[40] = __float_as_uint(right);
    out[41] = __float_as_uint((rsqrtf(value++), rsqrtf(value++)));
    out[42] = __float_as_uint(value);
    for (int iteration = 0; iteration < 2; ++iteration) {
        if (iteration == 0) continue;
        out[43] = __float_as_uint(rsqrtf(value++));
    }
    out[44] = __float_as_uint(value);
    out[45] = __float_as_uint(take_next(value));
    out[46] = __float_as_uint(value);
    out[47] = unsigned(true && rsqrtf(value++));
    out[48] = __float_as_uint(value);
}
