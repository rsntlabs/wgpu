#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_2 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_2_block_1Compute { type_2 _group_0_binding_1_cs; };

layout(std140) uniform type_2_block_2Compute { type_2 _group_0_binding_2_cs; };


void synchronize() {
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    return;
}

void rounds(uint count, uint mode) {
    uint iteration = 0u;
    {
        iteration = 0u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e8 = iteration;
                iteration = (_e8 + uint(1));
            }
            loop_init = false;
            uint _e4 = iteration;
            if ((_e4 < count)) {
            } else {
                break;
            }
            if ((mode != 0u)) {
                memoryBarrierBuffer();
                memoryBarrierShared();
                barrier();
            } else {
                memoryBarrierBuffer();
                memoryBarrierShared();
                barrier();
            }
        }
        return;
    }
}

uint finish(uint lane) {
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    if (((lane & 1u) != 0u)) {
        return (lane + 100u);
    }
    return (lane + 200u);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint mode_2 = _group_0_binding_1_cs.value;
    uint count_2 = _group_0_binding_2_cs.value;
    uint lane_1 = threadIdx.x;
    uint base = (blockIdx.x * 12u);
    local = uint((base + lane_1));
    uint _e21 = local;
    _group_0_binding_0_cs[_e21] = (((blockIdx.x * 10u) + lane_1) + 1u);
    synchronize();
    uint _e25 = (lane_1 + 1u);
    local_1 = uint((base + (_e25 - 4u * (_e25 / 4u))));
    uint _e31 = local_1;
    uint next = _group_0_binding_0_cs[_e31];
    synchronize();
    local_2 = uint((base + lane_1));
    uint _e39 = local_2;
    _group_0_binding_0_cs[_e39] = (next + 10u);
    rounds(count_2, mode_2);
    uint _e42 = (lane_1 + 1u);
    local_4 = uint((base + (_e42 - 4u * (_e42 / 4u))));
    uint _e48 = local_4;
    uint _e50 = _group_0_binding_0_cs[_e48];
    local_3 = uint(((base + 4u) + lane_1));
    uint _e56 = local_3;
    _group_0_binding_0_cs[_e56] = _e50;
    uint _e58 = finish(lane_1);
    local_5 = uint(((base + 8u) + lane_1));
    uint _e64 = local_5;
    _group_0_binding_0_cs[_e64] = _e58;
    synchronize();
}

