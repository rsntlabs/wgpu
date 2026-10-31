#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[64];

shared int signed_value;

shared float float_value;


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        signed_value = 0;
        float_value = 0.0;
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e15 = values[lane];
    local = uint((base + lane));
    uint _e19 = local;
    local_3 = uint(_e19);
    uint _e22 = local_3;
    _group_0_binding_0_cs[_e22] = _e15;
    if ((lane == 0u)) {
        signed_value = -(7);
        float_value = 3.5;
        int _e32 = signed_value;
        local_1 = uint((base + 64u));
        uint _e40 = local_1;
        local_4 = uint(_e40);
        uint _e43 = local_4;
        _group_0_binding_0_cs[_e43] = uint((_e32 + 10));
        float _e45 = float_value;
        local_2 = uint((base + 65u));
        uint _e53 = local_2;
        local_5 = uint(_e53);
        uint _e56 = local_5;
        _group_0_binding_0_cs[_e56] = uint((_e45 * 2.0));
    }
}

