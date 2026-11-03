using Sample = const float;

__device__ Sample rounded(Sample value) { return roundf(value); }
__device__ int roundf(bool value) { return value ? 7 : 9; }
__device__ float roundf(float first, float second) { return first + second; }

__global__ void rounds(unsigned *output) {
    output[0] = __float_as_uint(roundf(0.0f));
    output[1] = __float_as_uint(roundf(-0.0f));
    output[2] = __float_as_uint(roundf(1.25f));
    output[3] = __float_as_uint(roundf(-1.75f));
    output[4] = __float_as_uint(rounded(3));
    output[5] = __float_as_uint(rounded(5u));
    output[6] = unsigned(roundf(true));
    output[7] = unsigned(roundf(false));
    output[8] = __float_as_uint(rounded(true));
    output[9] = __float_as_uint(rounded(false));
    output[10] = __float_as_uint(roundf(__uint_as_float(1u)));
    output[11] = __float_as_uint(roundf(__uint_as_float(0x80000001u)));
    output[12] = __float_as_uint(roundf(__uint_as_float(0x007fffffu)));
    output[13] = __float_as_uint(roundf(__uint_as_float(0x807fffffu)));
    output[14] = __float_as_uint(roundf(-0.25f));
    output[15] = __float_as_uint(roundf(__uint_as_float(0x4affffffu)));
    output[16] = __float_as_uint(roundf(__uint_as_float(0xcaffffffu)));
    output[17] = __float_as_uint(roundf(3.402823466e38f));
    output[18] = __float_as_uint(roundf(-3.402823466e38f));
    output[19] = __float_as_uint(roundf(__uint_as_float(0x7f800000u)));
    output[20] = __float_as_uint(roundf(__uint_as_float(0xff800000u)));
    output[21] = __float_as_uint(roundf(__uint_as_float(0x7fc12345u)));
    output[22] = __float_as_uint(roundf(__uint_as_float(0xff800001u)));
    float value = 2.25f;
    output[23] = __float_as_uint(rounded(value++));
    output[24] = __float_as_uint(value);
    output[25] = __float_as_uint(roundf(2.0f, 3.0f));
    output[26] = __float_as_uint(rounded(0xffffffffu));
    output[27] = __float_as_uint(rounded(-2147483647 - 1));
    output[28] = __float_as_uint(roundf(1e10f));
    output[29] = __float_as_uint(roundf(1.5f));
    output[30] = __float_as_uint(roundf(-1.5f));
    output[31] = __float_as_uint(roundf(2.5f));
    output[32] = __float_as_uint(roundf(-2.5f));
    output[33] = __float_as_uint(roundf(__uint_as_float(0x3effffffu)));
    output[34] = __float_as_uint(roundf(__uint_as_float(0x3f000001u)));
    output[35] = __float_as_uint(roundf(__uint_as_float(0xbeffffffu)));
    output[36] = __float_as_uint(roundf(__uint_as_float(0xbf000001u)));
    output[37] = __float_as_uint(roundf(__uint_as_float(0x4a800001u)));
    output[38] = __float_as_uint(roundf(__uint_as_float(0xca800001u)));
    output[39] = __float_as_uint(roundf(__uint_as_float(0x4afffffdu)));
    output[40] = __float_as_uint(roundf(__uint_as_float(0xcafffffdu)));
}
