__global__ void paired_trig(const float *input, float *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    float value = input[lane];
    float sine; float cosine;
    sincosf(value, &sine, &cosine);
    output[base] = sine; output[base + 1u] = cosine;
    unsigned cursor = base + 2u;
    __nv_sincosf(value++, output + cursor++, output + cursor++);
    output[base + 4u] = float(cursor);
    output[base + 5u] = value;
    sincosf(0.0f, &sine, &sine);
    output[base + 6u] = sine;
    output[base + 7u] = cosine;
    value = input[lane];
    __sincosf(value, &sine, &cosine);
    output[base + 8u] = sine; output[base + 9u] = cosine;
    cursor = base + 10u;
    __nv_fast_sincosf(value++, output + cursor++, output + cursor++);
    output[base + 12u] = float(cursor);
    output[base + 13u] = value;
    __sincosf(input[lane], &sine, &sine);
    output[base + 14u] = sine;
    output[base + 15u] = cosine;
}
