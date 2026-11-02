#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };

shared uint values[4];


uint adjusted_4_(uint value) {
    return (value + uint(4));
}

uint adjusted_8_(uint value_1) {
    return (value_1 + uint(8));
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint stride = 0u;
    uint local_1 = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 4u);
    local = uint((base + lane));
    uint _e9 = local;
    uint _e12 = _group_0_binding_1_cs[_e9];
    values[lane] = _e12;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    {
        stride = 2u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e29 = stride;
                stride = (_e29 >> 1u);
            }
            loop_init = false;
            uint _e17 = stride;
            if ((_e17 > 0u)) {
            } else {
                break;
            }
            uint _e20 = stride;
            if ((lane < _e20)) {
                uint _e22 = stride;
                uint _e25 = values[(lane + _e22)];
                uint _e27 = values[lane];
                values[lane] = (_e27 + _e25);
            }
            memoryBarrierBuffer();
            memoryBarrierShared();
            barrier();
        }
    }
    uint _e34 = values[0];
    uint _e35 = adjusted_4_(_e34);
    local_1 = uint((base + lane));
    uint _e39 = local_1;
    _group_0_binding_0_cs[_e39] = _e35;
}

