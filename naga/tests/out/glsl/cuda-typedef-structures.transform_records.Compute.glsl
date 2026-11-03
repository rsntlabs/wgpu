#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct Pair_cuda_record_0_ {
    uint low;
    uint high;
};
struct PacketTag_cuda_record_1_ {
    Pair_cuda_record_0_ pair;
    uint samples[2];
};
struct type_3 {
    uint value;
};
struct Bias_cuda_record_2_ {
    uint value;
};
layout(std430) buffer type_2_block_0Compute { PacketTag_cuda_record_1_ _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { PacketTag_cuda_record_1_ _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


Pair_cuda_record_0_ rotated_pair(Pair_cuda_record_0_ value) {
    Pair_cuda_record_0_ value_1 = Pair_cuda_record_0_(0u, 0u);
    Pair_cuda_record_0_ local_14 = Pair_cuda_record_0_(0u, 0u);
    value_1 = value;
    uint _e4 = value_1.high;
    local_14.low = _e4;
    uint _e8 = value_1.low;
    local_14.high = _e8;
    Pair_cuda_record_0_ _e9 = local_14;
    return _e9;
}

void main() {
    uvec3 blockIdx_2 = gl_WorkGroupID;
    uvec3 threadIdx_2 = gl_LocalInvocationID;
    Bias_cuda_record_2_ bias = Bias_cuda_record_2_(0u);
    PacketTag_cuda_record_1_ packet = PacketTag_cuda_record_1_(Pair_cuda_record_0_(0u, 0u), uint[2](0u, 0u));
    PacketTag_cuda_record_1_ local_12 = PacketTag_cuda_record_1_(Pair_cuda_record_0_(0u, 0u), uint[2](0u, 0u));
    PacketTag_cuda_record_1_ local_13 = PacketTag_cuda_record_1_(Pair_cuda_record_0_(0u, 0u), uint[2](0u, 0u));
    uint count_3 = _group_0_binding_2_cs.value;
    uint index = ((blockIdx_2.x * 4u) + threadIdx_2.x);
    if ((index >= count_3)) {
        return;
    }
    bias.value = (index + 1u);
    PacketTag_cuda_record_1_ _e17 = _group_0_binding_1_cs[index];
    local_13 = _e17;
    PacketTag_cuda_record_1_ _e19 = local_13;
    local_12 = _e19;
    PacketTag_cuda_record_1_ _e21 = local_12;
    packet = _e21;
    Pair_cuda_record_0_ _e24 = packet.pair;
    Pair_cuda_record_0_ _e25 = rotated_pair(_e24);
    packet.pair = _e25;
    uint _e28 = bias.value;
    uint _e32 = packet.samples[0];
    packet.samples[0] = (_e32 + _e28);
    uint _e37 = packet.samples[1];
    packet.samples[1] = (_e37 ^ 2779077210u);
    PacketTag_cuda_record_1_ _e40 = packet;
    _group_0_binding_0_cs[index] = _e40;
}

