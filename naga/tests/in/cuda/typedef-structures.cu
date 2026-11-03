typedef struct {
    unsigned low, high;
} Pair, PairAlias;

typedef struct PacketTag {
    Pair pair;
    unsigned samples[2];
} Packet;

__device__ PairAlias rotated_pair(Pair value) {
    return PairAlias{value.high, value.low};
}

template<class Record>
__global__ void copy_records(Record *output, const Record *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index < count) output[index] = input[index];
}

template __global__ void copy_records<Pair>(Pair *, const Pair *, unsigned);
template __global__ void copy_records<Packet>(Packet *, const Packet *, unsigned);

__global__ void transform_records(Packet *output, const Packet *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    typedef struct {
        unsigned value;
    } Bias;
    Bias bias{index + 1u};
    Packet packet = input[index];
    packet.pair = rotated_pair(packet.pair);
    packet.samples[0] += bias.value;
    packet.samples[1] ^= 0xa5a55a5au;
    output[index] = packet;
}
