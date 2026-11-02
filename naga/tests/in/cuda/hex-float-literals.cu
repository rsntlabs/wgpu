#define IDENTITY(value) value
#define EXPANDED(value) IDENTITY(value)

constexpr float HexScale = 0x1.8p-1f;

__device__ float identity(float value) {
    return value;
}

__device__ float observe(unsigned &counter, float value) {
    ++counter;
    return value;
}

__global__ void hex_float_literals(unsigned *output) {
    unsigned counter = 0u;
    output[0] = __float_as_uint(0x0p0f);
    output[1] = __float_as_uint(-0x0p0f);
    output[2] = __float_as_uint(0x1p0f);
    output[3] = __float_as_uint(0X1P+1F);
    output[4] = __float_as_uint(0x.8p1f);
    output[5] = __float_as_uint(0x1.p-1f);
    output[6] = __float_as_uint(0x1.8p+1f);
    output[7] = __float_as_uint(-0x1.4p2f);
    output[8] = __float_as_uint(0x1p-126f);
    output[9] = __float_as_uint(0x1p-149f);
    output[10] = __float_as_uint(0x1.fffffcp-127f);
    output[11] = __float_as_uint(0x1.fffffep-127f);
    output[12] = __float_as_uint(0x1p-150f);
    output[13] = __float_as_uint(-0x1p-150f);
    output[14] = __float_as_uint(0x1.000002p-150f);
    output[15] = __float_as_uint(0x1.fffffep-151f);
    output[16] = __float_as_uint(0x3p-150f);
    output[17] = __float_as_uint(0x5p-150f);
    output[18] = __float_as_uint(0x7p-150f);
    output[19] = __float_as_uint(0x1.000001p0f);
    output[20] = __float_as_uint(0x1.000003p0f);
    output[21] = __float_as_uint(0x1.00000100000000000000000000000000000000000000000000000000000000000000001p0f);
    output[22] = __float_as_uint(0x1.000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffp0f);
    output[23] = __float_as_uint(0x1.fffffep127f);
    output[24] = __float_as_uint(-0x1.fffffep127f);
    output[25] = __float_as_uint(0x1.fffffdp127f);
    output[26] = __float_as_uint(0x1.fffffefffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffp127f);
    output[27] = __float_as_uint(0x1.00000000000000000000000000000000000000000000000000000000000000000000001p-150f);
    output[28] = __float_as_uint(-0x1.00000000000000000000000000000000000000000000000000000000000000000000001p-150f);
    output[29] = __float_as_uint(0x0.00000000000000000000000000000000000000000000000000000000000000000000001p0f);
    output[30] = __float_as_uint(0x1'2.3'4p+0'2f);
    output[31] = __float_as_uint(0X.8'0P-0'1F);
    output[32] = __float_as_uint(IDENTITY(0x1.8p2f));
    output[33] = __float_as_uint(EXPANDED(0x1p2f));
    output[34] = __float_as_uint(HexScale);
    output[35] = __float_as_uint(identity(0x1.2p3f));
    output[36] = __float_as_uint(observe(counter, 0x1.8p1f));
    output[37] = __float_as_uint(0x1p-2f + 0x1p-1f);
    output[38] = __float_as_uint(0x0p+128f);
    output[39] = counter;
}
