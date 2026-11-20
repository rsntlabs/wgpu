__global__ void paired_trig(const float *input, float *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 8u;
    float value = input[lane];
    float sine; float cosine;
    sincosf(value, &sine, &cosine);
    output[base] = sine; output[base + 1u] = cosine;
    unsigned cursor = base + 2u;
    sincosf(value++, output + cursor++, output + cursor++);
    output[base + 4u] = float(cursor);
    output[base + 5u] = value;
    sincosf(0.0f, &sine, &sine);
    output[base + 6u] = sine;
    output[base + 7u] = cosine;
}
