__device__ void reset_math_flags(unsigned &flags) { flags = 0u; }
extern "C" __global__ void uniform_math_barriers(float value, unsigned *output) {
    __shared__ unsigned shared_values[4];
    unsigned lane = threadIdx.x;
    shared_values[lane] = lane + 1u;
    unsigned flags = 1u;
    reset_math_flags(flags);
    if ((floorf(value)) > 0.0f) { __syncthreads(); flags |= 1u; }
    if ((ceilf(value)) > 0.0f) { __syncthreads(); flags |= 2u; }
    if ((roundf(value)) > 0.0f) { __syncthreads(); flags |= 4u; }
    if ((fabsf(value)) > 0.0f) { __syncthreads(); flags |= 8u; }
    if ((sqrtf(value)) > 0.0f) { __syncthreads(); flags |= 16u; }
    if ((rsqrtf(value)) > 0.0f) { __syncthreads(); flags |= 32u; }
    if ((fmodf(value, 2.0f)) > 0.0f) { __syncthreads(); flags |= 64u; }
    if ((value / 2.0f) > 0.0f) { __syncthreads(); flags |= 128u; }
    if ((sinf(value)) > 0.0f) { __syncthreads(); flags |= 256u; }
    if ((cosf(value)) > 0.0f) { __syncthreads(); flags |= 512u; }
    output[4u + lane * 2u] = shared_values[(lane + 1u) & 3u];
    output[5u + lane * 2u] = flags;
}
