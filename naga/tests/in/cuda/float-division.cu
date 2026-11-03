using Sample = const float;

__device__ float quotient(Sample numerator, Sample denominator) {
    return numerator / denominator;
}

__device__ float take_divisor(float &value) { return value++; }
__device__ float take_values(float &left, float &right) { return left++ / right++; }

__device__ float4 operator/(float4 left, float4 right) {
    return make_float4(left.x / right.x, left.y / right.y, left.z / right.z, left.w / right.w);
}

__device__ float4 operator/(float4 left, float right) {
    return make_float4(left.x / right, left.y / right, left.z / right, left.w / right);
}

__device__ float4 operator/(float left, float4 right) {
    return make_float4(left / right.x, left / right.y, left / right.z, left / right.w);
}

__device__ void operator/=(float4 &left, float4 right) { left = left / right; }
__device__ void operator/=(float4 &left, float right) { left = left / right; }

struct Ratio { float value; };
__device__ float operator/(Ratio left, Ratio right) { return left.value + right.value; }
__device__ Ratio operator/=(Ratio &left, float right) {
    left.value += right;
    return left;
}

__global__ void divisions(const unsigned *input, unsigned *output) {
    float numerator = __uint_as_float(input[0]);
    float denominator = __uint_as_float(input[1]);
    output[0] = __float_as_uint(numerator / denominator);
    output[1] = __float_as_uint(quotient(numerator, denominator));
    output[2] = __float_as_uint(numerator / 3);
    output[3] = __float_as_uint(3 / numerator);

    float4 values = make_float4(numerator, 1.0f, -0.0f, __uint_as_float(input[3]));
    float4 divisors = make_float4(denominator, 3.0f, 3.0f, 2.0f);
    float4 divided = values / divisors;
    output[4] = __float_as_uint(divided.x);
    output[5] = __float_as_uint(divided.y);
    output[6] = __float_as_uint(divided.z);
    output[7] = __float_as_uint(divided.w);
    divided = values / 3.0f;
    output[8] = __float_as_uint(divided.x);
    output[9] = __float_as_uint(divided.y);
    output[10] = __float_as_uint(divided.z);
    output[11] = __float_as_uint(divided.w);
    divided = 3.0f / divisors;
    output[12] = __float_as_uint(divided.x);
    output[13] = __float_as_uint(divided.y);
    output[14] = __float_as_uint(divided.z);
    output[15] = __float_as_uint(divided.w);
    divided = values;
    divided /= divisors;
    output[16] = __float_as_uint(divided.x);
    output[17] = __float_as_uint(divided.y);
    output[18] = __float_as_uint(divided.z);
    output[19] = __float_as_uint(divided.w);
    divided = values;
    divided /= 3.0f;
    output[20] = __float_as_uint(divided.x);
    output[21] = __float_as_uint(divided.y);
    output[22] = __float_as_uint(divided.z);
    output[23] = __float_as_uint(divided.w);

    float scalar = numerator;
    output[24] = __float_as_uint(scalar /= denominator);
    output[25] = __float_as_uint(scalar);
    float bank[2] = {numerator, 7.0f};
    unsigned index = 0u;
    float divisor = denominator;
    output[26] = __float_as_uint(bank[index++] /= take_divisor(divisor));
    output[27] = __float_as_uint(bank[0]);
    output[28] = index;
    output[29] = __float_as_uint(divisor);
    output[30] = __float_as_uint(bank[1]);
    output[31] = unsigned(-7 / 3);
    output[32] = 0xffffffffu / 3u;
    Ratio first = {2.0f};
    Ratio second = {3.0f};
    output[33] = __float_as_uint(first / second);
    Ratio updated = (first /= 3.0f);
    output[34] = __float_as_uint(updated.value);
    output[35] = __float_as_uint(first.value);
    constexpr float third = 1.0f / 3.0f;
    output[36] = __float_as_uint(third);

    float left = 2.0f;
    float right = 3.0f;
    output[37] = __float_as_uint(left++ / right++);
    output[38] = __float_as_uint(left);
    output[39] = __float_as_uint(right);
    float selected_numerator = numerator;
    float selected_denominator = denominator;
    bool choose = false;
    output[40] = __float_as_uint(choose ? quotient(selected_numerator++, selected_denominator++)
                                      : selected_numerator++ / selected_denominator++);
    output[41] = __float_as_uint(selected_numerator);
    output[42] = __float_as_uint(selected_denominator);
    output[43] = unsigned(false && quotient(selected_numerator++, selected_denominator++));
    output[44] = __float_as_uint(selected_numerator);
    output[45] = unsigned(true || quotient(selected_numerator++, selected_denominator++));
    output[46] = __float_as_uint(selected_denominator);
    float scale = 6.0f;
    output[47] = __float_as_uint((scale /= 2.0f, scale /= 3.0f));
    output[48] = __float_as_uint(scale);
    scale = 8.0f;
    for (int iteration = 0; iteration < 2; ++iteration) {
        if (iteration == 0) continue;
        scale /= 2.0f;
    }
    output[49] = __float_as_uint(scale);
    left = 2.0f;
    right = 3.0f;
    output[50] = __float_as_uint(take_values(left, right));
    output[51] = __float_as_uint(left);
    output[52] = __float_as_uint(right);
    output[53] = __float_as_uint((numerator / denominator) / 3.0f);
    output[54] = __float_as_uint(24.0f / denominator / 2.0f);
    output[55] = __float_as_uint(24.0f / (denominator / 2.0f));
    output[56] = __float_as_uint(numerator / true);
    output[57] = __float_as_uint(0xffffffffu / denominator);
    output[58] = __float_as_uint(numerator / __uint_as_float(input[2]));
    output[59] = __float_as_uint(__uint_as_float(input[2]) / __uint_as_float(input[2]));
    output[60] = __float_as_uint(__uint_as_float(input[3]) / __uint_as_float(input[3]));
}
