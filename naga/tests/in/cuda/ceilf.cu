using Sample = const float;

__device__ Sample rounded(Sample value) { return ceilf(value); }
__device__ int ceilf(bool value) { return value ? 7 : 9; }
__device__ float ceilf(float first, float second) { return first + second; }

__global__ void ceilings(unsigned *output) {
    output[0] = __float_as_uint(ceilf(0.0f));
    output[1] = __float_as_uint(ceilf(-0.0f));
    output[2] = __float_as_uint(ceilf(1.25f));
    output[3] = __float_as_uint(ceilf(-1.75f));
    output[4] = __float_as_uint(rounded(3));
    output[5] = __float_as_uint(rounded(5u));
    output[6] = unsigned(ceilf(true));
    output[7] = unsigned(ceilf(false));
    output[8] = __float_as_uint(rounded(true));
    output[9] = __float_as_uint(rounded(false));
    output[10] = __float_as_uint(ceilf(__uint_as_float(1u)));
    output[11] = __float_as_uint(ceilf(__uint_as_float(0x80000001u)));
    output[12] = __float_as_uint(ceilf(__uint_as_float(0x007fffffu)));
    output[13] = __float_as_uint(ceilf(__uint_as_float(0x807fffffu)));
    output[14] = __float_as_uint(ceilf(-0.25f));
    output[15] = __float_as_uint(ceilf(__uint_as_float(0x4affffffu)));
    output[16] = __float_as_uint(ceilf(__uint_as_float(0xcaffffffu)));
    output[17] = __float_as_uint(ceilf(3.402823466e38f));
    output[18] = __float_as_uint(ceilf(-3.402823466e38f));
    output[19] = __float_as_uint(ceilf(__uint_as_float(0x7f800000u)));
    output[20] = __float_as_uint(ceilf(__uint_as_float(0xff800000u)));
    output[21] = __float_as_uint(ceilf(__uint_as_float(0x7fc12345u)));
    output[22] = __float_as_uint(ceilf(__uint_as_float(0xff800001u)));
    float value = 2.25f;
    output[23] = __float_as_uint(rounded(value++));
    output[24] = __float_as_uint(value);
    output[25] = __float_as_uint(ceilf(2.0f, 3.0f));
    output[26] = __float_as_uint(rounded(0xffffffffu));
    output[27] = __float_as_uint(rounded(-2147483647 - 1));
    output[28] = __float_as_uint(ceilf(1e10f));
}
