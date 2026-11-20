using Bits = unsigned;
using Sample = const float;

__device__ float from_bits(Bits value) {
    return __uint_as_float(value);
}

__device__ int __float_as_int(int first, int second) {
    return first + second;
}

__global__ void bitcasts(Bits *out) {
    out[0] = unsigned(__float_as_int(true));
    out[1] = unsigned(__float_as_int(3));
    out[2] = unsigned(__float_as_int(5u));
    out[3] = unsigned(__float_as_int(2.75f));
    out[4] = __float_as_uint(true);
    out[5] = __float_as_uint(3);
    out[6] = __float_as_uint(5u);
    out[7] = __float_as_uint(2.75f);
    out[8] = __float_as_uint(__int_as_float(true));
    out[9] = __float_as_uint(__int_as_float(3));
    out[10] = __float_as_uint(__int_as_float(5u));
    out[11] = __float_as_uint(__int_as_float(2.75f));
    out[12] = __float_as_uint(__uint_as_float(true));
    out[13] = __float_as_uint(__uint_as_float(3));
    out[14] = __float_as_uint(__uint_as_float(5u));
    out[15] = __float_as_uint(__uint_as_float(2.75f));
    float value = 1.5f;
    out[16] = unsigned(__float_as_int(value++));
    out[17] = __float_as_uint(value);
    out[18] = __float_as_uint(value++);
    out[19] = __float_as_uint(value);
    int signed_bits = 0x3f800000;
    out[20] = __float_as_uint(__int_as_float(signed_bits++));
    out[21] = unsigned(signed_bits);
    Bits unsigned_bits = 0x40000000u;
    out[22] = __float_as_uint(__uint_as_float(unsigned_bits++));
    out[23] = unsigned_bits;
    out[24] = unsigned(__float_as_int(3, 4));
    Sample copied = from_bits(0xbf800000u);
    out[25] = __float_as_uint(copied);
    out[26] = __float_as_uint(__int_as_float(0x7f800000));
    out[27] = __float_as_uint(__uint_as_float(0x7fc12345u));
    out[28] = __float_as_uint(__uint_as_float(1065353216.0f));
    out[29] = unsigned(__float_as_int(1u));
    out[30] = unsigned(__nv_float_as_int(true));
    out[31] = unsigned(__nv_float_as_int(3));
    out[32] = unsigned(__nv_float_as_int(5u));
    out[33] = unsigned(__nv_float_as_int(2.75f));
    out[34] = __nv_float_as_uint(true);
    out[35] = __nv_float_as_uint(3);
    out[36] = __nv_float_as_uint(5u);
    out[37] = __nv_float_as_uint(2.75f);
    out[38] = __nv_float_as_uint(__nv_int_as_float(true));
    out[39] = __nv_float_as_uint(__nv_int_as_float(3));
    out[40] = __nv_float_as_uint(__nv_int_as_float(5u));
    out[41] = __nv_float_as_uint(__nv_int_as_float(2.75f));
    out[42] = __nv_float_as_uint(__nv_uint_as_float(true));
    out[43] = __nv_float_as_uint(__nv_uint_as_float(3));
    out[44] = __nv_float_as_uint(__nv_uint_as_float(5u));
    out[45] = __nv_float_as_uint(__nv_uint_as_float(2.75f));
    value = 1.5f;
    out[46] = unsigned(__nv_float_as_int(value++));
    out[47] = __float_as_uint(value);
    out[48] = __nv_float_as_uint(value++);
    out[49] = __float_as_uint(value);
    signed_bits = 0x3f800000;
    out[50] = __float_as_uint(__nv_int_as_float(signed_bits++));
    out[51] = unsigned(signed_bits);
    unsigned_bits = 0x40000000u;
    out[52] = __float_as_uint(__nv_uint_as_float(unsigned_bits++));
    out[53] = unsigned_bits;
}
