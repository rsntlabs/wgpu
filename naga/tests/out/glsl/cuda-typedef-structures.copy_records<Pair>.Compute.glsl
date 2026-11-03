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
layout(std430) buffer type_5_block_0Compute { Pair_cuda_record_0_ _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_5_block_1Compute { Pair_cuda_record_0_ _group_0_binding_1_cs[]; };

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
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    Pair_cuda_record_0_ local_2 = Pair_cuda_record_0_(0u, 0u);
    uint local_3 = 0u;
    Pair_cuda_record_0_ local_4 = Pair_cuda_record_0_(0u, 0u);
    uint local_5 = 0u;
    uint count_3 = _group_0_binding_2_cs.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index < count_3)) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        Pair_cuda_record_0_ _e17 = _group_0_binding_1_cs[_e14];
        local_4 = _e17;
        Pair_cuda_record_0_ _e19 = local_4;
        local_2 = _e19;
        Pair_cuda_record_0_ _e21 = local_2;
        local = index;
        uint _e23 = local;
        local_5 = _e23;
        uint _e25 = local_5;
        _group_0_binding_0_cs[_e25] = _e21;
    }
}

