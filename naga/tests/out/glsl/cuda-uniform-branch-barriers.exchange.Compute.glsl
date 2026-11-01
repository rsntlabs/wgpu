#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_2 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_2_block_2Compute { type_2 _group_0_binding_2_cs; };

shared uint values[4];


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint transformed = 0u;
    uint local_1 = 0u;
    uint mode_1 = _group_0_binding_2_cs.value;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 4u);
    local = uint((base + lane));
    uint _e12 = local;
    uint _e15 = _group_0_binding_0_cs[_e12];
    values[lane] = _e15;
    if ((mode_1 != 0u)) {
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e21 = (lane + 1u);
        uint _e25 = values[(_e21 - 4u * (_e21 / 4u))];
        transformed = (_e25 + 10u);
    } else {
        memoryBarrierBuffer();
        memoryBarrierShared();
        barrier();
        uint _e30 = (lane + 2u);
        uint _e34 = values[(_e30 - 4u * (_e30 / 4u))];
        transformed = (_e34 + 20u);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e39 = transformed;
    values[lane] = _e39;
    uint _e42 = (blockIdx.x + mode_1);
    switch((_e42 - 3u * (_e42 / 3u))) {
        case 0u: {
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
            uint _e46 = values[lane];
            values[lane] = (_e46 + 1u);
            break;
        }
        case 1u: {
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
            uint _e50 = values[lane];
            values[lane] = (_e50 * 2u);
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
            uint _e54 = values[lane];
            values[lane] = (_e54 + 3u);
            break;
        }
        default: {
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
            uint _e58 = values[lane];
            values[lane] = (_e58 + 3u);
            break;
        }
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e62 = (lane + 3u);
    uint _e66 = values[(_e62 - 4u * (_e62 / 4u))];
    local_1 = uint((base + lane));
    uint _e70 = local_1;
    _group_0_binding_1_cs[_e70] = _e66;
}

