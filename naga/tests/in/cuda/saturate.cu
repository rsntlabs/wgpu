using Sample = const float;
using Bits = unsigned;

__device__ Sample __saturatef(Sample value);

__device__ Sample saturate_scalar(Sample value) {
    return __saturatef(value);
}

__host__ __device__ float saturate_reference(const float &value) {
    return __saturatef(value);
}

__device__ float saturate_pointer(const float *value) {
    return __saturatef(*value);
}

__device__ void saturate_in_place(float &value) {
    value = __saturatef(value);
}

__device__ int __saturatef(bool value) {
    return value ? 7 : 9;
}

__device__ float __saturatef(float first, float second) {
    return first + second;
}

__device__ float2 __saturatef(float2 value) {
    return make_float2(__saturatef(value.x), __saturatef(value.y));
}

__device__ float pair(float first, float second) {
    return first * 4.0f + second;
}

struct Pixel {
    float channel;
};

__global__ void saturate_values(Bits *out) {
    out[0] = __float_as_uint(__saturatef(-1.0f));
    out[1] = __float_as_uint(__saturatef(0.0f));
    out[2] = __float_as_uint(__saturatef(-0.0f));
    out[3] = __float_as_uint(__saturatef(0.25f));
    out[4] = __float_as_uint(__saturatef(1.0f));
    out[5] = __float_as_uint(__saturatef(2.0f));
    out[6] = __float_as_uint(saturate_scalar(-3));
    out[7] = __float_as_uint(saturate_scalar(5u));
    out[8] = __float_as_uint(saturate_scalar(true));
    out[9] = __float_as_uint(saturate_scalar(false));
    out[10] = unsigned(__saturatef(true));
    out[11] = unsigned(__saturatef(false));
    float value = 0.25f;
    out[12] = __float_as_uint(__saturatef(value++));
    out[13] = __float_as_uint(value);
    float2 bounded = __saturatef(make_float2(-0.5f, 0.5f));
    out[14] = __float_as_uint(bounded.x);
    out[15] = __float_as_uint(bounded.y);
    Pixel pixel{2.0f};
    saturate_in_place(pixel.channel);
    out[16] = __float_as_uint(pixel.channel);
    out[17] = __float_as_uint(saturate_reference(pixel.channel));
    float values[2]{1.5f, -0.5f};
    out[18] = __float_as_uint(saturate_pointer(values));
    out[19] = __float_as_uint(saturate_reference(-0.5f));
    out[20] = __float_as_uint(saturate_scalar(__saturatef(0.75f)));
    out[21] = __float_as_uint(__saturatef(0.25f, 1.0f));
    value = 0.25f;
    out[22] = __float_as_uint(pair(__saturatef(value++), value++));
    out[23] = __float_as_uint(value);
    bool choose = false;
    out[24] = __float_as_uint(choose ? __saturatef(value++) : __saturatef(--value));
    out[25] = __float_as_uint(value);
    bool active = false && __saturatef(value++);
    out[26] = unsigned(active);
    out[27] = __float_as_uint(value);
    out[28] = __float_as_uint((__saturatef(value++), __saturatef(value)));
    out[29] = __float_as_uint(value);
}
