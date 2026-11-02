struct Packet {
    unsigned tag;
    int samples[2];
    int2 pair;
};

using PacketAlias = Packet;
using FrozenPacket = const Packet;
using Triple = uint3;

__device__ Packet produce_packet(unsigned &counter, int seed) {
    ++counter;
    Packet result{counter, {seed, seed + 1}, {seed + 2, seed + 3}};
    return result;
}

__device__ int2 produce_pair(unsigned &counter, int seed) {
    ++counter;
    return make_int2(seed, seed + 1);
}

__global__ void direct_aggregate_copy(unsigned *output) {
    unsigned counter = 0u;
    Packet original{3u, {5, 7}, {11, 13}};
    Packet copied(original), following((original.samples[0] = 17, original));
    FrozenPacket frozen(copied);
    original.pair.x = 19;
    original.samples[1] = 23;
    original.tag = 29u;
    copied.samples[1] += 1;
    PacketAlias called(produce_packet(counter, 31)), called_copy(called);
    called.samples[0] = 41;
    int2 point{43, 47};
    int2 point_copy(point), changed((point.x = 53, point));
    const int2 frozen_point(point_copy);
    point_copy.y = 59;
    int2 from_call(produce_pair(counter, 61));
    Triple triple{67u, 71u, 73u};
    Triple triple_copy(triple);
    triple.y = 79u;
    output[0] = copied.tag;
    output[1] = unsigned(copied.samples[0]);
    output[2] = unsigned(copied.samples[1]);
    output[3] = unsigned(frozen.samples[1]);
    output[4] = unsigned(copied.pair.x);
    output[5] = unsigned(frozen.pair.y);
    output[6] = unsigned(following.samples[0]);
    output[7] = unsigned(following.pair.x);
    output[8] = unsigned(original.samples[1]);
    output[9] = unsigned(original.pair.x);
    output[10] = called.tag;
    output[11] = unsigned(called_copy.samples[0]);
    output[12] = unsigned(called.samples[0]);
    output[13] = unsigned(called_copy.pair.y);
    output[14] = unsigned(point_copy.x);
    output[15] = unsigned(point_copy.y);
    output[16] = unsigned(changed.x);
    output[17] = unsigned(frozen_point.y);
    output[18] = unsigned(from_call.x);
    output[19] = unsigned(from_call.y);
    output[20] = counter;
    output[21] = triple_copy.x;
    output[22] = triple_copy.y;
    output[23] = triple.y;
}
