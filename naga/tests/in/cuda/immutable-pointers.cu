__device__ void copy(int &destination, const int &source) {
    destination = source;
}

__global__ void kernel(int *out, int *other) {
    unsigned destination_index = 1;
    unsigned source_index = 8;
    copy(out[destination_index++], other[source_index++]);

    int &live = out[8];
    int first = live;
    live = 7;
    out[0] = first;
    out[2] = live;

    bool choose = out[3] != 0;
    out[4] = *(choose ? (out + 8) : (other + 9));
    out[5] = destination_index * 100 + source_index;

    const int &saved = other[source_index++];
    ++source_index;
    out[6] = saved;
    out[7] = source_index;
}
