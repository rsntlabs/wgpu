__global__ void kernel(int *output) {
    output[8] = atomicSub(output, -3);
    output[9] = atomicMin(output + 1, 3);
    output[10] = atomicMax(output + 2, 3);
    output[11] = atomicAnd(output + 3, -13);
    output[12] = atomicOr(output + 4, 15);
    output[13] = atomicXor(output + 5, -2147483647 - 1);
    output[14] = atomicExch(output + 6, 4.75f);
    output[16] = output[0];
    output[17] = output[1];
    output[18] = output[2];
    output[19] = output[3];
    output[20] = output[4];
    output[21] = output[5];
    output[22] = output[6];
    atomicSub(output, 2.75f);
    output[23] = output[0];
}
