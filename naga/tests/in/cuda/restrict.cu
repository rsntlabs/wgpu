__device__ void copy(int *__restrict__, const int *__restrict);

__global__ void kernel(int *__restrict__ output, const int *__restrict input) {
    copy(output, input);
    output[1] = input[2];
}

__device__ void copy(int *__restrict destination, const int *const __restrict__ source) {
    destination[0] = source[0] + source[1];
}
