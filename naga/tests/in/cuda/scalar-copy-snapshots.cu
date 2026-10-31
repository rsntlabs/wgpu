__device__ void overwrite(int *output) { output[8] = 11; }

__global__ void kernel(int *output) {
    int direct_snapshot = output[8];
    output[8] = 9;
    output[0] = direct_snapshot;
    output[1] = output[8];
    int helper_snapshot = output[8];
    overwrite(output);
    output[2] = helper_snapshot;
    output[3] = output[8];
    int branch_snapshot = output[8];
    if (output[7]) output[8] = 13;
    else output[8] = 17;
    output[4] = branch_snapshot;
    output[5] = output[8];
    int loop_snapshot = output[8];
    for (int iteration = 0; iteration < 3; ++iteration) output[8] += iteration + 1;
    output[6] = loop_snapshot;
    output[9] = output[8];
    int atomic_snapshot = output[8];
    int previous = atomicExch(output + 8, 19);
    output[10] = atomic_snapshot;
    output[11] = previous;
    output[12] = output[8];
    int changed = output[8];
    output[13] = changed++;
    output[14] = changed;
}
