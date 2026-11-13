extern "C" __global__ void object_sizes(unsigned *output) {
    float3 values[2];
    float3 &reference = values[0];
    output[0] = unsigned(sizeof values);
    output[1] = unsigned(sizeof(reference));
    output[2] = unsigned(sizeof(output));
}
