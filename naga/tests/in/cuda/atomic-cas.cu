__global__ void kernel(int *output) {
    output[8] = atomicCAS(output, -3, 7.75f);
    output[9] = atomicCAS(output, -3, 11);
    output[10] = atomicCAS(output + 1, -2147483647 - 1, -7);
    atomicCAS(output + 2, 5, -4);
    output[11] = atomicCAS(output + 2, -4.75f, 9.75f);
    output[12] = output[0];
    output[13] = output[1];
    output[14] = output[2];
}
