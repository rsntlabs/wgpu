__global__ void kernel(int *output) {
    int before = output[0];
    int previous = atomicAdd(output, -3);
    output[1] = before;
    output[2] = previous;
    atomicAdd(output, 2.75f);
    output[3] = output[0];
    output[0] = 11;
    output[4] = atomicAdd(output, 4);
    output[5] = output[0];
    unsigned index = 8;
    int amount = 3;
    output[6] = atomicAdd(output + index++, amount++);
    output[7] = index;
    output[9] = amount;
    bool skipped = false && atomicAdd(output + 8, 100);
    bool ready = true || atomicAdd(output + 8, 100);
    output[10] = int(skipped) + int(ready);
    output[11] = atomicAdd(output, -20);
    output[12] = output[0];
    output[13] = output[7] == 9 ? atomicAdd(output + 8, 2) : atomicAdd(output + 15, 100);
    output[14] = output[8];
}
